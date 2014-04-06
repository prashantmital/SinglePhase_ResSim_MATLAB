function [ P ] = analyticsol( r,mu,ct )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
alpha = 0.096*10^-12/(0.1*mu*ct);
P = 13 - (3*mu/(4*pi*0.096*10^-12*5))*(expint(r^2/(4*alpha*0.4)));

end

