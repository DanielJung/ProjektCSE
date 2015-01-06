

A = xlsread('VonUnibisRatio.xlsx','Tabelle3');
x=A(1:10:end,1);
y=A(1:10:end,2);


 s = street(x,y,0.001);
[~, x, y, xr, yr, xl, yl] = s.getRouting(4);
plot(x,y,'r*',xr,yr,'g',xl,yl,'b')
