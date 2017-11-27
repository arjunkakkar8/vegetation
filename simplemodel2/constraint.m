function [c,ceq] = constraint(conc, g, constants, xinc, yinc, xnum, ynum)
% Constants corresponding to stored values in the constants array
c0 = constants(1);
c1 = constants(2);
c2 = constants(3);
c3 = constants(4);

w = c2.*ones(xnum, ynum);
p = c3.*conc;
%water = max(w - p + max(cumsum(w-p, 2,'reverse'),0),0);
water = cumsum(w-p, 2,'reverse');
ceq = conc.*(c0-c1.*conc-water);
c = -water;
end