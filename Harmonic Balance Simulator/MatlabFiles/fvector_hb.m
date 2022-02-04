function f = fvector_hb(X)

Is = 2e-15;
Vt = 26e-3;
f = Is*(exp((X)/Vt)-1);

end



