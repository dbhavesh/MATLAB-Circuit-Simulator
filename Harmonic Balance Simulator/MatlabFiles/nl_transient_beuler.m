function [tpoints,r] = nl_transient_beuler(t1,t2,h,out)
% [tpoints,r] = beuler(t1,t2,h,out)
% Perform transient analysis for NONLINEAR Circuits using Backward Euler
% Assume zero initial condition.
% Inputs:  t1 = starting time point (typically 0)
%          t2 = ending time point
%          h  = step size
%          out = output node
% Outputs  tpoints = are the time points at which the output
%                    was evaluated
%          r       = value of the response at above time points
% plot(tpoints,r) should produce a plot of the transient response

HB_Circuit
global G C b

tpoints = t1:h:t2;
m = length(b);
xn1 = zeros(m,1);
xn0 = zeros(m,1);
maxerr = 1e-6;
r = zeros(m,length(tpoints));

for k = 1:length(tpoints)-1
  dX = 999;
  while dX > maxerr
      phi = (G + C./h) * xn1 + f_vector(xn1) ...
            - BTime(tpoints(k+1)) - (C./h)*xn0;
      dphi = (G + C./h) + nlJacobian(xn1);
      deltaX = -dphi\phi;       
      dX = norm(deltaX);
      xn1 = xn1 + deltaX;
  end
    r(:,k+1) = xn1(out);
    xn0 = xn1;
end

end




   