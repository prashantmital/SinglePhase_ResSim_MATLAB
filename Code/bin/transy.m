function [ tru,trl ] = transy( dx,dy,nx,ny,mu,i,j )
%TRANSY calculates the y-transmissibility of face i,j+1/2 and i,j-1/2

%true x y coordinates can be determined from i,j
%in next version, use functions of h and k to get values at desired
%location
[x,y] = locxy(i,j,dx,dy);

a = (hxy(x,y)*dx*ky(x,y)/(mu*dy)); %at i,j
b = (hxy(x,y+dy)*dx*ky(x,y+dy)/(mu*dy)); %at i,j+1
c = (hxy(x,y-dy)*dx*ky(x,y-dy)/(mu*dy)); %at i,j-1

tru = (2*a*b)/(a+b);
trl = (2*a*c)/(a+c);

if (j<=1)
    %disp('Boundary!');
    trl = 0;
end

if (j>=ny)
    %disp('Boundary!');
    tru = 0;
end

return
end

