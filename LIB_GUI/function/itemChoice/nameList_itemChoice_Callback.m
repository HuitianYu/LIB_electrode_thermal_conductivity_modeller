%% NAMELIST_ITEMCHOICE_CALLBACK
% calls back a function for the name list of the item choice.

function varargout = nameList_itemChoice_Callback(hObject, eventdata, handles) %#ok<INUSD,STOUT>

% get the tag_core
currentTag = get(hObject, 'Tag');
tag_core = currentTag(length('nameList_itemChoice_') + 1 : end);

% set the value of value
value_nameList = get(hObject, 'Value');
% get the string array of the name list
array_string_nameList = get(hObject, 'String');

% get the maximal length of the name list
eval(['maxNumber_nameList = getappdata(0, ''maxNumber_nameList_', ...
    tag_core,''');'])

% get the maximal length of the name list
eval(['stringEnd_nameList = getappdata(0, ''stringEnd_nameList_', ...
    tag_core,''');'])

% get the handle for value
eval(['handle_value = handles.value_itemChoice_', tag_core, ';'])

% get the table and output
eval(['selectedTable = getappdata(0, ''selectedTable_', ...
    tag_core, ''');'])
eval(['outputTable = getappdata(0, ''outputTable_', ...
    tag_core, ''');'])

if value_nameList == 1
 % set the handle value on and clear its string, if default item is chosen
    set(handle_value, 'Enable', 'on')
    set(handle_value, 'String', [])
    % set the visibility of the text of the unit to off
    eval(['set(handles.text_unit_itemChoice_', tag_core, ', ''Visible'', ''off'')'])
elseif length(array_string_nameList) >= maxNumber_nameList + 2 && ...
            value_nameList == length(array_string_nameList)
    % set the handle value on and clear its string, if default item is chosen
    set(handle_value, 'Enable', 'on')
    set(handle_value, 'String', [])
    % set the visibility of the text of the unit to off
    eval(['set(handles.text_unit_itemChoice_', tag_core, ', ''Visible'', ''off'')'])
else % generate the proper output at the value and set it off
    string_currentMaterial = array_string_nameList{value_nameList};
    eval(['load tables ', selectedTable])
    eval(['currentMaterial = ', selectedTable, '(''', ...
            string_currentMaterial, ''',:);'])
    eval(['set(handle_value, ''String'', num2str(currentMaterial.', ...
        outputTable,'))'])
    set(handle_value, 'Enable', 'off')
    % set the visibility of the text of the unit to on
    eval(['set(handles.text_unit_itemChoice_', tag_core, ', ''Visible'', ''on'')'])
end


end