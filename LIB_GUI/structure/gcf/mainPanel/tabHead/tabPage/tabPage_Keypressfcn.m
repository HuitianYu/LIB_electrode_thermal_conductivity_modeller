%% TABPAGE_KEYPRESSFCN
% calls the function, when the tab page is pressed by ENTER.
function vargout = tabPage_KeyPressFcn(hObject,eventdata,handles) %#ok<STOUT>
key = get(gcf,'CurrentKey');
if strcmp(key, 'return')
    tabPage_Callback(hObject,eventdata,handles)
end
end
