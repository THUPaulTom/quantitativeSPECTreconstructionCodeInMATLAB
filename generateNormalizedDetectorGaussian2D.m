function [normalizedDetResponse] = generateNormalizedDetectorGaussian2D(xProjDimen, zProjDimen, xProjWidth, zProjWidth,detectFWHM )
%���ɹ�һ����̽�������зֱ�����ɵĿռ伸�ηֲ�

detResponse = zeros(xProjDimen,zProjDimen);%̽�������зֱ�����Ӧ������ԭ����ͼ������
    sigma = detectFWHM / 2.355;
    for i=1:xProjDimen
        for k=1:zProjDimen
            detResponse(i,k) = ( 1/(2 * pi * sigma^2) ) * exp( -0.5 *(  ((i-64)* xProjWidth )^2+((k-64)*zProjWidth )^2 )/sigma^2  ) * xProjWidth * zProjWidth;
        end
    end
    
    %��һ��
    normalizedDetResponse = detResponse/sum(sum(detResponse));
    
end

