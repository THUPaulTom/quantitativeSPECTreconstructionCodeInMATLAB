
function [handles] = startSPECTreconstruction(handles)


    %------------------------------------1. ��ʼ���ؽ��������� ----------------------------------------------
    reconParameterStruct = handles.reconParameterStruct;
    %------------------------------------------------------------------------------------------------------


    %------------------------------------2. �����ؽ��������� ------------------------------------------------
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



    %------------------------------------------- 3. ��ʼ���ؽ�ͼ�� -------------------------------------------------------------
    initializationReconImage = ones(xImageDimen,yImageDimen,zImageDimen);
    %--------------------------------------------------------------------------------------------------------------------------



    %----------4. ����ȫ�ֱ��� projectionFileName ����ͶӰ�ļ����洢Ϊ��ά����(xProjDimen,zProjDimen,numOfFrame) ----------------
    if handles.reconParameterStruct.boolScatterCorrectionSwitch
        projection = handles.projectionMain - 0.5*handles.projectionScatter/(scatterHighEnergy - scatterLowEnergy)*(mainHighEnergy - mainLowEnergy);;
    else
        projection = handles.projectionMain;
    end
    %--------------------------------------------------------------------------------------------------------------------------



    %------------------------------------------- 5. �����Ӽ� -------------------------------------------------------------------
    numOfFrameInOneSubset = numOfFrame/numberOfSubsets;
    subsetCell = divideProjectionToSubsets( numOfFrame, numberOfSubsets, numOfFrameInOneSubset );

    %--------------------------------------------------------------------------------------------------------------------------



    %------------------------------------------- 6. ����˥��ͼ -----------------------------------------------------------------
    if handles.reconParameterStruct.boolAttenuationCorrectionSwitch
        attMap =  handles.attenuationMap;
    else
        attMap = zeros(xImageDimen,yImageDimen,zImageDimen);
    end

    %--------------------------------------------------------------------------------------------------------------------------


    %------------------------------------------- 7. ����OSEM���� --------------------------------------------------------------
    % ���ȸ���Ԥ�ȵĶ��壬ȷ���� ˥����׼ֱ����ӦУ�� ��ǰͶӰ�ͷ�ͶӰ���Ƿ���Ҫ���ǣ�Ȼ���ٽ��е���
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
    
    
    %��ӽ������Ի�����ʾ���û��ؽ����̵Ľ���
    %�����waitbar()����
    progressRatio = 0;
    deltaProgressRatio = 1/(  (2*iterationTimes+1) * (numberOfSubsets*numOfFrameInOneSubset)  ); %ÿһ֡ǰͶӰ���߷�ͶӰ�����ĵ�ʱ�����
    progressWaitbar = waitbar(progressRatio,sprintf('����� %d %%',progressRatio),'Name','�ؽ�����', 'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
    setappdata(progressWaitbar,'canceling',0);
    
    
    %Ԥ�ȼ����һ������ͼ��
    normalizationFactorOfProjectionSubset = ones(xImageDimen,yImageDimen,zImageDimen,numberOfSubsets);
    
    for iSubset = 1:numberOfSubsets
        
        if getappdata(progressWaitbar,'canceling')
                break
        end
        
        indexArrayInProjection = subsetCell{iSubset};  
        %�����iSubset���Ӽ���Ӧ�Ĺ�һ��ϵ��ͼ��
        normalizationFactorOfProjectionSubset(:,:,:,iSubset) = calculateNormalizationImageOfProjectionSubset(orbitParameter( indexArrayInProjection ,1 ), ...
                       boolColGeoModeBwd, orbitParameter( indexArrayInProjection ,2 ), lenOfColHole ,backOfColToProjPlane, radiusOfColHole, ...
                       boolAttModeBwd, attMap, detectFWHM, ...
                       xImageDimen, yImageDimen, zImageDimen, xProjDimen, zProjDimen, ...
                       xImageWidth, yImageWidth, zImageWidth, xProjWidth, zProjWidth);
                   
       progressRatio = progressRatio + deltaProgressRatio*numOfFrameInOneSubset; 
       waitbar( progressRatio,progressWaitbar,sprintf('�ؽ������ %d %%',round(progressRatio*100)));
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

            for s = 1:numOfFrameInOneSubset  %�Ը��Ӽ�����ǰͶӰ
                
                indexInProjection = indexArrayInProjection(s);

                projectionEstimate(:,:,indexInProjection) = forwardProjection (reconImage, orbitParameter( indexInProjection ,1 ), ...
                       boolColGeoModeFwd, orbitParameter( indexInProjection,2), lenOfColHole ,backOfColToProjPlane, radiusOfColHole, ...
                       boolAttModeFwd, attMap, detectFWHM, ...
                       xImageDimen, yImageDimen, zImageDimen, xProjDimen, zProjDimen, ...
                       xImageWidth, yImageWidth, zImageWidth, xProjWidth, zProjWidth);

            end
            

            progressRatio = progressRatio + numOfFrameInOneSubset*deltaProgressRatio;   
            waitbar( progressRatio,progressWaitbar,sprintf('�ؽ������ %d %%',round(progressRatio*100)));
            
            for s = 1:numOfFrameInOneSubset  %�Ը��Ӽ�����ͶӰ��ֵ
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
            
            
            parfor s = 1:numOfFrameInOneSubset  %�Ը��Ӽ����з�ͶӰ
                indexInProjection = indexArrayInProjection(s);     
                correctionFactorImage = correctionFactorImage + backwardProjection( squeeze(projectionRatio(:,:,indexInProjection)), orbitParameter( indexInProjection ,1 ), ...
                       boolColGeoModeBwd, orbitParameter( indexInProjection,2), lenOfColHole ,backOfColToProjPlane, radiusOfColHole, ...
                       boolAttModeBwd, attMap, detectFWHM, ...
                       xImageDimen, yImageDimen, zImageDimen, xProjDimen, zProjDimen, ...
                       xImageWidth, yImageWidth, zImageWidth, xProjWidth, zProjWidth);
            end
            
            progressRatio = progressRatio + numOfFrameInOneSubset*deltaProgressRatio;
            waitbar( progressRatio,progressWaitbar,sprintf('�ؽ������ %d %%',round(progressRatio*100)));

            
            if getappdata(progressWaitbar,'canceling')
                break
            end           
            
            
            
            %�����Ѿ�������ɵĹ�һ������ͼ���������ؽ�ͼ��
            for k = 1:zImageDimen  %�Ը��Ӽ�����ͶӰ��ֵ
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


