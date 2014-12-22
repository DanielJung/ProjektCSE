function  [x_new,y_new] = getcurkart (x_curr,y_curr,x,y)

%%ERKLÄRUNG
% x_new ist nur die Verschiebung ohne Drehung


%% VERSCHIEBUNG
x_new = zeros(length(x),1);
y_new = zeros(length(x),1);

moveNorm = norm([x_curr,y_curr]);
moveAng = atan2((x_curr),(y_curr));

for i=1:length(x)
x_new(i) = x(i) - (moveNorm * sin(moveAng));
y_new(i) = y(i) - (moveNorm * cos(moveAng));


end