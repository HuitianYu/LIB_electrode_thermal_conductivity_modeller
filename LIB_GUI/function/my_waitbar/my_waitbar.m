%% MY_WAITBAR
% creates a docked wait bar in the bottom panel.

function my_waitbar(lengthRatio_colorBar, str_infoBar, handles)
if ~isempty(lengthRatio_colorBar)
    % change the length of the color bar
    h_pos_cb_orig = getappdata(0,'position_colorBar_original');
    set(handles.colorBar,'Position', [  h_pos_cb_orig(1), ...
                            h_pos_cb_orig(2), ...
                            lengthRatio_colorBar * h_pos_cb_orig(3), ...
                            h_pos_cb_orig(4)])
end
if ~isempty(str_infoBar)
    % change the content of the info bar
    set(handles.infoBar, 'String', [getappdata(0,'author_mark'), ': ', str_infoBar])
end
end