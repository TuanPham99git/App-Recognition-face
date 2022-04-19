function varargout = gui(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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



% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rows=112;
cols=92;
database_size=44;
files_in_each=10;


[filename pathname]=uigetfile('*','Test Image Select');
input_image=strcat(pathname,filename);


%input_image=preprocessing(rows,cols,input_image);
input_image=imread(input_image);

axes(handles.axes1); 
imshow(input_image);

%face_recognition(handles.rows,handles.cols,handles.database_size,handles.files_in_each,image);

handles.rows=rows;
handles.cols=cols;
handles.database_size=database_size;
handles.files_in_each=files_in_each;
handles.input_image=input_image;
handles.input_image2=input_image;
handles.faceDetect=1;
handles.isFaceDetected = 0;
guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%input_image=handles.input_image;
if(handles.faceDetect==1)
    [input_image, isFaceDetected]=face_detect(handles.input_image);
    input_image=preprocessing(handles.rows,handles.cols,input_image);
else
    input_image=preprocessing(handles.rows,handles.cols,handles.input_image);
    isFaceDetected = 0;
end
%input_image=imread(input_image);
image=input_image;

axes(handles.axes2); 
imshow(reshape(image,handles.rows,handles.cols));

handles.input_image3=image;
handles.isFaceDetected = isFaceDetected;
guidata(hObject, handles);
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.input_image3;
axes(handles.axes3); 
if handles.isFaceDetected==1
    face_recognition(handles.rows,handles.cols,handles.database_size,handles.files_in_each,image);
else
    temp_image = imread('no_face_detected.jpg');
    temp_image = preprocessing(handles.rows,handles.cols,temp_image);
    imshow(reshape(temp_image,handles.rows,handles.cols));
end
guidata(hObject, handles);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1

handles.faceDetect=get(hObject,'Value');
guidata(hObject, handles);
