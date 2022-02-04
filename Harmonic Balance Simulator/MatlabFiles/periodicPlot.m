function[] = periodicPlot()

H = 3;
p = 20;          % number of periods to plot
T = 1/1000;

N = 2*H + 1;
Xs = zeros(N,1);
[tpoints1, Xout] = hbsolve(H,Xs);

j = 1;
while p
    x1(1,1+N*(j-1):j*N) = Xout;
    j = j + 1;
    p = p - 1;
end

tpoints1_arr = zeros(1,length(x1));
for i = 2:length(x1)
    tpoints1_arr(i) = tpoints1(2)*(i-1);
end

% Transient Solution using Non-linear BE
t1=0;       t2=tpoints1_arr(1,end);
h=0.0001;   out=1;
[tpoints2,x2] = nl_transient_beuler(t1,t2,h,out);

% Indivdual Plots
% Harmonic Balance Plot
figure;
plot(1000*tpoints1_arr,x1);
hold on; grid on;
xlabel('Time (ms)'); ylabel('Vout (V)');
title('Harmonic Balance Solution');
hold off;
% Transient Plot
figure;
plot(1000*tpoints2, x2);
hold on; grid on;
xlabel('Time (ms)'); ylabel('Vout (V)');
title('Transient Response using Non-linear BE')
hold off;

% Both Plots
figure;
plot(1000*tpoints1_arr,x1);
hold on;
plot(1000*tpoints2, x2);
hold on;                grid on;
xlabel('Time (ms)');    ylabel('Vout (V)');
legend('Harmonic Balance Simulation','Non-linear BE Transient');
hold off;

% Truncating Plots to after 15ms for p>15
t1s = tpoints1_arr(tpoints1_arr>=15e-3);
x1s = x1(1,end-length(t1s)+1:end);
t2s = tpoints2(tpoints2>=15e-3);
x2s = x2(1,end-length(t2s)+1:end);
plot(1000*t1s, x1s);
hold on;
plot(1000*t2s, x2s);
hold on;                grid on;
xlabel('Time (ms)');    ylabel('Vout (V)');
legend('Harmonic Balance Simulation','Non-Linear BE Transient');
hold off;

BEymin = -1.988;
BEymax = 0.74;
BEymean = -0.5312;
BEpk2pk = abs(BEymax) + abs(BEymin);

HBymin = -2.117;
HBymax = 0.749;
HBymean = -0.6065;
HBpk2pk = abs(HBymax) + abs(HBymin);

end





