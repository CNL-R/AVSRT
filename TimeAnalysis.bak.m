% this module should be run after SMARTeCDFs.m to have all the data related
% to any individual preloaded to Matlab, it also uses CDFcomparitor.m
% function to calculate emperical CDF of any three combination of commands
% with the same basis. It will generate plot to make comparision for
% individuals selected by j 

ncond=13;
CDFsteps=0.1;

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
    [cdevalpts,htA,htB,htC,h_min_tAtB]=CDFcomparitor(condA,condB,condC, indconditionedcell,CDFsteps);

    Hfig1=figure;  
    plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
    hold on;
    plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
    legend('AV response','min(tA,tV)');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-single mode A-A,V-V,AV-AV, ',' for individual: ',strjoin(id(j)))}); % id(j) is of type cell shall be convert to string
    hold off;
    savefig(Hfig1,strcat('D:\TestData\Arian\Projects\SMART\Outputs\mintAtBHypoth\Individual\AllIndividuals\',strjoin(id(j)),'Fig1'));
    saveas(Hfig1,strcat('D:\TestData\Arian\Projects\SMART\Outputs\mintAtBHypoth\Individual\AllIndividuals\',strjoin(id(j)),'Fig1.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

    %%%%%%%Fig 2%%%%%%%%%%%%%
    focusconds=[7,10,13];
    condA=focusconds(1);
    condB=focusconds(2);
    condC=focusconds(3);
    [cdevalpts,htA,htB,htC,h_min_tAtB]=CDFcomparitor(condA,condB,condC, indconditionedcell,CDFsteps);

    Hfig2=figure;
    plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
    hold on;
    plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
    legend('AV response','min(tA,tV)');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-multi mode A-A,A-V,A-AV, ','for individual: ',strjoin(id(j)))}); % id(j) is of type cell shall be convert to string
    hold off;
    savefig(Hfig2,strcat('D:\TestData\Arian\Projects\SMART\Outputs\mintAtBHypoth\Individual\AllIndividuals\',strjoin(id(j)),'Fig2'));
    saveas(Hfig2,strcat('D:\TestData\Arian\Projects\SMART\Outputs\mintAtBHypoth\Individual\AllIndividuals\',strjoin(id(j)),'Fig2.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

    %%%%%%%Fig 3%%%%%%%%%%%%%%%    
    focusconds=[6,9,12];
    condA=focusconds(1);
    condB=focusconds(2);
    condC=focusconds(3);
    [cdevalpts,htA,htB,htC,h_min_tAtB]=CDFcomparitor(condA,condB,condC, indconditionedcell,CDFsteps);

    Hfig3=figure;
    plot(cdevalpts,htC,'--b','LineWidth',2);
    hold on;
    plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
    legend('AV response','min(tA,tV)');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-multi mode AV-A,AV-V,AV-AV, ','for individual: ',strjoin(id(j)))});
    hold off;
    savefig(Hfig3,strcat('D:\TestData\Arian\Projects\SMART\Outputs\mintAtBHypoth\Individual\AllIndividuals\',strjoin(id(j)),'Fig3'));
    saveas(Hfig3,strcat('D:\TestData\Arian\Projects\SMART\Outputs\mintAtBHypoth\Individual\AllIndividuals\',strjoin(id(j)),'Fig3.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name



    %%%%%%%Fig 4%%%%%%%%%%%%%%%    
    focusconds=[5,8,11];
    condA=focusconds(1);
    condB=focusconds(2);
    condC=focusconds(3);
    [cdevalpts,htA,htB,htC,h_min_tAtB]=CDFcomparitor(condA,condB,condC, indconditionedcell,CDFsteps);

    Hfig4=figure;
    plot(cdevalpts,htC,'--b','LineWidth',2);
    hold on;
    plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
    legend('AV response','min(tA,tV)');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-multi mode V-A,V-V,V-AV, ','for individual: ',strjoin(id(j)))});
    hold off;
    savefig(Hfig4,strcat('D:\TestData\Arian\Projects\SMART\Outputs\mintAtBHypoth\Individual\AllIndividuals\',strjoin(id(j)),'Fig4'));
    saveas(Hfig4,strcat('D:\TestData\Arian\Projects\SMART\Outputs\mintAtBHypoth\Individual\AllIndividuals\',strjoin(id(j)),'Fig4.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

    %%%%%%%Fig 5%%%%%%%%%%%%%%% 
    focusconds=[7,8,12];
    condA=focusconds(1);
    condB=focusconds(2);
    condC=focusconds(3);
    [cdevalpts,htA,htB,htC,h_min_tAtB]=CDFcomparitor(condA,condB,condC, indconditionedcell,CDFsteps);

    Hfig5=figure;
    plot(cdevalpts,htC,'--b','LineWidth',2);
    hold on;
    plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
    legend('AV response','min(tA,tV)');
    xlabel('Response delay ms');
    ylabel('CDF');
    title({'Comparision between theoretical min(tA,tV) and empirical AV response',strcat('-multi mode A-A,V-V,AV-AV, ','for individual: ',strjoin(id(j)))});
    hold off;
    savefig(Hfig5,strcat('D:\TestData\Arian\Projects\SMART\Outputs\mintAtBHypoth\Individual\AllIndividuals\',strjoin(id(j)),'Fig5'));
    saveas(Hfig5,strcat('D:\TestData\Arian\Projects\SMART\Outputs\mintAtBHypoth\Individual\AllIndividuals\',strjoin(id(j)),'Fig5.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
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