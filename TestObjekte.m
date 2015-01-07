
clear all
close all
clc
x = [0, 2, 3, 1, 3, 1.5, 0];
y = [0, 2, 1, -1, -1.5, 0.5, 2];
% obj_x = [1,1.5,1.5,2.5,0,2,2,1.5,2];
% obj_y = [0.5,1,2,1.5,0.5,0.5,-0.5,-1,0];
[x_baum,y_baum]=umkreisen(0.2,1,0.5);
baum1 = Objekte(10001,x_baum,y_baum,'Pedestrian','Standing', 'Unknown');
s=street(x,y,0.001);
[~, x, y, xr, yr, xl, yl] = s.getRouting(0.4); % Straße erstellen 


sens = Sensorik(2.9,23,0.01); %Sensorobjekt hinzufügen
sens2 = Sensorik(1.5,60,0.01); %Sensorobjekt hinzufügen
[x2,y2,x1,y1,zx2,zy2,zx1,zy1] = sens.Sensordarstellung(); % Kreisbogen erstellen
[x22,y22,x12,y12,zx22,zy22,zx12,zy12] = sens2.Sensordarstellung();
kreisplot = plot (0,0,'g*',x1,y1,'r*',x2,y2,'r*',zx1,zy1,'r*',zx2,zy2,'r*',x12,y12,'r*',x22,y22,'r*',zx12,zy12,'r*',zx22,zy22,'r*'); % kreisbogen plotten
%kreisplot2 = plot (0,0,'g*',x12,y12,'r*',x22,y22,'r*',zx12,zy12,'r*',zx22,zy22,'r*'); % kreisbogen plotten
axis([-3 3 0 3]);
 uistack(kreisplot) %kreisbogen in den Vordergrund
  uistack(kreisplot)%kreisbogen in den Vordergrund
    uistack(kreisplot)%kreisbogen in den Vordergrund
 obj = baum1.getObjPos();

for i = 1:10000
  curr=s.getPosition2D(); % aktuelle Position
  ver=Nullverschiebung(curr(1),curr(2),xr,yr,xl,yl,s.getFrame()); %Klasse aufrufen
  [xr_new,yr_new,xl_new,yl_new] = ver.centerStreet(1000); % neue Straße ermitteln (Koordinaten)
  [obj_newx,obj_newy] = ver.centerOther(obj(1,:),obj(2,:)); %neue Objekte ermitteln (Koordinaten)
  [x_det,y_det] = sens.detection(obj_newx,obj_newy,x1,y1,zx1,zy1); %detection
  [x_det2,y_det2] = sens2.detection(obj_newx,obj_newy,x12,y12,zx12,zy12); %detection
  hold on
  hplot = plot(xl_new,yl_new,'g*',xr_new,yr_new,'g*',obj_newx,obj_newy,'r*',x_det,y_det,'bx',x_det2,y_det2,'bx'); % plot
  

 uistack(kreisplot) %kreisbogen in den Vordergrund
   uistack(kreisplot)%kreisbogen in den Vordergrund
    uistack(kreisplot)%kreisbogen in den Vordergrund
 

  axis([-3 3 0 3]);
  drawnow; 
  delete(hplot);

  s=s.step(15);
end





