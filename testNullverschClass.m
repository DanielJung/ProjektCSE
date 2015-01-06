%SensorClassTest_2
clear all
close all
clc
x = [0, 2, 3, 1, 3, 1.5, 0];
y = [0, 2, 1, -1, -1.5, 0.5, 2];
obj_x = [1,1.5,1.5,2.5,0,2,2,1.5,2];
obj_y = [0.5,1,2,1.5,0.5,0.5,-0.5,-1,0];

numst = 6/0.001;
s=street(x,y,0.001);
[~, x, y, xr, yr, xl, yl] = s.getRouting(0.4);

[x2,y2,x1,y1,zx2,zy2,zx1,zy1]=kreisausschnitt(2.2,23,0.1);
kreisplot = plot (0,0,'g*',x1,y1,'r*',x2,y2,'r*',zx1,zy1,'r*',zx2,zy2,'r*');
axis([-3 3 0 3]);
  uistack(kreisplot) 
   uistack(kreisplot)
    uistack(kreisplot)

for i = 1:10000
  curr=s.getPosition2D();
  ver=Nullverschiebung(curr(1),curr(2),xr,yr,xl,yl,s.getFrame());
  [xr_new,yr_new,xl_new,yl_new] = ver.centerStreet(1000);
  [obj_newx,obj_newy] = ver.centerOther(obj_x,obj_y);
  [x_det,y_det] = detection2(obj_newx,obj_newy,x1,y1,zx1,zy1);
 
  hold on
  hplot = plot(xl_new,yl_new,'g*',xr_new,yr_new,'g*',obj_newx,obj_newy,'r*',x_det,y_det,'bx');

 uistack(kreisplot) 
   uistack(kreisplot)
    uistack(kreisplot)

  axis([-3 3 0 3]);
  drawnow;
  delete(hplot);

  s=s.step(5);
end





