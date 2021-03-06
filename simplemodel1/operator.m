function f = operator(conc, g, constants, xinc, yinc)
% Constants corresponding to stored values in the constants array
c0 = constants(1);
c1 = constants(2);
c2 = constants(3);
c3 = constants(4);
% The five required values from the matrix
u12 = circshift(conc, [1,0]);
u32 = circshift(conc, [-1,0]);
u21 = circshift(conc, [0,1]);
u23 = circshift(conc, [0,-1]);
% u02 = circshift(conc, [2,0]);
% u42 = circshift(conc, [-2,0]);
% u20 = circshift(conc, [0,2]);
% u24 = circshift(conc, [0,-2]);
% Energy equation from the proposed model
e = (conc.^2).*((-c2.*((u32-u12).^2)/(4*yinc.^2)-c2.*((u23-u21).^2)/(4*xinc.^2)+c0 - c1.*conc-c3.*g).^2);
% Calculate the total energy in the region
f = sum(sum(e));
% Calculate the gradient at each point
%g = 4*c1*conc.^3-2*c0*conc+c2*(2*conc-u02-u42)/(2*yinc.^2)+c2*(2*conc-u20-u24)/(2*xinc.^2);
end