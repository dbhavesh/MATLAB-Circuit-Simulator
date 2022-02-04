
function [tpoints,r] = transient_feuler(t1,t2,h,out)
% [tpoints,r] = Transient_feuler(t1,t2,h,out)
% Perform Transient analysis for LINEAR circuit using Forward Euler
% This function assumes the C matrix is invertible and will not work 
% for circuits where C is not invertible.
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

x0 = zeros(size(G,2),1);
tpoints = t1:h:t2;
n = length(tpoints);
r = zeros(n,1);

for k = 1:n-1
    x1 = C\(h*BTime(tpoints(k)) - h*G*x0 + C*x0);
    r(k+1) = x1(out);
    x0 = x1;
end

