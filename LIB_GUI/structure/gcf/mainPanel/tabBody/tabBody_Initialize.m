%% TABBODY_INITIALIZE
% creates and initializes the tab bodies, saves the handles to the handles.

% Create and initialize the tab bodies
pos_mainPanel = get(handles.mainPanel,'Position');
pos_tabPage = [ 1, ...
                1, ...
                pos_mainPanel(3), ...
                pos_mainPanel(4) - fix(pos_mainPanel(4) * heightRatio_tabHead)]; 
for ii = 1 : number_tabPage
    % Create and initialize the tab body ii
    h_tabBody_tmp = uipanel( ...
        'Parent', handles.mainPanel, ...
        'Tag', ['tabBody_', item_tabPage{ii}], ...
        'Units', 'pixels', ...
        'Position', pos_tabPage, ...
        'BorderType', borderType_tabBody, ...
        'Visible', 'off', ...
        'BackgroundColor', backgroundColor_tabBody);
    
    % Set the background for the main panel
    handles = section_backgroundImage(h_tabBody_tmp, ['tabBody_',item_tabPage{ii}], 'adjusted', handles);
    guidata(hObject, handles);

    
    % save this handle to handles
    strEval = [ 'handles.tabBody_', item_tabPage{ii}, ' = ', ...
                'h_tabBody_tmp;'];
    eval(strEval)
    clear strEval
    clear h_tabBody_tmp
    guidata(hObject, handles);
    
    % create the components of the tab body ii
    strEval = ['tabBody_',item_tabPage{ii}, '_Initialize'];
    eval(strEval)
    clear strEval
end
clear ii

clear pos_mainPanel
clear pos_tabPage



