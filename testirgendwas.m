clc, clear;

A = xlsread('VonUnibisRatio.xlsx','Tabelle3');
x=A(50:60,1);
y=A(50:60,2);

x1 = [0, 2, 3, 1, 3, 1.5, 0]*5;
y1 = [0, 2, 1, -1, -1.5, 0.5, 2]*5;


 s = street(x1,y1,0.001);
[~, x, y, xr, yr, xl, yl] = s.getRouting(0.1);
[a, b] = s.getRandomPoints(6, 0.1, 0.2);

ax = zeros(s.numSteps, 1);
ay = zeros(s.numSteps, 1);

for i=1:s.numSteps
    s = s.step(1);
    tmp =  s.getPosition2D();
    ax(i, 1) = tmp(1);
    ay(i, 1) = tmp(2);
end

plot(x, y, ax, ay);
%plot(x,y,'r',xr,yr,'g',xl,yl,'b')
%plot(x1, y1, 'O', x, y, a, b, 'O');