function [normalizedDetResponse] = generateNormalizedDetectorGaussian2D(xProjDimen, zProjDimen, xProjWidth, zProjWidth,detectFWHM )
%生成归一化的探测器固有分辨率造成的空间几何分布

detResponse = zeros(xProjDimen,zProjDimen);%探测器固有分辨率响应函数，原点在图像中心
    sigma = detectFWHM / 2.355;
    for i=1:xProjDimen
        for k=1:zProjDimen
            detResponse(i,k) = ( 1/(2 * pi * sigma^2) ) * exp( -0.5 *(  ((i-64)* xProjWidth )^2+((k-64)*zProjWidth )^2 )/sigma^2  ) * xProjWidth * zProjWidth;
        end
    end
    
    %归一化
    normalizedDetResponse = detResponse/sum(sum(detResponse));
    
end

