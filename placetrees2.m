function [] = placetrees2(xzuf,yzuf)
            
            
            
            h = Aero.VirtualRealityAnimation;
            h.VRWorldFilename = ['C:\Users\David\Documents\GitHub\Projekt CSE\ratiouni3D2'];
            h.initialize();
          
      
            
            Baumanzahl1 = 500;
            
        
            for i = 1:Baumanzahl1
           
              
               newtrans = getfield(h.Nodes{55+2*i}.VRNode,'translation') + [-xzuf(i) -1 -yzuf(i)];% getfield(h.Nodes{55+2*i}.VRNode,'translation') +
              
               h.Nodes{55+2*i}.move(newtrans,0);
      
            end
            
              h.nodeInfo
            
            
            
            
            h.saveas('C:\Users\David\Documents\GitHub\Projekt CSE\ratiouni3D2');
         end
            
            
            
           
         