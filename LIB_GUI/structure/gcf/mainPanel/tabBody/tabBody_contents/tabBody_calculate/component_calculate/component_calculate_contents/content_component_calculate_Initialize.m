%%  ALL_ITEMCHOICE_COMPONENT_CALCULATE_INITIALIZE
% creates and initialize all the item choices for the active material,
% conductive additive, binder and medium,
% saves all the handles to handles.

%% Layout for the item choices
% position of this tab body
pos_tabBody_calculate = get(handles.tabBody_calculate, 'Position');

% left, top position and vertical space of all items,
left_component_calculate = leftRatio_secondPoint; 
bottom_component_calculate_top = 1 - ...
        topRatio_firstPoint - distanceRatio_firstSecondPoint; 
verticalSpace_component_calculate = distanceRatio_twoSecondPoint;
height_component_calculate = verticalSpace_component_calculate * 0.9;

% font color of the text
fontColor_text = color_theme * fontColorRatio_tabBody;
fontSize_text = fontSize_secondPoint;

% full string and abbreviation of all items
array_string_head = {'Active Material', ...
                    'Conductive Additive', ...
                    'Binder', ...
                    'Medium'};
array_abbreviation_name = {'AM','CA','B','M'};
array_string_type = {'Mass fraction','Mass fraction','Mass fraction','Porosity'};
array_keyCriteria = { {'anode active material', 'cathode active material'},...
                        {'conductive additive'}, ...
                        {'binder'}, ...
                        {'electrolyte', 'filling gas'}};
% string for the unit
string_unit = '$\rm \frac{W}{m\cdot K}$';
% string for the percent
array_string_percent = {'$\rm wt.\%$','$\rm wt.\%$','$\rm wt.\%$','$\rm vol.\%$'};
% maximal length of the name list 
maxNumber_nameList = 20;

%% Create and initialize the item choices

%   Create item choice for the components
for ii = 1 : length(array_string_head)
    
    % calculate the positions in pixels
    
    % create and initialize the item choice
    handles = itemChoice_Initialize( ...
        handles.tabBody_calculate, ... % handle of the parent container
        ['component_calculate_', array_abbreviation_name{ii}], ... % tag core for all handles and tags
        left_component_calculate, ... % left position of all items
        bottom_component_calculate_top - (ii - 1) * verticalSpace_component_calculate, ... % bottom position of this item
        height_component_calculate, ... % height of all items
        array_string_head{ii}, string_unit, array_string_type{ii}, array_string_percent{ii},  ... % string for the head AND the unit AND the type AND the percent
        fontColor_text, fontSize_text, ... % font color AND size for the text
        'statistics', 'remark', array_keyCriteria{ii}, maxNumber_nameList, 'thermalConductivity', ... % table AND criteria column AND criteria AND output
        [], ... % alternative for name list
        'adjusted', ... % image matrix for the background
        hObject, handles); % handles for storage
    guidata(hObject, handles);
end
clear ii


% create and initialize the item choice for poly AM
handles = itemChoice_Initialize( ...
    handles.tabBody_calculate, ... % handle of the parent container
    'component_calculate_polyAM', ... % tag core for all handles and tags
    left_component_calculate, ... % left position of this item
    bottom_component_calculate_top, ... % bottom position of this item
    height_component_calculate, ... % height of all items
    array_string_head{1}, string_unit, array_abbreviation_name{1}, array_string_percent{1}, ... % string for the head AND the unit
    fontColor_text, fontSize_text, ... % font color AND size for the text
    [], [], [], [], [], ... % table AND criteria column AND criteria AND output
    {'polyAM'}, ... % alternative for name list
    'adjusted', ... % image matrix for the background
    hObject,handles); % handles for storage
guidata(hObject, handles);

% set this item choice panel to 'invisible'
set(handles.itemChoicePanel_component_calculate_polyAM, 'Visible', 'off')




%% Delete all unuseful variables

clear left_component_calculate
clear bottom_component_calculate_top
clear verticalSpace_component_calculate
clear string_component
clear string_unit
clear fontColor_text
clear fontSize_text
clear abbreviation_component
clear array_keyCriteria