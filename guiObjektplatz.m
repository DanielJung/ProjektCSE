function varargout = guiObjektplatz(varargin)
% GUIOBJEKTPLATZ MATLAB code for guiObjektplatz.fig
%      GUIOBJEKTPLATZ, by itself, creates a new GUIOBJEKTPLATZ or raises the existing
%      singleton*.
%
%      H = GUIOBJEKTPLATZ returns the handle to a new GUIOBJEKTPLATZ or the handle to
%      the existing singleton*.
%
%      GUIOBJEKTPLATZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIOBJEKTPLATZ.M with the given input arguments.
%
%      GUIOBJEKTPLATZ('Property','Value',...) creates a new GUIOBJEKTPLATZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiObjektplatz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiObjektplatz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiObjektplatz

% Last Modified by GUIDE v2.5 13-Jan-2015 03:34:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiObjektplatz_OpeningFcn, ...
                   'gui_OutputFcn',  @guiObjektplatz_OutputFcn, ...
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


% --- Executes just before guiObjektplatz is made visible.
function guiObjektplatz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiObjektplatz (see VARARGIN)

A = xlsread('koordinaten.xlsx');
x=A(1:10:end,1);
y=A(1:10:end,2);
s = street(x,y,.01);
[~, x, y, xr, yr, xl, yl] = s.getRouting(4);
plot(x,y,'r',xr,yr,'g',xl,yl,'b');
zoom on; 



% Choose default command line output for guiObjektplatz
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiObjektplatz wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guiObjektplatz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in objpos.
function objpos_Callback(hObject, eventdata, handles)

[x,y] = ginput(1);
set(handles.xtext,'String',strcat('x = ',num2str(x)));
set(handles.ytext,'String',strcat('y = ',num2str(y)));
hold on
plot(x,y,'r*')
% hObject    handle to objpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function obclass_Callback(hObject, eventdata, handles)
% hObject    handle to obclass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of obclass as text
%        str2double(get(hObject,'String')) returns contents of obclass as a double


% --- Executes during object creation, after setting all properties.
function obclass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obclass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function obstClass_Callback(hObject, eventdata, handles)
% hObject    handle to obstClass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of obstClass as text
%        str2double(get(hObject,'String')) returns contents of obstClass as a double


% --- Executes during object creation, after setting all properties.
function obstClass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obstClass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in uebernehmen.
function uebernehmen_Callback(hObject, eventdata, handles)
% hObject    handle to uebernehmen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function MClass_Callback(hObject, eventdata, handles)
% hObject    handle to MClass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MClass as text
%        str2double(get(hObject,'String')) returns contents of MClass as a double


% --- Executes during object creation, after setting all properties.
function MClass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MClass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in zoom_btn.
function zoom_btn_Callback(hObject, eventdata, handles)
% hObject    handle to zoom_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom on;
