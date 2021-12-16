%% NAMELIST_ITEMCHOICE_ALTERNATIVE_CALLBACK
% calls back a function for the name list alternative of the item choice.

function varargout = nameList_itemChoice_alternative_Callback(hObject, eventdata, handles) %#ok<INUSD,STOUT>

% get the tag_core
currentTag = get(hObject, 'Tag');
tag_core = currentTag(length('nameList_itemChoice_') + 1 : end);

% get the handle for value
eval(['handle_value = handles.value_itemChoice_', tag_core, ';'])

% set the value of value
value_nameList = get(hObject, 'Value');
string_nameList = get(hObject, 'String');

if value_nameList == 1 % set the handle value on and clear its string, if default item is chosen
    set(handle_value, 'Enable', 'on')
    set(handle_value, 'String', [])
else % generate the proper output at the value and set it off
    set(handle_value, 'String', string_nameList{value_nameList})
    set(handle_value, 'Enable', 'off')
end





end