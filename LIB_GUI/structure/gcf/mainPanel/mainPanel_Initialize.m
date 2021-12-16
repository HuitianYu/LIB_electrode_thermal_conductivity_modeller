%% MAINPANEL_INITIALIZE
% creates and initialize the main panel, saves the handle to handles.

%% Create a handle fot the main panel and set the properties
h_mainPanel = uipanel( ...
                'Parent', gcf, ...
                'Tag', 'mainPanel', ...
                'Units', 'pixels', ...
                'Position', ...
                [1, ...
                height_gcf - fix(height_gcf * heightRatio_mainPanel) + 1, ...
                width_gcf, ...
                fix(height_gcf * heightRatio_mainPanel)], ...
                'borderType',boderType_mainPanel, ...
                'backgroundColor', backgroundColor_mainPanel ...
                );

% Set the background for the main panel
handles = section_backgroundImage(h_mainPanel, 'mainPanel', 'adjusted', handles);
guidata(hObject, handles);

        

%% Save the handle of the main panel to handles
handles.mainPanel = h_mainPanel;
clear h_mainPanel
guidata(hObject, handles);

%% Create and initialize the components in this main panel

% Create and initialize the tab body
tabBody_Initialize

% Create and initialize the tab head
tabHead_Initialize

% Create and initialize a top line at the top of the tab head in the main
% panel
topLine_mainPanel_Initialize

% Create and initialize a separate line between tab body and tab head using panel
separateLine_mainPanel_Initialize

% Create and initialize a bottom line at the bottom of the tab body in the main
% panel
bottomLine_mainPanel_Initialize






