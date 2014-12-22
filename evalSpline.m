function [ y ] = evalSpline( CoeffMat, t, x)

%find matching interval

int = 1;

for i=1:length(t)-1
    if(x>t(i) && x<=t(i+1))
        int = i;
        break;
    end
end

x = x-t(int);

s = size(CoeffMat);
n = s(2);

y = 0;

for i=n:-1:1
    y = y+x.^(i-1)*CoeffMat(int, n-i+1);
end
%y = x.^3*CoeffMat(int, 1)+x.^2*CoeffMat(int, 2)+x.*CoeffMat(int, 3)+CoeffMat(int, 4);

end

