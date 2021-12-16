function varargout = GUI(varargin)


% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the Other input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 21-Mar-2020 16:17:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

try
    str=pwd;
    if ispc
        index_dir=strfind(str,'\GUI');
    elseif isunix
        index_dir=strfind(str,'/GUI');
    else
        disp('Platform not supported')
    end
    str_temp=str(1:index_dir(end)-1);
    currentFolder = str_temp;
    addpath(genpath(currentFolder))
catch
    msgbox('The current folder is not ...\GUI')
    close(handles.figure1)
    error('The current folder is not ...\GUI')
end

global programState
    programState = 1;

setappdata(0,'popupmenuAM',[])
setappdata(0,'popupmenuCA',[])
setappdata(0,'popupmenuB',[])
setappdata(0,'popupmenuMedium',[])

set(handles.textA,'Visible','Off')
set(handles.editA,'Enable','Off')
set(handles.editA,'Visible','Off')
set(handles.editA,'String',[])
setappdata(0,'editA',[])

set(handles.textC,'Visible','Off')
set(handles.editC,'Enable','Off')
set(handles.editC,'Visible','Off')
set(handles.editC,'String',[])
setappdata(0,'editC',[])

set(handles.textE,'Visible','Off')
set(handles.editE,'Enable','Off')
set(handles.editE,'Visible','Off')
set(handles.editE,'String',[])
setappdata(0,'editE',[])

set(handles.textG,'Visible','Off')
set(handles.editG,'Enable','Off')
set(handles.editG,'Visible','Off')
set(handles.editG,'String',[])
setappdata(0,'editG',[])


set(handles.textModelAdd,'Visible','Off')
set(handles.popupmenuModelAdd,'Enable','Off')
set(handles.popupmenuModelAdd,'Visible','Off')
setappdata(0,'popupmenuModelAdd',[])
set(handles.editOtherModelAdd,'Enable','Off')
set(handles.editOtherModelAdd,'Visible','Off')
set(handles.editOtherModelAdd,'String',[])
setappdata(0,'editOtherModelAdd',[])

set(handles.textModeTortuosity,'Visible','Off')
set(handles.popupmenuModeTortuosity,'Enable','Off')
set(handles.popupmenuModeTortuosity,'Visible','Off')
setappdata(0,'popupmenuModeTortuosity',[])
set(handles.editOtherModeTortuosity,'Enable','Off')
set(handles.editOtherModeTortuosity,'Visible','Off')
set(handles.editOtherModeTortuosity,'String',[])
setappdata(0,'editOtherModeTortuosity',[])

set(handles.textResult,'Visible','Off')
set(handles.editResult,'Enable','Off')
set(handles.editResult,'Visible','Off')
set(handles.editResult,'String',[])
setappdata(0,'editResult',[])
set(handles.pushbuttonCalculation,'Visible','Off')
set(handles.pushbuttonCalculation,'Enable','Off')

set(handles.textFitting,'Visible','Off')

set(handles.radiobuttonFitting,'Visible','Off')
set(handles.radiobuttonFitting,'Enable','Off')
set(handles.radiobuttonFitting,'Value',[])


set(handles.popupmenuFittingA,'Visible','Off')
set(handles.popupmenuFittingA,'Enable','Off')
set(handles.popupmenuFittingA,'Value',[])
setappdata(0,'popupmenuFittingA',[])

set(handles.popupmenuFittingC,'Visible','Off')
set(handles.popupmenuFittingC,'Enable','Off')
set(handles.popupmenuFittingC,'Value',[])
setappdata(0,'popupmenuFittingC',[])

set(handles.popupmenuFittingE,'Visible','Off')
set(handles.popupmenuFittingE,'Enable','Off')
set(handles.popupmenuFittingE,'Value',[])
setappdata(0,'popupmenuFittingE',[])

set(handles.popupmenuFittingG,'Visible','Off')
set(handles.popupmenuFittingG,'Enable','Off')
set(handles.popupmenuFittingG,'Value',[])
setappdata(0,'popupmenuFittingG',[])

set(handles.textAFit,'Visible','Off')
strAFit = get(handles.popupmenuAFit,'String');
setappdata(0,'aFitList',strAFit)
set(handles.popupmenuAFit,'Enable','Off')
set(handles.popupmenuAFit,'Visible','Off') 
setappdata(0,'popupmenuAFit',[])
set(handles.editAFit,'Enable','Off')
set(handles.editAFit,'Visible','Off')
set(handles.editAFit,'String',[])
setappdata(0,'editAFit',[])

set(handles.textCFit,'Visible','Off')
strCFit = get(handles.popupmenuCFit,'String');
setappdata(0,'cFitList',strCFit)
set(handles.popupmenuCFit,'Enable','Off')
set(handles.popupmenuCFit,'Visible','Off') 
setappdata(0,'popupmenuCFit',[])
set(handles.editCFit,'Enable','Off')
set(handles.editCFit,'Visible','Off')
set(handles.editCFit,'String',[])
setappdata(0,'editCFit',[])

set(handles.textEFit,'Visible','Off')
strEFit = get(handles.popupmenuEFit,'String');
setappdata(0,'eFitList',strEFit)
set(handles.popupmenuEFit,'Enable','Off')
set(handles.popupmenuEFit,'Visible','Off') 
setappdata(0,'popupmenuEFit',[])
set(handles.editEFit,'Enable','Off')
set(handles.editEFit,'Visible','Off')
set(handles.editEFit,'String',[])
setappdata(0,'editEFit',[])

set(handles.textGFit,'Visible','Off')
strGFit = get(handles.popupmenuGFit,'String');
setappdata(0,'gFitList',strGFit)
set(handles.popupmenuGFit,'Enable','Off')
set(handles.popupmenuGFit,'Visible','Off') 
setappdata(0,'popupmenuGFit',[])
set(handles.editGFit,'Enable','Off')
set(handles.editGFit,'Visible','Off')
set(handles.editGFit,'String',[])
setappdata(0,'editGFit',[])

set(handles.pushbuttonFitting,'Visible','Off')
set(handles.pushbuttonFitting,'Enable','Off')

set(handles.textTickA,'Visible','Off')
set(handles.textTickC,'Visible','Off')
set(handles.textTickE,'Visible','Off')
set(handles.textTickG,'Visible','Off')

set(handles.figure1,'OuterPosition',[82.57 21 121 41],'Position',[82.57 21 121 41],'Color',[0.9 0.9 1])

set(handles.textWaitBar,'Position',[0 0 121 44])
setappdata(0,'backgroundColor',[61 89 171]/255)
set(handles.textWaitBar,'ForegroundColor',[0.9 0.9 1],'FontWeight','Bold','FontSize',15,'BackgroundColor',getappdata(0,'backgroundColor'))
set(handles.textWaitBar,'String',{[];[];[];...
    'Welcome to using the panel of the lithium ion battery';[];[];[];[];[];...
    '          =          ';'        = =          ';'      = = =          ';'    = = = =          ';'  =   =   =   =   =  ';...
    '          = = = =    ';'          = = =      ';'          = =        ';'          =          ';...
    [];[];[];[];'Please RIGHT CLICK any location on this panel'})

% water mark
set(handles.textCopyRight,'ForegroundColor',[0.92 0.92 1],'FontWeight','Bold','FontSize',10,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[89 38.5 30 2.2],'OuterPosition',[89 38.5 30 2.2],'Position',[89 38.5 30 2.2],'HorizontalAlignment', 'Center')

set(handles.axesModel,'InnerPosition',[72 17.5 60 12],'OuterPosition',[72 17.5 60 12],'Position',[72 17.5 60 12],'Visible','Off')

set(handles.textComponents,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',10,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[1 38 40 1.5],'OuterPosition',[1 38 40 1.5],'Position',[1 38 40 1.5],'HorizontalAlignment', 'Left')
set(handles.textLambda,'ForegroundColor',[0.5 0.5 0.5],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[50 36 23 4],'OuterPosition',[60 36 23 4],'Position',[60 36 23 4],'HorizontalAlignment', 'Center')
set(handles.popupmenuFractionType,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[85 36 27 1.5],'OuterPosition',[85 36 27 1.5],'Position',[85 36 27 1.5],'HorizontalAlignment', 'Left')

set(handles.textAM,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[10 34 23 1.5],'OuterPosition',[10 34 23 1.5],'Position',[10 34 23 1.5],'HorizontalAlignment', 'Left')
set(handles.popupmenuAM,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[35 34 23 1.5],'OuterPosition',[35 34 23 1.5],'Position',[35 34 23 1.5],'HorizontalAlignment', 'Left')
set(handles.editOtherAM,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[60 34 23 1.5],'OuterPosition',[60 34 23 1.5],'Position',[60 34 23 1.5],'HorizontalAlignment', 'Center')
set(handles.editAM,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[85 34 23 1.5],'OuterPosition',[85 34 23 1.5],'Position',[85 34 23 1.5],'HorizontalAlignment', 'Center')
set(handles.textFractionAM,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[109 34 2 1.25],'OuterPosition',[109 34 2 1.25],'Position',[109 34 2 1.25],'HorizontalAlignment', 'Left')

set(handles.textCA,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[10 32 23 1.5],'OuterPosition',[10 32 23 1.5],'Position',[10 32 23 1.5],'HorizontalAlignment', 'Left')
set(handles.popupmenuCA,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[35 32 23 1.5],'OuterPosition',[35 32 23 1.5],'Position',[35 32 23 1.5],'HorizontalAlignment', 'Left')
set(handles.editOtherCA,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[60 32 23 1.5],'OuterPosition',[60 32 23 1.5],'Position',[60 32 23 1.5],'HorizontalAlignment', 'Center')
set(handles.editCA,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[85 32 23 1.5],'OuterPosition',[85 32 23 1.5],'Position',[85 32 23 1.5],'HorizontalAlignment', 'Center')
set(handles.textFractionCA,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[109 32 2 1.25],'OuterPosition',[109 32 2 1.25],'Position',[109 32 2 1.25],'HorizontalAlignment', 'Left')

set(handles.textB,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[10 30 23 1.5],'OuterPosition',[10 30 23 1.5],'Position',[10 30 23 1.5],'HorizontalAlignment', 'Left')
set(handles.popupmenuB,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[35 30 23 1.5],'OuterPosition',[35 30 23 1.5],'Position',[35 30 23 1.5],'HorizontalAlignment', 'Left')
set(handles.editOtherB,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[60 30 23 1.5],'OuterPosition',[60 30 23 1.5],'Position',[60 30 23 1.5],'HorizontalAlignment', 'Center')
set(handles.editB,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[85 30 23 1.5],'OuterPosition',[85 30 23 1.5],'Position',[85 30 23 1.5],'HorizontalAlignment', 'Center')
set(handles.textFractionB,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[109 30 2 1.25],'OuterPosition',[109 30 2 1.25],'Position',[109 30 2 1.25],'HorizontalAlignment', 'Left')

set(handles.textMedium,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[10 28 23 1.5],'OuterPosition',[10 28 23 1.5],'Position',[10 28 23 1.5],'HorizontalAlignment', 'Left')
set(handles.popupmenuMedium,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[35 28 23 1.5],'OuterPosition',[35 28 23 1.5],'Position',[35 28 23 1.5],'HorizontalAlignment', 'Left')
set(handles.editOtherMedium,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[60 28 23 1.5],'OuterPosition',[60 28 23 1.5],'Position',[60 28 23 1.5],'HorizontalAlignment', 'Center')

set(handles.textPorosity,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[10 26 23 1.5],'OuterPosition',[10 26 23 1.5],'Position',[10 26 23 1.5],'HorizontalAlignment', 'Left')
set(handles.editPorosity,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[35 26 23 1.5],'OuterPosition',[35 26 23 1.5],'Position',[35 26 23 1.5],'HorizontalAlignment', 'Center')
set(handles.textFractionPorosity,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[59 26 2 1.25],'OuterPosition',[59 26 2 1.25],'Position',[59 26 2 1.25],'HorizontalAlignment', 'Left')


set(handles.textModels,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',10,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[1 24 40 1.5],'OuterPosition',[1 24 40 1.5],'Position',[1 24 40 1.5],'HorizontalAlignment', 'Left')

set(handles.textModel,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[10 22 23 1.5],'OuterPosition',[10 22 23 1.5],'Position',[10 22 23 1.5],'HorizontalAlignment', 'Left')
set(handles.popupmenuModel,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[35 22 38 1.5],'OuterPosition',[35 22 38 1.5],'Position',[35 22 38 1.5],'HorizontalAlignment', 'Left')

set(handles.textModeTortuosity,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[10 20 23 1.5],'OuterPosition',[10 20 23 1.5],'Position',[10 20 23 1.5],'HorizontalAlignment', 'Left')
set(handles.popupmenuModeTortuosity,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[35 20 23 1.5],'OuterPosition',[35 20 23 1.5],'Position',[35 20 23 1.5],'HorizontalAlignment', 'Left')
set(handles.editOtherModeTortuosity,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[60 20 23 1.5],'OuterPosition',[60 20 23 1.5],'Position',[60 20 23 1.5],'HorizontalAlignment', 'Center')
   
set(handles.textModelAdd,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[10 18 23 1.5],'OuterPosition',[10 18 23 1.5],'Position',[10 18 23 1.5],'HorizontalAlignment', 'Left')
set(handles.popupmenuModelAdd,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[35 18 23 1.5],'OuterPosition',[35 18 23 1.5],'Position',[35 18 23 1.5],'HorizontalAlignment', 'Left')
set(handles.editOtherModelAdd,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[60 18 23 1.5],'OuterPosition',[60 18 23 1.5],'Position',[60 18 23 1.5],'HorizontalAlignment', 'Center')

set(handles.textA,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[10 16 9 1.5],'OuterPosition',[10 16 9 1.5],'Position',[10 16 9 1.5],'HorizontalAlignment', 'Left')
set(handles.editA,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[20 16 9 1.5],'OuterPosition',[20 16 9 1.5],'Position',[20 16 9 1.5],'HorizontalAlignment', 'Center')

set(handles.textC,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[35 16 9 1.5],'OuterPosition',[35 16 9 1.5],'Position',[35 16 9 1.5],'HorizontalAlignment', 'Left')
set(handles.editC,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[45 16 9 1.5],'OuterPosition',[45 16 9 1.5],'Position',[45 16 9 1.5],'HorizontalAlignment', 'Center')

set(handles.textE,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[60 16 9 1.5],'OuterPosition',[60 16 9 1.5],'Position',[60 16 9 1.5],'HorizontalAlignment', 'Left')
set(handles.editE,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[70 16 9 1.5],'OuterPosition',[70 16 9 1.5],'Position',[70 16 9 1.5],'HorizontalAlignment', 'Center')

set(handles.textG,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[85 16 9 1.5],'OuterPosition',[85 16 9 1.5],'Position',[85 16 9 1.5],'HorizontalAlignment', 'Left')
set(handles.editG,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[95 16 9 1.5],'OuterPosition',[95 16 9 1.5],'Position',[95 16 9 1.5],'HorizontalAlignment', 'Center')

set(handles.textResult,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[10 14 48 1.5],'OuterPosition',[10 14 48 1.5],'Position',[10 14 48 1.5],'HorizontalAlignment', 'Left')
set(handles.editResult,'ForegroundColor',[0 0.45 0.74],'FontWeight','Bold','FontSize',9,'BackgroundColor',[1 0.8 1],'InnerPosition',[60 14 23 1.5],'OuterPosition',[60 14 23 1.5],'Position',[60 14 23 1.5],'HorizontalAlignment', 'Center')
set(handles.pushbuttonCalculation,'ForegroundColor',[1 1 1],'FontWeight','Bold','FontSize',9,'BackgroundColor',[0.3 0.75 0.75],'InnerPosition',[100 14 18 1.5],'OuterPosition',[100 14 18 1.5],'Position',[100 14 18 1.5],'HorizontalAlignment', 'Center')

set(handles.radiobuttonFitting,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[1 12 10 1],'OuterPosition',[1 12 10 1],'Position',[1 12 10 1],'HorizontalAlignment', 'Left')

set(handles.textFitting,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',10,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[1 10 40 1.5],'OuterPosition',[1 10 40 1.5],'Position',[1 10 40 1.5],'HorizontalAlignment', 'Left')

set(handles.textTickA,'ForegroundColor',[1 0.2 0.2],'FontWeight','Bold','FontSize',14,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[7 8 3 1.75],'OuterPosition',[7 8 3 1.75],'Position',[7 8 3 1.75],'HorizontalAlignment', 'Left')
set(handles.textAFit,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[10 8 4 1.5],'OuterPosition',[10 8 4 1.5],'Position',[10 8 4 1.5],'HorizontalAlignment', 'Left')
set(handles.popupmenuAFit,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[15 8 28 1.5],'OuterPosition',[15 8 28 1.5],'Position',[15 8 28 1.5],'HorizontalAlignment', 'Left')
set(handles.editAFit,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[45 8 53 1.5],'OuterPosition',[45 8 53 1.5],'Position',[45 8 53 1.5],'HorizontalAlignment', 'Center')
set(handles.popupmenuFittingA,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[100 8 15 1.5],'OuterPosition',[100 8 15 1.5],'Position',[100 8 15 1.5],'HorizontalAlignment', 'Left')

set(handles.textTickC,'ForegroundColor',[1 0.2 0.2],'FontWeight','Bold','FontSize',14,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[7 6 3 1.75],'OuterPosition',[7 6 3 1.75],'Position',[7 6 3 1.75],'HorizontalAlignment', 'Left')
set(handles.textCFit,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[10 6 4 1.5],'OuterPosition',[10 6 4 1.5],'Position',[10 6 4 1.5],'HorizontalAlignment', 'Left')
set(handles.popupmenuCFit,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[15 6 28 1.5],'OuterPosition',[15 6 28 1.5],'Position',[15 6 28 1.5],'HorizontalAlignment', 'Left')
set(handles.editCFit,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[45 6 53 1.5],'OuterPosition',[45 6 53 1.5],'Position',[45 6 53 1.5],'HorizontalAlignment', 'Center')
set(handles.popupmenuFittingC,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[100 6 15 1.5],'OuterPosition',[100 6 15 1.5],'Position',[100 6 15 1.5],'HorizontalAlignment', 'Left')

set(handles.textTickE,'ForegroundColor',[1 0.2 0.2],'FontWeight','Bold','FontSize',14,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[7 4 3 1.75],'OuterPosition',[7 4 3 1.75],'Position',[7 4 3 1.75],'HorizontalAlignment', 'Left')
set(handles.textEFit,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[10 4 4 1.5],'OuterPosition',[10 4 4 1.5],'Position',[10 4 4 1.5],'HorizontalAlignment', 'Left')
set(handles.popupmenuEFit,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[15 4 28 1.5],'OuterPosition',[15 4 28 1.5],'Position',[15 4 28 1.5],'HorizontalAlignment', 'Left')
set(handles.editEFit,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[45 4 53 1.5],'OuterPosition',[45 4 53 1.5],'Position',[45 4 53 1.5],'HorizontalAlignment', 'Center')
set(handles.popupmenuFittingE,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[100 4 15 1.5],'OuterPosition',[100 4 15 1.5],'Position',[100 4 15 1.5],'HorizontalAlignment', 'Left')

set(handles.textTickG,'ForegroundColor',[1 0.2 0.2],'FontWeight','Bold','FontSize',14,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[7 2 3 1.75],'OuterPosition',[7 2 3 1.75],'Position',[7 2 3 1.75],'HorizontalAlignment', 'Left')
set(handles.textGFit,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[0.9 0.9 1],'InnerPosition',[10 2 4 1.5],'OuterPosition',[10 2 4 1.5],'Position',[10 2 4 1.5],'HorizontalAlignment', 'Left')
set(handles.popupmenuGFit,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[15 2 28 1.5],'OuterPosition',[15 2 28 1.5],'Position',[15 2 28 1.5],'HorizontalAlignment', 'Left')
set(handles.editGFit,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[45 2 53 1.5],'OuterPosition',[45 2 53 1.5],'Position',[45 2 53 1.5],'HorizontalAlignment', 'Center')
set(handles.popupmenuFittingG,'ForegroundColor',[0 0.15 0.3],'FontWeight','Bold','FontSize',8,'BackgroundColor',[1 0.9 1],'InnerPosition',[100 2 15 1.5],'OuterPosition',[100 2 15 1.5],'Position',[100 2 15 1.5],'HorizontalAlignment', 'Left')

set(handles.pushbuttonFitting,'ForegroundColor',[1 1 1],'FontWeight','Bold','FontSize',9,'BackgroundColor',[0.3 0.75 0.75],'InnerPosition',[100 10 18 1.5],'OuterPosition',[100 10 18 1.5],'Position',[100 10 18 1.5],'HorizontalAlignment', 'Center')

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on selection change in popupmenuModel.
function popupmenuModel_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuModel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuModel
numModel = get(handles.popupmenuModel,'Value');
strModel = get(handles.popupmenuModel,'String');
setappdata(0,'popupmenuModel',strModel(numModel))
if numModel == 1
    cla(handles.axesModel,'reset');
    set(handles.axesModel,'InnerPosition',[72 17.5 60 12],'OuterPosition',[72 17.5 60 12],'Position',[72 17.5 60 12],'Visible','Off')
    set(handles.textA,'Visible','Off')
    set(handles.editA,'Enable','Off')
    set(handles.editA,'Visible','Off')
    set(handles.editA,'String',[])
    setappdata(0,'editA',[])

    
    set(handles.textC,'Visible','Off')
    set(handles.editC,'Enable','Off')
    set(handles.editC,'Visible','Off')
    set(handles.editC,'String',[])
    setappdata(0,'editC',[])


    set(handles.textE,'Visible','Off')
    set(handles.editE,'Enable','Off')
    set(handles.editE,'Visible','Off')
    set(handles.editE,'String',[])
    setappdata(0,'editE',[])


    set(handles.textG,'Visible','Off')
    set(handles.editG,'Enable','Off')
    set(handles.editG,'Visible','Off')
    set(handles.editG,'String',[])
    setappdata(0,'editG',[])

    
    set(handles.textModelAdd,'Visible','Off')
    set(handles.popupmenuModelAdd,'Value',1)
    set(handles.popupmenuModelAdd,'Enable','Off')
    set(handles.popupmenuModelAdd,'Visible','Off')
    setappdata(0,'popupmenuModelAdd',[])

    
    set(handles.editOtherModelAdd,'Visible','Off')
    set(handles.editOtherModelAdd,'String',[])
    setappdata(0,'editOtherModelAdd',[])
       

    set(handles.textModeTortuosity,'Visible','Off')
    set(handles.popupmenuModeTortuosity,'Value',1)
    set(handles.popupmenuModeTortuosity,'Enable','Off')
    set(handles.popupmenuModeTortuosity,'Visible','Off')
    setappdata(0,'popupmenuModeTortuosity',[])

    
    set(handles.editOtherModeTortuosity,'Visible','Off')
    set(handles.editOtherModeTortuosity,'String',[])
    setappdata(0,'editOtherModeTortuosity',[])
    
    set(handles.textResult,'Visible','Off')
    set(handles.editResult,'Enable','Off')
    set(handles.editResult,'Visible','Off')
    set(handles.editResult,'String',[])
    setappdata(0,'editResult',[])
    set(handles.pushbuttonCalculation,'Visible','Off')
    set(handles.pushbuttonCalculation,'Enable','Off')
    
    set(handles.textFitting,'Visible','Off')
    set(handles.radiobuttonFitting,'Visible','Off')
    set(handles.radiobuttonFitting,'Enable','Off')
    set(handles.radiobuttonFitting,'Value',[])
    set(handles.popupmenuFittingA,'Visible','Off')
    set(handles.popupmenuFittingA,'Enable','Off')
    set(handles.popupmenuFittingA,'Value',[])
    setappdata(0,'popupmenuFittingA',[])
    
    set(handles.popupmenuFittingC,'Visible','Off')
    set(handles.popupmenuFittingC,'Enable','Off')
    set(handles.popupmenuFittingC,'Value',[])
    setappdata(0,'popupmenuFittingC',[])

    set(handles.popupmenuFittingE,'Visible','Off')
    set(handles.popupmenuFittingE,'Enable','Off')
    set(handles.popupmenuFittingE,'Value',[])
    setappdata(0,'popupmenuFittingE',[])

    set(handles.popupmenuFittingG,'Visible','Off')
    set(handles.popupmenuFittingG,'Enable','Off')
    set(handles.popupmenuFittingG,'Value',[])
    setappdata(0,'popupmenuFittingG',[])
    
    set(handles.textAFit,'Visible','Off')
    set(handles.popupmenuAFit,'Enable','Off')
    set(handles.popupmenuAFit,'Visible','Off') 
    setappdata(0,'popupmenuAFit',[])
    set(handles.editAFit,'Enable','Off')
    set(handles.editAFit,'Visible','Off')
    set(handles.editAFit,'String',[])
    setappdata(0,'editAFit',[])

    set(handles.textCFit,'Visible','Off')
    set(handles.popupmenuCFit,'Enable','Off')
    set(handles.popupmenuCFit,'Visible','Off') 
    setappdata(0,'popupmenuCFit',[])
    set(handles.editCFit,'Enable','Off')
    set(handles.editCFit,'Visible','Off')
    set(handles.editCFit,'String',[])
    setappdata(0,'editCFit',[])

    set(handles.textEFit,'Visible','Off')
    set(handles.popupmenuEFit,'Enable','Off')
    set(handles.popupmenuEFit,'Visible','Off') 
    setappdata(0,'popupmenuEFit',[])
    set(handles.editEFit,'Enable','Off')
    set(handles.editEFit,'Visible','Off')
    set(handles.editEFit,'String',[])
    setappdata(0,'editEFit',[])

    set(handles.textGFit,'Visible','Off')
    set(handles.popupmenuGFit,'Enable','Off')
    set(handles.popupmenuGFit,'Visible','Off') 
    setappdata(0,'popupmenuGFit',[])
    set(handles.editGFit,'Enable','Off')
    set(handles.editGFit,'Visible','Off')
    set(handles.editGFit,'String',[])
    setappdata(0,'editGFit',[])

    set(handles.pushbuttonFitting,'Visible','Off')
    set(handles.pushbuttonFitting,'Enable','Off')
    
    set(handles.textTickA,'Visible','Off')
    set(handles.textTickC,'Visible','Off')
    set(handles.textTickE,'Visible','Off')
    set(handles.textTickG,'Visible','Off')
elseif numModel == 2
    
    if isempty(getappdata(0,'popupmenuAM')) || ~strcmp(getappdata(0,'popupmenuAM'),'PolyAM')
        set(handles.axesModel,'Visible','On')
        axes(handles.axesModel)
        if ispc
            imshow(imread('figures\ZBS.bmp'))
        elseif isunix
            imshow(imread('figures/ZBS.bmp'))
        else
            disp('Platform not supported')
        end
        set(handles.textA,'Visible','On')
        set(handles.editA,'Enable','On')
        set(handles.editA,'Visible','On')
        set(handles.editA,'String',num2str(0))
        setappdata(0,'editA',0)


        set(handles.textC,'Visible','On')
        set(handles.editC,'Enable','On')
        set(handles.editC,'Visible','On')
        set(handles.editC,'String',num2str(0))
        setappdata(0,'editC',0)


        set(handles.textE,'Visible','On')
        set(handles.editE,'Enable','On')
        set(handles.editE,'Visible','On')
        set(handles.editE,'String',num2str(0))
        setappdata(0,'editE',0)


        set(handles.textG,'Visible','On')
        set(handles.editG,'Enable','On')
        set(handles.editG,'Visible','On')
        set(handles.editG,'String',num2str(0))
        setappdata(0,'editG',0)


        set(handles.textModelAdd,'Visible','On')
        set(handles.popupmenuModelAdd,'Value',1)
        set(handles.popupmenuModelAdd,'Enable','On')
        set(handles.popupmenuModelAdd,'Visible','On')
        setappdata(0,'popupmenuModelAdd',[])

        set(handles.editOtherModelAdd,'Visible','Off')
        set(handles.editOtherModelAdd,'String',[])
        setappdata(0,'editOtherModelAdd',[])



        set(handles.textModeTortuosity,'Visible','On')
        set(handles.popupmenuModeTortuosity,'Value',1)
        set(handles.popupmenuModeTortuosity,'Enable','On')
        set(handles.popupmenuModeTortuosity,'Visible','On')
        setappdata(0,'popupmenuModeTortuosity',[])


        set(handles.editOtherModeTortuosity,'Visible','Off')
        set(handles.editOtherModeTortuosity,'String',[])
        setappdata(0,'editOtherModeTortuosity',[])
        set(handles.popupmenuFittingA,'Visible','Off')
        set(handles.popupmenuFittingA,'Enable','Off')

        set(handles.textResult,'Visible','On')
        set(handles.editResult,'Enable','On')
        set(handles.editResult,'Visible','On')
        set(handles.editResult,'String','Result')
        setappdata(0,'editResult',[])
        set(handles.pushbuttonCalculation,'Visible','On')
        set(handles.pushbuttonCalculation,'Enable','On')

        set(handles.textFitting,'Visible','Off')
        set(handles.radiobuttonFitting,'Visible','On')
        set(handles.radiobuttonFitting,'Enable','On')
        set(handles.radiobuttonFitting,'Value',0)
        set(handles.popupmenuFittingA,'Visible','Off')
        set(handles.popupmenuFittingA,'Enable','Off')
        set(handles.popupmenuFittingA,'Value',[])
        setappdata(0,'popupmenuFittingA',[])

        set(handles.popupmenuFittingC,'Visible','Off')
        set(handles.popupmenuFittingC,'Enable','Off')
        set(handles.popupmenuFittingC,'Value',[])
        setappdata(0,'popupmenuFittingC',[])

        set(handles.popupmenuFittingE,'Visible','Off')
        set(handles.popupmenuFittingE,'Enable','Off')
        set(handles.popupmenuFittingE,'Value',[])
        setappdata(0,'popupmenuFittingE',[])

        set(handles.popupmenuFittingG,'Visible','Off')
        set(handles.popupmenuFittingG,'Enable','Off')
        set(handles.popupmenuFittingG,'Value',[])
        setappdata(0,'popupmenuFittingG',[])

        set(handles.textAFit,'Visible','Off')
        strAFit = getappdata(0,'aFitList');
        set(handles.popupmenuAFit,'String',strAFit)
        set(handles.popupmenuAFit,'Value',1)
        set(handles.popupmenuAFit,'Enable','Off')
        set(handles.popupmenuAFit,'Visible','Off') 
        setappdata(0,'popupmenuAFit',[])
        set(handles.editAFit,'Enable','Off')
        set(handles.editAFit,'Visible','Off')
        set(handles.editAFit,'String',[])
        setappdata(0,'editAFit',[])

        set(handles.textCFit,'Visible','Off')
        strCFit = getappdata(0,'cFitList');
        set(handles.popupmenuCFit,'String',strCFit)
        set(handles.popupmenuCFit,'Value',1)
        set(handles.popupmenuCFit,'Enable','Off')
        set(handles.popupmenuCFit,'Visible','Off') 
        setappdata(0,'popupmenuCFit',[])
        set(handles.editCFit,'Enable','Off')
        set(handles.editCFit,'Visible','Off')
        set(handles.editCFit,'String',[])
        setappdata(0,'editCFit',[])

        set(handles.textEFit,'Visible','Off')
        strEFit = getappdata(0,'eFitList');
        set(handles.popupmenuEFit,'String',strEFit)
        set(handles.popupmenuEFit,'Value',1)
        set(handles.popupmenuEFit,'Enable','Off')
        set(handles.popupmenuEFit,'Visible','Off') 
        setappdata(0,'popupmenuEFit',[])
        set(handles.editEFit,'Enable','Off')
        set(handles.editEFit,'Visible','Off')
        set(handles.editEFit,'String',[])
        setappdata(0,'editEFit',[])

        set(handles.textGFit,'Visible','Off')
        strGFit = getappdata(0,'gFitList');
        set(handles.popupmenuGFit,'String',strGFit)
        set(handles.popupmenuGFit,'Value',1)
        set(handles.popupmenuGFit,'Enable','Off')
        set(handles.popupmenuGFit,'Visible','Off') 
        setappdata(0,'popupmenuGFit',[])
        set(handles.editGFit,'Enable','Off')
        set(handles.editGFit,'Visible','Off')
        set(handles.editGFit,'String',[])
        setappdata(0,'editGFit',[])

        set(handles.pushbuttonFitting,'Visible','Off')
        set(handles.pushbuttonFitting,'Enable','Off')

        set(handles.textTickA,'Visible','Off')
        set(handles.textTickC,'Visible','Off')
        set(handles.textTickE,'Visible','Off')
        set(handles.textTickG,'Visible','Off')
    else
        msgbox('This model is not valid in this case.')
        set(handles.popupmenuModel,'Value',1)
    end    
elseif numModel == 3
    if isempty(getappdata(0,'popupmenuAM')) || ~strcmp(getappdata(0,'popupmenuAM'),'PolyAM')
        set(handles.axesModel,'Visible','On')
        axes(handles.axesModel)
        if ispc
            imshow(imread('figures\ZBS_modified.bmp'))
        elseif isunix
            imshow(imread('figures/ZBS_modified.bmp'))
        else
            disp('Platform not supported')
        end

        set(handles.textA,'Visible','On')
        set(handles.editA,'Enable','On')
        set(handles.editA,'Visible','On')
        set(handles.editA,'String',num2str(0))
        setappdata(0,'editA',0)


        set(handles.textC,'Visible','On')
        set(handles.editC,'Enable','On')
        set(handles.editC,'Visible','On')
        set(handles.editC,'String',num2str(0))
        setappdata(0,'editC',0)


        set(handles.textE,'Visible','On')
        set(handles.editE,'Enable','On')
        set(handles.editE,'Visible','On')
        set(handles.editE,'String',num2str(0))
        setappdata(0,'editE',0)


        set(handles.textG,'Visible','On')
        set(handles.editG,'Enable','On')
        set(handles.editG,'Visible','On')
        set(handles.editG,'String',num2str(0))
        setappdata(0,'editG',0)


        set(handles.textModelAdd,'Visible','On')
        set(handles.popupmenuModelAdd,'Value',1)
        set(handles.popupmenuModelAdd,'Enable','On')
        set(handles.popupmenuModelAdd,'Visible','On')
        setappdata(0,'popupmenuModelAdd',[])

        set(handles.editOtherModelAdd,'Visible','Off')
        set(handles.editOtherModelAdd,'String',[])
        setappdata(0,'editOtherModelAdd',[])



        set(handles.textModeTortuosity,'Visible','On')
        set(handles.popupmenuModeTortuosity,'Value',1)
        set(handles.popupmenuModeTortuosity,'Enable','On')
        set(handles.popupmenuModeTortuosity,'Visible','On')
        setappdata(0,'popupmenuModeTortuosity',[])


        set(handles.editOtherModeTortuosity,'Visible','Off')
        set(handles.editOtherModeTortuosity,'String',[])
        setappdata(0,'editOtherModeTortuosity',[])
        set(handles.popupmenuFittingA,'Visible','Off')
        set(handles.popupmenuFittingA,'Enable','Off')

        set(handles.textResult,'Visible','On')
        set(handles.editResult,'Enable','On')
        set(handles.editResult,'Visible','On')
        set(handles.editResult,'String','Result')
        setappdata(0,'editResult',[])
        set(handles.pushbuttonCalculation,'Visible','On')
        set(handles.pushbuttonCalculation,'Enable','On')

        set(handles.textFitting,'Visible','Off')
        set(handles.radiobuttonFitting,'Visible','On')
        set(handles.radiobuttonFitting,'Enable','On')
        set(handles.radiobuttonFitting,'Value',0)
        set(handles.popupmenuFittingA,'Visible','Off')
        set(handles.popupmenuFittingA,'Enable','Off')
        set(handles.popupmenuFittingA,'Value',[])
        setappdata(0,'popupmenuFittingA',[])

        set(handles.popupmenuFittingC,'Visible','Off')
        set(handles.popupmenuFittingC,'Enable','Off')
        set(handles.popupmenuFittingC,'Value',[])
        setappdata(0,'popupmenuFittingC',[])

        set(handles.popupmenuFittingE,'Visible','Off')
        set(handles.popupmenuFittingE,'Enable','Off')
        set(handles.popupmenuFittingE,'Value',[])
        setappdata(0,'popupmenuFittingE',[])

        set(handles.popupmenuFittingG,'Visible','Off')
        set(handles.popupmenuFittingG,'Enable','Off')
        set(handles.popupmenuFittingG,'Value',[])
        setappdata(0,'popupmenuFittingG',[])

        set(handles.textAFit,'Visible','Off')
        strAFit = getappdata(0,'aFitList');
        set(handles.popupmenuAFit,'String',strAFit)
        set(handles.popupmenuAFit,'Value',1)
        set(handles.popupmenuAFit,'Enable','Off')
        set(handles.popupmenuAFit,'Visible','Off') 
        setappdata(0,'popupmenuAFit',[])
        set(handles.editAFit,'Enable','Off')
        set(handles.editAFit,'Visible','Off')
        set(handles.editAFit,'String',[])
        setappdata(0,'editAFit',[])

        set(handles.textCFit,'Visible','Off')
        strCFit = getappdata(0,'cFitList');
        set(handles.popupmenuCFit,'String',strCFit)
        set(handles.popupmenuCFit,'Value',1)
        set(handles.popupmenuCFit,'Enable','Off')
        set(handles.popupmenuCFit,'Visible','Off') 
        setappdata(0,'popupmenuCFit',[])
        set(handles.editCFit,'Enable','Off')
        set(handles.editCFit,'Visible','Off')
        set(handles.editCFit,'String',[])
        setappdata(0,'editCFit',[])

        set(handles.textEFit,'Visible','Off')
        strEFit = getappdata(0,'eFitList');
        set(handles.popupmenuEFit,'String',strEFit)
        set(handles.popupmenuEFit,'Value',1)
        set(handles.popupmenuEFit,'Enable','Off')
        set(handles.popupmenuEFit,'Visible','Off') 
        setappdata(0,'popupmenuEFit',[])
        set(handles.editEFit,'Enable','Off')
        set(handles.editEFit,'Visible','Off')
        set(handles.editEFit,'String',[])
        setappdata(0,'editEFit',[])

        set(handles.textGFit,'Visible','Off')
        strGFit = getappdata(0,'gFitList');
        set(handles.popupmenuGFit,'String',strGFit)
        set(handles.popupmenuGFit,'Value',1)
        set(handles.popupmenuGFit,'Enable','Off')
        set(handles.popupmenuGFit,'Visible','Off') 
        setappdata(0,'popupmenuGFit',[])
        set(handles.editGFit,'Enable','Off')
        set(handles.editGFit,'Visible','Off')
        set(handles.editGFit,'String',[])
        setappdata(0,'editGFit',[])

        set(handles.pushbuttonFitting,'Visible','Off')
        set(handles.pushbuttonFitting,'Enable','Off')

        set(handles.textTickA,'Visible','Off')
        set(handles.textTickC,'Visible','Off')
        set(handles.textTickE,'Visible','Off')
        set(handles.textTickG,'Visible','Off')
    else
        msgbox('This model is not valid in this case.')
        set(handles.popupmenuModel,'Value',1)
    end
    
elseif numModel == 4
    if isempty(getappdata(0,'popupmenuAM')) || ~strcmp(getappdata(0,'popupmenuAM'),'PolyAM')
        set(handles.axesModel,'Visible','On')
        axes(handles.axesModel)
        if ispc
            imshow(imread('figures\RNM1.bmp'))
        elseif isunix
            imshow(imread('figures/RNM1.bmp'))
        else
            disp('Platform not supported')
        end

        set(handles.textA,'Visible','On')
        set(handles.editA,'Enable','On')
        set(handles.editA,'Visible','On')
        set(handles.editA,'String',num2str(0))
        setappdata(0,'editA',0)


        set(handles.textC,'Visible','Off')    
        set(handles.editC,'Enable','Off')
        set(handles.editC,'Visible','Off')
        setappdata(0,'editC',[])


        set(handles.textE,'Visible','Off')    
        set(handles.editE,'Enable','Off')
        set(handles.editE,'Visible','Off')
        setappdata(0,'editE',[])



        set(handles.textG,'Visible','Off')    
        set(handles.editG,'Enable','Off')
        set(handles.editG,'Visible','Off')
        setappdata(0,'editG',[])


        set(handles.textModelAdd,'Visible','Off')
        set(handles.popupmenuModelAdd,'Value',1)
        set(handles.popupmenuModelAdd,'Enable','Off')
        set(handles.popupmenuModelAdd,'Visible','Off')
        setappdata(0,'popupmenuModelAdd',[])


        set(handles.editOtherModelAdd,'Visible','Off')
        set(handles.editOtherModelAdd,'String',[])
        setappdata(0,'editOtherModelAdd',[])


        set(handles.textModeTortuosity,'Visible','On')
        set(handles.popupmenuModeTortuosity,'Value',1)
        set(handles.popupmenuModeTortuosity,'Enable','On')
        set(handles.popupmenuModeTortuosity,'Visible','On')
        setappdata(0,'popupmenuModeTortuosity',[])


        set(handles.editOtherModeTortuosity,'Visible','Off')
        set(handles.editOtherModeTortuosity,'String',[])
        setappdata(0,'editOtherModeTortuosity',[])

        set(handles.textResult,'Visible','On')
        set(handles.editResult,'Enable','On')
        set(handles.editResult,'Visible','On')
        set(handles.editResult,'String','Result')
        setappdata(0,'editResult',[])
        set(handles.pushbuttonCalculation,'Visible','On')
        set(handles.pushbuttonCalculation,'Enable','On')

        set(handles.textFitting,'Visible','Off')
        set(handles.radiobuttonFitting,'Visible','Off')
        set(handles.radiobuttonFitting,'Enable','Off')
        set(handles.radiobuttonFitting,'Value',[])
        set(handles.popupmenuFittingA,'Visible','Off')
        set(handles.popupmenuFittingA,'Enable','Off')
        set(handles.popupmenuFittingA,'Value',[])
        setappdata(0,'popupmenuFittingA',[])

        set(handles.popupmenuFittingC,'Visible','Off')
        set(handles.popupmenuFittingC,'Enable','Off')
        set(handles.popupmenuFittingC,'Value',[])
        setappdata(0,'popupmenuFittingC',[])

        set(handles.popupmenuFittingE,'Visible','Off')
        set(handles.popupmenuFittingE,'Enable','Off')
        set(handles.popupmenuFittingE,'Value',[])
        setappdata(0,'popupmenuFittingE',[])

        set(handles.popupmenuFittingG,'Visible','Off')
        set(handles.popupmenuFittingG,'Enable','Off')
        set(handles.popupmenuFittingG,'Value',[])
        setappdata(0,'popupmenuFittingG',[])

        set(handles.textAFit,'Visible','Off')
        set(handles.popupmenuAFit,'Enable','Off')
        set(handles.popupmenuAFit,'Visible','Off') 
        setappdata(0,'popupmenuAFit',[])
        set(handles.editAFit,'Enable','Off')
        set(handles.editAFit,'Visible','Off')
        set(handles.editAFit,'String',[])
        setappdata(0,'editAFit',[])

        set(handles.textCFit,'Visible','Off')
        set(handles.popupmenuCFit,'Enable','Off')
        set(handles.popupmenuCFit,'Visible','Off') 
        setappdata(0,'popupmenuCFit',[])
        set(handles.editCFit,'Enable','Off')
        set(handles.editCFit,'Visible','Off')
        set(handles.editCFit,'String',[])
        setappdata(0,'editCFit',[])

        set(handles.textEFit,'Visible','Off')
        set(handles.popupmenuEFit,'Enable','Off')
        set(handles.popupmenuEFit,'Visible','Off') 
        setappdata(0,'popupmenuEFit',[])
        set(handles.editEFit,'Enable','Off')
        set(handles.editEFit,'Visible','Off')
        set(handles.editEFit,'String',[])
        setappdata(0,'editEFit',[])

        set(handles.textGFit,'Visible','Off')
        set(handles.popupmenuGFit,'Enable','Off')
        set(handles.popupmenuGFit,'Visible','Off') 
        setappdata(0,'popupmenuGFit',[])
        set(handles.editGFit,'Enable','Off')
        set(handles.editGFit,'Visible','Off')
        set(handles.editGFit,'String',[])
        setappdata(0,'editGFit',[])

        set(handles.pushbuttonFitting,'Visible','Off')
        set(handles.pushbuttonFitting,'Enable','Off')

        set(handles.textTickA,'Visible','Off')
        set(handles.textTickC,'Visible','Off')
        set(handles.textTickE,'Visible','Off')
        set(handles.textTickG,'Visible','Off')
    else
        msgbox('This model is not valid in this case.')
        set(handles.popupmenuModel,'Value',1)
    end
elseif numModel == 5
    if isempty(getappdata(0,'popupmenuAM')) || ~strcmp(getappdata(0,'popupmenuAM'),'PolyAM')
        set(handles.axesModel,'Visible','On')
        axes(handles.axesModel)
        if ispc
            imshow(imread('figures\RNM2.bmp'))
        elseif isunix
            imshow(imread('figures/RNM2.bmp'))
        else
            disp('Platform not supported')
        end

        set(handles.textA,'Visible','On')
        set(handles.editA,'Enable','On')
        set(handles.editA,'Visible','On')
        set(handles.editA,'String',num2str(0))
        setappdata(0,'editA',0)


        set(handles.textC,'Visible','Off')
        set(handles.editC,'Enable','Off')
        set(handles.editC,'Visible','Off')
        setappdata(0,'editC',[])


        set(handles.textE,'Visible','Off')    
        set(handles.editE,'Enable','Off')
        set(handles.editE,'Visible','Off')
        setappdata(0,'editE',[])



        set(handles.textG,'Visible','Off')
        set(handles.editG,'Enable','Off')
        set(handles.editG,'Visible','Off')
        setappdata(0,'editG',[])



        set(handles.textModelAdd,'Visible','Off')
        set(handles.popupmenuModelAdd,'Value',1)
        set(handles.popupmenuModelAdd,'Enable','Off')
        set(handles.popupmenuModelAdd,'Visible','Off')
        setappdata(0,'popupmenuModelAdd',[])


        set(handles.editOtherModelAdd,'Visible','Off')
        set(handles.editOtherModelAdd,'String',[])
        setappdata(0,'editOtherModelAdd',[])


        set(handles.textModeTortuosity,'Visible','On')
        set(handles.popupmenuModeTortuosity,'Value',1)
        set(handles.popupmenuModeTortuosity,'Enable','On')
        set(handles.popupmenuModeTortuosity,'Visible','On')
        setappdata(0,'popupmenuModeTortuosity',[])


        set(handles.editOtherModeTortuosity,'Visible','Off')
        set(handles.editOtherModeTortuosity,'String',[])
        setappdata(0,'editOtherModeTortuosity',[])

        set(handles.textResult,'Visible','On')
        set(handles.editResult,'Enable','On')
        set(handles.editResult,'Visible','On')
        set(handles.editResult,'String','Result')
        setappdata(0,'editResult',[])
        set(handles.pushbuttonCalculation,'Visible','On')
        set(handles.pushbuttonCalculation,'Enable','On')

        set(handles.textFitting,'Visible','Off')
        set(handles.radiobuttonFitting,'Visible','Off')
        set(handles.radiobuttonFitting,'Enable','Off')
        set(handles.radiobuttonFitting,'Value',[])
        set(handles.popupmenuFittingA,'Visible','Off')
        set(handles.popupmenuFittingA,'Enable','Off')
        set(handles.popupmenuFittingA,'Value',[])
        setappdata(0,'popupmenuFittingA',[])

        set(handles.popupmenuFittingC,'Visible','Off')
        set(handles.popupmenuFittingC,'Enable','Off')
        set(handles.popupmenuFittingC,'Value',[])
        setappdata(0,'popupmenuFittingC',[])

        set(handles.popupmenuFittingE,'Visible','Off')
        set(handles.popupmenuFittingE,'Enable','Off')
        set(handles.popupmenuFittingE,'Value',[])
        setappdata(0,'popupmenuFittingE',[])

        set(handles.popupmenuFittingG,'Visible','Off')
        set(handles.popupmenuFittingG,'Enable','Off')
        set(handles.popupmenuFittingG,'Value',[])
        setappdata(0,'popupmenuFittingG',[])

        set(handles.textAFit,'Visible','Off')
        set(handles.popupmenuAFit,'Enable','Off')
        set(handles.popupmenuAFit,'Visible','Off') 
        setappdata(0,'popupmenuAFit',[])
        set(handles.editAFit,'Enable','Off')
        set(handles.editAFit,'Visible','Off')
        set(handles.editAFit,'String',[])
        setappdata(0,'editAFit',[])

        set(handles.textCFit,'Visible','Off')
        set(handles.popupmenuCFit,'Enable','Off')
        set(handles.popupmenuCFit,'Visible','Off') 
        setappdata(0,'popupmenuCFit',[])
        set(handles.editCFit,'Enable','Off')
        set(handles.editCFit,'Visible','Off')
        set(handles.editCFit,'String',[])
        setappdata(0,'editCFit',[])

        set(handles.textEFit,'Visible','Off')
        set(handles.popupmenuEFit,'Enable','Off')
        set(handles.popupmenuEFit,'Visible','Off') 
        setappdata(0,'popupmenuEFit',[])
        set(handles.editEFit,'Enable','Off')
        set(handles.editEFit,'Visible','Off')
        set(handles.editEFit,'String',[])
        setappdata(0,'editEFit',[])

        set(handles.textGFit,'Visible','Off')
        set(handles.popupmenuGFit,'Enable','Off')
        set(handles.popupmenuGFit,'Visible','Off') 
        setappdata(0,'popupmenuGFit',[])
        set(handles.editGFit,'Enable','Off')
        set(handles.editGFit,'Visible','Off')
        set(handles.editGFit,'String',[])
        setappdata(0,'editGFit',[])

        set(handles.pushbuttonFitting,'Visible','Off')
        set(handles.pushbuttonFitting,'Enable','Off')

        set(handles.textTickA,'Visible','Off')
        set(handles.textTickC,'Visible','Off')
        set(handles.textTickE,'Visible','Off')
        set(handles.textTickG,'Visible','Off')
    else
        msgbox('This model is not valid in this case.')
        set(handles.popupmenuModel,'Value',1)
    end
elseif numModel == 6
    
    if isempty(getappdata(0,'popupmenuAM')) || strcmp(getappdata(0,'popupmenuAM'),'PolyAM')
        set(handles.axesModel,'Visible','On')
        axes(handles.axesModel)
        if ispc
            imshow(imread('figures\ZBS_PolyAM.bmp'))
        elseif isunix
            imshow(imread('figures/ZBS_PolyAM.bmp'))
        else
            disp('Platform not supported')
        end
        set(handles.textA,'Visible','On')
        set(handles.editA,'Enable','On')
        set(handles.editA,'Visible','On')
        set(handles.editA,'String',num2str(0))
        setappdata(0,'editA',0)


        set(handles.textC,'Visible','On')
        set(handles.editC,'Enable','On')
        set(handles.editC,'Visible','On')
        set(handles.editC,'String',num2str(0))
        setappdata(0,'editC',0)


        set(handles.textE,'Visible','On')
        set(handles.editE,'Enable','On')
        set(handles.editE,'Visible','On')
        set(handles.editE,'String',num2str(0))
        setappdata(0,'editE',0)


        set(handles.textG,'Visible','On')
        set(handles.editG,'Enable','On')
        set(handles.editG,'Visible','On')
        set(handles.editG,'String',num2str(0))
        setappdata(0,'editG',0)


        set(handles.textModelAdd,'Visible','On')
        set(handles.popupmenuModelAdd,'Value',1)
        set(handles.popupmenuModelAdd,'Enable','On')
        set(handles.popupmenuModelAdd,'Visible','On')
        setappdata(0,'popupmenuModelAdd',[])

        set(handles.editOtherModelAdd,'Visible','Off')
        set(handles.editOtherModelAdd,'String',[])
        setappdata(0,'editOtherModelAdd',[])



        set(handles.textModeTortuosity,'Visible','On')
        set(handles.popupmenuModeTortuosity,'Value',1)
        set(handles.popupmenuModeTortuosity,'Enable','On')
        set(handles.popupmenuModeTortuosity,'Visible','On')
        setappdata(0,'popupmenuModeTortuosity',[])


        set(handles.editOtherModeTortuosity,'Visible','Off')
        set(handles.editOtherModeTortuosity,'String',[])
        setappdata(0,'editOtherModeTortuosity',[])
        set(handles.popupmenuFittingA,'Visible','Off')
        set(handles.popupmenuFittingA,'Enable','Off')

        set(handles.textResult,'Visible','On')
        set(handles.editResult,'Enable','On')
        set(handles.editResult,'Visible','On')
        set(handles.editResult,'String','Result')
        setappdata(0,'editResult',[])
        set(handles.pushbuttonCalculation,'Visible','On')
        set(handles.pushbuttonCalculation,'Enable','On')

        set(handles.textFitting,'Visible','Off')
        set(handles.radiobuttonFitting,'Visible','On')
        set(handles.radiobuttonFitting,'Enable','On')
        set(handles.radiobuttonFitting,'Value',0)
        set(handles.popupmenuFittingA,'Visible','Off')
        set(handles.popupmenuFittingA,'Enable','Off')
        set(handles.popupmenuFittingA,'Value',[])
        setappdata(0,'popupmenuFittingA',[])

        set(handles.popupmenuFittingC,'Visible','Off')
        set(handles.popupmenuFittingC,'Enable','Off')
        set(handles.popupmenuFittingC,'Value',[])
        setappdata(0,'popupmenuFittingC',[])

        set(handles.popupmenuFittingE,'Visible','Off')
        set(handles.popupmenuFittingE,'Enable','Off')
        set(handles.popupmenuFittingE,'Value',[])
        setappdata(0,'popupmenuFittingE',[])

        set(handles.popupmenuFittingG,'Visible','Off')
        set(handles.popupmenuFittingG,'Enable','Off')
        set(handles.popupmenuFittingG,'Value',[])
        setappdata(0,'popupmenuFittingG',[])

        set(handles.textAFit,'Visible','Off')
        strAFit = getappdata(0,'aFitList');
        set(handles.popupmenuAFit,'String',strAFit)
        set(handles.popupmenuAFit,'Value',1)
        set(handles.popupmenuAFit,'Enable','Off')
        set(handles.popupmenuAFit,'Visible','Off') 
        setappdata(0,'popupmenuAFit',[])
        set(handles.editAFit,'Enable','Off')
        set(handles.editAFit,'Visible','Off')
        set(handles.editAFit,'String',[])
        setappdata(0,'editAFit',[])

        set(handles.textCFit,'Visible','Off')
        strCFit = getappdata(0,'cFitList');
        set(handles.popupmenuCFit,'String',strCFit)
        set(handles.popupmenuCFit,'Value',1)
        set(handles.popupmenuCFit,'Enable','Off')
        set(handles.popupmenuCFit,'Visible','Off') 
        setappdata(0,'popupmenuCFit',[])
        set(handles.editCFit,'Enable','Off')
        set(handles.editCFit,'Visible','Off')
        set(handles.editCFit,'String',[])
        setappdata(0,'editCFit',[])

        set(handles.textEFit,'Visible','Off')
        strEFit = getappdata(0,'eFitList');
        set(handles.popupmenuEFit,'String',strEFit)
        set(handles.popupmenuEFit,'Value',1)
        set(handles.popupmenuEFit,'Enable','Off')
        set(handles.popupmenuEFit,'Visible','Off') 
        setappdata(0,'popupmenuEFit',[])
        set(handles.editEFit,'Enable','Off')
        set(handles.editEFit,'Visible','Off')
        set(handles.editEFit,'String',[])
        setappdata(0,'editEFit',[])

        set(handles.textGFit,'Visible','Off')
        strGFit = getappdata(0,'gFitList');
        set(handles.popupmenuGFit,'String',strGFit)
        set(handles.popupmenuGFit,'Value',1)
        set(handles.popupmenuGFit,'Enable','Off')
        set(handles.popupmenuGFit,'Visible','Off') 
        setappdata(0,'popupmenuGFit',[])
        set(handles.editGFit,'Enable','Off')
        set(handles.editGFit,'Visible','Off')
        set(handles.editGFit,'String',[])
        setappdata(0,'editGFit',[])

        set(handles.pushbuttonFitting,'Visible','Off')
        set(handles.pushbuttonFitting,'Enable','Off')

        set(handles.textTickA,'Visible','Off')
        set(handles.textTickC,'Visible','Off')
        set(handles.textTickE,'Visible','Off')
        set(handles.textTickG,'Visible','Off')

    else
        msgbox('This model is not valid in this case.')
        set(handles.popupmenuModel,'Value',1)
    end
    
elseif numModel == 7
    
    if isempty(getappdata(0,'popupmenuAM')) || strcmp(getappdata(0,'popupmenuAM'),'PolyAM')
        set(handles.axesModel,'Visible','On')
        axes(handles.axesModel)
        if ispc
            imshow(imread('figures\ZBS_modified_PolyAM.bmp'))
        elseif isunix
            imshow(imread('figures/ZBS_modified_PolyAM.bmp'))
        else
            disp('Platform not supported')
        end
        set(handles.textA,'Visible','On')
        set(handles.editA,'Enable','On')
        set(handles.editA,'Visible','On')
        set(handles.editA,'String',num2str(0))
        setappdata(0,'editA',0)


        set(handles.textC,'Visible','On')
        set(handles.editC,'Enable','On')
        set(handles.editC,'Visible','On')
        set(handles.editC,'String',num2str(0))
        setappdata(0,'editC',0)


        set(handles.textE,'Visible','On')
        set(handles.editE,'Enable','On')
        set(handles.editE,'Visible','On')
        set(handles.editE,'String',num2str(0))
        setappdata(0,'editE',0)


        set(handles.textG,'Visible','On')
        set(handles.editG,'Enable','On')
        set(handles.editG,'Visible','On')
        set(handles.editG,'String',num2str(0))
        setappdata(0,'editG',0)


        set(handles.textModelAdd,'Visible','On')
        set(handles.popupmenuModelAdd,'Value',1)
        set(handles.popupmenuModelAdd,'Enable','On')
        set(handles.popupmenuModelAdd,'Visible','On')
        setappdata(0,'popupmenuModelAdd',[])

        set(handles.editOtherModelAdd,'Visible','Off')
        set(handles.editOtherModelAdd,'String',[])
        setappdata(0,'editOtherModelAdd',[])



        set(handles.textModeTortuosity,'Visible','On')
        set(handles.popupmenuModeTortuosity,'Value',1)
        set(handles.popupmenuModeTortuosity,'Enable','On')
        set(handles.popupmenuModeTortuosity,'Visible','On')
        setappdata(0,'popupmenuModeTortuosity',[])


        set(handles.editOtherModeTortuosity,'Visible','Off')
        set(handles.editOtherModeTortuosity,'String',[])
        setappdata(0,'editOtherModeTortuosity',[])
        set(handles.popupmenuFittingA,'Visible','Off')
        set(handles.popupmenuFittingA,'Enable','Off')

        set(handles.textResult,'Visible','On')
        set(handles.editResult,'Enable','On')
        set(handles.editResult,'Visible','On')
        set(handles.editResult,'String','Result')
        setappdata(0,'editResult',[])
        set(handles.pushbuttonCalculation,'Visible','On')
        set(handles.pushbuttonCalculation,'Enable','On')

        set(handles.textFitting,'Visible','Off')
        set(handles.radiobuttonFitting,'Visible','On')
        set(handles.radiobuttonFitting,'Enable','On')
        set(handles.radiobuttonFitting,'Value',0)
        set(handles.popupmenuFittingA,'Visible','Off')
        set(handles.popupmenuFittingA,'Enable','Off')
        set(handles.popupmenuFittingA,'Value',[])
        setappdata(0,'popupmenuFittingA',[])

        set(handles.popupmenuFittingC,'Visible','Off')
        set(handles.popupmenuFittingC,'Enable','Off')
        set(handles.popupmenuFittingC,'Value',[])
        setappdata(0,'popupmenuFittingC',[])

        set(handles.popupmenuFittingE,'Visible','Off')
        set(handles.popupmenuFittingE,'Enable','Off')
        set(handles.popupmenuFittingE,'Value',[])
        setappdata(0,'popupmenuFittingE',[])

        set(handles.popupmenuFittingG,'Visible','Off')
        set(handles.popupmenuFittingG,'Enable','Off')
        set(handles.popupmenuFittingG,'Value',[])
        setappdata(0,'popupmenuFittingG',[])

        set(handles.textAFit,'Visible','Off')
        strAFit = getappdata(0,'aFitList');
        set(handles.popupmenuAFit,'String',strAFit)
        set(handles.popupmenuAFit,'Value',1)
        set(handles.popupmenuAFit,'Enable','Off')
        set(handles.popupmenuAFit,'Visible','Off') 
        setappdata(0,'popupmenuAFit',[])
        set(handles.editAFit,'Enable','Off')
        set(handles.editAFit,'Visible','Off')
        set(handles.editAFit,'String',[])
        setappdata(0,'editAFit',[])

        set(handles.textCFit,'Visible','Off')
        strCFit = getappdata(0,'cFitList');
        set(handles.popupmenuCFit,'String',strCFit)
        set(handles.popupmenuCFit,'Value',1)
        set(handles.popupmenuCFit,'Enable','Off')
        set(handles.popupmenuCFit,'Visible','Off') 
        setappdata(0,'popupmenuCFit',[])
        set(handles.editCFit,'Enable','Off')
        set(handles.editCFit,'Visible','Off')
        set(handles.editCFit,'String',[])
        setappdata(0,'editCFit',[])

        set(handles.textEFit,'Visible','Off')
        strEFit = getappdata(0,'eFitList');
        set(handles.popupmenuEFit,'String',strEFit)
        set(handles.popupmenuEFit,'Value',1)
        set(handles.popupmenuEFit,'Enable','Off')
        set(handles.popupmenuEFit,'Visible','Off') 
        setappdata(0,'popupmenuEFit',[])
        set(handles.editEFit,'Enable','Off')
        set(handles.editEFit,'Visible','Off')
        set(handles.editEFit,'String',[])
        setappdata(0,'editEFit',[])

        set(handles.textGFit,'Visible','Off')
        strGFit = getappdata(0,'gFitList');
        set(handles.popupmenuGFit,'String',strGFit)
        set(handles.popupmenuGFit,'Value',1)
        set(handles.popupmenuGFit,'Enable','Off')
        set(handles.popupmenuGFit,'Visible','Off') 
        setappdata(0,'popupmenuGFit',[])
        set(handles.editGFit,'Enable','Off')
        set(handles.editGFit,'Visible','Off')
        set(handles.editGFit,'String',[])
        setappdata(0,'editGFit',[])

        set(handles.pushbuttonFitting,'Visible','Off')
        set(handles.pushbuttonFitting,'Enable','Off')

        set(handles.textTickA,'Visible','Off')
        set(handles.textTickC,'Visible','Off')
        set(handles.textTickE,'Visible','Off')
        set(handles.textTickG,'Visible','Off')

    else
        msgbox('This model is not valid in this case.')
        set(handles.popupmenuModel,'Value',1)
    end
elseif numModel == 8
    
    if isempty(getappdata(0,'popupmenuAM')) || ~strcmp(getappdata(0,'popupmenuAM'),'PolyAM')
        set(handles.axesModel,'Visible','On')
        axes(handles.axesModel)
        if ispc
            imshow(imread('figures\ZBS_distributedAdd.bmp'))
        elseif isunix
            imshow(imread('figures/ZBS_distributedAdd.bmp'))
        else
            disp('Platform not supported')
        end
        set(handles.textA,'Visible','On')
        set(handles.editA,'Enable','On')
        set(handles.editA,'Visible','On')
        set(handles.editA,'String',num2str(0))
        setappdata(0,'editA',0)


        set(handles.textC,'Visible','On')
        set(handles.editC,'Enable','On')
        set(handles.editC,'Visible','On')
        set(handles.editC,'String',num2str(0))
        setappdata(0,'editC',0)


        set(handles.textE,'Visible','On')
        set(handles.editE,'Enable','On')
        set(handles.editE,'Visible','On')
        set(handles.editE,'String',num2str(0))
        setappdata(0,'editE',0)


        set(handles.textG,'Visible','On')
        set(handles.editG,'Enable','On')
        set(handles.editG,'Visible','On')
        set(handles.editG,'String',num2str(0))
        setappdata(0,'editG',0)


        set(handles.textModelAdd,'Visible','On')
        set(handles.popupmenuModelAdd,'Value',1)
        set(handles.popupmenuModelAdd,'Enable','On')
        set(handles.popupmenuModelAdd,'Visible','On')
        setappdata(0,'popupmenuModelAdd',[])

        set(handles.editOtherModelAdd,'Visible','Off')
        set(handles.editOtherModelAdd,'String',[])
        setappdata(0,'editOtherModelAdd',[])



        set(handles.textModeTortuosity,'Visible','On')
        set(handles.popupmenuModeTortuosity,'Value',1)
        set(handles.popupmenuModeTortuosity,'Enable','On')
        set(handles.popupmenuModeTortuosity,'Visible','On')
        setappdata(0,'popupmenuModeTortuosity',[])


        set(handles.editOtherModeTortuosity,'Visible','Off')
        set(handles.editOtherModeTortuosity,'String',[])
        setappdata(0,'editOtherModeTortuosity',[])
        set(handles.popupmenuFittingA,'Visible','Off')
        set(handles.popupmenuFittingA,'Enable','Off')

        set(handles.textResult,'Visible','On')
        set(handles.editResult,'Enable','On')
        set(handles.editResult,'Visible','On')
        set(handles.editResult,'String','Result')
        setappdata(0,'editResult',[])
        set(handles.pushbuttonCalculation,'Visible','On')
        set(handles.pushbuttonCalculation,'Enable','On')

        set(handles.textFitting,'Visible','Off')
        set(handles.radiobuttonFitting,'Visible','On')
        set(handles.radiobuttonFitting,'Enable','On')
        set(handles.radiobuttonFitting,'Value',0)
        set(handles.popupmenuFittingA,'Visible','Off')
        set(handles.popupmenuFittingA,'Enable','Off')
        set(handles.popupmenuFittingA,'Value',[])
        setappdata(0,'popupmenuFittingA',[])

        set(handles.popupmenuFittingC,'Visible','Off')
        set(handles.popupmenuFittingC,'Enable','Off')
        set(handles.popupmenuFittingC,'Value',[])
        setappdata(0,'popupmenuFittingC',[])

        set(handles.popupmenuFittingE,'Visible','Off')
        set(handles.popupmenuFittingE,'Enable','Off')
        set(handles.popupmenuFittingE,'Value',[])
        setappdata(0,'popupmenuFittingE',[])

        set(handles.popupmenuFittingG,'Visible','Off')
        set(handles.popupmenuFittingG,'Enable','Off')
        set(handles.popupmenuFittingG,'Value',[])
        setappdata(0,'popupmenuFittingG',[])

        set(handles.textAFit,'Visible','Off')
        strAFit = getappdata(0,'aFitList');
        set(handles.popupmenuAFit,'String',strAFit)
        set(handles.popupmenuAFit,'Value',1)
        set(handles.popupmenuAFit,'Enable','Off')
        set(handles.popupmenuAFit,'Visible','Off') 
        setappdata(0,'popupmenuAFit',[])
        set(handles.editAFit,'Enable','Off')
        set(handles.editAFit,'Visible','Off')
        set(handles.editAFit,'String',[])
        setappdata(0,'editAFit',[])

        set(handles.textCFit,'Visible','Off')
        strCFit = getappdata(0,'cFitList');
        set(handles.popupmenuCFit,'String',strCFit)
        set(handles.popupmenuCFit,'Value',1)
        set(handles.popupmenuCFit,'Enable','Off')
        set(handles.popupmenuCFit,'Visible','Off') 
        setappdata(0,'popupmenuCFit',[])
        set(handles.editCFit,'Enable','Off')
        set(handles.editCFit,'Visible','Off')
        set(handles.editCFit,'String',[])
        setappdata(0,'editCFit',[])

        set(handles.textEFit,'Visible','Off')
        strEFit = getappdata(0,'eFitList');
        set(handles.popupmenuEFit,'String',strEFit)
        set(handles.popupmenuEFit,'Value',1)
        set(handles.popupmenuEFit,'Enable','Off')
        set(handles.popupmenuEFit,'Visible','Off') 
        setappdata(0,'popupmenuEFit',[])
        set(handles.editEFit,'Enable','Off')
        set(handles.editEFit,'Visible','Off')
        set(handles.editEFit,'String',[])
        setappdata(0,'editEFit',[])

        set(handles.textGFit,'Visible','Off')
        strGFit = getappdata(0,'gFitList');
        set(handles.popupmenuGFit,'String',strGFit)
        set(handles.popupmenuGFit,'Value',1)
        set(handles.popupmenuGFit,'Enable','Off')
        set(handles.popupmenuGFit,'Visible','Off') 
        setappdata(0,'popupmenuGFit',[])
        set(handles.editGFit,'Enable','Off')
        set(handles.editGFit,'Visible','Off')
        set(handles.editGFit,'String',[])
        setappdata(0,'editGFit',[])

        set(handles.pushbuttonFitting,'Visible','Off')
        set(handles.pushbuttonFitting,'Enable','Off')

        set(handles.textTickA,'Visible','Off')
        set(handles.textTickC,'Visible','Off')
        set(handles.textTickE,'Visible','Off')
        set(handles.textTickG,'Visible','Off')
    else
        msgbox('This model is not valid in this case.')
        set(handles.popupmenuModel,'Value',1)
    end        
elseif numModel == 9
    
    if isempty(getappdata(0,'popupmenuAM')) || ~strcmp(getappdata(0,'popupmenuAM'),'PolyAM')
        set(handles.axesModel,'Visible','On')
        axes(handles.axesModel)
        if ispc
            imshow(imread('figures\ZBS_modified_distributedAdd.bmp'))
        elseif isunix
            imshow(imread('figures/ZBS_modified_distributedAdd.bmp'))
        else
            disp('Platform not supported')
        end
        set(handles.textA,'Visible','On')
        set(handles.editA,'Enable','On')
        set(handles.editA,'Visible','On')
        set(handles.editA,'String',num2str(0))
        setappdata(0,'editA',0)


        set(handles.textC,'Visible','On')
        set(handles.editC,'Enable','On')
        set(handles.editC,'Visible','On')
        set(handles.editC,'String',num2str(0))
        setappdata(0,'editC',0)


        set(handles.textE,'Visible','On')
        set(handles.editE,'Enable','On')
        set(handles.editE,'Visible','On')
        set(handles.editE,'String',num2str(0))
        setappdata(0,'editE',0)


        set(handles.textG,'Visible','On')
        set(handles.editG,'Enable','On')
        set(handles.editG,'Visible','On')
        set(handles.editG,'String',num2str(0))
        setappdata(0,'editG',0)


        set(handles.textModelAdd,'Visible','On')
        set(handles.popupmenuModelAdd,'Value',1)
        set(handles.popupmenuModelAdd,'Enable','On')
        set(handles.popupmenuModelAdd,'Visible','On')
        setappdata(0,'popupmenuModelAdd',[])

        set(handles.editOtherModelAdd,'Visible','Off')
        set(handles.editOtherModelAdd,'String',[])
        setappdata(0,'editOtherModelAdd',[])



        set(handles.textModeTortuosity,'Visible','On')
        set(handles.popupmenuModeTortuosity,'Value',1)
        set(handles.popupmenuModeTortuosity,'Enable','On')
        set(handles.popupmenuModeTortuosity,'Visible','On')
        setappdata(0,'popupmenuModeTortuosity',[])


        set(handles.editOtherModeTortuosity,'Visible','Off')
        set(handles.editOtherModeTortuosity,'String',[])
        setappdata(0,'editOtherModeTortuosity',[])
        set(handles.popupmenuFittingA,'Visible','Off')
        set(handles.popupmenuFittingA,'Enable','Off')

        set(handles.textResult,'Visible','On')
        set(handles.editResult,'Enable','On')
        set(handles.editResult,'Visible','On')
        set(handles.editResult,'String','Result')
        setappdata(0,'editResult',[])
        set(handles.pushbuttonCalculation,'Visible','On')
        set(handles.pushbuttonCalculation,'Enable','On')

        set(handles.textFitting,'Visible','Off')
        set(handles.radiobuttonFitting,'Visible','On')
        set(handles.radiobuttonFitting,'Enable','On')
        set(handles.radiobuttonFitting,'Value',0)
        set(handles.popupmenuFittingA,'Visible','Off')
        set(handles.popupmenuFittingA,'Enable','Off')
        set(handles.popupmenuFittingA,'Value',[])
        setappdata(0,'popupmenuFittingA',[])

        set(handles.popupmenuFittingC,'Visible','Off')
        set(handles.popupmenuFittingC,'Enable','Off')
        set(handles.popupmenuFittingC,'Value',[])
        setappdata(0,'popupmenuFittingC',[])

        set(handles.popupmenuFittingE,'Visible','Off')
        set(handles.popupmenuFittingE,'Enable','Off')
        set(handles.popupmenuFittingE,'Value',[])
        setappdata(0,'popupmenuFittingE',[])

        set(handles.popupmenuFittingG,'Visible','Off')
        set(handles.popupmenuFittingG,'Enable','Off')
        set(handles.popupmenuFittingG,'Value',[])
        setappdata(0,'popupmenuFittingG',[])

        set(handles.textAFit,'Visible','Off')
        strAFit = getappdata(0,'aFitList');
        set(handles.popupmenuAFit,'String',strAFit)
        set(handles.popupmenuAFit,'Value',1)
        set(handles.popupmenuAFit,'Enable','Off')
        set(handles.popupmenuAFit,'Visible','Off') 
        setappdata(0,'popupmenuAFit',[])
        set(handles.editAFit,'Enable','Off')
        set(handles.editAFit,'Visible','Off')
        set(handles.editAFit,'String',[])
        setappdata(0,'editAFit',[])

        set(handles.textCFit,'Visible','Off')
        strCFit = getappdata(0,'cFitList');
        set(handles.popupmenuCFit,'String',strCFit)
        set(handles.popupmenuCFit,'Value',1)
        set(handles.popupmenuCFit,'Enable','Off')
        set(handles.popupmenuCFit,'Visible','Off') 
        setappdata(0,'popupmenuCFit',[])
        set(handles.editCFit,'Enable','Off')
        set(handles.editCFit,'Visible','Off')
        set(handles.editCFit,'String',[])
        setappdata(0,'editCFit',[])

        set(handles.textEFit,'Visible','Off')
        strEFit = getappdata(0,'eFitList');
        set(handles.popupmenuEFit,'String',strEFit)
        set(handles.popupmenuEFit,'Value',1)
        set(handles.popupmenuEFit,'Enable','Off')
        set(handles.popupmenuEFit,'Visible','Off') 
        setappdata(0,'popupmenuEFit',[])
        set(handles.editEFit,'Enable','Off')
        set(handles.editEFit,'Visible','Off')
        set(handles.editEFit,'String',[])
        setappdata(0,'editEFit',[])

        set(handles.textGFit,'Visible','Off')
        strGFit = getappdata(0,'gFitList');
        set(handles.popupmenuGFit,'String',strGFit)
        set(handles.popupmenuGFit,'Value',1)
        set(handles.popupmenuGFit,'Enable','Off')
        set(handles.popupmenuGFit,'Visible','Off') 
        setappdata(0,'popupmenuGFit',[])
        set(handles.editGFit,'Enable','Off')
        set(handles.editGFit,'Visible','Off')
        set(handles.editGFit,'String',[])
        setappdata(0,'editGFit',[])

        set(handles.pushbuttonFitting,'Visible','Off')
        set(handles.pushbuttonFitting,'Enable','Off')

        set(handles.textTickA,'Visible','Off')
        set(handles.textTickC,'Visible','Off')
        set(handles.textTickE,'Visible','Off')
        set(handles.textTickG,'Visible','Off')
    else
        msgbox('This model is not valid in this case.')
        set(handles.popupmenuModel,'Value',1)
    end        
end



% --- Executes during object creation, after setting all properties.
function popupmenuModel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editAM_Callback(hObject, eventdata, handles)
% hObject    handle to editAM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAM as text
%        str2double(get(hObject,'String')) returns contents of editAM as a double

wAM = str2double(get(handles.editAM,'String'));
if isnan(wAM) || (wAM < 0 || wAM > 100)
    set(hObject,'String',100)
    wAM = 100;
    msgbox('The value should be between 0 and 100.')
end
setappdata(0,'editAM',wAM)
wCA = str2double(get(handles.editCA,'String'));
set(handles.editB,'String',100 - wAM - wCA)

% --- Executes during object creation, after setting all properties.
function editAM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editCA_Callback(hObject, eventdata, handles)
% hObject    handle to editCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editCA as text
%        str2double(get(hObject,'String')) returns contents of editCA as a double
wCA = str2double(get(handles.editCA,'String'));
if isnan(wCA) || (wCA < 0 || wCA > 100)
    set(hObject,'String',0)
    wCA = 0;
    msgbox('The value should be between 0 and 100.')
end
setappdata(0,'editCA',wCA)
wAM = str2double(get(handles.editAM,'String'));
set(handles.editB,'String',100 - wAM - wCA)


% --- Executes during object creation, after setting all properties.
function editCA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editB_Callback(hObject, eventdata, handles)
% hObject    handle to editB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editB as text
%        str2double(get(hObject,'String')) returns contents of editB as a double


% --- Executes during object creation, after setting all properties.
function editB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Enable','Off')


function editPorosity_Callback(hObject, eventdata, handles)
% hObject    handle to editPorisity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPorosity as text
%        str2double(get(hObject,'String')) returns contents of editPorosity as a double
porosity = str2double(get(handles.editPorosity,'String'));
if isnan(porosity) || (porosity < 0 || porosity > 100)
    set(hObject,'String',0)
    porosity = 0;
    msgbox('The value should be between 0 and 100.')
end
setappdata(0,'editPorosity',porosity)


% --- Executes during object creation, after setting all properties.
function editPorosity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPorosity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editA_Callback(hObject, eventdata, handles)
% hObject    handle to editA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editA as text
%        str2double(get(hObject,'String')) returns contents of editA as a double
a = str2double(get(handles.editA,'String'));
if isnan(a) || (a < 0 || a > 1)
    set(hObject,'String',0)
    a = 0;
    msgbox('The value should be between 0 and 1.')
end
setappdata(0,'editA',a)


% --- Executes during object creation, after setting all properties.
function editA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function editC_Callback(hObject, eventdata, handles)
% hObject    handle to editC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editC as text
%        str2double(get(hObject,'String')) returns contents of editC as a double
if strcmp(get(handles.editC,'String'),'auto')
    c = 'automatic';
else
    c = str2double(get(handles.editC,'String'));
    if isnan(c) || (c < 0 || c > 1)
        set(hObject,'String',0)
        c = 0;
        msgbox('The value should be between 0 and 1 OR auto.')
    end
end
setappdata(0,'editC',c)
    


% --- Executes during object creation, after setting all properties.
function editC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editE_Callback(hObject, eventdata, handles)
% hObject    handle to editE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editE as text
%        str2double(get(hObject,'String')) returns contents of editE as a double
e = str2double(get(handles.editE,'String'));
if isnan(e) || (e < 0 || e > 1)
    set(hObject,'String',0)
    e = 0;
    msgbox('The value should be between 0 and 1.')
end
setappdata(0,'editE',e)


% --- Executes during object creation, after setting all properties.
function editE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editG_Callback(hObject, eventdata, handles)
% hObject    handle to editG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editG as text
%        str2double(get(hObject,'String')) returns contents of editG as a double
g = str2double(get(handles.editG,'String'));
if isnan(g) || (g < 0 || g > 1)
    set(hObject,'String',0)
    g = 0;
    msgbox('The value should be between 0 and 1.')
end
setappdata(0,'editG',g)


% --- Executes during object creation, after setting all properties.
function editG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editResult_Callback(hObject, eventdata, handles)
% hObject    handle to editResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editResult as text
%        str2double(get(hObject,'String')) returns contents of editResult as a double


% --- Executes during object creation, after setting all properties.
function editResult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in popupmenuAM.
function popupmenuAM_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuAM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuAM contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuAM
numAM = get(handles.popupmenuAM,'Value');
strAM = get(handles.popupmenuAM,'String');
setappdata(0,'popupmenuAM',strAM(numAM))
set(handles.editOtherAM,'Visible','On')
set(handles.editOtherAM,'Enable','On')
set(handles.popupmenuModel,'Enable','On')
set(handles.popupmenuModel,'Value',1)
strModel = get(handles.popupmenuModel,'String');
setappdata(0,'popupmenuModel',strModel(1))
set(handles.popupmenuModel,'Enable','On')
cla(handles.axesModel,'reset');
set(handles.axesModel,'InnerPosition',[72 17.5 60 12],'OuterPosition',[72 17.5 60 12],'Position',[72 17.5 60 12],'Visible','Off')
set(handles.textA,'Visible','Off')
set(handles.editA,'Enable','Off')
set(handles.editA,'Visible','Off')
set(handles.editA,'String',[])
setappdata(0,'editA',[])


set(handles.textC,'Visible','Off')
set(handles.editC,'Enable','Off')
set(handles.editC,'Visible','Off')
set(handles.editC,'String',[])
setappdata(0,'editC',[])


set(handles.textE,'Visible','Off')
set(handles.editE,'Enable','Off')
set(handles.editE,'Visible','Off')
set(handles.editE,'String',[])
setappdata(0,'editE',[])


set(handles.textG,'Visible','Off')
set(handles.editG,'Enable','Off')
set(handles.editG,'Visible','Off')
set(handles.editG,'String',[])
setappdata(0,'editG',[])


set(handles.textModelAdd,'Visible','Off')
set(handles.popupmenuModelAdd,'Value',1)
set(handles.popupmenuModelAdd,'Enable','Off')
set(handles.popupmenuModelAdd,'Visible','Off')
setappdata(0,'popupmenuModelAdd',[])


set(handles.editOtherModelAdd,'Visible','Off')
set(handles.editOtherModelAdd,'String',[])
setappdata(0,'editOtherModelAdd',[])


set(handles.textModeTortuosity,'Visible','Off')
set(handles.popupmenuModeTortuosity,'Value',1)
set(handles.popupmenuModeTortuosity,'Enable','Off')
set(handles.popupmenuModeTortuosity,'Visible','Off')
setappdata(0,'popupmenuModeTortuosity',[])


set(handles.editOtherModeTortuosity,'Visible','Off')
set(handles.editOtherModeTortuosity,'String',[])
setappdata(0,'editOtherModeTortuosity',[])

set(handles.textResult,'Visible','Off')
set(handles.editResult,'Enable','Off')
set(handles.editResult,'Visible','Off')
set(handles.editResult,'String',[])
setappdata(0,'editResult',[])
set(handles.pushbuttonCalculation,'Visible','Off')
set(handles.pushbuttonCalculation,'Enable','Off')

set(handles.textFitting,'Visible','Off')
set(handles.radiobuttonFitting,'Visible','Off')
set(handles.radiobuttonFitting,'Enable','Off')
set(handles.radiobuttonFitting,'Value',[])
set(handles.popupmenuFittingA,'Visible','Off')
set(handles.popupmenuFittingA,'Enable','Off')
set(handles.popupmenuFittingA,'Value',[])
setappdata(0,'popupmenuFittingA',[])

set(handles.popupmenuFittingC,'Visible','Off')
set(handles.popupmenuFittingC,'Enable','Off')
set(handles.popupmenuFittingC,'Value',[])
setappdata(0,'popupmenuFittingC',[])

set(handles.popupmenuFittingE,'Visible','Off')
set(handles.popupmenuFittingE,'Enable','Off')
set(handles.popupmenuFittingE,'Value',[])
setappdata(0,'popupmenuFittingE',[])

set(handles.popupmenuFittingG,'Visible','Off')
set(handles.popupmenuFittingG,'Enable','Off')
set(handles.popupmenuFittingG,'Value',[])
setappdata(0,'popupmenuFittingG',[])

set(handles.textAFit,'Visible','Off')
set(handles.popupmenuAFit,'Enable','Off')
set(handles.popupmenuAFit,'Visible','Off') 
setappdata(0,'popupmenuAFit',[])
set(handles.editAFit,'Enable','Off')
set(handles.editAFit,'Visible','Off')
set(handles.editAFit,'String',[])
setappdata(0,'editAFit',[])

set(handles.textCFit,'Visible','Off')
set(handles.popupmenuCFit,'Enable','Off')
set(handles.popupmenuCFit,'Visible','Off') 
setappdata(0,'popupmenuCFit',[])
set(handles.editCFit,'Enable','Off')
set(handles.editCFit,'Visible','Off')
set(handles.editCFit,'String',[])
setappdata(0,'editCFit',[])

set(handles.textEFit,'Visible','Off')
set(handles.popupmenuEFit,'Enable','Off')
set(handles.popupmenuEFit,'Visible','Off') 
setappdata(0,'popupmenuEFit',[])
set(handles.editEFit,'Enable','Off')
set(handles.editEFit,'Visible','Off')
set(handles.editEFit,'String',[])
setappdata(0,'editEFit',[])

set(handles.textGFit,'Visible','Off')
set(handles.popupmenuGFit,'Enable','Off')
set(handles.popupmenuGFit,'Visible','Off') 
setappdata(0,'popupmenuGFit',[])
set(handles.editGFit,'Enable','Off')
set(handles.editGFit,'Visible','Off')
set(handles.editGFit,'String',[])
setappdata(0,'editGFit',[])

set(handles.pushbuttonFitting,'Visible','Off')
set(handles.pushbuttonFitting,'Enable','Off')

set(handles.textTickA,'Visible','Off')
set(handles.textTickC,'Visible','Off')
set(handles.textTickE,'Visible','Off')
set(handles.textTickG,'Visible','Off')
if strcmp(strAM(numAM),'Other')
    set(handles.editOtherAM,'String','...')
    setappdata(0,'editOtherAM',[])
elseif strcmp(strAM(numAM),'PolyAM')
    set(handles.editOtherAM,'Enable','Off')
    set(handles.editOtherAM,'String','Poly Components');
    setappdata(0,'editOtherAM','Poly Components')
    %{
    set(handles.popupmenuModel,'Value',6)
    strModel = get(handles.popupmenuModel,'String');
    setappdata(0,'popupmenuModel',strModel(6))
    set(handles.popupmenuModel,'Enable','Off')
    set(handles.axesModel,'Visible','On')
    axes(handles.axesModel)
    if ispc
        imshow(imread('figures\ZBS_PolyAM.bmp'))
    elseif isunix
        imshow(imread('figures/ZBS_PolyAM.bmp'))
    else
        disp('Platform not supported')
    end
    set(handles.textA,'Visible','On')
    set(handles.editA,'Enable','On')
    set(handles.editA,'Visible','On')
    set(handles.editA,'String',num2str(0))
    setappdata(0,'editA',0)

    
    set(handles.textC,'Visible','On')
    set(handles.editC,'Enable','On')
    set(handles.editC,'Visible','On')
    set(handles.editC,'String',num2str(0))
    setappdata(0,'editC',0)

    
    set(handles.textE,'Visible','On')
    set(handles.editE,'Enable','On')
    set(handles.editE,'Visible','On')
    set(handles.editE,'String',num2str(0))
    setappdata(0,'editE',0)


    set(handles.textG,'Visible','On')
    set(handles.editG,'Enable','On')
    set(handles.editG,'Visible','On')
    set(handles.editG,'String',num2str(0))
    setappdata(0,'editG',0)

    
    set(handles.textModelAdd,'Visible','On')
    set(handles.popupmenuModelAdd,'Value',1)
    set(handles.popupmenuModelAdd,'Enable','On')
    set(handles.popupmenuModelAdd,'Visible','On')
    setappdata(0,'popupmenuModelAdd',[])

    set(handles.editOtherModelAdd,'Visible','Off')
    set(handles.editOtherModelAdd,'String',[])
    setappdata(0,'editOtherModelAdd',[])
        


    set(handles.textModeTortuosity,'Visible','On')
    set(handles.popupmenuModeTortuosity,'Value',1)
    set(handles.popupmenuModeTortuosity,'Enable','On')
    set(handles.popupmenuModeTortuosity,'Visible','On')
    setappdata(0,'popupmenuModeTortuosity',[])

    
    set(handles.editOtherModeTortuosity,'Visible','Off')
    set(handles.editOtherModeTortuosity,'String',[])
    setappdata(0,'editOtherModeTortuosity',[])
    set(handles.popupmenuFittingA,'Visible','Off')
    set(handles.popupmenuFittingA,'Enable','Off')

    set(handles.textResult,'Visible','On')
    set(handles.editResult,'Enable','On')
    set(handles.editResult,'Visible','On')
    set(handles.editResult,'String','Result')
    setappdata(0,'editResult',[])
    set(handles.pushbuttonCalculation,'Visible','On')
    set(handles.pushbuttonCalculation,'Enable','On')
    
    set(handles.textFitting,'Visible','Off')
    set(handles.radiobuttonFitting,'Visible','On')
    set(handles.radiobuttonFitting,'Enable','On')
    set(handles.radiobuttonFitting,'Value',0)
    set(handles.popupmenuFittingA,'Visible','Off')
    set(handles.popupmenuFittingA,'Enable','Off')
    set(handles.popupmenuFittingA,'Value',[])
    setappdata(0,'popupmenuFittingA',[])
    
    set(handles.popupmenuFittingC,'Visible','Off')
    set(handles.popupmenuFittingC,'Enable','Off')
    set(handles.popupmenuFittingC,'Value',[])
    setappdata(0,'popupmenuFittingC',[])

    set(handles.popupmenuFittingE,'Visible','Off')
    set(handles.popupmenuFittingE,'Enable','Off')
    set(handles.popupmenuFittingE,'Value',[])
    setappdata(0,'popupmenuFittingE',[])

    set(handles.popupmenuFittingG,'Visible','Off')
    set(handles.popupmenuFittingG,'Enable','Off')
    set(handles.popupmenuFittingG,'Value',[])
    setappdata(0,'popupmenuFittingG',[])

    set(handles.textAFit,'Visible','Off')
    strAFit = getappdata(0,'aFitList');
    set(handles.popupmenuAFit,'String',strAFit)
    set(handles.popupmenuAFit,'Value',1)
    set(handles.popupmenuAFit,'Enable','Off')
    set(handles.popupmenuAFit,'Visible','Off') 
    setappdata(0,'popupmenuAFit',[])
    set(handles.editAFit,'Enable','Off')
    set(handles.editAFit,'Visible','Off')
    set(handles.editAFit,'String',[])
    setappdata(0,'editAFit',[])

    set(handles.textCFit,'Visible','Off')
    strCFit = getappdata(0,'cFitList');
    set(handles.popupmenuCFit,'String',strCFit)
    set(handles.popupmenuCFit,'Value',1)
    set(handles.popupmenuCFit,'Enable','Off')
    set(handles.popupmenuCFit,'Visible','Off') 
    setappdata(0,'popupmenuCFit',[])
    set(handles.editCFit,'Enable','Off')
    set(handles.editCFit,'Visible','Off')
    set(handles.editCFit,'String',[])
    setappdata(0,'editCFit',[])

    set(handles.textEFit,'Visible','Off')
    strEFit = getappdata(0,'eFitList');
    set(handles.popupmenuEFit,'String',strEFit)
    set(handles.popupmenuEFit,'Value',1)
    set(handles.popupmenuEFit,'Enable','Off')
    set(handles.popupmenuEFit,'Visible','Off') 
    setappdata(0,'popupmenuEFit',[])
    set(handles.editEFit,'Enable','Off')
    set(handles.editEFit,'Visible','Off')
    set(handles.editEFit,'String',[])
    setappdata(0,'editEFit',[])

    set(handles.textGFit,'Visible','Off')
    strGFit = getappdata(0,'gFitList');
    set(handles.popupmenuGFit,'String',strGFit)
    set(handles.popupmenuGFit,'Value',1)
    set(handles.popupmenuGFit,'Enable','Off')
    set(handles.popupmenuGFit,'Visible','Off') 
    setappdata(0,'popupmenuGFit',[])
    set(handles.editGFit,'Enable','Off')
    set(handles.editGFit,'Visible','Off')
    set(handles.editGFit,'String',[])
    setappdata(0,'editGFit',[])

    set(handles.pushbuttonFitting,'Visible','Off')
    set(handles.pushbuttonFitting,'Enable','Off')
    
    set(handles.textTickA,'Visible','Off')
    set(handles.textTickC,'Visible','Off')
    set(handles.textTickE,'Visible','Off')
    set(handles.textTickG,'Visible','Off')
    %}
elseif strcmp(strAM(numAM),'Please Choose')
    set(handles.editOtherAM,'Visible','Off')
    set(handles.editOtherAM,'Enable','Off')
    set(handles.editOtherAM,'String',[]);
    setappdata(0,'editOtherAM',[])
else
    load tables statistics
    AM = statistics(strAM(numAM),:); 
    kAM = AM.thermalConductivity;
    set(handles.editOtherAM,'Enable','Off')
    set(handles.editOtherAM,'String',num2str(kAM));
    setappdata(0,'editOtherAM',kAM)
end
nameAM = getappdata(0,'popupmenuAM');
nameCA = getappdata(0,'popupmenuCA');
nameB = getappdata(0,'popupmenuB');
if ~(strcmp(nameAM,'Other') || strcmp(nameCA,'Other') || strcmp(nameB,'Other'))
    set(handles.popupmenuFractionType,'Enable','On')
    set(handles.popupmenuFractionType,'Visible','On')
    set(handles.popupmenuFractionType,'String',{'Mass Fraction (wt. %)','Volume Fraction (vol. %)'})
    setappdata(0,'popupmenuFractionType','Mass Fraction (wt. %)')
else
    set(handles.popupmenuFractionType,'String',{'Volume Fraction (vol. %)'})
    set(handles.popupmenuFractionType,'Enable','Off')
    set(handles.popupmenuFractionType,'Visible','On')
    setappdata(0,'popupmenuFractionType','Volume Fraction (vol. %)')
end


% --- Executes during object creation, after setting all properties.
function popupmenuAM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuAM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuCA.
function popupmenuCA_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuCA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuCA
numCA = get(handles.popupmenuCA,'Value');
strCA = get(handles.popupmenuCA,'String');
setappdata(0,'popupmenuCA',strCA(numCA))
if strcmp(strCA(numCA),'Other')
    set(handles.editOtherCA,'Enable','On')
    set(handles.editOtherCA,'Visible','On')
    set(handles.editOtherCA,'String','...')
    setappdata(0,'editOtherCA',[])
elseif strcmp(strCA(numCA),'Please Choose')
    set(handles.editOtherCA,'Visible','Off')
    set(handles.editOtherCA,'Enable','Off')
    set(handles.editOtherCA,'String',[]);
    setappdata(0,'editOtherCA',[])
else
    load tables statistics
    CA = statistics(strCA(numCA),:); 
    kCA = CA.thermalConductivity;
    set(handles.editOtherCA,'Visible','On')
    set(handles.editOtherCA,'Enable','Off')
    set(handles.editOtherCA,'String',num2str(kCA));
    setappdata(0,'editOtherCA',kCA)
end
nameAM = getappdata(0,'popupmenuAM');
nameCA = getappdata(0,'popupmenuCA');
nameB = getappdata(0,'popupmenuB');
if ~(strcmp(nameAM,'Other') || strcmp(nameCA,'Other') || strcmp(nameB,'Other'))
    set(handles.popupmenuFractionType,'Enable','On')
    set(handles.popupmenuFractionType,'Visible','On')
    set(handles.popupmenuFractionType,'String',{'Mass Fraction (wt. %)','Volume Fraction (vol. %)'})
    setappdata(0,'popupmenuFractionType','Mass Fraction (wt. %)')
else
    set(handles.popupmenuFractionType,'String',{'Volume Fraction (vol. %)'})
    set(handles.popupmenuFractionType,'Enable','Off')
    set(handles.popupmenuFractionType,'Visible','On')
    setappdata(0,'popupmenuFractionType','Volume Fraction (vol. %)')
end


% --- Executes during object creation, after setting all properties.
function popupmenuCA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuB.
function popupmenuB_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuB contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuB
numB = get(handles.popupmenuB,'Value');
strB = get(handles.popupmenuB,'String');
setappdata(0,'popupmenuB',strB(numB))
if strcmp(strB(numB),'Other')
    set(handles.editOtherB,'Enable','On')
    set(handles.editOtherB,'Visible','On')
    set(handles.editOtherB,'String','...')
    setappdata(0,'editOtherB',[])
elseif strcmp(strB(numB),'Please Choose')
    set(handles.editOtherB,'Visible','Off')
    set(handles.editOtherB,'Enable','Off')
    set(handles.editOtherB,'String',[]);
    setappdata(0,'editOtherB',[])
else
    load tables statistics
    B = statistics(strB(numB),:); 
    kB = B.thermalConductivity;
    set(handles.editOtherB,'Visible','On')
    set(handles.editOtherB,'Enable','Off')
    set(handles.editOtherB,'String',num2str(kB));
    setappdata(0,'editOtherB',kB)
end
nameAM = getappdata(0,'popupmenuAM');
nameCA = getappdata(0,'popupmenuCA');
nameB = getappdata(0,'popupmenuB');
if ~(strcmp(nameAM,'Other') || strcmp(nameCA,'Other') || strcmp(nameB,'Other'))
    set(handles.popupmenuFractionType,'Enable','On')
    set(handles.popupmenuFractionType,'Visible','On')
    set(handles.popupmenuFractionType,'String',{'Mass Fraction (wt. %)','Volume Fraction (vol. %)'})
    setappdata(0,'popupmenuFractionType','Mass Fraction (wt. %)')
else
    set(handles.popupmenuFractionType,'String',{'Volume Fraction (vol. %)'})
    set(handles.popupmenuFractionType,'Enable','Off')
    set(handles.popupmenuFractionType,'Visible','On')
    setappdata(0,'popupmenuFractionType','Volume Fraction (vol. %)')
end

% --- Executes during object creation, after setting all properties.
function popupmenuB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuMedium.
function popupmenuMedium_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuMedium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuMedium contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuMedium
numMedium = get(handles.popupmenuMedium,'Value');
strMedium = get(handles.popupmenuMedium,'String');
setappdata(0,'popupmenuMedium',strMedium(numMedium))
if strcmp(strMedium(numMedium),'Other')
    set(handles.editOtherMedium,'Enable','On')
    set(handles.editOtherMedium,'Visible','On')
    set(handles.editOtherMedium,'String','...')
    setappdata(0,'editOtherMedium',[])
elseif strcmp(strMedium(numMedium),'Please Choose')
    set(handles.editOtherMedium,'Visible','Off')
    set(handles.editOtherMedium,'Enable','Off')
    set(handles.editOtherMedium,'String',[]);
    setappdata(0,'editOtherMedium',[])
else
    load tables statistics
    Medium = statistics(strMedium(numMedium),:); 
    kMedium = Medium.thermalConductivity;
    set(handles.editOtherMedium,'Visible','On')
    set(handles.editOtherMedium,'Enable','Off')
    set(handles.editOtherMedium,'String',num2str(kMedium));
    setappdata(0,'editOtherMedium',kMedium)
end


% --- Executes during object creation, after setting all properties.
function popupmenuMedium_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuMedium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuModelAdd.
function popupmenuModelAdd_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuModelAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuModelAdd contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuModelAdd
numModelAdd = get(handles.popupmenuModelAdd,'Value');
strModelAdd = get(handles.popupmenuModelAdd,'String');
setappdata(0,'popupmenuModelAdd',strModelAdd(numModelAdd))
if strcmp(strModelAdd(numModelAdd),'Other')
    set(handles.editOtherModelAdd,'Enable','On')
    set(handles.editOtherModelAdd,'Visible','On')
    set(handles.editOtherModelAdd,'String','...')
    setappdata(0,'editOtherModelAdd',[])
elseif strcmp(strModelAdd(numModelAdd),'Please Choose')
    set(handles.editOtherModelAdd,'Visible','Off')
    set(handles.editOtherModelAdd,'Enable','Off')
    set(handles.editOtherModelAdd,'String',[]);
    setappdata(0,'editOtherModelAdd',[])
else
    set(handles.editOtherModelAdd,'Visible','On')
    set(handles.editOtherModelAdd,'Enable','Off')
    set(handles.editOtherModelAdd,'String',strModelAdd(numModelAdd));
    setappdata(0,'editOtherModelAdd',strModelAdd(numModelAdd))
end


% --- Executes during object creation, after setting all properties.
function popupmenuModelAdd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuModelAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuModeTortuosity.
function popupmenuModeTortuosity_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuModeTortuosity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuModeTortuosity contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuModeTortuosity
numModeTortuosity = get(handles.popupmenuModeTortuosity,'Value');
strModeTortuosity = get(handles.popupmenuModeTortuosity,'String');
setappdata(0,'popupmenuModeTortuosity',strModeTortuosity(numModeTortuosity))
if strcmp(strModeTortuosity(numModeTortuosity),'Other')
    set(handles.editOtherModeTortuosity,'Enable','On')
    set(handles.editOtherModeTortuosity,'Visible','On')
    set(handles.editOtherModeTortuosity,'String','...')
    setappdata(0,'editOtherModeTortuosity',[])
elseif strcmp(strModeTortuosity(numModeTortuosity),'Please Choose')
    set(handles.editOtherModeTortuosity,'Visible','Off')
    set(handles.editOtherModeTortuosity,'Enable','Off')
    set(handles.editOtherModeTortuosity,'String',[]);
else
    set(handles.editOtherModeTortuosity,'Visible','On')
    set(handles.editOtherModeTortuosity,'Enable','Off')
    if numModeTortuosity == 1
        set(handles.editOtherModeTortuosity,'String',strModeTortuosity(1));
    elseif numModeTortuosity == 2
        set(handles.editOtherModeTortuosity,'String','y = x/(1 - sqrt[1-x])');
    elseif numModeTortuosity == 3
        set(handles.editOtherModeTortuosity,'String','y = x^(-0.5)');
    elseif numModeTortuosity == 4
        set(handles.editOtherModeTortuosity,'String','y = 1.8 * x^(-0.53)');
    else
        set(handles.editOtherModeTortuosity,'String',strModeTortuosity(numModeTortuosity));
    end
    setappdata(0,'editOtherModeTortuosity',strModeTortuosity(numModeTortuosity))
end


% --- Executes during object creation, after setting all properties.
function popupmenuModeTortuosity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuModeTortuosit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonCalculation.
function pushbuttonCalculation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCalculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    if ~exist('results','dir')
        mkdir('results')
    end
    
    strClock = clock;
    dirClock = [num2str(strClock(1,1)),'-',num2str(strClock(1,2)),'-',num2str(strClock(1,3)),'-',num2str(strClock(1,4)),'-',num2str(strClock(1,5)),'-',num2str(round(strClock(1,6)))];
    
    
    setappdata(0,'backgroundColor',[0.47, 0.67, 0.19])
    set(handles.textWaitBar,'ForegroundColor','w','FontWeight','Bold','BackgroundColor',[0.47, 0.67, 0.19])
    set(handles.textWaitBar,'Position',[0 0 1 1])
    set(handles.editResult,'String','...');
    pause(0.03)
    set(handles.textWaitBar,'Position',[0 0 31 1])
    set(handles.textWaitBar,'String','Loading components ...','HorizontalAlignment','Center')
    pause(0.03)
    setappdata(0,'editResult',[])
    load tables statistics
    model = getappdata(0,'popupmenuModel');
    frAM = getappdata(0,'editAM')/100;
    frCA = getappdata(0,'editCA')/100;
    frB = 1 - frAM - frCA;
    porosity = getappdata(0,'editPorosity')/100;
    nameAM = getappdata(0,'popupmenuAM');
    otherAM = getappdata(0,'editOtherAM');
    kAM = otherAM;
    nameCA = getappdata(0,'popupmenuCA');
    otherCA = getappdata(0,'editOtherCA');  
    kCA = otherCA;
    nameB = getappdata(0,'popupmenuB');
    otherB = getappdata(0,'editOtherB');
    kB = otherB;
    nameMedium = getappdata(0,'popupmenuMedium');
    otherMedium = getappdata(0,'editOtherMedium');
    kMedium = otherMedium;
    set(handles.textWaitBar,'Position',[0 0 61 1])
    set(handles.textWaitBar,'String','Components loaded','HorizontalAlignment','Center')
    pause(0.03)
    set(handles.textWaitBar,'Position',[0 0 61 1])
    set(handles.textWaitBar,'String','Loading parameters ...','HorizontalAlignment','Center')
    pause(0.03)
    try
        a = getappdata(0,'editA');
    catch
        a = [];
    end
    try
        c = getappdata(0,'editC');
    catch
        c = [];
    end
    try
        e = getappdata(0,'editE');
    catch
        e = [];
    end
    try
        g = getappdata(0,'editG');
    catch
        g = [];
    end
    try
        nameModelAdd = getappdata(0,'popupmenuModelAdd');
        nameModelAdd = nameModelAdd{1};
    catch
        nameModelAdd = ' ';
    end
    try
        nameModeTortuosity = getappdata(0,'popupmenuModeTortuosity');
        nameModeTortuosity = str2double(nameModeTortuosity{1});
    catch
        nameModeTortuosity = ' ';
    end
    set(handles.textWaitBar,'Position',[0 0 91 1])
    set(handles.textWaitBar,'String','Parameters loaded','HorizontalAlignment','Center')
    set(handles.textWaitBar,'Position',[0 0 91 1])
    pause(0.03)
    set(handles.textWaitBar,'String','Calculating...','HorizontalAlignment','Center')
    fractionType = getappdata(0,'popupmenuFractionType');
    pause(0.03)

    if strcmp(fractionType,'Volume Fraction (vol. %)')
        output_volumeFractionsMatrix = [frAM;frCA];
    elseif strcmp(fractionType,'Mass Fraction (wt. %)')
        try
            [output_volumeFractionsMatrix,~] = fractionsMatrix_xPorosity_transfer(...
                {nameAM;nameCA;nameB},[frAM;frCA],'none',0,1,0,0,0);
        catch
        end
    end
    strModel = get(handles.popupmenuModel,'String');

    
    if strcmp(model,strModel(2))
        keff = k_ZSM_1_calculator(...
            [kAM;kCA;kB],output_volumeFractionsMatrix,...
            kMedium,porosity,'curveRAreaContact',...
            nameModelAdd,nameModeTortuosity,a,c,e,g);
        additional = {nameModeTortuosity;nameModelAdd;a;c;e;g};
        additionalInfo = {'Tortuosity';'Additive System';'a';'c';'e';'g'};
    elseif strcmp(model,strModel(3))
        keff = k_ZSM_1_a_calculator(...
            [kAM;kCA;kB],output_volumeFractionsMatrix,...
            kMedium,porosity,'curveRAreaContact',...
            nameModelAdd,nameModeTortuosity,a,c,e,g);
        additional = {nameModeTortuosity;nameModelAdd;a;c;e;g};
        additionalInfo = {'Tortuosity';'Additive System';'a';'c';'e';'g'};
    elseif strcmp(model,strModel(4))
        keff = k_RNM_1_calculator([kAM;kCA;kB],output_volumeFractionsMatrix,kMedium,porosity,nameModeTortuosity,a);
        additional = {nameModeTortuosity;a};
        additionalInfo = {'Tortuosity';'a'};
    elseif strcmp(model,strModel(5))
        keff = k_RNM_2_calculator([kAM;kCA;kB],output_volumeFractionsMatrix,kMedium,porosity,nameModeTortuosity,a);
        additional = {nameModeTortuosity;a};
        additionalInfo = {'Tortuosity';'a'};
    elseif strcmp(model,strModel(6))
        prompt = {'The number of active material (AM) between 1 and 10'};
        dlgtitle = 'Individualized Input';
        dims = [1 40];
        definput = {'2'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        
        while isnan(str2double(answer)) || str2double(answer) < 0 || str2double(answer) > 10 % if empty, then quit
            prompt = {'AGAIN: The number of active material (AM) between 1 and 10'};
            dlgtitle = 'Individualized Input';
            dims = [1 40];
            definput = {'2'};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
        end
        
        nAM = str2double(answer);
        AM = cell(1,nAM);
        ksAM = zeros(1,nAM);
        ratiosAM = zeros(1,nAM);
        infoAM = cell(nAM * 3,1);
        strInfoAM = cell(nAM * 3,1);
        dlgtitle = 'Individualized Input';
        dims = [1 40];
        
        
        for ii = 1 : nAM
            errorAM = 0;
            prompt = {['AM ',num2str(ii)],['Ratio ',num2str(ii)]};
            definput = {['AM',num2str(ii)],'0'};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            try
                try
                    objectAM = statistics(answer{1,1},:);
                    ksAM(1,ii) = objectAM.thermalConductivity;
                    AM{1,ii} = answer{1,1};
                catch
                    ksAM(1,ii) = str2double(answer{1,1});
                    AM{1,ii} = ['AM',num2str(ii)];
                    
                end
                ratiosAM(1,ii) = str2double(answer{2,1});
                infoAM{ii * 3 - 2,1} = AM{1,ii};
                strInfoAM{ii * 3 - 2,1} = ['AM',num2str(ii)];
                infoAM{ii * 3 - 1,1} = ksAM(1,ii);
                strInfoAM{ii * 3 - 1,1} = ['kAM',num2str(ii)];
                infoAM{ii * 3,1} = ratiosAM(1,ii);
                strInfoAM{ii * 3,1} = ['ratio AM',num2str(ii)];
                errorAM = 0;
            catch
                errorAM = 1;
            end
            if strcmp(fractionType,'Mass Fraction (wt. %)')
                while ~isnan(str2double(answer{1,1})) || errorAM == 1 || ratiosAM(1,ii) < 0 % is a number
                    prompt = {['AM ',num2str(ii),' - AGAIN'],['Ratio ',num2str(ii),' - AGAIN']};
                    answer = inputdlg(prompt,dlgtitle,dims,definput);
                   try
                        objectAM = statistics(answer{1,1},:); 
                        ksAM(1,ii) = objectAM.thermalConductivity;
                        AM{1,ii} = answer{1,1};
                        ratiosAM(1,ii) = str2double(answer{2,1});
                        infoAM{ii * 3 - 2,1} = AM{1,ii};
                        strInfoAM{ii * 3 - 2,1} = ['AM',num2str(ii)];
                        infoAM{ii * 3 - 1,1} = ksAM(1,ii);
                        strInfoAM{ii * 3 - 1,1} = ['kAM',num2str(ii)];
                        infoAM{ii * 3,1} = ratiosAM(1,ii);
                        strInfoAM{ii * 3,1} = ['ratio AM',num2str(ii)];
                        errorAM = 0;
                   catch
                        errorAM = 1;
                   end
                end
                %%%%%%%% For everything else
            end
        end
        clear ii
        while sum(ratiosAM,2) == 0
            for ii = 1 : nAM
                errorAM = 0;
                prompt = {['AM ',num2str(ii),' - AGAIN'],['Ratio ',num2str(ii),' - AGAIN']};
                definput = {['AM',num2str(ii)],'0'};
                answer = inputdlg(prompt,dlgtitle,dims,definput);
                try
                    try
                        objectAM = statistics(answer{1,1},:);
                        ksAM(1,ii) = objectAM.thermalConductivity;
                        AM{1,ii} = answer{1,1};
                    catch
                        ksAM(1,ii) = str2double(answer{1,1});
                        AM{1,ii} = ['AM',num2str(ii)];
                    end
                    ratiosAM(1,ii) = str2double(answer{2,1});
                    infoAM{ii * 3 - 2,1} = AM{1,ii};
                    strInfoAM{ii * 3 - 2,1} = ['AM',num2str(ii)];
                    infoAM{ii * 3 - 1,1} = ksAM(1,ii);
                    strInfoAM{ii * 3 - 1,1} = ['kAM',num2str(ii)];
                    infoAM{ii * 3,1} = ratiosAM(1,ii);
                    strInfoAM{ii * 3,1} = ['ratio AM',num2str(ii)];
                    errorAM = 0;
                catch
                    errorAM = 1;
                end
                if strcmp(fractionType,'Mass Fraction (wt. %)')
                    while ~isnan(str2double(answer{1,1})) || errorAM == 1 || ratiosAM(1,ii) < 0 % is a number
                        prompt = {['AM ',num2str(ii),' - AGAIN'],['Ratio ',num2str(ii),' - AGAIN']};
                        answer = inputdlg(prompt,dlgtitle,dims,definput);
                       try
                            objectAM = statistics(answer{1,1},:); 
                            ksAM(1,ii) = objectAM.thermalConductivity;
                            AM{1,ii} = answer{1,1};
                            ratiosAM(1,ii) = str2double(answer{2,1});
                            infoAM{ii * 3 - 2,1} = AM{1,ii};
                            strInfoAM{ii * 3 - 2,1} = ['AM',num2str(ii)];
                            infoAM{ii * 3 - 1,1} = ksAM(1,ii);
                            strInfoAM{ii * 3 - 1,1} = ['kAM',num2str(ii)];
                            infoAM{ii * 3,1} = ratiosAM(1,ii);
                            strInfoAM{ii * 3,1} = ['ratio AM',num2str(ii)];
                            errorAM = 0;
                       catch
                            errorAM = 1;
                       end
                    end
                end
            end
            clear ii
        end
        
        ratioAM = ratiosAM ./ sum(ratiosAM,2);

        if strcmp(fractionType,'Volume Fraction (vol. %)')
            
        elseif strcmp(fractionType,'Mass Fraction (wt. %)')
        
            [output_volumeFractionsMatrixAll,~] = fractionsMatrix_xPorosity_transfer(...
                [AM';nameCA;nameB],[ratioAM' .* frAM;frCA],'none',0,1,0,0,0);
            ratioAM = output_volumeFractionsMatrixAll(1:nAM) ./ sum(output_volumeFractionsMatrixAll(1:nAM),1);
            output_volumeFractionsMatrix = [sum(output_volumeFractionsMatrixAll(1:nAM),1);output_volumeFractionsMatrixAll(nAM + 1)];
            
        end

        keff = k_ZSM_1_polyAM_calculator(...
            [ksAM';kCA;kB],output_volumeFractionsMatrix,...
            kMedium,porosity,'curveRAreaContact',...
            nameModelAdd,nameModeTortuosity,a,c,e,g,ratioAM);
        additional = [{nameModeTortuosity;nameModelAdd;a;c;e;g};infoAM];
        additionalInfo = [{'Tortuosity';'Additive System';'a';'c';'e';'g'};strInfoAM];



    elseif strcmp(model,strModel(7))
        prompt = {'The number of active material (AM) between 1 and 10'};
        dlgtitle = 'Individualized Input';
        dims = [1 40];
        definput = {'2'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        
        while isnan(str2double(answer)) || str2double(answer) < 0 || str2double(answer) > 10 % if empty, then quit
            prompt = {'AGAIN: The number of active material (AM) between 1 and 10'};
            dlgtitle = 'Individualized Input';
            dims = [1 40];
            definput = {'2'};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
        end
        
        nAM = str2double(answer);
        AM = cell(1,nAM);
        ksAM = zeros(1,nAM);
        ratiosAM = zeros(1,nAM);
        infoAM = cell(nAM * 3,1);
        strInfoAM = cell(nAM * 3,1);
        dlgtitle = 'Individualized Input';
        dims = [1 40];
        
        
        for ii = 1 : nAM
            errorAM = 0;
            prompt = {['AM ',num2str(ii)],['Ratio ',num2str(ii)]};
            definput = {['AM',num2str(ii)],'0'};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            try
                try
                    objectAM = statistics(answer{1,1},:);
                    ksAM(1,ii) = objectAM.thermalConductivity;
                    AM{1,ii} = answer{1,1};
                catch
                    ksAM(1,ii) = str2double(answer{1,1});
                    AM{1,ii} = ['AM',num2str(ii)];
                    
                end
                ratiosAM(1,ii) = str2double(answer{2,1});
                infoAM{ii * 3 - 2,1} = AM{1,ii};
                strInfoAM{ii * 3 - 2,1} = ['AM',num2str(ii)];
                infoAM{ii * 3 - 1,1} = ksAM(1,ii);
                strInfoAM{ii * 3 - 1,1} = ['kAM',num2str(ii)];
                infoAM{ii * 3,1} = ratiosAM(1,ii);
                strInfoAM{ii * 3,1} = ['ratio AM',num2str(ii)];
                errorAM = 0;
            catch
                errorAM = 1;
            end
            if strcmp(fractionType,'Mass Fraction (wt. %)')
                while ~isnan(str2double(answer{1,1})) || errorAM == 1 || ratiosAM(1,ii) < 0 % is a number
                    prompt = {['AM ',num2str(ii),' - AGAIN'],['Ratio ',num2str(ii),' - AGAIN']};
                    answer = inputdlg(prompt,dlgtitle,dims,definput);
                   try
                        objectAM = statistics(answer{1,1},:); 
                        ksAM(1,ii) = objectAM.thermalConductivity;
                        AM{1,ii} = answer{1,1};
                        ratiosAM(1,ii) = str2double(answer{2,1});
                        infoAM{ii * 3 - 2,1} = AM{1,ii};
                        strInfoAM{ii * 3 - 2,1} = ['AM',num2str(ii)];
                        infoAM{ii * 3 - 1,1} = ksAM(1,ii);
                        strInfoAM{ii * 3 - 1,1} = ['kAM',num2str(ii)];
                        infoAM{ii * 3,1} = ratiosAM(1,ii);
                        strInfoAM{ii * 3,1} = ['ratio AM',num2str(ii)];
                        errorAM = 0;
                   catch
                        errorAM = 1;
                   end
                end
                %%%%%%%% For everything else
            end
        end
        clear ii
        while sum(ratiosAM,2) == 0
            for ii = 1 : nAM
                errorAM = 0;
                prompt = {['AM ',num2str(ii),' - AGAIN'],['Ratio ',num2str(ii),' - AGAIN']};
                definput = {['AM',num2str(ii)],'0'};
                answer = inputdlg(prompt,dlgtitle,dims,definput);
                try
                    try
                        objectAM = statistics(answer{1,1},:);
                        ksAM(1,ii) = objectAM.thermalConductivity;
                        AM{1,ii} = answer{1,1};
                    catch
                        ksAM(1,ii) = str2double(answer{1,1});
                        AM{1,ii} = ['AM',num2str(ii)];
                    end
                    ratiosAM(1,ii) = str2double(answer{2,1});
                    infoAM{ii * 3 - 2,1} = AM{1,ii};
                    strInfoAM{ii * 3 - 2,1} = ['AM',num2str(ii)];
                    infoAM{ii * 3 - 1,1} = ksAM(1,ii);
                    strInfoAM{ii * 3 - 1,1} = ['kAM',num2str(ii)];
                    infoAM{ii * 3,1} = ratiosAM(1,ii);
                    strInfoAM{ii * 3,1} = ['ratio AM',num2str(ii)];
                    errorAM = 0;
                catch
                    errorAM = 1;
                end
                if strcmp(fractionType,'Mass Fraction (wt. %)')
                    while ~isnan(str2double(answer{1,1})) || errorAM == 1 || ratiosAM(1,ii) < 0 % is a number
                        prompt = {['AM ',num2str(ii),' - AGAIN'],['Ratio ',num2str(ii),' - AGAIN']};
                        answer = inputdlg(prompt,dlgtitle,dims,definput);
                       try
                            objectAM = statistics(answer{1,1},:); 
                            ksAM(1,ii) = objectAM.thermalConductivity;
                            AM{1,ii} = answer{1,1};
                            ratiosAM(1,ii) = str2double(answer{2,1});
                            infoAM{ii * 3 - 2,1} = AM{1,ii};
                            strInfoAM{ii * 3 - 2,1} = ['AM',num2str(ii)];
                            infoAM{ii * 3 - 1,1} = ksAM(1,ii);
                            strInfoAM{ii * 3 - 1,1} = ['kAM',num2str(ii)];
                            infoAM{ii * 3,1} = ratiosAM(1,ii);
                            strInfoAM{ii * 3,1} = ['ratio AM',num2str(ii)];
                            errorAM = 0;
                       catch
                            errorAM = 1;
                       end
                    end
                end
            end
            clear ii
        end
        
        ratioAM = ratiosAM ./ sum(ratiosAM,2);

        if strcmp(fractionType,'Volume Fraction (vol. %)')
            
        elseif strcmp(fractionType,'Mass Fraction (wt. %)')
        
            [output_volumeFractionsMatrixAll,~] = fractionsMatrix_xPorosity_transfer(...
                [AM';nameCA;nameB],[ratioAM' .* frAM;frCA],'none',0,1,0,0,0);
            ratioAM = output_volumeFractionsMatrixAll(1:nAM) ./ sum(output_volumeFractionsMatrixAll(1:nAM),1);
            output_volumeFractionsMatrix = [sum(output_volumeFractionsMatrixAll(1:nAM),1);output_volumeFractionsMatrixAll(nAM + 1)];
            
        end

        keff = k_ZSM_1_a_polyAM_calculator(...
            [ksAM';kCA;kB],output_volumeFractionsMatrix,...
            kMedium,porosity,'curveRAreaContact',...
            nameModelAdd,nameModeTortuosity,a,c,e,g,ratioAM);
        additional = [{nameModeTortuosity;nameModelAdd;a;c;e;g};infoAM];
        additionalInfo = [{'Tortuosity';'Additive System';'a';'c';'e';'g'};strInfoAM];
        
    elseif strcmp(model,strModel(8))
        prompt = {'Distribution: e.g. ''linear'' or [0.1;0.2;0.3;0.4]'};
        dlgtitle = 'Individualized Input';
        dims = [1 40];
        definput = {'linear'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        infoAddDistribution = answer;

        if strcmp(answer,'linear')
            addDistribution = answer{1};
            prompt = {'Slope'};
            dlgtitle = 'Individualized Input';
            dims = [1 40];
            definput = {'0.1'};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            infoAddDisPar = answer;
            addDisPar = str2double(answer);
        else
            addDistribution = str2num(answer{1});
            addDisPar = 'none';
            infoAddDisPar = answer;
        end
        
        keff = k_ZSM_1_addDistribution_calculator(...
            [kAM;kCA;kB],output_volumeFractionsMatrix,...
            kMedium,porosity,'curveRAreaContact',...
            nameModelAdd,nameModeTortuosity,a,c,e,g,addDistribution,addDisPar);
        additional = {infoAddDistribution;infoAddDisPar};
        additionalInfo = {'Distribution of additive';'Slope of the distribution'};
    
    elseif strcmp(model,strModel(9))
        prompt = {'Distribution: e.g. ''linear'' or [0.1;0.2;0.3;0.4]'};
        dlgtitle = 'Individualized Input';
        dims = [1 40];
        definput = {'linear'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        infoAddDistribution = answer;

        if strcmp(answer,'linear')
            addDistribution = answer{1};
            prompt = {'Slope'};
            dlgtitle = 'Individualized Input';
            dims = [1 40];
            definput = {'0.1'};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            infoAddDisPar = answer;
            addDisPar = str2double(answer);
        else
            addDistribution = str2num(answer{1});
            addDisPar = 'none';
            infoAddDisPar = answer;
        end
        
        keff = k_ZSM_1_a_addDistribution_calculator(...
            [kAM;kCA;kB],output_volumeFractionsMatrix,...
            kMedium,porosity,'curveRAreaContact',...
            nameModelAdd,nameModeTortuosity,a,c,e,g,addDistribution,addDisPar);
        additional = {infoAddDistribution;infoAddDisPar};
        additionalInfo = {'Distribution of additive';'Slope of the distribution'};
    end
    set(handles.textWaitBar,'Position',[0 0 121 1])
    set(handles.textWaitBar,'String','Calculated','HorizontalAlignment','Center')
    pause(0.03)
    set(handles.editResult,'String',num2str(keff));
    setappdata(0,'editResult',keff)

    
    A = {dirClock;fractionType;nameAM{1};kAM;frAM*100;nameCA{1};kCA;frCA*100;nameB{1};kB;frB*100;...
        nameMedium{1};kMedium;porosity*100;model{1};keff};
    B = {'Time';'Fraction Mode';'AM';'k_AM';'fr_AM';'CA';'k_CA';'fr_CA';'B';'k_B';'fr_B';...
        'Medium';'k_Medium';'Porosity (%)';'Model';'keff'};
    A = [A;additional];
    B = [B;additionalInfo];

    if ispc
        T = table(A,'RowNames',B);
        writetable(T,['results\thermalConductivity_',dirClock,'.xlsx'],'WriteVariableNames',false,'WriteRowNames',true)
        clear T
    elseif isunix
        T = table(A,'RowNames',B);
        writetable(T,['results/thermalConductivity_',dirClock,'.xlsx'],'WriteVariableNames',false,'WriteRowNames',true)
        clear T
    else
        disp('Platform not supported')
    end
    
    set(handles.textWaitBar,'Position',[0 0 121 1])
    set(handles.textWaitBar,'String','Completed','HorizontalAlignment','Center')
    
    for ii = 1 : 100
        pause(0.03)
        set(handles.textWaitBar,'BackgroundColor',[0.47, 0.67, 0.19] + ([0.9,0.9,1] -  [0.47, 0.67, 0.19]) * (ii/100))
    end
    set(handles.textWaitBar,'String','','Position',[0 0 0 1])

catch
    set(handles.editResult,'String','Result');
    setappdata(0,'editResult',[])
    msgbox('Please check if each field is filled corrected.')
    set(handles.textWaitBar,'BackgroundColor','r')
    set(handles.textWaitBar,'String','Error','HorizontalAlignment','Center')
    setappdata(0,'backgroundColor',[1 0 0])
    for ii = 1 : 100
        pause(0.03)
        set(handles.textWaitBar,'BackgroundColor',[1,0,0] + ([0.9,0.9,1] -  [1,0,0]) * (ii/100))
    end
    set(handles.textWaitBar,'String','','Position',[0 0 0 1])
end

% --- Executes on selection change in popupmenuFractionType.
function popupmenuFractionType_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuFractionType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuFractionType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuFractionType
numFractionType = get(handles.popupmenuFractionType,'Value');
strFractionType = get(handles.popupmenuFractionType,'String');
setappdata(0,'popupmenuFractionType',strFractionType(numFractionType))


% --- Executes during object creation, after setting all properties.
function popupmenuFractionType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuFractionType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function editOtherAM_Callback(hObject, eventdata, handles)
% hObject    handle to editOtherAM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOtherAM as text
%        str2double(get(hObject,'String')) returns contents of editOtherAM as a double
otherAM = get(handles.editOtherAM,'String');
if ~isnan(str2double(otherAM)) % is a number
    set(handles.popupmenuAM,'Value',get(handles.popupmenuAM,'Value'))
    setappdata(0,'popupmenuAM',{'Other'})
    setappdata(0,'editOtherAM',str2double(otherAM))
    set(handles.popupmenuFractionType,'String',{'Volume Fraction (vol. %)'})
    set(handles.popupmenuFractionType,'Enable','Off')
    setappdata(0,'popupmenuFractionType','Volume Fraction (vol. %)')
else
    load tables statistics
    numAM = get(handles.popupmenuAM,'Value');
    strAM = get(handles.popupmenuAM,'String');
    if any(strcmp(strAM,otherAM))
        numAM = find(strcmp(strAM,otherAM),1);
        set(handles.popupmenuAM,'Value',numAM)
        setappdata(0,'popupmenuAM',strAM(numAM))
        AM = statistics(strAM(numAM),:);
        kAM = AM.thermalConductivity;
        set(handles.editOtherAM,'Enable','Off')
        set(handles.editOtherAM,'Visible','On')
        set(handles.editOtherAM,'String',num2str(kAM));
        setappdata(0,'editOtherAM',kAM)
    else
        try
            AM = statistics(otherAM,:); 
            strAM(numAM) = {otherAM};
            strAM(numAM + 1) = {'Other'};
            set(handles.popupmenuAM,'Value',numAM)
            set(handles.popupmenuAM,'String',strAM);
            setappdata(0,'popupmenuAM',strAM(numAM))
            kAM = AM.thermalConductivity;
            set(handles.editOtherAM,'Enable','Off')
            set(handles.editOtherAM,'Visible','On')
            set(handles.editOtherAM,'String',num2str(kAM));
            setappdata(0,'editOtherAM',kAM)
        catch
            set(handles.editOtherAM,'String','...')
            setappdata(0,'editOtherAM',[])
            msgbox('Please enter the name of a material which can be found in the table: statistics.')
        end
    end
    nameAM = getappdata(0,'popupmenuAM');
    nameCA = getappdata(0,'popupmenuCA');
    nameB = getappdata(0,'popupmenuB');
    if ~(strcmp(nameAM,'Other') || strcmp(nameCA,'Other') || strcmp(nameB,'Other'))
        set(handles.popupmenuFractionType,'Enable','On')
        set(handles.popupmenuFractionType,'String',{'Mass Fraction (wt. %)','Volume Fraction (vol. %)'})
        setappdata(0,'popupmenuFractionType','Mass Fraction (wt. %)')
    else
        set(handles.popupmenuFractionType,'String',{'Volume Fraction (vol. %)'})
        set(handles.popupmenuFractionType,'Enable','Off')
        setappdata(0,'popupmenuFractionType','Volume Fraction (vol. %)')
    end 
end


% --- Executes during object creation, after setting all properties.
function editOtherAM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOtherAM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Visible','Off')



function editOtherCA_Callback(hObject, eventdata, handles)
% hObject    handle to editOtherCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOtherCA as text
%        str2double(get(hObject,'String')) returns contents of editOtherCA as a double
otherCA = get(handles.editOtherCA,'String');
if ~isnan(str2double(otherCA)) % is a number
    set(handles.popupmenuCA,'Value',get(handles.popupmenuCA,'Value'))
    setappdata(0,'popupmenuCA',{'Other'})
    setappdata(0,'editOtherCA',str2double(otherCA))
    set(handles.popupmenuFractionType,'String',{'Volume Fraction (vol. %)'})
    set(handles.popupmenuFractionType,'Enable','Off')
    setappdata(0,'popupmenuFractionType','Volume Fraction (vol. %)')
else
    load tables statistics
    numCA = get(handles.popupmenuCA,'Value');
    strCA = get(handles.popupmenuCA,'String');
    if any(strcmp(strCA,otherCA))
        numCA = find(strcmp(strCA,otherCA),1);
        set(handles.popupmenuCA,'Value',numCA)
        setappdata(0,'popupmenuCA',strCA(numCA))
        CA = statistics(strCA(numCA),:);
        kCA = CA.thermalConductivity;
        set(handles.editOtherCA,'Enable','Off')
        set(handles.editOtherCA,'Visible','On')
        set(handles.editOtherCA,'String',num2str(kCA));
        setappdata(0,'editOtherCA',kCA)
    else
        try
            CA = statistics(otherCA,:); 
            strCA(numCA) = {otherCA};
            strCA(numCA + 1) = {'Other'};
            set(handles.popupmenuCA,'Value',numCA)
            set(handles.popupmenuCA,'String',strCA);
            setappdata(0,'popupmenuCA',strCA(numCA))
            kCA = CA.thermalConductivity;
            set(handles.editOtherCA,'Enable','Off')
            set(handles.editOtherCA,'Visible','On')
            set(handles.editOtherCA,'String',num2str(kCA));
            setappdata(0,'editOtherCA',kCA)
        catch
            set(handles.editOtherCA,'String','...')
            setappdata(0,'editOtherCA',[])
            msgbox('Please enter the name of a material which can be found in the table: statistics.')
        end
    end
    nameAM = getappdata(0,'popupmenuCA');
    nameCA = getappdata(0,'popupmenuCA');
    nameB = getappdata(0,'popupmenuB');
    if ~(strcmp(nameAM,'Other') || strcmp(nameCA,'Other') || strcmp(nameB,'Other'))
        set(handles.popupmenuFractionType,'Enable','On')
        set(handles.popupmenuFractionType,'String',{'Mass Fraction (wt. %)','Volume Fraction (vol. %)'})
        setappdata(0,'popupmenuFractionType','Mass Fraction (wt. %)')
    else
        set(handles.popupmenuFractionType,'String',{'Volume Fraction (vol. %)'})
        set(handles.popupmenuFractionType,'Enable','Off')
        setappdata(0,'popupmenuFractionType','Volume Fraction (vol. %)')
    end  
end

% --- Executes during object creation, after setting all properties.
function editOtherCA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOtherCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Visible','Off')

function editOtherB_Callback(hObject, eventdata, handles)
% hObject    handle to editOtherB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOtherB as text
%        str2double(get(hObject,'String')) returns contents of editOtherB as a double
otherB = get(handles.editOtherB,'String');
if ~isnan(str2double(otherB))
    set(handles.popupmenuB,'Value',get(handles.popupmenuB,'Value'))
    setappdata(0,'popupmenuB',{'Other'})
    setappdata(0,'editOtherB',str2double(otherB))
    set(handles.popupmenuFractionType,'String',{'Volume Fraction (vol. %)'})
    set(handles.popupmenuFractionType,'Enable','Off')
    setappdata(0,'popupmenuFractionType','Volume Fraction (vol. %)')
else
    load tables statistics
    numB = get(handles.popupmenuB,'Value');
    strB = get(handles.popupmenuB,'String');
    if any(strcmp(strB,otherB))
        numB = find(strcmp(strB,otherB),1);
        set(handles.popupmenuB,'Value',numB)
        setappdata(0,'popupmenuB',strB(numB))
        B = statistics(strB(numB),:);
        kB = B.thermalConductivity;
        set(handles.editOtherB,'Enable','Off')
        set(handles.editOtherB,'Visible','On')
        set(handles.editOtherB,'String',num2str(kB));
        setappdata(0,'editOtherB',kB)
    else
        try
            B = statistics(otherB,:); 
            strB(numB) = {otherB};
            strB(numB + 1) = {'Other'};
            set(handles.popupmenuB,'Value',numB)
            set(handles.popupmenuB,'String',strB);
            setappdata(0,'popupmenuB',strB(numB))
            kB = B.thermalConductivity;
            set(handles.editOtherB,'Enable','Off')
            set(handles.editOtherB,'Visible','On')
            set(handles.editOtherB,'String',num2str(kB));
            setappdata(0,'editOtherB',kB)
        catch
            set(handles.editOtherB,'String','...')
            setappdata(0,'editOtherB',[])
            msgbox('Please enter the name of a material which can be found in the table: statistics.')
        end
    end
    nameAM = getappdata(0,'popupmenuB');
    nameCA = getappdata(0,'popupmenuCA');
    nameB = getappdata(0,'popupmenuB');
    if ~(strcmp(nameAM,'Other') || strcmp(nameCA,'Other') || strcmp(nameB,'Other'))
        set(handles.popupmenuFractionType,'Enable','On')
        set(handles.popupmenuFractionType,'String',{'Mass Fraction (wt. %)','Volume Fraction (vol. %)'})
        setappdata(0,'popupmenuFractionType','Mass Fraction (wt. %)')
    else
        set(handles.popupmenuFractionType,'String',{'Volume Fraction (vol. %)'})
        set(handles.popupmenuFractionType,'Enable','Off')
        setappdata(0,'popupmenuFractionType','Volume Fraction (vol. %)')
    end 
end

% --- Executes during object creation, after setting all properties.
function editOtherB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOtherB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Visible','Off')

function editOtherMedium_Callback(hObject, eventdata, handles)
% hObject    handle to editOtherMedium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOtherMedium as text
%        str2double(get(hObject,'String')) returns contents of editOtherMedium as a double
otherMedium = get(handles.editOtherMedium,'String');
if ~isnan(str2double(otherMedium))
    set(handles.popupmenuMedium,'Value',get(handles.popupmenuMedium,'Value'))
    setappdata(0,'popupmenuMedium',{'Other'})
    setappdata(0,'editOtherMedium',str2double(otherMedium))
    set(handles.popupmenuFractionType,'String',{'Volume Fraction (vol. %)'})
    set(handles.popupmenuFractionType,'Enable','Off')
    setappdata(0,'popupmenuFractionType','Volume Fraction (vol. %)')
else
    load tables statistics
    numMedium = get(handles.popupmenuMedium,'Value');
    strMedium = get(handles.popupmenuMedium,'String');
    if any(strcmp(strMedium,otherMedium))
        numMedium = find(strcmp(strMedium,otherMedium),1);
        set(handles.popupmenuMedium,'Value',numMedium)
        setappdata(0,'popupmenuMedium',strMedium(numMedium))
        Medium = statistics(strMedium(numMedium),:);
        kMedium = Medium.thermalConductivity;
        set(handles.editOtherMedium,'Enable','Off')
        set(handles.editOtherMedium,'Visible','On')
        set(handles.editOtherMedium,'String',num2str(kMedium));
        setappdata(0,'editOtherMedium',kMedium)
    else
        try
            Medium = statistics(otherMedium,:); 
            strMedium(numMedium) = {otherMedium};
            strMedium(numMedium + 1) = {'Other'};
            set(handles.popupmenuMedium,'Value',numMedium)
            set(handles.popupmenuMedium,'String',strMedium);
            setappdata(0,'popupmenuMedium',strMedium(numMedium))
            kMedium = Medium.thermalConductivity;
            set(handles.editOtherMedium,'Enable','Off')
            set(handles.editOtherMedium,'Visible','On')
            set(handles.editOtherMedium,'String',num2str(kMedium));
            setappdata(0,'editOtherMedium',kMedium)
        catch
            set(handles.editOtherMedium,'String','...')
            setappdata(0,'editOtherMedium',[])
            msgbox('Please enter the name of a material which can be found in the table: statistics.')
        end
    end
end

% --- Executes during object creation, after setting all properties.
function editOtherMedium_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOtherMedium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Visible','Off')



function editOtherModelAdd_Callback(hObject, eventdata, handles)
% hObject    handle to editOtherModelAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOtherModelAdd as text
%        str2double(get(hObject,'String')) returns contents of editOtherModelAdd as a double
otherModelAdd = get(handles.editOtherModelAdd,'String');
numModelAdd = get(handles.popupmenuModelAdd,'Value');
strModelAdd = get(handles.popupmenuModelAdd,'String');
if any(strcmp(strModelAdd,otherModelAdd))
    numModelAdd = find(strcmp(strModelAdd,otherModelAdd),1);
    set(handles.popupmenuModelAdd,'Value',numModelAdd)
    setappdata(0,'popupmenuModelAdd',strModelAdd(numModelAdd))
    set(handles.editOtherModelAdd,'Enable','Off')
    set(handles.editOtherModelAdd,'Visible','On')
    set(handles.editOtherModelAdd,'String',strModelAdd(numModelAdd));
    setappdata(0,'editOtherModelAdd',strModelAdd(numModelAdd))
else
    try
        keff = k_model_out_of_name_calculator([1;1],0.5,'none',0,otherModelAdd);
        strModelAdd(numModelAdd) = {otherModelAdd};
        strModelAdd(numModelAdd + 1) = {'Other'};
        set(handles.popupmenuModelAdd,'Value',numModelAdd)
        set(handles.popupmenuModelAdd,'String',strModelAdd);
        setappdata(0,'popupmenuModelAdd',strModelAdd(numModelAdd))
        set(handles.editOtherModelAdd,'Enable','Off')
        set(handles.editOtherModelAdd,'Visible','On')
        set(handles.editOtherModelAdd,'String',strModelAdd(numModelAdd));
        setappdata(0,'editOtherModelAdd',strModelAdd(numModelAdd))
    catch
        set(handles.editOtherModelAdd,'String','...')
        setappdata(0,'editOtherModelAdd',[])
        msgbox('Please enter the existing name of a model for the binary addtive system.')
    end
        
end


% --- Executes during object creation, after setting all properties.
function editOtherModelAdd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOtherModelAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Visible','Off')



function editOtherModeTortuosity_Callback(hObject, eventdata, handles)
% hObject    handle to editOtherModeTortuosity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOtherModeTortuosity as text
%        str2double(get(hObject,'String')) returns contents of editOtherModeTortuosity as a double
otherModeTortuosity = get(handles.editOtherModeTortuosity,'String');
numModeTortuosity = get(handles.popupmenuModeTortuosity,'Value');
strModeTortuosity = get(handles.popupmenuModeTortuosity,'String');
if any(strcmp(strModeTortuosity,otherModeTortuosity))
    numModeTortuosity = find(strcmp(strModeTortuosity,otherModeTortuosity),1);
    set(handles.popupmenuModeTortuosity,'Value',numModeTortuosity)
    setappdata(0,'popupmenuModeTortuosity',strModeTortuosity(numModeTortuosity))
    set(handles.editOtherModeTortuosity,'Enable','Off')
    set(handles.editOtherModeTortuosity,'Visible','On')
    if numModeTortuosity == 1
        set(handles.editOtherModeTortuosity,'String',strModeTortuosity(1));
    elseif numModeTortuosity == 2
        set(handles.editOtherModeTortuosity,'String','y = x/(1 - sqrt[1-x])');
    elseif numModeTortuosity == 3
        set(handles.editOtherModeTortuosity,'String','y = x^(-0.5)');
    elseif numModeTortuosity == 4
        set(handles.editOtherModeTortuosity,'String','y = 1.8 * x^(-0.53)');
    else
        set(handles.editOtherModeTortuosity,'String',strModeTortuosity(numModeTortuosity));
    end
    setappdata(0,'editOtherModeTortuosity',strModeTortuosity(numModeTortuosity))
else
    try
        tau = tortuosity_calculator(0.5,str2double(otherModeTortuosity));
        strModeTortuosity(numModeTortuosity) = {otherModeTortuosity};
        strModeTortuosity(numModeTortuosity + 1) = {'Other'};
        set(handles.popupmenuModeTortuosity,'Value',numModeTortuosity)
        set(handles.popupmenuModeTortuosity,'String',strModeTortuosity);
        setappdata(0,'popupmenuModeTortuosity',strModeTortuosity(numModeTortuosity))
        set(handles.editOtherModeTortuosity,'Enable','Off')
        set(handles.editOtherModeTortuosity,'Visible','On')
        set(handles.editOtherModeTortuosity,'String',strModeTortuosity(numModeTortuosity));
        setappdata(0,'editOtherModeTortuosity',strModeTortuosity(numModeTortuosity))
    catch
        set(handles.editOtherModeTortuosity,'String','...')
        setappdata(0,'editOtherModeTortuosity',[])
        msgbox('Please enter the number of tortuosity mode which exists in the function tortuosity_calculator.')
    end
        
end


% --- Executes during object creation, after setting all properties.
function editOtherModeTortuosity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOtherModeTortuosity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Visible','Off')


% --- Executes on selection change in popupmenuAFit.
function popupmenuAFit_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuAFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuAFit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuAFit
set(handles.popupmenuFittingA,'Visible','Off')
set(handles.popupmenuFittingA,'Enable','Off')
set(handles.popupmenuFittingA,'Value',[])
setappdata(0,'popupmenuFittingA',[])
numAFit = get(handles.popupmenuAFit,'Value');
strAFit = get(handles.popupmenuAFit,'String');
setappdata(0,'popupmenuAFit',strAFit(numAFit))
if strcmp(strAFit(numAFit),'Other')
    set(handles.editAFit,'Enable','On')
    set(handles.editAFit,'Visible','On')
    set(handles.editAFit,'String','...')
    setappdata(0,'editAFit',[])
elseif strcmp(strAFit(numAFit),'Please Choose')
    set(handles.editAFit,'Visible','Off')
    set(handles.editAFit,'Enable','Off')
    set(handles.editAFit,'String',[]);
    setappdata(0,'editAFit',[])
else
    set(handles.editAFit,'Visible','On')
    set(handles.editAFit,'Enable','Off')
    set(handles.editAFit,'String',strAFit(numAFit));
    setappdata(0,'editAFit',strAFit(numAFit))
    
    if numAFit == 2 || numAFit == 3 || numAFit == 4 || numAFit == 5
        set(handles.popupmenuFittingA,'Visible','On')
        set(handles.popupmenuFittingA,'Enable','On')
        set(handles.popupmenuFittingA,'Value',1)
        setappdata(0,'popupmenuFittingA',{'Linear'})
    end
end
set(handles.textTickA,'Visible','Off')
set(handles.textTickC,'Visible','Off')
set(handles.textTickE,'Visible','Off')
set(handles.textTickG,'Visible','Off')


% --- Executes during object creation, after setting all properties.
function popupmenuAFit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuAFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuCFit.
function popupmenuCFit_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuCFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuCFit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuCFit
set(handles.popupmenuFittingC,'Visible','Off')
set(handles.popupmenuFittingC,'Enable','Off')
set(handles.popupmenuFittingC,'Value',[])
setappdata(0,'popupmenuFittingC',[])
numCFit = get(handles.popupmenuCFit,'Value');
strCFit = get(handles.popupmenuCFit,'String');
setappdata(0,'popupmenuCFit',strCFit(numCFit))
if strcmp(strCFit(numCFit),'Other')
    set(handles.editCFit,'Enable','On')
    set(handles.editCFit,'Visible','On')
    set(handles.editCFit,'String','...')
    setappdata(0,'editCFit',[])
elseif strcmp(strCFit(numCFit),'Please Choose')
    set(handles.editCFit,'Visible','Off')
    set(handles.editCFit,'Enable','Off')
    set(handles.editCFit,'String',[]);
else
    set(handles.editCFit,'Visible','On')
    set(handles.editCFit,'Enable','Off')
    set(handles.editCFit,'String',strCFit(numCFit));
    setappdata(0,'editCFit',strCFit(numCFit))
    if numCFit == 2 || numCFit == 3 || numCFit == 4 || numCFit == 5
        set(handles.popupmenuFittingC,'Visible','On')
        set(handles.popupmenuFittingC,'Enable','On')
        set(handles.popupmenuFittingC,'Value',1)
        setappdata(0,'popupmenuFittingC',{'Linear'})
    end
end
set(handles.textTickA,'Visible','Off')
set(handles.textTickC,'Visible','Off')
set(handles.textTickE,'Visible','Off')
set(handles.textTickG,'Visible','Off')


% --- Executes during object creation, after setting all properties.
function popupmenuCFit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuCFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuEFit.
function popupmenuEFit_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuEFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuEFit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuEFit
set(handles.popupmenuFittingE,'Visible','Off')
set(handles.popupmenuFittingE,'Enable','Off')
set(handles.popupmenuFittingE,'Value',[])
setappdata(0,'popupmenuFittingE',[])
numEFit = get(handles.popupmenuEFit,'Value');
strEFit = get(handles.popupmenuEFit,'String');
setappdata(0,'popupmenuEFit',strEFit(numEFit))
if strcmp(strEFit(numEFit),'Other')
    set(handles.editEFit,'Enable','On')
    set(handles.editEFit,'Visible','On')
    set(handles.editEFit,'String','...')
    setappdata(0,'editEFit',[])
elseif strcmp(strEFit(numEFit),'Please Choose')
    set(handles.editEFit,'Visible','Off')
    set(handles.editEFit,'Enable','Off')
    set(handles.editEFit,'String',[]);
else
    set(handles.editEFit,'Visible','On')
    set(handles.editEFit,'Enable','Off')
    set(handles.editEFit,'String',strEFit(numEFit));
    setappdata(0,'editEFit',strEFit(numEFit))
        if numEFit == 2 || numEFit == 3 || numEFit == 4 || numEFit == 5
        set(handles.popupmenuFittingE,'Visible','On')
        set(handles.popupmenuFittingE,'Enable','On')
        set(handles.popupmenuFittingE,'Value',1)
        setappdata(0,'popupmenuFittingE',{'Linear'})
    end
end
set(handles.textTickA,'Visible','Off')
set(handles.textTickC,'Visible','Off')
set(handles.textTickE,'Visible','Off')
set(handles.textTickG,'Visible','Off')


% --- Executes during object creation, after setting all properties.
function popupmenuEFit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuEFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuGFit.
function popupmenuGFit_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuGFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuGFit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuGFit

set(handles.popupmenuFittingG,'Visible','Off')
set(handles.popupmenuFittingG,'Enable','Off')
set(handles.popupmenuFittingG,'Value',[])
setappdata(0,'popupmenuFittingG',[])
numGFit = get(handles.popupmenuGFit,'Value');
strGFit = get(handles.popupmenuGFit,'String');
setappdata(0,'popupmenuGFit',strGFit(numGFit))
if strcmp(strGFit(numGFit),'Other')
    set(handles.editGFit,'Enable','On')
    set(handles.editGFit,'Visible','On')
    set(handles.editGFit,'String','...')
    setappdata(0,'editGFit',[])
elseif strcmp(strGFit(numGFit),'Please Choose')
    set(handles.editGFit,'Visible','Off')
    set(handles.editGFit,'Enable','Off')
    set(handles.editGFit,'String',[]);
else
    set(handles.editGFit,'Visible','On')
    set(handles.editGFit,'Enable','Off')
    set(handles.editGFit,'String',strGFit(numGFit));
    setappdata(0,'editGFit',strGFit(numGFit))
    if numGFit == 2 || numGFit == 3 || numGFit == 4 || numGFit == 5
        set(handles.popupmenuFittingG,'Visible','On')
        set(handles.popupmenuFittingG,'Enable','On')
        set(handles.popupmenuFittingG,'Value',1)
        setappdata(0,'popupmenuFittingG',{'Linear'})
    end
end
set(handles.textTickA,'Visible','Off')
set(handles.textTickC,'Visible','Off')
set(handles.textTickE,'Visible','Off')
set(handles.textTickG,'Visible','Off')


% --- Executes during object creation, after setting all properties.
function popupmenuGFit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuGFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editAFit_Callback(hObject, eventdata, handles)
% hObject    handle to editAFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAFit as text
%        str2double(get(hObject,'String')) returns contents of editAFit as a double
aFit = get(handles.editAFit,'String');
numAFit = get(handles.popupmenuAFit,'Value');
strAFit = get(handles.popupmenuAFit,'String');
if any(strcmp(strAFit,aFit))
    numAFit = find(strcmp(strAFit,aFit),1);
    set(handles.popupmenuAFit,'Value',numAFit)
    setappdata(0,'popupmenuAFit',strAFit(numAFit))
    set(handles.editAFit,'Enable','Off')
    set(handles.editAFit,'Visible','On')
    set(handles.editAFit,'String',strAFit(numAFit));
    setappdata(0,'editAFit',strAFit(numAFit))
else
    
    if ~isnan(str2double(aFit))
        isDouble = 1;
        isFunction = 0;
    else
        isDouble = 0;
        if (length(aFit) < 13)|| ~strcmp(aFit(1:13),'@(porosity_i)')
            isFunction = 0;
        else
            try
                tempAFit = str2func(aFit);
                tempAFit(0.5);
                isFunction = 1;
            catch
                isFunction = 0;
            end
        end
    end
    
    if ((isDouble == 1) && (str2double(aFit) >= 0 && str2double(aFit) <= 1))|| (isFunction == 1)
        strAFit(numAFit) = {aFit};
        strAFit(numAFit + 1) = {'Other'};
        set(handles.popupmenuAFit,'Value',numAFit)
        set(handles.popupmenuAFit,'String',strAFit);
        setappdata(0,'popupmenuAFit',strAFit(numAFit))
        set(handles.editAFit,'Enable','Off')
        set(handles.editAFit,'Visible','On')
        set(handles.editAFit,'String',strAFit(numAFit));
        setappdata(0,'editAFit',strAFit(numAFit))
    else
        set(handles.editAFit,'String','...')
        setappdata(0,'editAFit',[])
        msgbox('Please enter a Level, a function handle @(porosity_i) or a reasonble number for the parameter.')
    end

end
if numAFit == 2 || numAFit == 3 || numAFit == 4 || numAFit == 5
    set(handles.popupmenuFittingA,'Visible','On')
    set(handles.popupmenuFittingA,'Enable','On')
    set(handles.popupmenuFittingA,'Value',1)
    setappdata(0,'popupmenuFittingA',{'Linear'})
else
    set(handles.popupmenuFittingA,'Visible','Off')
    set(handles.popupmenuFittingA,'Enable','Off')
    set(handles.popupmenuFittingA,'Value',[])
    setappdata(0,'popupmenuFittingA',[])

end


% --- Executes during object creation, after setting all properties.
function editAFit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editCFit_Callback(hObject, eventdata, handles)
% hObject    handle to editCFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editCFit as text
%        str2double(get(hObject,'String')) returns contents of editCFit as a double
cFit = get(handles.editCFit,'String');
numCFit = get(handles.popupmenuCFit,'Value');
strCFit = get(handles.popupmenuCFit,'String');
if any(strcmp(strCFit,cFit))
    numCFit = find(strcmp(strCFit,cFit),1);
    set(handles.popupmenuCFit,'Value',numCFit)
    setappdata(0,'popupmenuCFit',strCFit(numCFit))
    set(handles.editCFit,'Enable','Off')
    set(handles.editCFit,'Visible','On')
    set(handles.editCFit,'String',strCFit(numCFit));
    setappdata(0,'editCFit',strCFit(numCFit))
else
    if ~isnan(str2double(cFit))
        isDouble = 1;
        isFunction = 0;
    else
        isDouble = 0;
        if (length(cFit) < 13)|| ~strcmp(cFit(1:13),'@(porosity_i)')
            isFunction = 0;
        else
            try
                tempCFit = str2func(cFit);
                tempCFit(0.5);
                isFunction = 1;
            catch
                isFunction = 0;
            end
        end
    end
    
    if ((isDouble == 1) && (str2double(cFit) >= 0 && str2double(cFit) <= 1))|| (isFunction == 1)
        strCFit(numCFit) = {cFit};
        strCFit(numCFit + 1) = {'Other'};
        set(handles.popupmenuCFit,'Value',numCFit)
        set(handles.popupmenuCFit,'String',strCFit);
        setappdata(0,'popupmenuCFit',strCFit(numCFit))
        set(handles.editCFit,'Enable','Off')
        set(handles.editCFit,'Visible','On')
        set(handles.editCFit,'String',strCFit(numCFit));
        setappdata(0,'editCFit',strCFit(numCFit))
    else
        set(handles.editCFit,'String','...')
        setappdata(0,'editCFit',[])
        msgbox('Please enter a Level, a function handle @(porosity_i) or a reasonble number for the parameter.')
    end

end
if numCFit == 2 || numCFit == 3 || numCFit == 4 || numCFit == 5
    set(handles.popupmenuFittingC,'Visible','On')
    set(handles.popupmenuFittingC,'Enable','On')
    set(handles.popupmenuFittingC,'Value',1)
    setappdata(0,'popupmenuFittingC',{'Linear'})
else
    set(handles.popupmenuFittingC,'Visible','Off')
    set(handles.popupmenuFittingC,'Enable','Off')
    set(handles.popupmenuFittingC,'Value',[])
    setappdata(0,'popupmenuFittingC',[])

end


% --- Executes during object creation, after setting all properties.
function editCFit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editCFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEFit_Callback(hObject, eventdata, handles)
% hObject    handle to editEFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEFit as text
%        str2double(get(hObject,'String')) returns contents of editEFit as a double
eFit = get(handles.editEFit,'String');
numEFit = get(handles.popupmenuEFit,'Value');
strEFit = get(handles.popupmenuEFit,'String');
if any(strcmp(strEFit,eFit))
    numEFit = find(strcmp(strEFit,eFit),1);
    set(handles.popupmenuEFit,'Value',numEFit)
    setappdata(0,'popupmenuEFit',strEFit(numEFit))
    set(handles.editEFit,'Enable','Off')
    set(handles.editEFit,'Visible','On')
    set(handles.editEFit,'String',strEFit(numEFit));
    setappdata(0,'editEFit',strEFit(numEFit))
else
    if ~isnan(str2double(eFit))
        isDouble = 1;
        isFunction = 0;
    else
        isDouble = 0;
        if (length(eFit) < 13)|| ~strcmp(eFit(1:13),'@(porosity_i)')
            isFunction = 0;
        else
            try
                tempEFit = str2func(eFit);
                tempEFit(0.5);
                isFunction = 1;
            catch
                isFunction = 0;
            end
        end
    end
    
    if ((isDouble == 1) && (str2double(eFit) >= 0 && str2double(eFit) <= 1))|| (isFunction == 1)
        strEFit(numEFit) = {eFit};
        strEFit(numEFit + 1) = {'Other'};
        set(handles.popupmenuEFit,'Value',numEFit)
        set(handles.popupmenuEFit,'String',strEFit);
        setappdata(0,'popupmenuEFit',strEFit(numEFit))
        set(handles.editEFit,'Enable','Off')
        set(handles.editEFit,'Visible','On')
        set(handles.editEFit,'String',strEFit(numEFit));
        setappdata(0,'editEFit',strEFit(numEFit))
    else
        set(handles.editEFit,'String','...')
        setappdata(0,'editEFit',[])
        msgbox('Please enter a Level, a function handle @(porosity_i) or a reasonble number for the parameter.')
    end

end
if numEFit == 2 || numEFit == 3 || numEFit == 4 || numEFit == 5
    set(handles.popupmenuFittingE,'Visible','On')
    set(handles.popupmenuFittingE,'Enable','On')
    set(handles.popupmenuFittingE,'Value',1)
    setappdata(0,'popupmenuFittingE',{'Linear'})
else
    set(handles.popupmenuFittingE,'Visible','Off')
    set(handles.popupmenuFittingE,'Enable','Off')
    set(handles.popupmenuFittingE,'Value',[])
    setappdata(0,'popupmenuFittingE',[])

end


% --- Executes during object creation, after setting all properties.
function editEFit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editGFit_Callback(hObject, eventdata, handles)
% hObject    handle to editGFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editGFit as text
%        str2double(get(hObject,'String')) returns contents of editGFit as a double
gFit = get(handles.editGFit,'String');
numGFit = get(handles.popupmenuGFit,'Value');
strGFit = get(handles.popupmenuGFit,'String');
if any(strcmp(strGFit,gFit))
    numGFit = find(strcmp(strGFit,gFit),1);
    set(handles.popupmenuGFit,'Value',numGFit)
    setappdata(0,'popupmenuGFit',strGFit(numGFit))
    set(handles.editGFit,'Enable','Off')
    set(handles.editGFit,'Visible','On')
    set(handles.editGFit,'String',strGFit(numGFit));
    setappdata(0,'editGFit',strGFit(numGFit))
else
    if ~isnan(str2double(gFit))
        isDouble = 1;
        isFunction = 0;
    else
        isDouble = 0;
        if (length(gFit) < 13)|| ~strcmp(gFit(1:13),'@(porosity_i)')
            isFunction = 0;
        else
            try
                tempGFit = str2func(gFit);
                tempGFit(0.5);
                isFunction = 1;
            catch
                isFunction = 0;
            end
        end
    end
    
    if ((isDouble == 1) && (str2double(gFit) >= 0 && str2double(gFit) <= 1))|| (isFunction == 1)
        strGFit(numGFit) = {gFit};
        strGFit(numGFit + 1) = {'Other'};
        set(handles.popupmenuGFit,'Value',numGFit)
        set(handles.popupmenuGFit,'String',strGFit);
        setappdata(0,'popupmenuGFit',strGFit(numGFit))
        set(handles.editGFit,'Enable','Off')
        set(handles.editGFit,'Visible','On')
        set(handles.editGFit,'String',strGFit(numGFit));
        setappdata(0,'editGFit',strGFit(numGFit))
    else
        set(handles.editGFit,'String','...')
        setappdata(0,'editGFit',[])
        msgbox('Please enter a Level, a function handle @(porosity_i) or a reasonble number for the parameter.')
    end

end
if numGFit == 2 || numGFit == 3 || numGFit == 4 || numGFit == 5
    set(handles.popupmenuFittingG,'Visible','On')
    set(handles.popupmenuFittingG,'Enable','On')
    set(handles.popupmenuFittingG,'Value',1)
    setappdata(0,'popupmenuFittingG',{'Linear'})
else
    set(handles.popupmenuFittingG,'Visible','Off')
    set(handles.popupmenuFittingG,'Enable','Off')
    set(handles.popupmenuFittingG,'Value',[])
    setappdata(0,'popupmenuFittingG',[])
end

% --- Executes during object creation, after setting all properties.
function editGFit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editGFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonFitting.
function pushbuttonFitting_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonFitting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
set(handles.textTickA,'Visible','Off')
set(handles.textTickC,'Visible','Off')
set(handles.textTickE,'Visible','Off')
set(handles.textTickG,'Visible','Off')

setappdata(0,'backgroundColor',[0.47, 0.67, 0.19])
set(handles.textWaitBar,'ForegroundColor','w','FontWeight','Bold','BackgroundColor',[0.47, 0.67, 0.19])
set(handles.textWaitBar,'Position',[0 0 1 1])
set(handles.editResult,'String',[]);
pause(0.2)

answer = questdlg('Do you want to replace all the divergent points by 0?', ...
	'Dealing with divergence', ...
	'Yes','No','No');
% Handle response
switch answer
    case 'No'
        modeDivergence = 0;
    case 'Yes'
        modeDivergence = 1;
end

try
    aFit = getappdata(0,'popupmenuAFit');
    numAFit = get(handles.popupmenuAFit,'Value');
    if numAFit == 1
        otherAFit = 0;
    else
        otherAFit = getappdata(0,'editAFit');
        otherAFit = otherAFit{1};        
    end

    cFit = getappdata(0,'popupmenuCFit');
    numCFit = get(handles.popupmenuCFit,'Value');
    if numCFit == 1
        otherCFit = 0;
    else
        otherCFit = getappdata(0,'editCFit');
        otherCFit = otherCFit{1};
    end

    eFit = getappdata(0,'popupmenuEFit');
    numEFit = get(handles.popupmenuEFit,'Value');
    if numEFit == 1
        otherEFit = 0;
    else
        otherEFit = getappdata(0,'editEFit');
        otherEFit = otherEFit{1};
    end

    gFit = getappdata(0,'popupmenuGFit');
    numGFit = get(handles.popupmenuGFit,'Value');
    if numGFit == 1
        otherGFit = 0;
    else
        otherGFit = getappdata(0,'editGFit');
        otherGFit = otherGFit{1};
    end
    
    paraFit = {otherAFit,otherCFit,otherEFit,otherGFit};

    set(handles.textWaitBar,'Position',[0 0 6 1])
    set(handles.textWaitBar,'String','Loading ...');  
    pause(0.2)
    
    numHWait = 0;
    nowHWait = 0;
    for ii = 1 : 4
        try
            if strcmp(paraFit{1,ii}(1:5),'Level')
                numHWait = numHWait + 1;
            end
        catch
            
        end
    end
    clear ii
 
    
    if sum(strcmp(paraFit,'Level 1')) > 1 || sum(strcmp(paraFit,'Level 2')) > 1 || sum(strcmp(paraFit,'Level 3')) > 1 || sum(strcmp(paraFit,'Level 4')) > 1
       error('Level number cannot be the same!')
    end
    
    set(handles.textWaitBar,'Position',[0 0 11 1])
    set(handles.textWaitBar,'String','Loading ...');    
    pause(0.2)

    % Fitting
    if ispc
        data = readtable('data\database.xlsx','ReadVariableNames',false,'ReadRowNames',true);
    elseif isunix
        data = readtable('data/database.xlsx','ReadVariableNames',false,'ReadRowNames',true);
    else
        disp('Platform not supported')
    end
    namesMatrix = cell(1,size(data,2));
    nameFiller = cell(1,size(data,2));
    vFrMatrix = zeros(2,size(data,2));
    porosity = zeros(1,size(data,2));
    k = zeros(1,size(data,2));
    for ii =  1 : size(data,2)
        namesMatrix{1,ii} = {data{2,ii}{1};data{3,ii}{1};data{4,ii}{1}};
        nameFiller{1,ii} = data{5,ii}{1};
        [vFrMatrix(1:2,ii),~] = fractionsMatrix_xPorosity_transfer(...
                                  namesMatrix{1,ii},[str2double(data{6,ii}{1});str2double(data{7,ii}{1})],'none',0,str2double(data{8,ii}{1}),0,0,0);
        porosity(1,ii) = str2double(data{9,ii}{1});
        k(1,ii) = str2double(data{10,ii}{1});
    end
    clear ii
    
    set(handles.textWaitBar,'Position',[0 0 16 1])
    set(handles.textWaitBar,'String','Loading ...');    
    pause(0.2)

    numModel = get(handles.popupmenuModel,'Value');
    if numModel == 2
        modelName = 'ZSM_1';
    elseif numModel == 3
        modelName = 'ZSM_1_a';
    end
    
    % curve name
    curveName = 'curveRAreaContact';

    % mode name for additive combination (conductive additive + binder)
    modelAdditiveName = getappdata(0,'popupmenuModelAdd');
    modelAdditiveName = modelAdditiveName{1};

    % tortuosity mode
    modeTortuosity = getappdata(0,'popupmenuModeTortuosity');
    modeTortuosity = str2double(modeTortuosity{1});
    
    set(handles.textWaitBar,'Position',[0 0 21 1])
    set(handles.textWaitBar,'String','Loaded');
    pause(0.2)
    
    if ~exist('results','dir')
        mkdir('results')
    end
    
    strClock = clock;
    dirClock = [num2str(strClock(1,1)),'-',num2str(strClock(1,2)),'-',num2str(strClock(1,3)),'-',num2str(strClock(1,4)),'-',num2str(strClock(1,5)),'-',num2str(round(strClock(1,6)))];
    
    if ispc
        if ~exist(['results\',dirClock],'dir')
            mkdir(['results\',dirClock])
        end
    elseif isunix
        if ~exist(['results/',dirClock],'dir')
            mkdir(['results/',dirClock])
        end
    else
        disp('Platform not supported')
    end
    
    % parameters
    PARAs = {'a','c','e','g'};
    if any(strcmp(paraFit,'Level 1'))
        fprintf('************************** Level 1 ************************** \n')
        nowHWait = nowHWait + 1;
        for jj = 1 : size(PARAs,2)
            if strcmp(paraFit{1,jj},'Level 1')
                paraValues{1,jj} = 'vary';
            elseif strcmp(paraFit{1,jj},'Level 2') || strcmp(paraFit{1,jj},'Level 3') || strcmp(paraFit{1,jj},'Level 4')
                paraValues{1,jj} = 0;
            elseif ~isnan(str2double(paraFit{1,jj}))
                paraValues{1,jj} = str2double(paraFit{1,jj});
            else strcmp(paraFit{1,jj}(1),'@')
                paraValues{1,jj} = paraFit{1,jj};
            end
        end
        clear jj
        
        epsilon = 1e-3; % accuracy for the derivate at the point 0
        FUNCs = '';
        funcValues = '';
        for jj = 1 : size(PARAs,2)
            if isnumeric(paraValues{1,jj})
               eval([PARAs{1,jj},'=',num2str(paraValues{1,jj}),';']) 
            elseif ischar(paraValues{1,jj}) && ~strcmp(paraValues{1,jj},'vary')
                eval([PARAs{1,jj},'=',paraValues{1,jj},';']) 
                strlen_FUNCs = strlength(FUNCs);
                FUNCs = insertAfter(FUNCs,strlen_FUNCs,[',',PARAs{1,jj}]);
                strlen_funcValues = strlength(funcValues);
                funcValues = insertAfter(funcValues,strlen_funcValues,[',',PARAs{1,jj},'(porosity(1,ii))']);
            else
                eval([PARAs{1,jj},'= zeros(1,size(data,2));']) 
                eval(['PARA = ','''',PARAs{1,jj},''';'])
                remark = cell(1,size(data,2));
            end
        end
        clear jj

        eval(['fittingType = getappdata(0,''popupmenuFitting',upper(PARA),''');'])
        fittingType = fittingType{1};


        % function handle to calculate the difference between simulated value and modelled value
        eval(['f = @ (k_i,namesMatrix_i,vFrMatrix_i,nameFiller_i,porosity_i,',PARA,FUNCs,') k_i - k_',modelName,'(namesMatrix_i,vFrMatrix_i,nameFiller_i,porosity_i,curveName,modelAdditiveName,modeTortuosity,a,c,e,g);'])

 
        f_PARA = cell(1,size(data,2));
        for ii = 1 : size(data,2)
            eval(['f_PARA{1,ii} = @(PARA) f(k(1,ii),namesMatrix{1,ii},vFrMatrix(1:2,ii),nameFiller{1,ii},porosity(1,ii),PARA',funcValues,');'])
        end
        clear ii
        
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : ',' 0/',num2str(size(data,2)),' (',num2str(round((sum(get(handles.textWaitBar,'Position') .* [0 0 1 0]) - 21) / 100 * 100,0)),' %)'],'HorizontalAlignment','Center');
        pause(0.2)
        for ii = 1 : size(data,2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : ',num2str(ii),'/',num2str(size(data,2)),' (', num2str(round((sum(get(handles.textWaitBar,'Position') .* [0 0 1 0]) - 21) / 100 * 100,0)),' %) ...'],'HorizontalAlignment','Center');
            pause(0.2)
            fprintf('------------ For data %d ------------\n',ii)
            options = optimset('Display','off');
            eval(['f_PARA{1,ii} = @(PARA) f(k(1,ii),namesMatrix{1,ii},vFrMatrix(1:2,ii),nameFiller{1,ii},porosity(1,ii),PARA',funcValues,');'])
            
            if f_PARA{1,ii}(0) < f_PARA{1,ii}(epsilon)  % monotonically increasing
                if f_PARA{1,ii}(0) == 0
                    eval([PARA,'(1,ii) = 0;'])
                elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) < 0.05
                    eval([PARA,'(1,ii) = 0;'])
                    fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) >= 0.05
                    fprintf('%s cannot be found for data %d.\n',PARA,ii)
                    eval([PARA,'(1,ii) = NaN;'])
                elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) < 0.05
                    eval([PARA,'(1,ii) = 0;'])
                    fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                else
                    fprintf('%s is being iterated for data %d.\n',PARA,ii)
                    para_iter = 0;
                    while f_PARA{1,ii}(para_iter) < 0
                       para_iter = para_iter + 0.05; 
                    end
                    eval([PARA,'(1,ii) = fzero(f_PARA{1,ii},[0 para_iter],options);'])
                    eval(['fprintf(''%s = %6.4f for data %d.\n'',PARA,',PARA,'(1,ii),ii)'])
                end
            elseif f_PARA{1,ii}(0) > f_PARA{1,ii}(epsilon)  % monotonically decreasing
                    if f_PARA{1,ii}(0) == 0
                        eval([PARA,'(1,ii) = 0;'])
                    elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) < 0.05
                        eval([PARA,'(1,ii) = 0;'])
                        fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                    elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) >= 0.05
                        fprintf('%s cannot be found for data %d.\n',PARA,ii)
                        eval([PARA,'(1,ii) = NaN;'])
                    elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) < 0.05
                        eval([PARA,'(1,ii) = 0;'])
                        fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                    else
                        fprintf('%s is being iterated for data %d.\n',PARA,ii)
                        para_iter = 0;
                        while f_PARA{1,ii}(para_iter) > 0
                           para_iter = para_iter + 0.05; 
                        end
                        eval([PARA,'(1,ii) = fzero(f_PARA{1,ii},[0 para_iter],options);'])
                        eval(['fprintf(''%s = %6.4f for data %d.\n'',PARA,',PARA,'(1,ii),ii)'])
                    end
            else
                if f_PARA{1,ii}(0) == 0
                        eval([PARA,'(1,ii) = 0;'])
                else
                        fprintf('%s cannot be found for data %d.\n',PARA,ii)
                        eval([PARA,'(1,ii) = NaN;'])
                end
            end
            x = 21 + nowHWait/numHWait * 100 / size(data,2) * ii;
            set(handles.textWaitBar,'Position',[0 0 x 1])
            clear x
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : ',num2str(ii),'/',num2str(size(data,2)),' (', num2str(round((sum(get(handles.textWaitBar,'Position') .* [0 0 1 0]) - 21) / 100 * 100,0)),' %) is done'],'HorizontalAlignment','Center');
            pause(0.2)
        end
        clear ii
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Writing porosity ...'],'HorizontalAlignment','Center');
        pause(0.2)
                
        porosity_ = ['porosity',num2cell(porosity)];
        eval(['PARA_temp = ',PARA,';'])
        % MODIFIED BEGIN
        switch modeDivergence
            case 1
                eval(['PARA_temp(isnan(',PARA,')) = 0;'])
                eval([PARA,'_ = [''',PARA,''',num2cell(PARA_temp)];'])
            case 0
                eval([PARA,'_ = [''',PARA,''',num2cell(PARA_temp)];'])
                porosity_temp2 = porosity;
                eval(['porosity(isnan(',PARA,')) = [];'])
                eval(['PARA_temp(isnan(',PARA,')) = [];'])
        end     
        eval(['remark(isnan(',PARA,')) = {''divergent''};'])
        remark_ = ['remark',remark];
        % MODIFIED   END
        
        if ispc
            if ~exist(['results\',dirClock,'\',PARA],'dir')
                mkdir(['results\',dirClock,'\',PARA])
            end
        elseif isunix
            if ~exist(['results/',dirClock,'/',PARA],'dir')
                mkdir(['results/',dirClock,'/',PARA])
            end
        else
            disp('Platform not supported')
        end

        eval(['T = table(porosity_'',',PARA,'_'',remark_'');'])
        if ispc
            eval(['writetable(T,''results\',dirClock,'\',PARA,'\',PARA,'_porosity.xlsx'',''WriteVariableNames'',false)'])
        elseif isunix
            eval(['writetable(T,''results/',dirClock,'/',PARA,'/',PARA,'_porosity.xlsx'',''WriteVariableNames'',false)'])
        else
            disp('Platform not supported')
        end
        clear T
        
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Writing porosity is done'],'HorizontalAlignment','Center');
        pause(0.2)

        H = figure;
        hold on
        legends = cell(2,1);
        legends{1,1} = 'Numeric simulated Values';
        eval(['scatter(porosity,PARA_temp)'])
        x = linspace(0,1,101)';
        if strcmp(fittingType,'Linear')
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            eval(['p = polyfit(porosity,PARA_temp,1);'])
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve is done'],'HorizontalAlignment','Center');
            pause(0.2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            y_lin = polyval(p,x);
            y_lin(y_lin<0) = 0;
            plot(x,y_lin)
            for jj = 1 : size(PARAs,2)
                if strcmp(paraFit{1,jj},'Level 1')
                    eval(['paraFit{1,',num2str(jj),'} = ''@(porosity_i)',num2str(p(1,1)),' * porosity_i + ',num2str(p(1,2)),''';'])
                    eval(['set(handles.edit',upper(PARA),'Fit,''String'',paraFit{1,',num2str(jj),'})'])
                     
                    eval(['setappdata(0,''edit',upper(PARA),'Fit'',paraFit{1,',num2str(jj),'})'])
                end
            end
            clear jj
        elseif strcmp(fittingType,'Horizontal')
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            eval(['p_h = polyfit(porosity,PARA_temp,0);'])
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve is done'],'HorizontalAlignment','Center');
            pause(0.2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            y_hor = polyval(p_h(1,1),x);
            y_hor(y_hor<0) = 0;
            plot(x,y_hor)
            for jj = 1 : size(PARAs,2)
                if strcmp(paraFit{1,jj},'Level 1')
                    eval(['paraFit{1,',num2str(jj),'} = ',num2str(p_h(1,1)),''';'])
                    eval(['set(handles.edit',upper(PARA),'Fit,''String'',paraFit{1,',num2str(jj),'})'])
                     
                    eval(['setappdata(0,''edit',upper(PARA),'Fit'',paraFit{1,',num2str(jj),'})'])
                end
            end
            clear jj
        else
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            f_exp = @(a,x) a(1) * exp(a(2) * x);
            eval(['b = nlinfit(porosity,PARA_temp,f_exp,[0;0]);'])
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve is done'],'HorizontalAlignment','Center');
            pause(0.2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            y_exp = arrayfun(@(x) f_exp(b,x),x);
            plot(x,y_exp)
            for jj = 1 : size(PARAs,2)
                if strcmp(paraFit{1,jj},'Level 1')
                    eval(['paraFit{1,',num2str(jj),'} = ''@(porosity_i)',num2str(b(1)),' * exp(',num2str(b(2)),'* porosity_i)''';])
                    eval(['set(handles.edit',upper(PARA),'Fit,''String'',paraFit{1,',num2str(jj),'})'])
                     
                    eval(['setappdata(0,''edit',upper(PARA),'Fit'',paraFit{1,',num2str(jj),'})'])
                end
            end
        end

        hold off
        xlabel('Porosity \phi / -')
        ylabel([PARA,' / -'])
        if strcmp(fittingType,'Linear')
            if p(1,2) > 0
                legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x + ', num2str(p(1,2))];
            elseif p(1,2) == 0
                legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x'];
            else
               legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x - ', num2str(abs(p(1,2)))]; 
            end   
        elseif strcmp(fittingType,'Horizontal')
               legends{2,1} = ['horizontal: y = ',num2str(p_h(1,1))]; 
        else
            legends{2,1} = ['exponential: y = ',num2str(b(1)),' * exp(',num2str(b(2)),' * x)'];
        end
        legend(legends)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve is done'],'HorizontalAlignment','Center');
        pause(0.2)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving fitting curve ...'],'HorizontalAlignment','Center');
        pause(0.2)
        
        if ispc
            savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_porosity.fig'])
        elseif isunix
            savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_porosity.fig'])
        else
            disp('Platform not supported')
        end
        
        
        close(H)
        clear H        
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving fitting curve is done'],'HorizontalAlignment','Center');
        pause(0.2)
        
        % MODIFIED BEGIN
        switch modeDivergence
            case 1
            case 0
                porosity = porosity_temp2;
        end     
        % MODIFIED   END
                
        

        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating thermal conductivity ...'],'HorizontalAlignment','Center');
        pause(0.2)
        k_0 = zeros(1,size(data,2));
        if strcmp(fittingType,'Linear')
            % linear
            k_lin = zeros(1,size(data,2));
            for ii = 1 : size(data,2)
                fprintf('Try to calculate k_0 and k_lin for data %d.\n',ii)
                k_0(1,ii) = k(1,ii) - f_PARA{1,ii}(0);
                try
                    k_lin(1,ii) = k(1,ii) - f_PARA{1,ii}(p(1,1) * porosity(1,ii) + p(1,2));
                catch
                    k_lin(1,ii) = NaN;
                end
            end
            clear ii
        elseif strcmp(fittingType,'Horizontal')
            % horizontal
            k_hor = zeros(1,size(data,2));
            for ii = 1 : size(data,2)
                fprintf('Try to calculate k_0 and k_hor for data %d.\n',ii)
                k_0(1,ii) = k(1,ii) - f_PARA{1,ii}(0);
                try
                    k_hor(1,ii) = k(1,ii) - f_PARA{1,ii}(p_h(1,1));
                catch
                    k_hor(1,ii) = NaN;
                end
            end
            clear ii
        else
            % exponential
            k_exp = zeros(1,size(data,2));
            for ii = 1 : size(data,2)
                fprintf('Try to calculate k_exp for data %d.\n',ii)
                k_0(1,ii) = k(1,ii) - f_PARA{1,ii}(0);
                try
                    k_exp(1,ii) = k(1,ii) - f_PARA{1,ii}(b(1) * exp(b(2) * porosity(1,ii)));
                catch
                    k_exp(1,ii) = NaN;
                end
            end
            clear ii
        end
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating thermal conductivity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting thermal conductivity ...'],'HorizontalAlignment','Center');
        pause(0.2)
        if strcmp(fittingType,'Linear')
            H = figure;
            hold on
            scatter(porosity,k,'o')
            scatter(porosity,k_0,'x')
            scatter(porosity,k_lin,'s')

            hold off
            xlabel('Porosity \phi / -')
            ylabel('Thermal conductivity / W/(m * K)')
            legend({'Numeric simulated Values';'unfitted Values';[PARA,' linear fitted Values']})
            if ispc
                savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_linear.fig'])
            elseif isunix
                savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_linear.fig'])
            else
                disp('Platform not supported')
            end
            close(H)
            clear H
        elseif strcmp(fittingType,'Horizontal')
            H = figure;
            hold on
            scatter(porosity,k,'o')
            scatter(porosity,k_0,'x')
            scatter(porosity,k_hor,'s')

            hold off
            xlabel('Porosity \phi / -')
            ylabel('Thermal conductivity / W/(m * K)')
            legend({'Numeric simulated Values';'unfitted Values';[PARA,' horizontal fitted Values']})
            if ispc
                savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_horizontal.fig'])
            elseif isunix
                savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_horizontal.fig'])
            else
                disp('Platform not supported')
            end
            close(H)
            clear H
        else
            H = figure;
            hold on
            scatter(porosity,k,'o')
            scatter(porosity,k_0,'x')
            scatter(porosity,k_exp,'s')

            hold off
            xlabel('Porosity \phi / -')
            ylabel('Thermal conductivity / W/(m * K)')
            legend({'Numeric simulated values';'unfitted values';[PARA,' exponential fitted values']})
            if ispc
                savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_exponential.fig'])
            elseif isunix
                savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_exponential.fig'])
            else
                disp('Platform not supported')
            end
            close(H)
            clear H
        end
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting thermal conductivity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving thermal conductivity ...'],'HorizontalAlignment','Center');
        pause(0.2)
        k_ = ['k numeric',num2cell(k)];
        k_0_ = ['k not fitted',num2cell(k_0)];
        
        if strcmp(fittingType,'Linear')
            k_lin_ = ['k linearly fitted',num2cell(k_lin)];
            T = table(k_',k_0_',k_lin_');
            if ispc
                writetable(T,['results\',dirClock,'\',PARA,'\',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            elseif isunix
                writetable(T,['results/',dirClock,'/',PARA,'/',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)           
            else
                disp('Platform not supported')
            end
            clear T
        elseif strcmp(fittingType,'Horizontal')
            k_hor_ = ['k horizontally fitted',num2cell(k_hor)];
            T = table(k_',k_0_',k_hor_');
            if ispc
                writetable(T,['results\',dirClock,'\',PARA,'\',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            elseif isunix
                writetable(T,['results/',dirClock,'/',PARA,'/',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)           
            else
                disp('Platform not supported')
            end
            clear T
        else
            k_exp_ = ['k exponentially fitted',num2cell(k_exp)];
            T = table(k_',k_0_',k_exp_');
            if ispc
                writetable(T,['results\',dirClock,'\',PARA,'\',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            elseif isunix
                writetable(T,['results/',dirClock,'/',PARA,'/',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            else
                disp('Platform not supported')
            end
            clear T
        end
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving thermal conductivity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        eval(['set(handles.textTick',upper(PARA),',''Visible'',''On'')'])
        eval(['set(handles.textTick',upper(PARA),',''String'',''O'')'])
    end

    
    if any(strcmp(paraFit,'Level 2'))
        fprintf('************************** Level 2 ************************** \n')
        nowHWait = nowHWait + 1;
        for jj = 1 : size(PARAs,2)
            if strcmp(paraFit{1,jj},'Level 2')
                paraValues{1,jj} = 'vary';
            elseif strcmp(paraFit{1,jj},'Level 3') || strcmp(paraFit{1,jj},'Level 4')
                paraValues{1,jj} = 0;
            elseif ~isnan(str2double(paraFit{1,jj}))
                paraValues{1,jj} = str2double(paraFit{1,jj});
            else strcmp(paraFit{1,jj}(1),'@')
                paraValues{1,jj} = paraFit{1,jj};
            end
        end
        clear jj
        
        epsilon = 1e-3; % accuracy for the derivate at the point 0
        FUNCs = '';
        funcValues = '';
        for jj = 1 : size(PARAs,2)
            if isnumeric(paraValues{1,jj})
               eval([PARAs{1,jj},'=',num2str(paraValues{1,jj}),';']) 
            elseif ischar(paraValues{1,jj}) && ~strcmp(paraValues{1,jj},'vary')
                eval([PARAs{1,jj},'=',paraValues{1,jj},';']) 
                strlen_FUNCs = strlength(FUNCs);
                FUNCs = insertAfter(FUNCs,strlen_FUNCs,[',',PARAs{1,jj}]);
                strlen_funcValues = strlength(funcValues);
                funcValues = insertAfter(funcValues,strlen_funcValues,[',',PARAs{1,jj},'(porosity(1,ii))']);
            else
                eval([PARAs{1,jj},'= zeros(1,size(data,2));']) 
                eval(['PARA = ','''',PARAs{1,jj},''';'])
                remark = cell(1,size(data,2));
            end
        end
        clear jj

        eval(['fittingType = getappdata(0,''popupmenuFitting',upper(PARA),''');'])
        fittingType = fittingType{1};



        % function handle to calculate the difference between simulated value and modelled value
        eval(['f = @ (k_i,namesMatrix_i,vFrMatrix_i,nameFiller_i,porosity_i,',PARA,FUNCs,') k_i - k_',modelName,'(namesMatrix_i,vFrMatrix_i,nameFiller_i,porosity_i,curveName,modelAdditiveName,modeTortuosity,a,c,e,g);'])

 
        f_PARA = cell(1,size(data,2));
        for ii = 1 : size(data,2)
            eval(['f_PARA{1,ii} = @(PARA) f(k(1,ii),namesMatrix{1,ii},vFrMatrix(1:2,ii),nameFiller{1,ii},porosity(1,ii),PARA',funcValues,');'])
        end
        clear ii
        
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : ',' 0/',num2str(size(data,2)),' (',num2str(round((sum(get(handles.textWaitBar,'Position') .* [0 0 1 0]) - 21) / 100 * 100,0)),' %)'],'HorizontalAlignment','Center');
        pause(0.2)
        for ii = 1 : size(data,2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : ',num2str(ii),'/',num2str(size(data,2)),' (', num2str(round((sum(get(handles.textWaitBar,'Position') .* [0 0 1 0]) - 21) / 100 * 100,0)),' %) ...'],'HorizontalAlignment','Center');
            pause(0.2)
            fprintf('------------ For data %d ------------\n',ii)
            options = optimset('Display','off');
            eval(['f_PARA{1,ii} = @(PARA) f(k(1,ii),namesMatrix{1,ii},vFrMatrix(1:2,ii),nameFiller{1,ii},porosity(1,ii),PARA',funcValues,');'])
            
            if f_PARA{1,ii}(0) < f_PARA{1,ii}(epsilon)  % monotonically increasing
                if f_PARA{1,ii}(0) == 0
                    eval([PARA,'(1,ii) = 0;'])
                elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) < 0.05
                    eval([PARA,'(1,ii) = 0;'])
                    fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) >= 0.05
                    fprintf('%s cannot be found for data %d.\n',PARA,ii)
                    eval([PARA,'(1,ii) = NaN;'])
                elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) < 0.05
                    eval([PARA,'(1,ii) = 0;'])
                    fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                else
                    fprintf('%s is being iterated for data %d.\n',PARA,ii)
                    para_iter = 0;
                    while f_PARA{1,ii}(para_iter) < 0
                       para_iter = para_iter + 0.05; 
                    end
                    eval([PARA,'(1,ii) = fzero(f_PARA{1,ii},[0 para_iter],options);'])
                    eval(['fprintf(''%s = %6.4f for data %d.\n'',PARA,',PARA,'(1,ii),ii)'])
                end
            elseif f_PARA{1,ii}(0) > f_PARA{1,ii}(epsilon)  % monotonically decreasing
                    if f_PARA{1,ii}(0) == 0
                        eval([PARA,'(1,ii) = 0;'])
                    elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) < 0.05
                        eval([PARA,'(1,ii) = 0;'])
                        fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                    elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) >= 0.05
                        fprintf('%s cannot be found for data %d.\n',PARA,ii)
                        eval([PARA,'(1,ii) = NaN;'])
                    elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) < 0.05
                        eval([PARA,'(1,ii) = 0;'])
                        fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                    else
                        fprintf('%s is being iterated for data %d.\n',PARA,ii)
                        para_iter = 0;
                        while f_PARA{1,ii}(para_iter) > 0
                           para_iter = para_iter + 0.05; 
                        end
                        eval([PARA,'(1,ii) = fzero(f_PARA{1,ii},[0 para_iter],options);'])
                        eval(['fprintf(''%s = %6.4f for data %d.\n'',PARA,',PARA,'(1,ii),ii)'])
                    end
            else
                if f_PARA{1,ii}(0) == 0
                        eval([PARA,'(1,ii) = 0;'])
                else
                        fprintf('%s cannot be found for data %d.\n',PARA,ii)
                        eval([PARA,'(1,ii) = NaN;'])
                end
            end
            
            x = 21 + nowHWait/numHWait * 100 / size(data,2) * ii;
            set(handles.textWaitBar,'Position',[0 0 x 1])
            clear x
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : ',num2str(ii),'/',num2str(size(data,2)),' (', num2str(round((sum(get(handles.textWaitBar,'Position') .* [0 0 1 0]) - 21) / 100 * 100,0)),' %) is done'],'HorizontalAlignment','Center');
            pause(0.2)
        end
        clear ii
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Writing porosity ...'],'HorizontalAlignment','Center');
        pause(0.2)
        
        porosity_ = ['porosity',num2cell(porosity)];
        eval(['PARA_temp = ',PARA,';'])
        % MODIFIED BEGIN
        switch modeDivergence
            case 1
                eval(['PARA_temp(isnan(',PARA,')) = 0;'])
                eval([PARA,'_ = [''',PARA,''',num2cell(PARA_temp)];'])
            case 0
                eval([PARA,'_ = [''',PARA,''',num2cell(PARA_temp)];'])
                porosity_temp2 = porosity;
                eval(['porosity(isnan(',PARA,')) = [];'])
                eval(['PARA_temp(isnan(',PARA,')) = [];'])
        end     
        eval(['remark(isnan(',PARA,')) = {''divergent''};'])
        remark_ = ['remark',remark];
        % MODIFIED   END

        
        if ispc
            if ~exist(['results\',dirClock,'\',PARA],'dir')
                mkdir(['results\',dirClock,'\',PARA])
            end
        elseif isunix
            if ~exist(['results/',dirClock,'/',PARA],'dir')
                mkdir(['results/',dirClock,'/',PARA])
            end
        else
            disp('Platform not supported')
        end
        
        eval(['T = table(porosity_'',',PARA,'_'',remark_'');'])
        if ispc
            eval(['writetable(T,''results\',dirClock,'\',PARA,'\',PARA,'_porosity.xlsx'',''WriteVariableNames'',false)'])
        elseif isunix
            eval(['writetable(T,''results/',dirClock,'/',PARA,'/',PARA,'_porosity.xlsx'',''WriteVariableNames'',false)'])
        else
            disp('Platform not supported')
        end
        clear T

        
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Writing porosity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        
        H = figure;
        hold on
        legends = cell(2,1);
        legends{1,1} = 'Numeric simulated Values';
        eval(['scatter(porosity,PARA_temp)'])
        x = linspace(0,1,101)';
        if strcmp(fittingType,'Linear')
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            eval(['p = polyfit(porosity,PARA_temp,1);'])
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve is done'],'HorizontalAlignment','Center');
            pause(0.2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            y_lin = polyval(p,x);
            y_lin(y_lin<0) = 0;
            plot(x,y_lin)
            for jj = 1 : size(PARAs,2)
                if strcmp(paraFit{1,jj},'Level 2')
                    eval(['paraFit{1,',num2str(jj),'} = ''@(porosity_i)',num2str(p(1,1)),' * porosity_i + ',num2str(p(1,2)),''';'])
                    eval(['set(handles.edit',upper(PARA),'Fit,''String'',paraFit{1,',num2str(jj),'})'])
                     
                    eval(['setappdata(0,''edit',upper(PARA),'Fit'',paraFit{1,',num2str(jj),'})'])
                end
            end
            clear jj
        elseif strcmp(fittingType,'Horizontal')
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            eval(['p_h = polyfit(porosity,PARA_temp,0);'])
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve is done'],'HorizontalAlignment','Center');
            pause(0.2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            y_hor = polyval(p_h(1,1),x);
            y_hor(y_hor<0) = 0;
            plot(x,y_hor)
            for jj = 1 : size(PARAs,2)
                if strcmp(paraFit{1,jj},'Level 1')
                    eval(['paraFit{1,',num2str(jj),'} = ',num2str(p_h(1,1)),''';'])
                    eval(['set(handles.edit',upper(PARA),'Fit,''String'',paraFit{1,',num2str(jj),'})'])

                    eval(['setappdata(0,''edit',upper(PARA),'Fit'',paraFit{1,',num2str(jj),'})'])
                end
            end
            clear jj
        else
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            f_exp = @(a,x) a(1) * exp(a(2) * x);
            eval(['b = nlinfit(porosity,PARA_temp,f_exp,[0;0]);'])
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve is done'],'HorizontalAlignment','Center');
            pause(0.2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            y_exp = arrayfun(@(x) f_exp(b,x),x);
            plot(x,y_exp)
            for jj = 1 : size(PARAs,2)
                if strcmp(paraFit{1,jj},'Level 2')
                    eval(['paraFit{1,',num2str(jj),'} = ''@(porosity_i)',num2str(b(1)),' * exp(',num2str(b(2)),'* porosity_i)'';';])
                    eval(['set(handles.edit',upper(PARA),'Fit,''String'',paraFit{1,',num2str(jj),'})'])
                     
                    eval(['setappdata(0,''edit',upper(PARA),'Fit'',paraFit{1,',num2str(jj),'})'])
                end
            end
        end

        hold off
        xlabel('Porosity \phi / -')
        ylabel([PARA,' / -'])
        if strcmp(fittingType,'Linear')
            if p(1,2) > 0
                legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x + ', num2str(p(1,2))];
            elseif p(1,2) == 0
                legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x'];
            else
               legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x - ', num2str(abs(p(1,2)))]; 
            end   
        elseif strcmp(fittingType,'Horizontal')
               legends{2,1} = ['horizontal: y = ',num2str(p_h(1,1))]; 
        else
            legends{2,1} = ['exponential: y = ',num2str(b(1)),' * exp(',num2str(b(2)),' * x)'];
        end
        legend(legends)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve is done'],'HorizontalAlignment','Center');
        pause(0.2)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving fitting curve ...'],'HorizontalAlignment','Center');
        pause(0.2)
        if ispc
            savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_porosity.fig'])
        elseif isunix
            savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_porosity.fig'])
        else
            disp('Platform not supported')
        end
        close(H)
        clear H
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving fitting curve is done'],'HorizontalAlignment','Center');
        pause(0.2)


        % MODIFIED BEGIN
        switch modeDivergence
            case 1
            case 0
                porosity = porosity_temp2;
        end     
        % MODIFIED   END
        
        
        
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating thermal conductivity ...'],'HorizontalAlignment','Center');
        pause(0.2)
        k_0 = zeros(1,size(data,2));
        if strcmp(fittingType,'Linear')
            % linear
            k_lin = zeros(1,size(data,2));
            for ii = 1 : size(data,2)
                fprintf('Try to calculate k_0 and k_lin for data %d.\n',ii)
                k_0(1,ii) = k(1,ii) - f_PARA{1,ii}(0);
                try
                    k_lin(1,ii) = k(1,ii) - f_PARA{1,ii}(p(1,1) * porosity(1,ii) + p(1,2));
                catch
                    k_lin(1,ii) = NaN;
                end
            end
            clear ii
        elseif strcmp(fittingType,'Horizontal')
            % horizontal
            k_hor = zeros(1,size(data,2));
            for ii = 1 : size(data,2)
                fprintf('Try to calculate k_0 and k_hor for data %d.\n',ii)
                k_0(1,ii) = k(1,ii) - f_PARA{1,ii}(0);
                try
                    k_hor(1,ii) = k(1,ii) - f_PARA{1,ii}(p_h(1,1));
                catch
                    k_hor(1,ii) = NaN;
                end
            end
            clear ii
        else
            % exponential
            k_exp = zeros(1,size(data,2));
            for ii = 1 : size(data,2)
                fprintf('Try to calculate k_exp for data %d.\n',ii)
                k_0(1,ii) = k(1,ii) - f_PARA{1,ii}(0);
                try
                    k_exp(1,ii) = k(1,ii) - f_PARA{1,ii}(b(1) * exp(b(2) * porosity(1,ii)));
                catch
                    k_exp(1,ii) = NaN;
                end
            end
            clear ii
        end
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating thermal conductivity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting thermal conductivity ...'],'HorizontalAlignment','Center');
        pause(0.2)
        if strcmp(fittingType,'Linear')
            H = figure;
            hold on
            scatter(porosity,k,'o')
            scatter(porosity,k_0,'x')
            scatter(porosity,k_lin,'s')

            hold off
            xlabel('Porosity \phi / -')
            ylabel('Thermal conductivity / W/(m * K)')
            legend({'Numeric simulated Values';'unfitted Values';[PARA,' linear fitted Values']})
            if ispc
                savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_linear.fig'])
            elseif isunix
                savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_linear.fig'])
            else
                disp('Platform not supported')
            end
            close(H)
            clear H

        elseif strcmp(fittingType,'Horizontal')
            H = figure;
            hold on
            scatter(porosity,k,'o')
            scatter(porosity,k_0,'x')
            scatter(porosity,k_hor,'s')

            hold off
            xlabel('Porosity \phi / -')
            ylabel('Thermal conductivity / W/(m * K)')
            legend({'Numeric simulated Values';'unfitted Values';[PARA,' horizontal fitted Values']})
            if ispc
                savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_horizontal.fig'])
            elseif isunix
                savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_horizontal.fig'])
            else
                disp('Platform not supported')
            end
            close(H)
            clear H
        else
            H = figure;
            hold on
            scatter(porosity,k,'o')
            scatter(porosity,k_0,'x')
            scatter(porosity,k_exp,'s')

            hold off
            xlabel('Porosity \phi / -')
            ylabel('Thermal conductivity / W/(m * K)')
            legend({'Numeric simulated values';'unfitted values';[PARA,' exponential fitted values']})
            if ispc
                savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_exponential.fig'])
            elseif isunix
                savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_exponential.fig'])
            else
                disp('Platform not supported')
            end
            close(H)
            clear H
        end
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting thermal conductivity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving thermal conductivity ...'],'HorizontalAlignment','Center');
        pause(0.2)
        
        k_ = ['k numeric',num2cell(k)];
        k_0_ = ['k not fitted',num2cell(k_0)];
        if strcmp(fittingType,'Linear')
            k_lin_ = ['k linearly fitted',num2cell(k_lin)];
            T = table(k_',k_0_',k_lin_');
            if ispc
                writetable(T,['results\',dirClock,'\',PARA,'\',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            elseif isunix
                writetable(T,['results/',dirClock,'/',PARA,'/',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)           
            else
                disp('Platform not supported')
            end
            clear T
        elseif strcmp(fittingType,'Horizontal')
            k_hor_ = ['k horizontally fitted',num2cell(k_hor)];
            T = table(k_',k_0_',k_hor_');
            if ispc
                writetable(T,['results\',dirClock,'\',PARA,'\',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            elseif isunix
                writetable(T,['results/',dirClock,'/',PARA,'/',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)           
            else
                disp('Platform not supported')
            end
            clear T
        else
            k_exp_ = ['k exponentially fitted',num2cell(k_exp)];
            T = table(k_',k_0_',k_exp_');
            if ispc
                writetable(T,['results\',dirClock,'\',PARA,'\',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            elseif isunix
                writetable(T,['results/',dirClock,'/',PARA,'/',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            else
                disp('Platform not supported')
            end
            clear T
        end

        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving thermal conductivity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        eval(['set(handles.textTick',upper(PARA),',''Visible'',''On'')'])
        eval(['set(handles.textTick',upper(PARA),',''String'',''O'')'])
    end
    
    
    if any(strcmp(paraFit,'Level 3'))
        fprintf('************************** Level 3 ************************** \n')
        nowHWait = nowHWait + 1;

        for jj = 1 : size(PARAs,2)
            if strcmp(paraFit{1,jj},'Level 3')
                paraValues{1,jj} = 'vary';
            elseif strcmp(paraFit{1,jj},'Level 4')
                paraValues{1,jj} = 0;
            elseif ~isnan(str2double(paraFit{1,jj}))
                paraValues{1,jj} = str2double(paraFit{1,jj});
            else strcmp(paraFit{1,jj}(1),'@')
                paraValues{1,jj} = paraFit{1,jj};
            end
        end
        clear jj
        
        epsilon = 1e-3; % accuracy for the derivate at the point 0
        FUNCs = '';
        funcValues = '';
        for jj = 1 : size(PARAs,2)
            if isnumeric(paraValues{1,jj})
               eval([PARAs{1,jj},'=',num2str(paraValues{1,jj}),';']) 
            elseif ischar(paraValues{1,jj}) && ~strcmp(paraValues{1,jj},'vary')
                eval([PARAs{1,jj},'=',paraValues{1,jj},';']) 
                strlen_FUNCs = strlength(FUNCs);
                FUNCs = insertAfter(FUNCs,strlen_FUNCs,[',',PARAs{1,jj}]);
                strlen_funcValues = strlength(funcValues);
                funcValues = insertAfter(funcValues,strlen_funcValues,[',',PARAs{1,jj},'(porosity(1,ii))']);
            else
                eval([PARAs{1,jj},'= zeros(1,size(data,2));']) 
                eval(['PARA = ','''',PARAs{1,jj},''';'])
                remark = cell(1,size(data,2));
            end
        end
        clear jj


        eval(['fittingType = getappdata(0,''popupmenuFitting',upper(PARA),''');'])
        fittingType = fittingType{1};


        % function handle to calculate the difference between simulated value and modelled value
        eval(['f = @ (k_i,namesMatrix_i,vFrMatrix_i,nameFiller_i,porosity_i,',PARA,FUNCs,') k_i - k_',modelName,'(namesMatrix_i,vFrMatrix_i,nameFiller_i,porosity_i,curveName,modelAdditiveName,modeTortuosity,a,c,e,g);'])

 
        f_PARA = cell(1,size(data,2));
        for ii = 1 : size(data,2)
            eval(['f_PARA{1,ii} = @(PARA) f(k(1,ii),namesMatrix{1,ii},vFrMatrix(1:2,ii),nameFiller{1,ii},porosity(1,ii),PARA',funcValues,');'])
        end
        clear ii
        
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : ',' 0/',num2str(size(data,2)),' (',num2str(round((sum(get(handles.textWaitBar,'Position') .* [0 0 1 0]) - 21) / 100 * 100,0)),' %)'],'HorizontalAlignment','Center');
        pause(0.2)
        for ii = 1 : size(data,2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : ',num2str(ii),'/',num2str(size(data,2)),' (', num2str(round((sum(get(handles.textWaitBar,'Position') .* [0 0 1 0]) - 21) / 100 * 100,0)),' %) ...'],'HorizontalAlignment','Center');
            pause(0.2)
            fprintf('------------ For data %d ------------\n',ii)
            options = optimset('Display','off');
            eval(['f_PARA{1,ii} = @(PARA) f(k(1,ii),namesMatrix{1,ii},vFrMatrix(1:2,ii),nameFiller{1,ii},porosity(1,ii),PARA',funcValues,');'])
            
            if f_PARA{1,ii}(0) < f_PARA{1,ii}(epsilon)  % monotonically increasing
                if f_PARA{1,ii}(0) == 0
                    eval([PARA,'(1,ii) = 0;'])
                elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) < 0.05
                    eval([PARA,'(1,ii) = 0;'])
                    fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) >= 0.05
                    fprintf('%s cannot be found for data %d.\n',PARA,ii)
                    eval([PARA,'(1,ii) = NaN;'])
                elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) < 0.05
                    eval([PARA,'(1,ii) = 0;'])
                    fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                else
                    fprintf('%s is being iterated for data %d.\n',PARA,ii)
                    para_iter = 0;
                    while f_PARA{1,ii}(para_iter) < 0
                       para_iter = para_iter + 0.05; 
                    end
                    eval([PARA,'(1,ii) = fzero(f_PARA{1,ii},[0 para_iter],options);'])
                    eval(['fprintf(''%s = %6.4f for data %d.\n'',PARA,',PARA,'(1,ii),ii)'])
                end
            elseif f_PARA{1,ii}(0) > f_PARA{1,ii}(epsilon)  % monotonically decreasing
                    if f_PARA{1,ii}(0) == 0
                        eval([PARA,'(1,ii) = 0;'])
                    elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) < 0.05
                        eval([PARA,'(1,ii) = 0;'])
                        fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                    elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) >= 0.05
                        fprintf('%s cannot be found for data %d.\n',PARA,ii)
                        eval([PARA,'(1,ii) = NaN;'])
                    elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) < 0.05
                        eval([PARA,'(1,ii) = 0;'])
                        fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                    else
                        fprintf('%s is being iterated for data %d.\n',PARA,ii)
                        para_iter = 0;
                        while f_PARA{1,ii}(para_iter) > 0
                           para_iter = para_iter + 0.05; 
                        end
                        eval([PARA,'(1,ii) = fzero(f_PARA{1,ii},[0 para_iter],options);'])
                        eval(['fprintf(''%s = %6.4f for data %d.\n'',PARA,',PARA,'(1,ii),ii)'])
                    end
            else
                if f_PARA{1,ii}(0) == 0
                        eval([PARA,'(1,ii) = 0;'])
                else
                        fprintf('%s cannot be found for data %d.\n',PARA,ii)
                        eval([PARA,'(1,ii) = NaN;'])
                end
            end
            x = 21 + nowHWait/numHWait * 100 / size(data,2) * ii;
            set(handles.textWaitBar,'Position',[0 0 x 1])
            clear x
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : ',num2str(ii),'/',num2str(size(data,2)),' (', num2str(round((sum(get(handles.textWaitBar,'Position') .* [0 0 1 0]) - 21) / 100 * 100,0)),' %) is done'],'HorizontalAlignment','Center');
            pause(0.2)

        end
        clear ii
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Writing porosity ...'],'HorizontalAlignment','Center');
        pause(0.2)

        porosity_ = ['porosity',num2cell(porosity)];
        eval(['PARA_temp = ',PARA,';'])
        % MODIFIED BEGIN
        switch modeDivergence
            case 1
                eval(['PARA_temp(isnan(',PARA,')) = 0;'])
                eval([PARA,'_ = [''',PARA,''',num2cell(PARA_temp)];'])
            case 0
                eval([PARA,'_ = [''',PARA,''',num2cell(PARA_temp)];'])
                porosity_temp2 = porosity;
                eval(['porosity(isnan(',PARA,')) = [];'])
                eval(['PARA_temp(isnan(',PARA,')) = [];'])
        end     
        eval(['remark(isnan(',PARA,')) = {''divergent''};'])
        remark_ = ['remark',remark];
        % MODIFIED   END

        
        if ispc
            if ~exist(['results\',dirClock,'\',PARA],'dir')
                mkdir(['results\',dirClock,'\',PARA])
            end
        elseif isunix
            if ~exist(['results/',dirClock,'/',PARA],'dir')
                mkdir(['results/',dirClock,'/',PARA])
            end
        else
            disp('Platform not supported')
        end
        
        eval(['T = table(porosity_'',',PARA,'_'',remark_'');'])
        if ispc
            eval(['writetable(T,''results\',dirClock,'\',PARA,'\',PARA,'_porosity.xlsx'',''WriteVariableNames'',false)'])
        elseif isunix
            eval(['writetable(T,''results/',dirClock,'/',PARA,'/',PARA,'_porosity.xlsx'',''WriteVariableNames'',false)'])
        else
            disp('Platform not supported')
        end
        clear T

        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Writing porosity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        
        H = figure;
        hold on
        legends = cell(2,1);
        legends{1,1} = 'Numeric simulated Values';
        eval(['scatter(porosity,PARA_temp)'])
        x = linspace(0,1,101)';
        if strcmp(fittingType,'Linear')
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            eval(['p = polyfit(porosity,PARA_temp,1);'])
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve is done'],'HorizontalAlignment','Center');
            pause(0.2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            y_lin = polyval(p,x);
            y_lin(y_lin<0) = 0;
            plot(x,y_lin)
            for jj = 1 : size(PARAs,2)
                if strcmp(paraFit{1,jj},'Level 3')
                    eval(['paraFit{1,',num2str(jj),'} = ''@(porosity_i)',num2str(p(1,1)),' * porosity_i + ',num2str(p(1,2)),''';'])
                    eval(['set(handles.edit',upper(PARA),'Fit,''String'',paraFit{1,',num2str(jj),'})'])
                     
                    eval(['setappdata(0,''edit',upper(PARA),'Fit'',paraFit{1,',num2str(jj),'})'])
                end
            end
            clear jj
        elseif strcmp(fittingType,'Horizontal')
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            eval(['p_h = polyfit(porosity,PARA_temp,0);'])
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve is done'],'HorizontalAlignment','Center');
            pause(0.2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            y_hor = polyval(p_h(1,1),x);
            y_hor(y_hor<0) = 0;
            plot(x,y_hor)
            for jj = 1 : size(PARAs,2)
                if strcmp(paraFit{1,jj},'Level 1')
                    eval(['paraFit{1,',num2str(jj),'} = ',num2str(p_h(1,1)),''';'])
                    eval(['set(handles.edit',upper(PARA),'Fit,''String'',paraFit{1,',num2str(jj),'})'])
                     
                    eval(['setappdata(0,''edit',upper(PARA),'Fit'',paraFit{1,',num2str(jj),'})'])
                end
            end
            clear jj
        else
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            f_exp = @(a,x) a(1) * exp(a(2) * x);
            eval(['b = nlinfit(porosity,PARA_temp,f_exp,[0;0]);'])
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve is done'],'HorizontalAlignment','Center');
            pause(0.2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            y_exp = arrayfun(@(x) f_exp(b,x),x);
            plot(x,y_exp)
            for jj = 1 : size(PARAs,2)
                if strcmp(paraFit{1,jj},'Level 3')
                    eval(['paraFit{1,',num2str(jj),'} = ''@(porosity_i)',num2str(b(1)),' * exp(',num2str(b(2)),'* porosity_i)'';';])
                    eval(['set(handles.edit',upper(PARA),'Fit,''String'',paraFit{1,',num2str(jj),'})'])
                     
                    eval(['setappdata(0,''edit',upper(PARA),'Fit'',paraFit{1,',num2str(jj),'})'])
                end
            end
        end

        hold off
        xlabel('Porosity \phi / -')
        ylabel([PARA,' / -'])
        if strcmp(fittingType,'Linear')
            if p(1,2) > 0
                legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x + ', num2str(p(1,2))];
            elseif p(1,2) == 0
                legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x'];
            else
               legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x - ', num2str(abs(p(1,2)))]; 
            end   
        elseif strcmp(fittingType,'Horizontal')
               legends{2,1} = ['horizontal: y = ',num2str(p_h(1,1))]; 
        else
            legends{2,1} = ['exponential: y = ',num2str(b(1)),' * exp(',num2str(b(2)),' * x)'];
        end
        legend(legends)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve is done'],'HorizontalAlignment','Center');
        pause(0.2)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving fitting curve ...'],'HorizontalAlignment','Center');
        pause(0.2)
        if ispc
            savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_porosity.fig'])
        elseif isunix
            savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_porosity.fig'])
        else
            disp('Platform not supported')
        end
        close(H)
        clear H  
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving fitting curve is done'],'HorizontalAlignment','Center');
        pause(0.2)
        

        % MODIFIED BEGIN
        switch modeDivergence
            case 1
            case 0
                porosity = porosity_temp2;
        end     
        % MODIFIED   END
        
        
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating thermal conductivity ...'],'HorizontalAlignment','Center');
        pause(0.2)
        k_0 = zeros(1,size(data,2));
        if strcmp(fittingType,'Linear')
            % linear
            k_lin = zeros(1,size(data,2));
            for ii = 1 : size(data,2)
                fprintf('Try to calculate k_0 and k_lin for data %d.\n',ii)
                k_0(1,ii) = k(1,ii) - f_PARA{1,ii}(0);
                try
                    k_lin(1,ii) = k(1,ii) - f_PARA{1,ii}(p(1,1) * porosity(1,ii) + p(1,2));
                catch
                    k_lin(1,ii) = NaN;
                end
            end
            clear ii
        elseif strcmp(fittingType,'Horizontal')
            % horizontal
            k_hor = zeros(1,size(data,2));
            for ii = 1 : size(data,2)
                fprintf('Try to calculate k_0 and k_hor for data %d.\n',ii)
                k_0(1,ii) = k(1,ii) - f_PARA{1,ii}(0);
                try
                    k_hor(1,ii) = k(1,ii) - f_PARA{1,ii}(p_h(1,1));
                catch
                    k_hor(1,ii) = NaN;
                end
            end
            clear ii
        else
            % exponential
            k_exp = zeros(1,size(data,2));
            for ii = 1 : size(data,2)
                fprintf('Try to calculate k_exp for data %d.\n',ii)
                k_0(1,ii) = k(1,ii) - f_PARA{1,ii}(0);
                try
                    k_exp(1,ii) = k(1,ii) - f_PARA{1,ii}(b(1) * exp(b(2) * porosity(1,ii)));
                catch
                    k_exp(1,ii) = NaN;
                end
            end
            clear ii
        end
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating thermal conductivity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting thermal conductivity ...'],'HorizontalAlignment','Center');
        pause(0.2)
        if strcmp(fittingType,'Linear')
            H = figure;
            hold on
            scatter(porosity,k,'o')
            scatter(porosity,k_0,'x')
            scatter(porosity,k_lin,'s')

            hold off
            xlabel('Porosity \phi / -')
            ylabel('Thermal conductivity / W/(m * K)')
            legend({'Numeric simulated Values';'unfitted Values';[PARA,' linear fitted Values']})
            if ispc
                savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_linear.fig'])
            elseif isunix
                savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_linear.fig'])
            else
                disp('Platform not supported')
            end
            close(H)
            clear H

        elseif strcmp(fittingType,'Horizontal')
            H = figure;
            hold on
            scatter(porosity,k,'o')
            scatter(porosity,k_0,'x')
            scatter(porosity,k_hor,'s')

            hold off
            xlabel('Porosity \phi / -')
            ylabel('Thermal conductivity / W/(m * K)')
            legend({'Numeric simulated Values';'unfitted Values';[PARA,' horizontal fitted Values']})
            if ispc
                savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_horizontal.fig'])
            elseif isunix
                savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_horizontal.fig'])
            else
                disp('Platform not supported')
            end
            close(H)
            clear H
        else
            H = figure;
            hold on
            scatter(porosity,k,'o')
            scatter(porosity,k_0,'x')
            scatter(porosity,k_exp,'s')

            hold off
            xlabel('Porosity \phi / -')
            ylabel('Thermal conductivity / W/(m * K)')
            legend({'Numeric simulated values';'unfitted values';[PARA,' exponential fitted values']})
            if ispc
                savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_exponential.fig'])
            elseif isunix
                savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_exponential.fig'])
            else
                disp('Platform not supported')
            end
            close(H)
            clear H
        end
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting thermal conductivity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving thermal conductivity ...'],'HorizontalAlignment','Center');
        pause(0.2)
        k_ = ['k numeric',num2cell(k)];
        k_0_ = ['k not fitted',num2cell(k_0)];


        if strcmp(fittingType,'Linear')
            k_lin_ = ['k linearly fitted',num2cell(k_lin)];
            T = table(k_',k_0_',k_lin_');
            if ispc
                writetable(T,['results\',dirClock,'\',PARA,'\',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            elseif isunix
                writetable(T,['results/',dirClock,'/',PARA,'/',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)           
            else
                disp('Platform not supported')
            end
            clear T

        elseif strcmp(fittingType,'Horizontal')
            k_hor_ = ['k horizontally fitted',num2cell(k_hor)];
            T = table(k_',k_0_',k_hor_');
            if ispc
                writetable(T,['results\',dirClock,'\',PARA,'\',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            elseif isunix
                writetable(T,['results/',dirClock,'/',PARA,'/',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)           
            else
                disp('Platform not supported')
            end
            clear T
        else
            k_exp_ = ['k exponentially fitted',num2cell(k_exp)];
            T = table(k_',k_0_',k_exp_');
            if ispc
                writetable(T,['results\',dirClock,'\',PARA,'\',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            elseif isunix
                writetable(T,['results/',dirClock,'/',PARA,'/',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            else
                disp('Platform not supported')
            end
            clear T
        end
        
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving thermal conductivity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        eval(['set(handles.textTick',upper(PARA),',''Visible'',''On'')'])
        eval(['set(handles.textTick',upper(PARA),',''String'',''O'')'])
    end
    
    
    if any(strcmp(paraFit,'Level 4'))
        fprintf('************************** Level 4 ************************** \n')
        nowHWait = nowHWait + 1;
        for jj = 1 : size(PARAs,2)
            if strcmp(paraFit{1,jj},'Level 4')
                paraValues{1,jj} = 'vary';
            elseif ~isnan(str2double(paraFit{1,jj}))
                paraValues{1,jj} = str2double(paraFit{1,jj});
            else strcmp(paraFit{1,jj}(1),'@')
                paraValues{1,jj} = paraFit{1,jj};
            end
        end
        clear jj
        
        epsilon = 1e-3; % accuracy for the derivate at the point 0
        FUNCs = '';
        funcValues = '';
        for jj = 1 : size(PARAs,2)
            if isnumeric(paraValues{1,jj})
               eval([PARAs{1,jj},'=',num2str(paraValues{1,jj}),';']) 
            elseif ischar(paraValues{1,jj}) && ~strcmp(paraValues{1,jj},'vary')
                eval([PARAs{1,jj},'=',paraValues{1,jj},';']) 
                strlen_FUNCs = strlength(FUNCs);
                FUNCs = insertAfter(FUNCs,strlen_FUNCs,[',',PARAs{1,jj}]);
                strlen_funcValues = strlength(funcValues);
                funcValues = insertAfter(funcValues,strlen_funcValues,[',',PARAs{1,jj},'(porosity(1,ii))']);
            else
                eval([PARAs{1,jj},'= zeros(1,size(data,2));']) 
                eval(['PARA = ','''',PARAs{1,jj},''';'])
                remark = cell(1,size(data,2));
            end
        end
        clear jj

        eval(['fittingType = getappdata(0,''popupmenuFitting',upper(PARA),''');'])
        fittingType = fittingType{1};



        % function handle to calculate the difference between simulated value and modelled value
        eval(['f = @ (k_i,namesMatrix_i,vFrMatrix_i,nameFiller_i,porosity_i,',PARA,FUNCs,') k_i - k_',modelName,'(namesMatrix_i,vFrMatrix_i,nameFiller_i,porosity_i,curveName,modelAdditiveName,modeTortuosity,a,c,e,g);'])

 
        f_PARA = cell(1,size(data,2));
        for ii = 1 : size(data,2)
            eval(['f_PARA{1,ii} = @(PARA) f(k(1,ii),namesMatrix{1,ii},vFrMatrix(1:2,ii),nameFiller{1,ii},porosity(1,ii),PARA',funcValues,');'])
        end
        clear ii
        
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : ',' 0/',num2str(size(data,2)),' (',num2str(round((sum(get(handles.textWaitBar,'Position') .* [0 0 1 0]) - 21) / 100 * 100,0)),' %)'],'HorizontalAlignment','Center');
        pause(0.2)
        for ii = 1 : size(data,2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : ',num2str(ii),'/',num2str(size(data,2)),' (', num2str(round((sum(get(handles.textWaitBar,'Position') .* [0 0 1 0]) - 21) / 100 * 100,0)),' %) ...'],'HorizontalAlignment','Center');
            pause(0.2)
            fprintf('------------ For data %d ------------\n',ii)
            options = optimset('Display','off');
            eval(['f_PARA{1,ii} = @(PARA) f(k(1,ii),namesMatrix{1,ii},vFrMatrix(1:2,ii),nameFiller{1,ii},porosity(1,ii),PARA',funcValues,');'])
            
            if f_PARA{1,ii}(0) < f_PARA{1,ii}(epsilon)  % monotonically increasing
                if f_PARA{1,ii}(0) == 0
                    eval([PARA,'(1,ii) = 0;'])
                elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) < 0.05
                    eval([PARA,'(1,ii) = 0;'])
                    fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) >= 0.05
                    fprintf('%s cannot be found for data %d.\n',PARA,ii)
                    eval([PARA,'(1,ii) = NaN;'])
                elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) < 0.05
                    eval([PARA,'(1,ii) = 0;'])
                    fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                else
                    fprintf('%s is being iterated for data %d.\n',PARA,ii)
                    para_iter = 0;
                    while f_PARA{1,ii}(para_iter) < 0
                       para_iter = para_iter + 0.05; 
                    end
                    eval([PARA,'(1,ii) = fzero(f_PARA{1,ii},[0 para_iter],options);'])
                    eval(['fprintf(''%s = %6.4f for data %d.\n'',PARA,',PARA,'(1,ii),ii)'])
                end
            elseif f_PARA{1,ii}(0) > f_PARA{1,ii}(epsilon)  % monotonically decreasing
                    if f_PARA{1,ii}(0) == 0
                        eval([PARA,'(1,ii) = 0;'])
                    elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) < 0.05
                        eval([PARA,'(1,ii) = 0;'])
                        fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                    elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) >= 0.05
                        fprintf('%s cannot be found for data %d.\n',PARA,ii)
                        eval([PARA,'(1,ii) = NaN;'])
                    elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) < 0.05
                        eval([PARA,'(1,ii) = 0;'])
                        fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
                    else
                        fprintf('%s is being iterated for data %d.\n',PARA,ii)
                        para_iter = 0;
                        while f_PARA{1,ii}(para_iter) > 0
                           para_iter = para_iter + 0.05; 
                        end
                        eval([PARA,'(1,ii) = fzero(f_PARA{1,ii},[0 para_iter],options);'])
                        eval(['fprintf(''%s = %6.4f for data %d.\n'',PARA,',PARA,'(1,ii),ii)'])
                    end
            else
                if f_PARA{1,ii}(0) == 0
                        eval([PARA,'(1,ii) = 0;'])
                else
                        fprintf('%s cannot be found for data %d.\n',PARA,ii)
                        eval([PARA,'(1,ii) = NaN;'])
                end
            end
            x = 21 + nowHWait/numHWait * 100 / size(data,2) * ii;
            set(handles.textWaitBar,'Position',[0 0 x 1])
            clear x
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : ',num2str(ii),'/',num2str(size(data,2)),' (', num2str(round((sum(get(handles.textWaitBar,'Position') .* [0 0 1 0]) - 21) / 100 * 100,0)),' %) is done'],'HorizontalAlignment','Center');
            pause(0.2)

        end
        clear ii
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Writing porosity ...'],'HorizontalAlignment','Center');
        pause(0.2)
        
        porosity_ = ['porosity',num2cell(porosity)];
        eval(['PARA_temp = ',PARA,';'])
        % MODIFIED BEGIN
        switch modeDivergence
            case 1
                eval(['PARA_temp(isnan(',PARA,')) = 0;'])
                eval([PARA,'_ = [''',PARA,''',num2cell(PARA_temp)];'])
            case 0
                eval([PARA,'_ = [''',PARA,''',num2cell(PARA_temp)];'])
                porosity_temp2 = porosity;
                eval(['porosity(isnan(',PARA,')) = [];'])
                eval(['PARA_temp(isnan(',PARA,')) = [];'])
        end     
        eval(['remark(isnan(',PARA,')) = {''divergent''};'])
        remark_ = ['remark',remark];
        % MODIFIED   END
        
        if ispc
            if ~exist(['results\',dirClock,'\',PARA],'dir')
                mkdir(['results\',dirClock,'\',PARA])
            end
        elseif isunix
            if ~exist(['results/',dirClock,'/',PARA],'dir')
                mkdir(['results/',dirClock,'/',PARA])
            end
        else
            disp('Platform not supported')
        end
        
        eval(['T = table(porosity_'',',PARA,'_'',remark_'');'])
        if ispc
            eval(['writetable(T,''results\',dirClock,'\',PARA,'\',PARA,'_porosity.xlsx'',''WriteVariableNames'',false)'])
        elseif isunix
            eval(['writetable(T,''results/',dirClock,'/',PARA,'/',PARA,'_porosity.xlsx'',''WriteVariableNames'',false)'])
        else
            disp('Platform not supported')
        end
        clear T

        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Writing porosity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        H = figure;
        hold on
        legends = cell(2,1);
        legends{1,1} = 'Numeric simulated Values';
        eval(['scatter(porosity,PARA_temp)'])
        x = linspace(0,1,101)';
        if strcmp(fittingType,'Linear')
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            eval(['p = polyfit(porosity,PARA_temp,1);'])
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve is done'],'HorizontalAlignment','Center');
            pause(0.2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            y_lin = polyval(p,x);
            y_lin(y_lin<0) = 0;
            plot(x,y_lin)
            for jj = 1 : size(PARAs,2)
                if strcmp(paraFit{1,jj},'Level 4')
                    eval(['paraFit{1,',num2str(jj),'} = ''@(porosity_i)',num2str(p(1,1)),' * porosity_i + ',num2str(p(1,2)),''';'])
                    eval(['set(handles.edit',upper(PARA),'Fit,''String'',paraFit{1,',num2str(jj),'})'])
                     
                    eval(['setappdata(0,''edit',upper(PARA),'Fit'',paraFit{1,',num2str(jj),'})'])
                end
            end
            clear jj
        elseif strcmp(fittingType,'Horizontal')
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            eval(['p_h = polyfit(porosity,PARA_temp,0);'])
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve is done'],'HorizontalAlignment','Center');
            pause(0.2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            y_hor = polyval(p_h(1,1),x);
            y_hor(y_hor<0) = 0;
            plot(x,y_hor)
            for jj = 1 : size(PARAs,2)
                if strcmp(paraFit{1,jj},'Level 1')
                    eval(['paraFit{1,',num2str(jj),'} = ',num2str(p_h(1,1)),''';'])
                    eval(['set(handles.edit',upper(PARA),'Fit,''String'',paraFit{1,',num2str(jj),'})'])
                     
                    eval(['setappdata(0,''edit',upper(PARA),'Fit'',paraFit{1,',num2str(jj),'})'])
                end
            end
            clear jj
        else
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            f_exp = @(a,x) a(1) * exp(a(2) * x);
            eval(['b = nlinfit(porosity,PARA_temp,f_exp,[0;0]);'])
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating fitting curve is done'],'HorizontalAlignment','Center');
            pause(0.2)
            set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve ...'],'HorizontalAlignment','Center');
            pause(0.2)
            y_exp = arrayfun(@(x) f_exp(b,x),x);
            plot(x,y_exp)
            for jj = 1 : size(PARAs,2)
                if strcmp(paraFit{1,jj},'Level 4')
                    eval(['paraFit{1,',num2str(jj),'} = ''@(porosity_i)',num2str(b(1)),' * exp(',num2str(b(2)),'* porosity_i)'';';])
                    eval(['set(handles.edit',upper(PARA),'Fit,''String'',paraFit{1,',num2str(jj),'})'])
                     
                    eval(['setappdata(0,''edit',upper(PARA),'Fit'',paraFit{1,',num2str(jj),'})'])
                end
            end
        end

        hold off
        xlabel('Porosity \phi / -')
        ylabel([PARA,' / -'])
        if strcmp(fittingType,'Linear')
            if p(1,2) > 0
                legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x + ', num2str(p(1,2))];
            elseif p(1,2) == 0
                legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x'];
            else
               legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x - ', num2str(abs(p(1,2)))]; 
            end   
        elseif strcmp(fittingType,'Horizontal')
               legends{2,1} = ['horizontal: y = ',num2str(p_h(1,1))]; 
        else
            legends{2,1} = ['exponential: y = ',num2str(b(1)),' * exp(',num2str(b(2)),' * x)'];
        end
        legend(legends)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting fitting curve is done'],'HorizontalAlignment','Center');
        pause(0.2)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving fitting curve ...'],'HorizontalAlignment','Center');
        pause(0.2)
        if ispc
            savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_porosity.fig'])
        elseif isunix
            savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_porosity.fig'])
        else
            disp('Platform not supported')
        end
        close(H)
        clear H    
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving fitting curve is done'],'HorizontalAlignment','Center');
        pause(0.2)
        

        % MODIFIED BEGIN
        switch modeDivergence
            case 1
            case 0
                porosity = porosity_temp2;
        end     
        % MODIFIED   END
        
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating thermal conductivity ...'],'HorizontalAlignment','Center');
        pause(0.2)
        k_0 = zeros(1,size(data,2));
        if strcmp(fittingType,'Linear')
            % linear
            k_lin = zeros(1,size(data,2));
            for ii = 1 : size(data,2)
                fprintf('Try to calculate k_0 and k_lin for data %d.\n',ii)
                k_0(1,ii) = k(1,ii) - f_PARA{1,ii}(0);
                try
                    k_lin(1,ii) = k(1,ii) - f_PARA{1,ii}(p(1,1) * porosity(1,ii) + p(1,2));
                catch
                    k_lin(1,ii) = NaN;
                end
            end
            clear ii
        elseif strcmp(fittingType,'Horizontal')
            % horizontal
            k_hor = zeros(1,size(data,2));
            for ii = 1 : size(data,2)
                fprintf('Try to calculate k_0 and k_hor for data %d.\n',ii)
                k_0(1,ii) = k(1,ii) - f_PARA{1,ii}(0);
                try
                    k_hor(1,ii) = k(1,ii) - f_PARA{1,ii}(p_h(1,1));
                catch
                    k_hor(1,ii) = NaN;
                end
            end
            clear ii
        else
            % exponential
            k_exp = zeros(1,size(data,2));
            for ii = 1 : size(data,2)
                fprintf('Try to calculate k_exp for data %d.\n',ii)
                k_0(1,ii) = k(1,ii) - f_PARA{1,ii}(0);
                try
                    k_exp(1,ii) = k(1,ii) - f_PARA{1,ii}(b(1) * exp(b(2) * porosity(1,ii)));
                catch
                    k_exp(1,ii) = NaN;
                end
            end
            clear ii
        end
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating thermal conductivity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Plotting thermal conductivity ...'],'HorizontalAlignment','Center');
        pause(0.2)
        if strcmp(fittingType,'Linear')
            H = figure;
            hold on
            scatter(porosity,k,'o')
            scatter(porosity,k_0,'x')
            scatter(porosity,k_lin,'s')

            hold off
            xlabel('Porosity \phi / -')
            ylabel('Thermal conductivity / W/(m * K)')
            legend({'Numeric simulated Values';'unfitted Values';[PARA,' linear fitted Values']})
            if ispc
                savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_linear.fig'])
            elseif isunix
                savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_linear.fig'])
            else
                disp('Platform not supported')
            end
            close(H)
            clear H
        elseif strcmp(fittingType,'Horizontal')
            H = figure;
            hold on
            scatter(porosity,k,'o')
            scatter(porosity,k_0,'x')
            scatter(porosity,k_hor,'s')

            hold off
            xlabel('Porosity \phi / -')
            ylabel('Thermal conductivity / W/(m * K)')
            legend({'Numeric simulated Values';'unfitted Values';[PARA,' horizontal fitted Values']})
            if ispc
                savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_horizontal.fig'])
            elseif isunix
                savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_horizontal.fig'])
            else
                disp('Platform not supported')
            end
            close(H)
            clear H
        else
            H = figure;
            hold on
            scatter(porosity,k,'o')
            scatter(porosity,k_0,'x')
            scatter(porosity,k_exp,'s')

            hold off
            xlabel('Porosity \phi / -')
            ylabel('Thermal conductivity / W/(m * K)')
            legend({'Numeric simulated values';'unfitted values';[PARA,' exponential fitted values']})
            if ispc
                savefig(H,['results\',dirClock,'\',PARA,'\',PARA,'_exponential.fig'])
            elseif isunix
                savefig(H,['results/',dirClock,'/',PARA,'/',PARA,'_exponential.fig'])
            else
                disp('Platform not supported')
            end
            close(H)
            clear H
        end
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Calculating thermal conductivity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving thermal conductivity ...'],'HorizontalAlignment','Center');
        pause(0.2)
        
        k_ = ['k numeric',num2cell(k)];
        k_0_ = ['k not fitted',num2cell(k_0)];
        
        if strcmp(fittingType,'Linear')
            k_lin_ = ['k linearly fitted',num2cell(k_lin)];
            T = table(k_',k_0_',k_lin_');
            if ispc
                writetable(T,['results\',dirClock,'\',PARA,'\',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            elseif isunix
                writetable(T,['results/',dirClock,'/',PARA,'/',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)           
            else
                disp('Platform not supported')
            end
            clear T
        elseif strcmp(fittingType,'Horizontal')
            k_hor_ = ['k horizontally fitted',num2cell(k_hor)];
            T = table(k_',k_0_',k_hor_');
            if ispc
                writetable(T,['results\',dirClock,'\',PARA,'\',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            elseif isunix
                writetable(T,['results/',dirClock,'/',PARA,'/',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)           
            else
                disp('Platform not supported')
            end
            clear T
        else
            k_exp_ = ['k exponentially fitted',num2cell(k_exp)];
            T = table(k_',k_0_',k_exp_');
            if ispc
                writetable(T,['results\',dirClock,'\',PARA,'\',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            elseif isunix
                writetable(T,['results/',dirClock,'/',PARA,'/',PARA,'_thermalConductivities.xlsx'],'WriteVariableNames',false)
            else
                disp('Platform not supported')
            end
            clear T
        end
        
        set(handles.textWaitBar,'String',['L',num2str(nowHWait),' : Saving thermal conductivity is done'],'HorizontalAlignment','Center');
        pause(0.2)
        eval(['set(handles.textTick',upper(PARA),',''Visible'',''On'')'])  
        eval(['set(handles.textTick',upper(PARA),',''String'',''O'')'])
    end

    set(handles.textWaitBar,'Position',[0 0 121 1])
    set(handles.textWaitBar,'String','Completed','HorizontalAlignment','Center')
    for ii = 1 : 100
        pause(0.03)
        set(handles.textWaitBar,'BackgroundColor',[0.47, 0.67, 0.19] + ([0.9,0.9,1] -  [0.47, 0.67, 0.19]) * (ii/100))
    end
    set(handles.textWaitBar,'String','','Position',[0 0 0 1],'HorizontalAlignment','Center')
catch
    isTickA = get(handles.textTickA,'Visible');
    numA = get(handles.popupmenuAFit,'Value');
    strA = get(handles.popupmenuAFit,'String');
    try 
        nowA = strA(numA);
        nowA = nowA{1};
        isLevelA = strcmp(nowA(1:5),'Level');
    catch
        isLevelA = 0;
    end

    if strcmp(isTickA,'off') && isLevelA == 1
        set(handles.textTickA,'Visible','On')
        set(handles.textTickA,'String','X')
    end
    
    isTickC = get(handles.textTickC,'Visible');
    numC = get(handles.popupmenuCFit,'Value');
    strC = get(handles.popupmenuCFit,'String');
    try 
        nowC = strC(numC);
        nowC = nowC{1};
        isLevelC = strcmp(nowC(1:5),'Level');
    catch
        isLevelC = 0;
    end
    if strcmp(isTickC,'off') && isLevelC == 1
        set(handles.textTickC,'Visible','On')
        set(handles.textTickC,'String','X')
    end
    
    isTickE = get(handles.textTickE,'Visible');
    numE = get(handles.popupmenuEFit,'Value');
    strE = get(handles.popupmenuEFit,'String');
    try 
        nowE = strE(numE);
        nowE = nowE{1};
        isLevelE = strcmp(nowE(1:5),'Level');
    catch
        isLevelE = 0;
    end
    if strcmp(isTickE,'off') && isLevelE == 1
        set(handles.textTickE,'Visible','On')
        set(handles.textTickE,'String','X')
    end
    
    isTickG = get(handles.textTickG,'Visible');
    numG = get(handles.popupmenuGFit,'Value');
    strG = get(handles.popupmenuGFit,'String');
    try 
        nowG = strG(numG);
        nowG = nowG{1};
        isLevelG = strcmp(nowG(1:5),'Level');
    catch
        isLevelG = 0;
    end
    if strcmp(isTickG,'off') && isLevelG == 1
        set(handles.textTickG,'Visible','On')
        set(handles.textTickG,'String','X')
    end
    
    
    msgbox('Please check all relevant input.')
    set(handles.textWaitBar,'BackgroundColor','r')
    set(handles.textWaitBar,'String','Error','HorizontalAlignment','Center')
    setappdata(0,'backgroundColor',[1 0 0])
    for ii = 1 : 100
        pause(0.03)
        set(handles.textWaitBar,'BackgroundColor',[1,0,0] + ([0.9,0.9,1] -  [1,0,0]) * (ii/100))
    end
    set(handles.textWaitBar,'String','','Position',[0 0 0 1])
end





% --- Executes on button press in radiobuttonFitting.
function radiobuttonFitting_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonFitting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonFitting
numRadioButtonFitting = get(handles.radiobuttonFitting,'Value');
if numRadioButtonFitting == 0
    
    set(handles.textLambda,'Visible','On')
    set(handles.popupmenuFractionType,'Visible','On')
    set(handles.popupmenuFractionType,'Enable','On')
    set(handles.popupmenuFractionType,'Value',1)
    
    set(handles.textAM,'Visible','On')
    set(handles.popupmenuAM,'Visible','On')
    set(handles.popupmenuAM,'Enable','On')
    set(handles.popupmenuAM,'Value',1)
    set(handles.editAM,'Visible','On')
    set(handles.editAM,'Enable','On')
    set(handles.editAM,'String',100)  
    set(handles.textFractionAM,'Visible','On')
    set(handles.textFractionAM,'Enable','On')   
    
    set(handles.textCA,'Visible','On')
    set(handles.popupmenuCA,'Visible','On')
    set(handles.popupmenuCA,'Enable','On')
    set(handles.popupmenuCA,'Value',1)
    set(handles.editCA,'Visible','On')
    set(handles.editCA,'Enable','On')
    set(handles.editCA,'String',0)   
    set(handles.textFractionCA,'Visible','On')
    set(handles.textFractionCA,'Enable','On')   
    
    set(handles.textB,'Visible','On')
    set(handles.popupmenuB,'Visible','On')
    set(handles.popupmenuB,'Enable','On')
    set(handles.popupmenuB,'Value',1)
    set(handles.editB,'Visible','On')
    set(handles.editB,'Enable','On')
    set(handles.editB,'String',0)  
    set(handles.textFractionB,'Visible','On')
    set(handles.textFractionB,'Enable','On')   
    
    set(handles.textMedium,'Visible','On')
    set(handles.popupmenuMedium,'Visible','On')
    set(handles.popupmenuMedium,'Enable','On')
    set(handles.popupmenuMedium,'Value',1)

    set(handles.textPorosity,'Visible','On')
    set(handles.editPorosity,'Visible','On')
    set(handles.editPorosity,'Enable','On')
    set(handles.editPorosity,'String',0)  
    set(handles.textFractionPorosity,'Visible','On')
    set(handles.textFractionPorosity,'Enable','On')

    set(handles.popupmenuModel,'Enable','On')
    set(handles.textA,'Visible','On')
    set(handles.editA,'Visible','On')
    set(handles.editA,'Enable','On')
    set(handles.editA,'String',num2str(0))
    setappdata(0,'editA',0)
    
    set(handles.textC,'Visible','On')
    set(handles.editC,'Visible','On')
    set(handles.editC,'Enable','On')
    set(handles.editC,'String',num2str(0))
    setappdata(0,'editC',0)
    
    set(handles.textE,'Visible','On')
    set(handles.editE,'Visible','On')
    set(handles.editE,'Enable','On')
    set(handles.editE,'String',num2str(0))
    setappdata(0,'editE',0)
    
    set(handles.textG,'Visible','On')
    set(handles.editG,'Visible','On')
    set(handles.editG,'Enable','On')
    set(handles.editG,'String',num2str(0))
    setappdata(0,'editG',0)
    
    set(handles.textResult,'Visible','On')
    set(handles.editResult,'Visible','On')
    set(handles.editResult,'Enable','On')
    set(handles.editResult,'String','Result')
    setappdata(0,'editResult',[])
    set(handles.pushbuttonCalculation,'Visible','On')
    set(handles.pushbuttonCalculation,'Enable','On')

    set(handles.textFitting,'Visible','Off')
    set(handles.popupmenuFittingA,'Visible','Off')
    set(handles.popupmenuFittingA,'Enable','Off')
    set(handles.popupmenuFittingA,'Value',0)
    setappdata(0,'popupmenuFittingA',[])
    
    set(handles.popupmenuFittingC,'Visible','Off')
    set(handles.popupmenuFittingC,'Enable','Off')
    set(handles.popupmenuFittingC,'Value',[])
    setappdata(0,'popupmenuFittingC',[])

    set(handles.popupmenuFittingE,'Visible','Off')
    set(handles.popupmenuFittingE,'Enable','Off')
    set(handles.popupmenuFittingE,'Value',[])
    setappdata(0,'popupmenuFittingE',[])

    set(handles.popupmenuFittingG,'Visible','Off')
    set(handles.popupmenuFittingG,'Enable','Off')
    set(handles.popupmenuFittingG,'Value',[])
    setappdata(0,'popupmenuFittingG',[])

    set(handles.textAFit,'Visible','Off')
    set(handles.popupmenuAFit,'Visible','Off')
    set(handles.popupmenuAFit,'Enable','Off')
    set(handles.popupmenuAFit,'Value',1)
    strAFit = getappdata(0,'aFitList');
    set(handles.popupmenuAFit,'String',strAFit)
    set(handles.editAFit,'Visible','Off')
    set(handles.editAFit,'Enable','Off')
    
    set(handles.textCFit,'Visible','Off')
    set(handles.popupmenuCFit,'Visible','Off')
    set(handles.popupmenuCFit,'Enable','Off')
    set(handles.popupmenuCFit,'Value',1)
    strCFit = getappdata(0,'cFitList');
    set(handles.popupmenuCFit,'String',strCFit)
    set(handles.editCFit,'Visible','Off')
    set(handles.editCFit,'Enable','Off')
    
    set(handles.textEFit,'Visible','Off')
    set(handles.popupmenuEFit,'Visible','Off')
    set(handles.popupmenuEFit,'Enable','Off')
    set(handles.popupmenuEFit,'Value',1)
    strCFit = getappdata(0,'cFitList');
    set(handles.popupmenuCFit,'String',strCFit)
    set(handles.editEFit,'Visible','Off')
    set(handles.editEFit,'Enable','Off')
    
    set(handles.textGFit,'Visible','Off')
    set(handles.popupmenuGFit,'Visible','Off')
    set(handles.popupmenuGFit,'Enable','Off')
    set(handles.popupmenuGFit,'Value',1)
    strGFit = getappdata(0,'gFitList');
    set(handles.popupmenuGFit,'String',strGFit)
    set(handles.editGFit,'Visible','Off')
    set(handles.editGFit,'Enable','Off')
    
    set(handles.pushbuttonFitting,'Visible','Off')
    set(handles.pushbuttonFitting,'Enable','Off')
    
    set(handles.textTickA,'Visible','Off')
    set(handles.textTickC,'Visible','Off')
    set(handles.textTickE,'Visible','Off')
    set(handles.textTickG,'Visible','Off')
    
else
    set(handles.textLambda,'Visible','Off')
    set(handles.popupmenuFractionType,'Visible','Off')
    set(handles.popupmenuFractionType,'Enable','Off')
    set(handles.popupmenuFractionType,'Value',1)
    
    set(handles.textAM,'Visible','Off')
    set(handles.popupmenuAM,'Visible','Off')
    set(handles.popupmenuAM,'Enable','Off')
    set(handles.popupmenuAM,'Value',1)
    set(handles.editOtherAM,'Visible','Off')
    set(handles.editOtherAM,'Enable','Off')
    set(handles.editOtherAM,'String',[])
    set(handles.editAM,'Visible','Off')
    set(handles.editAM,'Enable','Off')
    set(handles.editAM,'String',[])   
    set(handles.textFractionAM,'Visible','Off')
    set(handles.textFractionAM,'Enable','Off')    
    
    set(handles.textCA,'Visible','Off')
    set(handles.popupmenuCA,'Visible','Off')
    set(handles.popupmenuCA,'Enable','Off')
    set(handles.popupmenuCA,'Value',1)
    set(handles.editOtherCA,'Visible','Off')
    set(handles.editOtherCA,'Enable','Off')
    set(handles.editOtherCA,'String',[])
    set(handles.editCA,'Visible','Off')
    set(handles.editCA,'Enable','Off')
    set(handles.editCA,'String',[])   
    set(handles.textFractionCA,'Visible','Off')
    set(handles.textFractionCA,'Enable','Off') 
    
    set(handles.textB,'Visible','Off')
    set(handles.popupmenuB,'Visible','Off')
    set(handles.popupmenuB,'Enable','Off')
    set(handles.popupmenuB,'Value',1)
    set(handles.editOtherB,'Visible','Off')
    set(handles.editOtherB,'Enable','Off')
    set(handles.editOtherB,'String',[])
    set(handles.editB,'Visible','Off')
    set(handles.editB,'Enable','Off')
    set(handles.editB,'String',[])   
    set(handles.textFractionB,'Visible','Off')
    set(handles.textFractionB,'Enable','Off') 
    
    set(handles.textMedium,'Visible','Off')
    set(handles.popupmenuMedium,'Visible','Off')
    set(handles.popupmenuMedium,'Enable','Off')
    set(handles.popupmenuMedium,'Value',1)
    set(handles.editOtherMedium,'Visible','Off')
    set(handles.editOtherMedium,'Enable','Off')
    set(handles.editOtherMedium,'String',[])
    
    set(handles.textPorosity,'Visible','Off')
    set(handles.editPorosity,'Visible','Off')
    set(handles.editPorosity,'Enable','Off')
    set(handles.editPorosity,'String',[])
    set(handles.textFractionPorosity,'Visible','Off')
    set(handles.textFractionPorosity,'Enable','Off') 

    set(handles.popupmenuModel,'Enable','Off')
    set(handles.textA,'Visible','Off')
    set(handles.editA,'Visible','Off')
    set(handles.editA,'Enable','Off')
    set(handles.editA,'String',[])
    setappdata(0,'editA',[])

    set(handles.textC,'Visible','Off')
    set(handles.editC,'Visible','Off')
    set(handles.editC,'Enable','Off')
    set(handles.editC,'String',[])
    setappdata(0,'editC',[])
    
    set(handles.textE,'Visible','Off')
    set(handles.editE,'Visible','Off')
    set(handles.editE,'Enable','Off')
    set(handles.editE,'String',[])
    setappdata(0,'editE',[])
    
    set(handles.textG,'Visible','Off')
    set(handles.editG,'Visible','Off')
    set(handles.editG,'Enable','Off')
    set(handles.editG,'String',[])
    setappdata(0,'editG',[])
    
    set(handles.textResult,'Visible','Off')
    set(handles.editResult,'Visible','Off')
    set(handles.editResult,'Enable','Off')
    set(handles.editA,'String',[])
    setappdata(0,'editResult',[])
    set(handles.pushbuttonCalculation,'Visible','Off')
    set(handles.pushbuttonCalculation,'Enable','Off')
    
    set(handles.textFitting,'Visible','On')
    set(handles.popupmenuFittingA,'Visible','Off')
    set(handles.popupmenuFittingA,'Enable','Off')
    set(handles.popupmenuFittingA,'Value',[])
    setappdata(0,'popupmenuFittingA',[])
    
    set(handles.popupmenuFittingC,'Visible','Off')
    set(handles.popupmenuFittingC,'Enable','Off')
    set(handles.popupmenuFittingC,'Value',[])
    setappdata(0,'popupmenuFittingC',[])

    set(handles.popupmenuFittingE,'Visible','Off')
    set(handles.popupmenuFittingE,'Enable','Off')
    set(handles.popupmenuFittingE,'Value',[])
    setappdata(0,'popupmenuFittingE',[])

    set(handles.popupmenuFittingG,'Visible','Off')
    set(handles.popupmenuFittingG,'Enable','Off')
    set(handles.popupmenuFittingG,'Value',[])
    setappdata(0,'popupmenuFittingG',[])
    
    set(handles.textAFit,'Visible','On')
    set(handles.popupmenuAFit,'Visible','On')
    set(handles.popupmenuAFit,'Enable','On')
    set(handles.popupmenuAFit,'Value',1)
    strAFit = getappdata(0,'aFitList');
    set(handles.popupmenuAFit,'String',strAFit)
    set(handles.editAFit,'Visible','Off')
    set(handles.editAFit,'Enable','Off')
    
    
    set(handles.textCFit,'Visible','On')
    set(handles.popupmenuCFit,'Visible','On')
    set(handles.popupmenuCFit,'Enable','On')
    set(handles.popupmenuCFit,'Value',1)
    strCFit = getappdata(0,'cFitList');
    set(handles.popupmenuCFit,'String',strCFit)
    set(handles.editCFit,'Visible','Off')
    set(handles.editCFit,'Enable','Off')
    
    set(handles.textEFit,'Visible','On')
    set(handles.popupmenuEFit,'Visible','On')
    set(handles.popupmenuEFit,'Enable','On')
    set(handles.popupmenuEFit,'Value',1)
    strEFit = getappdata(0,'eFitList');
    set(handles.popupmenuEFit,'String',strEFit)
    set(handles.editEFit,'Visible','Off')
    set(handles.editEFit,'Enable','Off')
    
    set(handles.textGFit,'Visible','On')
    set(handles.popupmenuGFit,'Visible','On')
    set(handles.popupmenuGFit,'Enable','On')
    set(handles.popupmenuGFit,'Value',1)
    strGFit = getappdata(0,'gFitList');
    set(handles.popupmenuGFit,'String',strGFit)
    set(handles.editGFit,'Visible','Off')
    set(handles.editGFit,'Enable','Off')
    
    set(handles.pushbuttonFitting,'Visible','On')
    set(handles.pushbuttonFitting,'Enable','On')
    
    set(handles.textTickA,'Visible','Off')
    set(handles.textTickC,'Visible','Off')
    set(handles.textTickE,'Visible','Off')
    set(handles.textTickG,'Visible','Off')
end


% --- Executes on selection change in popupmenuFittingA.
function popupmenuFittingA_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuFittingA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuFittingA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuFittingA
numFittingA = get(handles.popupmenuFittingA,'Value');
strFittingA = get(handles.popupmenuFittingA,'String');
setappdata(0,'popupmenuFittingA',strFittingA(numFittingA))


% --- Executes during object creation, after setting all properties.
function popupmenuFittingA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuFittingA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuFittingC.
function popupmenuFittingC_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuFittingC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuFittingC contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuFittingC
numFittingC = get(handles.popupmenuFittingC,'Value');
strFittingC = get(handles.popupmenuFittingC,'String');
setappdata(0,'popupmenuFittingC',strFittingC(numFittingC))



% --- Executes during object creation, after setting all properties.
function popupmenuFittingC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuFittingC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuFittingE.
function popupmenuFittingE_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuFittingE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuFittingE contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuFittingE
numFittingE = get(handles.popupmenuFittingE,'Value');
strFittingE = get(handles.popupmenuFittingE,'String');
setappdata(0,'popupmenuFittingE',strFittingE(numFittingE))


% --- Executes during object creation, after setting all properties.
function popupmenuFittingE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuFittingE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuFittingG.
function popupmenuFittingG_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuFittingG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuFittingG contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuFittingG
numFittingG = get(handles.popupmenuFittingG,'Value');
strFittingG = get(handles.popupmenuFittingG,'String');
setappdata(0,'popupmenuFittingG',strFittingG(numFittingG)) 


% --- Executes during object creation, after setting all properties.
function popupmenuFittingG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuFittingG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over textWaitBar.
function textWaitBar_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to textWaitBar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
z = 500;
for ii = 1 : z
    set(handles.textWaitBar,'BackgroundColor',getappdata(0,'backgroundColor') + ([0.9 0.9 1] - getappdata(0,'backgroundColor')) * ii / z)
    pause(0.001)
end
clear z ii
set(handles.textWaitBar,'Position',[0 0 0 1.5])
set(handles.textWaitBar,'String',[])
set(handles.textWaitBar,'ForegroundColor','w','FontWeight','Bold','FontSize',8,'FontSize',8,'BackgroundColor',[0.47, 0.67, 0.19])


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
