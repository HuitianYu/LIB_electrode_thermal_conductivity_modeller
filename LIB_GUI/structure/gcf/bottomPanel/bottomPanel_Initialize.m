%% BOTTOMPANEL_INITIALIZE
% creates and initializes the bottom panel, saves the handle to handles.

%% Create a handle of the bottom panel and set the properties
h_bottomPanel = uipanel( ...
                    'Parent', gcf, ...
                    'Units', 'pixels', ...
                    'Tag', 'bottomPanel', ...
                    'Position', ...
                    [1, 1, ...
                    width_gcf, ...
                    height_gcf - fix(height_gcf * heightRatio_mainPanel)], ...
                    'BorderType',boderType_bottomPanel, ...
                    'BackgroundColor', backgroundColor_bottomPanel ...
                    );

% Set the background for the main panel
handles = section_backgroundImage(h_bottomPanel, 'bottomPanel', 'adjusted', handles);
guidata(hObject, handles);


%% Save the handle of the bottom panel to handles
handles.bottomPanel = h_bottomPanel;
clear h_bottomPanel
guidata(hObject, handles);

%% Create and initialize the info bar and the colro bar
infoBar_Initialize
colorBar_Initialize

%% Show the welcome information
% set the welcome string of the info bar
% change the task icon
[~, strWeekday] = weekday(datestr(now), 'long');
str_infoBar = ['Welcome back! ', ...
        'It is ',strWeekday, ', ', datestr(now,1), ' today.'];
clear strWeekday

% set the initial length ratio of the color bar
my_waitbar(0, str_infoBar, handles);
clear str_infoBar
