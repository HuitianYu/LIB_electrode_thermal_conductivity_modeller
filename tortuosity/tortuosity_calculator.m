%% TORTUOSITY_CALCULATOR This function calculates the tortuosity out of porosity.
% Different modes with their information are listed below.
%
% Mode information:
% Mode 1:
% Mode 2:
% Mode 3:
% TODO: citation

function tau = tortuosity_calculator(porosity,mode)
%% Explanations of input & output arguments:

    % porosity: e.g. 0.2657: numeric variable in range of [0,1].
    % mode: e.g. 1: interger, numeric variable.

%% Calculation of the tortuosity

    if porosity == 0
        tau = Inf;
    else
        switch mode
            case 1
                tau = porosity/( 1 - sqrt( 1 - porosity ));
            case 2
                tau = porosity^(-0.5);
            case 3 % LPF electrode and LCO electrode 1
                tau = 1.8 * porosity^(-0.53);
        end
    end