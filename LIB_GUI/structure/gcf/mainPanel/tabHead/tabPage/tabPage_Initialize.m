% TAGPAGE_INITIALIZE
% creates and initialize the tab pages in tab head, 
% saves the handles to handles

%% Create and initialize the tab pages, save the handles to handels
% Create handles for the icons of active and inactive state and resize the icons
size_icon = fix([height_gcf * ...
                heightRatio_mainPanel * ...
                heightRatio_tabHead * ...
                heightRatio_tabPage, ...
                width_gcf / ...
                number_tabPage * ...
                widthRatio_tabPage]);


h_tabPage_icon_active = getappdata(0, 'tabPage_icon_active');
h_tabPage_icon_inactive = getappdata(0, 'tabPage_icon_inactive');

h_tabPage_icon_active_resized = imresize(h_tabPage_icon_active,size_icon);
h_tabPage_icon_inactive_resized = imresize(h_tabPage_icon_inactive,size_icon);

setappdata(0, 'tabPage_icon_active_resized', h_tabPage_icon_active_resized)
setappdata(0, 'tabPage_icon_inactive_resized', h_tabPage_icon_inactive_resized)


clear icon_size gcf_innerPosition

pos_tabHead = get(handles.tabHead, 'Position');
% For-loop for the creation and initializaiton
for ii = 1 : number_tabPage
    pos_tabPage = [ fix((ii - 0.5) * pos_tabHead(3) / number_tabPage) - ...
                        fix(0.5  * pos_tabHead(3) / number_tabPage * widthRatio_tabPage), ...
                    fix(0.5 * pos_tabHead(4)) - fix(0.5 * pos_tabHead(4) * heightRatio_tabPage), ...
                    2 * fix(0.5  * pos_tabHead(3) / number_tabPage * widthRatio_tabPage), ...
                    2 * fix(0.5 * pos_tabHead(4) * heightRatio_tabPage)];
    % Create and initialize the tab page ii 
    h_tabPage_tmp = uicontrol( ...
        'Parent', handles.tabHead, ...
        'Tag', ['tabPage_', item_tabPage{ii}], ...
        'Style', 'pushbutton', ...
        'Unit', 'pixels', ...
        'Position', pos_tabPage, ...
        'FontUnits', 'pixels', ...
        'FontSize', fontSize_tabPage, ...
        'FontWeight', fontWeight_tabPage, ...
        'String', item_tabPage{ii}, ...
        'ForegroundColor', foregroundColor_tabPage, ...
        'BackgroundColor', backgroundColor_tabPage); %#ok<NASGU>
    eval(['h_tabPage_', item_tabPage{ii}, ' = h_tabPage_tmp;'])
    clear pos_tabPage
    clear h_tabPage_tmp
    
    % save this handle to handles
    strEval = [ 'handles.tabPage_', item_tabPage{ii}, ' = ', ...
                'h_tabPage_', item_tabPage{ii},';'];
    eval(strEval)
    clear strEval
    strEval = [ 'clear h_tabPage_', item_tabPage{ii},''];
    eval(strEval)
    clear strEval
    
    % add background image to the icon
    eval(['h_tabPage_tmp = handles.tabPage_', item_tabPage{ii},';'])
    pos_h_tabPage_tmp = getpixelposition(h_tabPage_tmp, true);
    
    h_tabPage_icon_active_resized_add = ...
        add_icon_backgroundImage( ...
            getappdata(0, 'tabPage_icon_active_resized'), ...
            pos_h_tabPage_tmp, ...
            'adjusted', ...
            eps, icon_transparency); %#ok<NASGU>
    
    % add icon to the tab page
    eval(['set(handles.tabPage_',item_tabPage{ii}, ', ''CData'', h_tabPage_icon_active_resized_add)'])
    guidata(hObject, handles);
end
clear ii
clear pos_tabHead

%% Set the call backs
% Set the Callbacks for the tab pages
for ii = 1 : number_tabPage
    strEval = [ 'set(handles.tabPage_', item_tabPage{ii}, ',', ...
                '''CallBack'',{@tabPage_Callback,handles})'];
    eval(strEval)
    clear strEval
    strEval = [ 'set(handles.tabPage_', item_tabPage{ii}, ',', ...
                '''KeyPressFcn'',{@tabPage_Keypressfcn,handles})'];
    eval(strEval)
    clear strEval
end
clear ii

%% Set the default state of the tab pages
% Set the tab body to visible, when the corresponding tab page is pressed
% (initial state accordingto handles.string_select)
tab_alter(hObject,eventdata,handles);

%% Clear the variables
clear h_tabPage_icon_active
clear h_tabPage_icon_inactive
clear h_tabPage_icon_active_resized
clear h_tabPage_icon_inactive_resized
clear path_tabPage_icon_active
clear path_tabPage_icon_inactive
clear h_tabPage_icon_active_resized_add