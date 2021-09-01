function [subsetCell] = divideProjectionToSubsets(numOfFrame, numberOfSubsets,numOfFrameInOneSubset)
% �Ӽ����֣����������֡�����ֶ�������Ӽ������Զ�����OSEM�������Ӽ�����Ԫ������ʽ���
% Ԫ���ڹ��� numberOfSubsets �����飬ÿ�������� numOfFrameInOneSubset ��Ԫ�أ�ÿ��Ԫ�ش���ÿһ֡��ԭʼͶӰ����֡��������к�

    if numOfFrame == numberOfSubsets * numOfFrameInOneSubset
        subsetCell = cell(numberOfSubsets,1);
        indexInProjection = zeros(1,numOfFrameInOneSubset);
        for iSubset=1:numberOfSubsets
            subsetCell{ iSubset } = zeros(1,numOfFrameInOneSubset);
            for p = 1:numOfFrameInOneSubset
                indexInProjection(1,p) = (p - 1) * numberOfSubsets + iSubset;
            end
            subsetCell{ iSubset } = indexInProjection;
        end
    else
        error('Error occurred.');
    end
    
end

