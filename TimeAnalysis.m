% this module should be run after SMARTeCDFs.m to have all the data related
% to any individual preloaded to Matlab, it also uses CDFcomparitor.m
% function to calculate emperical CDF of any three combination of commands
% with the same basis. It will generate plot to make comparision for
% individuals selected by j 

ncond=13;
CDFsteps=0.1;

Outdir = uigetdir('D:\Arian\Projects\SMART\Outputs\mintAtBHypoth\Individual\','Select Output Directory for the Graphs!'); % this is the directory the output figures will be saved to

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
    [cdevalpts,htA,htB,htC,h_min_tAtB,meanA,modA,stdA,meanB,modB,stdB,meanC,modC,stdC]=CDFcomparitor(condA,condB,condC, indconditionedcell,CDFsteps);
    hRM=htA+htB;
    hRM(hRM>1)=1;
    
    
    Hfig1=figure;  
    plot(cdevalpts,hRM,'-.c','LineWidth',2);
    hold on;
    plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
    plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
    plot(cdevalpts,htA,'--m','LineWidth',2);
    plot(cdevalpts,htB,'-.g','LineWidth',2);
    axis([100 400 -inf inf]);
    legend('RM','AV response','min(tA,tV)','Audio','Visual');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-pure mode A-A,V-V,AV-AV, ',' for individual: ',strjoin(id(j))),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(modA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(modB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); % id(j) is of type cell shall be convert to string
 %    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-pure mode A-A,V-V,AV-AV, ',' for individual: ',strjoin(id(j))),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(modA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(modB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f')) , strcat('mean(\tau_{AV})=',num2str(meanC,'%.1f'), ', median(\tau_{AV})=',num2str(modC,'%.1f'),', std(\tau_{AV})=',num2str(stdC,'%.1f')      ) }); % id(j) is of type cell shall be convert to string
    hold off;
    savefig(Hfig1,strcat(Outdir,'\',strjoin(id(j)),'Fig1'));
    saveas(Hfig1,strcat(Outdir,'\',strjoin(id(j)),'Fig1.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

    %%%%%%%Fig 2%%%%%%%%%%%%%
    focusconds=[7,10,13];
    condA=focusconds(1);
    condB=focusconds(2);
    condC=focusconds(3);
    [cdevalpts,htA,htB,htC,h_min_tAtB,meanA,modA,stdA,meanB,modB,stdB,meanC,modC,stdC]=CDFcomparitor(condA,condB,condC, indconditionedcell,CDFsteps);
    hRM=htA+htB;
    hRM(hRM>1)=1;
    
    Hfig2=figure;
    plot(cdevalpts,hRM,'-.c','LineWidth',2);
    hold on;
    plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
    plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
    plot(cdevalpts,htA,'--m','LineWidth',2);
    plot(cdevalpts,htB,'-.g','LineWidth',2);
    axis([100 400 -inf inf]);
    legend('RM','AV response','min(tA,tV)','Audio','Visual');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-multi mode A-A,A-V,A-AV, ','for individual: ',strjoin(id(j))),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(modA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(modB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); % id(j) is of type cell shall be convert to string
    hold off;
    savefig(Hfig2,strcat(Outdir,'\',strjoin(id(j)),'Fig2'));
    saveas(Hfig2,strcat(Outdir,'\',strjoin(id(j)),'Fig2.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

    %%%%%%%Fig 3%%%%%%%%%%%%%%%    
    focusconds=[6,9,12];
    condA=focusconds(1);
    condB=focusconds(2);
    condC=focusconds(3);
    [cdevalpts,htA,htB,htC,h_min_tAtB,meanA,modA,stdA,meanB,modB,stdB,meanC,modC,stdC]=CDFcomparitor(condA,condB,condC, indconditionedcell,CDFsteps);
    hRM=htA+htB;
    hRM(hRM>1)=1;
    
    Hfig3=figure;
    plot(cdevalpts,hRM,'-.c','LineWidth',2);
    hold on;
    plot(cdevalpts,htC,'--b','LineWidth',2);
    plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
    plot(cdevalpts,htA,'--m','LineWidth',2);
    plot(cdevalpts,htB,'-.g','LineWidth',2);
    axis([100 400 -inf inf]);
    legend('RM','AV response','min(tA,tV)','Audio','Visual');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-multi mode AV-A,AV-V,AV-AV, ','for individual: ',strjoin(id(j))),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(modA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(modB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); % id(j) is of type cell shall be convert to string
    hold off;
    savefig(Hfig3,strcat(Outdir,'\',strjoin(id(j)),'Fig3'));
    saveas(Hfig3,strcat(Outdir,'\',strjoin(id(j)),'Fig3.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name



    %%%%%%%Fig 4%%%%%%%%%%%%%%%    
    focusconds=[5,8,11];
    condA=focusconds(1);
    condB=focusconds(2);
    condC=focusconds(3);
    [cdevalpts,htA,htB,htC,h_min_tAtB,meanA,modA,stdA,meanB,modB,stdB,meanC,modC,stdC]=CDFcomparitor(condA,condB,condC, indconditionedcell,CDFsteps);
    hRM=htA+htB;
    hRM(hRM>1)=1;
    
    Hfig4=figure;
    plot(cdevalpts,hRM,'-.c','LineWidth',2);
    hold on;
    plot(cdevalpts,htC,'--b','LineWidth',2);
    plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
    plot(cdevalpts,htA,'--m','LineWidth',2);
    plot(cdevalpts,htB,'-.g','LineWidth',2);
    axis([100 400 -inf inf]);
    legend('RM','AV response','min(tA,tV)','Audio','Visual');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-multi mode V-A,V-V,V-AV, ','for individual: ',strjoin(id(j))),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(modA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(modB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); % id(j) is of type cell shall be convert to string
    hold off;
    savefig(Hfig4,strcat(Outdir,'\',strjoin(id(j)),'Fig4'));
    saveas(Hfig4,strcat(Outdir,'\',strjoin(id(j)),'Fig4.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

    %%%%%%%Fig 5%%%%%%%%%%%%%%% 
    focusconds=[7,8,12];
    condA=focusconds(1);
    condB=focusconds(2);
    condC=focusconds(3);
    [cdevalpts,htA,htB,htC,h_min_tAtB,meanA,modA,stdA,meanB,modB,stdB,meanC,modC,stdC]=CDFcomparitor(condA,condB,condC, indconditionedcell,CDFsteps);
    hRM=htA+htB;
    hRM(hRM>1)=1;
    
    Hfig5=figure;
    plot(cdevalpts,hRM,'-.c','LineWidth',2);
    hold on;
    plot(cdevalpts,htC,'--b','LineWidth',2);
    plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
    plot(cdevalpts,htA,'--m','LineWidth',2);
    plot(cdevalpts,htB,'-.g','LineWidth',2);
    axis([100 400 -inf inf]);
    legend('RM','AV response','min(tA,tV)','Audio','Visual');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-multi mode A-A,V-V,AV-AV, ','for individual: ',strjoin(id(j))),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(modA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(modB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); % id(j) is of type cell shall be convert to string
    hold off;
    savefig(Hfig5,strcat(Outdir,'\',strjoin(id(j)),'Fig5'));
    saveas(Hfig5,strcat(Outdir,'\',strjoin(id(j)),'Fig5.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
end % for 1:size(id,2)..
%################ END Individual Analysis  ####################


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