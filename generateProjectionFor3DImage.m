%程序入口，开始进行投影
clc;
clear;


%------------------------------------1. 手动输入前投影参数，用于初始化投影过程中的全局变量 ----------------------------------------
forwardProjectionParameterStruct = defineForwardProjectionParameterStruct();
%-------------------------------------------------------------------------------------------------------------------------------


%------------------------------------2. 定义重建参数全局变量 ---------------------------------------------------------------------
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



%------------------------------------------- 3. 从磁盘读入需要进行前投影的重建图像--------------------------------------------

%尝试打开重建图像文件
inputReconImageFileID = fopen(inputReconImageFileName,'rb');
%如果打开成功，则按行优先的方式读取
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

%如果不存在此文件，或者打开文件不成功，则报错退出
else
    error('用于前投影的重建图像无法从磁盘中读取，请检查！！！');
end

%--------------------------------------------------------------------------------------------------------------------------


%------------------------------------------ 4. 确定前投影需要考虑的物理效应 -------------------------------------------------
% 首先根据预先的定义，确定出 衰减与准直器响应校正 在前投影中是否需要考虑
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


%------------------------------------------ 5. 从磁盘中读取已经配准好的衰减图 -----------------------------------------------
attMap = zeros(xImageDimen,yImageDimen,zImageDimen);
if boolAttModeFwd == true
    attenuationMapFileID = fopen(attenuationMapFileName,'rb');
    if attenuationMapFileID > 0
        attMap = readAttenuationMapFromDisk(attenuationMapFileName,xImageDimen,yImageDimen,zImageDimen);
        fclose(attenuationMapFileID);
    else
        error('用于前投影的衰减图无法从磁盘中读取，请检查！！！');
    end
end

%--------------------------------------------------------------------------------------------------------------------------



%------------------------------------------------ 6. 对所有角度进行前投影 ---------------------------------------------------
projection = zeros(zProjDimen,xProjDimen,numOfFrame);


for i=1:numOfFrame
    projection(:,:,i) = forwardProjection (inputReconImage, orbitParameter( i ,1 ), ...
                       boolColGeoModeFwd, orbitParameter( i,2), lenOfColHole ,backOfColToProjPlane, radiusOfColHole, ...
                       boolAttModeFwd, attMap, detectFWHM, ...
                       xImageDimen, yImageDimen, zImageDimen, xProjDimen, zProjDimen, ...
                       xImageWidth, yImageWidth, zImageWidth, xProjWidth, zProjWidth);
                   
   fprintf('Forward projection, %d.\n', i); %显示已经对第 i 角度进行了前投影
end

%--------------------------------------------------------------------------------------------------------------------------

%------------------------------------------       7. 投影图像泊松抽样添加噪声     ------------------------------------------
projectionWithPossionNoise = random('poisson',projection);
%--------------------------------------------------------------------------------------------------------------------------

%------------------------------------------ 8. 将投影文件以行优先存储方式保存到磁盘 ------------------------------------------
% saveProjectionFileToDisk(outputProjectionFileName,projectionWithPossionNoise,xProjDimen,zProjDimen,numOfFrame,forwardProjectionPhysicsMode);
%--------------------------------------------------------------------------------------------------------------------------

%------------------------------------------ 8. 将投影文件以DICOM格式保存到磁盘 ------------------------------------------
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

               
