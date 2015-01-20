classdef Sensorik
     properties (GetAccess=public)
       laenge
       oeffnungswinkel
       schrittweite
    
     end
   methods
       
function this = Sensorik(laenge,oeffnungswinkel,schrittweite)
            this.laenge = laenge;
            this.oeffnungswinkel = oeffnungswinkel;
            this.schrittweite = schrittweite;
           
        end
function [x2,y2,x1,y1,zx2,zy2,zx1,zy1]=  Sensordarstellung(this);
        %% zx2,zy2,zx1,zy1 Kreisausschnitt ohne "Deckel" 
        %% x2,y2,x1,y1   Kreissegmentkoordninaten


        %% Leere Vektoren erstellen
        y1=zeros(this.oeffnungswinkel/this.schrittweite,1);
        y2=zeros(this.oeffnungswinkel/this.schrittweite,1);
        x1=zeros(this.oeffnungswinkel/this.schrittweite,1);
        x2=zeros(this.oeffnungswinkel/this.schrittweite,1);
        zy1=zeros(this.laenge/this.schrittweite,1);
        zx1=zeros(this.laenge/this.schrittweite,1);
        zx2=zeros(this.laenge/this.schrittweite,1);
        zy2=zeros(this.laenge/this.schrittweite,1);


         %% Kreissegmentkoordinaten berechnen
         j=1;
        for i= 0:this.schrittweite:this.oeffnungswinkel
        y1(j)=sin((90-i)*pi/180)*this.laenge;
        x1(j)=cos((90-i)*pi/180)*this.laenge;
        x2(j)=-cos((90-i)*pi/180)*this.laenge;
        y2(j)=sin((90-i)*pi/180)*this.laenge;
        j=j+1;
        end
        v=1;

        %% Dreieck berechnen  (ohne Kreissegment)
        for u=0:this.schrittweite:this.laenge
        zy1(v)=sin((90-this.oeffnungswinkel)*pi/180)*u;
        zx1(v)=cos((90-this.oeffnungswinkel)*pi/180)*u;
        zx2(v)=-cos((90-this.oeffnungswinkel)*pi/180)*u;
        zy2(v)=sin((90-this.oeffnungswinkel)*pi/180)*u;    
        v=v+1;
        end
        

        end
function [x_det,y_det] = detection(this,obj_x,obj_y)
%% Detektionsvektor erstellen
x_det = zeros(length(obj_x),1);
y_det = zeros(length(obj_y),1);
 

[obj_phi,obj_r] = cart2pol(obj_x,obj_y);

obj_phi = obj_phi.*180./pi;

z=1;
for i = 1:length(obj_x)
if (obj_r(i) <= this.laenge) && (abs(90-obj_phi(i))<= this.oeffnungswinkel)
    
   [x_det(z),y_det(z)] = pol2cart(obj_phi(i)*pi/180,obj_r(i));
   z=z+1;
   
end


 x_det =  x_det(1:z-1); 
 y_det =  y_det(1:z-1);  
end

end
function det= det_prop(x)
   %Funktion liefert Boolean ob Objekt detektiert oder nicht.
  
   detection=rand(1,1);
   if detection <=x
       % detection succesful
       det = 1;
   end
   if detection >x
       % detection failed
       det = 0;
   end
       
end 

function [sigma_x,sigma_y]= var_sens(x,Sens)
    %Funktion bekommt Abstand x und Sensorname und liefert die Varianzen
    %ACHTUNG !!Ausgabe von SMPC in kartesischen Koordinaten, von Radar und Lidas
    %Polarkoordinaten!!!
  if STRCMP(Sens, 'SMPC') == 1
  smpc_x = @(x) ( 1 / sqrt ( 5 ) ) * 0.2 / ( 0.2 * 1600 ) * x^2;
  smpc_y = @(x) 5.5/1600*x;
  sigma_x= smpc_x(x);
  sigma_y= smpc_y(x);
  end
  
  if STRCMP(Sens, 'SMPC-LR') == 1
  smpc_LR_x = @(x) 1/sqrt(10)*0.2/(0.2 * 1600) * x^2;
  smpc_LR_y = @(x) 0.00125*x;
  sigma_x= smpc_LR_x(x);
  sigma_y= smpc_LR_y(x);
  end
  
  if STRCMP(Sens, 'RADAR') == 1
  radar_x = 0.3;
  radar_y = 0.1*pi/180; 
  sigma_x= radar_x(x);
  sigma_y= radar_y(x);
  end
  
  if STRCMP(Sens, 'LIDAR') == 1
  lidar_x =  0.2;
  lidar_y =  0.15*pi/180;
  sigma_x= lidar_x(x);
  sigma_y= lidar_y(x);
  end
  
 
  
    
    
function [c] = get_cov(sigma_x,sigma_y)

c = [sigma_x^2,0; 0, sigma_y^2];


end
function [var_kar] = get_covP(R,Phi,varPhi,varR)
% Liefert Kovarianzmatrix von r,phi in x,y

% % syms varR varPhi covRPhi real
% % syms R Phi real
% % x_t = [R*cos(Phi);R*sin(Phi)];
% % 
% % P = [ varR, 0; 0, varPhi ];
% % J = jacobian(x_t, [ R, Phi]);
% % var_kar = J * P * J';


var_kar = ...
[                 varPhi*R^2*sin(Phi)^2 + varR*cos(Phi)^2, - varPhi*cos(Phi)*sin(Phi)*R^2 + varR*cos(Phi)*sin(Phi); ...
 - varPhi*cos(Phi)*sin(Phi)*R^2 + varR*cos(Phi)*sin(Phi),                 varPhi*R^2*cos(Phi)^2 + varR*sin(Phi)^2];



end

end
   end

   
end
