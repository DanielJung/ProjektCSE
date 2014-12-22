
function [x1,y1,flagr,flagl] = smpcP1(fahrpunkt,alpha,laenge,xl,xr) 

x1=zeros(1000,1);
y1=zeros(1000,1);

xvorher = fahrpunkt(1);
yvorher = fahrpunkt(2);
dphi=23/1000;
flagl=zeros(1000,2);
flagr=zeros(1000,2);
tol=0.001;

y1(1)=yvorher+sin((alpha-23)*pi/180)*laenge;
x1(1)=xvorher+cos((alpha-23)*pi/180)*laenge;


for i= 1:1000
%for j=1:length(xl)
    
y1(i+1)=yvorher+sin((alpha+i*dphi)*pi/180)*laenge;
x1(i+1)=xvorher+cos((alpha+i*dphi)*pi/180)*laenge;

% %xl,xr 
% dxl= sqrt((x1-xl(j))^2+(y1-yl(j))^2);
% dxr=sqrt((x1-xr(j))^2+(y1-yr(j))^2);
% 
% if(dxl<tol)
%     flagl(i,1)=x1;
%     flagl(i,2)=y1;
% end
% 
% if(dxr<tol)
%     flagr(i,1)=x1;
%     flagr(i,2)=y1;
% end 



end
end
