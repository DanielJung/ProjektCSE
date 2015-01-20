
function [dist] = getDist(x,y,det_x,det_y)

dist = sqrt((det_y-y)^2 + (det_x-x)^2);


end