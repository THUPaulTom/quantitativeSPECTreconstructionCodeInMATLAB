function [correctionFactorImage] = backwardProjection(projectionRatio, theta, ...
   boolColGeoMode, cenOfRotToFrontOfCol, lenOfColHole ,backOfColToProjPlane, radiusOfColHole, ...
   boolAttMode, attMap, detectFWHM, ...
   xImageDimen, yImageDimen, zImageDimen, xProjDimen, zProjDimen, ...
   xImageWidth, yImageWidth, zImageWidth, xProjWidth, zProjWidth)
%��ͶӰ��������Ե����Ƕȶ�ͶӰ��ֵ���з�ͶӰ

%���������
% @ʵ��ͶӰ�����ͶӰ�ı�ֵ��projectionRatio �����ö�ά��������ݸ�ʽ(:,:)
% @ͶӰ�Ƕ� theta����˳ʱ����ת�����У������ͼ���˥��ͼ theta �ǣ���ͶӰ��ֵ����0�ȣ�Ȼ����з�ͶӰ�������ʱ����תУ������ͼ�� theta �Ǽ���
   %�˽ǶȵĶ���ı�׼��Ҫ��DICOM�ı�׼һ�£��Ӷ��������
   %DICOM��������ϵ�ı�׼�ǣ��������ԣ��ӻ��ߵĽŹ۲죬���߱������·�Ϊ0�ȣ���ʱ��Ϊ����˳ʱ��Ϊ��
% @�Ƿ���׼ֱ���ļ�����Ӧ boolColGeoMode��trueΪ���ǣ�falseΪ������
% @�ɼ���DICOMͶӰ�ļ��е� Radial Position ������������Ϊ׼ֱ��ǰ���浽̽������ת���ĵľ���
  % ���������Ϊ�������������Ϊ cenOfRotToFrontOfCol
  % ��������������� ͼ���������ĵ�׼ֱ��ǰ����Ĵ�ֱ���� distanceSource2CollimatorEveryY����������������ص����ͼ����仯
% @׼ֱ���ĺ�ȣ���׼ֱ�׵ĳ��ȣ� lenOfColHole
% @׼ֱ������浽����ƽ��ľ��룬backOfColToProjPlane
% @׼ֱ���׵İ뾶 radiusOfColHole����Ϊ�������Σ���Ϊ����Բ�뾶
   % ����Բ�ν��ƿ������迼�������εĳ��򣬼������ε�һ���ض�����̽������һ���ض������ɵļнǣ��˽Ƕȿ���Ϊ����ֵ

% @�Ƿ���˥������ͶӰ�Ŀ��أ�boolAttMode��trueΪ���ǣ�falseΪ������
% @˥��ͼ attMap��������ά��������ݸ�ʽ(:,:,:)���Ѿ���SEPCTͼ����׼

% @����̽�������зֱ��ʵ�Ӱ�죬̽�������зֱ��� detectFWHM����λ mm

% @ͼ��ά�� xImageDimen,yImageDimen,zImageDimen
% @ͶӰά�� xProjDimen, zProjDimen

% @ͼ��������ά��� xImageWidth, yImageWidth, zImageWidth,����׼ֱ��������Ӧ��ģ
% @ͶӰ���ض�ά��� xProjWidth, zprojWidth������̽�������зֱ��ʽ�ģ

%���������
% @У������ͼ�� correctionFactorImage��������ά��������ݸ�ʽ(:,:,:)����Ҫע�������Ե��ǵ���ͶӰ�Ƕȣ��������е�ͶӰ�Ƕ�


    % ���ȶԼ����У������ͼ�� correctedRatioImage ��z�����˳ʱ����ת������Ϊ theta��
    rotCorrectionFactorImage = zeros(xImageDimen, yImageDimen, zImageDimen);
    
    %�����Ҫ����˥������ô˥��ͼҲ��Ҫ������ת
    if boolAttMode == true
        rotAttMap = zeros(xImageDimen, yImageDimen, zImageDimen);
        for k=1:zImageDimen
            rotAttMap(:, :, k)  = imrotate( squeeze(attMap(:, :, k)), theta, 'bilinear','crop' );
        end
    end

    % ��ת���֮�󣬽��з�ͶӰ��������ת�Ĳ�����ʹ��ͶӰ��ֵ������Զ����0�ȵ�λ�ã���ʱ��ͶӰ�ͱ����y�������صĸ�ֵ����
    % ��ģ��ʱ���ѡ����׼ֱ���ļ�����Ӧ�����������ڲ�˥����Ӱ�죬����һ��Ĭ�Ͽ���̽�����Ĺ��зֱ���Ӱ�죬���ǰ����ֱ�����������bool���͵Ŀ��أ�����������������    
    %���ò�������ϵ��LPH+���ؽ�ͼ������ϵi,j,k�Ͳ�������ϵ������ƽ�У�����y���ѭ�������jָ���ѭ��

    rotCorrFactorImageWithoutDetResolution = zeros(xImageDimen, yImageDimen, zImageDimen);
    
    %1. ��ͶӰ�Ȳ���˥��У����Ҳ����׼ֱ����ӦУ��
    if boolAttMode == false && boolColGeoMode == false
        for j=yImageDimen:-1:1 %����ͼ������ϵ��j=yImageDimen����׼ֱ�������һ��
            for  k=1:zImageDimen
                for i=1:xImageDimen
                    rotCorrFactorImageWithoutDetResolution(i,j,zImageDimen-k+1)=projectionRatio(k,i);
                end
            end
        end
    end
    
    %2. ��ͶӰֻ��˥��У��
    if boolAttMode == true && boolColGeoMode == false
        attFactor2D = zeros(xProjDimen, zProjDimen);%�ۼ�˥��ϵ����ά���飬����y����һ��һ�㷢���仯����׼ֱ�������ɽ���Զ�ۼ�
        
        for j=yImageDimen:-1:1
            attFactor2D = attFactor2D + squeeze(rotAttMap(:,j,:)) *  0.5 *yImageWidth; %���ǵ������ص����ģ�������׼ֱ�������һ��˥��������yImageWidth��һ�롣
            for k=1:zImageDimen
                for i=1:xImageDimen
                    rotCorrFactorImageWithoutDetResolution(i,j,zImageDimen-k+1)=projectionRatio(k,i)*exp(-attFactor2D(i,zImageDimen-k+1));
                end
            end
            attFactor2D = attFactor2D + squeeze(rotAttMap(:,j,:)) *  0.5 *yImageWidth;
        end
        
    end
    
    %3. ��ͶӰֻ��׼ֱ����ӦУ��
    %�Ȱ�ͶӰ��ֵ��һ��2D FFT����ʱ��Ƶ������
    %���׼ֱ��Ƶ����Ӧ�����������������ĵĽ���ʽ���г�����
    
    if boolAttMode == false && boolColGeoMode == true
        
        %��У������ͼ��y�����ÿһ�㣬��׼ֱ����Ӧ��������ͬ��������Ҫ��������
        for j=yImageDimen:-1:1
            
            %����˼�룺����ͶӰ��ֵ��y����ĵ�j�㣬��1����׼ֱ����Զ����yImageDimen��׼ֱ��������ٴν���ǰͶӰ�������õ���ͶӰ��ΪУ������ͼ��ĵ�j�㣡����������
            freqProjectionRatio = fft2(projectionRatio);   %ת����Ƶ�򣬵�Ƶ������
            
            %��ʱ��Ϊ��ת���Ĵ���j=64��j=65��ķֽ�����
            distanceSource2CollimatorEveryY = cenOfRotToFrontOfCol + (64 -j + 0.5) * yImageWidth;  
            
            %����Բ�ο�׼ֱ��Ƶ����Ӧ��������Ƶ����Ӧ�����Ѿ���һ��
            freqCollimatorEveryY = generateNormalizedBesselFreq2D( xProjDimen, zProjDimen, xProjWidth, zProjWidth, distanceSource2CollimatorEveryY ,backOfColToProjPlane, lenOfColHole, radiusOfColHole );       
            
            shiftFreqCollimatorEveryY = fftshift(freqCollimatorEveryY);%��Ƶ������    
            freqProjectionRatioEveryYFinal = freqProjectionRatio.* shiftFreqCollimatorEveryY;%���     
            
            projectionRatioEveryYFinal = abs(ifft2(freqProjectionRatioEveryYFinal));
            
            for  k=1:zImageDimen
                for i=1:xImageDimen
                    rotCorrFactorImageWithoutDetResolution(i,j,zImageDimen-k+1)=projectionRatioEveryYFinal(k,i); 
                end
            end
            
        end
        
    end
    
    
    %4. ǰͶӰ����˥��У����Ҳ��׼ֱ����ӦУ���������ǵ�2������͵�3������Ľ��
    if boolAttMode == true && boolColGeoMode == true
        
        attFactor2D = zeros(xProjDimen, zProjDimen);%�ۼ�˥��ϵ����ά���飬����y����һ��һ�㷢���仯����׼ֱ�������ɽ���Զ�ۼ�
        
        %��y�����ÿһ�㣬��׼ֱ����Ӧ��������ͬ��������Ҫ��������
        for j=yImageDimen:-1:1
           
            attFactor2D = attFactor2D + squeeze(rotAttMap(:,j,:)) * 0.5 * yImageWidth; %���ǵ������ص����ģ�������׼ֱ�������һ��˥��������yImageWidth��һ�롣
            projectionRatioEveryY = projectionRatio .* exp(-attFactor2D);
            attFactor2D = attFactor2D + squeeze(rotAttMap(:,j,:)) * 0.5 * yImageWidth;

            freqProjectionRatioEveryY = fft2(projectionRatioEveryY);   %ת����Ƶ��
            
            %��ʱ��Ϊ��ת���Ĵ���j=64��j=65��ķֽ�����
            distanceSource2CollimatorEveryY = cenOfRotToFrontOfCol + (64 -j + 0.5) * yImageWidth;  
            
            %��Ƶ����Ӧ�����Ѿ���һ��
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
    
    
    %�����̽�����Ĺ��зֱ��ʵ�Ӱ�죬���ϻ����if��֧�õ��ķ�ͶӰ���ǿ�����ʽ����ȡ��j�� 2D fft��Ƶ��
    %Ȼ����̽�������зֱ��ʵĸ�˹������Ƶ��ͼ�񣨰������и�˹���������г���,��2D fft���������һ��2D IFFT���ɵõ����յķ�ͶӰͼ��
    if boolColGeoMode == true
        %�˿�����Ӧ�����Ѿ���һ��
        detResponse = generateNormalizedDetectorGaussian2D(xProjDimen, zProjDimen, xProjWidth, zProjWidth,detectFWHM );
        freqDetector = fft2(detResponse);

        for j=1:yImageDimen
            freqRotCorrFactorImageWithoutDetEveryY = fft2( squeeze(rotCorrFactorImageWithoutDetResolution(:,j,:)));   %ת����Ƶ��
            freqRotCorrFactorImageWithoutDetEveryYFinal = freqRotCorrFactorImageWithoutDetEveryY .* freqDetector;
            rotCorrectionFactorImage(:,j,:) = shiftMatrixXby1Yby1(abs(fftshift(ifft2(freqRotCorrFactorImageWithoutDetEveryYFinal))),xImageDimen,'positiveDirection');%������Ҫ��fftshift��ԭ��������Ƶ��ͼ�񶼰���(-1)^(i+j)�Ŀ���ƽ�����ӣ���ô���֮��ͱ����(-1)^(2(i+j))�����1�����Կ����ƽ��������ʧ�ˣ��ʿ���һ�������ܺ����Ļ����ˣ���Ҫ�����ٴζԵ�����
        end
        
    else
        
        for j=1:yImageDimen
            rotCorrectionFactorImage = rotCorrFactorImageWithoutDetResolution;
        end
        
    end
    
    % ���У������ͼ��˳ʱ����ת theta �� �� 0 �ȵ�λ�ã����㲻ͬ��ͶӰ�õ��Ľ���ۼ�
    correctionFactorImage = zeros(xImageDimen, yImageDimen, zImageDimen);
    
    for k=1:zImageDimen
        correctionFactorImage(:, :, k)  = imrotate( squeeze(rotCorrectionFactorImage(:, :, k)), -theta, 'bilinear','crop' );
    end
    
    
end

