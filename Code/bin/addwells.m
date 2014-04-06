function [ A,B ] = addwells( A,B,welldata,numwells,deltim,dx,dy,nx,ny )
%ADDWELLS adds well data to matrices A and B 

for i=1:numwells
    [iwell,jwell] = locij(welldata(1,i),welldata(2,i),dx,dy);
    position = index(iwell,jwell,nx,ny);
    if (welldata(6,i)==1)
        B(position,1)=B(position,1)+welldata(5,i)*deltim*welldata(7,i);
    end
    if (welldata(6,i)==-1)
        A(position,position)=A(position,position)+deltim*welldata(8,i);
        B(position,1)=B(position,1)+deltim*welldata(8,i)*welldata(7,i);
    end
end

end

