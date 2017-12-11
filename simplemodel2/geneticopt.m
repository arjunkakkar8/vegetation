% Use the GAToolbox by adding it to your path by specifying its exact
% address in the Github folder.
addpath('/Users/ak23/vegetation/genetic')
% addAttachedFiles(gcp, {'geneticMSE.m'});
SIZE = [25, 25];
NIND=70;        % Gives the population size
MAXGEN=10000;     % Gives the number of generations
NVAR=SIZE(1).*SIZE(2);% Number of variables
GGAP=1;
PRECI = 16;

CONSTANTS = [1, 1, 1, 3, 3];

FieldD = repmat([PRECI;0;1;1;0;1;1], [1,NVAR]);

% Initial binary population
% Chrom = crtbp(NIND, NVAR*PRECI);

% Initialize generations
gen = 0;

% Evaluate the objective function
ObjV = objfun(bs2rv(Chrom, FieldD), SIZE, CONSTANTS);
disp(ObjV)
disp(min(ObjV))

while gen < MAXGEN
    FitnV = ranking(ObjV);
    
    SelCh = select('sus', Chrom, FitnV, GGAP);
    
    SelCh = recombin('xovdp', SelCh, 1);
    
    SelCh = mut(SelCh,0.00005);
    
    ObjVSel = objfun(bs2rv(SelCh, FieldD), SIZE, CONSTANTS);
    
    [Chrom, ObjV] = reins(Chrom, SelCh, 1, 1, ObjV, ObjVSel);
    
    gen = gen+1;
    disp(gen)
    disp(min(ObjV))
    
    contour(reshape(bs2rv(Chrom(1,:), FieldD), SIZE(1), SIZE(2)))
    drawnow
end

% Function that iterates over the MSE calculation of the population in
% Parallel
function value = objfun(indMat, SIZE, constants)
value = zeros(size(indMat, 1), 1);
parfor i=1:size(indMat, 1)
    value(i, 1) = geneticobj(indMat(i,:), SIZE, constants);
end
end

function outmat = bin2dec(inmat, FieldD)

end

