%---------------------------
% INPUTS
%---------------------------

%Specify Input XLSX Filepath in ./bin/inputfile.m and ./bin/readwells.m

%Input Kx,Ky,Porosity and Height Functions Folderpath
addpath('./functions/');

%----------------------------
% NO INPUTS BEYOND THIS POINT
%----------------------------

%clc;
%clear all;

%Add Auxiliary Functions to Path
addpath('./bin/');

%Parse Input
run('./bin/inputfile.m');

%Assemble Matrices
A = assembleA(nx,ny,dx,dy,deltim,mu,ct);

%Add Initial Pressure Data
B = assembleB(nx,ny,dx,dy,ct,Pn);

%Read Initial Well Data
run('./bin/readwells.m');

%Induct Initial Well Data into Matrices
[A,B] = addwells(A,B,welldata,numwells,deltim,dx,dy,nx,ny);

%Initialize Simulation Clock
curtim = 0;
stepnum = 0;

%Check Schedule at First Time Step and Rebuild Matrices
[welldata,curschedule,flag]=scheduler(scheduletime,schedulebook,curschedule,curtim,raw_data,welldata);
if flag==1
    A = assembleA(nx,ny,dx,dy,deltim,mu,ct);
    B = assembleB(nx,ny,dx,dy,ct,Pn);
    [A,B] = addwells(A,B,welldata,numwells,deltim,dx,dy,nx,ny);
end

%Mark Inactive Cells
[ A,B,Pn ] = deactivate_cells( A,B,Pn,nx,ny,dx,dy,mu,deltim );
%size(A)

B

%Initialize Data Structures to Store Output
numsteps = endtim/deltim;
Pwf = zeros(numsteps,numwells);
Qwf = zeros(numsteps,numwells);
Psim = zeros(numsteps,nx*ny);
MatBal = zeros(numsteps,2);

%March Through Time
while curtim<=endtim
    stepnum = stepnum+1
    %A
    %B
    P = A\B;
    count = 0;
    %P = readd_cells(P,nx,ny);
    curtim = curtim + deltim;
    %disp('Current Time = ');
    %disp(curtim);
    %------------------
    %Store Well Outputs
    for i = 1:numwells
        [iwell,jwell] = locij(welldata(1,i),welldata(2,i),dx,dy);
        position = index(iwell,jwell,nx,ny);
        if welldata(6,i)==1
            Pwf(stepnum,i) = welldata(5,i)*welldata(7,i)/welldata(8,i) + P(position,1);
            Qwf(stepnum,i) = welldata(5,i)*welldata(7,i);
        end
        if welldata(6,i)==-1
            Pwf(stepnum,i) = welldata(7,i);
            Qwf(stepnum,i) = welldata(8,i)*(welldata(7,i)-P(position,1));
        end
    end
    %Store Pressure Profile
    Psim(stepnum,:)=P;
    %Calculate and Store Global Mass Balance Information
    lhs = 0;
    for i = 1:nx
        for j = 1:ny
            [xij,yij] = locxy(i,j,dx,dy);
            position = index(i,j,nx,ny);
            if(P(position,1)==-9999)
                count = count+1; %Stores number of inactive cells for debugging
                continue;
            end
            lhs = lhs + ct*poro(xij,yij)*dx*dy*(P(position,1)-Pn(position,1))*hxy(xij,yij);
        end
    end
    rhs = 0;
    for i = 1:numwells
        rhs = rhs+deltim*Qwf(stepnum,i);
    end
    MatBal(stepnum,1) = stepnum;            
    MatBal(stepnum,2) = rhs-lhs;
    %------------------
    %Check Well Schedule
    [welldata,curschedule,flag]=scheduler(scheduletime,schedulebook,curschedule,curtim,raw_data,welldata);
    %Rebuild Matrices with Modified Initial Conditions
    if flag == 1
        A = assembleA(nx,ny,dx,dy,deltim,mu,ct);
        [A,~] = addwells(A,B,welldata,numwells,deltim,dx,dy,nx,ny);
        [ A,~ ] = deactivate_cells( A,B,Pn,nx,ny,dx,dy,mu,deltim );
    end
    
    B = assembleB(nx,ny,dx,dy,ct,P);
    [~,B] = addwells(A,B,welldata,numwells,deltim,dx,dy,nx,ny);
    [ ~,B,~ ] = deactivate_cells( A,B,Pn,nx,ny,dx,dy,mu,deltim );
    Pn = P;
end

disp('Global Material Balance Information');
disp(MatBal)

%Visualize Output