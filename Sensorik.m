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


end
end
