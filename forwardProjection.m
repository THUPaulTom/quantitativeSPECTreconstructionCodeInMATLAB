function [projection] = forwardProjection (reconImage, theta, ...
   boolColGeoMode, cenOfRotToFrontOfCol, lenOfColHole ,backOfColToProjPlane, radiusOfColHole, ...
   boolAttMode, attMap, detectFWHM, ...
   xImageDimen, yImageDimen, zImageDimen, xProjDimen, zProjDimen, ...
   xImageWidth, yImageWidth, zImageWidth, xProjWidth, zProjWidth)
%ǰͶӰ��������Ե����Ƕȶ��ؽ�ͼ�����ͶӰ

%���������
% @�ؽ�ͼ���ʼֵ reconImage��������ά��������ݸ�ʽ(:,:,:)
% @ͶӰ�Ƕ� theta������תͼ���˥��ͼ���˽Ƕȣ�Ȼ�����ͶӰ
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
% @˥��ͼ attMap��������ά��������ݸ�ʽ(:,:,)���Ѿ���SEPCTͼ����׼

% @����̽�������зֱ��ʵ�Ӱ�죬̽�������зֱ��� detectFWHM����λ mm

% @ͼ��ά�� xImageDimen,yImageDimen,zImageDimen
% @ͶӰά�� xProjDimen, zProjDimen

% @ͼ��������ά��� xImageWidth, yImageWidth, zImageWidth,����׼ֱ��������Ӧ��ģ
% @ͶӰ���ض�ά��� xProjWidth, zprojWidth������̽�������зֱ��ʽ�ģ

%���������
% @ͶӰ projection�����ö�ά��������ݸ�ʽ(:,:)


    % ���ȶ��ؽ�ͼ����z�����˳ʱ����ת������Ϊ theta��ͼ��ά�Ȳ���

    rotReconImage = zeros(xImageDimen, yImageDimen, zImageDimen);

    for k=1:zImageDimen
        rotReconImage(:, :, k)  = imrotate( squeeze(reconImage(:, :, k)),theta, 'bilinear','crop' );
    end
    
    %�����Ҫ����˥������ô˥��ͼҲ��Ҫ������ת
    if boolAttMode == true
        rotAttMap = zeros(xImageDimen, yImageDimen, zImageDimen);
        for k=1:zImageDimen
            rotAttMap(:, :, k)  = imrotate( squeeze(attMap(:, :, k)),theta, 'bilinear','crop' );
        end
    end

    % ��ת���֮�󣬽���ͶӰ��������ת�Ĳ�����ʹ��̽����������Զ����0�ȵ�λ�ã���ʱͶӰ�ͱ����y�������ص��ۼӲ���
    % ��ģ��ʱ���ѡ����׼ֱ���ļ�����Ӧ�����������ڲ�˥����Ӱ�죬����һ��Ĭ�Ͽ���̽�����Ĺ��зֱ���Ӱ�죬���ǰ����ֱ�����������bool���͵Ŀ��أ�����������������

    
    %���ò�������ϵ��LPH+���ؽ�ͼ������ϵi,j,k�Ͳ�������ϵ������ƽ�У�����y���ѭ���ۼӱ����jָ���ѭ���ۼ�
    
    projectionWithoutDetResolution = zeros(xProjDimen, zProjDimen);%ͶӰͼ��,δ����̽�����ֱ��ʵ�Ӱ��֮ǰ
    
    %1. ǰͶӰ�Ȳ���˥��У����Ҳ����׼ֱ����ӦУ��
    if boolAttMode == false && boolColGeoMode == false
        for j=yImageDimen:-1:1
            for k=1:zImageDimen
                for i=1:xImageDimen
                    projectionWithoutDetResolution(k,i)=projectionWithoutDetResolution(k,i) + rotReconImage(i,j,zImageDimen-k+1);
                end
            end
        end
    end
    
    %2. ǰͶӰֻ��˥��У��
    if boolAttMode == true && boolColGeoMode == false
        attFactor2D = zeros(xProjDimen, zProjDimen);%�ۼ�˥��ϵ����ά���飬����y����һ��һ�㷢���仯����׼ֱ�������ɽ���Զ�ۼ�
        
        for j=yImageDimen:-1:1
            attFactor2D = attFactor2D + squeeze(rotAttMap(:,j,:)) *  0.5 *yImageWidth; %���ǵ������ص����ģ�������׼ֱ�������һ��˥��������yImageWidth��һ�롣
            for k=1:zImageDimen
                for i=1:xImageDimen
                    projectionWithoutDetResolution(k,i)=projectionWithoutDetResolution(k,i) + rotReconImage(i,j,zImageDimen-k+1)*exp(-attFactor2D(i,zImageDimen-k+1));
                end
            end
            attFactor2D = attFactor2D + squeeze(rotAttMap(:,j,:)) *  0.5 *yImageWidth;
        end
    end
    
    %3. ǰͶӰֻ��׼ֱ����ӦУ��
    %�Ȱ�ͶӰ��һ��2D FFT����ʱ��Ƶ������
    
    if boolAttMode == false && boolColGeoMode == true
        
        projectionEveryY = zeros(zImageDimen,xImageDimen);
        
        %��ͼ��y�����ÿһ�㣬��׼ֱ����Ӧ��������ͬ��������Ҫ��������
        %ȡͼ��y����ĵ�j�㣬��1����׼ֱ����Զ����yImageDimen��׼ֱ�����
        for j=yImageDimen:-1:1
            
            for  k=1:zImageDimen
                for i=1:xImageDimen
                    projectionEveryY(k,i)=rotReconImage(i,j,zImageDimen-k+1);
                end
            end
            
            freqProjectionEveryY = fft2(projectionEveryY);   %ת����Ƶ�򣬵�Ƶ������
            
            %��ʱ��Ϊ��ת���Ĵ���j=64��j=65��ķֽ�����
            distanceSource2CollimatorEveryY = cenOfRotToFrontOfCol + (64 -j + 0.5) * yImageWidth;  
            
            %����Բ�ο�׼ֱ��Ƶ����Ӧ��������Ƶ����Ӧ�����Ѿ���һ��
            freqCollimatorEveryY = generateNormalizedBesselFreq2D( xProjDimen, zProjDimen, xProjWidth, zProjWidth, distanceSource2CollimatorEveryY ,backOfColToProjPlane, lenOfColHole, radiusOfColHole );       
            
            shiftFreqCollimatorEveryY = fftshift(freqCollimatorEveryY);%��Ƶ������    
            freqProjectionEveryYFinal = freqProjectionEveryY.* shiftFreqCollimatorEveryY;%���            
            projectionWithoutDetResolution = projectionWithoutDetResolution + abs(ifft2(freqProjectionEveryYFinal));
        end
        
    end
    
    
    %4. ǰͶӰ����˥��У����Ҳ��׼ֱ����ӦУ���������ǵ�2������͵�3������Ľ��
    if boolAttMode == true && boolColGeoMode == true
        
        projectionEveryY = zeros(zImageDimen,xImageDimen);
        attFactor2D = zeros(xProjDimen, zProjDimen);%�ۼ�˥��ϵ����ά���飬����y����һ��һ�㷢���仯����׼ֱ�������ɽ���Զ�ۼ�
        
        %��ͼ��y�����ÿһ�㣬��׼ֱ����Ӧ��������ͬ��������Ҫ��������
        for j=yImageDimen:-1:1
            
            attFactor2D = attFactor2D + squeeze(rotAttMap(:,j,:)) *  0.5 *yImageWidth; %���ǵ������ص����ģ�������׼ֱ�������һ��˥��������yImageWidth��һ�롣
            for  k=1:zImageDimen
                for i=1:xImageDimen
                    projectionEveryY(k,i)= rotReconImage(i,j,zImageDimen-k+1)*exp(-attFactor2D(i,zImageDimen-k+1));
                end
            end
            attFactor2D = attFactor2D + squeeze(rotAttMap(:,j,:)) *  0.5 *yImageWidth;

            freqProjectionEveryY = fft2(projectionEveryY);   %ת����Ƶ��
            
            %��ʱ��Ϊ��ת���Ĵ���j=64��j=65��ķֽ�����
            distanceSource2CollimatorEveryY = cenOfRotToFrontOfCol + (64 -j + 0.5) * yImageWidth;  
            
            %��Ƶ����Ӧ�����Ѿ���һ��
            freqCollimatorEveryY = generateNormalizedBesselFreq2D( xProjDimen, zProjDimen, xProjWidth, zProjWidth, distanceSource2CollimatorEveryY ,backOfColToProjPlane, lenOfColHole, radiusOfColHole );         
     
            shiftFreqCollimatorEveryY = fftshift(freqCollimatorEveryY);
            freqProjectionEveryYFinal = freqProjectionEveryY.* shiftFreqCollimatorEveryY;
            projectionWithoutDetResolution = projectionWithoutDetResolution + abs((ifft2(freqProjectionEveryYFinal)));
            
        end
    end
    
    
    %�����̽�����Ĺ��зֱ��ʵ�Ӱ�죬���ϻ����if��֧�õ���ͶӰ���ǿ�����ʽ����2D fft��Ƶ�򣬴�ʱ��Ƶ�����ܣ���Ƶ������
    if boolColGeoMode == true
    
        freqProjectionWithoutDetResolution= fft2(projectionWithoutDetResolution);   %ת����Ƶ��

        %�˿�����Ӧ�����Ѿ���һ��
        detResponse = generateNormalizedDetectorGaussian2D(xProjDimen, zProjDimen, xProjWidth, zProjWidth,detectFWHM );
        freqDetector = fft2(detResponse);

        freqProjectionDetectorFinal = freqProjectionWithoutDetResolution .* freqDetector;
        projection = shiftMatrixXby1Yby1(abs(fftshift(ifft2(freqProjectionDetectorFinal))),xImageDimen,'positiveDirection');
    
    else
        
        projection = projectionWithoutDetResolution;
        
    end
    
end

