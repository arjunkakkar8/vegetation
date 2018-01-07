function [c,ceq] = constraint(conc, constants, xinc, yinc, xnum, ynum)
% Constants corresponding to stored values in the constants array
c0 = constants(1);
c1 = constants(2);
c2 = constants(3);
c3 = constants(4);
c4 = constants(5);

w = c2.*ones(xnum, ynum);
p = c3.*conc;
%water = max(w - p + max(cumsum(w-p, 2,'reverse'),0),0);
water = cumsum(w-p, 2,'reverse');
% Calculate the gradient sq of water availability (the root system)
waterp = padarray(water, [0,1], 'replicate', 'both');
% waterp = zeros(xnum+2, ynum+2);
% waterp(2:end-1, 2:end-1) = water;
% waterp(1,:) = waterp(2,:);
% waterp(end,:) = waterp(end-1,:);
% waterp(:,1) = waterp(:,2);
% waterp(:,end) = waterp(:,end-1);
w12 = circshift(waterp, [1,0]);
w32 = circshift(waterp, [-1,0]);
w21 = circshift(waterp, [0,1]);
w23 = circshift(waterp, [0,-1]);
delsqwaterp = (w32+w12-2.*waterp)/(4*yinc.^2)+(w23+w21-2.*waterp)/(4*xinc.^2);
delsqwater = delsqwaterp(1:end, 2:end-1);
% Constraints
ceq = conc.*(c0-c1.*conc-water-c4.*delsqwater);
c = -water;
end