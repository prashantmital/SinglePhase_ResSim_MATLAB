function [ A ] = assembleA( nx,ny,dx,dy,deltim,mu,ct )
%ASSEMBLEAB Sets up the matrix for the first iteration
%Accounts for no-flow boundary conditions
%Does not implement wells or inactive cells
%Initializes with boundary conditions Pn

%Add path containing input functions
%addpath('../inputfunctions/');

%Add path containing auxiliary functions
%addpath('../bin/');

%Initialize Matrices
A = zeros(nx*ny);

for i=1:nx
    for j=1:ny
        [xij,yij] = locxy(i,j,dx,dy); %(x,y) coordinates of (i,j)
        hij = hxy(xij,yij); %height h(x,y) of (i,j)
        row = index(i,j,nx,ny); %matrix location of (i,j)
        %IMPLEMENT KX KY IN TRANSX TRANSY
        phi = poro(xij,yij);
        [trxf,trxb]=transx(dx,dy,nx,ny,mu,i,j);
        [tryu,tryl]=transy(dx,dy,nx,ny,mu,i,j);
        A(row,row)=A(row,row)+deltim*(tryu+tryl+trxb+trxf)+phi*ct*dx*dy*hij;
        if (i~=1)
            A(row,index(i-1,j,nx,ny))=A(row,index(i-1,j,nx,ny))-deltim*trxb;
        end
        if (i~=nx)
            A(row,index(i+1,j,nx,ny))=A(row,index(i+1,j,nx,ny))-deltim*trxf;
        end
        if (j~=1)
            A(row,index(i,j-1,nx,ny))=A(row,index(i,j-1,nx,ny))-deltim*tryl;
        end
        if (j~=ny)
            A(row,index(i,j+1,nx,ny))=A(row,index(i,j+1,nx,ny))-deltim*tryu;
        end
    end
end


return

end