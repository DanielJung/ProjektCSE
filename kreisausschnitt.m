%% Kreisausschnitt plotten
function [x2,y2,x1,y1,zx2,zy2,zx1,zy1]=  kreisausschnitt(laenge,oeffnungswinkel,schrittweite);

% laenge=80;
% oeffnungswinkel = 23;
% schrittweite=.01;
j=1;

y1=zeros(oeffnungswinkel/schrittweite,1);
y2=zeros(oeffnungswinkel/schrittweite,1);
x1=zeros(oeffnungswinkel/schrittweite,1);
x2=zeros(oeffnungswinkel/schrittweite,1);
zy1=zeros(laenge/schrittweite,1);
zx1=zeros(laenge/schrittweite,1);
zx2=zeros(laenge/schrittweite,1);
zy2=zeros(laenge/schrittweite,1);



for i= 0:schrittweite:oeffnungswinkel
y1(j)=sin((90-i)*pi/180)*laenge;
x1(j)=cos((90-i)*pi/180)*laenge;
x2(j)=-cos((90-i)*pi/180)*laenge;
y2(j)=sin((90-i)*pi/180)*laenge;
j=j+1;
end
v=1;
for u=0:schrittweite:laenge
zy1(v)=sin((90-oeffnungswinkel)*pi/180)*u;
zx1(v)=cos((90-oeffnungswinkel)*pi/180)*u;
zx2(v)=-cos((90-oeffnungswinkel)*pi/180)*u;
zy2(v)=sin((90-oeffnungswinkel)*pi/180)*u;    
v=v+1;
end

%[kxl,kyl,kxr,kyr,lxl,lyl,lxr,lyr] = [x2,y2,x1,y1,zx2,zy2,zx1,zx2];
    
%plot (0,0,'g*',x1,y1,'r*',x2,y2,'r*',zx1,zy1,'r*',zx2,zy2,'r*');

end