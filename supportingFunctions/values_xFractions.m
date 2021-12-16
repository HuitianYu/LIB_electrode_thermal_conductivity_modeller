%% VALUES_XFRACTIONS This function concatenates physicalQuantitiesMatrix, xFractionsMatrix, physicalQuantitiesFiller and xPorosity
% to physicalQuantities and xFractions, where filler does not need
% to be distinguished from matrix materials.
% xFractionsMatrix and xPorosity must share the same unit.

function [values,xFractions] = values_xFractions(valuesMatrix,xFractionsMatrix,valueFiller,xPorosity)
%% Explanations of input & output arguments:

    % valuesMatrix: e.g. [0.2;24] or 0.2: n_matrix * 1 numeric array of thermal conductivities
    % xFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % valueFiller: e.g. 'none' or 24: numeric variable.
    % xPorosity: e.g. 0 or 0.5: numeric variable.    
    
%% To concatenate the input argument

    % assign values to thermalConductivities and volumeFractions
    n_matrix = size(valuesMatrix,1);
    xFractionsMatrix(n_matrix,1) = 1 - sum(xFractionsMatrix(1:n_matrix - 1));
    if xFractionsMatrix(n_matrix,1) < 0
        error(['The calculated last element is negative (',num2str(xFractionsMatrix(1,1)),',',num2str(xFractionsMatrix(2,1)),',',num2str(xFractionsMatrix(3,1))],').')
    end

    if ischar(valueFiller) && strcmp(valueFiller,'none') && xPorosity == 0
        values = valuesMatrix;
        xFractions = xFractionsMatrix;
    elseif (ischar(valueFiller) && strcmp(valueFiller,'none')) && xPorosity ~= 0
        error('xPorosity should be 0, when physicalQuantityFiller is ''none''.')
    else
        values = [valuesMatrix;valueFiller];
        xFractions = [xFractionsMatrix * (1 - xPorosity);xPorosity];
    end
    