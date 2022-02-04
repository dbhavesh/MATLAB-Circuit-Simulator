function J = nlJacobian_hb(X)

n=size(X);
J = zeros(n);
Is = 2e-15;
Vt = 26e-3;

for i=1:n
    J(i,i) = (Is/Vt)*exp(X(i)/Vt);
end

end




