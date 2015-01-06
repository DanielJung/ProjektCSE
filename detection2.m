function [x_det,y_det] = detection2(obj_x,obj_y,x1,y1,zx1,zy1)

ymax = max(abs(y1));

ymax2 = max(abs(zy1));
xmax2 = max(abs(zx1));


 x_det = zeros(length(zx1),1);
 y_det = zeros(length(zx1),1);
z=1;
for j=1:length(obj_x)
if (abs(obj_x(j)) <= abs(xmax2)) && (obj_y(j) <= ymax2)
    
      for i =1:length(zy1)
         if ((zy1(i)-obj_y(j))< 0.05)
             if (abs(obj_x(j)) < abs(zx1(i)))
                x_det(z) = obj_x(j);
                y_det(z) = obj_y(j);
                 z=z+1;
             end
         end                     
      end
  
    
end

if (abs(obj_x(j)) <= abs(xmax2)) && (obj_y(j) <= ymax ) && (ymax2 <= obj_y(j))
    for i =1:length(y1)
        if ((y1(i)-obj_y(j))< 0.005) && (abs(obj_x(j)) <= abs(x1(i)))
            %if (abs(obj_x(j)) <= abs(x1(i)))
             x_det(z) = obj_x(j);
             y_det(z) = obj_y(j);
             z=z+1;
           % end
        end
    end
    

end
 x_det =  x_det(x_det~=0);   
 y_det =  y_det(y_det~=0);   
end