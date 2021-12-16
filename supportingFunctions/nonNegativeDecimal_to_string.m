%% NONNEGATIVEDECIMAL_TO_STRING This function convert a decimal number to a string, which can be used in file name.

function nonNegativeDecimal_string = nonNegativeDecimal_to_string(nonNegativeDecimalNumber)
%% Explanations of input & output arguments:
    % nonNegativeDecimalNumber: e.g. 21.368: non-negative numeric variable.
    % nonNegativeDecimal_string: char array.
    
%% Conversion from number to string
    if ~isnumeric(nonNegativeDecimalNumber) || nonNegativeDecimalNumber < 0
        error('It should be number and positive.')
    else
       nonNegativeDecimalNumber_rounded = round(nonNegativeDecimalNumber,2);
       integerPart = floor(nonNegativeDecimalNumber_rounded);
       fractionalPart_2_places = round((nonNegativeDecimalNumber_rounded - integerPart) * 100);
       fractionalPart_second_place = mod(fractionalPart_2_places,10);
       fractionalPart_first_place = (fractionalPart_2_places - fractionalPart_second_place)/10;
       if fractionalPart_2_places ~= 0 && fractionalPart_second_place ~= 0
           if integerPart ~= 0 
                nonNegativeDecimal_string =...
                    [num2str(integerPart),'P',num2str(fractionalPart_first_place),num2str(fractionalPart_second_place)];
           else
               nonNegativeDecimal_string =...
                    ['P',num2str(fractionalPart_first_place),num2str(fractionalPart_second_place)];
           end
       elseif fractionalPart_2_places ~= 0 && fractionalPart_second_place == 0
           if integerPart ~= 0
                nonNegativeDecimal_string = [num2str(integerPart),'P',num2str(fractionalPart_first_place)];
           else
               nonNegativeDecimal_string = ['P',num2str(fractionalPart_first_place)];
           end
       else
           nonNegativeDecimal_string = num2str(integerPart);
       end
    end