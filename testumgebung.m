clear all
close all
A = xlsread('VonUnibisRatio.xlsx','Tabelle4');
x=A(1:10:end,1);
y=A(1:10:end,2);

s = street(x,y,.02);
umgebung = Umgebung(s);
umgebung = umgebung.putObject('baum',1842,1250,'Standing','Pedestrian','Unknown');
umgebung = umgebung.putObject('leitplanke',83,157,'Standing','Pedestrian','Unknown');
umgebung = umgebung.putObject('leitplanke',257,446,'Standing','Pedestrian','Unknown');
umgebung = umgebung.putObject('leitplanke',1570,1293,'Standing','Pedestrian','Unknown');


[rand1,rand2] = s.getRandomPoints(20,6,7);

[~, x, y, xr, yr, xl, yl] = s.getRouting(4);
SMPC = Sensorik(70,23,0.01); %Sensorobjekt hinzufügen
RADAR = Sensorik(240,9,0.01); %Sensorobjekt hinzufügen
[x2,y2,x1,y1,zx2,zy2,zx1,zy1] = SMPC.Sensordarstellung(); % Kreisbogen erstellen
[x22,y22,x12,y12,zx22,zy22,zx12,zy12] = RADAR.Sensordarstellung();
kreisplot = plot (x1,y1,'r',x2,y2,'r',zx1,zy1,'r',zx2,zy2,'r',x12,y12,'b',x22,y22,'b',zx12,zy12,'b',zx22,zy22,'b'); % kreisbogen plotten

axis([-50 50 0 260]);


 uistack(kreisplot) %kreisbogen in den Vordergrund
  uistack(kreisplot)%kreisbogen in den Vordergrund
    uistack(kreisplot)%kreisbogen in den Vordergrund
    
for i = 1:10000
  curr=s.getPosition2D(); % aktuelle Position
  ver=Nullverschiebung(curr(1),curr(2),xr,yr,xl,yl,s.getFrame()); %Klasse aufrufen
  [xr_new,yr_new,xl_new,yl_new] = ver.centerStreet(100); % neue Straße ermitteln (Koordinaten)
  [obj_newx,obj_newy] = ver.centerOther(umgebung.koordinatenarray(:,1),umgebung.koordinatenarray(:,2)); %neue Objekte ermitteln (Koordinaten)
  [x_det,y_det] = SMPC.detection(obj_newx,obj_newy); %detection
  [x_det2,y_det2] = RADAR.detection(obj_newx,obj_newy); %detection
  hold on
  hplot = plot(xl_new,yl_new,'g',xr_new,yr_new,'g',obj_newx,obj_newy,'r*',x_det,y_det,'bx',x_det2,y_det2,'bx'); % plot

 uistack(kreisplot) %kreisbogen in den Vordergrund
   uistack(kreisplot)%kreisbogen in den Vordergrund
    uistack(kreisplot)%kreisbogen in den Vordergrund
 

  axis([-50 50 0 260]);
  drawnow; 
  delete(hplot);

  s=s.step(1);
end
    
    
