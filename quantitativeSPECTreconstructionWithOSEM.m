function varargout = quantitativeSPECTreconstructionWithOSEM(varargin)
% QUANTITATIVESPECTRECONSTRUCTIONWITHOSEM MATLAB code for quantitativeSPECTreconstructionWithOSEM.fig
%      QUANTITATIVESPECTRECONSTRUCTIONWITHOSEM, by itself, creates a new QUANTITATIVESPECTRECONSTRUCTIONWITHOSEM or raises the existing
%      singleton*.
%
%      H = QUANTITATIVESPECTRECONSTRUCTIONWITHOSEM returns the handle to a new QUANTITATIVESPECTRECONSTRUCTIONWITHOSEM or the handle to
%      the existing singleton*.
%
%      QUANTITATIVESPECTRECONSTRUCTIONWITHOSEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QUANTITATIVESPECTRECONSTRUCTIONWITHOSEM.M with the given input arguments.
%
%      QUANTITATIVESPECTRECONSTRUCTIONWITHOSEM('Property','Value',...) creates a new QUANTITATIVESPECTRECONSTRUCTIONWITHOSEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before quantitativeSPECTreconstructionWithOSEM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to quantitativeSPECTreconstructionWithOSEM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help quantitativeSPECTreconstructionWithOSEM

% Last Modified by GUIDE v2.5 01-Sep-2021 20:07:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @quantitativeSPECTreconstructionWithOSEM_OpeningFcn, ...
                   'gui_OutputFcn',  @quantitativeSPECTreconstructionWithOSEM_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before quantitativeSPECTreconstructionWithOSEM is made visible.
function quantitativeSPECTreconstructionWithOSEM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to quantitativeSPECTreconstructionWithOSEM (see VARARGIN)

% Choose default command line output for quantitativeSPECTreconstructionWithOSEM
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes quantitativeSPECTreconstructionWithOSEM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = quantitativeSPECTreconstructionWithOSEM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function sliderOfProjTranView_Callback(hObject, eventdata, handles)
% hObject    handle to sliderOfProjTranView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    valueOfSliderToInt = round( get(hObject,'Value') );
    set(hObject,'Value', valueOfSliderToInt);
    
    axes(handles.axesOfProjTranView);axis tight;axis equal;
    imagesc(handles.projectionMain(:,:, valueOfSliderToInt ));
    set(handles.axesOfProjTranView,'xtick',[])
    set(handles.axesOfProjTranView,'ytick',[])
    
    guidata(hObject,handles);
    
   



% --- Executes during object creation, after setting all properties.
function sliderOfProjTranView_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderOfProjTranView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderOfProjCoraView_Callback(hObject, eventdata, handles)
% hObject    handle to sliderOfProjCoraView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    valueOfSliderToInt = round( get(hObject,'Value') );
    set(hObject,'Value', valueOfSliderToInt);

    axes(handles.axesOfProjCoraView);axis tight;axis equal;
    imagesc(flipud(squeeze(handles.projectionMain( valueOfSliderToInt ,:,:))'));
    set(handles.axesOfProjCoraView,'xtick',[])
    set(handles.axesOfProjCoraView,'ytick',[])
    
    guidata(hObject,handles);
    
    
    
        
    


% --- Executes during object creation, after setting all properties.
function sliderOfProjCoraView_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderOfProjCoraView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderOfProjSagiView_Callback(hObject, eventdata, handles)
% hObject    handle to sliderOfProjSagiView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    valueOfSliderToInt = round( get(hObject,'Value') );
    set(hObject,'Value', valueOfSliderToInt);
    
    axes(handles.axesOfProjSagiView);axis tight;axis equal;
    imagesc(squeeze(handles.projectionMain(:, valueOfSliderToInt ,:))');
    set(handles.axesOfProjSagiView,'xtick',[])
    set(handles.axesOfProjSagiView,'ytick',[])
    
    guidata(hObject,handles);
   



% --- Executes during object creation, after setting all properties.
function sliderOfProjSagiView_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderOfProjSagiView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderOfImageTranView_Callback(hObject, eventdata, handles)
    valueOfSliderToInt = round( get(hObject,'Value') );
    set(hObject,'Value', valueOfSliderToInt);
    
    axes(handles.axesOfImageTranView);axis tight;axis equal;
    imagesc(handles.reconImage(:,:, valueOfSliderToInt ));
    set(handles.axesOfImageTranView,'xtick',[]);
    set(handles.axesOfImageTranView,'ytick',[]);
    
    guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function sliderOfImageTranView_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderOfImageTranView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderOfImageCoraView_Callback(hObject, eventdata, handles)  

    valueOfSliderToInt = round( get(hObject,'Value') );
    set(hObject,'Value', valueOfSliderToInt);
    
    axes(handles.axesOfImageCoraView);axis tight;axis equal;
    imagesc(squeeze(handles.reconImage(valueOfSliderToInt,:,:))');
    set(handles.axesOfImageCoraView,'xtick',[]);
    set(handles.axesOfImageCoraView,'ytick',[]);
    
    guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function sliderOfImageCoraView_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderOfImageCoraView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderOfImageSagiView_Callback(hObject, eventdata, handles)
    valueOfSliderToInt = round( get(hObject,'Value') );
    set(hObject,'Value', valueOfSliderToInt);
    
    axes(handles.axesOfImageSagiView);axis tight;axis equal;
    imagesc(squeeze(handles.reconImage(:,valueOfSliderToInt,:))');
    set(handles.axesOfImageSagiView,'xtick',[]);
    set(handles.axesOfImageSagiView,'ytick',[]);
    
    guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function sliderOfImageSagiView_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderOfImageSagiView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbuttonOfLoadProjection.
function pushbuttonOfLoadProjection_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOfLoadProjection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [projectionFileName, projectionFilePath] = uigetfile( {'*.dcm;','DICOM Files(*.dcm)';'*.*','All Files (*.*)'}, '请选择投影DICOM文件（目前仅支持载入DICOM文件）');
    
    %用户通过交互界面指定了一个文件，如果用户最终点击了确定按钮，那么
    %projectionFileName 不为0，如果用户突然改变主意，点击取消，那么 
    %projectionFileName 为0，我们需要根据用户的行为进行相应的回调函数的编程
    
    if projectionFileName ~=0
        %如果用户重新打开一个投影文件，那么首先需要将投影读取模块中的全部edit控件设置为默认值
        set(findobj(handles.uipanelOfLoadProjection,'style','edit'),'Enable','on');
        set(findobj(handles.uipanelOfLoadProjection,'style','edit'),'String','0');
        set(findobj(gcf,'Tag','editOfProjDimen'),'String','[0,0,0]');
        set(findobj(gcf,'Tag','editOfPixelSpacing'),'String','[0,0]');
        set(findobj(gcf,'Tag','editOfDetRotMode'),'String','未读取');
        
        %然后将 散射、衰减与准直器-探测器响应校正模块 的所有可编辑控件设置为默认值
        set(findobj(gcf,'Tag','checkboxOfScatterCorrMode'),'Enable','on');
        set(findobj(gcf,'Tag','checkboxOfScatterCorrMode'),'Value',0);
        set(findobj(gcf,'Tag','checkboxOfAttenuationCorrMode'),'Enable','on');
        set(findobj(gcf,'Tag','checkboxOfAttenuationCorrMode'),'Value',0);
        set(findobj(gcf,'Tag','checkboxOfCollimatorDetectorCorrMode'),'Enable','on');
        set(findobj(gcf,'Tag','checkboxOfCollimatorDetectorCorrMode'),'Value',0);
        set(findobj(gcf,'Tag','editOfCollimatorThickness'),'Enable','on');
        set(findobj(gcf,'Tag','editOfCollimatorThickness'),'String',24.05);
        set(findobj(gcf,'Tag','editOfCollHoleDiameter'),'Enable','on');
        set(findobj(gcf,'Tag','editOfCollHoleDiameter'),'String',1.17);
        set(findobj(gcf,'Tag','editOfDistanceCollBackToDecPlane'),'Enable','on');
        set(findobj(gcf,'Tag','editOfDistanceCollBackToDecPlane'),'String',10.0);
        set(findobj(gcf,'Tag','editOfDetectorResolution'),'Enable','on');
        set(findobj(gcf,'Tag','editOfDetectorResolution'),'String',3.9);
        set(findobj(gcf,'Tag','radiobuttonOfMLEM'),'Enable','on');
        set(findobj(gcf,'Tag','radiobuttonOfMLEM'),'Value',0);
        set(findobj(gcf,'Tag','radiobuttonOfOSEM'),'Enable','on');
        set(findobj(gcf,'Tag','radiobuttonOfOSEM'),'Value',1);
        set(findobj(gcf,'Tag','editOfOSEMSubsetNumber'),'Enable','on');
        set(findobj(gcf,'Tag','editOfOSEMSubsetNumber'),'String',10);
        set(findobj(gcf,'Tag','editOfIterationTimes'),'Enable','on');
        set(findobj(gcf,'Tag','editOfIterationTimes'),'String',2);
        
        %再将 部分容积效应校正模块 的所有可编辑控件设置为默认值
        set(findobj(gcf,'Tag','radiobuttonOfGTM'),'Enable','on');
        set(findobj(gcf,'Tag','radiobuttonOfGTM'),'Value',0);
        set(findobj(gcf,'Tag','radiobuttonOfMTC'),'Enable','on');
        set(findobj(gcf,'Tag','radiobuttonOfMTC'),'Value',1);

        %最后将 标准摄取值计算模块 的所有可编辑控件设置为初始值
        set(findobj(handles.uipanelOfSUVcalculate,'style','edit'),'Enable','on');
        set(findobj(handles.uipanelOfSUVcalculate,'style','edit'),'String','0');
        set(findobj(gcf,'Tag','editOfInjectionTime'),'Enable','on');
        set(findobj(gcf,'Tag','editOfInjectionTime'),'String','00:00:00');
        set(findobj(gcf,'Tag','editOfAcquisitionTime'),'Enable','on');
        set(findobj(gcf,'Tag','editOfAcquisitionTime'),'String','00:00:00');
        

        projectionInfo = dicominfo(  fullfile( projectionFilePath, projectionFileName )  );
        projection4D = dicomread(projectionInfo);

        %将重建相关参数保存到 handles.reconParameterStruct结构体成员变量之中
        handles.reconParameterStruct.projectionInfo = projectionInfo;

        %经过与 Amide 读取的 DICOM 图像像素值的验证， MATLAB 所读取的投影顺序与预期相符，而且像素值正确
        %此时 projection3D 如果包含散射能窗数据的话，那么需要根据用户需求进行后续处理
        projection3D = double(squeeze(projection4D));

        handles.reconParameterStruct.projectionFileName = projectionFileName;
        handles.reconParameterStruct.xProjectionDimension = double(projectionInfo.Rows);
        handles.reconParameterStruct.zProjectionDimension = double(projectionInfo.Columns);

        pixelSpacing = projectionInfo.PixelSpacing;
        handles.reconParameterStruct.xProjectionWidth = pixelSpacing(1);
        handles.reconParameterStruct.zProjectionWidth = pixelSpacing(2);

        %一个探头一个位置算一个投影角度，所以投影角度数量等于总帧数除以能窗数，这个变量是主能窗投影的实际帧数，是需要显示到面板上供用户查看的
        handles.reconParameterStruct.numberOfProjectionView = double(projectionInfo.NumberOfFrames/projectionInfo.NumberOfEnergyWindows);
        handles.reconParameterStruct.orbitParameter = zeros(handles.reconParameterStruct.numberOfProjectionView ,2);

        % rotationDirection 的作用一个是显示到面板上供用户查看,
        % 另外一个是用于 handles.reconParameterStruct.rotationStartAngle + (n-1) * rotAngleStep 中加号还是减号的确定
        handles.reconParameterStruct.rotationDirection = projectionInfo.RotationInformationSequence.Item_1.RotationDirection;

        %-----------------------------------------------------------------------------------------------------------------------------------
        %判断是否是复杂轨道采集模式，即人体轮廓跟踪模式
        if max( size( projectionInfo.RotationInformationSequence.Item_1.RadialPosition ) ) == 1
            handles.reconParameterStruct.boolComplexOrbitMode = false;
        else
            handles.reconParameterStruct.boolComplexOrbitMode = true;
        end


        %重新组织投影，不区分探头1和探头2，投影对应的角度和与旋转中心距离这两个重要参数也需要重新组织
        %从 projection3D 抽取出主能窗帧和散射能窗帧（如果有散射能窗的话），分开存储在 handles.reconParameterStruct 中

        %如果采用了复杂轨道模式
        if handles.reconParameterStruct.boolComplexOrbitMode == true

            if projectionInfo.NumberOfEnergyWindows == 1 && projectionInfo.NumberOfDetectors == 1
                handles.projectionMain = projection3D;
                for i=1:handles.reconParameterStruct.numberOfProjectionView
                    handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.RotationInformationSequence.Item_1.StartAngle + (i-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                    handles.reconParameterStruct.orbitParameter(i,2) = projectionInfo.RotationInformationSequence.Item_1.RadialPosition(i);
                end
            end

            if projectionInfo.NumberOfEnergyWindows == 1 && projectionInfo.NumberOfDetectors == 2
                handles.projectionMain = projection3D;
                for i=1:handles.reconParameterStruct.numberOfProjectionView
                    if i>handles.reconParameterStruct.numberOfProjectionView/2
                        j=i-handles.reconParameterStruct.numberOfProjectionView/2;
                    else 
                        j=i;
                    end
                    if projectionInfo.DetectorVector(i) == 1
                        handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.DetectorInformationSequence.Item_1.StartAngle + (j-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                        handles.reconParameterStruct.orbitParameter(i,2) = projectionInfo.DetectorInformationSequence.Item_1.RadialPosition(j);
                    end
                    if projectionInfo.DetectorVector(i) == 2
                        handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.DetectorInformationSequence.Item_2.StartAngle + (j-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                        handles.reconParameterStruct.orbitParameter(i,2) = projectionInfo.DetectorInformationSequence.Item_2.RadialPosition(j);
                    end
                end
            end

            if projectionInfo.NumberOfEnergyWindows == 2 && projectionInfo.NumberOfDetectors == 1
                handles.projectionMain = projection3D(:,:,1:handles.reconParameterStruct.numberOfProjectionView); %DICOM应该默认将主能窗存在前面，散射能窗存在后面
                handles.projectionScatter = projection3D(:,:,handles.reconParameterStruct.numberOfProjectionView+1:projectionInfo.NumberOfFrames);
                for i=1:handles.reconParameterStruct.numberOfProjectionView
                    handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.RotationInformationSequence.Item_1.StartAngle + (i-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                    handles.reconParameterStruct.orbitParameter(i,2) = projectionInfo.RotationInformationSequence.Item_1.RadialPosition(i);
                end
            end

            if projectionInfo.NumberOfEnergyWindows == 2 && projectionInfo.NumberOfDetectors == 2
                handles.projectionMain = projection3D(:,:,1:handles.reconParameterStruct.numberOfProjectionView);
                handles.projectionScatter = projection3D(:,:,handles.reconParameterStruct.numberOfProjectionView+1:projectionInfo.NumberOfFrames);
                for i=1:handles.reconParameterStruct.numberOfProjectionView
                    if i>handles.reconParameterStruct.numberOfProjectionView/2
                        j=i-handles.reconParameterStruct.numberOfProjectionView/2;
                    else 
                        j=i;
                    end
                    if projectionInfo.DetectorVector(i) == 1
                        handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.DetectorInformationSequence.Item_1.StartAngle + (j-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                        handles.reconParameterStruct.orbitParameter(i,2) = projectionInfo.DetectorInformationSequence.Item_1.RadialPosition(j);
                    end
                    if projectionInfo.DetectorVector(i) == 2
                        handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.DetectorInformationSequence.Item_2.StartAngle + (j-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                        handles.reconParameterStruct.orbitParameter(i,2) = projectionInfo.DetectorInformationSequence.Item_2.RadialPosition(j);
                    end
                end
            end

        end


        %如果不采用复杂轨道模式
        if handles.reconParameterStruct.boolComplexOrbitMode == false
             if projectionInfo.NumberOfEnergyWindows == 1 && projectionInfo.NumberOfDetectors == 1
                handles.projectionMain = projection3D;
                for i=1:handles.reconParameterStruct.numberOfProjectionView
                    if strcmp(handles.reconParameterStruct.rotationDirection,'CC')
                        handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.RotationInformationSequence.Item_1.StartAngle + (i-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                    else 
                        handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.RotationInformationSequence.Item_1.StartAngle - (i-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                    end
                    handles.reconParameterStruct.orbitParameter(i,2) = projectionInfo.RotationInformationSequence.Item_1.RadialPosition;
                end
            end

            if projectionInfo.NumberOfEnergyWindows == 1 && projectionInfo.NumberOfDetectors == 2
                handles.projectionMain = projection3D;
                for i=1:handles.reconParameterStruct.numberOfProjectionView
                    if projectionInfo.DetectorVector(i) == 1
                        if strcmp(handles.reconParameterStruct.rotationDirection,'CC')
                            handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.DetectorInformationSequence.Item_1.StartAngle + (i-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                        else 
                            handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.DetectorInformationSequence.Item_1.StartAngle - (i-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                        end
                        handles.reconParameterStruct.orbitParameter(i,2) = projectionInfo.DetectorInformationSequence.Item_1.RadialPosition(i);
                    end
                    if projectionInfo.DetectorVector(i) == 2
                        if strcmp(handles.reconParameterStruct.rotationDirection,'CC')
                            handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.DetectorInformationSequence.Item_2.StartAngle + (i-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                        else 
                            handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.DetectorInformationSequence.Item_2.StartAngle - (i-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                        end
                            handles.reconParameterStruct.orbitParameter(i,2) = projectionInfo.DetectorInformationSequence.Item_2.RadialPosition(i);
                    end
                end
            end

            if projectionInfo.NumberOfEnergyWindows == 2 && projectionInfo.NumberOfDetectors == 1
                handles.projectionMain = projection3D(:,:,1:handles.reconParameterStruct.numberOfProjectionView); %DICOM应该默认将主能窗存在前面，散射能窗存在后面
                handles.projectionScatter = projection3D(:,:,handles.reconParameterStruct.numberOfProjectionView+1:projectionInfo.NumberOfFrames);
                for i=1:handles.reconParameterStruct.numberOfProjectionView
                    if strcmp(handles.reconParameterStruct.rotationDirection,'CC')
                        handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.RotationInformationSequence.Item_1.StartAngle + (i-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                    else
                        handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.RotationInformationSequence.Item_1.StartAngle - (i-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                    end
                    handles.reconParameterStruct.orbitParameter(i,2) = projectionInfo.RotationInformationSequence.Item_1.RadialPosition;
                end
            end

            if projectionInfo.NumberOfEnergyWindows == 2 && projectionInfo.NumberOfDetectors == 2
                handles.projectionMain = projection3D(:,:,1:handles.reconParameterStruct.numberOfProjectionView);
                handles.projectionScatter = projection3D(:,:,handles.reconParameterStruct.numberOfProjectionView+1:projectionInfo.NumberOfFrames);
                for i=1:handles.reconParameterStruct.numberOfProjectionView
                    if projectionInfo.DetectorVector(i) == 1
                        if strcmp(handles.reconParameterStruct.rotationDirection,'CC')
                            handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.DetectorInformationSequence.Item_1.StartAngle + (i-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                        else
                            handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.DetectorInformationSequence.Item_1.StartAngle - (i-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                        end
                        handles.reconParameterStruct.orbitParameter(i,2) = projectionInfo.DetectorInformationSequence.Item_1.RadialPosition;
                    end
                    if projectionInfo.DetectorVector(i) == 2
                        if strcmp(handles.reconParameterStruct.rotationDirection,'CC')
                            handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.DetectorInformationSequence.Item_2.StartAngle + (i-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                        else
                            handles.reconParameterStruct.orbitParameter(i,1) = projectionInfo.DetectorInformationSequence.Item_2.StartAngle - (i-1) * projectionInfo.RotationInformationSequence.Item_1.AngularStep;
                        end
                        handles.reconParameterStruct.orbitParameter(i,2) = projectionInfo.DetectorInformationSequence.Item_2.RadialPosition;
                    end
                end
            end

        end

        %-----------------------------------------------------------------------------------------------------------------------------------

        handles.reconParameterStruct.outputReconImageFileName = strcat('reconImageOf_',projectionFileName);  %设置默认重建图像文件名，存储到磁盘中
        
        handles.reconParameterStruct.xImageDimension = double(projectionInfo.Rows);
        handles.reconParameterStruct.yImageDimension = handles.reconParameterStruct.xImageDimension;
        handles.reconParameterStruct.zImageDimension = double(projectionInfo.Columns);
        handles.reconParameterStruct.xImageWidth = handles.reconParameterStruct.xProjectionWidth;
        handles.reconParameterStruct.yImageWidth = handles.reconParameterStruct.xImageWidth;
        handles.reconParameterStruct.zImageWidth = handles.reconParameterStruct.zProjectionWidth;

        % 这里我们默认DICOM把主能窗数据存储在 Item_1 中，散射能窗存储在 Item_2中，且只对双能窗这种情况进行考虑
        if  projectionInfo.NumberOfEnergyWindows == 2
            handles.reconParameterStruct.mainEnergyWindowLowLimit = projectionInfo.EnergyWindowInformationSequence.Item_1.EnergyWindowRangeSequence.Item_1.EnergyWindowLowerLimit;
            handles.reconParameterStruct.mainEnergyWindoHighLimit = projectionInfo.EnergyWindowInformationSequence.Item_1.EnergyWindowRangeSequence.Item_1.EnergyWindowUpperLimit;
            handles.reconParameterStruct.scatterEnergyWindowLowLimit = projectionInfo.EnergyWindowInformationSequence.Item_2.EnergyWindowRangeSequence.Item_1.EnergyWindowLowerLimit;
            handles.reconParameterStruct.scatterEnergyWindowHighLimit = projectionInfo.EnergyWindowInformationSequence.Item_2.EnergyWindowRangeSequence.Item_1.EnergyWindowUpperLimit;
        end

        if  projectionInfo.NumberOfEnergyWindows == 1
            handles.reconParameterStruct.mainEnergyWindowLowLimit = projectionInfo.EnergyWindowInformationSequence.Item_1.EnergyWindowRangeSequence.Item_1.EnergyWindowLowerLimit;
            handles.reconParameterStruct.mainEnergyWindoHighLimit = projectionInfo.EnergyWindowInformationSequence.Item_1.EnergyWindowRangeSequence.Item_1.EnergyWindowUpperLimit;
        end

        % eachFrameDuration 变量表示每一帧的采集时间，用于最后计算SUV，重建过程不需要使用，可以显示到面板上供用户参考，单位秒
        handles.reconParameterStruct.eachFrameDuration = projectionInfo.RotationInformationSequence.Item_1.ActualFrameDuration/1000;

        %剩下的 reconParameterStruct
        %里面的成员变量是重建模块从用户在界面中输入的数据中读取的，所以这里只是新建这些变量并初始化

        handles.reconParameterStruct.iterationTimes = 0;
        handles.reconParameterStruct.numberOfSubsets = 0;
        handles.reconParameterStruct.numberOfIterationIntervalToSave = 999999; %这个功能关闭

        %散射校正、衰减校正以及准直器-探测器响应校正 的选择开关
        handles.reconParameterStruct.boolScatterCorrectionSwitch = false;
        handles.reconParameterStruct.boolAttenuationCorrectionSwitch = false;
        handles.reconParameterStruct.boolCollimatorAndDetectorCorrectionSwitch = false;

        handles.reconParameterStruct.distanceCollimatorBackToProjectionPlane = 0;
        handles.reconParameterStruct.collimatorHoleLength = 0;
        handles.reconParameterStruct.collimatorHoleDiameter = 0;
        handles.reconParameterStruct.detectorIntrinsicResolution = 0;

        %显示投影信息到面板
        set(findobj(gcf,'Tag','editOfProjDimen'),'String',...
            sprintf('%s%d,%d,%d%s','[',handles.reconParameterStruct.xProjectionDimension,...
            handles.reconParameterStruct.zProjectionDimension,handles.reconParameterStruct.numberOfProjectionView,']'));
        set(findobj(gcf,'Tag','editOfProjDimen'),'Enable','off');

        set(findobj(gcf,'Tag','editOfPixelSpacing'),'String',...
            sprintf('%s%.2f,%.2f%s','[',handles.reconParameterStruct.xProjectionWidth,...
            handles.reconParameterStruct.zProjectionWidth,']'));
        set(findobj(gcf,'Tag','editOfPixelSpacing'),'Enable','off');

        set(findobj(gcf,'Tag','editOfMainEnergyWindow'),'String',...
            sprintf('%s%.2f,%.2f%s','[',handles.reconParameterStruct.mainEnergyWindowLowLimit,...
            handles.reconParameterStruct.mainEnergyWindoHighLimit,']'));
        set(findobj(gcf,'Tag','editOfMainEnergyWindow'),'Enable','off');

        if  projectionInfo.NumberOfEnergyWindows == 2
            set(findobj(gcf,'Tag','editOfScatterEnergyWindow'),'String',...
                sprintf('%s%.2f,%.2f%s','[',handles.reconParameterStruct.scatterEnergyWindowLowLimit,...
                handles.reconParameterStruct.scatterEnergyWindowHighLimit,']'));
            set(findobj(gcf,'Tag','editOfScatterEnergyWindow'),'Enable','off');
        end
        
        if projectionInfo.NumberOfEnergyWindows == 1
            set(findobj(gcf,'Tag','editOfScatterEnergyWindow'),'String','无散射能窗');
            set(findobj(gcf,'Tag','editOfScatterEnergyWindow'),'Enable','off');
            uiwait(msgbox('注意：投影中没有散射能窗数据，散射校正不可用！','提醒','modal'));
            set(findobj(gcf,'Tag','checkboxOfScatterCorrMode'),'Value',0);
            set(findobj(gcf,'Tag','checkboxOfScatterCorrMode'),'Enable','off');
        end
        
        set(findobj(gcf,'Tag','editOfNumberOfDetector'),'String',projectionInfo.NumberOfDetectors);
        set(findobj(gcf,'Tag','editOfNumberOfDetector'),'Enable','off');
        
        if strcmp(handles.reconParameterStruct.rotationDirection,'CC')
            set(findobj(gcf,'Tag','editOfDetRotMode'),'String','逆时针');
        else
            set(findobj(gcf,'Tag','editOfDetRotMode'),'String','顺时针');
        end
        set(findobj(gcf,'Tag','editOfDetRotMode'),'Enable','off');
        
        set(findobj(gcf,'Tag','editOfRadialDistance'),'String',projectionInfo.RotationInformationSequence.Item_1.RadialPosition(1));
        set(findobj(gcf,'Tag','editOfRadialDistance'),'Enable','off');
        
        if projectionInfo.NumberOfDetectors == 1
            set(findobj(gcf,'Tag','editOfDetector1StartAngle'),'String',projectionInfo.RotationInformationSequence.Item_1.StartAngle);
            set(findobj(gcf,'Tag','editOfDetector1StartAngle'),'Enable','off');
            set(findobj(gcf,'Tag','editOfDetector2StartAngle'),'String','未启用');
            set(findobj(gcf,'Tag','editOfDetector2StartAngle'),'Enable','off');
        end
        
        if projectionInfo.NumberOfDetectors == 2
            set(findobj(gcf,'Tag','editOfDetector1StartAngle'),'String',projectionInfo.DetectorInformationSequence.Item_1.StartAngle);
            set(findobj(gcf,'Tag','editOfDetector1StartAngle'),'Enable','off');
            set(findobj(gcf,'Tag','editOfDetector2StartAngle'),'String',projectionInfo.DetectorInformationSequence.Item_2.StartAngle);
            set(findobj(gcf,'Tag','editOfDetector2StartAngle'),'Enable','off');
        end
        
        set(findobj(gcf,'Tag','editOfScanArc'),'String',projectionInfo.RotationInformationSequence.Item_1.ScanArc);
        set(findobj(gcf,'Tag','editOfScanArc'),'Enable','off');
        
        set(findobj(gcf,'Tag','editOfAngularStep'),'String',projectionInfo.RotationInformationSequence.Item_1.AngularStep);
        set(findobj(gcf,'Tag','editOfAngularStep'),'Enable','off');
        
        set(findobj(gcf,'Tag','editOfFrameDuration'),'String',projectionInfo.RotationInformationSequence.Item_1.ActualFrameDuration/1000);
        set(findobj(gcf,'Tag','editOfFrameDuration'),'Enable','off');
        
        %显示投影预览
        
        %设置横断面
        %设置slider最大值，最小值，滑动步长以及初始值
        set(findobj(gcf,'Tag','sliderOfProjTranView'),'Min',1);
        set(findobj(gcf,'Tag','sliderOfProjTranView'),'Max',handles.reconParameterStruct.numberOfProjectionView);
        set(findobj(gcf,'Tag','sliderOfProjTranView'),'SliderStep',[1/handles.reconParameterStruct.numberOfProjectionView,1/handles.reconParameterStruct.numberOfProjectionView]);
        set(findobj(gcf,'Tag','sliderOfProjTranView'),'Value', ceil(handles.reconParameterStruct.numberOfProjectionView/2) );
        %设置坐标轴，画图
        cla(handles.axesOfProjTranView);
        axes(handles.axesOfProjTranView);axis tight;axis equal;
        imagesc(handles.projectionMain(:,:, ceil(handles.reconParameterStruct.numberOfProjectionView/2) ));
        set(handles.axesOfProjTranView,'xtick',[]);
        set(handles.axesOfProjTranView,'ytick',[]);
        
        
        %设置冠状面
        set(findobj(gcf,'Tag','sliderOfProjCoraView'),'Min',1);
        set(findobj(gcf,'Tag','sliderOfProjCoraView'),'Max',handles.reconParameterStruct.xProjectionDimension);
        set(findobj(gcf,'Tag','sliderOfProjCoraView'),'SliderStep',[1/handles.reconParameterStruct.xProjectionDimension,1/handles.reconParameterStruct.xProjectionDimension]);
        set(findobj(gcf,'Tag','sliderOfProjCoraView'),'Value', ceil(handles.reconParameterStruct.xProjectionDimension/2) );
        
        
        cla(handles.axesOfProjCoraView);
        axes(handles.axesOfProjCoraView);axis tight;axis equal;
        imagesc(flipud(squeeze(handles.projectionMain( ceil(handles.reconParameterStruct.xProjectionDimension/2) ,:,:))'));
        set(handles.axesOfProjCoraView,'xtick',[]);
        set(handles.axesOfProjCoraView,'ytick',[]);
        
        %设置矢状面
        set(findobj(gcf,'Tag','sliderOfProjSagiView'),'Min',1);
        set(findobj(gcf,'Tag','sliderOfProjSagiView'),'Max',handles.reconParameterStruct.zProjectionDimension);
        set(findobj(gcf,'Tag','sliderOfProjSagiView'),'SliderStep',[1/handles.reconParameterStruct.zProjectionDimension,1/handles.reconParameterStruct.zProjectionDimension]);
        set(findobj(gcf,'Tag','sliderOfProjSagiView'),'Value', ceil(handles.reconParameterStruct.zProjectionDimension/2) );
        
        cla(handles.axesOfProjSagiView);
        axes(handles.axesOfProjSagiView);axis tight;axis equal;
        imagesc(squeeze(handles.projectionMain(:, ceil(handles.reconParameterStruct.zProjectionDimension/2) ,:))');
        set(handles.axesOfProjSagiView,'xtick',[]);
        set(handles.axesOfProjSagiView,'ytick',[]);
        
        guidata(hObject,handles);
        
    end
    
    
    
    

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxOfScatterCorrMode.
function checkboxOfScatterCorrMode_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxOfScatterCorrMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if isfield(handles,'projectionMain')
    
    if min(size(handles.projectionMain)) >= 1 && min(size(handles.projectionScatter)) >= 1
        handles.reconParameterStruct.boolScatterCorrectionSwitch = logical( get(hObject,'Value') );
        guidata(hObject,handles);
    else
        uiwait(msgbox('错误：投影数组有一个维度小于0，请检查原始投影文件并重新载入！','错误','modal'));
        set(hObject,'Enable','off');
    end
    
else
    uiwait(msgbox('错误：程序未载入投影文件！请指定相应的DICOM投影文件并将其导入。','错误','modal'));
    set(hObject,'Value',0);
    
end
    
    

% --- Executes on button press in checkboxOfAttenuationCorrMode.
function checkboxOfAttenuationCorrMode_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxOfAttenuationCorrMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    if isfield(handles,'projectionMain')
        %如果衰减图已经导入，而且其维度最小值大于0，那么衰减校正复选框有效，读取其状态赋值给
        % handles.reconParameterStruct.boolAttenuationCorrectionSwitch
        if isfield(handles,'attenuationMap')
            if min(size(handles.attenuationMap)) >= 1
                handles.reconParameterStruct.boolAttenuationCorrectionSwitch = logical( get(hObject,'Value') );
                guidata(hObject,handles);
            else 
                uiwait(msgbox('错误：衰减图有一个维度小于0，请检查CT文件并重新导入！','错误','modal'));
                set(hObject,'Value',0);
            end

        else
            uiwait(msgbox('警告：程序未读取到CT(HU)衰减图！请指定相应的二进制文件并将其导入。','警告','modal'));
            set(hObject,'Value',0);
        end

    else
        uiwait(msgbox('错误：程序未载入投影文件！请指定相应的DICOM投影文件并将其导入。','错误','modal'));
        set(hObject,'Value',0);

    end




% --- Executes on button press in checkboxOfCollimatorDetectorCorrMode.
function checkboxOfCollimatorDetectorCorrMode_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxOfCollimatorDetectorCorrMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%读取准直器-探测器响应校正复选框，将其状态赋值给
% handles.reconParameterStruct.boolCollimatorAndDetectorCorrectionSwitch

if isfield(handles,'projectionMain')
    
    if min(size(handles.projectionMain)) >= 1 
        handles.reconParameterStruct.boolCollimatorAndDetectorCorrectionSwitch = logical( get(hObject,'Value') );
        handles.reconParameterStruct.collimatorHoleLength = str2double( get(findobj(gcf,'Tag','editOfCollimatorThickness'),'String') );
        handles.reconParameterStruct.collimatorHoleDiameter = str2double( get(findobj(gcf,'Tag','editOfCollHoleDiameter'),'String') );
        handles.reconParameterStruct.distanceCollimatorBackToProjectionPlane = str2double( get(findobj(gcf,'Tag','editOfDistanceCollBackToDecPlane'),'String') );
        handles.reconParameterStruct.detectorIntrinsicResolution = str2double( get(findobj(gcf,'Tag','editOfDetectorResolution'),'String') );
        guidata(hObject,handles);
    else
        uiwait(msgbox('错误：投影数组有一个维度小于0，请检查原始投影文件并重新载入！','错误','modal'));
        set(hObject,'Enable','off');
    end
    
else
    uiwait(msgbox('错误：程序未载入投影文件！请指定相应的DICOM投影文件并将其导入。','错误','modal'));
    set(hObject,'Value',0);
    
end



% --- Executes on button press in pushbuttonOfStartReconstruction.
function pushbuttonOfStartReconstruction_Callback(hObject, eventdata, handles)
    %判断投影是否已经载入
    if isfield(handles,'projectionMain')
        
        if min(size(handles.projectionMain)) >= 1
            
            %避免误点击，让用户确认进行重建操作
            answer = questdlg('请再次检查面板中的重建参数，是否立即使用当前参数进行图像重建？','图像重建过程即将开始','是','否','是');
            
            if answer == '是'
            
                %清空图像预览面板中（如果）已有的图像句柄
                cla(handles.axesOfImageTranView);
                
                %清空图像预览面板中（如果）已有的图像句柄
                cla(handles.axesOfImageCoraView);

                %清空图像预览面板中（如果）已有的图像句柄
                cla(handles.axesOfImageSagiView);

                %读取面板中的重建参数
                handles.reconParameterStruct.iterationTimes = str2num( get(findobj(gcf,'Tag','editOfIterationTimes'),'String') );

                if get(findobj(gcf,'Tag','radiobuttonOfMLEM'),'Value') == 1
                    handles.reconParameterStruct.numberOfSubsets = handles.reconParameterStruct.numberOfProjectionView;
                else
                    handles.reconParameterStruct.numberOfSubsets = str2num( get(findobj(gcf,'Tag','editOfOSEMSubsetNumber'),'String') );
                end

                handles.reconParameterStruct.boolScatterCorrectionSwitch = logical( get(findobj(gcf,'Tag','checkboxOfScatterCorrMode'),'Value') );
                handles.reconParameterStruct.boolAttenuationCorrectionSwitch = logical( get(findobj(gcf,'Tag','checkboxOfAttenuationCorrMode'),'Value') );
                handles.reconParameterStruct.boolCollimatorAndDetectorCorrectionSwitch = logical( get(findobj(gcf,'Tag','checkboxOfCollimatorDetectorCorrMode'),'Value') );

                handles.reconParameterStruct.collimatorHoleLength = str2double( get(findobj(gcf,'Tag','editOfCollimatorThickness'),'String') );
                handles.reconParameterStruct.collimatorHoleDiameter = str2double( get(findobj(gcf,'Tag','editOfCollHoleDiameter'),'String') );
                handles.reconParameterStruct.distanceCollimatorBackToProjectionPlane = str2double( get(findobj(gcf,'Tag','editOfDistanceCollBackToDecPlane'),'String') );
                handles.reconParameterStruct.detectorIntrinsicResolution = str2double( get(findobj(gcf,'Tag','editOfDetectorResolution'),'String') );
                guidata(hObject,handles);
            
                %开始进行重建，重建图像存入 handles 结构体成员变量 reconImage 之中
                handles = startSPECTreconstruction(handles);
                guidata(hObject,handles);
                
                if isfield(handles,'reconImage')
                    
                    %自动在当前文件夹保存重建图像为DICOM文件
                    handles.reconParameterStruct.projectionInfo.NumberOfFrames = handles.reconParameterStruct.zImageDimension;
                    handles.reconParameterStruct.projectionInfo.SliceThickness = handles.reconParameterStruct.zImageWidth;
                    handles.reconParameterStruct.projectionInfo.SliceVector = zeros(handles.reconParameterStruct.zImageDimension,1);
                    for i=1:handles.reconParameterStruct.zImageDimension
                        handles.reconParameterStruct.projectionInfo.SliceVector(i)=i;
                    end
                    handles.reconParameterStruct.projectionInfo.NumberOfSlices = handles.reconParameterStruct.zImageDimension;
                    
                    
                    maxOfReconImagePixelValue = max(max(max(handles.reconImage)));
                    minOfReconImagePixelValue = min(min(min(handles.reconImage)));
                    scaleFactorOfReconImagePixelValue = floor(65535/maxOfReconImagePixelValue);
                    maxOfReconImagePixelValueScaled = uint16(scaleFactorOfReconImagePixelValue*maxOfReconImagePixelValue);
                    minOfReconImagePixelValueScaled = uint16(scaleFactorOfReconImagePixelValue*minOfReconImagePixelValue);
                    handles.reconParameterStruct.projectionInfo.WindowWidth = maxOfReconImagePixelValueScaled - minOfReconImagePixelValueScaled;
                    handles.reconParameterStruct.projectionInfo.SmallestImagePixelValue = minOfReconImagePixelValueScaled;
                    handles.reconParameterStruct.projectionInfo.LargestImagePixelValue = maxOfReconImagePixelValueScaled;
                    handles.reconParameterStruct.projectionInfo.WindowCenter = uint16(0.5*( maxOfReconImagePixelValueScaled - minOfReconImagePixelValueScaled ));
                    
                    
                    for i=1:handles.reconParameterStruct.xImageDimension
                        for j=1:handles.reconParameterStruct.yImageDimension
                            for m=1:1
                                for k=1:handles.reconParameterStruct.zImageDimension
                                    reconImage4D(i,j,m,k) = uint16(scaleFactorOfReconImagePixelValue*handles.reconImage(i,j,k));
                                end
                            end
                        end
                    end
                    
                    if handles.reconParameterStruct.boolScatterCorrectionSwitch
                        scatterCorrectionSwitchString = 'scatter_';
                    else
                        scatterCorrectionSwitchString = '';
                    end

                    if handles.reconParameterStruct.boolAttenuationCorrectionSwitch
                        attenuationCorrectionSwitchString = 'attenuation_';
                    else
                        attenuationCorrectionSwitchString = '';
                    end

                    if handles.reconParameterStruct.boolCollimatorAndDetectorCorrectionSwitch
                        collimatorAndDetectorCorrectionSwitchString = 'collimatorAndDetector_';
                    else
                        collimatorAndDetectorCorrectionSwitchString = '';
                    end
                    
                    if handles.reconParameterStruct.boolScatterCorrectionSwitch == false ...
                            && handles.reconParameterStruct.boolAttenuationCorrectionSwitch == false ...
                            && handles.reconParameterStruct.boolCollimatorAndDetectorCorrectionSwitch ==false
                        prefixString = 'none_correction_';
                    else
                        prefixString = 'correction_';
                    end

                    outputReconImageFileName = strcat(scatterCorrectionSwitchString,...
                        attenuationCorrectionSwitchString,...
                        collimatorAndDetectorCorrectionSwitchString,...
                        prefixString,handles.reconParameterStruct.outputReconImageFileName);
                    
                    %%%%%%%%%%%%%%%%%%%
                    handles.reconParameterStruct.projectionInfo.SeriesDescription = outputReconImageFileName;
                    %%%%%%%%%%%%%%%%%%%
                    if exist(outputReconImageFileName,'file')
                        delete(outputReconImageFileName);
                    end
                    
                    dicomwrite(reconImage4D,outputReconImageFileName, 'CreateMode','Copy',handles.reconParameterStruct.projectionInfo);
                    
                    %重建结果显示到图像预览坐标轴
                    
                    %设置横断面
                    
                    %设置slider最大值，最小值，滑动步长以及初始值
                    set(findobj(gcf,'Tag','sliderOfImageTranView'),'Min',1);
                    set(findobj(gcf,'Tag','sliderOfImageTranView'),'Max',handles.reconParameterStruct.zImageDimension);
                    set(findobj(gcf,'Tag','sliderOfImageTranView'),'SliderStep',[1/handles.reconParameterStruct.zImageDimension,1/handles.reconParameterStruct.zImageDimension]);
                    set(findobj(gcf,'Tag','sliderOfImageTranView'),'Value', ceil(handles.reconParameterStruct.zImageDimension/2) );
                    %设置坐标轴，画图
                    cla(handles.axesOfImageTranView);
                    axes(handles.axesOfImageTranView);axis tight;axis equal;
                    imagesc(handles.reconImage(:,:, ceil(handles.reconParameterStruct.zImageDimension/2) ));
                    set(handles.axesOfImageTranView,'xtick',[]);
                    set(handles.axesOfImageTranView,'ytick',[]);

                    %设置冠状面
                    set(findobj(gcf,'Tag','sliderOfImageCoraView'),'Min',1);
                    set(findobj(gcf,'Tag','sliderOfImageCoraView'),'Max',handles.reconParameterStruct.xImageDimension);
                    set(findobj(gcf,'Tag','sliderOfImageCoraView'),'SliderStep',[1/handles.reconParameterStruct.xImageDimension,1/handles.reconParameterStruct.xImageDimension]);
                    set(findobj(gcf,'Tag','sliderOfImageCoraView'),'Value', ceil(handles.reconParameterStruct.xImageDimension/2) );

                    cla(handles.axesOfImageCoraView);
                    axes(handles.axesOfImageCoraView);axis tight;axis equal;
                    imagesc(squeeze(handles.reconImage( ceil(handles.reconParameterStruct.xImageDimension/2) ,:,:))' );
                    set(handles.axesOfImageCoraView,'xtick',[]);
                    set(handles.axesOfImageCoraView,'ytick',[]);
                    

                    %设置矢状面
                    set(findobj(gcf,'Tag','sliderOfImageSagiView'),'Min',1);
                    set(findobj(gcf,'Tag','sliderOfImageSagiView'),'Max',handles.reconParameterStruct.yImageDimension);
                    set(findobj(gcf,'Tag','sliderOfImageSagiView'),'SliderStep',[1/handles.reconParameterStruct.yImageDimension,1/handles.reconParameterStruct.yImageDimension]);
                    set(findobj(gcf,'Tag','sliderOfImageSagiView'),'Value', ceil(handles.reconParameterStruct.yImageDimension/2) );

                    cla(handles.axesOfImageSagiView);
                    axes(handles.axesOfImageSagiView);axis tight;axis equal;
                    imagesc(squeeze(handles.reconImage(:, ceil(handles.reconParameterStruct.yImageDimension/2) ,:))' );
                    set(handles.axesOfImageSagiView,'xtick',[]);
                    set(handles.axesOfImageSagiView,'ytick',[]);
                    
                    guidata(hObject,handles);
                    
                else
                    
                    uiwait(msgbox('错误：重建过程出现未知错误，重建图像未生成，请检查！','错误','modal'));
                end
                
                
            end
            
        else
            uiwait(msgbox('错误：投影数组有一个维度小于0，请检查原始投影文件并重新载入！','错误','modal'));
        end

    else
        uiwait(msgbox('错误：程序未载入投影文件！请指定相应的DICOM投影文件并将其导入。','错误','modal'));
        
    end





function editOfCollimatorThickness_Callback(hObject, eventdata, handles)
% hObject    handle to editOfCollimatorThickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    if isfield(handles,'projectionMain')

        if min(size(handles.projectionMain)) < 1
            uiwait(msgbox('错误：投影数组有一个维度小于0，请检查原始投影文件并重新载入！','错误','modal'));
            set(hObject,'Enable','off');
        end

    else
        set(hObject,'String','24.05');
        uiwait(msgbox('错误：程序未载入投影文件！请指定相应的DICOM投影文件并将其导入。','错误','modal'));
        
    end


% --- Executes during object creation, after setting all properties.
function editOfCollimatorThickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfCollimatorThickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfCollHoleDiameter_Callback(hObject, eventdata, handles)
% hObject    handle to editOfCollHoleDiameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    if isfield(handles,'projectionMain')

        if min(size(handles.projectionMain)) < 1
            uiwait(msgbox('错误：投影数组有一个维度小于0，请检查原始投影文件并重新载入！','错误','modal'));
            set(hObject,'Enable','off');
        end

    else
        set(hObject,'String','1.17');
        uiwait(msgbox('错误：程序未载入投影文件！请指定相应的DICOM投影文件并将其导入。','错误','modal'));

    end


% --- Executes during object creation, after setting all properties.
function editOfCollHoleDiameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfCollHoleDiameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfDistanceCollBackToDecPlane_Callback(hObject, eventdata, handles)
% hObject    handle to editOfDistanceCollBackToDecPlane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    if isfield(handles,'projectionMain')

        if min(size(handles.projectionMain)) < 1
            uiwait(msgbox('错误：投影数组有一个维度小于0，请检查原始投影文件并重新载入！','错误','modal'));
            set(hObject,'Enable','off');
        end

    else
        set(hObject,'String','10');
        uiwait(msgbox('错误：程序未载入投影文件！请指定相应的DICOM投影文件并将其导入。','错误','modal'));

    end


% --- Executes during object creation, after setting all properties.
function editOfDistanceCollBackToDecPlane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfDistanceCollBackToDecPlane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfDetectorResolution_Callback(hObject, eventdata, handles)
% hObject    handle to editOfDetectorResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    if isfield(handles,'projectionMain')

        if min(size(handles.projectionMain)) < 1
            uiwait(msgbox('错误：投影数组有一个维度小于0，请检查原始投影文件并重新载入！','错误','modal'));
            set(hObject,'Enable','off');
        end

    else
        set(hObject,'String','3.9');
        uiwait(msgbox('错误：程序未载入投影文件！请指定相应的DICOM投影文件并将其导入。','错误','modal'));
        
    end


% --- Executes during object creation, after setting all properties.
function editOfDetectorResolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfDetectorResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonOfStartPVC.
function pushbuttonOfStartPVC_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOfStartPVC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonOfLoadCTHUimage.
function pushbuttonOfLoadCTHUimage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOfLoadCTHUimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [attenuationMapFileName, attenuationMapFilePath] = uigetfile( {'*.dat;','二进制文件(*.dat)';'*.*','All Files (*.*)'}, ...
    '请选择CT(HU)二进制文件（目前仅支持二进制格式，请先用Amide手动配准CT图后以二进制格式导出，后缀命名为 .dat）');
    if attenuationMapFileName ~= 0
        handles.attenuationMap = readAttenuationMapFromDisk(fullfile( attenuationMapFilePath, attenuationMapFileName ),...
            handles.reconParameterStruct.xImageDimension ,...
            handles.reconParameterStruct.yImageDimension ,...
            handles.reconParameterStruct.zImageDimension );
        guidata(hObject,handles);
    end


% --- Executes on button press in radiobuttonOfGTM.
function radiobuttonOfGTM_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonOfGTM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonOfGTM


% --- Executes on button press in pushbuttonOfLoadMyocardiumImage.
function pushbuttonOfLoadMyocardiumImage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOfLoadMyocardiumImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonOfLoadCardiacBloodPoolImage.
function pushbuttonOfLoadCardiacBloodPoolImage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOfLoadCardiacBloodPoolImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonOfPVCimageSaveAs.
function pushbuttonOfPVCimageSaveAs_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOfPVCimageSaveAs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonOfScatAttnCollDetImageSaveAs.
function pushbuttonOfScatAttnCollDetImageSaveAs_Callback(hObject, eventdata, handles)
    if isfield(handles,'reconImage')
        defaultNameSuffixDcm = handles.reconParameterStruct.projectionInfo.SeriesDescription;
        defaultNameSuffixDat = strcat(defaultNameSuffixDcm(1:length(defaultNameSuffixDcm)-4),'.dat');
        [userDefinedImageFileName,userDefinedImageFilePath] = uiputfile('*.dat','图像另存为(请输入重建图像文件名)',defaultNameSuffixDat);
        
        suffixExitFlag = strfind(userDefinedImageFileName,'.dat');
        
        if isempty(suffixExitFlag) || max(suffixExitFlag+3)~=length(userDefinedImageFileName)
            outputFileNameOfReconImage = strcat(userDefinedImageFileName,'.dat');
        else
            outputFileNameOfReconImage = userDefinedImageFileName;
        end
        
        saveReconstructionImageToDisk(  fullfile(userDefinedImageFilePath,outputFileNameOfReconImage), handles.reconImage, ...
            handles.reconParameterStruct.xImageDimension, handles.reconParameterStruct.yImageDimension, handles.reconParameterStruct.zImageDimension);
        
    else
        uiwait(msgbox('错误：重建图像未生成，请检查！','错误','modal'));
    end


    



function editOfiMTCiterationTimes_Callback(hObject, eventdata, handles)
% hObject    handle to editOfiMTCiterationTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfiMTCiterationTimes as text
%        str2double(get(hObject,'String')) returns contents of editOfiMTCiterationTimes as a double


% --- Executes during object creation, after setting all properties.
function editOfiMTCiterationTimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfiMTCiterationTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfInjectionTime_Callback(hObject, eventdata, handles)
% hObject    handle to editOfInjectionTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfInjectionTime as text
%        str2double(get(hObject,'String')) returns contents of editOfInjectionTime as a double


% --- Executes during object creation, after setting all properties.
function editOfInjectionTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfInjectionTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfAcquisitionTime_Callback(hObject, eventdata, handles)
% hObject    handle to editOfAcquisitionTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfAcquisitionTime as text
%        str2double(get(hObject,'String')) returns contents of editOfAcquisitionTime as a double


% --- Executes during object creation, after setting all properties.
function editOfAcquisitionTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfAcquisitionTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfInjectionActivity_Callback(hObject, eventdata, handles)
% hObject    handle to editOfInjectionActivity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfInjectionActivity as text
%        str2double(get(hObject,'String')) returns contents of editOfInjectionActivity as a double


% --- Executes during object creation, after setting all properties.
function editOfInjectionActivity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfInjectionActivity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfNuclideHalfLife_Callback(hObject, eventdata, handles)
% hObject    handle to editOfNuclideHalfLife (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfNuclideHalfLife as text
%        str2double(get(hObject,'String')) returns contents of editOfNuclideHalfLife as a double


% --- Executes during object creation, after setting all properties.
function editOfNuclideHalfLife_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfNuclideHalfLife (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfPatientWeight_Callback(hObject, eventdata, handles)
% hObject    handle to editOfPatientWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfPatientWeight as text
%        str2double(get(hObject,'String')) returns contents of editOfPatientWeight as a double


% --- Executes during object creation, after setting all properties.
function editOfPatientWeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfPatientWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonStartSUVcalculation.
function pushbuttonStartSUVcalculation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStartSUVcalculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonOfSUVimageSaveAs.
function pushbuttonOfSUVimageSaveAs_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonOfSUVimageSaveAs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editOfSPECTsensitivity_Callback(hObject, eventdata, handles)
% hObject    handle to editOfSPECTsensitivity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfSPECTsensitivity as text
%        str2double(get(hObject,'String')) returns contents of editOfSPECTsensitivity as a double


% --- Executes during object creation, after setting all properties.
function editOfSPECTsensitivity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfSPECTsensitivity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfPixelSpacing_Callback(hObject, eventdata, handles)
% hObject    handle to editOfPixelSpacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfPixelSpacing as text
%        str2double(get(hObject,'String')) returns contents of editOfPixelSpacing as a double


% --- Executes during object creation, after setting all properties.
function editOfPixelSpacing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfPixelSpacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfMainEnergyWindow_Callback(hObject, eventdata, handles)
% hObject    handle to editOfMainEnergyWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfMainEnergyWindow as text
%        str2double(get(hObject,'String')) returns contents of editOfMainEnergyWindow as a double


% --- Executes during object creation, after setting all properties.
function editOfMainEnergyWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfMainEnergyWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfScatterEnergyWindow_Callback(hObject, eventdata, handles)
% hObject    handle to editOfScatterEnergyWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfScatterEnergyWindow as text
%        str2double(get(hObject,'String')) returns contents of editOfScatterEnergyWindow as a double


% --- Executes during object creation, after setting all properties.
function editOfScatterEnergyWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfScatterEnergyWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfDetRotMode_Callback(hObject, eventdata, handles)
% hObject    handle to editOfDetRotMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfDetRotMode as text
%        str2double(get(hObject,'String')) returns contents of editOfDetRotMode as a double


% --- Executes during object creation, after setting all properties.
function editOfDetRotMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfDetRotMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfRadialDistance_Callback(hObject, eventdata, handles)
% hObject    handle to editOfRadialDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfRadialDistance as text
%        str2double(get(hObject,'String')) returns contents of editOfRadialDistance as a double


% --- Executes during object creation, after setting all properties.
function editOfRadialDistance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfRadialDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfScanArc_Callback(hObject, eventdata, handles)
% hObject    handle to editOfScanArc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfScanArc as text
%        str2double(get(hObject,'String')) returns contents of editOfScanArc as a double


% --- Executes during object creation, after setting all properties.
function editOfScanArc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfScanArc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfAngularStep_Callback(hObject, eventdata, handles)
% hObject    handle to editOfAngularStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfAngularStep as text
%        str2double(get(hObject,'String')) returns contents of editOfAngularStep as a double


% --- Executes during object creation, after setting all properties.
function editOfAngularStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfAngularStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfDetector1StartAngle_Callback(hObject, eventdata, handles)
% hObject    handle to editOfDetector1StartAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfDetector1StartAngle as text
%        str2double(get(hObject,'String')) returns contents of editOfDetector1StartAngle as a double


% --- Executes during object creation, after setting all properties.
function editOfDetector1StartAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfDetector1StartAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfOSEMSubsetNumber_Callback(hObject, eventdata, handles)
% hObject    handle to editOfOSEMSubsetNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    if isfield(handles,'projectionMain')

        if min(size(handles.projectionMain)) >= 1

            numberOfSubsets = str2num( get(hObject,'String') );
            if mod(handles.reconParameterStruct.numberOfProjectionView,numberOfSubsets) == 0
                handles.reconParameterStruct.numberOfSubsets = numberOfSubsets;
                guidata(hObject, handles);
            else
                uiwait(msgbox('错误：OSEM子集数不能被投影帧数整除，输入无效，请重新输入！','错误','modal'));
                set(hObject,'String','10');
            end
            
        else
            
            uiwait(msgbox('错误：投影数组有一个维度小于0，请检查原始投影文件并重新载入！','错误','modal'));
            set(hObject,'Enable','off');
        end

    else
        set(hObject,'String','10');
        uiwait(msgbox('错误：程序未载入投影文件！请指定相应的DICOM投影文件并将其导入。','错误','modal'));
        
    end


% --- Executes during object creation, after setting all properties.
function editOfOSEMSubsetNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfOSEMSubsetNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfIterationTimes_Callback(hObject, eventdata, handles)
% hObject    handle to editOfIterationTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    if isfield(handles,'projectionMain')

        if min(size(handles.projectionMain)) >= 1
                handles.reconParameterStruct.iterationTimes = str2num( get(hObject,'String') );;
                guidata(hObject, handles);
        else
            uiwait(msgbox('错误：投影数组有一个维度小于0，请检查原始投影文件并重新载入！','错误','modal'));
            set(hObject,'Enable','off');
        end

    else
        set(hObject,'String','2');
        uiwait(msgbox('错误：程序未载入投影文件！请指定相应的DICOM投影文件并将其导入。','错误','modal'));
        
    end


% --- Executes during object creation, after setting all properties.
function editOfIterationTimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfIterationTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfActivityAfterInjection_Callback(hObject, eventdata, handles)
% hObject    handle to editOfActivityAfterInjection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfActivityAfterInjection as text
%        str2double(get(hObject,'String')) returns contents of editOfActivityAfterInjection as a double


% --- Executes during object creation, after setting all properties.
function editOfActivityAfterInjection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfActivityAfterInjection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfFrameDuration_Callback(hObject, eventdata, handles)
% hObject    handle to editOfFrameDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfFrameDuration as text
%        str2double(get(hObject,'String')) returns contents of editOfFrameDuration as a double


% --- Executes during object creation, after setting all properties.
function editOfFrameDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfFrameDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfNumberOfDetector_Callback(hObject, eventdata, handles)
% hObject    handle to editOfNumberOfDetector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfNumberOfDetector as text
%        str2double(get(hObject,'String')) returns contents of editOfNumberOfDetector as a double


% --- Executes during object creation, after setting all properties.
function editOfNumberOfDetector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfNumberOfDetector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOfDetector2StartAngle_Callback(hObject, eventdata, handles)
% hObject    handle to editOfDetector2StartAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOfDetector2StartAngle as text
%        str2double(get(hObject,'String')) returns contents of editOfDetector2StartAngle as a double


% --- Executes during object creation, after setting all properties.
function editOfDetector2StartAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOfDetector2StartAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobuttonOfMLEM.
function radiobuttonOfMLEM_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonOfMLEM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonOfMLEM


% --- Executes when selected object is changed in uibuttongroupOfIterParaSetup.
function uibuttongroupOfIterParaSetup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroupOfIterParaSetup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    if isfield(handles,'projectionMain')

        if min(size(handles.projectionMain)) >= 1
            
                radioButtonTag = get(hObject,'Tag');
                switch radioButtonTag
                    case 'radiobuttonOfMLEM'
                        handles.reconParameterStruct.iterationTimes = str2num( get(findobj(gcf,'Tag','editOfIterationTimes'),'String') );
                        handles.reconParameterStruct.numberOfSubsets = handles.reconParameterStruct.numberOfProjectionView;
                    case 'radiobuttonOfOSEM'
                        iterationTimes = str2num( get(findobj(gcf,'Tag','editOfIterationTimes'),'String') );
                        numberOfSubsets = str2num( get(findobj(gcf,'Tag','editOfOSEMSubsetNumber'),'String') );
                        if mod(handles.reconParameterStruct.numberOfProjectionView,numberOfSubsets) == 0
                            handles.reconParameterStruct.iterationTimes = iterationTimes;
                            handles.reconParameterStruct.numberOfSubsets = numberOfSubsets;
                        else
                            uiwait(msgbox('错误：OSEM子集数不能被投影帧数整除，输入无效，请重新输入！','错误','modal'));
                        end
                end
                guidata(hObject, handles);
                
        else
            uiwait(msgbox('错误：投影数组有一个维度小于0，请检查原始投影文件并重新载入！','错误','modal'));
        end

    else
        uiwait(msgbox('错误：程序未载入投影文件！请指定相应的DICOM投影文件并将其导入。','错误','modal'));
        
    end


% --- Executes during object creation, after setting all properties.
function uibuttongroupOfIterParaSetup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroupOfIterParaSetup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit44_Callback(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit44 as text
%        str2double(get(hObject,'String')) returns contents of edit44 as a double


% --- Executes during object creation, after setting all properties.
function edit44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function textOfFigSubtitle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textOfFigSubtitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
