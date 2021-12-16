%% SET_ICON_THEMECOLOR
% set the active and inactive icon, task icon to the variants of the theme color.

iconName_array = {'tabPage', 'task'};

for ii = 1 : length(iconName_array)
    % change directory to 'input'
    path_icon_original = fullfile(getappdata(0, 'pathParent'),getappdata(0,'folderName_project'),...
        'input','image','icon',[iconName_array{ii},'_icon.jpg']);

    % executes only when one of two icons does not exist
    % find the gray image
    [rgb_original, ~] = imread(path_icon_original);
    gray_original = im2double(rgb2gray(rgb_original));
    
    % background part
    gray_original_tmp = gray_original;
    gray_original(1 - gray_original > eps) = 0;
    gray_original(1 - gray_original < eps) = 1;
    gray_original_bg = gray_original;
    gray_original = gray_original_tmp;
    clear gray_original_tmp

    % create a variable for alpha from background
    alpha = ones(size(rgb_original,1), size(rgb_original,2));
    alpha(gray_original_bg == 1) = 0;

    % icon core part
    gray_original(1 - gray_original < eps) = 0;
    gray_original_core = gray_original;
    clear rgb_original
    gray_original_core_adjusted = gray_original_core * colorRatio_icon + ...
                            1 * (1 - colorRatio_icon);                   
                        
                        

    % set a rgb for the gray image
    color_theme = getappdata(0,'color_theme');
    rgb_color_theme = ones(size(gray_original,1),size(gray_original,2),3);
    rgb_color_theme(:,:,1) = color_theme(1);
    rgb_color_theme(:,:,2) = color_theme(2);
    rgb_color_theme(:,:,3) = color_theme(3);

    % set the dark part of the gray image to the variants of the theme color
    rgb_active =    gray_original_core_adjusted .* rgb_color_theme + gray_original_bg;
    rgb_inactive =  gray_original_core_adjusted .* ...
                        (rgb_color_theme * ratioColor_inactive + ...
                        1 * (1 - ratioColor_inactive)) + ...
                    gray_original_bg;


    rgb_active(1 - rgb_active < eps) = 1;
    rgb_active(rgb_active < 0) = 0;

    rgb_inactive(1 - rgb_inactive < eps) = 1;
    rgb_inactive(rgb_inactive < 0) = 0;
   
    

    % save the handles to handles
    setappdata(0, [iconName_array{ii},'_icon_active'], rgb_active)
    setappdata(0, [iconName_array{ii},'_icon_inactive'], rgb_inactive)
    guidata(hObject, handles);
    
    imwrite(rgb_active, ...
        fullfile(getappdata(0, 'pathParent'),getappdata(0,'folderName_project'),...
        'input','image','icon','processed',...
        [iconName_array{ii},'_icon_active.png']), 'Alpha', alpha)
    imwrite(rgb_inactive, ...
        fullfile(getappdata(0, 'pathParent'),getappdata(0,'folderName_project'),...
        'input','image','icon','processed',...
        [iconName_array{ii},'_icon_inactive.png']), 'Alpha', alpha)
end
clear ii
    



% clear
clear gray_original
clear gray_original_bg
clear gray_original_core
clear gray_original_core_adjusted
clear rgb_color_theme
clear rgb_active
clear rgb_inactive
clear path_tabPage_icon_original