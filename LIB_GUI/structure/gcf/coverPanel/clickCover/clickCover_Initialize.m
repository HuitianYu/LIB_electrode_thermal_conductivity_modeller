%% CLICKCOVER_INITIALIZE
% creates and initializes a middle label for click

% get the position of the cover panel
position_coverPanel = get(handles.coverPanel, 'Position');

% create and initialize the middle label
h_clickCover = label_middle_Initialize(...
    handles.coverPanel, 'CLICK TO START', ...
    fontColor_clickCover, ...
    [1, 1, position_coverPanel(3), position_coverPanel(4)], ...
    fontSize_clickCover, fontWeight_clickCover, ...
    'original');
set(h_clickCover, 'Enable', 'on')


% save click to handles
handles.clickCover = h_clickCover;
clear h_clickCover

% set the call back
set(handles.clickCover, 'Callback', {@coverPanel_Callback, handles})