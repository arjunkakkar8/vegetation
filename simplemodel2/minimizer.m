%Define some parameters
xmin=0; xmax=100;   % Determines the x limits of the region
ymin=0; ymax=100;   % Determines the y limits of the region
xnum=50; ynum=50; % Determines the amount of refinement required

xinc = (xmax-xmin)/xnum; % Calculates length of x interval
yinc = (ymax-ymin)/ynum; % Calculates length of y interval

% Define the initial grid
 conc = repmat(sin(2*pi*[1:xnum]/xnum).^2, ynum, 1)+0.1*rand(xnum,ynum)+1;
% conc = sin(1*pi*[1:xnum]/xnum).^2' * sin(2*pi*[1:ynum]/ynum).^2+0.1*rand(xnum,ynum);

% conc = rand(xnum,ynum);
% conc = repmat(exp([1:xnum]./xnum), ynum, 1);

% Define the landscape
g = repmat([1:xnum]./xnum, ynum, 1);

% Set the value of constants
constants = [1, 1, 1, 5];

% Define anonymous function to be minimized
%objfun = @(X) objfun(X);
constrfun = @(Y) constraint(Y, g, constants, xinc, yinc, xnum, ynum);

% Set the number of iterations for the optimizer
options = optimoptions('fmincon', 'MaxFunctionEvaluations', 300000,...
    'Hessian', {'lbfgs',30}, 'TolCon', 1e-5,'TolFun',1e-5,'TolX',1e-5,...
    'UseParallel', true, 'SpecifyObjectiveGradient',true);


% Run optimizer using the prescribed options
[minconc, minenergy] = fmincon('objfun', conc,[],[],[],[],conc*0,[], constrfun, options)

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