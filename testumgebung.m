clear all
close all
A = xlsread('VonUnibisRatio.xlsx','Tabelle4');
x=A(1:10:end,1);
y=A(1:10:end,2);


s = street(x,y,.01);
umgebung = Umgebung(s);
umgebung = umgebung.putObject('baum',1842,1250,'Standing','Pedestrian','Unknown');
umgebung = umgebung.putObject('leitplanke',83,157,'Standing','Pedestrian','Unknown');
umgebung = umgebung.putObject('leitplanke',257,446,'Standing','Pedestrian','Unknown');
umgebung = umgebung.putObject('leitplanke',1570,1293,'Standing','Pedestrian','Unknown');
umgebung = umgebung.putRandomObject(40,10,10);

[rand1,rand2] = s.getRandomPoints(20,6,7);

  g= graphics('ratiouni3D3',0,x,y,.01);
  world = vrworld('ratiouni3D3');
  g.openWorld();
    car = vrnode(world,'Mercedes_S');
       RadVR = vrnode(world,'Rad_vr');
       RadHR = vrnode(world,'Rad_hr');
       RadVL = vrnode(world,'Rad_vl');
       RadHL = vrnode(world,'Rad_hl');
  vrdrawnow;

[~, x, y, xr, yr, xl, yl] = s.getRouting(4);
SMPC = Sensorik(70,23,0.01); %Sensorobjekt hinzufï¿½gen
RADAR = Sensorik(240,9,0.01); %Sensorobjekt hinzufï¿½gen
[x2,y2,x1,y1,zx2,zy2,zx1,zy1] = SMPC.Sensordarstellung(); % Kreisbogen erstellen
[x22,y22,x12,y12,zx22,zy22,zx12,zy12] = RADAR.Sensordarstellung();
kreisplot = plot (x1,y1,'r',x2,y2,'r',zx1,zy1,'r',zx2,zy2,'r',x12,y12,'b',x22,y22,'b',zx12,zy12,'b',zx22,zy22,'b'); % kreisbogen plotten

axis([-75 75 0 500]);
set(gca,'XDir','reverse');
  
 uistack(kreisplot) %kreisbogen in den Vordergrund
  uistack(kreisplot)%kreisbogen in den Vordergrund
    uistack(kreisplot)%kreisbogen in den Vordergrund
     
    
for i = 1:10000
<<<<<<< HEAD
  winkel = -s.getRotation()-pi/2;
  curr=s.getPosition2D(); % aktuelle Position
  ver=Nullverschiebung(curr(1),curr(2),xr,yr,xl,yl,s.getFrame(),winkel); %Klasse aufrufen
  [xr_new,yr_new,xl_new,yl_new] = ver.centerStreet(200); % neue Straße ermitteln (Koordinaten)
=======
  curr=s.getPosition2D();
  curr_rand= s.getRightLimit();                         % aktuelle Position
  ver=Nullverschiebung(curr(1),curr(2),xr,yr,xl,yl,s.getFrame(),curr_rand(1),curr_rand(2)); %Klasse aufrufen
  [xr_new,yr_new,xl_new,yl_new] = ver.centerStreet(100); % neue Straï¿½e ermitteln (Koordinaten)
>>>>>>> 412424de59bceb158b6ce765f992956958a65122
  [obj_newx,obj_newy] = ver.centerOther(umgebung.koordinatenarray(:,1),umgebung.koordinatenarray(:,2)); %neue Objekte ermitteln (Koordinaten)
  [x_det,y_det] = SMPC.detection(obj_newx,obj_newy); %detection
  [x_det2,y_det2] = RADAR.detection(obj_newx,obj_newy); %detection
  hold on
  hplot = plot(xl_new,yl_new,'g',xr_new,yr_new,'g',obj_newx,obj_newy,'r*',x_det,y_det,'bx',x_det2,y_det2,'bx'); % plot
  set(gca,'XDir','reverse');
 uistack(kreisplot) %kreisbogen in den Vordergrund
   uistack(kreisplot)%kreisbogen in den Vordergrund
    uistack(kreisplot)%kreisbogen in den Vordergrund
 

axis([-75 75 0 500]);
    koo = umgebung.getCoords()
    g.placeNodes2(koo(:,1),koo(:,2));
    car.translation = s.getPosition();
    car.rotation = [0 -1 0 s.getRotation()];
    RadVR.rotation = [0 0 1 -s.getRadRotation()];
    RadHR.rotation = [0 0 1 -s.getRadRotation()];
    RadVL.rotation = [0 0 1 -s.getRadRotation()];
    RadHL.rotation = [0 0 1 -s.getRadRotation()];
    drawnow;    
    vrdrawnow;
    
   
    delete(hplot);
    s=s.step(1);
   
end
    
    
