function [t, xout] = hbsolve(H,xs)
% Performs the steady state simulation using the Harmonic balance method
% input: H is the number of harmonics
%        xs is the initial time-domain guess
% output: t are the timepoints at which the harmonics are calculated
%         xout is the time-domain vector 

% Sinusoid parameters
f0 = 1000;
Io = 10e-3;
w0 = 2*pi*f0;

% circuit paramters
r = 1000;
c = 1e-6;

% Number of time points
N = 2*H + 1;

% Setting MNA phasor variables
B_p = zeros(N,1);
B_p(3) = Io;
G_p = zeros(N);
C_p = zeros(N);

% Setting diagonals of G phasor to corresponding G element
for n = 1:N
    G_p(n,n) = 1/r;
end

% Setting C phasor to corresponding C element multiplied by n*W
for n = 1:N/2
    C_p(2*n+1, 2*n) = -w0*n*c;
    C_p(2*n, 2*n+1) = w0*n*c;
end

% Inverse Discrete Fourier Matrix Operator
gamma = ones(N);
for n = 2:N
    kn = floor(n/2)*linspace(0,N-1,N);
    gamma(:,n) = ((1+(-1)^n)/2)*cos(2*pi*kn/N) + ((1-(-1)^n)/2)*sin(2*pi*kn/N);
end

% Discrete Fourier Matrix Operator
inv_gamma = (1/N)*ones(N);
for n = 2:N
    kn = floor(n/2)*linspace(0,N-1,N);
    inv_gamma(n,:) = (2/N)*(((1+(-1)^n)/2)*cos(2*pi*kn/N) + ((1-(-1)^n)/2)*sin(2*pi*kn/N));
end

maxerr = 1e-10;
converged = false;
iter = 0;
X = inv_gamma*xs;

while ~converged
    iter = iter + 1;
    xs = gamma*X;
    phi = (G_p + C_p)*X + inv_gamma*fvector_hb(xs) - B_p;
    dphi = G_p + C_p + inv_gamma*nlJacobian_hb(xs)*gamma;
    dphi = sparse(dphi);
    deltaX = -dphi\phi;
    X = X + deltaX;
    if norm(deltaX) < maxerr
        converged = true;
    end
end

xout = gamma*X;
t = linspace(0,(1/f0)*(N-1)/N, N);
end