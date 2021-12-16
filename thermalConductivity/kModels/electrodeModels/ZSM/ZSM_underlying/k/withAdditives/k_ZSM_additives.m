%% K_ZSM_ADDITIVES This function calculates the effective thermal conductivity with 2 additives
% both around the neck and at the side
% via the radius of additive RAdd, using Zehner Schlunder model.
% Here, phi is used to determine B iteratively.

function keff = k_ZSM_additives(nameMatrix,nameFiller,nameAdditive,curveName,R,alpha,phi,RAdditive_1,RAdditive_2)
%% Explanations of input & output arguments:

    % nameMatrix:    e.g. 'graphiteParallel': 1 * 1 cell array. 
    % nameFiller:    e.g. 'LP30': 1 * 1 cell array. 
    % nameAdditive: e.g. 'carbonBlack+PVDF': 1 * 1 cell array. 
    %               Usually, the effective thermal conductivity of the addtive should be calcualate first and added to table statistics before using.
    % curveName: e.g. 'curveRAreaContact': char array, the name of a function handle with variables (r,B,alpha).
    % R: e.g. 1.1: numeric variable, R >= 1.
    % alpha: e.g. 0.002: numeric variable, alpha >= 0.
    % phi: e.g. 0.5: numeric variable, phi is in range of [0,1].
    %       DON'T FORGET: phi >= 1 - 1 / R^2.
    % RAdditive_1: e.g. 0.25: numeric variable for additive. RAdditive is in range of [0,1]   
    % RAdditive_2: e.g. 0.3: numeric variable for additive.
    
%% To import thermal conductivities from table statistics
    % load statistics from tables
    load tables statistics
    % assign one line of table to table variable of all materials
    matrix = statistics(nameMatrix,:); 
    additive = statistics(nameAdditive,:);
    filler = statistics(nameFiller,:);
    % assign thermal conductivities to variables
    k_matrix = matrix.thermalConductivity;
    k_additive = additive.thermalConductivity;
    k_filler = filler.thermalConductivity;
    
%% To calculate the effective thermal conductivity

        % calculate B out of R, alpha, phi
        eval(['curveRBalpha = @ (R,B,alpha)',curveName,'(R,B,alpha);']) % create a function handle
        B = B_ZSM(curveRBalpha,R,alpha,phi); % calculate B out of phi and R
        
        % calculate the effective thermal conductivity with additive using corresponding calculator
        keff = k_ZSM_additives_calculator(k_matrix,k_filler,k_additive,curveName,R,B,alpha,RAdditive_1,RAdditive_2);


