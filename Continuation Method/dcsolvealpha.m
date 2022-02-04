function Xdc = dcsolvealpha(Xguess,alpha,maxerr)
% Compute dc solution using newtwon iteration for the augmented system
% G*X + f(X) = alpha*b
% Inputs: 
% Xguess is the initial guess for Newton Iteration
% alpha is a paramter (see definition in augmented system above)
% maxerr defined the stopping criterion from newton iteration: Stop the
% iteration when norm(deltaX)<maxerr
% Oupputs:
% Xdc is a vector containing the solution of the augmented system

    global G b 

    X = Xguess;
    
    while 1
        phi = G*X + f_vector(X) - alpha.*b;
        dphi = G + nlJacobian(X);
        deltaX = -dphi\phi;       
        dX = norm(deltaX);
        
        if dX < maxerr
            Xdc = X;
            break;
        end

        X = X + deltaX;
    end

end

