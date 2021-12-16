%%  INFOBAR_CALLBACK
% calls back the function for info bar to stop and resume the program.

function varargout = infoBar_Callback(hObject, eventdata, handles) %#ok<INUSL,STOUT>
if getappdata(0, 'stateProgram') ~= 0 % not stopped: program is running
    if getappdata(0, 'stateProgram') == 1 % running, to pause
        wholeString_infoBar = get(handles.infoBar, 'String');
        setappdata(0,'string_inforBar_tmp',...
            wholeString_infoBar(...
            length(getappdata(0,'author_mark')) + length(': ') + 1: end));
        my_waitbar([],'Press to resume', handles)
        setappdata(0, 'stateProgram', 2)
        clear wholeString_infoBar
        
        % change the task icon
        taskIcon_Inactivate
        % pause
        uiwait
    elseif getappdata(0, 'stateProgram') == 2 % paused, to run
        % resume
        uiresume
        my_waitbar([],getappdata(0,'string_inforBar_tmp'), handles)
        rmappdata(0,'string_inforBar_tmp');
        setappdata(0, 'stateProgram', 1)
        % change the task icon
        taskIcon_Activate
    else
       error('Error info bar.') 
    end
end

end