function [ DiffCoeffMat ] = diffCoeffMat( CoeffMat )

s = size(CoeffMat);
m = s(1);
n = s(2);

DiffCoeffMat = zeros(m, n-1);

for i=1:m
    for j=(n-1):-1:1
        DiffCoeffMat(i, j) = (n-j)*CoeffMat(i, j);
    end
end

end

