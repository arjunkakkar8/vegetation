function f = energyfun(u, w, constants)
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
% Energy equation from the proposed model
f=(a/2)*((c1+c2*u+c3*(u^2)+c4*u*w)^2)+((1-a)/2)*((c5+c6*u+c7*w+c8*u*w)^2);
end