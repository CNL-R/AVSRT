% this module should be run after SMARTeCDFs.m to have all the data related
% to any individual preloaded to Matlab, it also uses CDFcomparitorV2.m
% function to calculate emperical CDF of any three combination of commands
% with the same basis. It will generate plot to make comparision for
% individuals selected by j 

ncond=13;
CDFsteps=0.1;
percentiles = [.05 .1 .15 .2 .25 .3 .35 .4 .45 0.5 0.55 0.6 0.65 0.7 0.75 0.8];

Outdir = uigetdir('D:\Arian\Projects\SMART\Outputs\mintAtBHypoth\Individual\','Select Output Directory for the Graphs!'); % this is the directory the output figures will be saved to
%##### initializing the vectors that stores all individual analysis ########
%%%### initializing  the vectors  initializing  the vectors     ########
htpureA=cell(size(id,2),1);
htpureV=cell(size(id,2),1);
htpureAV=cell(size(id,2),1);
htpuremin_tAtB=cell(size(id,2),1);
htpureRM=cell(size(id,2),1);
cdevalptspure=cell(size(id,2),1);

puremeanA=zeros(1,(size(id,2)));
puremedA=zeros(1,(size(id,2)));
purestdA=zeros(1,(size(id,2)));
puremeanV=zeros(1,(size(id,2)));
puremedV=zeros(1,(size(id,2)));
purestdV=zeros(1,(size(id,2)));
puremeanAV=zeros(1,(size(id,2)));
puremedAV=zeros(1,(size(id,2)));
purestdAV=zeros(1,(size(id,2)));

htmultiA_A=cell(size(id,2),1);
htmultiA_V=cell(size(id,2),1);
htmultiA_AV=cell(size(id,2),1);
htmultipsA_min=cell(size(id,2),1);
htmultipsA_RM=cell(size(id,2),1);
cdevalptsmultipsA=cell(size(id,2),1);

multimeanA_A=zeros(1,(size(id,2)));
multimedA_A=zeros(1,(size(id,2)));
multistdA_A=zeros(1,(size(id,2)));
multimeanA_V=zeros(1,(size(id,2)));
multimedA_V=zeros(1,(size(id,2)));
multistdA_V=zeros(1,(size(id,2)));
multimeanA_AV=zeros(1,(size(id,2)));
multimedA_AV=zeros(1,(size(id,2)));
multistdA_AV=zeros(1,(size(id,2)));

htmultiAV_A=cell(size(id,2),1);
htmultiAV_V=cell(size(id,2),1);
htmultiAV_AV=cell(size(id,2),1);
htmultipsAV_min=cell(size(id,2),1);
htmultipsAV_RM=cell(size(id,2),1);
cdevalptsmultipsAV=cell(size(id,2),1);

multimeanAV_A=zeros(1,(size(id,2)));
multimedAV_A=zeros(1,(size(id,2)));
multistdAV_A=zeros(1,(size(id,2)));
multimeanAV_V=zeros(1,(size(id,2)));
multimedAV_V=zeros(1,(size(id,2)));
multistdAV_V=zeros(1,(size(id,2)));
multimeanAV_AV=zeros(1,(size(id,2)));
multimedAV_AV=zeros(1,(size(id,2)));
multistdAV_AV=zeros(1,(size(id,2)));

htmultiV_A=cell(size(id,2),1);
htmultiV_V=cell(size(id,2),1);
htmultiV_AV=cell(size(id,2),1);
htmultipsV_min=cell(size(id,2),1);
htmultipsV_RM=cell(size(id,2),1);
cdevalptsmultipsV=cell(size(id,2),1);

multimeanV_A=zeros(1,(size(id,2)));
multimedV_A=zeros(1,(size(id,2)));
multistdV_A=zeros(1,(size(id,2)));
multimeanV_V=zeros(1,(size(id,2)));
multimedV_V=zeros(1,(size(id,2)));
multistdV_V=zeros(1,(size(id,2)));
multimeanV_AV=zeros(1,(size(id,2)));
multimedV_AV=zeros(1,(size(id,2)));
multistdV_AV=zeros(1,(size(id,2)));
%%%end setting the vectors

pureh=zeros((size(id,2)),length(percentiles));
purepvals=zeros((size(id,2)),length(percentiles));

repeath=zeros((size(id,2)),length(percentiles));
repeatPvals=zeros((size(id,2)),length(percentiles));

multiA_h=zeros((size(id,2)),length(percentiles));
multiA_pvals=zeros((size(id,2)),length(percentiles));

multiAV_h=zeros((size(id,2)),length(percentiles));
multiAV_pvals=zeros((size(id,2)),length(percentiles));

multiV_h=zeros((size(id,2)),length(percentiles));
multiV_pvals=zeros((size(id,2)),length(percentiles));

%%%%%%%%%%%%%%%%%%%%%%
pureSimRMh=zeros((size(id,2)),length(percentiles));
pureSimRMpvals=zeros((size(id,2)),length(percentiles));

repeatSimRMh=zeros((size(id,2)),length(percentiles));
repeatSimRMPvals=zeros((size(id,2)),length(percentiles));

multiA_SimRMh=zeros((size(id,2)),length(percentiles));
multiA_SimRMpvals=zeros((size(id,2)),length(percentiles));

multiAV_SimRMh=zeros((size(id,2)),length(percentiles));
multiAV_SimRMpvals=zeros((size(id,2)),length(percentiles));

multiV_SimRMh=zeros((size(id,2)),length(percentiles));
multiV_SimRMpvals=zeros((size(id,2)),length(percentiles));

%################   Individual Analysis  ####################
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
    htpuremin_tAtB{j}=h_min_tAtB;
    htpureRM{j}=hRM;
    cdevalptspure{j}=cdevalpts;

    puremeanA(j)=meanA;
    puremedA(j)=medA;
    purestdA(j)=stdA;
    puremeanV(j)=meanB;
    puremedV(j)=medB;
    purestdV(j)=stdB;
    puremeanAV(j)=meanC;
    puremedAV(j)=medC;
    purestdAV(j)=stdC; 
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
    
%     Hfig1=figure;  
%     plot(cdevalpts,hRM,'-.c','LineWidth',2);
%     hold on;
%     plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
%     plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
%     plot(cdevalpts,htA,'--m','LineWidth',2);
%     plot(cdevalpts,htB,'-.g','LineWidth',2);
%     axis([100 400 -inf inf]);
%     legend('RM','AV response','min(tA,tV)','Audio','Visual');
%     xlabel('Response delay ms');
%     ylabel('CDF');
%     title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-pure mode A-A,V-V,AV-AV, ',' for individual: ',strjoin(id(j))),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(medA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(medB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); % id(j) is of type cell shall be convert to string
%  %    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-pure mode A-A,V-V,AV-AV, ',' for individual: ',strjoin(id(j))),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(medA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(medB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f')) , strcat('mean(\tau_{AV})=',num2str(meanC,'%.1f'), ', median(\tau_{AV})=',num2str(medC,'%.1f'),', std(\tau_{AV})=',num2str(stdC,'%.1f')      ) }); % id(j) is of type cell shall be convert to string
%     hold off;
%     savefig(Hfig1,strcat(Outdir,'\',strjoin(id(j)),'Fig1'));
%     saveas(Hfig1,strcat(Outdir,'\',strjoin(id(j)),'Fig1.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

    
    
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
    htmultipsA_min{j}=h_min_tAtB;
    htmultipsA_RM{j}=hRM;
    cdevalptsmultipsA{j}=cdevalpts;
    
    multimeanA_A(j)=meanA;
    multimedA_A(j)=medA;
    multistdA_A(j)=stdA;
    multimeanA_V(j)=meanB;
    multimedA_V(j)=medB;
    multistdA_V(j)=stdB;
    multimeanA_AV(j)=meanC;
    multimedA_AV(j)=medC;
    multistdA_AV(j)=stdC;

    
    for k = 1:length(percentiles)   %testing significance NOT assuming indep
        indemp=find(htC>percentiles(k),1);
        indcalIRM=find(htIRM>percentiles(k),1);
        tempthr=cdevalpts(indemp);
        tIRMthr=cdevalpts(indcalIRM);
        [multiA_h(j,k), multiA_pvals(j,k)] = ttest2(sortedcelltC(sortedcelltC<tempthr),sortedcelltIRM(sortedcelltIRM<tIRMthr),'Tail','left'); %p-values at each percentile are contained in the mixpvals array
    end
  
   
    for k = 1:length(percentiles)   %testing significance NOT assuming indep
        indemp=find(htC>percentiles(k),1);
        indcalSRM=find(hRM>percentiles(k),1);
        tempthr=cdevalpts(indemp);
        tSRMthr=cdevalpts(indcalSRM);
        [multiA_SimRMh(j,k), multiA_SimRMpvals(j,k)] = ttest2(sortedcelltC(sortedcelltC<tempthr),sortedcellSimRM(sortedcellSimRM<tSRMthr),'Tail','left'); %p-values at each percentile are contained in the mixpvals array
    end 
    
%     Hfig2=figure;
%     plot(cdevalpts,hRM,'-.c','LineWidth',2);
%     hold on;
%     plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
%     plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
%     plot(cdevalpts,htA,'--m','LineWidth',2);
%     plot(cdevalpts,htB,'-.g','LineWidth',2);
%     axis([100 400 -inf inf]);
%     legend('RM','AV response','min(tA,tV)','Audio','Visual');
%     xlabel('Response delay ms');
%     ylabel('CDF');
%     title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-multi mode A-A,A-V,A-AV, ','for individual: ',strjoin(id(j))),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(medA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(medB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); % id(j) is of type cell shall be convert to string
%     hold off;
%     savefig(Hfig2,strcat(Outdir,'\',strjoin(id(j)),'Fig2'));
%     saveas(Hfig2,strcat(Outdir,'\',strjoin(id(j)),'Fig2.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

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
    htmultipsAV_min{j}=h_min_tAtB;
    htmultipsAV_RM{j}=hRM;
    cdevalptsmultipsAV{j}=cdevalpts;
    
    multimeanAV_A(j)=meanA;
    multimedAV_A(j)=medA;
    multistdAV_A(j)=stdA;
    multimeanAV_V(j)=meanB;
    multimedAV_V(j)=medB;
    multistdAV_V(j)=stdB;
    multimeanAV_AV(j)=meanC;
    multimedAV_AV(j)=medC;
    multistdAV_AV(j)=stdC;
    
    for k = 1:length(percentiles)   %testing significance NOT assuming indep
        indemp=find(htC>percentiles(k),1);
        indcalIRM=find(htIRM>percentiles(k),1);
        tempthr=cdevalpts(indemp);
        tIRMthr=cdevalpts(indcalIRM);
        [multiAV_h(j,k), multiAV_pvals(j,k)] = ttest2(sortedcelltC(sortedcelltC<tempthr),sortedcelltIRM(sortedcelltIRM<tIRMthr),'Tail','left'); %p-values at each percentile are contained in the mixpvals array
    end
  
    for k = 1:length(percentiles)   %testing significance NOT assuming indep
        indemp=find(htC>percentiles(k),1);
        indcalSRM=find(hRM>percentiles(k),1);
        tempthr=cdevalpts(indemp);
        tSRMthr=cdevalpts(indcalSRM);
       [multiAV_SimRMh(j,k), multiAV_SimRMpvals(j,k)] = ttest2(sortedcelltC(sortedcelltC<tempthr),sortedcellSimRM(sortedcellSimRM<tSRMthr),'Tail','left'); %p-values at each percentile are contained in the mixpvals array
    end   
    
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
    htmultipsV_min{j}=h_min_tAtB;
    htmultipsV_RM{j}=hRM;
    cdevalptsmultipsV{j}=cdevalpts;
    
    multimeanV_A(j)=meanA;
    multimedV_A(j)=medA;
    multistdV_A(j)=stdA;
    multimeanV_V(j)=meanB;
    multimedV_V(j)=medB;
    multistdV_V(j)=stdB;
    multimeanV_AV(j)=meanC;
    multimedV_AV(j)=medC;
    multistdV_AV(j)=stdC;
    
    for k = 1:length(percentiles)   %testing significance NOT assuming indep
        indemp=find(htC>percentiles(k),1);
        indcalIRM=find(htIRM>percentiles(k),1);
        tempthr=cdevalpts(indemp);
        tIRMthr=cdevalpts(indcalIRM);
        [multiV_h(j,k), multiV_pvals(j,k)] = ttest2(sortedcelltC(sortedcelltC<tempthr),sortedcelltIRM(sortedcelltIRM<tIRMthr),'Tail','left'); %p-values at each percentile are contained in the mixpvals array
    end
    
    for k = 1:length(percentiles)   %testing significance NOT assuming indep
        indemp=find(htC>percentiles(k),1);
        indcalSRM=find(hRM>percentiles(k),1);
        tempthr=cdevalpts(indemp);
        tSRMthr=cdevalpts(indcalSRM);
        [multiV_SimRMh(j,k), multiV_SimRMpvals(j,k)] = ttest2(sortedcelltC(sortedcelltC<tempthr),sortedcellSimRM(sortedcellSimRM<tSRMthr),'Tail','left');  %p-values at each percentile are contained in the mixpvals array
    end   
    

    %%%%%%%Fig 5%%%%%%%%%%%%%%% 
    focusconds=[7,8,12];
    condA=focusconds(1);
    condB=focusconds(2);
    condC=focusconds(3);
    [cdevalpts,htA,htB,htC,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcelltA,sortedcelltB,sortedcelltC,sortedcelltIRM,sortedcellSimRM]=CDFcomparitorV2(condA,condB,condC, indconditionedcell,CDFsteps);
    hRM=htA+htB;
    hRM(hRM>1)=1;
    
    for k = 1:length(percentiles)   %testing significance NOT assuming indep
        indemp=find(htC>percentiles(k),1);
        indcalIRM=find(htIRM>percentiles(k),1);
        tempthr=cdevalpts(indemp);
        tIRMthr=cdevalpts(indcalIRM);
        [repeath(j,k), repeatPvals(j,k)] = ttest2(sortedcelltC(sortedcelltC<tempthr),sortedcelltIRM(sortedcelltIRM<tIRMthr),'Tail','left'); %p-values at each percentile are contained in the mixpvals array
    end
    
    for k = 1:length(percentiles)   %testing significance NOT assuming indep
        indemp=find(htC>percentiles(k),1);
        indcalSRM=find(hRM>percentiles(k),1);
        tempthr=cdevalpts(indemp);
        tSRMthr=cdevalpts(indcalSRM);
        [repeatSimRMh(j,k), repeatSimRMPvals(j,k)] = ttest2(sortedcelltC(sortedcelltC<tempthr),sortedcellSimRM(sortedcellSimRM<tSRMthr),'Tail','left'); %p-values at each percentile are contained in the mixpvals array
    end     
    
   
    

end % for 1:size(id,2)..
%################ END Individual Analysis  ####################

Hfig10=figure;
significant_45=[sum(pureh(:,9)) sum(repeath(:,9)) sum(multiA_h(:,9)) sum(multiAV_h(:,9)) sum(multiV_h(:,9))]; % this stored the number of significant violations at 45 percentile among all participants
signame={'pure';'repeat';'multi-Astate';'multi-AVstate';'multi-Vstate'};
bar(significant_45);
title('Number of Significant Violations Among Participants from Min Independent Processes ');
set(gca,'xticklabel',signame);
savefig(Hfig10,strcat(Outdir,'\','SignificantViolationIRM1'));
saveas(Hfig10,strcat(Outdir,'\','SignificantViolationIRM.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name


Hfig11=figure;
significant_45=[sum(pureSimRMh(:,9)) sum(repeatSimRMh(:,9)) sum(multiA_SimRMh(:,9)) sum(multiAV_SimRMh(:,9)) sum(multiV_SimRMh(:,9))]; % this stored the number of significant violations at 45 percentile among all participants
signame={'pure';'repeat';'multi-Astate';'multi-AVstate';'multi-Vstate'};
bar(significant_45);
title('Number of Significant Violations Among Participants from Simulated Upper Bound Race Model Distribution');
set(gca,'xticklabel',signame);
savefig(Hfig11,strcat(Outdir,'\','SignificantViolationSRM'));
saveas(Hfig11,strcat(Outdir,'\','SignificantViolationSRM.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name


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