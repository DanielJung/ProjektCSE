
clear all
close all
A = xlsread('VonUnibisRatio.xlsx','Tabelle4');
x=A(1:10:end,1);
y=A(1:10:end,2);


 s = street(x,y,.01);
[~, x, y, xr, yr, xl, yl] = s.getRouting(4);
[xzuf,yzuf] = s.getRandomPoints(500,100,100);
%plot(x,y,'r',xr,yr,'g',xl,yl,'b');

%placetrees2(xzuf,yzuf);
%puttrees2(xzuf,yzuf);

g= graphics('ratiouni3D3',0,x,y,.01);
g.openWorld();
%g.placeNodes2(xzuf,yzuf);
g.movecar('Mercedes_S');
