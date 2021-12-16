%% ERRORINFO
%   displays the error info and then disappears.

function errorInfo(string_error, handles)
        % store the original information and font color
        wholeString_infoBar = get(handles.infoBar, 'String');
        setappdata(0,'string_inforBar_tmp',...
            wholeString_infoBar(...
            length(getappdata(0,'author_mark')) + length(': ') + 1: end));
        setappdata(0, 'fontColor_infoBar_tmp', ...
            get(handles.infoBar, 'ForegroundColor'))
        set(handles.infoBar, 'ForegroundColor', [1, 0, 0])
        setappdata(0, 'fontWeight_infoBar_tmp', ...
            get(handles.infoBar, 'FontWeight'))
        set(handles.infoBar, 'FontWeight', 'bold')
        % show the error information in the info bar
        my_waitbar([], string_error, ...
            handles);

        % inactivates all uicontrols
        enable_inactive

        pause(1.5)
        
        % recover the information in the info bar
        set(handles.infoBar, 'ForegroundColor', getappdata(0, 'fontColor_infoBar_tmp'))
        rmappdata(0,'fontColor_infoBar_tmp');
        set(handles.infoBar, 'FontWeight', getappdata(0, 'fontWeight_infoBar_tmp'))
        rmappdata(0,'fontWeight_infoBar_tmp');
        my_waitbar([], getappdata(0,'string_inforBar_tmp'), handles);
        rmappdata(0,'string_inforBar_tmp');
        % recover the 'Enable' property of all uicontrols
        enable_recover


end