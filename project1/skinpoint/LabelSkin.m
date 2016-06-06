function varargout = LabelSkin(varargin)
% LABELSKIN MATLAB code for LabelSkin.fig
%      LABELSKIN, by itself, creates a new LABELSKIN or raises the existing
%      singleton*.
%
%      H = LABELSKIN returns the handle to a new LABELSKIN or the handle to
%      the existing singleton*.
%
%      LABELSKIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LABELSKIN.M with the given input arguments.
%
%      LABELSKIN('Property','Value',...) creates a new LABELSKIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LabelSkin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LabelSkin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LabelSkin

% Last Modified by GUIDE v2.5 28-Jan-2015 22:43:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LabelSkin_OpeningFcn, ...
                   'gui_OutputFcn',  @LabelSkin_OutputFcn, ...
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

% --- Executes just before LabelSkin is made visible.
function LabelSkin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LabelSkin (see VARARGIN)

% Choose default command line output for LabelSkin
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LabelSkin wait for user response (see UIRESUME)
% uiwait(handles.figure);

% --- Outputs from this function are returned to the command line.
function varargout = LabelSkin_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OpenImage.
function OpenImage_Callback(hObject, eventdata, handles)
% hObject    handle to OpenImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.jpg';'*.png';'*.bmp';'*.*'},'Select a picture file');

if isequal(FileName,0)
    return;
end
h=imtool2(fullfile(PathName, FileName));
%adjust position of the image window
position = get(h, 'position');
position(2) = 100; %y position
position(3) = 600; % width
position(4) = 500; % height
set(h,'position',position);
%get the image handle
child_handles = allchild(h);
AllTagList =  get(child_handles,'Tag');
bp = findobj(h,'Tag','bottom panel');
child = allchild(bp);
imageHandle = guihandles(child(1)); 
% Transfer the window handle to the image window
% For image window to notify new added pixel
handles.listBoxInfo = struct('index',{},'skin',{},'x',{},'y',{},'rgbi',{},'rgb',{},'yiq',{},'hsv',{});
guidata(hObject,handles);
imageHandle.labelSkinHandles = handles;
%imageHandle.listBoxInfo = struct('index',{},'skin',{},'x',{},'y',{},'rgbid',{},'rgb',{},'yiq',{},'hsv',{});
% Save the structure
guidata(child,imageHandle);
set(handles.OpenImage,'Enable','off'); 

% --- Executes on button press in SaveFile.
function SaveFile_Callback(hObject, eventdata, handles)
% hObject    handle to SaveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname] = uiputfile('*.csv','Save the File As');

if isequal(filename,0) || isequal(pathname,0)
   return;
end

fpath = fullfile(pathname,filename);
fileID = fopen(fpath,'w+');
eq = isfield(handles, 'listBoxInfo');
if isequal(eq, 0)
    return;
end
for ii=handles.listBoxInfo
    fprintf(fileID,'%d, %d, %f, %f, %f, %f, %f, %f, %f, %f, %f, %d\n',ii.x,ii.y, ...
        ii.rgb(1),ii.rgb(2),ii.rgb(3), ii.yiq(1), ii.yiq(2), ii.yiq(3), ...
        ii.hsv(1), ii.hsv(2), ii.hsv(3), ii.skin);
end
fclose(fileID);

% --- Executes on selection change in labelListBox.
function labelListBox_Callback(hObject, eventdata, handles)
% hObject    handle to labelListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns labelListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from labelListBox
ed = isfield(eventdata,'rgbi');
% 
% %update the new selected pixels to the struct array 
if ed == 1
    itemNum = length(handles.listBoxInfo);
    handles.listBoxInfo(itemNum+1) = eventdata;
    guidata(hObject,handles);  
end
sel = get(handles.labelListBox,'Value');
if(sel > 0)
    info = handles.listBoxInfo(sel);
    set(handles.xypos,'String',sprintf('Position:     x=%d     y=%d',info.x,info.y));
    set(handles.RGBid,'String',sprintf('RGB: R=%d (%.3f)    G=%d (%.3f)    B=%d (%.3f)', ...
        info.rgbi(1), info.rgb(1), info.rgbi(2), info.rgb(2), info.rgbi(3), info.rgb(3)));
    set(handles.YIQid,'String',sprintf('YIQ: Y=%.3f    I=%.3f    Q=%.3f', ...
        info.yiq(1), info.yiq(2), info.yiq(3) )   );
    set(handles.HSVid,'String',sprintf('HSV: H=%.3f    S=%.3f    V=%.3f', ...
        info.hsv(1), info.hsv(2), info.hsv(3) )   );
    if info.skin==1
        set(handles.skin,'Value',1);
        set(handles.nonskin,'Value',0);
    else
        set(handles.skin,'Value',0);
        set(handles.nonskin,'Value',1);
    end
    %set background color
    set(handles.colorPreview,'BackgroundColor',info.rgb);
end
% guidata(hObject,handles);  
%update view info

% --- Executes during object creation, after setting all properties.
function labelListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to labelListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in skin.
function skin_Callback(hObject, eventdata, handles)
% hObject    handle to skin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of skin
set(handles.skin,'Value',1);
set(handles.nonskin,'Value',0);
updateSkinInfo(hObject,handles);


% --- Executes on button press in nonskin.
function nonskin_Callback(hObject, eventdata, handles)
% hObject    handle to nonskin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of nonskin
set(handles.skin,'Value',0);
set(handles.nonskin,'Value',1);
updateSkinInfo(hObject,handles);

function updateSkinInfo(hObject, handles)
sel = get(handles.labelListBox,'Value');
if(sel > 0)
    skinValue = get(handles.skin,'Value');
    handles.listBoxInfo(sel).skin = skinValue;
    listContent = get(handles.labelListBox,'String');
    itemStr = listContent(sel);
    if skinValue == 1
        itemStr = strrep(itemStr, 'N', 'S');
    else
        itemStr = strrep(itemStr, 'S', 'N');
    end
    listContent(sel) = itemStr;
    set(handles.labelListBox,'String',listContent);
    guidata(hObject,handles);
end
