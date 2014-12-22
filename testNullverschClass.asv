%SensorClassTest_2
clear all
close all
clc
x = [0, 2, 3, 1, 3, 1.5, 0];
y = [0, 2, 1, -1, -1.5, 0.5, 2];
obj_x = 1:.01:1.5;
obj_y = linspace(1,1,length(obj_x));

numst = 6/0.001;
s=street(x,y,0.001);
[~, x, y, xr, yr, xl, yl] = s.getRouting(numst, 0.4);



for i = 1:7000-1
  curr=s.getPosition2D();
  ver=Nullverschiebung(curr(1),curr(2),xr,yr,xl,yl,s.getFrame());
  [xr_new,yr_new,xl_new,yl_new] = ver.centerStreet(800);
  [obj_newx,obj_newy] = ver.centerOther(obj_x,obj_y);
  hplot = plot(xl_new,yl_new,'b*',xr_new,yr_new,'g*',obj_newx,obj_newy,'r*');
  axis([-2 2 0 2]);
  drawnow;
  %delete(hplot);

  s=s.step(10);
end





