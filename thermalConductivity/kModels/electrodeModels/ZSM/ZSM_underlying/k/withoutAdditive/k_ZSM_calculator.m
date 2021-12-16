%% K_ZSM_CALCULATOR This function calculates the effective thermal conductivity 
% with thermal conductivities of solid and fluid material and form factor B,
% using Zehner Schlunder model.

function keff = k_ZSM_calculator(kMatrix,kFiller,curveName,R,B,alpha)
%% Explanations of input & output arguments:

    % kMatrix: e.g. 180: numeric variable, the thermal conductivity of solid material.
    % kFiller: e.g. 0.1874: numeric variable, the thermal conductivity of fluid material.
    % curveName: e.g. 'curveRAreaContact': char array, the name of a function handle with variables (r,B,alpha).
    % R: e.g. 1.1: numeric variable, R >= 1.
    % B: e.g. 1: numeric variable, B >= 0.
    % alpha: e.g. 0.002: numeric variable, alpha >= 0.
    
    
%% To calculate the effective thermal conductivity using infinitesimal method

    N = 1e6; % number of steps
    deltaRM = 1 / N; % step length
    kMFTemp = 0; % initial value = 0
    
    % summation of infinitesimal method for middle part, where both solid and fluid exist 
    eval(['curveRBalpha = @(r,B,alpha)',curveName,'(r,B,alpha);']) % corresponding function handle for the curveName
    
    % calculation all without pi
    if B == 0
        kMF = kFiller;
    elseif B == Inf
        kMF = kMatrix;
    else
        for iR = 0 : N -1
            ZMatrixR = curveRBalpha(deltaRM * (iR + 0.5),B,alpha);
            kMFTemp = kMFTemp + 1/(ZMatrixR / kMatrix + (1 - ZMatrixR) / kFiller) * (2 * iR + 1); % 2 * iR + 1 = (iR + 1)^2 - iR^2, where deltaRS^2 is omiited.
        end
        kMF = kMFTemp * deltaRM^2;
    end
    
    % combine the middle part with free liquid surrounding the middle part with series model
    kTemp = 1 / R^2 * kMF + (1 - 1 / R^2) * kFiller; % series --> parallel
    
    if kTemp > max(kMatrix,kFiller) % if statement to avoid rounding error
        keff = max(kMatrix,kFiller);
    elseif kTemp < min(kMatrix,kFiller)
        keff = min(kMatrix,kFiller);
    else
        keff = kTemp;
    end
    
    