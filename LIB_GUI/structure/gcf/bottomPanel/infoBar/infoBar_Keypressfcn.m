%% INFOBAR_KEYPRESSFCN
% calls back the function, when the key ENTER is pressed.

function vargout = infoBar_KeyPressFcn(hObject,eventdata,handles) %#ok<STOUT>
key = get(gcf,'CurrentKey');
if strcmp(key, 'return')
    infoBar_Callback(hObject,eventdata,handles)
end
end