%% VALUE_ITEMCHOICE_ALTERNATIVE_CALLBACK
% calls back a function for value of the item choice for the alternative
% name list.

function varargout = value_itemChoice_alternative_Callback(hObject, eventdata, handles) %#ok<STOUT,INUSL>

% get the tag_core
currentTag = get(hObject, 'Tag');
tag_core = currentTag(length('value_itemChoice_') + 1 : end);

% get the handle for the name list
eval(['handle_nameList = handles.nameList_itemChoice_', tag_core, ';'])


% string of the edit frame
string_value = get(hObject, 'String');

% set the value handle and name list after typing in the value edit frame
if isempty(string_value)
% empty or non-negative number
    % set 'Enable' of the value to 'on'
    set(hObject, 'Enable', 'on')
    
    % set 'Value' of the name list to 1
    set(handle_nameList, 'Value', 1)
else
% others
    % find value the typed string exists in the name list, if
    % existent
    
    string_nameList = get(handle_nameList, 'String');
    value_nameList = ...
        find(strcmp(string_nameList,string_value), 1);
    
    if ~isempty(value_nameList) && ...
            ~strcmp(string_value,string_nameList(1))
    % existent
        % set 'Value' of the name list to the corresponding one
        set(handle_nameList, 'Value', value_nameList)

        % set 'Enable' of the value to 'off'
        set(hObject, 'Enable', 'off')
  
    else
    % not existent
        % set 'Enable' of the edit to 'on'
        set(hObject, 'Enable', 'on')
        % set 'Value' of the pop-up menu to 1
        set(handle_nameList, 'Value', 1)
        % set 'String' of the edit to []
        set(hObject, 'String', [])
        
        % show the error information in the info bar
        errorInfo('Please enter a valid component name.', handles)
    end
    
    clear string_nameList
    clear wholeString_infoBar
end

end