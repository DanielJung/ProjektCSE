clear all
close all

x = [ 1 2 3 ];
y= [3,2,1];



x_curr =  x(2);
y_curr = y(2);


[x_new,y_new] = getcurkart (x_curr,y_curr,x(1),y(1));
[x_new2,y_new2] = getcurkart (x_curr,y_curr,x_curr,y_curr);
[x_new3,y_new3] = getcurkart (x_curr,y_curr,x(3),y(3));
[xr_gedr,yr_gedr] = systemdrehung(x_new3,y_new3,[x_new3;1.1],[y_new3;-0.9]);



plot(x,y,'*',x_new,y_new,'r*',x_new2,y_new2,'r*',x_new3,y_new3,'r*',xr_gedr,yr_gedr,'b*')