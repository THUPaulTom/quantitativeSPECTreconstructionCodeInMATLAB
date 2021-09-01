function [normalizedCollimatorBesselFreq2D] = generateNormalizedBesselFreq2D(xProjDimen, zProjDimen, xProjWidth, zProjWidth, distanceSource2Collimator,backOfColToProjPlane, lenOfColHole, radiusOfColHole )
%生成贝塞尔函数形式的准直器几何响应函数的频域离散图

    deltaFreqCol=1/xProjWidth/xProjDimen;   

    freqCol = zeros(xProjDimen,zProjDimen); %频域图像中，每个像素点对应的真实物理频域的值，二维数组，这里抽样xProjDimen * zProjDimen个点
    
    for i=1:xProjDimen
        for k=1:zProjDimen
            freqCol(i,k) = sqrt( (i-64-0.001)^2+(k-64-0.001)^2  ) * deltaFreqCol; 
        end
    end

    alphaEvery = 1+ (distanceSource2Collimator + backOfColToProjPlane)/lenOfColHole;

    collimatorBesselFreq2D = ( besselj(1, 2 * pi * alphaEvery * radiusOfColHole * freqCol)./( pi * alphaEvery * radiusOfColHole * freqCol) ).^2;
    
    %归一化
    normalizationFactorFreqCol = sum(sum( abs(ifft2(collimatorBesselFreq2D))  ));
    
    normalizedCollimatorBesselFreq2D = collimatorBesselFreq2D/normalizationFactorFreqCol;
end

