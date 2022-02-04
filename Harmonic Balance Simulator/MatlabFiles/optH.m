function[] = optH()

for i=1:5
    converged = false;
    H = 3;
    xs = zeros(7,1);
    [t0, x0] = hbsolve(H,xs);

    Htol = 1*10^(-i);

    while ~converged
        H = H + 1;
        N = 2*H + 1;
        xs = zeros(N,1);
        [t1, x1] = hbsolve(H,xs);

        if (abs(mean(x1)-mean(x0)) < Htol)
            tol_arr(i) = Htol;
            H_arr(i) = H;
            converged = true;
            break;
        end
        t0 = t1;
        x0 = x1;
    end
end

semilogx(tol_arr,H_arr)
grid on;
xlabel('Tolerance'); ylabel('H Required');

end

