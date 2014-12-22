classdef Sensor
     properties (GetAccess=public)
        s %straﬂe
         
     end
   methods
       function this = Sensor(x,y)
           this.s = street(x,y,0.01);
       end
       function this = plotRouteStationaer(this,numSteps,width)
        [~, x, y, xr, yr, xl, yl] = this.s.getRouting(numSteps, width);  
        plot (x,y)
        hold on
        plot(xl,yl)
        plot(xr,yr) 
       end
       function [x1,y1,x2,y2,g1x,g1y,g2x,g2y,g3x,g3y] = smpcP(this,fahrpunkt,alpha,laenge) 

% smpc data bekommt den Straﬂenverlauf und Lenkwinkel und soll dann Straﬂenr‰nder erkennen
xvorher = fahrpunkt(1);
yvorher = fahrpunkt(2);

y1=yvorher+sin((alpha-23)*pi/180)*laenge;
x1=xvorher+cos((alpha-23)*pi/180)*laenge;
x2=xvorher+cos((alpha+23)*pi/180)*laenge;
y2=yvorher+sin((alpha+23)*pi/180)*laenge;

steigung1 = (y1 - yvorher) / (x1 - xvorher);
steigung2 = (y2 - yvorher) / (x2 - xvorher);
steigung3 = (y2 - y1) / (x2 - x1);

b1 = yvorher-steigung1*xvorher;
b2 = yvorher-steigung2*xvorher;
b3 = y2-steigung3*x2;

deltax1 = x1 - xvorher;
deltax2 = x2 - xvorher;
deltax3 = x2 - x1;
dx1 = deltax1/1000;
dx2 = deltax2/1000;
dx3 = deltax3/1000;

for i= 1:1000
    g1x(1) = xvorher;
    g1y(1)= steigung1 * g1x(1) + b1;
    
    g1x(i+1) = g1x(i) + dx1;
    g1y(i+1) = steigung1 * g1x(i+1) + b1;
    
    
    g2x(1) = xvorher;
    g2y(1)= steigung2 * g2x(1) + b2;
   
    g2x(i+1) = g2x(i) + dx2;
    g2y(i+1) = steigung2 * g2x(i+1) + b2;
    
    g3x(1) = x1;
    g3y(1)= steigung3 * g3x(1) + b3;
   
    g3x(i+1) = g3x(i) + dx3;
    g3y(i+1) = steigung3 * g3x(i+1) + b3;
end
       
       end   
       function this = fahrenlassen(this)
        for i=1:this.s.NumSteps
        this.s = this.s.step(1);

        axis([-1 4 -3 3]);
        [poscurr]=  this.s.getPosition2D();
        alpha =  this.s.getRotation();
        winkeltotal = alpha*180/pi;

        [x1,y1,x2,y2,g1x,g1y,g2x,g2y,g3x,g3y] = this.smpcP(poscurr,winkeltotal,-.6);
        [xneu,yneu] = smpcP1(poscurr,winkeltotal,-.6) ;
        plot(poscurr(1),poscurr(2),'g.');

        h =  plot(x1,y1,'b.',x2,y2,'b.',g1x,g1y,g2x,g2y,g3x,g3y,xneu,yneu);
            drawnow;
            delete(h);
     
  
        end
       end
       function [x1,y1] = smpcP1(this,fahrpunkt,alpha,laenge) 

            x1=zeros(1000,1);
            y1=zeros(1000,1);
            xvorher = fahrpunkt(1);
            yvorher = fahrpunkt(2);
            dphi=23/10000;

            y1(1)=yvorher+sin((alpha-23)*pi/180)*laenge;
            x1(1)=xvorher+cos((alpha-23)*pi/180)*laenge;
            for i= 1:10000

            y1(i+1)=yvorher+sin((alpha+i*dphi)*pi/180)*laenge;
            x1(i+1)=xvorher+cos((alpha+i*dphi)*pi/180)*laenge;

            end
   end
   end
end