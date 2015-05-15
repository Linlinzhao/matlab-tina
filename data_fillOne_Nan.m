%08.04.2015, due to problem of coordinate systems, we change the angle from
% "theta" to "180-theta"

% we fill one missing frame with averaged value, two up to 5 missing frames
% are replaced with NaN. 


clear all;
clc;

dat = importdata('data.txt');
beesize = importdata('size.txt');

%track = textread('track2013.csv','', 'delimiter', ','); % textread function returns 


trxdata = dat.data;

timeStamps = trxdata(:, 1);             %the time step array
%beeNumSight = tr{1, 4};       %The number of bees in sight
timestamps = trxdata(:, 2);
timestamps = timestamps - timestamps(1);
times = trxdata(:, 2);

dtime = timestamps(2) - timestamps(1);

traj = trxdata(:, 3:end);
%timeStep = size(track, 1);
%maxSight = max(track(:, 4));

beeNum = size(traj, 2)/5;

i = 0;
ii = 1;

for j = 1:beeNum
    
    idx = find(traj(:, 5*j - 3) == 255);
    ID(j) = unique(traj(:, 5*j - 4));
    
    xcor = traj(:, 5*j - 2);
    ycor = traj(:, 5*j - 1);
    tcor = (180 - traj(:, 5*j))/57;
    alen = ones(length(xcor), 1)*66;
    blen = ones(length(xcor), 1)*30;
    
    xdcor = xcor;
    ydcor = ycor;
    tdcor = tcor;
    
    
    %here we replace all the missing data with NaN
    %xcor(idx) = NaN;
    %ycor(idx) = NaN;
    %tcor(idx) = NaN;
    

    timeStamps(idx) = [];
    timeShift = timeStamps(2:end);
    timeShift = [timeShift; timeStamps(end) + 1]; 
    
    
    td = timeShift - timeStamps;
    idx1 = find(td == 2);    %find the location where one frame is missing
    idx2 = find(td == 3);    %two frames are missing
    idx3 = find(td > 3 & td < 6);   % Here determines the length of filling frames. 
    idx4 = find(td > 6);
    
    miss1Frame = timeStamps(idx1) + 1;   %find the indices where on frame is missing
    miss2Frame1 = timeStamps(idx2) + 1;
    miss2Frame2 = timeStamps(idx2) + 2;    
    
    
    %fill locations where 1 or 2 frames are missing
    xcor(miss1Frame) = (xcor(miss1Frame - 1) + xcor(miss1Frame + 1))/2;
    ycor(miss1Frame) = (ycor(miss1Frame - 1) + ycor(miss1Frame + 1))/2;
    tcor(miss1Frame) = (tcor(miss1Frame - 1) + tcor(miss1Frame + 1))/2;
    
    xcor(miss2Frame1) = NaN;
    ycor(miss2Frame1) = NaN;
    tcor(miss2Frame1) = NaN;
    
    xcor(miss2Frame2) = NaN;
    ycor(miss2Frame2) = NaN;
    tcor(miss2Frame2) = NaN;
    
    %fill locations where 3 or more location are missing
    
    missNum = td(idx3);   %vector of the numbers of missing frames
    missmFrame = timeStamps(idx3);  %vector of indices where frames are missing
    
    holeNum = size(missNum);
    for n = 1:holeNum
        for m = 1:(missNum(n)-1)
            xcor(missmFrame(n) + m) = NaN;
            ycor(missmFrame(n) + m) = NaN;
            tcor(missmFrame(n) + m) = NaN; 
            alen(missmFrame(n) + m) = 33;
            blen(missmFrame(n) + m) = 15;
        end
        
    end
    
    
    
    
    idxFilled = find(xcor == -1);   %find the indices where still exists missing frames
    
    xdcor(idxFilled) = [];
    len = length(xdcor);
    
    
    idxFshift = [idxFilled(2:end); idxFilled(end) + 1];
    idxB = idxFshift - idxFilled; %find the indices where breaking happens 
    idxTemp = find(idxB ~= 1);
    idxBreak0 = idxFilled(idxTemp);
    idxBreak1 = idxFilled(idxTemp + 1);
    
    segNum = length(idxBreak0);
    
    kk = 1;
    for k = 1:segNum  
        segm = xcor((idxBreak0(k)+1):(idxBreak1(k)-1));
        segmNum = length(segm);
        
        if segmNum > 500     % we set the length threshold as 500, that mean we keep frames with length larger than 500 
        
        xcor_s{j}{kk} = xcor((idxBreak0(k)+1):(idxBreak1(k)-1));    %segmented trajectory
        ycor_s{j}{kk} = ycor((idxBreak0(k)+1):(idxBreak1(k)-1));
        tcor_s{j}{kk} = tcor((idxBreak0(k)+1):(idxBreak1(k)-1));   
        
        trx(ii).x = xcor((idxBreak0(k)+1):(idxBreak1(k)-1))/6;
        trx(ii).y = ycor((idxBreak0(k)+1):(idxBreak1(k)-1))/6;
        trx(ii).theta = tcor((idxBreak0(k)+1):(idxBreak1(k)-1));
        trx(ii).id = unique(traj(:, 5*j - 4));
        trx(ii).a = alen((idxBreak0(k)+1):(idxBreak1(k)-1))/4;
        trx(ii).b = blen((idxBreak0(k)+1):(idxBreak1(k)-1))/4;
        trx(ii).dt = dtime;
        trx(ii).fps = 2;
        trx(ii).sex = 'F';
        trx(ii).x_mm = xcor((idxBreak0(k)+1):(idxBreak1(k)-1))/18;
        trx(ii).y_mm = ycor((idxBreak0(k)+1):(idxBreak1(k)-1))/18;
        trx(ii).theta_mm = tcor((idxBreak0(k)+1):(idxBreak1(k)-1));
        trx(ii).a_mm = alen((idxBreak0(k)+1):(idxBreak1(k)-1))/12;
        trx(ii).b_mm = blen((idxBreak0(k)+1):(idxBreak1(k)-1))/12;
        trx(ii).nframes = length(xcor((idxBreak0(k)+1):(idxBreak1(k)-1)));
        trx(ii).firstframe = idxBreak0(k)+1;
        trx(ii).endframe = idxBreak1(k)-1;
        trx(ii).off = - idxBreak0(k);
        trx(ii).timestamps = times((idxBreak0(k)+1):(idxBreak1(k)-1));
                
        
        ii = ii + 1;
        kk = kk + 1;
        end
    end
    
    
    
    
    if len > 5000
        
        i = i + 1;
        trax(i).id = unique(traj(:, 5*j - 4));
        
        trax(i).x = xcor;
        trax(i).y = ycor;
        trax(i).theta = tcor;
        trax(i).a = alen;
        trax(i).b = blen;
        trax(i).sex = 'F';
        trax(i).dt = dtime;
        trax(i).fps = 2;
        trax(i).x_mm = xcor/3;
        trax(i).y_mm = ycor/3;
        trax(i).theta_mm = tcor;
        trax(i).a_mm = 66/3;
        trax(i).b_mm = 30/3;
        
        
    %else trax = rmfield(trax, 'id');
    end
    
    timeStamps = trxdata(:, 1); 
end

save('trx0956.mat', 'trx', 'timestamps');


    



