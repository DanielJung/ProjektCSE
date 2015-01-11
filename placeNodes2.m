function []= placeNodes2()   
    [neu,neu2] = s.getRandomPoints(100,100,100) % HIER getrandompoints verwenden
           
 for i = 1:100
               tree = vrnode(this.world,strcat('treebaum',num2str(i))); 
               %tree.scale = [0.02 0.02 0.02];
               tree.translation = [neu(i) 3 neu2(i)];
               
 end
end