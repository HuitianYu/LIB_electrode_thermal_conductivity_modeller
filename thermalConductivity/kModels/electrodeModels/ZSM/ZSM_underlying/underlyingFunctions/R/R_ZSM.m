%% R_ZSM This function calculates R out of B, alpha and phi.
% R is the outer radius of fluid layer, which surrounds the solid particles
% in Zehner Schluner Model. R >= 1.
% phi is the volume fraction of filling fluid
% including the outer layer. phi is in range of [0,1].
function R = R_ZSM(curveRBalpha,B,alpha,phi) 
%% Explanations of input & output arguments:

    % curveRBalpha: e.g. @(r,B,alpha)curveRAreaContact(r,B,alpha)
    %               a function handle in form: @(r,B,alpha)function(r,B,alpha,a,b,...) and a, b and other variables must be specified.
    % B: e.g. 1: numeric variable, B >= 0.
    % alpha: e.g. 0.002: numeric variable, alpha >= 0.
    % phi: e.g. 0.5: numeric variable, phi is in range of [0,1].

%% Calculation of R

    % one eighth volume of solid enclosed by the curve
    volumeSolid = volume8th(@(r)curveRBalpha(r,B,alpha),1);

    % avoid some impratical one eighth volume
    if volumeSolid > pi / 4
        volumeSolid = pi / 4;
    end
    if volumeSolid < 0
        volumeSolid = 0;
    end
    
    % classified calculation for R to simplify some calculation
    if phi > 1 || phi <0
        error('phi is out of range of [0.1].')
    else
        if volumeSolid == pi / 4
            if phi == 1
                error('It is not possible, when B is infinity but phi = 1')
            else
                R = 1/sqrt(1-phi);
            end
        elseif volumeSolid == 0
            if phi == 1
                R = 1;
            else
                error('It is not possible, when B = 0 but phi NOT = 1')
            end
        else
            if phi == 1
                error('phi = 1 is not possible, when volumeSolid Not = 0.')
            else
                
                % calculate R with format
                R = sqrt( 4 / pi * volumeSolid /( 1 - phi ) );
            end
        end
    end