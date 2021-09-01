function [subsetCell] = divideProjectionToSubsets(numOfFrame, numberOfSubsets,numOfFrameInOneSubset)
% 子集划分，根据输入的帧数与手动定义的子集数，自动划分OSEM迭代的子集，以元胞的形式输出
% 元胞内共有 numberOfSubsets 个数组，每个数组有 numOfFrameInOneSubset 个元素，每个元素代表每一帧在原始投影序列帧里面的序列号

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

