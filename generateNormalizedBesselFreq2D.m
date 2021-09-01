function [normalizedCollimatorBesselFreq2D] = generateNormalizedBesselFreq2D(xProjDimen, zProjDimen, xProjWidth, zProjWidth, distanceSource2Collimator,backOfColToProjPlane, lenOfColHole, radiusOfColHole )
%���ɱ�����������ʽ��׼ֱ��������Ӧ������Ƶ����ɢͼ

    deltaFreqCol=1/xProjWidth/xProjDimen;   

    freqCol = zeros(xProjDimen,zProjDimen); %Ƶ��ͼ���У�ÿ�����ص��Ӧ����ʵ����Ƶ���ֵ����ά���飬�������xProjDimen * zProjDimen����
    
    for i=1:xProjDimen
        for k=1:zProjDimen
            freqCol(i,k) = sqrt( (i-64-0.001)^2+(k-64-0.001)^2  ) * deltaFreqCol; 
        end
    end

    alphaEvery = 1+ (distanceSource2Collimator + backOfColToProjPlane)/lenOfColHole;

    collimatorBesselFreq2D = ( besselj(1, 2 * pi * alphaEvery * radiusOfColHole * freqCol)./( pi * alphaEvery * radiusOfColHole * freqCol) ).^2;
    
    %��һ��
    normalizationFactorFreqCol = sum(sum( abs(ifft2(collimatorBesselFreq2D))  ));
    
    normalizedCollimatorBesselFreq2D = collimatorBesselFreq2D/normalizationFactorFreqCol;
end

