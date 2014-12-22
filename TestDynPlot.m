%% dynamische plot Achsen bewegen lassen
x = [0, 2, 3, 1, 3, 1.5, 0];
y = [0, 2, 1, -1, -1.5, 0.5, 2];

s = street(x,y,0.01);
[t, x, y, xr, yr, xl, yl] = s.getRouting(1000, 0.4);
plot (x,y)
hold on
plot(xl,yl)
plot(xr,yr)
winkeltotal=0;

for i=1:s.NumSteps
    s = s.step(1);

    axis([-1 4 -3 3]);
    [poscurr]=  s.getPosition2D();
     alpha =  s.getRotation();
     winkeltotal = alpha*180/pi;
%      phi=0;
%      dphi = 23/1000;
%      xneu(1) = poscurr(1)*cos(alpha);
%      yneu(1) = poscurr(2)*sin(alpha);
%      for j= 1:1000
%      xneu(j+1) = poscurr(1)+0.3*cos(-(phi+dphi+alpha));
%      yneu(j+1) = poscurr(2)+0.3*sin(-(phi+dphi+alpha));
%              
%      end
[x1,y1] = smpcP1(poscurr,winkeltotal,-.9);
     
    [xfalsch,yfalsch,x2,y2,g1x,g1y,g2x,g2y,g3x,g3y] = smpcP(poscurr,winkeltotal,-.9);
     plot(poscurr(1),poscurr(2),'g.');
        
     h =  plot(x1,y1,'b.',x2,y2,'b.',g1x,g1y,g2x,g2y,g3x,g3y);
     
    pause(0.001)
    delete(h);
    drawnow;
    
  
end
