%Define some parameters
xmin=0; xmax=1; % Determines the x limits of the region
ymin=0; ymax=1; % Determines the y limits of the region
xinc=0.1; yinc=0.1; % Determines the amount of refinement required

xnum = (xmax-xmin)/xinc; % Calculates number of x intervals needed
ynum = (ymax-ymin)/yinc; % Calculates number of y intervals needed

% Define the initial grid
vals(:,:,1) = ones(xnum, ynum); % Plant concentration
vals(5:6,5:6,1) = 10;
vals(:,:,2) = ones(xnum, ynum); % Water concentration
vals(:,:,3) = ones(xnum, ynum); % Energy in plant system

% Set the value of constants
constants = [1/2, -1/2, 1/2, -1/2, 1/10, -1/2, -1/2, 1/2, 1/2, 1];

% Define anonymous function to be minimized
minfun = @(X) modelenergy(X, constants, xinc, yinc, xnum, ynum);
% Set the number of iterations for the optimizer
options = optimoptions('fmincon', 'MaxFunctionEvaluations', 100000);
% Run optimizer using the prescribed options
[minvals, minchange] = fmincon(minfun, vals,[],[],[],[],vals*0,[], [], options)
% Here the funtion minimized is the regionenergy function
% The constants are used from the constants array
% The constraint on the solution is that it should be greater than 0


% Generate a plot of the water and plant concentration in the region
 figure;
 subplot(2,4,1)
 hold on
 xgrid = xmin+xinc/2:xinc:xmax-xinc/2;
 ygrid = ymin+yinc/2:yinc:ymax-yinc/2;
 surf(xgrid, ygrid, minvals(:,:,1))
 hold off
 title('Minimizing Plant Concentration')
 subplot(2,4,2)
 hold on
 xgrid = xmin+xinc/2:xinc:xmax-xinc/2;
 ygrid = ymin+yinc/2:yinc:ymax-yinc/2;
 surf(xgrid, ygrid, minvals(:,:,2))
 hold off
 title('Minimizing Water Concentration')
 subplot(2,4,3)
 hold on
 xgrid = xmin+xinc/2:xinc:xmax-xinc/2;
 ygrid = ymin+yinc/2:yinc:ymax-yinc/2;
 surf(xgrid, ygrid, minvals(:,:,3))
 hold off
 title('Minimizing Plant System Energy')
 subplot(2,4,4)
 contour(xgrid, ygrid, minvals(:,:,1))
 title('Minimizing Plant Concentration')
 subplot(2,4,5)
 hold on
 xgrid = xmin+xinc/2:xinc:xmax-xinc/2;
 ygrid = ymin+yinc/2:yinc:ymax-yinc/2;
 surf(xgrid, ygrid, vals(:,:,1))
 hold off
 title('Initial Plant Concentration')
 subplot(2,4,6)
 hold on
 xgrid = xmin+xinc/2:xinc:xmax-xinc/2;
 ygrid = ymin+yinc/2:yinc:ymax-yinc/2;
 surf(xgrid, ygrid, vals(:,:,2))
 hold off
 title('Initial Water Concentration')
 subplot(2,4,7)
 hold on
 xgrid = xmin+xinc/2:xinc:xmax-xinc/2;
 ygrid = ymin+yinc/2:yinc:ymax-yinc/2;
 surf(xgrid, ygrid, vals(:,:,3))
 hold off
 title('Initial Plant System Energy')
 subplot(2,4,8)
 contour(xgrid, ygrid, vals(:,:,1))
 title('Initial Plant Concentration')
% 
% %bar3(minconc(:,:,1))
