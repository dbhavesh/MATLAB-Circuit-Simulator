function [Xdc, dX] = dcsolve(Xguess,maxerr)
% Compute dc solution using newtwon iteration
% input: Xguess is the initial guess for the unknown vector. 
%        It should be the correct size of the unknown vector.
%        maxerr is the maximum allowed error. Set your code to exit the
%        newton iteration once the norm of DeltaX is less than maxerr
% Output: Xdc is the correction solution
%         dX is a vector containing the 2 norm of DeltaX used in the 
%         newton Iteration. the size of dX should be the same as the number
%         of Newton-Raphson iterations. See the help on the function 'norm'
%         in matlab.
% Rahul Bhavesh Dhunnoo [260629108]

global G C b DIODE_LIST

N         = 50;                 % number of iterations arbitrarily set
dX        = zeros(N, 1);
deltaX    = [0; 0; 0];
X         = Xguess;

for k = 1:N
    X = [X(1) + deltaX(1); X(2) + deltaX(2); X(3) + deltaX(3)];
    dfx = nlJacobian(X);
    dphi = G + dfx;
    phi = G*X + f_vector(X) - b;
    deltaX = -dphi\phi;         % remove semicolon to return interim values of 
                                % deltaX for each iteration to CMD window
    dX(k) = norm(deltaX);
    
    if dX(k) < maxerr
        Xdc = X;
        dX = dX(1:k);           % trimming dX to the size of [no. of iterations x 1]
        break;
    end
end

end

