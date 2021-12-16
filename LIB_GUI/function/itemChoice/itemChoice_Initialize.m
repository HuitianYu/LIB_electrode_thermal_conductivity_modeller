%% ITEMCHOICE_INITIALIZE
% creates and initializes a group of uicontrols of 'Type' of 
% output: handles
% ATTENTION: handles must be added to handles outside the function using the outputs.

function handles = itemChoice_Initialize( ...
    handle_parent, tag_core, ... % handle of the parent container AND tag core for all handles and tags
    leftRatio, bottomRatio, ...% left AND botton position of this item
    heightRatio, ... % height of this item
    string_head, string_unit, string_type, string_percent, ... % string for the head AND the unit AND the type AND the percent
    fontColor_item, fontSize_item, ... % font color AND size for the text
    selectedTable, criteriaTable, keyCriteria, maxNumber_nameList, outputTable, ... % table AND criteria column AND criteria AND maximal lenght of the name list AND output
    array_nameList_alternative, ... % alternative for name list, either this line is [] or the last line is []
    adjusted, ... % image matrix for the background
    hObject,handles) % handles for storage

    % --------------------- SET APPLICATION DATA BEGIN ---------------------
    % save the selected table and output in the edit frame
    eval(['setappdata(0, ''selectedTable_', ...
        tag_core,''', selectedTable)'])
    
    eval(['setappdata(0, ''criteriaTable_', ...
        tag_core,''', criteriaTable)'])

    eval(['setappdata(0, ''keyCriteria_', ...
        tag_core,''', keyCriteria)'])
    
    eval(['setappdata(0, ''maxNumber_nameList_', ...
        tag_core,''', maxNumber_nameList)'])
    
    stringEnd_nameList = '...';
    eval(['setappdata(0, ''stringEnd_nameList_', ...
        tag_core,''', ''',stringEnd_nameList,''')'])
    
    eval(['setappdata(0, ''outputTable_', ...
        tag_core,''', outputTable)'])  
    
    % --------------------- SET APPLICATION DATA   END ---------------------
    

    % --------------------- LOAD MATERIAL LIST BEGIN ---------------------
    if (~isempty(selectedTable) && ~isempty(criteriaTable) && ...
            ~isempty(keyCriteria) && ~isempty(maxNumber_nameList) && ~isempty(outputTable)...
        ) && ...
        isempty(array_nameList_alternative)
    
        % load the strings for the name list
        eval(['load tables ', selectedTable])
        eval(['array_nameList = ', selectedTable, '.Properties.RowNames;'])
        array_nameList_selected = cell.empty(0,1);
        for ii = 1 : length(keyCriteria)
            eval(['array_nameList_tmp = ', ...
                'array_nameList(strcmp(', ...
                selectedTable,'.',criteriaTable, ', ''',keyCriteria{ii},''' ));'])
            array_nameList_selected(...
                end + 1 : end + size(array_nameList_tmp)) = ...
                array_nameList_tmp;
        end
        clear ii
        % save the length of the name list under certain criteria
        eval(['setappdata(0, ''totalNumber_nameList_', ...
            tag_core,''', length(array_nameList_selected))'])
        
        if  maxNumber_nameList >= length(array_nameList_selected)
            array_nameList_selected = [...
                'Choose or enter'; array_nameList_selected];
        else
            array_nameList_selected = [...
                'Choose or enter'; array_nameList_selected(1:maxNumber_nameList); stringEnd_nameList];
        end
        clear array_nameList
        clear array_nameList_tmp
    elseif (isempty(selectedTable) && isempty(criteriaTable) && ...
                isempty(keyCriteria) && isempty(maxNumber_nameList) && isempty(outputTable)...
            ) && ...
            ~isempty(array_nameList_alternative)
        array_nameList_selected = ['Choose'; array_nameList_alternative];
        
    end
    % --------------------- LOAD MATERIAL LIST   END ---------------------
    
    % --------------------- POSITION BEGIN ---------------------   
    space = 0.01;
    smallSpace = 0.007;
    bigSpace = 0.017;
    array_length = [0.17, 0.20, 0.16, 0.04, 0.12, 0.10, 0.02];
    positionParent = get(handle_parent, 'Position');
    spacePanel_pixel = 0;
    
    % panel item choice  
    position_panel_itemChoice = ...
        [1, fix(bottomRatio * positionParent(4)),...
        positionParent(3), ...
        fix(heightRatio * positionParent(4))];

    
    % head
    positionLine_head = ...        
        [   fix(leftRatio * position_panel_itemChoice(3)), 1, ...
            fix(array_length(1) * position_panel_itemChoice(3)) ];
    % name list
    xRelPosition_nameList = ...
        [   fix(space * position_panel_itemChoice(3)), ...  
            fix(array_length(2) * position_panel_itemChoice(3)) ...
        ];
    % value
    xRelPosition_value = ...
        [   fix(space * position_panel_itemChoice(3)), ...
            fix(array_length(3) * position_panel_itemChoice(3)) ...
        ];
    % unit
    xRelPosition_unit = ...
        [   fix(smallSpace * position_panel_itemChoice(3)),...
            fix(array_length(4) * position_panel_itemChoice(3)) ...
        ]; ... 
        
    % type
    xRelPosition_type = ...
        [   fix(bigSpace * position_panel_itemChoice(3)),...
            fix(array_length(5) * position_panel_itemChoice(3)) ...
        ]; ...
    
    % fraction
    xRelPosition_fraction = ...
        [   fix(space * position_panel_itemChoice(3)),...
            fix(array_length(6) * position_panel_itemChoice(3)) ...
        ]; ...
    % percent
    xRelPosition_percent = ...
        [   fix(smallSpace * position_panel_itemChoice(3)),...
            fix(array_length(7) * position_panel_itemChoice(3)) ...
        ]; ...
    
    % --------------------- POSITION   END ---------------------  
    
    
    % --------------------- FONTWEIGHT BEGIN ---------------------  
    array_fontWeight = {'bold', 'normal', 'normal', 'normal', 'normal', 'normal', 'normal'};
    % --------------------- FONTWEIGHT   END ---------------------  

    
    % --------------------- CREATION AND INITIALIZATION BEGIN ---------------------

    % -------- 0. ITEM CHOICE PANEL BEGIN ---------

    h_itemChoicePanel = uipanel( ...
            'Parent', handle_parent, ...
            'Tag', ['panel_itemChoice_', tag_core], ...
            'Units', 'pixels', ...
            'Position', position_panel_itemChoice, ...
            'borderType','none', ...
            'backgroundColor', get(handle_parent, 'BackgroundColor') ...
            );

    % Set the background for the main panel
    handles = section_backgroundImage(h_itemChoicePanel, ['itemChoicePanel_', tag_core], 'adjusted', handles);
    guidata(hObject,handles);
    
    eval(['handles.itemChoicePanel_', tag_core, ' = h_itemChoicePanel;'])

    % -------- 0. ITEM CHOICE PANEL BEGIN ---------


    % --------- 1. HEAD BEGIN ---------
    % create and initialize the head
    h_head = label_Initialize(h_itemChoicePanel, ...
        string_head, ...
        fontColor_item, ...
        [...
            positionLine_head(1), ...
            spacePanel_pixel + 1, ...
            positionLine_head(3), ...
            position_panel_itemChoice(4) - 2 * spacePanel_pixel...
        ], ...
        fontSize_item, array_fontWeight{1}, ...
        adjusted); %#ok<NASGU>


    % set the tags and save the handles to handles
    eval(['set(h_head(1), ''Tag'', ''axes_head_itemChoice_', ...
            tag_core, ''')'])
    eval(['handles.axes_head_itemChoice_', tag_core, ' = h_head(1);'])

    eval(['set(h_head(2), ''Tag'', ''text_head_itemChoice_', ...
            tag_core, ''')'])
    eval(['handles.text_head_itemChoice_', tag_core, ' = h_head(2);'])
    % --------- 1. HEAD   END ---------

    % --------- 2. NAME LIST BEGIN ---------
    % create and initialize the pop-up menu, to get the height
    h_nameList = uicontrol( ...
                    'Parent', h_itemChoicePanel, ...
                    'Style', 'popupmenu', ...
                    'Units', 'pixels', ...
                    'FontUnits', 'pixels', ...
                    'FontSize', fontSize_item, ...
                    'String', array_nameList_selected, ...  
                    'ForegroundColor', fontColor_item, ...
                    'FontWeight', array_fontWeight{2}, ...
                    'BackgroundColor', 0.5 * (get(h_itemChoicePanel,'BackgroundColor') + [1 1 1]) ...
                    );

    % set the position of the name list
    set(h_nameList, ...
            'Position', ...
            [   positionLine_head(1) + positionLine_head(3) + ...
                    xRelPosition_nameList(1), ...
                spacePanel_pixel + 1, ...
                xRelPosition_nameList(2), ...
                position_panel_itemChoice(4) - 2 * spacePanel_pixel...
            ])

    % set the tag and save the handle to handles
    eval(['set(h_nameList, ''Tag'', ''nameList_itemChoice_', ...
            tag_core, ''')'])
    eval(['handles.nameList_itemChoice_', tag_core, ' = h_nameList;'])
    % --------- 2. NAME LIST   END ---------    

    
    % --------- 3. VALUE BEGIN ---------
    % create and initialize the value and set the position
    h_value = uicontrol( ...
                'Parent', h_itemChoicePanel, ...
                'Style', 'edit', ...
                'Units', 'pixels', ...
                'FontUnits', 'pixels', ...
                'FontSize', fontSize_item, ...
                'ForegroundColor', fontColor_item, ...
                'FontWeight', array_fontWeight{3}, ...
                'HorizontalAlignment', 'right', ...
                'BackgroundColor', ...
                0.5 * (get(h_itemChoicePanel,'BackgroundColor') + [1 1 1]) ...
                );


    % set the positions of the value
    set(h_value, ...
            'Position', ...
            [   positionLine_head(1) + positionLine_head(3) + ...
                    xRelPosition_nameList(1) + xRelPosition_nameList(2) + ...
                    xRelPosition_value(1), ...
                spacePanel_pixel + 1, ...
                xRelPosition_value(2), ...
                position_panel_itemChoice(4) - 2 * spacePanel_pixel ...
            ])
    % set the tag and save the handle to handles
    eval(['set(h_value, ''Tag'', ''value_itemChoice_', ...
            tag_core, ''')'])
    eval(['handles.value_itemChoice_', tag_core, ' = h_value;'])
    % --------- 3. VALUE   END ---------

    % --------- 4. UNIT BEGIN ---------
    % create and initialize the unit
    h_unit = label_Initialize(h_itemChoicePanel, ...
        string_unit, ...
        fontColor_item, ...
        [   positionLine_head(1) + positionLine_head(3) + ...
                xRelPosition_nameList(1) + xRelPosition_nameList(2) + ...
                xRelPosition_value(1) + xRelPosition_value(2) + ...
                xRelPosition_unit(1), ...
            spacePanel_pixel + 1, ...
            xRelPosition_unit(2), ...
            position_panel_itemChoice(4) - 2 * spacePanel_pixel...
        ], ...
        fontSize_item, array_fontWeight{4}, ...
        adjusted);

    % set the interpreter of the text box of unit to latex 
    set(h_unit(2),'Interpreter','latex')
    
    % set the visibility of the text to off
    set(h_unit(2), 'Visible', 'off')

    % set the tags and save the handles to handles
    eval(['set(h_unit(1), ''Tag'', ''axes_unit_itemChoice_', ...
            tag_core, ''')'])
    eval(['handles.axes_unit_itemChoice_', tag_core, ' = h_unit(1);'])

    eval(['set(h_unit(2), ''Tag'', ''text_unit_itemChoice_', ...
            tag_core, ''')'])
    eval(['handles.text_unit_itemChoice_', tag_core, ' = h_unit(2);'])

    % --------- 4. UNIT   END ---------
   

    % --------- 5. TYPE BEGIN ---------
    % create and initialize the type
    h_type = label_Initialize(h_itemChoicePanel, ...
        string_type, ...
        fontColor_item, ...
        [   positionLine_head(1) + positionLine_head(3) + ...
                xRelPosition_nameList(1) + xRelPosition_nameList(2) + ...
                xRelPosition_value(1) + xRelPosition_value(2) + ...
                xRelPosition_unit(1) + xRelPosition_unit(2) + ...
                xRelPosition_type(1), ...
            spacePanel_pixel + 1, ...
            xRelPosition_type(2), ...
            position_panel_itemChoice(4) - 2 * spacePanel_pixel...
        ], ...
        fontSize_item, array_fontWeight{5}, ...
        adjusted); %#ok<NASGU>


    % set the tags and save the handles to handles
    eval(['set(h_type(1), ''Tag'', ''axes_type_itemChoice_', ...
            tag_core, ''')'])
    eval(['handles.axes_type_itemChoice_', tag_core, ' = h_type(1);'])

    eval(['set(h_type(2), ''Tag'', ''text_type_itemChoice_', ...
            tag_core, ''')'])
    eval(['handles.text_type_itemChoice_', tag_core, ' = h_type(2);'])
    % --------- 5. TYPE   END ---------
    
    % --------- 6. FRACTION BEGIN ---------
    % create and initialize the fraction and set the position
    h_fraction = uicontrol( ...
                'Parent', h_itemChoicePanel, ...
                'Style', 'edit', ...
                'Units', 'pixels', ...
                'FontUnits', 'pixels', ...
                'FontSize', fontSize_item, ...
                'ForegroundColor', fontColor_item, ...
                'FontWeight', array_fontWeight{5}, ...
                'HorizontalAlignment', 'right', ...
                'BackgroundColor', ...
                0.5 * (get(h_itemChoicePanel,'BackgroundColor') + [1 1 1]) ...
                );
            
            
    % set the positions of the fraction
    set(h_fraction, ...
            'Position', ...
            [   positionLine_head(1) + positionLine_head(3) + ...
                    xRelPosition_nameList(1) + xRelPosition_nameList(2) + ...
                    xRelPosition_value(1) + xRelPosition_value(2) + ...
                    xRelPosition_unit(1) + xRelPosition_unit(2) + ...
                    xRelPosition_type(1) + xRelPosition_type(2) + ...
                    xRelPosition_fraction(1), ...
                spacePanel_pixel + 1, ...
                xRelPosition_fraction(2), ...
                position_panel_itemChoice(4) - 2 * spacePanel_pixel ...
            ])
    % set the tag and save the handle to handles
    eval(['set(h_fraction, ''Tag'', ''fraction_itemChoice_', ...
            tag_core, ''')'])
    eval(['handles.fraction_itemChoice_', tag_core, ' = h_fraction;'])
   % --------- 6. FRACTION   END ---------


    % --------- 7. PERCENT BEGIN ---------
    % create and initialize the unit
    h_percent = label_Initialize(h_itemChoicePanel, ...
        string_percent, ...
        fontColor_item, ...
            [   positionLine_head(1) + positionLine_head(3) + ...
                    xRelPosition_nameList(1) + xRelPosition_nameList(2) + ...
                    xRelPosition_value(1) + xRelPosition_value(2) + ...
                    xRelPosition_unit(1) + xRelPosition_unit(2) + ...
                    xRelPosition_type(1) + xRelPosition_type(2) + ...
                    xRelPosition_fraction(1) + xRelPosition_fraction(2) + ...
                    xRelPosition_percent(1), ...
                spacePanel_pixel + 1, ...
                xRelPosition_percent(2), ...
                position_panel_itemChoice(4) - 2 * spacePanel_pixel ...
            ], ...
        fontSize_item, array_fontWeight{7}, ...
        adjusted);

    % set the interpreter of the text box of unit to latex 
    set(h_percent(2),'Interpreter','latex')

    % set the tags and save the handles to handles
    eval(['set(h_percent(1), ''Tag'', ''axes_percent_itemChoice_', ...
            tag_core, ''')'])
    eval(['handles.axes_percent_itemChoice_', tag_core, ' = h_percent(1);'])

    eval(['set(h_percent(2), ''Tag'', ''text_percent_itemChoice_', ...
            tag_core, ''')'])
    eval(['handles.text_percent_itemChoice_', tag_core, ' = h_percent(2);'])

    % --------- 7. PERCENT   END ---------
   

    % --------------------- CREATION AND INITIALIZATION   END ---------------------
    
    

    
    
    % --------------------- SET CALLBACKS BEGIN ---------------------
    if (~isempty(selectedTable) && ~isempty(criteriaTable) && ...
            ~isempty(keyCriteria) && ~isempty(maxNumber_nameList) && ~isempty(outputTable)...
        ) && ...
        isempty(array_nameList_alternative)
        eval(['set(handles.nameList_itemChoice_', tag_core, ...
            ', ''Callback'', {@nameList_itemChoice_Callback, handles})'])

        eval(['set(handles.value_itemChoice_', tag_core, ...
            ', ''Callback'', {@value_itemChoice_Callback, handles})'])
    elseif (isempty(selectedTable) && isempty(criteriaTable) && ...
                isempty(keyCriteria) && isempty(maxNumber_nameList) && isempty(outputTable)...
            ) && ...
            ~isempty(array_nameList_alternative)
        eval(['set(handles.nameList_itemChoice_', tag_core, ...
            ', ''Callback'', {@nameList_itemChoice_alternative_Callback, handles})'])

        eval(['set(handles.value_itemChoice_', tag_core, ...
            ', ''Callback'', {@value_itemChoice_alternative_Callback, handles})'])
        
    end
    % --------------------- SET CALLBACKS   END ---------------------
    
end