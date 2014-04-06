function [ A,B,Pn ] = deactivate_cells( A,B,Pn,nx,ny,dx,dy,mu,deltim )
%DEACTIVATE_CELLS marks inactive cells with a negative pressure
raw_data = xlsread('./datainput.xlsx','InactiveCells');
[nrow,~]=size(raw_data);
for k = 1:nrow
    i = raw_data(k,1);
    j = raw_data(k,2);
    position = index(i,j,nx,ny);
    A(position,:)=0;
    A(:,position)=0;
    A(position,position)=1;
    B(position,1) = -9999;
    %Pn(position,1)
    [trxf,trxb]=transx(dx,dy,nx,ny,mu,i,j);
    [tryu,tryl]=transy(dx,dy,nx,ny,mu,i,j);
    if i~=1
        row = index(i-1,j,nx,ny);
        if A(row,row) ~= 1
            A(row,row) = A(row,row) - deltim*trxb;
        end
    end
    if i~=nx
        row = index(i+1,j,nx,ny);
        if A(row,row)~=1
            A(row,row) = A(row,row) - deltim*trxf;
        end
    end
    if j~=1
        row = index(i,j-1,nx,ny);
        if A(row,row) ~= 1
            A(row,row) = A(row,row) - deltim*tryl;
        end
    end
    if j~=ny
        row = index(i,j+1,nx,ny);
        if A(row,row) ~= 1
            A(row,row) = A(row,row) - deltim*tryu;
        end
    end
end



return



end

