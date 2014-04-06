%----------------
% INPUT
%----------------

%Gamma
gam = 1.781;

%Dietz Shape Factor
dief = 31.62;

addpath('../functions/');

%Script to read the well data
raw_data = xlsread('../datainput.xlsx','WellInput');

%----------------------------
% NO INPUTS BEYOND THIS POINT
%----------------------------

[~,numwells] = size(raw_data);

welldata = raw_data(1:8,:); %Well Data at time t=0 days

wellindex = [1:numwells]; %Keep track of wells

%Calculating Productivity Indices
for i = 1:numwells
    hiwell = hxy(welldata(1,i),welldata(2,i));
    kxwell = kx(welldata(1,i),welldata(2,i));
    kywell = ky(welldata(1,i),welldata(2,i));
    Aijwell = dx*dy;
    bradwell = welldata(3,i);
    sfactorwell = welldata(4,i);
    temp1 = 2*pi*sqrt(kxwell*kywell)*hiwell/mu;
    temp2 = 0.5*log(4*Aijwell/(gam*dief*bradwell^2))+0.25+sfactorwell;
    welldata(8,i) = temp1/temp2;
end

%Bookkeeping for Scheduling Tasks
schedulebook = []; %Well associated with each schedule change
scheduletime = []; %Time at which schedule changes
productivity_index = [];

for i=1:numwells
    
    for j=1:raw_data(8,i)
        scheduletime = [scheduletime,raw_data(9+(j-1)*4,i)];
        schedulebook = [schedulebook,i];
    end
end

curschedule = zeros(1,numwells); %Number of schedule updates per well



