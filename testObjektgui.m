clear all; 
close all; 
% bild = imread('berg.jpg'); 
% imshow(bild); % hier muss es imshow heißen, da du sonst ein anderes GUI öffnest 

clear all
close all
A = xlsread('VonUnibisRatio.xlsx','Tabelle4');
x=A(1:10:end,1);
y=A(1:10:end,2);


 s = street(x,y,.01);
[~, x, y, xr, yr, xl, yl] = s.getRouting(4);
% [xzuf,yzuf] = s.getRandomPoints(500,100,100);
plot(x,y,'r',xr,yr,'g',xl,yl,'b');
[x,y]=ginput(1); 
% p=polyfit(a(:,1),a(:,2),1); 
% x=0:0.1:100; 
% y=polyval(p,x); 

hold on 
plot(x,y,'r*') % Gerade durch die Punkte 
% plot(a(:,1),a(:,2),'r') % Strecke zwischen den Punkten
