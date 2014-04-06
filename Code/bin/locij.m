function [ i,j ] = locij( x,y,dx,dy )
%LOCIJ returns (i,j) of given (x,y)
i = floor(x/dx)+1;
j = floor(y/dy)+1;
return
end

