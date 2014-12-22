clc, clear, close all;
x = [0, 2, 3, 1, 3, 1.5, 0];
y = [0, 2, 1, -1, -1.5, 0.5, 2];


s = street(x, y, 0.001);
[t,x, y, xr, yr, xl, yl] = s.getRouting(200, 0.3);
plot(x, y, xr, yr, xl, yl);
legend('Mittellinie', 'Rechter Rand', 'Linker Rand');
ausgabe = zeros(2*length(xr),2);

for i = 1:length(xr)
   ausgabe(2*i,1) = xr(i);
   ausgabe(2*i,2) = yr(i);    
end
for j = 1:length(xr)
   ausgabe(2*j-1,1) = xl(j);
   ausgabe(2*j-1,2) = yl(j);   
end
s=3;
ausgabe2 = zeros(length(xr)-1,5);

    for k=1:length(xr)-1
        s=s-2;
        for kk=0:3
   ausgabe2(k,1+kk)=s;
   s=s+1;
   ausgabe2(k,5) = -1;
        end
    end
    ausgabe2
xlswrite('test3.xls',ausgabe,'Tabelle1')
xlswrite('test3.xls',ausgabe2,'Tabelle2')


