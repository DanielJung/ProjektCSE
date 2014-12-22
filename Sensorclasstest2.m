%SensorClassTest_2
clear all
close all
clc
x = [0, 2, 3, 1, 3, 1.5, 0];
y = [0, 2, 1, -1, -1.5, 0.5, 2];
numst = 6/0.001;
s=street(x,y,0.001);
frame=1;
[~, x, y, xr, yr, xl, yl] = s.getRouting(numst, 0.4);



for i = 1:7000-1
 curr=s.getPosition2D();
[x_curr,y_curr,xl_new,yl_new,xr_new,yr_new] =getcurrStreet(xl,yl,xr,yr,curr(1),curr(2),frame,2000);   
hplot = plot(x_curr,y_curr,'r*',xl_new,yl_new,'b*',xr_new,yr_new,'g*');
axis([-2 2 0 2]);
drawnow;
delete(hplot);

s=s.step(4);
frame = frame+4;
end
[x_curr,y_curr,xl_new,yl_new,xr_new,yr_new] =getcurrStreet(xl,yl,xr,yr,curr(1),curr(2),frame,1000);



plot(x_curr,y_curr,'r*',xl_new,yl_new,'b*',xr_new,yr_new,'g*')
axis([-3 4 0 4]);
