classdef Nullverschiebung
     properties (GetAccess=public)
       x_curr % Momentanposition Auto X
       y_curr % Momentanposition Auto Y
       x_bezug % Bezugspunkt (rechter stra�enrand) X
       y_bezug % Bezugspunkt (rechter stra�enrand) Y
       frame % bei welchem frame es gerade ist
       xr  %Stra�e rechts X
       yr   %Stra�e rechts Y
       xl   %Stra�e links X
       yl   %Stra�e links Y
         
     end
   methods
       function this = Nullverschiebung(x_curr,y_curr,xr,yr,xl,yl,frame,xbez,ybez)
           this.x_curr = x_curr;
           this.y_curr = y_curr;
           this.xr = xr;
           this.yr = yr;
           this.xl = xl;
           this.yl = yl;
           this.frame = frame;
           [this.x_bezug,this.y_bezug] = this.getShift(x_curr,y_curr,xbez,ybez);
       
           
       end
       
       
       function  [x_new,y_new] = getShift(this,x_curr,y_curr,x,y)
            %% VERSCHIEBUNG
              % x_new ist nur die Verschiebung ohne Drehung

            x_new = zeros(length(x),1);
            y_new = zeros(length(x),1);
         
             
            for i=1:length(x)
            x_new(i) = x(i) - x_curr;
            y_new(i) = y(i) - y_curr;
            end
      
      end
       
      function [x_gedr,y_gedr] = getSystemrotation(this,x_bezug,y_bezug,x,y)
        %% Drehung des Systems um einen Bezugswinkel 
               % Bezugswinkel definiert als Winkel zw. Bezugspunkt und
               % x-Achse
               
               x_gedr = zeros(length(x),1);
               y_gedr = zeros(length(x),1);
               
               alpha1 = -atan2(y_bezug,x_bezug); %Bezugswinkel
               
               R1 = [cos(alpha1),-sin(alpha1);sin(alpha1),cos(alpha1)]; %Rotationsmatrix
               
               for i = 1: length(x)
                    a=(R1*([x(i);y(i)]))';          % Ermittlung gedrehter Koordinaten
                    x_gedr(i) =  a(1);          
                    y_gedr(i) =  a(2);
               end
      
      end
       
      function [xr_gedr,yr_gedr,xl_gedr,yl_gedr] = centerStreet(this,n)
         % n = anzahl der berechneten Stra�enpunkte
          
          %%Vektoren erstellen
            xl_new = zeros(n,1);
            yl_new = zeros(n,1);
            xr_new = zeros(n,1);
            yr_new = zeros(n,1);
            xl_gedr = zeros(n,1);
            yl_gedr = zeros(n,1);
            xr_gedr = zeros(n,1);
            yr_gedr = zeros(n,1);
            
            
            
            for i = 2:n
    
                [xl_new(i),yl_new(i)] = this.getShift(this.x_curr,this.y_curr,this.xl(this.frame+i-1),this.yl(this.frame+i-1));
                [xr_new(i),yr_new(i)] = this.getShift(this.x_curr,this.y_curr,this.xr(this.frame+i-1),this.yr(this.frame+i-1));
                [xl_gedr(i),yl_gedr(i)] = this.getSystemrotation(this.x_bezug,this.y_bezug,xl_new(i),yl_new(i));
                [xr_gedr(i),yr_gedr(i)] = this.getSystemrotation(this.x_bezug,this.y_bezug,xr_new(i),yr_new(i));
           end
        
      
      end
      function bezug = getBezug(this)
                bezug = [this.x_bezug;this.y_bezug];
      end
      function [x_neu,y_neu] = centerOther (this,x_oth,y_oth)
         % Vektoren definieren
         x_neu = zeros(length(x_oth),1);
         y_neu = zeros(length(x_oth),1);
         x_temp = zeros(length(x_oth),1);
         y_temp = zeros(length(x_oth),1);
         
          for i=1:length(x_oth)
              [x_temp(i),y_temp(i)] = this.getShift(this.x_curr,this.y_curr,x_oth(i),y_oth(i));
              [x_neu(i),y_neu(i)] = this.getSystemrotation(this.x_bezug,this.y_bezug,x_temp(i),y_temp(i));       
          end
          
      end
       
   end
end

