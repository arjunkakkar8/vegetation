function val = geneticobj(data, size, constants)
% Constants
c0 = constants(1);
c1 = constants(2);
c2 = constants(3);
c3 = constants(4);
c4 = constants(5);

xinc = size(1)/100;
yinc = size(2)/100;

% The plant concentration at gridpoints
u = reshape(data, size(1), size(2));
% Total plant concentration
conc = sum(sum(u));
% Constraints
w = c2.*ones(size(1), size(2));
p = c3.*u;
water = cumsum(w-p, 2,'reverse');
% Calculate the gradient sq of water availability (the root system)
%waterp = padarray(water, [1,1], 'replicate', 'both');
waterp = zeros(size(1)+2, size(1)+2);
waterp(2:end-1, 2:end-1) = water;
waterp(1,:) = waterp(2,:);
waterp(end,:) = waterp(end-1,:);
waterp(:,1) = waterp(:,2);
waterp(:,end) = waterp(:,end-1);
w12 = circshift(waterp, [1,0]);
w32 = circshift(waterp, [-1,0]);
w21 = circshift(waterp, [0,1]);
w23 = circshift(waterp, [0,-1]);
delsqwaterp = ((w32-w12).^2)/(4*yinc.^2)+((w23-w21).^2)/(4*xinc.^2);
delsqwater = delsqwaterp(2:end-1, 2:end-1);

ceq = sum(sum(abs(u.*(c0-c1.*u-water-c4.*delsqwater))));
c = -water;

% Penalty for violating equality constraint
ceqpen = ceq.*1e5;
% Penalty for violating inequality constraint
c = sum(sum(abs(c(c>0))));
cpen = c.*1e7;

% Compose the final goodness value
val = cpen+ceqpen+1/conc;
end