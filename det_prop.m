

% x propability of detection
function det= det_prop(x)

  
   detection=rand(1,1);
   if detection <=x
       % detection succesful
       det = 1;
   end
   if detection >x
       % detection failed
       det = 0;
   end
       
end 