%% B_ZSM This function calculates the value B for Zehner Schlunder Model iteratively.
% It consumes about 2 sec.
function B = B_ZSM(curveRBalpha,R,alpha,phi)
%% Explanations of input & output arguments:

% curveRBalpha: e.g. @(r,B,alpha)curveRAreaContact(r,B,alpha)
%               a function handle in form: @(r,B,alpha)function(r,B,alpha,a,b,...) and a, b and other variables must be specified.
% R: e.g. 1.1: numeric variable, R >= 1.
% alpha: e.g. 0.002: numeric variable, alpha >= 0.
% phi: e.g. 0.5: numeric variable, phi is in range of [0,1].
%       DON'T FORGET:  phi > 1 - 1 / R^2.

%% Iteration of B

    % set some error ranges
    REsp = 1e-3;
    BEsp = 1e-3;
    B0 = 1e-6;

    % classified discussion to simply the iteraton
    if phi < 0 || phi > 1 || R < 1
        error('phi is out of range of [0,1] or R < 1')
    elseif phi == 1
        B = 0;
    elseif phi == 0
        if R == 1
            B = Inf;
        else
            error('R MUST be 1, when phi = 0.')
        end
    else
        if phi < 1 - 1/R^2
            error('phi must be BIGGER than or be EQUAL to 1 - 1/R^2. (phi has a lower limit 1 - 1/R^2.)')
        elseif phi == 1 - 1/R^2
            B = Inf;
        else
            
            % use fsolve to calculate B by iteration
            options = optimoptions('fsolve','Display','none','TolFun',1e-20); % set options
            B_iter = fsolve(@(B)volume8th(@(r)curveRBalpha(r,B,alpha),1) - (1 - phi) * pi * R^2 / 4,B0,options); % iteration using vSolid(B) - (1-phi) * vTotal = 0
            
            % verify whether the B_Iter is meaningful with a little negatie tolerance
            if B_iter < - BEsp
                error('Failed to find a non-negative B. Here, B = %.8f.',B_iter)
            elseif B_iter > - BEsp && B_iter < 0 % approximated to 0 when the negative number is near zero to avoid unexpected value because of rouding errors
                fprintf('B is approximated to 0 at B = %.8f for B calculation.\n',B_iter)
                B = 0;
            elseif B_iter == 0
                B = 0;
            else
                % calculate R_Iter with the above iterated B_Iter to test the accuracy of B_Iter with the input R
                R_iter = R_ZSM(@(r,B,alpha) curveRBalpha(r,B,alpha),B_iter,alpha,phi);
                if abs(R_iter - R)/R >= REsp
                    error('Failed to find an accurate B (B_iter = %.4f) because of the inaccuracy ratio (value: %.4f , R_Iter = %.4f) of the calculated R using this B (value: %.4f) at R = % .4f, alpha = %.4f and phi = %.4f. \n',B_iter,abs(R_iter - R)/R,R_iter,B_iter,R,alpha,phi);
                else
                    B = B_iter; % the final result
                end
            end
        end
    end