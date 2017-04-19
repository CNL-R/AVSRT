
%%%%%%%%%%%
%%PHASE I%%
%%%%%%%%%%%

%The first part of the script will parse the behavioral data contained in the
%presentation log files. The script will iterate over a root folder containing
%folders for each individual participant.

clear all                                              %clear all workspace variables

direc = uigetdir;                                      %get the directory containing all of the participant folders
folders = dir(direc);
id = {folders([folders(:).isdir]).name};               %get the names of the folders in the root directory, ignore anything else
id(ismember(id,{'.','..'})) = [];                      %if the root folder is not actually a root (it almost always won't be), remove the "." and ".." entries.

nconds = 14;                                           %14 conditions (0=error, 1=click, 2=audio only, 3=visual only, 4=audiovisual only....)
removethresh = 100;                                    %ms threshold for physiologically possible responses
data = [];                                             %create empty data array, this will hold all the data in the order of the files, then stimuli, as presented
indcell = {};                                          %placeholder for incoming individual participant data, will be stored in cell array as different participants will have different numbers of trials
inddata = [];                                          %place holder for incoming mean individual data, this is a standard array as each participant will have 1 mean, 1 std for each condition.
for j = 1:size(id,2)                                   %loop iterating through individual data directories
    filelist = ls(fullfile(direc,id{j},'*log'));       %list the files in the directory that end with the .log extension
    indalltrials = [];                                 %placeholder for incoming data
    for i = 1:size(filelist,1)                         %loop to process files
        [struct, cond] = importPresentationLog(fullfile(direc,id{j},filelist(i,:))); %load the files
        
        if isfield(cond,'code')                        %make sure file actually has data by checking if the appropriate fields exist, if not do nothing, go to the next file
            responseidx = find(strcmp('1',cond.code)); %!!!my code looks for responses, not stimuli!!!
            
            if responseidx(1) == 1                     %if a response was the first thing in the file
                responseidx = responseidx(2:end);      %dump it, there was no preceding stimulus...
            end
            
            tempdata = [];                             %another temporary placeholder for incoming data
            tempdata(:,1) = str2double(cond.code(responseidx-1)); %take the event code from the event preceding the response (if a person clicks twice the second click is given a click code, not a stim!)
            tempdata(:,2) = cond.ttime(responseidx)/10;           %take the ttime from the response, divide by 10 to give in ms
            for p = 1:length(responseidx)                         %this loop manages the extraction of the ISI for each trial
                if responseidx(p) == 2                            %however, if it was the first stimulus, there was no ISI...
                    tempdata(p,3) = 0;                            %so set the ISI to zero
                else                                              %otherwise...
                    tempdata(p,3) = (cond.time(responseidx(p))-cond.time(responseidx(p)-2))/10; %The ISI is calculated from the time stamps on the events in the .log file.
                end
            end
            indalltrials = vertcat(indalltrials,tempdata); %concatenate temporary array to growing data array
            
            data = vertcat(data,tempdata);                 %concatenate the temporary data to the growing data array
        end
        
    end
    alltrials{j,:} = indalltrials; %Stores all individual trial data for each participant for each individual array the dimensions are - trials x [trigger-value reaction-time ISI-from-prev-stim]
    
    indremoveidx = find(indalltrials(:,2)<removethresh); %NOTE: WE ARE STILL INSIDE THE INDIVIDUAL PARTICIPANT LOOP; for this participant, find the trials where the response was less than removethresh
    indpossible = indalltrials;                          %create a new array that will only have realistic responses
    indpossible(indremoveidx,:) = [];                    %remove the unrealistic responses
    
    indcell{j} = indpossible;                            %store the individual participant realistic data in the growing "indcell" cell array, which will contain all individual trial data for all participants
    
    for k = 1:nconds                                     %calculate the mean reaction times across participants for each condition
        indcondidx = find(indpossible(:,1)==k-1);
        inddata(j,k,:) = [mean(indpossible(indcondidx,2)) std(indpossible(indcondidx,2)) length(indcondidx)]; %store the mean reaction times for each participant for each condition in the inddata array
    end

    %virtualconditions - the next three loops manage the creation of what
    %I'm calling "virual conditions", these are merely lumping all of the
    %presentations of each stimulus type A, V, AV into a single respective
    %condition (i.e. I'm throwing out the trial history considerations, so
    %A-A, V-A, and AV-A, all get lumped into mixed-A). This occurs so that
    %a mean reaction time for the mixed conditions can be quickly computed
    %at the individual level and added to the "inddata" array.
    
    %mixaud
    coi = [5 6 7];
    tempcat = [];
    for i = 1:length(coi)
        temp = [];
        temp = indpossible(find(indpossible(:,1)==coi(i)),2);
        tempcat = vertcat(tempcat,temp);
    end
    inddata(j,nconds+1,:) = [mean(tempcat) std(tempcat) length(tempcat)];
        
    %mixvis
    coi = [8 9 10];
    tempcat = [];
    for i = 1:length(coi)
        temp = [];
        temp = indpossible(find(indpossible(:,1)==coi(i)),2);
        tempcat = vertcat(tempcat,temp);
    end
    inddata(j,nconds+2,:) = [mean(tempcat) std(tempcat) length(tempcat)];
    
    %mixav
    coi = [11 12 13];
    tempcat = [];
    for i = 1:length(coi)
        temp = [];
        temp = indpossible(find(indpossible(:,1)==coi(i)),2);
        tempcat = vertcat(tempcat,temp);
    end
    inddata(j,nconds+3,:) = [mean(tempcat) std(tempcat) length(tempcat)];
    
    %switch AV
    coi = [11 13];
    tempcat = [];
    for i = 1:length(coi)
        temp = [];
        temp = indpossible(find(indpossible(:,1)==coi(i)),2);
        tempcat = vertcat(tempcat,temp);
    end
    inddata(j,nconds+4,:) = [mean(tempcat) std(tempcat) length(tempcat)];
    
end %THIS IS THE END OF THE INDIVIDUAL PARTICIPANT LOOP, once this loop completes all of the individual participant data has been extracted and organized.

allremoveidx = find(data(:,2)<removethresh);       %This removes unrealistic responses from the "data" array, which contains ALLLLLL of the trials from all participants, just a big 'ol pile 'o trials
allpossibledata = data;
allpossibledata(allremoveidx,:) = [];              %We're not going to do anything meaningful with this data yet, but it's cool to look at the data from this perspective (all trials drawn from one big distribution)

allmeandata = [];                                  %create array for averages, again this is for the pile 'o trials data, which we won't be doing much with
for i = 1:nconds                                   %for every condition
    allcondidx = find(allpossibledata(:,1)==i-1);
    allmeandata(i,:) = [mean(allpossibledata(allcondidx,2)) std(allpossibledata(allcondidx,2)) length(allcondidx)]; %take the mean of the data for each condition (first column), the SD (second column, and give the n (third)
end

%%%%%%%%%%%%
%%PHASE II%%
%%%%%%%%%%%%

% With the data extracted from the .log files, it is now time to sort
% the individual participant data into their respective conditions
% the cells below contain, for each participant, all of the trials with
% realistic reaction times for that condition, sorted by participant

for i = 1:length(indcell)
    pureAcell{i} = indcell{i}(find(indcell{i}(:,1)==2),:);
    pureVcell{i} = indcell{i}(find(indcell{i}(:,1)==3),:);
    pureAVcell{i} = indcell{i}(find(indcell{i}(:,1)==4),:);
    V2Acell{i} = indcell{i}(find(indcell{i}(:,1)==5),:);
    AV2Acell{i} = indcell{i}(find(indcell{i}(:,1)==6),:);
    A2Acell{i} = indcell{i}(find(indcell{i}(:,1)==7),:);
    V2Vcell{i} = indcell{i}(find(indcell{i}(:,1)==8),:);
    AV2Vcell{i} = indcell{i}(find(indcell{i}(:,1)==9),:);
    A2Vcell{i} = indcell{i}(find(indcell{i}(:,1)==10),:);
    V2AVcell{i} = indcell{i}(find(indcell{i}(:,1)==11),:);
    AV2AVcell{i} = indcell{i}(find(indcell{i}(:,1)==12),:);
    A2AVcell{i} = indcell{i}(find(indcell{i}(:,1)==13),:);
    mixAcell{i} = vertcat(V2Acell{i}, AV2Acell{i}, A2Acell{i});
    mixVcell{i} = vertcat(V2Vcell{i}, AV2Vcell{i}, A2Vcell{i});
    mixAVcell{i} = vertcat(V2AVcell{i}, AV2AVcell{i}, A2AVcell{i});
    switchAVcell{i} = vertcat(V2AVcell{i}, A2AVcell{i});
end


%%%%%%%%%%%%%
%%PHASE III%%
%%%%%%%%%%%%%

% With the data now sorted by individual and condition, it is now time to
% calculate the participant level eCDFs

%In order to compute our eCDFs we need to determine, for each participant,
%for each condition, what is the fraction of datapoints that is below a
%reaction time latency (t).

evalat = 100:1:500; %evalat gives us the reaction time latencies at which we will compute our eCDF for each participant, this is just a linearly spaced array from 100 to 500 in increments of 1
invarlist = {'mixAcell' 'mixVcell' 'mixAVcell' 'A2Acell' 'V2Vcell' 'AV2AVcell' 'pureAcell' 'pureVcell' 'pureAVcell' 'V2Acell' 'A2Vcell' 'switchAVcell'}; %got fancy with the subsequent loops, LEARN TO USE "evalin" and "assignin" functions!!!!!
outvarlist = {'mixAecdf' 'mixVecdf' 'micAVecdf' 'A2Aecdf' 'V2Vecdf' 'AV2AVecdf' 'pureAecdf' 'pureVecdf' 'pureAVecdf' 'V2Aecdf' 'A2Vecdf' 'switchAVecdf'};%these two functions reduced the number of lines of code needed to do these evaluations by ~100!!
for i = 1:length(invarlist)      %for the length the list of input varibles (so, iterate over each of these variable names please)
   tcell = evalin('base',invarlist{i});
    for j = 1:length(tcell)      %for the number of entries in that cell (which will be the number of participants)
        for k = 1:length(evalat) %for the length of evalat, which will be the same for everyone
            temp_ecdf(j,k) = size(find(tcell{j}(:,2)<=evalat(k)),1)/length(tcell{j}); %find the cumulative probability at each time point! !!eCDF CALCULATED HERE!!
        end    
    end
    assignin('base', outvarlist{i}, temp_ecdf); %again, learn these functions, so damn handy
end

%the subsequent code calculates the RACE model eCDF trace for each
%participant, with and without the assumption of channel independence
%the RACE models without the assumption of indepence occur fist, followed
%by the loops which calculate the RACE model with the assumption of
%independence
%These loops could have been done with evalin and assignin functions again,
%but there were only 3, so I just wrote them out...
mixSUMecdf = mixAecdf + mixVecdf;   %WITHOUT assumption of independence
for i = 1:size(mixAecdf,1)          %WITH assumption of independence
    for j = 1:size(mixAecdf,2)
        mixSUMindecdf(i,j) = (mixAecdf(i,j) + mixVecdf(i,j)) - (mixAecdf(i,j)*mixVecdf(i,j)) ; %the name of the variable is to indicate: "mixed stims", SUM of unisensory eCDFs, assumption of independence, eCDF
    end
end

pureSUMecdf = pureAecdf + pureVecdf;%WITHOUT assumption of independence
for i = 1:size(pureAecdf,1)         %WITH assumption of independence
    for j = 1:size(pureAecdf,2)
        pureSUMindecdf(i,j) = (pureAecdf(i,j) + pureVecdf(i,j)) - (pureAecdf(i,j)*pureVecdf(i,j)) ; % "pure stims", SUM of unisensory eCDFs, assumption of channel independence, eCDF
    end
end

repeatSUMecdf = A2Aecdf + V2Vecdf;
for i = 1:size(A2Aecdf,1)
    for j = 1:size(A2Aecdf,2)
        repeatSUMindecdf(i,j) = (A2Aecdf(i,j) + V2Vecdf(i,j)) - (A2Aecdf(i,j)*V2Vecdf(i,j)) ; 
    end
end

switchSUMecdf = A2Vecdf + V2Aecdf;
for i = 1:size(A2Vecdf,1)
    for j = 1:size(A2Vecdf,2)
        switchSUMindecdf(i,j) = (A2Vecdf(i,j) + V2Aecdf(i,j)) - (A2Vecdf(i,j)*V2Aecdf(i,j));
    end
end

%The next loop allows us to test for significant violations of the race
%model using the "horizontal" test. We will test for violations at the
%quantiles listed in the subsequent variable "percentiles". The loop
%immediately following this comment serves to give us the threshold
%crossings for each participant for each percentile. That is; the loop
%gives us the time (t) at which each participan's individual eCDF crossed the
%threshold percentile (p).

percentiles = [.05 .1 .15 .2 .25 .3 .35 .4 .45 0.5 0.55 0.6 0.65 0.7];
invarlist = {'micAVecdf' 'mixSUMecdf' 'mixSUMindecdf' 'AV2AVecdf' 'repeatSUMecdf' 'repeatSUMindecdf' 'pureAVecdf' 'pureSUMecdf' 'pureSUMindecdf' 'switchAVecdf' 'switchSUMecdf' 'switchSUMindecdf'};
outvarlist = {'mixAVtimes' 'mixSUMtimes' 'mixSUMindtimes' 'AV2AVtimes' 'repeatSUMtimes' 'repeatSUMindtimes' 'pureAVtimes' 'pureSUMtimes' 'pureSUMindtimes' 'switchAVtimes' 'switchSUMtimes' 'switchSUMindtimes'};
for i = 1:length(invarlist)
    tdat = evalin('base',invarlist{i});
    for j = 1:size(tdat,1)
        for k = 1:length(percentiles)
            temp_out(j,k) = evalat(find(tdat(j,:)>percentiles(k),1));
        end
    end
    assignin('base',outvarlist{i}, temp_out);
end

%WE NOW TEST SIGNIFICANCE against the RACE models that assume independence as
%well as those that don't...

%VERY IMPORTANTLY, the stats are ONE-TAILED t-test's. We are not looking 
%to see if the mean of the response latencies for a particular condition 
%at a particular percentile crossing are drawn from a different 
%distribution, but are instead looking to see if the mean of response 
%latencies at the percentile crossings for the AV stimulus are LESS THAN 
%the mean of the RACE model percentile crossings

%all trials mixed, mixed blocks
for i = 1:length(percentiles)   %testing significance NOT assuming indep
    [mixedh(i), mixpvals(i)] = ttest(mixAVtimes(:,i),mixSUMtimes(:,i),'Tail','left'); %p-values at each percentile are contained in the mixpvals array
end
for i = 1:length(percentiles)   %testing significance assuming indep
    [mixedindh(i) mixindpvals(i)] = ttest(mixAVtimes(:,i),mixSUMindtimes(:,i),'Tail','left'); %p-values at each percentile are contained in the mixindpvals array
end
%considering only repeat trials, mixed blocks
for i = 1:length(percentiles)   %testing significance NOT assming ind
    [repeath(i), repeatpvals(i)] = ttest(AV2AVtimes(:,i),repeatSUMtimes(:,i),'Tail','left'); %p-values at each percentile are contained in the repeatpvals array
end
for i = 1:length(percentiles)   %testing significance assuming ind
    [repeatindh(i), repeatindpvals(i)] = ttest(AV2AVtimes(:,i),repeatSUMindtimes(:,i),'Tail','left'); %p-values at each percentile are contained in the repeatindpvals array
end
%considering only pure trials, pure blocks
for i = 1:length(percentiles)
    [pureh(i), purepvals(i)] = ttest(pureAVtimes(:,i),pureSUMtimes(:,i),'Tail','left'); %p-values at each percentile are contained in the purepvals array
end
for i = 1:length(percentiles)
    [pureindh(i), pureindpvals(i)] = ttest(pureAVtimes(:,i),pureSUMindtimes(:,i),'Tail','left'); %p-values at each percentile are contained in the pureindpvals array
end
%considering switch trials, mixed blocks
for i = 1:length(percentiles)
    [switchh(i), switchpvals(i)] = ttest(switchAVtimes(:,i),switchSUMtimes(:,i),'Tail','left'); %p-values at each percentile are contained in the purepvals array
end
for i = 1:length(percentiles)
    [switchindh(i), switchindpvals(i)] = ttest(switchAVtimes(:,i),switchSUMindtimes(:,i),'Tail','left'); %p-values at each percentile are contained in the pureindpvals array
end

