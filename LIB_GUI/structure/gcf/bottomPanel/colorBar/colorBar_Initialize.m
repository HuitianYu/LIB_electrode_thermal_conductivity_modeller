%% COLORBAR_INITIALIZE
% creates and initialzes the color bar in the bottom panel,
% saves the handle to handles.

%% create and initialze the color bar in the bottom panel.
pos_bottomPanel = get(handles.bottomPanel, 'Position');
pos_colorBar = ...
    [fix(0.5 * pos_bottomPanel(3))...
        - fix(0.5 * pos_bottomPanel(3) * widthRatio_colorBar), ...
    fix(0.5 * pos_bottomPanel(4) * heightRatio_infoBar) - ...
        fix(0.5 * pos_bottomPanel(4) * heightRatio_infoBar * heightRatio_colorBar) + 1, ...
    2 * fix(0.5 * pos_bottomPanel(3) * widthRatio_colorBar), ...
    2 * fix(0.5 * pos_bottomPanel(4) * heightRatio_infoBar * heightRatio_colorBar)];
h_colorBar = uicontrol( ...
            'Parent', handles.bottomPanel, ...
            'Style', 'text', ...
            'Enable', 'off', ...
            'Units', 'pixels', ...
            'Position', ...
            pos_colorBar, ...
            'BackgroundColor', ...
            color_theme * colorStrengthRatio_colorBar + ...
            1 * (1 - colorStrengthRatio_colorBar) ...
            );
clear pos_bottomPanel
clear pos_colorBar


%% Save the handle to handles
set(h_colorBar, 'Tag', 'colorBar')
handles.colorBar = h_colorBar;
clear h_colorBar
guidata(hObject, handles);

%% save a handle of the length ratio for the info bar
setappdata(0,'position_colorBar_original', ...
    get(handles.colorBar, 'Position'))