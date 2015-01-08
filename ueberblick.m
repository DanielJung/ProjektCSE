

A = xlsread('VonUnibisRatio.xlsx','Tabelle4');
x=A(1:10:end,1);
y=A(1:10:end,2);


 s = street(x,y,.01);
[~, x, y, xr, yr, xl, yl] = s.getRouting(4);
%plot(x,y,'r',xr,yr,'g',xl,yl,'b');

g= graphics('ratiouni3D',0,x,y,.01);
g.openWorld();
g.movecar('Mercedes_S');