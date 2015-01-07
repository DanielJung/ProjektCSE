classdef Objekte
     properties (GetAccess=public)
       ObjektID % Jedem Objekt wird eine eindeutige ID zugeordnet
       MovementClass % Bewegungszustandes
       ObjectClass %  Objektklasse
       ObstacleClass %  Befahrbarkeit
       x_pos % x_Postition
       y_pos % y_Postition
       Output_State_Psi % Position in Polar
       Output_State_Length  % Position in Polar
       Output_State_width %Objektdicke
       
       
       
    
     end
   methods
       
       function this = Objekte(ObjektID,x_pos,y_pos,ObjectClass,MovementClass, ObstacleClass)
            this.ObjektID = ObjektID;
       %% Position in Objekt speichern
       this.x_pos=x_pos;  
       this.y_pos=y_pos;
       %% Objektklasse definieren
       this.ObjectClass=ObjectClass;
       %% MovementKlasse definieren
       this.MovementClass=MovementClass;
       %% Befahrbarkeit
       this.ObstacleClass=ObstacleClass;
       end
    
       function this = MClass(this,MZustand)
           
           switch MZustand
               case 1
                    this.MovementClass = 'Standing';
               case 2
                    this.MovementClass = 'Stopped';
               case 3
                    this.MovementClass = 'Moving';
           end
           
       end %  Bewegungszustand für RAND
       function this = OClass(this,OZustand)
           
           switch OZustand
               case 1
                    this.ObjectClass = 'Car';
               case 2
                    this.ObjectClass = 'Truck';
               case 3
                    this.ObjectClass = 'TwoWheeler';
               case 4 
                    this.ObjectClass = 'Pedestrian';%Fußgänger
               case 5    
                    this.ObjectClass = 'Beacon'  ; %Leuchte
               case 6  
                    this.ObjectClass = 'GuardRail';%Leitplanke
               case 7 
                    this.ObjectClass = 'ReflectorPost'; % Leitpfosten
                case 8 
                    this.ObjectClass = 'Unknown'; % Leitpfosten
                    
           end
           
       end %  Objektklasse für RAND
       function this = ObClass(this,ObZustand)
           
           switch ObZustand
               case 1
                    this.ObstacleClass = 'Underdrivable';
               case 2
                    this.ObstacleClass = 'Overdrivable';
               case 3
                    this.ObstacleClass = 'Unknown'; % Unknown
               
                    
                    
           end
           
       end % Befahrbarkeit für RAND
       function position = getObjPos(this) % Position des Objekts auslesen
       position = [this.x_pos;this.y_pos];
       end
       function movementclass = getMovementClass(this)
           movementclass = this.MovementClass;
       end %  Abfrage Bewegungszustand
       function objectclass = getObjectClass(this)%  Abfrage Bewegungszustand Objektklasse
           objectclass = this.ObjectClass;
       end 
       function obstacleclass = getObstacleClass(this)%  Abfrage Befahrbarkeit
           obstacleclass = this.ObstacleClass;
       end 
      
       
end
end
