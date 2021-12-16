%% MY_PARAMETER
% contains all the layout information of the GUI.

%% Folder of this project
folderName_project = 'LIB_GUI';
setappdata(0,'folderName_project',folderName_project)

%% AUTHOR MARK OF THE GUI
author_mark = 'YH';

%% TITLE OF THE FIGURE
title_gcf = 'Effective thermal conductivity of the electrode of LIB';


%% ITEMS OF THE TAB PAGES
item_tabPage = {'calculate','plot','fit'};
setappdata(0, 'item_tabPage', item_tabPage)
setappdata(0, 'string_select_tabPage', item_tabPage{1})

%% SIZE
% Size of gcf
position_Screen = get(0,'ScreenSize');
height_gcf = fix(position_Screen(4) * 0.875);
width_gcf = fix(position_Screen(3) * 0.4);

% For the background image
% Resize mode:  'center_middle',    'center_bottom',    'center_top'
mode_height_resize_im_background = 'center_bottom';
% Resize mode:  'center_middle',    'left_middle',    'right_middle'
mode_width_resize_im_background = 'center_middle';

    % Height ratio of the main panel to the figure
    heightRatio_mainPanel = 0.95;

        % Height ratio of the tab head to the main panel
        heightRatio_tabHead = 0.06;

            % Height and width ratio of the tab pages to the full ones
            heightRatio_tabPage = 0.65;
            widthRatio_tabPage = 0.55;
            
            % Length ratio and thick pixel of the vertical line between 
            % tab pages in the tab head to the full ones
            lengthRatio_verticalLine_tabHead = 0.65;
            thickPixel_verticalLine_tabHead = 1.5;
            
            % Ratio of the top side of the first point
            topRatio_firstPoint = 0.05;
            
            % Ratio of the left side of the first point and the second point
            leftRatio_firstPoint = 0.01;
            leftRatio_secondPoint = 0.05;
            
            % Distance ratio between first and second points
            distanceRatio_firstSecondPoint = 0.04;
            
            % Distance ratio between two second points
            distanceRatio_twoSecondPoint = 0.04;
            
            % Length and height ratio of the element in the first point
            lengthRatio_firstPoint = 0.3;
            heightRatio_firstPoint = 0.05;
            
            % Length of and space ratio between elements in the second point
            
        % Length ratio and thick pixel of the separate line of the main panel
        % to the full ones
        lengthRatio_separateLine_mainPanel = 0.97;
        thickPixel_separateLine_mainPanel = 3;

        % Length ratio and thick pixel of the top line of the main panel
        % to the full ones
        lengthRatio_topLine_mainPanel = lengthRatio_separateLine_mainPanel;
        thickPixel_topLine_mainPanel = thickPixel_separateLine_mainPanel;
        
        % Length ratio and thick pixel of the bottom line of the main panel
        % to the full ones
        lengthRatio_bottomLine_mainPanel = lengthRatio_separateLine_mainPanel;
        thickPixel_bottomLine_mainPanel = thickPixel_separateLine_mainPanel;
         
        
        
        
            
        % Height ratio of the info bar to the bottom panel
        heightRatio_infoBar = 0.5;
        
        % Height and width ratio of the info bar to the full ones
        heightRatio_colorBar = 0.8;
        widthRatio_colorBar = 0.97;
        

%% FONT SIZE & WEIGHT IN PIXELS

% Font size and weight of the tab pages
fontSize_tabPage = 20;
fontWeight_tabPage = 'bold';

% Font size and weight of the info bar
fontSize_infoBar = 12;
fontWeight_infoBar = 'normal';

% Font size of the first point
fontSize_firstPoint = 14;
fontWeight_firstPoint = 'bold';

% Font size and weight of the second point
fontSize_secondPoint = 11;
% tab body calculate
    % component
        fontWeight_secondPoint_component_calculate = {'normal', 'normal', 'normal', 'normal'};

% Font size and weight of the click in the cover panel
fontSize_clickCover = 25;
fontWeight_clickCover = 'bold';

%% COLOR
% Theme color
color_theme_list % load all the theme colors
lightRatio_color_theme = 0.5;
% NOTE: In America, 'Sunday': 1, 'Monday': 1, ... 'Saturday': 6
color_theme = color_theme_array(weekday(datestr(now)),:) ...
                * lightRatio_color_theme;

setappdata(0,'color_theme', color_theme)

% System gray
systemGray = [0.941 0.941 0.941];

% Whether background image is existent: 1: yes, 0: no
exist_im_background = 1;

% For the background image
% Color mode:   'theme_color',      'original_color'
mode_color_im_background = 'theme_color';

% Set the background image color ratio
ratioColor_im_background = 0.5;

% icon transparency: 0 to 1
icon_transparency = 1;  % NOT TO EDIT
setappdata(0,'icon_transparency',icon_transparency)

% background standard
eps = 0.1;
setappdata(0, 'eps', eps)

% color ratio for icon
colorRatio_icon = 0;

% Set the color ratio inactive : active for the icon
ratioColor_inactive = 0.5;


% Solor of the figure
color_gcf = [1 1 1];
    
    % Background color of the main panel
    backgroundColor_mainPanel = color_gcf;
        
        % Background color of the tab head
        backgroundColor_tabHead = backgroundColor_mainPanel;
        
        % Color of the top line of the tab head in the main panel
        backgroundColor_topLine_mainPanel = color_theme;
        
        % Color of the separate line between the tab head and tab body in
        % the main panel
        backgroundColor_separateLine_mainPanel = color_theme;
        
        
        % Color of the bottom line of the tab body in the main panel
        backgroundColor_bottomLine_mainPanel = color_theme;
        
            % Fore- and background color of the tab pages
            foregroundColor_tabPage = [1 1 1];
            setappdata(0, 'foregroundColor_tabPage', foregroundColor_tabPage)
            
            ratio_foregroundColor_tabPage_inactive = 0.97;
            setappdata(0, 'ratio_foregroundColor_tabPage_inactive', ...
                ratio_foregroundColor_tabPage_inactive)
            
            backgroundColor_tabPage = systemGray;
                
                % Font color of strings in tab bodies
                fontColorRatio_tabBody = 0.35;
            
            % Color of the vertical line between tab pages in the tab head
            backgroundColor_verticalLine_tabHead = color_theme;
            
        % Background color of the tab bodies
        backgroundColor_tabBody = backgroundColor_mainPanel;
        
    
    % Background color of the bottom panel    
    backgroundColor_bottomPanel = color_gcf;
        
        % Foreground color ratio and background color of the info bar
        fontColorRatio_infoBar = 1;
        backgroundColor_infoBar = backgroundColor_bottomPanel;
        
        % Background color strength of the color bar to the theme color
        colorStrengthRatio_colorBar = 0.6;
        
    % Background color of the cover panel    
    backgroundColor_coverPanel = color_gcf;
    
        % Foreground color of the click 
        fontColor_clickCover = [0, 0, 0]; % black

%% BORDER TYPE

% Border type of the main panel
boderType_mainPanel = 'none';

    % Border type of the tab head
    borderType_tabHead = 'none';
    
    % Border type of the tab bodies
    borderType_tabBody = 'none';

% Border type of the bottom panel
boderType_bottomPanel = 'none';

% Border type of the cover panel
boderType_coverPanel = 'none';



%% ------------------- NOT EDIBLE -------------------
% Set the author mark
setappdata(0,'author_mark', author_mark)

% Set the icon color
set_icon_themeColor

% Set the number of tab pages
number_tabPage = length(item_tabPage);
setappdata(0,'number_tabPage', number_tabPage)

% Set the color of the info bar 
fontColor_infoBar = color_theme * fontColorRatio_infoBar;


