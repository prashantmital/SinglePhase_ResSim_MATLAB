function [ x,y ] = locxy( i,j,dx,dy )
%LOCXY finds the (x,y) coordinates of cell center of (i,j)
x = (i-1)*dx + dx/2;
y = (j-1)*dy + dy/2;
return
end

