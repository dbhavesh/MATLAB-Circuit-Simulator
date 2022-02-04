function r = fsolve(fpoints ,out)
%  fsolve(fpoints ,out)
%  Obtain frequency domain response
%  global variables G C b
%  Inputs: fpoints is a vector containing the fequency points at which
%          to compute the response in Hz
%          out is the output node
%  Outputs: r is a vector containing the value of
%           of the response at the points fpoint

% define global variables
    global G C b
    
    n = size(fpoints,2);
    X = zeros(n,size(G,1));
    
    for k = 1:n
        s = 1i*2*pi*fpoints(k);     % s = j*w = j*2*pi*f
        X(k,:) = (G + s*C)\b;       % solving for Ax = b, where A = G + sC
        r(k) = X(k,out);
    end
end