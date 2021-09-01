%������ڣ���ʼ����ͶӰ
clc;
clear;


%------------------------------------1. �ֶ�����ǰͶӰ���������ڳ�ʼ��ͶӰ�����е�ȫ�ֱ��� ----------------------------------------
forwardProjectionParameterStruct = defineForwardProjectionParameterStruct();
%-------------------------------------------------------------------------------------------------------------------------------


%------------------------------------2. �����ؽ�����ȫ�ֱ��� ---------------------------------------------------------------------
outputProjectionFileName = forwardProjectionParameterStruct.outputProjectionFileName;
xProjDimen         = forwardProjectionParameterStruct.xProjectionDimension;
zProjDimen         = forwardProjectionParameterStruct.zProjectionDimension;
xProjWidth         = forwardProjectionParameterStruct.xProjectionWidth;
zProjWidth         = forwardProjectionParameterStruct.zProjectionWidth;
numOfFrame         = forwardProjectionParameterStruct.numberOfProjectionView;
rotAngleRange      = forwardProjectionParameterStruct.rotationAngleRange;
rotStartAngle      = forwardProjectionParameterStruct.rotationStartAngle;

cenOfRotToFrontOfCol = forwardProjectionParameterStruct.centerOfRotationToFrontOfCollimator;

boolComplexOrbitMode = forwardProjectionParameterStruct.boolComplexOrbitMode;
orbitParameter = zeros(numOfFrame,2);

if boolComplexOrbitMode == true
    orbitParameter = forwardProjectionParameterStruct.complexOrbitParameter;
else
    rotAngleStep   = rotAngleRange/numOfFrame;
    for n=1:numOfFrame
        orbitParameter(n,1) = rotStartAngle + (n-1) * rotAngleStep;
        orbitParameter(n,2) = cenOfRotToFrontOfCol;
    end
end

inputReconImageFileName = forwardProjectionParameterStruct.inputReconImageFileName;

xImageDimen = forwardProjectionParameterStruct.xImageDimension;
yImageDimen = forwardProjectionParameterStruct.yImageDimension;
zImageDimen = forwardProjectionParameterStruct.zImageDimension;
xImageWidth = forwardProjectionParameterStruct.xImageWidth;
yImageWidth = forwardProjectionParameterStruct.yImageWidth;
zImageWidth = forwardProjectionParameterStruct.zImageWidth;

forwardProjectionPhysicsMode = forwardProjectionParameterStruct.forwardProjectionPhysicsMode;

attenuationMapFileName = forwardProjectionParameterStruct.attenuationMapFileName;

backOfColToProjPlane   = forwardProjectionParameterStruct.distanceCollimatorBackToProjectionPlane;
lenOfColHole           = forwardProjectionParameterStruct.collimatorHoleLength;
radiusOfColHole        = 0.5 * forwardProjectionParameterStruct.collimatorHoleDiameter;
detectFWHM             = forwardProjectionParameterStruct.detectorIntrinsicResolution;
%--------------------------------------------------------------------------------------------------------------------------



%------------------------------------------- 3. �Ӵ��̶�����Ҫ����ǰͶӰ���ؽ�ͼ��--------------------------------------------

%���Դ��ؽ�ͼ���ļ�
inputReconImageFileID = fopen(inputReconImageFileName,'rb');
%����򿪳ɹ����������ȵķ�ʽ��ȡ
if inputReconImageFileID > 0 
    reconImageColumnVector = fread(inputReconImageFileID,inf,'float32');
    inputReconImage = zeros(xImageDimen,yImageDimen,zImageDimen);
    
    for k=1:zImageDimen
        for j=1:yImageDimen 
            for i=1:xImageDimen 
                inputReconImage(i,j,k) = reconImageColumnVector( (k-1)*yImageDimen*xImageDimen + (j-1)*xImageDimen + i   );
            end
        end
    end

    fclose(inputReconImageFileID);

%��������ڴ��ļ������ߴ��ļ����ɹ����򱨴��˳�
else
    error('����ǰͶӰ���ؽ�ͼ���޷��Ӵ����ж�ȡ�����飡����');
end

%--------------------------------------------------------------------------------------------------------------------------


%------------------------------------------ 4. ȷ��ǰͶӰ��Ҫ���ǵ�����ЧӦ -------------------------------------------------
% ���ȸ���Ԥ�ȵĶ��壬ȷ���� ˥����׼ֱ����ӦУ�� ��ǰͶӰ���Ƿ���Ҫ����
switch forwardProjectionPhysicsMode
    case 1
        boolAttModeFwd = false;
        boolColGeoModeFwd = false;
    case 2
        boolAttModeFwd = true;
        boolColGeoModeFwd = false;
    case 3
        boolAttModeFwd = false;
        boolColGeoModeFwd = true;
    case 4
        boolAttModeFwd = true;
        boolColGeoModeFwd = true;
end

%--------------------------------------------------------------------------------------------------------------------------


%------------------------------------------ 5. �Ӵ����ж�ȡ�Ѿ���׼�õ�˥��ͼ -----------------------------------------------
attMap = zeros(xImageDimen,yImageDimen,zImageDimen);
if boolAttModeFwd == true
    attenuationMapFileID = fopen(attenuationMapFileName,'rb');
    if attenuationMapFileID > 0
        attMap = readAttenuationMapFromDisk(attenuationMapFileName,xImageDimen,yImageDimen,zImageDimen);
        fclose(attenuationMapFileID);
    else
        error('����ǰͶӰ��˥��ͼ�޷��Ӵ����ж�ȡ�����飡����');
    end
end

%--------------------------------------------------------------------------------------------------------------------------



%------------------------------------------------ 6. �����нǶȽ���ǰͶӰ ---------------------------------------------------
projection = zeros(zProjDimen,xProjDimen,numOfFrame);


for i=1:numOfFrame
    projection(:,:,i) = forwardProjection (inputReconImage, orbitParameter( i ,1 ), ...
                       boolColGeoModeFwd, orbitParameter( i,2), lenOfColHole ,backOfColToProjPlane, radiusOfColHole, ...
                       boolAttModeFwd, attMap, detectFWHM, ...
                       xImageDimen, yImageDimen, zImageDimen, xProjDimen, zProjDimen, ...
                       xImageWidth, yImageWidth, zImageWidth, xProjWidth, zProjWidth);
                   
   fprintf('Forward projection, %d.\n', i); %��ʾ�Ѿ��Ե� i �ǶȽ�����ǰͶӰ
end

%--------------------------------------------------------------------------------------------------------------------------

%------------------------------------------       7. ͶӰͼ���ɳ����������     ------------------------------------------
projectionWithPossionNoise = random('poisson',projection);
%--------------------------------------------------------------------------------------------------------------------------

%------------------------------------------ 8. ��ͶӰ�ļ��������ȴ洢��ʽ���浽���� ------------------------------------------
% saveProjectionFileToDisk(outputProjectionFileName,projectionWithPossionNoise,xProjDimen,zProjDimen,numOfFrame,forwardProjectionPhysicsMode);
%--------------------------------------------------------------------------------------------------------------------------

%------------------------------------------ 8. ��ͶӰ�ļ���DICOM��ʽ���浽���� ------------------------------------------
projectionInfo = dicominfo('heart128.dcm');
handles.reconParameterStruct.projectionInfo = projectionInfo;
projectionWithPossionNoise4D = zeros(xProjDimen,zProjDimen,1,numOfFrame*2);
for i=1:xProjDimen
    for k=1:zProjDimen
        for m=1
            for n=1:numOfFrame
                projectionWithPossionNoise4D(i,k,m,n) = projectionWithPossionNoise(i,k,n);
            end
        end
    end
end
u16_projectionWithPossionNoise4D = uint16(projectionWithPossionNoise4D);
    
projectionInfo.SeriesDescription = outputProjectionFileName;
dicomwrite(u16_projectionWithPossionNoise4D,strcat(outputProjectionFileName,'.dcm'), 'CreateMode','Copy',projectionInfo);

%--------------------------------------------------------------------------------------------------------------------------

               
