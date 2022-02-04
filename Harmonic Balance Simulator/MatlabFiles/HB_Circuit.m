global G C
global b;

global DIODE_LIST TD_SOURCE_LIST_SINE TD_SOURCE_LIST_PWL
DIODE_LIST = struct('diodename',{ }, 'node1', [ ], 'node2', [ ], 'Is', [ ], 'Vt', [ ]);
TD_SOURCE_LIST_SINE = struct('SourceName',{ }, 'index1', [ ], 'index2', [ ], 'A', [ ], 'Phi', [ ], 'f', [ ]);
TD_SOURCE_LIST_PWL = struct('SourceName',{ }, 'index1', [ ], 'index2', [ ], 'T', [ ], 'D', [ ]);


N = 1;
G = sparse(N,N);               
C = sparse(N,N);
b = sparse(N,1);  

res(1,0,1000)
cap(1,0,1e-6)
cursine(1,0,10e-3,1e3,0)
diode('D1',1,0,2e-15,26e-3)
