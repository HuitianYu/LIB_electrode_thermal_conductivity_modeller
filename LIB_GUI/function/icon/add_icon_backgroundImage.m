%% ADD_ICON_BACKGROUNDIMAGE
% replaces the white background to the background image

function im_icon_resized_add = add_icon_backgroundImage( ...
    im_icon_resized, position_icon_pixel, suffix, ...
    eps, icon_transparency)
    
    % find the height of the adjusted resized background image
    im_background_resized_suffix = getappdata(0,['im_background_resized_', suffix]);
    height_im_background_resized_adjusted = size(im_background_resized_suffix,1);
        
    % cut the background image
    im_background_resized_adjusted_cut = im_background_resized_suffix( ...
        height_im_background_resized_adjusted - position_icon_pixel(2) - ...
            size(im_icon_resized,1) + 1 : ...
        height_im_background_resized_adjusted - position_icon_pixel(2), ...
        position_icon_pixel(1) : ...
        position_icon_pixel(1) + size(im_icon_resized,2) - 1, ...
        :);
    
    
    % add background image to the icon
    
    % background part
    im_icon_resized_tmp = im_icon_resized;
    im_icon_resized(1 - im_icon_resized > eps) = 0;
    im_icon_resized(1 - im_icon_resized < eps) = 1;
    im_icon_resized_bg = im_icon_resized;
    im_icon_resized = im_icon_resized_tmp;
    clear im_icon_resized_tmp

    % icon core part
    im_icon_resized(1 - im_icon_resized < eps) = 0;
    im_icon_resized_core = im_icon_resized;
    im_icon_resized_core(im_icon_resized_core < 0) = 0;
 
    
    % add
    im_icon_resized_add =   ...
        im_icon_resized_bg .* im_background_resized_adjusted_cut ...
        + im_icon_resized_core .* im_background_resized_adjusted_cut ...
            * icon_transparency;
    im_icon_resized_add(im_icon_resized_add > 1) = 1;
    im_icon_resized_add(im_icon_resized_add < 0) = 0;
end


