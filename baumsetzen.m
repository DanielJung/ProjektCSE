%% BÄUME HINZUFÜGEN
x = [0, 2, 3, 1, 3, 1.5, 0];
y = [0, 2, 1, -1, -1.5, 0.5, 2];

Baumanzahl = 10;
s = street(x, y, 0.001);
s.puttrees(Baumanzahl)

clear s
clear ans
close all

s = street(x, y, 0.001);
[t,x,y,neu,neu2,xl,yl] = s.getRouting(Baumansahl,0.4);
[t,x, y, xr, yr, xl, yl] = s.getRouting(2000, 0.2);
world = vrworld('roadtest1.wrl');
open(world);
fig = view(world);
vrdrawnow;
nodes(world)


car = vrnode(world,'Mercedes_S');
tree1 = vrnode(world,'tree1');

%% Platzieren der Bäume
 for i = 1:Baumanzahl
               tree = vrnode(world,strcat('tree',num2str(i))); 
               tree.scale = [0.02 0.02 0.02];
               tree.translation = [neu(i) 0.1 neu2(i)];
               vrdrawnow;
 end
%Fahren lassen des Autos            
 for i=1:s.NumSteps
    s = s.step(1);
    
    car.translation = s.getPosition();
    car.rotation = [0 -1 0 s.getRotation()];
    vrdrawnow;
  
end