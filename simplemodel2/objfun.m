function [f, grad] = objfun(conc)
f=-sum(sum(conc));
grad=-ones(size(conc));
end