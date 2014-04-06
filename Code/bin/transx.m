function [ trf,trb ] = transx( dx,dy,nx,ny,mu,i,j )
%TRANSX calculates the x-transmissibility of face i+1/2,j and i-1/2,j

%true x y coordinates can be determined from i,j
%in next version, use functions of h and k to get values at desired
%location
[x,y] = locxy(i,j,dx,dy);

a = (hxy(x,y)*dy*kx(x,y)/(mu*dx)); %at i,j
b = (hxy(x+dx,y)*dy*kx(x+dx,y)/(mu*dx)); %at i+1,j
c = (hxy(x-dx,y)*dy*kx(x-dx,y)/(mu*dx)); %at i-1,j

trf = (2*a*b)/(a+b);
trb = (2*a*c)/(a+c);

if (i<=1)
    %disp('Boundary!');
    trb = 0;
end

if (i>=nx)
    %disp('Boundary!');
    trf = 0;
end

return


end

