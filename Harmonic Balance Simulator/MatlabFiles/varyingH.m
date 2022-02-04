
clear; clc;

% N = 5;     % number of simulations
% Hmax = 5;
% 
% H_arr = round(linspace(0,Hmax,N));
% H_arr(1) = 1;
% 
% for i = 1:N
%     [t, xout] = hbsolve(H_arr(i),zeros(2*H_arr(i)+1,1));
%     plot(t,xout);
%     hold on;
% end

% Harmonic Balance Plot
% H_arr = round(linspace(0,Hmax,N));
% for  H = 3:50
    H = 40;
    N = 2*H + 1;
    Xs = zeros(N,1);
    [tpoints1, Xout] = hbsolve(H,Xs);
    plot(1000*tpoints1,Xout);
    hold on; 
    grid on;
    xlabel('Time (ms)'); ylabel('Vout (V)');
    title('HB Simulation with H = 40');
    hold off;
% end
