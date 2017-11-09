%Define some parameters
xmin=0; xmax=30;   % Determines the x limits of the region
ymin=0; ymax=30;   % Determines the y limits of the region
xnum=120; ynum=120; % Determines the amount of refinement required

xinc = (xmax-xmin)/xnum; % Calculates length of x interval
yinc = (ymax-ymin)/ynum; % Calculates length of y interval

% Define the initial grid
 conc = repmat(sin(pi*[1:xnum]/xnum).^2, ynum, 1);
% conc = rand(xnum,ynum)-0.5;

% Set the value of constants
constants = [1, 1, .1];

% Define anonymous function to be minimized
minfun = @(X) newregion_opt(X, constants, xinc, yinc);
% Set the number of iterations for the optimizer
options = optimoptions('fmincon', 'MaxFunctionEvaluations', 200000,...
    'Hessian', {'lbfgs',30}, 'TolCon', 1e-8,'TolFun',1e-8,'TolX',1e-8,...
    'UseParallel', true,...
    'SpecifyObjectiveGradient',true);

% Options used to check if the supplied gradient calculation is correct
% ,...
%    'CheckGradients', true,...
%   'FiniteDifferenceType', 'central'

% Run optimizer using the prescribed options
[minconc, minenergy] = fmincon(minfun, conc,[],[],[],[],[],[], [], options)
% Here the funtion minimized is the regionenergy function
% The constraint on the solution is that it should be greater than 0

% Generate a plot of the concentration in the region
 xgrid = xmin+xinc/2:xinc:xmax-xinc/2;
 ygrid = ymin+yinc/2:yinc:ymax-yinc/2;
 surf(xgrid, ygrid, minconc)
 title('Surface Plot of the Minimizing Concentrations')
