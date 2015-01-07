%baumsetzen2
% %% BÄUME HINZUFÜGEN

clear all
x = [0, 2, 3, 1, 3, 1.5, 0];
y = [0, 2, 1, -1, -1.5, 0.5, 2];
g= graphics('roadtest1',5,x,y,0.001);
%g.puttrees();
g.openWorld();
g.placeNodes();
g.movecar('Mercedes_S');

