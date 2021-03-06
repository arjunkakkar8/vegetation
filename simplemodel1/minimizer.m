%Define some parameters
xmin=0; xmax=100;   % Determines the x limits of the region
ymin=0; ymax=100;   % Determines the y limits of the region
xnum=100; ynum=100; % Determines the amount of refinement required

xinc = (xmax-xmin)/xnum; % Calculates length of x interval
yinc = (ymax-ymin)/ynum; % Calculates length of y interval

% Define the initial grid
% conc = repmat(sin(2*pi*[1:xnum]/xnum).^2, ynum, 1);
 conc = (sin(pi*[1:xnum]/xnum).^2' * sin(pi*[1:ynum]/ynum).^2)+0.1*rand(xnum,ynum);
% conc = sin(pi*[1:xnum]/xnum).^2' * sin(pi*[1:ynum]/ynum).^2;
% conc = rand(xnum,ynum);
% conc = repmat(exp([1:xnum]./xnum), ynum, 1);

% Define the landscape

g = 0.1.*repmat([1:xnum]./xnum, ynum, 1);

% Set the value of constants
constants = [1, 1, .5, 0];

% Define anonymous function to be minimized
minfun = @(X) operator(X, g, constants, xinc, yinc);
% Set the number of iterations for the optimizer
options = optimoptions('fmincon', 'MaxFunctionEvaluations', 200000,...
    'Hessian', {'lbfgs',30}, 'TolCon', 1e-8,'TolFun',1e-8,'TolX',1e-8,...
    'UseParallel', true);

% Options used to check if the supplied gradient calculation is correct
% ,...
%     'SpecifyObjectiveGradient',true
% ,...
%    'CheckGradients', true,...
%   'FiniteDifferenceType', 'central'

% Run optimizer using the prescribed options
[minconc, minenergy] = fmincon(minfun, conc,[],[],[],[],conc*0,[],[], options)
% Here the funtion minimized is the regionenergy function
% The constraint on the solution is that it should be greater than 0

% Generate a plot of the concentration in the region
subplot(2, 2, [1,2])
 xgrid = xmin+xinc/2:xinc:xmax-xinc/2;
 ygrid = ymin+yinc/2:yinc:ymax-yinc/2;
 surf(xgrid, ygrid, minconc)
 title('Surface Plot of the Minimizing Concentrations')
subplot(2, 2, 3)
 surf(xgrid, ygrid, conc)
 title('Surface Plot of the Initial Concentrations')
subplot(2, 2, 4)
 surf(xgrid, ygrid, g)
 title('Landscape')