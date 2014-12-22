clear all
close all
clc

% %%% FALLS STRAßE NICHT ANGEZEIGT, ANDERER VIEWER : vrsetpref('DefaultViewer','factory') 
% h = Aero.VirtualRealityAnimation;
% h.VRWorldFilename = ['C:\Users\jonas_000\Documents\MATLAB\PROJEKT CSE\9.12.2014\roadtest.wrl'];
% copyfile(h.VRWorldFilename,[tempdir,'roadtest.wrl'],'f');
% h.VRWorldFilename = [tempdir,'roadtest.wrl'];
% h.initialize();
% h.addNode('tree',['C:\Users\jonas_000\Documents\MATLAB\PROJEKT CSE\9.12.2014\tree.wrl']);
world = vrworld('roadtest1.wrl');
open(world);
fig = view(world);
vrdrawnow;
nodes(world)


car = vrnode(world,'Mercedes_S');
tree1 = vrnode(world,'tree1');


fields(car)
x = [0, 2, 3, 1, 3, 1.5, 0];
y = [0, 2, 1, -1, -1.5, 0.5, 2];

s = street(x, y, 0.001);
[t,x,y,neu,neu2,xl,yl] = s.getRouting(20,0.4);
[t,x, y, xr, yr, xl, yl] = s.getRouting(20, 0.2);



            for i = 1:20
               tree = vrnode(world,strcat('tree',num2str(i))); 
               tree.scale = [0.02 0.02 0.02];
               tree.translation = [neu(i) 0.1 neu2(i)];
               vrdrawnow;
            end
            
for i=1:s.NumSteps
    s = s.step(1);
    
    car.translation = s.getPosition();
    car.rotation = [0 -1 0 s.getRotation()];
    vrdrawnow;
  
end



