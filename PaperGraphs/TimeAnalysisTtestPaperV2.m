% this module should be run after SMARTeCDFs.m to have all the data related
% to any individual preloaded to Matlab, it also uses CDFcomparitorV2.m
% function to calculate emperical CDF of any three combination of commands
% with the same basis. It will generate plot to make comparision for
% individuals selected by j 
ncond=13;
CDFsteps=0.1;
percentiles = [.05 .1 .15 .2 .25 .3 .35 .4 .45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95];
alphath= 0.05;
AVvarlist = {'htpureAV' 'htmultiA_AV' 'htmultiAV_AV' 'htmultiV_AV' 'htrepeatAV' 'htclassAV'}; % these are list of CDF variables calculated in the TimeAnalysisAveragePaper 
RM1varlist= {'htpureRM' 'htmultipsA_RM'  'htmultipsAV_RM'  'htmultipsV_RM' 'htrepeat_RM'  'htclassical_RM'};
RM2varlist={'htpureIRM' 'htmultipsA_IRM' 'htmultipsAV_IRM' 'htmultipsV_IRM' 'htrepeat_IRM' 'htclassical_IRM'};
evalptslist={'cdevalptspure' 'cdevalptsmultipsA' 'cdevalptsmultipsAV'  'cdevalptsmultipsV' 'cdevalptsrepeat' 'cdevalptsclassical'};

AVperctimevarlist = {'pureAV_perctime' 'multiA_AV_perctime' 'multiAV_AV_perctime' 'multiV_AV_perctime' 'repeatAV_perctime' 'classAV_perctime'}; % this is the time the CDF variables reach to specific percetiles
RM1perctimevarlist = {'pureRM_perctime' 'multipsA_RM_perctime'  'multipsAV_RM_perctime'  'multipsV_RM_perctime' 'repeat_RM_perctime'  'classical_RM_perctime'}; % these are the time the Race Model reach to specific percetiles
RM2perctimevarlist = {'pureIRM_perctime' 'multipsA_IRM_perctime' 'multipsAV_IRM_perctime' 'multipsV_IRM_perctime' 'repeat_IRM_perctime' 'classical_IRM_perctime'};

PvalueRM1varlist={'pureAV_PvalRM1' 'multiA_AV_PvalRM1' 'multiAV_AV_PvalRM1' 'multiV_AV_PvalRM1' 'repeatAV_PvalRM1' 'classAV_PvalRM1'}; % this is the time the CDF variables reach to specific percetiles
HvalueRM1varlist={'pureAV_HvalRM1' 'multiA_AV_HvalRM1' 'multiAV_AV_HvalRM1' 'multiV_AV_HvalRM1' 'repeatAV_HvalRM1' 'classAV_HvalRM1'}; % this is the time the CDF variables reach to specific percetiles
PvalueRM2varlist={'pureAV_PvalRM2' 'multiA_AV_PvalRM2' 'multiAV_AV_PvalRM2' 'multiV_AV_PvalRM2' 'repeatAV_PvalRM2' 'classAV_PvalRM2'}; % this is the time the CDF variables reach to specific percetiles
HvalueRM2varlist={'pureAV_HvalRM2' 'multiA_AV_HvalRM2' 'multiAV_AV_HvalRM2' 'multiV_AV_HvalRM2' 'repeatAV_HvalRM2' 'classAV_HvalRM2'}; % this is the time the CDF variables reach to specific percetiles


Outdir = uigetdir('D:\Arian\Projects\SMART\Outputs\mintAtBHypoth\Average\T-testPaper','Select Output Directory for the Graphs!'); % this is the directory the output figures will be saved to
%##### initializing the vectors that stores all individual analysis ########
%%%### initializing  the vectors  initializing  the vectors     ########
htpureA=cell(size(id,2),1);
htpureV=cell(size(id,2),1);
htpureAV=cell(size(id,2),1);
htpureIRM=cell(size(id,2),1);
htpureRM=cell(size(id,2),1);
cdevalptspure=cell(size(id,2),1);

htmultiA_A=cell(size(id,2),1);
htmultiA_V=cell(size(id,2),1);
htmultiA_AV=cell(size(id,2),1);
htmultipsA_IRM=cell(size(id,2),1);
htmultipsA_RM=cell(size(id,2),1);
cdevalptsmultipsA=cell(size(id,2),1);

htmultiAV_A=cell(size(id,2),1);
htmultiAV_V=cell(size(id,2),1);
htmultiAV_AV=cell(size(id,2),1);
htmultipsAV_IRM=cell(size(id,2),1);
htmultipsAV_RM=cell(size(id,2),1);
cdevalptsmultipsAV=cell(size(id,2),1);

htmultiV_A=cell(size(id,2),1);
htmultiV_V=cell(size(id,2),1);
htmultiV_AV=cell(size(id,2),1);
htmultipsV_IRM=cell(size(id,2),1);
htmultipsV_RM=cell(size(id,2),1);
cdevalptsmultipsV=cell(size(id,2),1);

htrepeatA=cell(size(id,2),1);
htrepeatV=cell(size(id,2),1);
htrepeatAV=cell(size(id,2),1);
htrepeat_IRM=cell(size(id,2),1);
htrepeat_RM=cell(size(id,2),1);
cdevalptsrepeat=cell(size(id,2),1);

htclassA=cell(size(id,2),1);
htclassV=cell(size(id,2),1);
htclassAV=cell(size(id,2),1);
htclassical_IRM=cell(size(id,2),1);
htclassical_RM=cell(size(id,2),1);
cdevalptsclassical=cell(size(id,2),1);

%%%end setting the vectors

% pureh=zeros((size(id,2)),length(percentiles));
% purepvals=zeros((size(id,2)),length(percentiles));
% 
% repeath=zeros((size(id,2)),length(percentiles));
% repeatPvals=zeros((size(id,2)),length(percentiles));
% 
% multiA_h=zeros((size(id,2)),length(percentiles));
% multiA_pvals=zeros((size(id,2)),length(percentiles));
% 
% multiAV_h=zeros((size(id,2)),length(percentiles));
% multiAV_pvals=zeros((size(id,2)),length(percentiles));
% 
% multiV_h=zeros((size(id,2)),length(percentiles));
% multiV_pvals=zeros((size(id,2)),length(percentiles));
% 
% %%%%%%%%%%%%%%%%%%%%%%
% pureSimRMh=zeros((size(id,2)),length(percentiles));
% pureSimRMpvals=zeros((size(id,2)),length(percentiles));
% 
% repeatSimRMh=zeros((size(id,2)),length(percentiles));
% repeatSimRMPvals=zeros((size(id,2)),length(percentiles));
% 
% multiA_SimRMh=zeros((size(id,2)),length(percentiles));
% multiA_SimRMpvals=zeros((size(id,2)),length(percentiles));
% 
% multiAV_SimRMh=zeros((size(id,2)),length(percentiles));
% multiAV_SimRMpvals=zeros((size(id,2)),length(percentiles));
% 
% multiV_SimRMh=zeros((size(id,2)),length(percentiles));
% multiV_SimRMpvals=zeros((size(id,2)),length(percentiles));

%################   Individual CDFs, Race Model calculation  ####################
%############################################################
indconditionedcell=cell(ncond,1);% conditioned individual cell
for j=1:size(id,2), % the index of individual in the indcell

    for cond=2:ncond,
        condindx=find(indcell{j}(:,1)==cond);
        indconditionedcell{cond}=indcell{j}(condindx,2);
    end

    %%%%%%%Fig 2%%%%%%%%%%%%%
    focusconds=[2,3,4];
    condA=focusconds(1);
    condB=focusconds(2);
    condC=focusconds(3);
    [cdevalpts,htA,htB,htC,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcelltA,sortedcelltB,sortedcelltC,sortedcelltIRM,sortedcellSimRM]=CDFcomparitorV2(condA,condB,condC, indconditionedcell,CDFsteps);
       
    hRM=htA+htB;
    hRM(hRM>1)=1;
    
    htpureA{j}=htA;
    htpureV{j}=htB;
    htpureAV{j}=htC;
    htpureIRM{j}=h_min_tAtB;
    htpureRM{j}=hRM;
    cdevalptspure{j}=cdevalpts;

    
    for k = 1:length(percentiles),   %testing significance NOT assuming indep
        indemp=find(htC>percentiles(k),1);
        indcalIRM=find(htIRM>percentiles(k),1);
        tempthr=cdevalpts(indemp);
        tIRMthr=cdevalpts(indcalIRM);
        [pureh(j,k), purepvals(j,k)] = ttest2(sortedcelltC(sortedcelltC<tempthr),sortedcelltIRM(sortedcelltIRM<tIRMthr),'Tail','left'); %p-values at each percentile are contained in the mixpvals array
 %      [pureh(j,k), purepvals(j,k)] = ttest2(sortedcelltC,sortedcelltIRM,'Tail','left'); %p-values at each percentile are contained in the mixpvals array
    end
    
    %Test the alternative hypothesis that the population mean of sortedcelltC is less than the population mean of sortedcellSimRM.           

    for k = 1:length(percentiles),   %testing significance NOT assuming indep
        indemp=find(htC>percentiles(k),1);
        indcalSRM=find(hRM>percentiles(k),1);
        tempthr=cdevalpts(indemp);
        tSRMthr=cdevalpts(indcalSRM);
        [pureSimRMh(j,k), pureSimRMpvals(j,k)] = ttest2(sortedcelltC(sortedcelltC<tempthr),sortedcellSimRM(sortedcellSimRM<tSRMthr),'Tail','left'); %p-values at each percentile are contained in the mixpvals array
    end

    
    
    %%%%%%%Fig 2%%%%%%%%%%%%%
    focusconds=[7,10,13];
    condA=focusconds(1);
    condB=focusconds(2);
    condC=focusconds(3);
    [cdevalpts,htA,htB,htC,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcelltA,sortedcelltB,sortedcelltC,sortedcelltIRM,sortedcellSimRM]=CDFcomparitorV2(condA,condB,condC, indconditionedcell,CDFsteps);
    hRM=htA+htB;
    hRM(hRM>1)=1;
    
    htmultiA_A{j}=htA;
    htmultiA_V{j}=htB;
    htmultiA_AV{j}=htC;
    htmultipsA_IRM{j}=h_min_tAtB;
    htmultipsA_RM{j}=hRM;
    cdevalptsmultipsA{j}=cdevalpts;
         

    %%%%%%%Fig 3%%%%%%%%%%%%%%%    
    focusconds=[6,9,12];
    condA=focusconds(1);
    condB=focusconds(2);
    condC=focusconds(3);
    [cdevalpts,htA,htB,htC,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcelltA,sortedcelltB,sortedcelltC,sortedcelltIRM,sortedcellSimRM]=CDFcomparitorV2(condA,condB,condC, indconditionedcell,CDFsteps);
    hRM=htA+htB;
    hRM(hRM>1)=1;
    
    htmultiAV_A{j}=htA;
    htmultiAV_V{j}=htB;
    htmultiAV_AV{j}=htC;
    htmultipsAV_IRM{j}=h_min_tAtB;
    htmultipsAV_RM{j}=hRM;
    cdevalptsmultipsAV{j}=cdevalpts;
    
   
    %%%%%%%Fig 4%%%%%%%%%%%%%%%    
    focusconds=[5,8,11];
    condA=focusconds(1);
    condB=focusconds(2);
    condC=focusconds(3);
    [cdevalpts,htA,htB,htC,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcelltA,sortedcelltB,sortedcelltC,sortedcelltIRM,sortedcellSimRM]=CDFcomparitorV2(condA,condB,condC, indconditionedcell,CDFsteps);
    hRM=htA+htB;
    hRM(hRM>1)=1;
    
    htmultiV_A{j}=htA;
    htmultiV_V{j}=htB;
    htmultiV_AV{j}=htC;
    htmultipsV_IRM{j}=h_min_tAtB;
    htmultipsV_RM{j}=hRM;
    cdevalptsmultipsV{j}=cdevalpts;
       

    %%%%%%%Fig 5%%%%%%%%%%%%%%% 
    focusconds=[7,8,12];
    condA=focusconds(1);
    condB=focusconds(2);
    condC=focusconds(3);
    [cdevalpts,htA,htB,htC,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcelltA,sortedcelltB,sortedcelltC,sortedcelltIRM,sortedcellSimRM]=CDFcomparitorV2(condA,condB,condC, indconditionedcell,CDFsteps);
    hRM=htA+htB;
    hRM(hRM>1)=1;
    
    htrepeatA{j}=htA;
    htrepeatV{j}=htB;
    htrepeatAV{j}=htC;
    htrepeat_IRM{j}=h_min_tAtB;
    htrepeat_RM{j}=hRM;
    cdevalptsrepeat{j}=cdevalpts;
 
    %%%%%%%%%%%%% Figure 6 - Classical Approach %%%%%%%%%%%%%%%%%%%%%%%
%For combined conditions, we need to:  1-build the combined condition cells
%ourselves  2-use CDFcomparitoGeneral

comcondA=[7,5,6]; %A-A , V-A, AV-A
comcondB=[10,8,9]; % A-V, V-V,  AV-V
comcondC=[13,11,12]; %A-AV, v-AV, AV-AV

mixedcellA=[];
mixedcellB=[];
mixedcellC=[];

for ind=1:length(comcondA),
 mixedcellA=[mixedcellA; indconditionedcell{comcondA(ind)}];
end 
for ind=1:length(comcondB),
 mixedcellB=[mixedcellB; indconditionedcell{comcondB(ind)}];
end 
for ind=1:length(comcondC),
 mixedcellC=[mixedcellC; indconditionedcell{comcondC(ind)}];
end 

sortedcelltA=sort(mixedcellA); % sort conditioned cell
sortedcelltB=sort(mixedcellB); % sort conditioned cell
sortedcelltC=sort(mixedcellC); % sort conditioned cell

[cdevalpts,htA,htB,htC,hRM,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcellIRM,sortedcellSimRM] = CDFcomparitorGeneral(sortedcelltA,sortedcelltB,sortedcelltC,CDFsteps );

htclassA{j}=htA;
htclassV{j}=htB;
htclassAV{j}=htC;
htclassical_IRM{j}=h_min_tAtB;
htclassical_RM{j}=hRM;
cdevalptsclassical{j}=cdevalpts;  

end % for 1:size(id,2)..
%################ END CDFs, Race Model calculation
%###########################

%############### recursive time calculation for each percentile
%###########
for i = 1:length(AVvarlist)
    AVCDFdat = evalin('base',AVvarlist{i});
    RM1CDFdat = evalin('base',RM1varlist{i});
    RM2CDFdat = evalin('base',RM2varlist{i});
    evalptsdat = evalin('base',evalptslist{i}); %  evalptsdat is a cell each belong to one individual participants 
    
    tempAV_out=zeros(size(id,2),length(percentiles));
    tempRM1_out=zeros(size(id,2),length(percentiles));
    tempRM2_out=zeros(size(id,2),length(percentiles));
    
    for j=1:size(id,2), % the index of individual in the indcell
        for k = 1:length(percentiles),
            tempAV_out(j,k) = evalptsdat{j}(find(AVCDFdat{j}>percentiles(k),1)); % identify the first index where AVCDFdat becomes greater than percentiles
            tempRM1_out(j,k) = evalptsdat{j}(find(RM1CDFdat{j}>percentiles(k),1)); % identify the first index where AVCDFdat becomes greater than percentiles
            tempRM2_out(j,k) = evalptsdat{j}(find(RM2CDFdat{j}>percentiles(k),1)); % identify the first index where AVCDFdat becomes greater than percentiles       
        end      
    end  
    
    assignin('base',AVperctimevarlist{i}, tempAV_out);
    assignin('base',RM1perctimevarlist{i}, tempRM1_out);
    assignin('base',RM2perctimevarlist{i}, tempRM2_out);       
      
end

for i = 1:length(AVvarlist),
    AVperctime=evalin('base',AVperctimevarlist{i});
    RM1perctime=evalin('base',RM1perctimevarlist{i});
    RM2perctime=evalin('base',RM2perctimevarlist{i});
    
    temphvec_RM1=zeros(size(percentiles));
    temppvec_RM1=zeros(size(percentiles));
    temphvec_RM2=zeros(size(percentiles));
    temppvec_RM2=zeros(size(percentiles));
    for k=1:length(percentiles),
        [p1,h1] = ttest2(AVperctime(:,k),RM1perctime(:,k),'Tail','left','Vartype','equal','Alpha',alphath);  % if AV response is less than RM1 it is a significant violation.  
        [p2,h2] = ttest2(AVperctime(:,k),RM2perctime(:,k),'Tail','both','Vartype','equal','Alpha',alphath);  % if they are not equal to each other, 'unequal' with the assumption that not from same 
        temphvec_RM1(k)=h1;
        temppvec_RM1(k)=p1;
        temphvec_RM2(k)=h2;
        temppvec_RM2(k)=p2;        
    end
    
    assignin('base',PvalueRM1varlist{i}, temphvec_RM1);
    assignin('base',HvalueRM1varlist{i}, temppvec_RM1);
    
    
    assignin('base',PvalueRM2varlist{i}, temphvec_RM2);
    assignin('base',HvalueRM2varlist{i}, temppvec_RM2);     
end    

%############### end recursive time calculation for each percentile
%###########

% Condition names    
% 0		Presentation Error
% 1		Response
% 2		Pure Audio
% 3		Pure Visual
% 4		Pure AudioVisual
% 5		V -> A
% 6		AV -> A
% 7		A -> A
% 8		V -> V
% 9		AV -> V
% 10		A -> V
% 11		V -> AV
% 12		AV -> AV
% 13		A -> AV


%Possible useful function:
% kernel PDF estimation from a data set
%[f,xi] = ksdensity(x);
%[f,xi] = ksdensity(x,pts);  %specify the sample point

% histogram PDF;
% [counts binCenters] = hist(yourData, 256); % Use 256 bins. 
% plot(binCenters, counts);

%plot derivative of a function
%dydx = diff(y(:))./diff(x(:));