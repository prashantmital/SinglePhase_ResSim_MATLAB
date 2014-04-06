%----INPUT SPECIFICATION

%Script to read Basic Inputs

%------------------------------------------------
%Porosity, Kx, Ky, Height are input as functions
%------------------------------------------------

inp_data = xlsread('../datainput.xlsx','BasicInput');

% Mesh Parameters
xdim = inp_data(1,1);
ydim = inp_data(2,1);
nx = inp_data(3,1);
ny = inp_data(4,1);
dx = xdim/nx;
dy = ydim/ny;

% Physical Parameters
mu = inp_data(6,1)*10^(-9)/(3600*24);
ct = inp_data(7,1)*10^(-3);

% Time Stepping Parameters
endtim = inp_data(9,1);
deltim = inp_data(10,1);

% Initial Conditions
Pinit = inp_data(12,1);
Pn = Pinit*ones(nx*ny,1);