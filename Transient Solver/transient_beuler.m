function [tpoints,r] = transient_beuler(t1,t2,h,out)
% [tpoints,r] = beuler(t1,t2,h,out)
% Perform transient analysis for LINEAR Circuits using Backward Euler
% assume zero initial condition.
% Inputs:  t1 = starting time point (typically 0)
%          t2 = ending time point
%          h  = step size
%          out = output node
% Outputs  tpoints = are the time points at which the output
%                    was evaluated
%          r       = value of the response at above time points
% plot(tpoints,r) should produce a plot of the transient response

global G C b

% tpoints is a vector containing all the timepoints from t1 to t2 with step
% size h
tpoints = t1:h:t2;
X0 = zeros(length(G), 1);
n = length(tpoints);
r = zeros(n,1);

for k = 1:n-1
    X1 = (G + C./h)\(BTime(tpoints(k+1)) + (C./h)*X0);
    r(k+1) = X1(out);
    X0 = X1;
end







