function Xdc = dcsolvecont(n_steps,maxerr)
% Compute dc solution using newtwon iteration and continuation method
% (power ramping approach)
% inputs:
% n_steps is the number of continuation steps between zero and one that are
% to be taken. For the purposes of this assigments the steps should be 
% linearly spaced (the matlab function "linspace" may be useful).
% maxerr is the stopping criterion for newton iteration (stop iteration
% when norm(deltaX)<maxerr

    global G
    
    alpha_arr = linspace(0, 1, n_steps);
    Xguess = zeros(size(G,1),1);
    
    for k = 1:n_steps
        alpha = alpha_arr(k);
        Xdc = dcsolvealpha(Xguess, alpha, maxerr);
        Xguess = Xdc;
    end

end

