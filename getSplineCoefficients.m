function [ CoeffMat ] = getSplineCoefficients( t, y, dfa, dfb)

if(length(t)~=length(y))
    error('y and t must match together');
end

m = length(t);

A = zeros(m, m);

h = zeros(m-1, 1);

for i=1:length(h)
    h(i) = t(i+1)-t(i);
end

%vollständige Randbedingungen => erste und letzte zeile ausfüllen

A(1, 1) = 2*h(1);
A(1, 2) = h(1);

A(m, m-1) = h(m-1);
A(m, m) = 2*h(m-1);

%Rest der Matrix füllen

for i=2:m-1
    A(i, i-1) = h(i-1);
    A(i, i) = 2*(h(i-1)+h(i));
    A(i, i+1) = h(i);
end

%Rechte Seite
b = zeros(m, 1);
b(1) = 6/h(1)*(y(2)-y(1))-6*dfa;
b(m) = -6/h(m-1)*(y(m)-y(m-1))+6*dfb;

for i=2:m-1
    b(i) = 6/h(i)*(y(i+1)-y(i)) - 6/h(i-1)*(y(i)-y(i-1));
end

%LGS lösen

ddy = A\b;

%Koeffizienten berechnen

CoeffMat = zeros(m-1, 4);

for i=1:m-1
    CoeffMat(i, 1) = 1/6/h(i)*(ddy(i+1)-ddy(i)); %a
    CoeffMat(i, 2) = 0.5*ddy(i);
    CoeffMat(i, 3) = 1/h(i)*(y(i+1)-y(i))-1/6*h(i)*(ddy(i+1)+2*ddy(i));
    CoeffMat(i, 4) = y(i);
end

end

