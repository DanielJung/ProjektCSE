function [x_gedr,y_gedr] = systemdrehung2(x_bezug,y_bezug,x,y)
x_gedr = zeros(length(x),1);
y_gedr = zeros(length(x),1);


%% Rotattionsmatrix
alpha1 = -atan2(y_bezug,x_bezug);
% alpha2 = pi/2+pi+atan2(y_bezug,x_bezug);
% alpha3 = pi/2+pi-atan2(y_bezug,x_bezug);
% alpha4 = pi/2+atan2(y_bezug,x_bezug);
% alpha5 = pi;

R1 = [cos(alpha1),-sin(alpha1);sin(alpha1),cos(alpha1)];
% R2 = [cos(alpha2),-sin(alpha2);sin(alpha2),cos(alpha2)];
% R3 = [cos(alpha3),-sin(alpha3);sin(alpha3),cos(alpha3)];
% R4 = [cos(alpha4),-sin(alpha4);sin(alpha4),cos(alpha4)];
% R5 = [cos(alpha5),-sin(alpha5);sin(alpha5),cos(alpha5)];

for i = 1: length(x)
%     
%     if (x_bezug>0 && y_bezug>0) 
        a=(R1*([x(i);y(i)]))';
        x_gedr(i) =  a(1);
        y_gedr(i) =  a(2);
%     elseif (x_bezug<0 && y_bezug>0) 
%         a=(R2*([x(i);y(i)]))';
%         x_gedr(i) =  a(1);
%         y_gedr(i) =  a(2);
%     elseif (x_bezug<0 && y_bezug<0) 
%         a=(R3*([x(i);y(i)]))';
%         x_gedr(i) =  a(1);
%         y_gedr(i) =  a(2);
%     elseif (x_bezug>0 && y_bezug<0) 
%         a=(R4*([x(i);y(i)]))';
%         x_gedr(i) =  a(1);
%         y_gedr(i) =  a(2); 
%     else
%         a=(R5*([x(i);y(i)]))';
%         x_gedr(i) =  a(1);
%         y_gedr(i) =  a(2);
%         disp('hehe')
%     end
%         


end


end