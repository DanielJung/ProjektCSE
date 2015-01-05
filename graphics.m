classdef graphics
     properties (GetAccess=public)
     Baumanzahl     %Anzahl der B‰ume
     s              %Straﬂenklasse
     WRLdateiname   %Name der WRLdatei 'roadtest1'
     world          %VRworld
      end
     methods
            
function this = graphics(wrldateiname,Baumanzahl,x,y,dt)
             this.Baumanzahl=Baumanzahl;
             this.s = street(x,y,dt);
             this.WRLdateiname = wrldateiname;
             this.world = vrworld(wrldateiname);
         end
function this = puttrees(this)
            
           
            h = Aero.VirtualRealityAnimation;
            h.VRWorldFilename = ['C:\Users\jonas_000\Documents\MATLAB\PROJEKT CSE\9.12.2014\roadtest.wrl'];
            h.initialize();
      
            
            
            
            
            for i = 1:this.Baumanzahl
               h.addNode(strcat('tree',num2str(i)),['C:\Program Files\MATLAB\R2013b\toolbox\sl3d\library\objects\Components\Plants\Tree.wrl']);
               newtrans = getfield(h.Nodes{32+2*i}.VRNode,'translation') + [100,100,100];
              
               h.Nodes{32+2*i}.move(newtrans,0)
              
            end
            
            
            
            
            
            
            h.saveas('C:\Users\jonas_000\Documents\MATLAB\PROJEKT CSE\9.12.2014');
         end
function this = openWorld(this)
           
            open(this.world);
             fig = view(this.world);
             vrdrawnow;
         end
function this= placeNodes(this)   
    [~,~,~,neu,neu2,~,~] = this.s.getRouting(0.4);
           
 for i = 1:this.Baumanzahl
               tree = vrnode(this.world,strcat('tree',num2str(i))); 
               tree.scale = [0.02 0.02 0.02];
               tree.translation = [neu(i) 0.1 neu2(i)];
               vrdrawnow;
 end
         end
function this = movecar(this,carname)
     
      car = vrnode(this.world,carname);
                 %Fahren lassen des Autos            
 for i=1:this.s.NumSteps
    this.s = this.s.step(1);
    
    car.translation = this.s.getPosition();
    car.rotation = [0 -1 0 this.s.getRotation()];
    vrdrawnow;
  
 end
             end
function this = closeWorld(this)
             close(this.world)
             end
    
    
     end 
end
