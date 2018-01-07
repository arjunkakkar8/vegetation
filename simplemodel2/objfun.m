function [f, grad] = objfun(conc)
%f=-sum(sum(conc));
%grad=-ones(size(conc));
grad=-ones(size(conc)).*0;
f=0;
end