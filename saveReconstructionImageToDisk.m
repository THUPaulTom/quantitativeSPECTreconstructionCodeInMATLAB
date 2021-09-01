function [] = saveReconstructionImageToDisk(reconImageFileName,reconImage, xImageDimen, yImageDimen, zImageDimen)
    reconImageFileID = fopen( reconImageFileName , 'wb');

    reconImage1D = zeros( xImageDimen * yImageDimen * zImageDimen, 1 );
    for k = 1:zImageDimen
        for j = 1:yImageDimen
            for i = 1:xImageDimen
                reconImage1D( (k-1) * xImageDimen * yImageDimen + (j-1) * xImageDimen +i ,1 ) = reconImage(i,j,k);
            end
        end
    end

    fwrite(reconImageFileID,reconImage1D,'float32');
    fclose(reconImageFileID);
end

