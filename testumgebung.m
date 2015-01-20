clear all
close all
A = xlsread('VonUnibisRatio.xlsx','Tabelle4');
x=A(1:10:end,1);
y=A(1:10:end,2);


s = Street(x,y,.01);
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

  winkel = -s.getRotation()-pi/2;
  curr=s.getPosition2D(); % aktuelle Position

  ver=Nullverschiebung(curr(1),curr(2),xr,yr,xl,yl,s.getFrame(),winkel); %Klasse aufrufen
  [xr_new,yr_new,xl_new,yl_new] = ver.centerStreet(200); % neue Straße ermitteln (Koordinaten)


  [obj_newx,obj_newy] = ver.centerOther(umgebung.koordinatenarray(:,1),umgebung.koordinatenarray(:,2)); %neue Objekte ermitteln (Koordinaten)
  [x_det,y_det] = SMPC.detection(obj_newx,obj_newy); %detection
  [x_det2,y_det2] = RADAR.detection(obj_newx,obj_newy); %detection
  hold on
  
  varPhi=0.1*pi/180;
  varR=0.3;
  j=1;
  k=1;
  c1=get_cov(10,10);
  c2=get_cov(8,8);
  cplot(j) = plot(0,0);
  cplot2(k) = plot(0,0);
  if length(x_det) >= 1
  if det_prop(0.5)==1
      for j=1:1:length(x_det)
        cplot(j) =  draw_ellipse([x_det(j);y_det(j)],c1,'r','r');
      end
  end
  end
  if length(x_det2) >= 1
      if det_prop(0.5)==1
          for k=1:1:length(x_det2)
          [phic2,rc2]=cart2pol(x_det2(k),y_det2(k));
          c2=get_covP(rc2,phic2,varPhi,varR);
          cplot2(k) = draw_ellipse([x_det2(k);y_det2(k)],c2,'b','b');
          end
      end
  end
  
  hplot = plot(xl_new,yl_new,'g',xr_new,yr_new,'g',obj_newx,obj_newy,'r*',x_det,y_det,'bx',x_det2,y_det2,'bx'); % plot
  set(gca,'XDir','reverse');
 uistack(kreisplot) %kreisbogen in den Vordergrund
   uistack(kreisplot)%kreisbogen in den Vordergrund
    uistack(kreisplot)%kreisbogen in den Vordergrund
 

axis([-75 75 0 500]);
    koo = umgebung.getCoords();
    g.placeNodes2(koo(:,1),koo(:,2));
    car.translation = s.getPosition3D();
    car.rotation = [0 -1 0 s.getRotation()];
    RadVR.rotation = [0 0 1 -s.getWheelRotation()];
    RadHR.rotation = [0 0 1 -s.getWheelRotation()];
    RadVL.rotation = [0 0 1 -s.getWheelRotation()];
    RadHL.rotation = [0 0 1 -s.getWheelRotation()];
    drawnow;    
    vrdrawnow;
    
   
    delete(hplot);
    delete(cplot);
    delete(cplot2);
    
    s=s.step(1);
   
end
    
    
