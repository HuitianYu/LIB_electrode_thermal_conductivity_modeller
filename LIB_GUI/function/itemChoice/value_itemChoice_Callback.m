%% VALUE_ITEMCHOICE_CALLBACK
% calls back a function for value of the item choice.

function varargout = value_itemChoice_Callback(hObject, eventdata, handles) %#ok<STOUT,INUSL>

% get the tag_core
currentTag = get(hObject, 'Tag');
tag_core = currentTag(length('value_itemChoice_') + 1 : end);

% get the handle for the name list
eval(['handle_nameList = handles.nameList_itemChoice_', tag_core, ';'])

% get the string array of the name list
array_string_nameList = get(handle_nameList, 'String');

% get the 'Value' for the name list
value_nameList = get(handle_nameList, 'Value');

% get the maximal length of the name list
eval(['maxNumber_nameList = getappdata(0, ''maxNumber_nameList_', ...
    tag_core,''');'])

% get the maximal length of the name list
eval(['stringEnd_nameList = getappdata(0, ''stringEnd_nameList_', ...
    tag_core,''');'])

% get the total length of the name list under certain criteria
eval(['totalNumber_nameList = getappdata(0, ''totalNumber_nameList_', ...
    tag_core,''');'])

% get the table and output
eval(['selectedTable = getappdata(0, ''selectedTable_', ...
    tag_core, ''');'])
eval(['outputTable = getappdata(0, ''outputTable_', ...
    tag_core, ''');'])

% string of the edit frame
string_value = get(hObject, 'String');


string_errorInfo = '';

try
    % set the value handle and name list after typing in the value edit frame
   % EMPTY
    if  isempty(string_value)
         % set the visibility of the text of the unit to off
        eval(['set(handles.text_unit_itemChoice_', tag_core, ', ''Visible'', ''off'')'])
    % NUMBER
    elseif  ~isnan(str2double(string_value))
        % WHETHER LIST IS POSTIONED AT THE FIST ONE
        if value_nameList == 1
            % NON-NEGATIVE NUMBER
            if str2double(string_value) >= 0
            % VALUE OF NAME STRING IS 1?
                % set the visibility of the text of the unit to on
                eval(['set(handles.text_unit_itemChoice_', tag_core, ', ''Visible'', ''on'')'])
            else
                string_errorInfo = 'The typed number should be non-negative.';
                error(string_errorInfo)
            end
        else
            string_errorInfo = 'Number is not allowed to type. Please type a hidden component.';
            error(string_errorInfo)
        end
    % STRING
    else
        % STRING, BUT NOT A VARIABLE NAME IN THE FUNCTION
        if ~any(strcmp(string_value,who))
            % try to convert the expression to number, if it is an
            % expression
            try
                eval(['string_value = ', string_value, ';'])
                string_value = num2str(string_value);
            catch
                
            end
            
            % EXPRESSION CONVERTED FROM STRING
            if ~isnan(str2double(string_value))
                % WHETHER LIST IS POSTIONED AT THE FIST ONE
                if value_nameList == 1
                    % set the 'String' of the value edit frame
                    set(hObject, 'String', string_value)
                    if str2double(string_value) >= 0
                        % set the visibility of the text of the unit to on
                        eval(['set(handles.text_unit_itemChoice_', tag_core, ', ''Visible'', ''on'')'])  
                    else
                        string_errorInfo = 'The typed number should be non-negative.';
                        error(string_errorInfo)
                    end
                else
                    string_errorInfo = 'Number is not allowed to type. Please type a hidden component.';
                    error(string_errorInfo)   
                end
            % COMPONENT NAME
            else
                % load the table
                eval(['load tables ', selectedTable])

                % EXISTING NAME
                if  any(strcmp(array_string_nameList,string_value)) && ...
                        ~strcmp(string_value,array_string_nameList(1))
                    % WHETHER LIST IS POSTIONED AT THE FIST ONE
                    if value_nameList == 1
                        % get the targeted value of the name list
                        target_value_nameList = ...
                            find(strcmp(array_string_nameList,string_value), 1);
                        % set 'Value' of the name list to the corresponding one
                        set(handle_nameList, 'Value', target_value_nameList)
                        
                        % set 'String' of the value edit to the output of the corresponding one
                        string_currentMaterial = array_string_nameList{target_value_nameList};
                        eval(['currentMaterial = ', selectedTable, '(''', ...
                                string_currentMaterial, ''',:);'])
                        eval(['output = currentMaterial.', outputTable,';'])
                        set(hObject, 'String', num2str(output))
                        
                        % set the 'Enable' to off
                        set(hObject, 'Enable', 'off')
                    
                        % set the visibility of the text of the unit to on
                        eval(['set(handles.text_unit_itemChoice_', tag_core, ', ''Visible'', ''on'')'])
                    else
                        string_errorInfo = 'This component exists already.';
                        error(string_errorInfo)
                    end
                    
                % NON-EXISTING NAME    
                else
                    % load the strings for the name list
                    eval(['array_nameList = ', selectedTable, '.Properties.RowNames;'])
                    % whether this component exists in the table
                    if ~any(strcmp(array_nameList,string_value))
                        string_errorInfo = 'This is not a component name in the table.';
                        error(string_errorInfo) % not filled, go to catch
                    end
                    % try to find the material in the selected table
                    eval(['currentMaterial = ', selectedTable, '(''', ...
                            string_value, ''',:);'])

                    % get the criteria table of the name list
                    eval(['criteriaTable = getappdata(0, ''criteriaTable_', ...
                        tag_core,''');'])
                    % get the key criteria of the name list
                    eval(['keyCriteria = getappdata(0, ''keyCriteria_', ...
                        tag_core,''');'])
                    % verify whether the criteria are fulfilled
                    eval(['currentKeyCriteria = currentMaterial.', criteriaTable, ';'])
                    
                    
                    % WHETHER LIST IS POSTIONED AT THE LAST ONE
                    if value_nameList == length(array_string_nameList)
                        
                       % whether the component obeys the criteria
                        if ~any(strcmp(keyCriteria, currentKeyCriteria))
                            string_errorInfo = 'The component does not belong to this type.';
                            error(string_errorInfo) % not filled, go to catch
                        end
                       
                        % fulfilled and continue
                        eval(['output = currentMaterial.', outputTable,';'])
                        set(hObject, 'String', num2str(output))
                        % set 'Enable' of the value to 'off'
                        set(hObject, 'Enable', 'off')
                        
                        % set the visibility of the text of the unit to on
                        eval(['set(handles.text_unit_itemChoice_', tag_core, ', ''Visible'', ''on'')'])   


                        % add this material to the name list
                        array_string_nameList = [...
                            array_string_nameList(1:end-1);...
                            string_value];
                        if length(array_string_nameList) < totalNumber_nameList + 1
                            array_string_nameList = [array_string_nameList; stringEnd_nameList];
                        end

                        % reset the 'String' of the name list and change the value to
                        % this one
                        set(handle_nameList, 'String', array_string_nameList)
                        set(handle_nameList, 'Value', length(array_string_nameList) - 1)
                    else
                       % whether the component obeys the criteria
                        if ~any(strcmp(keyCriteria, currentKeyCriteria))
                            string_errorInfo = 'The component does not exist in the list and does not belong to this type.';
                            error(string_errorInfo) % not filled, go to catch
                        else
                            string_errorInfo = 'The name does not exist in the list. ';
                            if length(array_string_nameList) < totalNumber_nameList + 1
                                string_errorInfo = [string_errorInfo, ...
                                     'Please click ', stringEnd_nameList, ' to add a new component.'];
                            end
                        end
                        error(string_errorInfo)
                    end
                end
            end
        else
            string_errorInfo = 'The typed string is a variable name in the function.';
            error(string_errorInfo)
        end

    end
catch
    % change the font color and weight to stress the error
    setappdata(0, 'fontColor_tmp', get(hObject,'ForegroundColor'))
    set(hObject, 'ForegroundColor', [1, 0, 0])
    setappdata(0, 'fontWeight_tmp', get(hObject,'FontWeight'))
    set(hObject, 'Fontweight', 'bold')
    
    % show the erro information
    errorInfo(string_errorInfo, handles)
    
    % recover the font color and weight
    set(hObject, 'ForegroundColor', getappdata(0, 'fontColor_tmp'))
    rmappdata(0, 'fontColor_tmp')
    set(hObject, 'FontWeight', getappdata(0, 'fontWeight_tmp'))
    rmappdata(0, 'fontWeight_tmp')
    
    % set 'String' of the edit to []
    set(hObject, 'String', [])     
end
clear string_errorInfo

end