function [ ind ] = index( i,j,nx,ny )
%INDEX returns the cardinal matrix position for element (i,j)
ind = (j-1)*nx+i;
return
end

