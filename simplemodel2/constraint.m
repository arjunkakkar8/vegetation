function [c,ceq] = constraint(conc, g, constants, xinc, yinc, xnum, ynum)
% Constants corresponding to stored values in the constants array
c0 = constants(1);
c1 = constants(2);
% The five required values from the matrix
% u12 = circshift(conc, [1,0]);
% u32 = circshift(conc, [-1,0]);
% u21 = circshift(conc, [0,1]);
% u23 = circshift(conc, [0,-1]);
% Energy equation from the proposed model
%e = conc.*(-c2.*((u32-u12).^2)/(4*yinc.^2)-c2.*((u23-u21).^2)/(4*xinc.^2)+c0 - c1.*conc-c3.*g);
%ceq = conc.*(-c2.*((u32-u12).^2)/(4*yinc.^2)-c2.*((u23-u21).^2)/(4*xinc.^2)+c0*(ynum-repmat(1:ynum, [xnum,1]))-c1*cumsum(conc, 2, 'reverse'));
ceq = conc.*(c0-c1.*conc-water(conc, constants, xnum, ynum));
%ceq = conc.*(c0-c1.*conc);
c = [];
end

function [aw] = water(conc, constants, xnum, ynum)
c2 = constants(3);
c3 = constants(4);
precipitation = c2.*ones(xnum, ynum);
flow = precipitation - c3.*conc;
for i=0:ynum-2
    nonzero = flow(:,ynum-i)>0;
    flow(:,ynum-i)=flow(:,ynum-i).*nonzero;
    flow(:,ynum-i-1) = flow(:,ynum-i-1)+flow(:,ynum-i);
end
nonzero = flow(:,1)>0;
flow(:,1)=flow(:,1).*nonzero;
aw=flow;
end