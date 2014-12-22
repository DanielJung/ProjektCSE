function [x1,y1,x2,y2,g1x,g1y,g2x,g2y,g3x,g3y] = smpcP(fahrpunkt,alpha,laenge) 

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
%plot(fahrpunkt(1,1),fahrpunkt(1,2),'g.',x1,y1,'g.',x2,y2,'g.');