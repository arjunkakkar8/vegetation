vals = [1,1,1,1,1];

options = optimoptions('fmincon', 'MaxFunctionEvaluations', 60000,...
    'Display', 'iter', 'Algorithm', 'interior-point',...
    'HonorBounds', true);

[minconst, minpenalty] = fmincon('cfun', vals,[],[],[],[], vals*0,[], [], options);



