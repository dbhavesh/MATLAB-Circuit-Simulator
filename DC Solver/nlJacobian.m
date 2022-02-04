function J = nlJacobian(X)
% Compute the jacobian of the nonlinear vector of the MNA equations as a 
% function of X
% input: X is the current value of the unknown vector.
% output: J is the jacobian of the nonlinear vector f(X) in the MNA
% equations. The size of J should be the same as the size of G.
% Rahul Bhavesh Dhunnoo [260629108]

global G DIODE_LIST

M = size(G);
J = zeros(M);

NbDiodes = size(DIODE_LIST,2);

for I = 1:NbDiodes
    diode = DIODE_LIST(I);  % deconstructing diode variables
    node1 = diode.node1;  
    node2 = diode.node2;
    Vt    = diode.Vt;
    Is    = diode.Is; 

    if (node1 ~= 0) && (node2 ~= 0) 
        v1 = X(node1);
        v2 = X(node2); 
        df = (Is/Vt)*exp((v1-v2)/Vt);           % expression for dfn/dxn
        J(node1,:) = J(node1,:) + [df, -df, 0]; % Adding df1/dxn to first row of J
        J(node2,:) = J(node2,:) + [-df, df, 0]; % Adding df2/dxn to second row of J
    elseif (node1 == 0)
        v2 = X(node2);
        df = -(Is/Vt)*exp(-v2/Vt);              % expression for dfn/dxn
        J(node2,:) = J(node2,:) + [0, -df, 0];  % Adding df2/dxn to second row of J
    elseif (node2 == 0)
        v1 = X(node1);
        df = (Is/Vt)*exp(v1/Vt);                % expression for dfn/dxn
        J(node1,:) = J(node1,:) + [df, 0, 0];   % Adding df1/dxn to first row of J
    end
end

end




