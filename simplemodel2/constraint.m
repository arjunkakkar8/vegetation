function [c,ceq] = constraint(conc, g, constants, xinc, yinc)
% Constants corresponding to stored values in the constants array
c0 = constants(1);
c1 = constants(2);
c2 = constants(3);
c3 = constants(4);
c4 = constants(5);
% The five required values from the matrix
u12 = circshift(conc, [1,0]);
u32 = circshift(conc, [-1,0]);
u21 = circshift(conc, [0,1]);
u23 = circshift(conc, [0,-1]);
% Energy equation from the proposed model
e = conc.*(-c2.*((u32-u12).^2)/(4*yinc.^2)-c2.*((u23-u21).^2)/(4*xinc.^2)+c0 - c1.*conc-c3.*g)-c4;
ceq = sum(sum(e.^2));
c =[];
end