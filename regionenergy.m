function f = regionenergy(conc, constants, xinc, yinc)
% Split up the concentration matrix into its two parts
uconc = conc(:,:,1);
wconc = conc(:,:,2);
% Calculate the value of the energy function at each grid point
gridenergies = arrayfun(@(u, w) energyfun(u, w, constants), uconc, wconc)/(xinc*yinc); 
% Calculate the total energy in the region
f = sum(sum(gridenergies));
end