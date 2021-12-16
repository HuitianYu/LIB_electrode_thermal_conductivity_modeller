%% COVERPANEL_INITIALIZE
% creates and initialize the cover, saves the handle to handles.

%% Create and initialize a handle fot the cover panel and set the properties
h_coverPanel =  uipanel( ...
                'Parent', gcf, ...
                'Tag', 'coverPanel', ...
                'Units', 'pixels', ...
                'Position', ...
                [1, 1, width_gcf, height_gcf], ...
                'borderType',boderType_coverPanel, ...
                'backgroundColor', backgroundColor_coverPanel ...
                );

% Set the background for the main panel
handles = section_backgroundImage(h_coverPanel, 'coverPanel', 'original', handles);
guidata(hObject, handles);

        

%% Save the handle of the cover to handles
set(h_coverPanel, 'tag', 'coverPanel')
handles.coverPanel = h_coverPanel;
clear h_coverPanel
guidata(hObject, handles);

%% Create and intialize components in the cover panel
clickCover_Initialize








