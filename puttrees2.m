function [] = puttrees2(xzuf,yzuf)
            
            
            
            h = Aero.VirtualRealityAnimation;
            h.VRWorldFilename = ['C:\Users\David\Documents\GitHub\Projekt CSE\ratiouni3D2'];
            h.initialize();
          
      
            
            Baumanzahl1 = 0;
            
                for i = 501:1000
               h.addNode(strcat('baumtree',num2str(i)),['C:\Program Files\MATLAB\R2014b\toolbox\sl3d\library\objects\Components\Plants\Tree_Round.wrl']);
               newtrans = getfield(h.Nodes{55+2*i}.VRNode,'translation') - [xzuf(i-500),yzuf(i-500),1]; %getfield(h.Nodes{55+2*i}.VRNode,'translation') +
              
               h.Nodes{55+2*i}.move(newtrans,0)
                  end
%             
              h.nodeInfo
            
            
            
            
            h.saveas('C:\Users\David\Documents\GitHub\Projekt CSE\ratiouni3D2');
         end
            
            
            
           
         