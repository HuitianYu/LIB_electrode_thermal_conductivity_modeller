%% K_ZSM This function calculates the effective thermal conductivity of solid and fluid material,
% using Zehner Schlunder model, where phi is used to determine B iteratively.

function keff = k_ZSM(nameMatrix,nameFiller,curveName,R,alpha,phi)
%% Explanations of input & output arguments:

    % nameMatrix:    e.g. 'graphiteParallel': 1 * 1 cell array. 
    % nameFiller:    e.g. 'LP30': 1 * 1 cell array. 
    % curveName: e.g. 'curveRAreaContact': char array, the name of a function handle with variables (r,B,alpha).
    % R: e.g. 1.1: numeric variable, R >= 1.
    % alpha: e.g. 0.002: numeric variable, alpha >= 0.
    % phi: e.g. 0.5: numeric variable, phi is in range of [0,1].
    %       DON'T FORGET: phi >= 1 - 1 / R^2.  

%% To import thermal conductivities from table statistics
    % load statistics from tables
    load tables statistics
    % assign one line of table to table variable of all materials
    matrix = statistics(nameMatrix,:); 
    filler = statistics(nameFiller,:);
    % assign thermal conductivities to variables
    kMatrix = matrix.thermalConductivity;
    kFiller = filler.thermalConductivity;
    
%% To calculate the effective thermal conductivity

    % calculate B out of R, alpha, phi
    eval(['curveRBalpha = @ (R,B,alpha)',curveName,'(R,B,alpha);']) % create a function handle
    B = B_ZSM(curveRBalpha,R,alpha,phi);

    % calculate the effective thermal conductivity using corresponding calculator
    keff = k_ZSM_calculator(kMatrix,kFiller,curveName,R,B,alpha);

