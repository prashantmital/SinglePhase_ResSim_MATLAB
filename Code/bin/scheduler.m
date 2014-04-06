function [ welldata,curschedule,flag ] = scheduler( scheduletime,schedulebook,curschedule,curtime,raw_data,welldata )
%SCHEDULER schedule handler
welldata = welldata;
flag = 0;
[~,nc]=size(scheduletime);
for i=1:nc
    elt = scheduletime(i);
    if curtime==elt
        flag = 1;
        wellid = schedulebook(i);
        curschedule(i) = curschedule(i)+1;
        welliter = curschedule(i);
        temp_ind = 10 + (welliter-1)*4;
        welldata(5:7,wellid)=raw_data(temp_ind:temp_ind+2,wellid);
    end
end
end
