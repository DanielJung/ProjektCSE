classdef Umgebung
    properties
      anzahl             % Anzahl der Objekte
      Objektarray        % Array in dem die Objekte gespeichert werden
      street             % Die Straße wird übergeben  
      koordinatenarray   % Array in dem einfach die Koordinaten gespeichert werden
    end
    
    methods
        function this=Umgebung(street)
            this.street=street;
            this.anzahl=1;
            this.Objektarray = Objekte('TestObjekt', 0, 0, 'Pedestrian', 'Standing', 'Unknown');
            this.koordinatenarray = [0,0,1]; %[x,y,eintragsnummer]
        end
        
        
          function this=putRandomObject(this,n,dist,width)
        
              [x, y] = this.street.getRandomPoints(n, dist, width);
              
        for i= 1:n
              
         beschreibung = 'Randobjekt';
         this.anzahl=  this.anzahl+1; %ein Objekt kommt dazu
         objektnummer = this.anzahl;
         ID = strcat(beschreibung,int2str(objektnummer));
         a = randperm(3);       % Erstellung zufälliger Werte
         MovementClass = a(2);  % Erstellung zufälliger Werte  
         b = randperm(8);       % Erstellung zufälliger Werte
         ObjectClass = b(2);    % Erstellung zufälliger Werte
         c=randperm(3);         % Erstellung zufälliger Werte
         ObstacleClass = c(2);  % Erstellung zufälliger Werte
                    
         
         %% Objekt hinzufügen
         id = Objekte(ID,x(i),y(i),ObjectClass,MovementClass,ObstacleClass);
         id = id.MClass(MovementClass);
         id = id.OClass(ObjectClass);
         id = id.ObClass(ObstacleClass);
         this.Objektarray = [this.Objektarray , id];
        
        %% Koordinaten in Vektor schreiben
        m = length(x(i));
        objektnummerierung = objektnummer * ones(m, 1);
        this.koordinatenarray = [this.koordinatenarray; x(i),y(i), objektnummerierung];
        end
        
        
        end
        
        function this=putObject(this,beschreibung,x,y,MovementClass,ObjectClass,ObstacleClass)
         this.anzahl=  this.anzahl+1; %ein Objekt kommt dazu
         objektnummer = this.anzahl;
         ID = strcat(beschreibung,int2str(objektnummer));
         %% Objekt hinzufügen
         id = Objekte(ID,x,y,ObjectClass,MovementClass,ObstacleClass);
         this.Objektarray = [this.Objektarray , id];
        
        %% Koordinaten in Vektor schreiben
        n = length(x);
        objektnummerierung = objektnummer * ones(n, 1);
        this.koordinatenarray = [this.koordinatenarray; x,y, objektnummerierung];
        end
        function objektarray= getObject(this)
                 objektarray = this.Objektarray;
              end
        function koordinaten= getCoords(this)
                 koordinaten = this.koordinatenarray;
        end
        
        
    end
    
end

