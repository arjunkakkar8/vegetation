%Define some parameters
xmin=0; xmax=1; % Determines the x limits of the region
ymin=0; ymax=1; % Determines the y limits of the region
xinc=0.1; yinc=0.1; % Determines the amount of refinement required

xnum = (xmax-xmin)/xinc; % Calculates number of x intervals points needed
ynum = (ymax-ymin)/yinc; % Calculates number of y intervals points needed

% Define the initial grid
uconc = rand(xnum,ynum);
uconc(1:floor(xnum/2),1:ynum) = 0;
%uconc = zeros(xnum, ynum); %Define the grid with initial plant concentration
wconc = rand(xnum, ynum); %Define the grid with initial water concentration
conc(:,:,1)=uconc;
conc(:,:,2)=wconc;

% Set the value of constants
constants = [1/2, -1/2, 1/2, -1/2, 1/10, -1/2, -1/2, 1/2, 1/2];
% Define anonymous function to be minimized
minfun = @(X) regionenergy(X, constants, xinc, yinc);
% Set the number of iterations for the optimizer
options = optimoptions('fmincon', 'MaxFunctionEvaluations', 60000);
% Run optimizer using the prescribed options
[minconc, minenergy] = fmincon(minfun, conc,[],[],[],[],conc*0,[], [], options)
% Here the funtion minimized is the regionenergy function
% The constants are used from the constants array
% The constraint on the solution is that it should be greater than 0

% Generate a plot of the water and plant concentration in the region
figure;
subplot(2,2,1)
hold on
xgrid = xmin+xinc/2:xinc:xmax-xinc/2;
ygrid = ymin+yinc/2:yinc:ymax-yinc/2;
surf(xgrid, ygrid, minconc(:,:,1))
surf(xgrid, ygrid, minconc(:,:,2))
hold off
title('Surface Plot of the Minimizing Concentrations')
subplot(2,2,2)
contour(xgrid, ygrid, minconc(:,:,1))
title('Contour Plot of the Minimizing Plant Concentration')
subplot(2,2,3)
hold on
xgrid = xmin+xinc/2:xinc:xmax-xinc/2;
ygrid = ymin+yinc/2:yinc:ymax-yinc/2;
surf(xgrid, ygrid, conc(:,:,1))
surf(xgrid, ygrid, conc(:,:,2))
hold off
title('Surface Plot of the Initial Concentrations')
subplot(2,2,4)
contour(xgrid, ygrid, conc(:,:,1))
title('Contour Plot of the Initial Plant Concentration')

%bar3(minconc(:,:,1))
