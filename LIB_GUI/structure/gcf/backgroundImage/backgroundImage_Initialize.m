%% BACKGROUNDIMAGE_INITIALIZE
% creates and initializes the background image for the gcf,
% saves the handles to handles.
if exist_im_background == 1
    % number of background images
    strDir = dir(fullfile(getappdata(0, 'pathParent'),getappdata(0,'folderName_project'),'input',...
                    'image', 'background'));
    arrayFileName = {strDir.name};
    number_backgroundImage = size(arrayFileName,2) - 2;
    clear strDir
    clear arrayFileName
    
    % load the path of the background image
    path_backgroundImage = fullfile(getappdata(0, 'pathParent'),getappdata(0,'folderName_project'),'input',...
        'image', 'background', ...
        ['background_',num2str(randi(number_backgroundImage)),'.jpg']);

    % read the background image
    im_background = imread(path_backgroundImage);

    % find the height and width of the background image in pixels
    height_im_background = size(im_background,1);
    width_im_background = size(im_background,2);

    % resize the background image
    if (height_im_background / width_im_background) >= (height_gcf / width_gcf)
        im_background_tmp = imresize(im_background, ...
                [ceil(height_im_background / width_im_background * width_gcf),...
                width_gcf]);
        height_im_background_tmp = size(im_background_tmp,1);

        switch mode_height_resize_im_background
            case 'center_middle'
                height_start = fix(height_im_background_tmp/2) - fix(height_gcf/2); 
            case 'center_bottom'
                height_start = height_im_background_tmp - height_gcf + 1;
            case 'center_top'
                height_top = 1;
        end

        im_background_resized_original = im_background_tmp( ...
            height_start : height_start + height_gcf - 1,...
            :,:);
        clear im_background_tmp
        clear height_im_background_tmp
        clear height_start
    else
        im_background_tmp = imresize(im_background, ...
                [height_gcf,...
                 ceil(width_im_background / height_im_background * height_gcf)]);
        width_im_background_tmp = size(im_background_tmp,2);

        switch mode_width_resize_im_background
            case 'center_middle'
                width_start = fix(width_im_background_tmp/2) - fix(width_gcf/2); 
            case 'left_middle'
                width_start = 1;
            case 'right_middle'
                width_start = width_im_background_tmp - width_gcf + 1;
        end

        im_background_resized_original = im_background_tmp( ...
            :, ...
            width_start : width_start + width_gcf - 1,...
            :);
        clear im_background_tmp
        clear width_im_background_tmp
        clear width_start


    end

    switch mode_color_im_background
        case 'theme_color'
            % set a rgb for the gray image
            rgb_color_theme = ones(size(im_background_resized_original,1),...
                size(im_background_resized_original,2),3);
            rgb_color_theme(:,:,1) = color_theme(1);
            rgb_color_theme(:,:,2) = color_theme(2);
            rgb_color_theme(:,:,3) = color_theme(3);

            % adjust the color to the theme color    
            gray_im_background_resized = rgb2gray(im_background_resized_original);
            gray_im_background_resized = im2double(gray_im_background_resized);
            im_background_resized_adjusted = (1 - gray_im_background_resized) .* ...
                (rgb_color_theme * ratioColor_im_background + ...
                    (1 - ratioColor_im_background)) + ...
                gray_im_background_resized;
        case 'original_color'
            im_background_resized_adjusted = ...
                im2double(im_background_resized_original) * ratioColor_im_background + ...
                (1 - ratioColor_im_background) * 1;
    end
elseif exist_im_background == 0
    im_background_resized_original = ones(height_gcf, width_gcf, 3);
    im_background_resized_adjusted = ones(height_gcf, width_gcf, 3);
    
    im_background_resized_original(:, :, 1) = handles.color_theme(1);
    im_background_resized_original(:, :, 2) = handles.color_theme(2);
    im_background_resized_original(:, :, 3) = handles.color_theme(3);

    im_background_resized_adjusted(:, :, 1) = handles.color_theme(1) ...
        * ratioColor_im_background + 1 * (1 - ratioColor_im_background);
    im_background_resized_adjusted(:, :, 2) = handles.color_theme(2) ...
        * ratioColor_im_background + 1 * (1 - ratioColor_im_background);
    im_background_resized_adjusted(:, :, 3) = handles.color_theme(3) ...
        * ratioColor_im_background + 1 * (1 - ratioColor_im_background);
else
    error('Error in exist_im_background')
end

% create and initialize an axes to hold the background image
position_axes = ...
        [1, 1, width_gcf, height_gcf];

h_axes_backgroundImage = axes( ...
                'Parent',gcf, ...
                'Units', 'pixels', ...
                'Position',position_axes ...
                );
axis off
% show the background image
imshow(im_background_resized_adjusted)      

            
% save the handles to handles
handles.axes_backgroundImage = h_axes_backgroundImage;
clear h_axes_backgroundImage
guidata(hObject, handles);
setappdata(0, 'im_background_resized_original',im_background_resized_original)
setappdata(0, 'im_background_resized_adjusted',im_background_resized_adjusted)


% clear 
clear number_backgroundImage
clear height_im_background
clear width_im_background
clear im_background
clear im_background_original
clear im_background_resized_adjusted
clear gray_im_background_resized
clear rgb_color_theme
clear position_axes