function ind(n1,n2,val)
    % ind(n1,n2,val)
    % Add stamp for inductor to the global circuit representation
    % Inductor connected between n1 and n2
    % The indjuctance is val in Henry
    % global G
    % global C
    % global b
    % Date:
    
    % defind global variables
    global G
    global b
    global C
    
    xr = size(G,1) + 1;
    G(xr, xr) = 0;         
    C(xr, xr)= -val; 
    b(xr, 1) = 0;

    if(n1 ~= 0)    
    G(n1, xr) = 1;
    G(xr, n1) = 1;
   end
    
    if(n2 ~= 0)     
       G(n2, xr) = -1;
       G(xr, n2) = -1;
    end
end
    
