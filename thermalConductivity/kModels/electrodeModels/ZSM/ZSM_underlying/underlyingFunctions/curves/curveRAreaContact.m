%% CURVERAREACONTACT This function describes a 2D relationship between height (z) and radius (r),
% which reflects 3D relationship in cylinder coordinate.
% 2 other parameters are B (form factor) and alpha (contact factor):
% r^2 + z^2 / ( (1 + alpha) * B - (B - 1) * z )^2 - 1 = 0
% B ranges from 0 to infinity, where B = 0 means doesn't occupy any area (3D: any space);
% B = 1 means the curve turns out to be a circle curve (3D: sphere);
% B = infinity means the curve spans the whole square area (3D: cylider).
% alpha ranges from 0 to infinity, where alpha = 0 means no contact (point contact);
% alpha = inf means total contact.
% alpha satisfies a relationship: RS = aqrt(1 - 1 / ( alpha * B + 1 )^2),
% where RS is the contact radius.
% When B = 0, z = 0.
% z is monotonically increasing with r in range [0,1], where z(r = 0) = 1 (except for B = 0),
% z(r = 1) = 0. z = 0 for z out of range of [0,1].

function z = curveRAreaContact(r,B,alpha) 
%% Explanations of input & output arguments:

% r: e.g. 1: numeric variable, theoretically can be negative.
% B: e.g. 1: numeric variable, B >= 0.
% alpha: e.g. 0.002: numeric variable, alpha >= 0.

%% To calculate z out of r,B,alpha
    % set error range for B to avoid rounding errors
    BEsp = 1e-3;
    
    % simply the calculation with classified discussion

    RS = sqrt(1 - 1 / (alpha * B + 1)^2);
    if r > 1 || r < 0
        z = 0;
    else
        if B < -BEsp
            error('B is smaller than 0. B = %.8f.',B)
        elseif B >= -BEsp && B < 0 % B is near zero 
            fprintf('B is approximated to 0 at B = %.8f for z calculation.\n',B)
            z = 0;
        elseif B == 0
            z = 0;
        elseif B == Inf
            z = 1;
        else
            if alpha < 0
                error('alpha is smaller than 0.')
            elseif alpha == Inf
                z = 1;
            else
                    if r >=0 && r <= RS
                        z = 1;
                    else

                        % calculate z with tranformed analytic equation
                        zTemp = (1 + alpha) * B * sqrt(1 - r^2) / (1 + (B - 1) * sqrt(1 - r^2));

                        % classified discussion to avoid some unexpected values other than those in[0,1]
                        if zTemp > 1
                            z = 1;
                        elseif zTemp < 0
                            z = 0;
                        else
                            z = zTemp;
                        end
                    end
            end
        end
    end