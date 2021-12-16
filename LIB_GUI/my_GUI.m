function varargout = my_GUI(varargin)
% MY_GUI MATLAB code for my_GUI.fig
%      MY_GUI, by itself, creates a new MY_GUI or raises the existing
%      singleton*.
%
%      H = MY_GUI returns the handle to a new MY_GUI or the handle to
%      the existing singleton*.
%
%      MY_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MY_GUI.M with the given input arguments.
%
%      MY_GUI('Property','Value',...) creates a new MY_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before my_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to my_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help my_GUI

% Last Modified by GUIDE v2.5 01-Mar-2020 17:21:03

% Copyright: Huitian, YU

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @my_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @my_GUI_OutputFcn, ...
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


% --- Executes just before my_GUI is made visible.
function my_GUI_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<INUSL>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to my_GUI (see VARARGIN)

% Choose default command line output for my_GUI
handles.output = hObject;


% Adds paths of the current folder and its subfolders.
currentPath = pwd;
try
    nameParentPath = 'Matlab';
    position_parentPath = strfind(currentPath,nameParentPath);
    pathParent = currentPath(   1:...
                                position_parentPath(1) + ...
                                strlength(nameParentPath) - 1);
    addpath(genpath(pathParent))
    % save the parent path to handles as variable
    setappdata(0, 'pathParent',pathParent)
catch
    error(['You should be at least in the ',nameParentPath,' folder!'])
end

% Load all the parameters
my_parameter

% Initialize all components
my_Initialize


% Update handles structure
guidata(hObject, handles);


% UIWAIT makes my_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = my_GUI_OutputFcn(hObject, eventdata, handles)  %#ok<INUSL>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
