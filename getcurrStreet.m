function [x_curr,y_curr,xl_gedr,yl_gedr,xr_gedr,yr_gedr] = getcurrStreet (xl,yl,xr,yr,x_curr,y_curr,frame,n)



xl_new = zeros(n,1);
yl_new = zeros(n,1);
xr_new = zeros(n,1);
yr_new = zeros(n,1);
xl_gedr = zeros(n,1);
yl_gedr = zeros(n,1);
xr_gedr = zeros(n,1);
yr_gedr = zeros(n,1);


[xl_new(1,1),yl_new(1,1)] = getcurkart(x_curr,y_curr,xl(frame),yl(frame));
[xr_new(1,1),yr_new(1,1)] = getcurkart(x_curr,y_curr,xr(frame),yr(frame));

for i = 2:n
    
    [xl_new(i),yl_new(i)] = getcurkart(x_curr,y_curr,xl(frame+i-1),yl(frame+i-1));
    [xr_new(i),yr_new(i)] = getcurkart(x_curr,y_curr,xr(frame+i-1),yr(frame+i-1));
    [xl_gedr(i),yl_gedr(i)] = systemdrehung2(xr_new(1),yr_new(1),xl_new(i),yl_new(i));
    [xr_gedr(i),yr_gedr(i)] = systemdrehung2(xr_new(1),yr_new(1),xr_new(i),yr_new(i));
end
[x_curr,y_curr] = getcurkart(x_curr,y_curr,x_curr,y_curr);

% plot(xr_new,yr_new,'b*',xl_new,yl_new,'g*')
% grid on



end