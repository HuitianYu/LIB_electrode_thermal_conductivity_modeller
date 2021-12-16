%% COVERPANEL_CALLBACK
% calls back the function to let the cover panel fades

function varargout = coverPanel_Callback(hObject, eventdata, handles) %#ok<INUSL,STOUT>
    set(handles.coverPanel, 'Visible', 'off')
end