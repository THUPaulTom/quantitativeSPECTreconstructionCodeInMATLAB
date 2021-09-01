function [matrixAfterShift] = shiftMatrixXby1Yby1(matrixBeforeShift,xImageDimen,direction)
    %只考虑偶数维情况
    if direction == 'positiveDirection'
        xImageDimenMinus1 = xImageDimen-1;

        matrixAfterShift(1,1) = matrixBeforeShift(xImageDimen,xImageDimen);
        matrixAfterShift(2:xImageDimen,1) = matrixBeforeShift(1:xImageDimenMinus1,xImageDimen);
        matrixAfterShift(1,2:xImageDimen) = matrixBeforeShift(xImageDimen,1:xImageDimenMinus1);

        matrixAfterShift(2:xImageDimen,2:xImageDimen) = matrixBeforeShift(1:xImageDimenMinus1,1:xImageDimenMinus1);
    end
    
    if direction == 'negativeDirection'
        xImageDimenMinus1 = xImageDimen-1;

        matrixAfterShift(xImageDimen,xImageDimen) = matrixBeforeShift(1,1);
        matrixAfterShift(1:xImageDimenMinus1,xImageDimen) = matrixBeforeShift(2:xImageDimen,1);
        matrixAfterShift(xImageDimen,1:xImageDimenMinus1) = matrixBeforeShift(1,2:xImageDimen);

        matrixAfterShift(1:xImageDimenMinus1,1:xImageDimenMinus1) = matrixBeforeShift(2:xImageDimen,2:xImageDimen);
    end
    

end

