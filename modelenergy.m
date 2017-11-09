function f = modelenergy(vars, constants, xinc, yinc, xnum, ynum)
% Split up the concentration matrix into its two parts
uconc = vars(:,:,1);
wconc = vars(:,:,2);
penergy = vars(:,:,3);

% Calculate the value of the energy function at each grid point

% Shift function that shifts each value of interest to index 2,2
% consequence of periodic boundary condition
shift = @(mat, index, xnum) circshift(mat, [2-floor(index/xnum),2-rem(index,xnum)]);

% Use each shifted matrix and calculate the energy at the grid points and scale by the area of region 

index = reshape(1:xnum*ynum,[xnum, ynum]);
gridenergies = arrayfun(@(i) energycalc(shift(uconc, i, xnum), shift(wconc, i, xnum), shift(penergy, i, xnum), constants, xinc, yinc), index)/(xinc*yinc);

% Calculate the total energy in the region
f = sum(sum(gridenergies));
end

function f = energycalc(umat, wmat, emat, constants, xinc, yinc)
% Constants corresponding to stored values in the constants array
c1 = constants(1);
c2 = constants(2);
c3 = constants(3);
c4 = constants(4);
c5 = constants(5);
c6 = constants(6);
c7 = constants(7);
c8 = constants(8);
a = constants(9);
K = constants(10);
% The required values from the matrix
u12 = umat(1,2);
u32 = umat(3,2);
u21 = umat(2,1);
u23 = umat(3,1);
u22 = umat(2,2);
w22 = wmat(2,2);
e12 = emat(1,2);
e32 = emat(3,2);
e21 = emat(2,1);
e23 = emat(3,1);
e22 = emat(2,2);
% Energy equation from the proposed model
lapu = ((u12+u32+u21+u23-4*u22)/(xinc*yinc));
lape = ((e12+e32+e21+e23-4*e22)/(xinc*yinc));
divudive = (u32-u12)*(e32-e12)/(4*xinc^2)+(u23-u21)*(e23-e21)/(4*yinc^2);
fp = (a/2)*((c1+c2*u22+c3*(u22^2)+c4*u22*w22)^2)+((1-a)/2)*((c5+c6*u22+c7*w22+c8*u22*w22)^2);

f = (fp + K * (e22*lapu + 2*divudive + u22*lape))^2;
end



