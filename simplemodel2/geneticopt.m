function [initial, Chrom, FieldD, SIZE] = geneticopt(initial, Chrom)
% Use the GAToolbox by adding it to your path by specifying its exact
% address in the Github folder.
% addpath('/Users/arjunkakkar/Desktop/Vegetation Patterns/vegetation/genetic')
 addpath('/Users/ak23/vegetation/genetic')

% addAttachedFiles(gcp, {'geneticMSE.m'});
SIZE = [10, 10];
NIND=100;        % Gives the population size
MAXGEN=100000;     % Gives the number of generations
NVAR=SIZE(1).*SIZE(2);% Number of variables
GGAP=1;
PRECI = 10;

%CONSTANTS = [10, 1, 1.5, 2, 10];
%CONSTANTS = [3, 1, 1, 6, 5];

CONSTANTS = [0.4830,0.9396,0.4747,4.0692,0.9760];

FieldD = repmat([PRECI;0;1;0;0;1;1], [1,NVAR]);

% Initial binary population
disp(nargin)
if nargin < 1
    Chrom = crtbp(NIND, NVAR*PRECI);
end
if nargin == 2
    bin = de2bi(round(initial*(2.^PRECI))', 10, 2, 'left-msb');
    disp(bin);
    Chrom = repmat(reshape(bin', [1,NVAR*PRECI]),[NIND,1]);
end

initial = Chrom;

% Initialize generations
gen = 0;

% Evaluate the objective function
ObjV = objfun(bs2rv(Chrom, FieldD), SIZE, CONSTANTS);
% disp(ObjV)
% disp(min(ObjV))

while gen < MAXGEN
    FitnV = ranking(ObjV);
    
    SelCh = select('sus', Chrom, FitnV, GGAP);
    
    SelCh = recombin('xovdp', SelCh, 1);
    
    SelCh = mut(SelCh);
    
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
        for i=1:size(indMat, 1)
            value(i, 1) = geneticobj(indMat(i,:), SIZE, constants);
        end
    end

%     function outmat = bin2dec(inmat, FieldD)
%         
%     end

end