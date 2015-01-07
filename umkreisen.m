function [x_kreis,y_kreis] =  umkreisen(radius,xmitte,ymitte)


% radius=2;
% xmitte=5;
% ymitte=1;
 
phi=1:20:360;
phi=phi./180.*pi;
[xtmp,ytmp] = pol2cart(phi,radius); 
x_kreis=xtmp+xmitte;
y_kreis=ytmp+ymitte;
 
end