
function [handles] = startSPECTreconstruction(handles)


    %------------------------------------1. 初始化重建参数变量 ----------------------------------------------
    reconParameterStruct = handles.reconParameterStruct;
    %------------------------------------------------------------------------------------------------------


    %------------------------------------2. 定义重建参数变量 ------------------------------------------------
    xProjDimen         = reconParameterStruct.xProjectionDimension;
    zProjDimen         = reconParameterStruct.zProjectionDimension;
    xProjWidth         = reconParameterStruct.xProjectionWidth;
    zProjWidth         = reconParameterStruct.zProjectionWidth;
    numOfFrame         = reconParameterStruct.numberOfProjectionView;

    orbitParameter = reconParameterStruct.orbitParameter;

    xImageDimen = reconParameterStruct.xImageDimension;
    yImageDimen = reconParameterStruct.yImageDimension;
    zImageDimen = reconParameterStruct.zImageDimension;
    xImageWidth = reconParameterStruct.xImageWidth;
    yImageWidth = reconParameterStruct.yImageWidth;
    zImageWidth = reconParameterStruct.zImageWidth;

    iterationTimes  = reconParameterStruct.iterationTimes;
    numberOfSubsets = reconParameterStruct.numberOfSubsets;
    
    if isfield(reconParameterStruct,'scatterEnergyWindowLowLimit')
        scatterLowEnergy      = reconParameterStruct.scatterEnergyWindowLowLimit;
    end
    
    if isfield(reconParameterStruct,'scatterEnergyWindowHighLimit')
        scatterHighEnergy     = reconParameterStruct.scatterEnergyWindowHighLimit;
    end
    
    mainLowEnergy         = reconParameterStruct.mainEnergyWindowLowLimit;
    mainHighEnergy        = reconParameterStruct.mainEnergyWindoHighLimit;

    backOfColToProjPlane   = reconParameterStruct.distanceCollimatorBackToProjectionPlane;
    lenOfColHole           = reconParameterStruct.collimatorHoleLength;
    radiusOfColHole        = 0.5 * reconParameterStruct.collimatorHoleDiameter;
    detectFWHM             = reconParameterStruct.detectorIntrinsicResolution;
    %--------------------------------------------------------------------------------------------------------------------------



    %------------------------------------------- 3. 初始化重建图像 -------------------------------------------------------------
    initializationReconImage = ones(xImageDimen,yImageDimen,zImageDimen);
    %--------------------------------------------------------------------------------------------------------------------------



    %----------4. 依据全局变量 projectionFileName 读入投影文件，存储为三维数组(xProjDimen,zProjDimen,numOfFrame) ----------------
    if handles.reconParameterStruct.boolScatterCorrectionSwitch
        projection = handles.projectionMain - 0.5*handles.projectionScatter/(scatterHighEnergy - scatterLowEnergy)*(mainHighEnergy - mainLowEnergy);;
    else
        projection = handles.projectionMain;
    end
    %--------------------------------------------------------------------------------------------------------------------------



    %------------------------------------------- 5. 构建子集 -------------------------------------------------------------------
    numOfFrameInOneSubset = numOfFrame/numberOfSubsets;
    subsetCell = divideProjectionToSubsets( numOfFrame, numberOfSubsets, numOfFrameInOneSubset );

    %--------------------------------------------------------------------------------------------------------------------------



    %------------------------------------------- 6. 读入衰减图 -----------------------------------------------------------------
    if handles.reconParameterStruct.boolAttenuationCorrectionSwitch
        attMap =  handles.attenuationMap;
    else
        attMap = zeros(xImageDimen,yImageDimen,zImageDimen);
    end

    %--------------------------------------------------------------------------------------------------------------------------


    %------------------------------------------- 7. 进行OSEM迭代 --------------------------------------------------------------
    % 首先根据预先的定义，确定出 衰减与准直器响应校正 在前投影和反投影中是否需要考虑，然后再进行迭代
    if handles.reconParameterStruct.boolAttenuationCorrectionSwitch
        boolAttModeFwd = true;
        boolAttModeBwd = true;
    else
        boolAttModeFwd = false;
        boolAttModeBwd = false;
    end
    
    
    if handles.reconParameterStruct.boolCollimatorAndDetectorCorrectionSwitch
        boolColGeoModeFwd = true;
        boolColGeoModeBwd = true;
    else
        boolColGeoModeFwd = false;
        boolColGeoModeBwd = false;
    end
           

    projectionEstimate = zeros(zProjDimen,xProjDimen,numOfFrame);
    projectionRatio = ones(zProjDimen,xProjDimen,numOfFrame);
    reconImage = initializationReconImage;
    
    
    %添加进度条对话框，显示给用户重建过程的进度
    %拟采用waitbar()函数
    progressRatio = 0;
    deltaProgressRatio = 1/(  (2*iterationTimes+1) * (numberOfSubsets*numOfFrameInOneSubset)  ); %每一帧前投影或者反投影所消耗的时间比例
    progressWaitbar = waitbar(progressRatio,sprintf('已完成 %d %%',progressRatio),'Name','重建进度', 'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
    setappdata(progressWaitbar,'canceling',0);
    
    
    %预先计算归一化因子图像
    normalizationFactorOfProjectionSubset = ones(xImageDimen,yImageDimen,zImageDimen,numberOfSubsets);
    
    for iSubset = 1:numberOfSubsets
        
        if getappdata(progressWaitbar,'canceling')
                break
        end
        
        indexArrayInProjection = subsetCell{iSubset};  
        %计算第iSubset个子集对应的归一化系数图像
        normalizationFactorOfProjectionSubset(:,:,:,iSubset) = calculateNormalizationImageOfProjectionSubset(orbitParameter( indexArrayInProjection ,1 ), ...
                       boolColGeoModeBwd, orbitParameter( indexArrayInProjection ,2 ), lenOfColHole ,backOfColToProjPlane, radiusOfColHole, ...
                       boolAttModeBwd, attMap, detectFWHM, ...
                       xImageDimen, yImageDimen, zImageDimen, xProjDimen, zProjDimen, ...
                       xImageWidth, yImageWidth, zImageWidth, xProjWidth, zProjWidth);
                   
       progressRatio = progressRatio + deltaProgressRatio*numOfFrameInOneSubset; 
       waitbar( progressRatio,progressWaitbar,sprintf('重建已完成 %d %%',round(progressRatio*100)));
    end
    

    for iIteration = 1:iterationTimes
        
        if getappdata(progressWaitbar,'canceling')
                break
        end

        for iSubset = 1:numberOfSubsets
            
            if getappdata(progressWaitbar,'canceling')
                    break
            end
            
            indexArrayInProjection = subsetCell{iSubset};  

            for s = 1:numOfFrameInOneSubset  %对该子集进行前投影
                
                indexInProjection = indexArrayInProjection(s);

                projectionEstimate(:,:,indexInProjection) = forwardProjection (reconImage, orbitParameter( indexInProjection ,1 ), ...
                       boolColGeoModeFwd, orbitParameter( indexInProjection,2), lenOfColHole ,backOfColToProjPlane, radiusOfColHole, ...
                       boolAttModeFwd, attMap, detectFWHM, ...
                       xImageDimen, yImageDimen, zImageDimen, xProjDimen, zProjDimen, ...
                       xImageWidth, yImageWidth, zImageWidth, xProjWidth, zProjWidth);

            end
            

            progressRatio = progressRatio + numOfFrameInOneSubset*deltaProgressRatio;   
            waitbar( progressRatio,progressWaitbar,sprintf('重建已完成 %d %%',round(progressRatio*100)));
            
            for s = 1:numOfFrameInOneSubset  %对该子集计算投影比值
                indexInProjection = indexArrayInProjection(s);
                for i=1:xProjDimen
                    for k=1:zProjDimen
                        if projectionEstimate(i,k,indexInProjection) < 10^-6
                            projectionRatio(i,k,indexInProjection) = 1;
                        else
                            projectionRatio(i,k,indexInProjection) = projection(i,k,indexInProjection)/projectionEstimate(i,k,indexInProjection);
                        end
                    end
                end
            end

            correctionFactorImage = zeros(xImageDimen,yImageDimen,zImageDimen);
            
            
            parfor s = 1:numOfFrameInOneSubset  %对该子集进行反投影
                indexInProjection = indexArrayInProjection(s);     
                correctionFactorImage = correctionFactorImage + backwardProjection( squeeze(projectionRatio(:,:,indexInProjection)), orbitParameter( indexInProjection ,1 ), ...
                       boolColGeoModeBwd, orbitParameter( indexInProjection,2), lenOfColHole ,backOfColToProjPlane, radiusOfColHole, ...
                       boolAttModeBwd, attMap, detectFWHM, ...
                       xImageDimen, yImageDimen, zImageDimen, xProjDimen, zProjDimen, ...
                       xImageWidth, yImageWidth, zImageWidth, xProjWidth, zProjWidth);
            end
            
            progressRatio = progressRatio + numOfFrameInOneSubset*deltaProgressRatio;
            waitbar( progressRatio,progressWaitbar,sprintf('重建已完成 %d %%',round(progressRatio*100)));

            
            if getappdata(progressWaitbar,'canceling')
                break
            end           
            
            
            
            %利用已经计算完成的归一化因子图像来更新重建图像
            for k = 1:zImageDimen  %对该子集计算投影比值
                for i=1:xImageDimen
                    for j=1:yImageDimen
                        if normalizationFactorOfProjectionSubset(i,j,k,iSubset) > 10^-6
                            reconImage(i,j,k) = reconImage(i,j,k) * (  correctionFactorImage(i,j,k)/normalizationFactorOfProjectionSubset(i,j,k,iSubset) );
                        end
                    end
                end
            end
            
        end
        
    end
    
    
    %--------------------------------------------------------------------------------------------------------------------------
    if ~getappdata(progressWaitbar,'canceling')
        handles.reconImage = reconImage;
    else
        if isfield(handles,'reconImage')
            handles = rmfield(handles,'reconImage');
        end
    end
    
    delete(progressWaitbar);
    
end


