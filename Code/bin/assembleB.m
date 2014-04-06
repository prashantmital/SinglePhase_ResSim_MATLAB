function [ B ] = assembleB( nx,ny,dx,dy,ct,Pn )
%ASSEMBLEB assembles and returns matrix B with initial conditions

B = zeros(nx*ny,1);
for i=1:nx
    for j=1:ny
        [xij,yij] = locxy(i,j,dx,dy); %(x,y) coordinates of (i,j)
        hij = hxy(xij,yij); %height h(x,y) of (i,j)
        row = index(i,j,nx,ny); %matrix location of (i,j)
        phi = poro(xij,yij);
        B(row,1)=phi*ct*dx*dy*hij*Pn(row);
    end
end

return
end

