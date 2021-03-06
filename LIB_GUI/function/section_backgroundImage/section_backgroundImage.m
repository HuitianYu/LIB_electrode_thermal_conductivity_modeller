%% SECTION_BACKGROUNDIMAGE
% extracts a section of the background image for panels.

function handles = section_backgroundImage(h_panel, tag_core, suffix_backgroundImage, handles)

% find the position of hObject in pixels and the height of the image
position_hObject_absolute = getpixelposition(h_panel,true);
im_background_resized_suffix = getappdata(0, ['im_background_resized_',suffix_backgroundImage]);
height_im_background_resized_suffix = size(im_background_resized_suffix,1);


% resize the image
im_background_resized_suffix_cut = ...
    im_background_resized_suffix(...
        height_im_background_resized_suffix - position_hObject_absolute(2) - ...
            position_hObject_absolute(4) + 2 : ...
        height_im_background_resized_suffix - position_hObject_absolute(2) + 1, ...
        position_hObject_absolute(1) : position_hObject_absolute(1) + position_hObject_absolute(3) - 1, ...
        :);
    

% create and initialize an axes for h_panel
h_axes = axes( ...
        'Parent', h_panel, ...
        'Units', 'pixels', ...
        'Position', ...
        [1, 1, position_hObject_absolute(3), position_hObject_absolute(4)]...
        ); %#ok<NASGU>
axis off
% show the image
imshow(im_background_resized_suffix_cut)

% save the axes to handles
eval(['handles.axes_', tag_core, ' = h_axes;'])

end