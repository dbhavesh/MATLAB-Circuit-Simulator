function J = nlJacobian(X)
% Compute the jacobian of the nonlinear vector of the MNA equations as a 
% function of X
% input: X is the current value of the unknown vector.
% output: J is the jacobian of the nonlinear vector f(X) in the MNA
% equations. The size of J should be the same as the size of G.
% Rahul Bhavesh Dhunnoo [260629108]

global G DIODE_LIST

J = zeros(size(G));

NbDiodes = size(DIODE_LIST,2);

for I = 1:NbDiodes
    diode = DIODE_LIST(I); 
    n1 = diode.node1;               % deconstructing diode variables
    n2 = diode.node2;
    Vt = diode.Vt;
    Is = diode.Is; 
    v1 = X(n1);
    v2 = X(n2);
    df = (Is/Vt)*exp((v1-v2)/Vt);   % expression for dfn/dxn

    if (n1 ~= 0) && (n2 ~= 0) 
        J(n1,n1) = J(n1,n1) + df;
        J(n1,n2) = J(n1,n2) - df;
        J(n2,n1) = J(n2,n1) - df;
        J(n2,n2) = J(n2,n2) + df;
    elseif (n1 ~= 0)
        J(n1,n1) = J(n1,n1) + df;     % Adding df1/dxn 
    elseif (n2 ~= 0)
        J(n2,n2) = J(n2,n2) + df;     % Adding df2/dxn 
    end

end

end




