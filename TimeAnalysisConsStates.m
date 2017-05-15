% this module should be run after SMARTeCDFs.m to have all the data related
% to any individual preloaded to Matlab, it also uses CDFcomparitor.m
% function to calculate emperical CDF of any three combination of commands
% with the same basis. It will generate plot to make comparision for
% individuals selected by j 

ncond=13;
CDFsteps=0.1;
Outdir = uigetdir('D:\Arian\Projects\SMART\Outputs\mintAtBHypoth\Individual\','Select Output Directory for the Graphs!'); % this is the directory the output figures will be saved to

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

% Consecuitive states
% A-A-..
% 7,7  %A-A-A
% 7,10  %A-A-V
% 7,13  %A-A-AV
% 
% V-V-.. 
% 8,8  %V-V-V
% 8,5   V-V-A
% 8,11  V-V-AV
% 
% AV-AV-..
% 12,12  AV-AV-AV
% 12,6   AV-AV-A
% 12,9   AV-AV-V %%

 indseqcondcell=cell(ncond,ncond);

for j=1:size(id,2), % the index of individual in the indcell

    indseqcondcell=cell(ncond,ncond);% consequitive state seperation of individual cell, first preceeding cond, second current condition
    for k=2:length(indcell{j}(:,1)), % scan a specific result and organise it in the possible consequitive states
        cond=indcell{j}(k,1);
        preccond=indcell{j}(k-1,1);
        indseqcondcell{preccond,cond}=[indseqcondcell{preccond,cond}; indcell{j}(k,2)];
    end     %%%
   

    %%%%%%%Fig 1%%%%%%%%%%%%%
    focusconds=[[2 2];[3 3];[4 4]]; % Which combination of consequitive states will be compared
    condAPrec=focusconds(1,1); % preceeding condition
    condACurr=focusconds(1,2); % current condition
    condBPrec=focusconds(2,1); % preceeding condition
    condBCurr=focusconds(2,2); % current condition
    condCPrec=focusconds(3,1); % preceeding condition
    condCCurr=focusconds(3,2); % current condition
    [cdevalpts,htA,htB,htC,h_min_tAtB,samplenum,meanA,modA,stdA,meanB,modB,stdB,meanC,modC,stdC]=CDFcomparitorconseq(condAPrec,condACurr,condBPrec,condBCurr,condCPrec,condCCurr,indseqcondcell,CDFsteps);

    set(0,'DefaultFigureVisible','off');% disable plot display because it is being saved
    
    Hfig1=figure;  
    plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
    hold on;
    plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
    plot(cdevalpts,htA,'--m','LineWidth',2);
    plot(cdevalpts,htB,'-.g','LineWidth',2);
    axis([100 400 -inf inf]);
    legend('AV response','min(tA,tV)','Audio','Visual');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-single mode A-A-A,V-V-V,AV-AV-AV, ',' for individual: ',strjoin(id(j))),strcat('mimimum number of samples in each category: ',num2str(samplenum)),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(modA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(modB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); % id(j) is of type cell shall be convert to string
    hold off;
    savefig(Hfig1,strcat(Outdir,'\',strjoin(id(j)),'Fig1'));
    saveas(Hfig1,strcat(Outdir,'\',strjoin(id(j)),'Fig1.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

    %%%%%%%Fig 2%%%%%%%%%%%%%%%    
    focusconds=[[7 7];[8 8];[12 12]]; % Which combination of consequitive states will be compared
    condAPrec=focusconds(1,1); % preceeding condition
    condACurr=focusconds(1,2); % current condition
    condBPrec=focusconds(2,1); % preceeding condition
    condBCurr=focusconds(2,2); % current condition
    condCPrec=focusconds(3,1); % preceeding condition
    condCCurr=focusconds(3,2); % current condition
    [cdevalpts,htA,htB,htC,h_min_tAtB,samplenum,meanA,modA,stdA,meanB,modB,stdB,meanC,modC,stdC]=CDFcomparitorconseq(condAPrec,condACurr,condBPrec,condBCurr,condCPrec,condCCurr,indseqcondcell,CDFsteps);

    Hfig2=figure;
    plot(cdevalpts,htC,'--b','LineWidth',2);
    hold on;
    plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
    plot(cdevalpts,htA,'--m','LineWidth',2);
    plot(cdevalpts,htB,'-.g','LineWidth',2);
    axis([100 400 -inf inf]);
    legend('AV response','min(tA,tV)','Audio','Visual');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-multi mode A-A-A,V-V-V,AV-AV-AV, ','for individual: ',strjoin(id(j))),strcat('mimimum number of samples in each category: ',num2str(samplenum)),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(modA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(modB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))});
    hold off;
    savefig(Hfig2,strcat(Outdir,'\',strjoin(id(j)),'Fig2'));
    saveas(Hfig2,strcat(Outdir,'\',strjoin(id(j)),'Fig2.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

    
    %%%%%%%Fig 3%%%%%%%%%%%%%%% 
    focusconds=[[7 7];[7 10];[7 13]]; % Which combination of consequitive states will be compared
    condAPrec=focusconds(1,1); % preceeding condition
    condACurr=focusconds(1,2); % current condition
    condBPrec=focusconds(2,1); % preceeding condition
    condBCurr=focusconds(2,2); % current condition
    condCPrec=focusconds(3,1); % preceeding condition
    condCCurr=focusconds(3,2); % current condition
   [cdevalpts,htA,htB,htC,h_min_tAtB,samplenum,meanA,modA,stdA,meanB,modB,stdB,meanC,modC,stdC]=CDFcomparitorconseq(condAPrec,condACurr,condBPrec,condBCurr,condCPrec,condCCurr,indseqcondcell,CDFsteps);

    Hfig3=figure;
    plot(cdevalpts,htC,'--b','LineWidth',2);
    hold on;
    plot(cdevalpts,htA,'--m','LineWidth',2);
    plot(cdevalpts,htB,'-.g','LineWidth',2);
    axis([100 400 -inf inf]);
    legend('AV response','min(tA,tV)','Audio','Visual');
    legend('AV response','min(tA,tV)');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-multi mode A-A-A,A-A-V,A-A-AV, ','for individual: ',strjoin(id(j))),strcat('mimimum number of samples in each category: ',num2str(samplenum)),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(modA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(modB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))});
    hold off;
    savefig(Hfig3,strcat(Outdir,'\',strjoin(id(j)),'Fig3'));
    saveas(Hfig3,strcat(Outdir,'\',strjoin(id(j)),'Fig3.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

    
    %%%%%%%Fig 4%%%%%%%%%%%%%
    focusconds=[[8 8];[8 5];[8 11]]; % Which combination of consequitive states will be compared
    condAPrec=focusconds(1,1); % preceeding condition
    condACurr=focusconds(1,2); % current condition
    condBPrec=focusconds(2,1); % preceeding condition
    condBCurr=focusconds(2,2); % current condition
    condCPrec=focusconds(3,1); % preceeding condition
    condCCurr=focusconds(3,2); % current condition
    [cdevalpts,htA,htB,htC,h_min_tAtB,samplenum,meanA,modA,stdA,meanB,modB,stdB,meanC,modC,stdC]=CDFcomparitorconseq(condAPrec,condACurr,condBPrec,condBCurr,condCPrec,condCCurr,indseqcondcell,CDFsteps);


    Hfig4=figure;
    plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
    hold on;
    plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
    plot(cdevalpts,htA,'--m','LineWidth',2);
    plot(cdevalpts,htB,'-.g','LineWidth',2);
    axis([100 400 -inf inf]);
    legend('AV response','min(tA,tV)','Audio','Visual');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-multi mode V-V-V,V-V-A,V-V-AV, ','for individual: ',strjoin(id(j))),strcat('mimimum number of samples in each category: ',num2str(samplenum)),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(modA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(modB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); % id(j) is of type cell shall be convert to string
    hold off;
    savefig(Hfig4,strcat(Outdir,'\',strjoin(id(j)),'Fig4'));
    saveas(Hfig4,strcat(Outdir,'\',strjoin(id(j)),'Fig4.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

    %%%%%%%Fig 5%%%%%%%%%%%%%%%    
    focusconds=[[12 6];[12 9];[12 12]]; % Which combination of consequitive states will be compared
    condAPrec=focusconds(1,1); % preceeding condition
    condACurr=focusconds(1,2); % current condition
    condBPrec=focusconds(2,1); % preceeding condition
    condBCurr=focusconds(2,2); % current condition
    condCPrec=focusconds(3,1); % preceeding condition
    condCCurr=focusconds(3,2); % current condition
    [cdevalpts,htA,htB,htC,h_min_tAtB,samplenum,meanA,modA,stdA,meanB,modB,stdB,meanC,modC,stdC]=CDFcomparitorconseq(condAPrec,condACurr,condBPrec,condBCurr,condCPrec,condCCurr,indseqcondcell,CDFsteps);

    Hfig5=figure;
    plot(cdevalpts,htC,'--b','LineWidth',2);
    hold on;
    plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
    plot(cdevalpts,htA,'--m','LineWidth',2);
    plot(cdevalpts,htB,'-.g','LineWidth',2);
    axis([100 400 -inf inf]);
    legend('AV response','min(tA,tV)','Audio','Visual');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-multi mode AV-AV-A,AV-AV-V,AV-AV-AV ','for individual: ',strjoin(id(j))),strcat('mimimum number of samples in each category: ',num2str(samplenum)),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(modA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(modB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))});
    hold off;
    savefig(Hfig5,strcat(Outdir,'\',strjoin(id(j)),'Fig5'));
    saveas(Hfig5,strcat(Outdir,'\',strjoin(id(j)),'Fig5.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

    set(0,'DefaultFigureVisible','on');%enable plot display
   
end % for 1:size(id,2)..


%Possible useful function:
% kernel PDF estimation from a data set
%[f,xi] = ksdensity(x);
%[f,xi] = ksdensity(x,pts);  %specify the sample point

% histogram PDF;
% [counts binCenters] = hist(yourData, 256); % Use 256 bins. 
% plot(binCenters, counts);

%plot derivative of a function

%format shortG
%dydx = diff(y(:))./diff(x(:));