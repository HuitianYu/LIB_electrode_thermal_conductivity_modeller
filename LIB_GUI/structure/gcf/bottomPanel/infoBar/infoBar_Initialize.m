%% INFOBAR_INITIALIZE
% creates and initialzes the info bar in the bottom panel,
% saves the handle to handles.

%% create and initialze an info bar in the bottom panel.
pos_bottomPanel = get(handles.bottomPanel, 'Position');
h_infoBar = label_middle_Initialize(...
    handles.bottomPanel, [], fontColor_infoBar, ...
    [1, ...
    pos_bottomPanel(4) - fix(heightRatio_infoBar * pos_bottomPanel(4)), ...
    fix(pos_bottomPanel(3)), ...
    fix(heightRatio_infoBar * pos_bottomPanel(4))], ...
    fontSize_infoBar, fontWeight_infoBar, ...
    'adjusted');
clear pos_bottomPanel



%% Save the handle to handles
set(h_infoBar, 'Tag', 'infoBar')
handles.infoBar = h_infoBar;
clear h_infoBar
guidata(hObject, handles);

setappdata(0, 'stateProgram', 0)
    % 0: program stopped, 1: program running , 2: program paused

%% Set the call backs
% Set the call back and key press function for the info bar
set(handles.infoBar, 'CallBack', {@infoBar_Callback, handles})
set(handles.infoBar, 'KeyPressFcn', {@infoBar_Keypressfcn, handles})

