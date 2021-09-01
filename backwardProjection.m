function [correctionFactorImage] = backwardProjection(projectionRatio, theta, ...
   boolColGeoMode, cenOfRotToFrontOfCol, lenOfColHole ,backOfColToProjPlane, radiusOfColHole, ...
   boolAttMode, attMap, detectFWHM, ...
   xImageDimen, yImageDimen, zImageDimen, xProjDimen, zProjDimen, ...
   xImageWidth, yImageWidth, zImageWidth, xProjWidth, zProjWidth)
%反投影函数，针对单个角度对投影比值进行反投影

%输入参数：
% @实测投影与估计投影的比值，projectionRatio ，采用二维数组的数据格式(:,:)
% @投影角度 theta，先顺时针旋转假想的校正因子图像和衰减图 theta 角，将投影比值放在0度，然后进行反投影，最后逆时针旋转校正因子图像 theta 角即可
   %此角度的定义的标准需要与DICOM的标准一致，从而方便计算
   %DICOM人体坐标系的标准是，患者仰卧，从患者的脚观察，患者背部正下方为0度，逆时针为正，顺时针为负
% @是否考虑准直器的几何响应 boolColGeoMode，true为考虑，false为不考虑
% @采集的DICOM投影文件中的 Radial Position 参数，物理含义为准直器前端面到探测器旋转中心的距离
  % 这个参数作为输入参数，命名为 cenOfRotToFrontOfCol
  % 这个参数用来计算 图像像素中心到准直器前端面的垂直距离 distanceSource2CollimatorEveryY，这个距离随着像素点遍历图像而变化
% @准直器的厚度，即准直孔的长度， lenOfColHole
% @准直器后端面到成像平面的距离，backOfColToProjPlane
% @准直器孔的半径 radiusOfColHole，若为正六边形，则为内切圆半径
   % 采用圆形近似可以无需考虑六边形的朝向，即六边形的一个特定边与探测器的一个特定边所成的夹角，此角度可以为任意值

% @是否考虑衰减进行投影的开关，boolAttMode，true为考虑，false为不考虑
% @衰减图 attMap，采用三维数组的数据格式(:,:,:)，已经与SEPCT图像配准

% @考虑探测器固有分辨率的影响，探测器固有分辨率 detectFWHM，单位 mm

% @图像维度 xImageDimen,yImageDimen,zImageDimen
% @投影维度 xProjDimen, zProjDimen

% @图像像素三维宽度 xImageWidth, yImageWidth, zImageWidth,用于准直器几何响应建模
% @投影像素二维宽度 xProjWidth, zprojWidth，用于探测器固有分辨率建模

%输出参数：
% @校正因子图像 correctionFactorImage，采用三维数组的数据格式(:,:,:)，需要注意的是针对的是单个投影角度，不是所有的投影角度


    % 首先对假想的校正因子图像 correctedRatioImage 绕z轴进行顺时针旋转，度数为 theta，
    rotCorrectionFactorImage = zeros(xImageDimen, yImageDimen, zImageDimen);
    
    %如果需要考虑衰减，那么衰减图也需要进行旋转
    if boolAttMode == true
        rotAttMap = zeros(xImageDimen, yImageDimen, zImageDimen);
        for k=1:zImageDimen
            rotAttMap(:, :, k)  = imrotate( squeeze(attMap(:, :, k)), theta, 'bilinear','crop' );
        end
    end

    % 旋转完成之后，进行反投影，由于旋转的操作，使得投影比值好像永远处于0度的位置，此时反投影就变成了y方向像素的赋值操作
    % 建模的时候可选考虑准直器的几何响应，成像物体内部衰减的影响，但是一般默认考虑探测器的固有分辨率影响，针对前二项分别设置了两个bool类型的开关，组合起来有四种情况    
    %采用病人坐标系，LPH+，重建图像坐标系i,j,k和病人坐标系坐标轴平行，所以y轴的循环变成了j指标的循环

    rotCorrFactorImageWithoutDetResolution = zeros(xImageDimen, yImageDimen, zImageDimen);
    
    %1. 反投影既不做衰减校正，也不做准直器响应校正
    if boolAttMode == false && boolColGeoMode == false
        for j=yImageDimen:-1:1 %按照图像坐标系，j=yImageDimen是离准直器最近的一层
            for  k=1:zImageDimen
                for i=1:xImageDimen
                    rotCorrFactorImageWithoutDetResolution(i,j,zImageDimen-k+1)=projectionRatio(k,i);
                end
            end
        end
    end
    
    %2. 反投影只做衰减校正
    if boolAttMode == true && boolColGeoMode == false
        attFactor2D = zeros(xProjDimen, zProjDimen);%累计衰减系数二维数组，按照y方向一层一层发生变化，离准直器距离由近及远累加
        
        for j=yImageDimen:-1:1
            attFactor2D = attFactor2D + squeeze(rotAttMap(:,j,:)) *  0.5 *yImageWidth; %考虑的是像素的中心，所以离准直器最近的一层衰减距离是yImageWidth的一半。
            for k=1:zImageDimen
                for i=1:xImageDimen
                    rotCorrFactorImageWithoutDetResolution(i,j,zImageDimen-k+1)=projectionRatio(k,i)*exp(-attFactor2D(i,zImageDimen-k+1));
                end
            end
            attFactor2D = attFactor2D + squeeze(rotAttMap(:,j,:)) *  0.5 *yImageWidth;
        end
        
    end
    
    %3. 反投影只做准直器响应校正
    %先把投影比值做一个2D FFT，此时低频在四周
    %点乘准直器频域响应函数（按照已有论文的解析式进行抽样）
    
    if boolAttMode == false && boolColGeoMode == true
        
        %对校正因子图像y方向的每一层，其准直器响应函数都不同，所以需要单独计算
        for j=yImageDimen:-1:1
            
            %物理思想：假想投影比值在y方向的第j层，第1层离准直器最远，第yImageDimen离准直器最近，再次进行前投影操作，得到的投影作为校正因子图像的第j层！！！！！！
            freqProjectionRatio = fft2(projectionRatio);   %转换到频域，低频在四周
            
            %暂时认为旋转中心处于j=64到j=65层的分界线上
            distanceSource2CollimatorEveryY = cenOfRotToFrontOfCol + (64 -j + 0.5) * yImageWidth;  
            
            %构造圆形孔准直器频域响应函数，此频域响应函数已经归一化
            freqCollimatorEveryY = generateNormalizedBesselFreq2D( xProjDimen, zProjDimen, xProjWidth, zProjWidth, distanceSource2CollimatorEveryY ,backOfColToProjPlane, lenOfColHole, radiusOfColHole );       
            
            shiftFreqCollimatorEveryY = fftshift(freqCollimatorEveryY);%低频在四周    
            freqProjectionRatioEveryYFinal = freqProjectionRatio.* shiftFreqCollimatorEveryY;%卷积     
            
            projectionRatioEveryYFinal = abs(ifft2(freqProjectionRatioEveryYFinal));
            
            for  k=1:zImageDimen
                for i=1:xImageDimen
                    rotCorrFactorImageWithoutDetResolution(i,j,zImageDimen-k+1)=projectionRatioEveryYFinal(k,i); 
                end
            end
            
        end
        
    end
    
    
    %4. 前投影既做衰减校正，也做准直器响应校正，代码是第2种情况和第3种情况的结合
    if boolAttMode == true && boolColGeoMode == true
        
        attFactor2D = zeros(xProjDimen, zProjDimen);%累计衰减系数二维数组，按照y方向一层一层发生变化，离准直器距离由近及远累加
        
        %对y方向的每一层，其准直器响应函数都不同，所以需要单独计算
        for j=yImageDimen:-1:1
           
            attFactor2D = attFactor2D + squeeze(rotAttMap(:,j,:)) * 0.5 * yImageWidth; %考虑的是像素的中心，所以离准直器最近的一层衰减距离是yImageWidth的一半。
            projectionRatioEveryY = projectionRatio .* exp(-attFactor2D);
            attFactor2D = attFactor2D + squeeze(rotAttMap(:,j,:)) * 0.5 * yImageWidth;

            freqProjectionRatioEveryY = fft2(projectionRatioEveryY);   %转换到频域
            
            %暂时认为旋转中心处于j=64到j=65层的分界线上
            distanceSource2CollimatorEveryY = cenOfRotToFrontOfCol + (64 -j + 0.5) * yImageWidth;  
            
            %此频域响应函数已经归一化
            freqCollimatorEveryY = generateNormalizedBesselFreq2D( xProjDimen, zProjDimen, xProjWidth, zProjWidth, distanceSource2CollimatorEveryY ,backOfColToProjPlane, lenOfColHole, radiusOfColHole );         
     
            shiftFreqCollimatorEveryY = fftshift(freqCollimatorEveryY);
            freqProjectionRatioEveryYFinal = freqProjectionRatioEveryY.* shiftFreqCollimatorEveryY;
            
            projectionRatioEveryYFinal = abs(ifft2(freqProjectionRatioEveryYFinal));
            
            for k=1:zImageDimen
                for i=1:xImageDimen
                    rotCorrFactorImageWithoutDetResolution(i,j,zImageDimen-k+1)=projectionRatioEveryYFinal(k,i); 
                end
            end
            
            
        end
    end
    
    
    %最后考虑探测器的固有分辨率的影响，以上互斥的if分支得到的反投影都是空域形式，先取第j层 2D fft到频域
    %然后点乘探测器固有分辨率的高斯函数的频域图像（按照已有高斯空域函数进行抽样,做2D fft），最后做一个2D IFFT即可得到最终的反投影图像
    if boolColGeoMode == true
        %此空域响应函数已经归一化
        detResponse = generateNormalizedDetectorGaussian2D(xProjDimen, zProjDimen, xProjWidth, zProjWidth,detectFWHM );
        freqDetector = fft2(detResponse);

        for j=1:yImageDimen
            freqRotCorrFactorImageWithoutDetEveryY = fft2( squeeze(rotCorrFactorImageWithoutDetResolution(:,j,:)));   %转换到频域
            freqRotCorrFactorImageWithoutDetEveryYFinal = freqRotCorrFactorImageWithoutDetEveryY .* freqDetector;
            rotCorrectionFactorImage(:,j,:) = shiftMatrixXby1Yby1(abs(fftshift(ifft2(freqRotCorrFactorImageWithoutDetEveryYFinal))),xImageDimen,'positiveDirection');%这里需要做fftshift的原因是两幅频域图像都包含(-1)^(i+j)的空域平移因子，那么相乘之后就变成了(-1)^(2(i+j))恒等于1，所以空域的平移因子消失了，故空域一定是四周和中心互换了，需要将其再次对调过来
        end
        
    else
        
        for j=1:yImageDimen
            rotCorrectionFactorImage = rotCorrFactorImageWithoutDetResolution;
        end
        
    end
    
    % 最后将校正因子图像顺时针旋转 theta 度 到 0 度的位置，方便不同的投影得到的结果累加
    correctionFactorImage = zeros(xImageDimen, yImageDimen, zImageDimen);
    
    for k=1:zImageDimen
        correctionFactorImage(:, :, k)  = imrotate( squeeze(rotCorrectionFactorImage(:, :, k)), -theta, 'bilinear','crop' );
    end
    
    
end

