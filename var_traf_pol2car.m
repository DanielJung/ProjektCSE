
function [var_kar] = var_traf_pol2car(R,Phi,varR,varPhi)
% % syms varR varPhi covRPhi real
% % syms R Phi real
% % x_t = [R*cos(Phi);R*sin(Phi)];
% % 
% % P = [ varR, 0; 0, varPhi ];
% % J = jacobian(x_t, [ R, Phi]);
% % var_kar = J * P * J';


var_kar = ...
[                 varPhi*R^2*sin(Phi)^2 + varR*cos(Phi)^2, - varPhi*cos(Phi)*sin(Phi)*R^2 + varR*cos(Phi)*sin(Phi); ...
 - varPhi*cos(Phi)*sin(Phi)*R^2 + varR*cos(Phi)*sin(Phi),                 varPhi*R^2*cos(Phi)^2 + varR*sin(Phi)^2];



end