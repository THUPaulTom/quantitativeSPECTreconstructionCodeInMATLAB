function [attenuationMap] = readAttenuationMapFromDisk(attenuationMapFileName,xImageDimen,yImageDimen,zImageDimen)
% ´Ó´ÅÅÌÖÐ¶ÁÈëCTË¥¼õÍ¼

    attenuationMapFileID = fopen(attenuationMapFileName,'rb');
    [attenuationMapColumnVectorHU, nVoxels] = fread(attenuationMapFileID,inf,'float32');

    attenuationMapColumnVector = zeros(nVoxels,1);

    isNANflag = isnan(attenuationMapColumnVectorHU);

    for i=1:nVoxels
        
        if isNANflag(i)==0
            if attenuationMapColumnVectorHU(i) > 0
                attenuationMapColumnVector(i) = 0.15+1.14*10^-4*attenuationMapColumnVectorHU(i);
            else 
                attenuationMapColumnVector(i) = 0.15+1.52*10^-4*attenuationMapColumnVectorHU(i);
            end
            
            if attenuationMapColumnVector(i)<0
                attenuationMapColumnVector(i)=0;
            end
        end

        if isNANflag(i)==1
            attenuationMapColumnVector(i)=0;
        end
    end
    
    attenuationMap = zeros(xImageDimen,yImageDimen,zImageDimen);
    
    for k=1:zImageDimen
        for j=1:yImageDimen
            for i=1:xImageDimen
                attenuationMap(i,j,k) = 0.1 * attenuationMapColumnVector( (k-1)*xImageDimen*yImageDimen + (j-1)*xImageDimen +i   );
            end
        end
    end
    
    fclose(attenuationMapFileID);
end

