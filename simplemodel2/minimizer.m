function[minconc, minenergy, process] = minimizer(a)

process = [];

%Define some parameters
xmin=0; xmax=100;   % Determines the x limits of the region
ymin=0; ymax=100;   % Determines the y limits of the region
xnum=10; ynum=10; % Determines the amount of refinement required

xinc = (xmax-xmin)/xnum; % Calculates length of x interval
yinc = (ymax-ymin)/ynum; % Calculates length of y interval

% Define the initial grid
% conc = repmat(sin(2*pi*[1:xnum]/xnum).^2, ynum, 1)+0.1*rand(xnum,ynum);

% conc =  sin(1*pi*[1:xnum]/xnum).^2' * sin(3*pi*[1:ynum]/ynum).^2+0.1*rand(xnum,ynum);
%conc =  sin(2*pi*[1:xnum]/xnum).^2' * sin(1*pi*[1:ynum]/ynum).^2+0.1*rand(xnum,ynum);
% conc = ones(xnum, ynum);
%conc =  sin(2*pi*[1:xnum]/xnum).^8' * sin(1*pi*[1:ynum]/ynum).^8+0.1*rand(xnum,ynum);
% conc = 0.1.*ones(xnum, ynum);
% conc(2,10) = 1;
 conc = 0.5.*rand(xnum,ynum);
% conc = repmat(exp([1:xnum]./xnum), ynum, 1);

% Define the landscape
g = repmat([1:ynum]./ynum, xnum, 1);

% Set the value of constants
%constants = [3, 1, 1, 6, 5];
constants = [1, 1, 0.5, 3, 1];
% Define anonymous function to be minimized
%objfun = @(X) objfun(X);
constrfun = @(Y) constraint(Y, constants, xinc, yinc, xnum, ynum);

% Set the number of iterations for the optimizer
options = optimoptions('fmincon', 'MaxFunctionEvaluations', 60000,...
    'SpecifyObjectiveGradient',true,...
    'Display', 'iter', 'Algorithm', 'sqp',...
    'HonorBounds', true, 'OutputFcn', @outfun);

% Run optimizer using the prescribed options
[minconc, minenergy] = fmincon('objfun', conc,[],[],[],[],conc*0,[], constrfun, options);

% Generate a plot of the concentration in the region
subplot(2, 2, [1,2])
 surf(minconc)
 title('Surface Plot of the Minimizing Concentrations')
subplot(2, 2, 3)
 surf(conc)
 title('Surface Plot of the Initial Concentrations')
subplot(2, 2, 4)
 surf(g)
 title('Landscape')

    function stop = outfun(x,optimValues,state)
        stop = false;
        process = [process; x];
    end

end