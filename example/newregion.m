function f = newregion(conc, constants, xinc, yinc, xnum, ynum)
index = reshape(1:xnum*ynum,[xnum, ynum]);
% Calculate the value of the energy function at each grid point
gridenergies = arrayfun(@(i) newenergy(circshift(conc, [2-floor(i/xnum),2-rem(i,xnum)]), constants, xinc, yinc), index)/(xinc*yinc); 
% Calculate the total energy in the region
f = sum(sum(gridenergies));
end

function f = newenergy(umat, constants, xinc, yinc)
% Constants corresponding to stored values in the constants array
c0 = constants(1);
c1 = constants(2);
% The five required values from the matrix
u12 = umat(1,2);
u32 = umat(3,2);
u21 = umat(2,1);
u23 = umat(3,1);
u22 = umat(2,2);
% Energy equation from the proposed model
f = ((u32-u12)^2)/(4*xinc^2)+((u23-u21)^2)/(4*yinc^2)-c0*u22^2+c1*u22^4;
end