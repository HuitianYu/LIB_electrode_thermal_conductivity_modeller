%% TABPAGE_CALLBACK
% calls the function, when the tab page is left clicked.
function vargout = tabPage_Callback(hObject,eventdata,handles) %#ok<STOUT>
tag_hObject = get(hObject,'Tag');
setappdata(0,'string_select_tabPage', tag_hObject(length('tabPage_')+1:end))
guidata(hObject, handles);
tab_alter(hObject, eventdata, handles);
end
