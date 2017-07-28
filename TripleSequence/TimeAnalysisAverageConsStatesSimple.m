% #### Average Over ALL Analysis ###
% this module should be run after SMARTeCDFs.m to have all the data related
% to any individual preloaded to Matlab, it also uses CDFcomparitor.m
% function to calculate emperical CDF of any three combination of commands
% with the same basis. It will generate plot to make comparision for
% average CDF,  
% First we make a long conditional cell includes trials of all individual
% except some identified in "excludeindvds", then do the same analysis put
% forward in TimeAnalysis for each individual 

ncond=13;
CDFsteps=0.1;
seqcondcell=cell(ncond,ncond);% conditioned individual cell
excludeindvds=[]; % this is the id index of individuals which should be excluded from analysis due to unreliable or impossible results or wrong measurements

Outdir = uigetdir('D:\Arian\Projects\SMART\Outputs\mintAtBHypoth\Average\','Select Output Directory for the Graphs!'); 

% extracte individual and cumulative response times based on current and
% previous condition
indseqcondcell=cell(size(id,2),ncond,ncond);
seqcondcell=cell(ncond,ncond);

for j=1:size(id,2), % the index of individual in the indcell
     if any(excludeindvds==j) , % this means j is an excluded individual also may be implemented by  sum(ismember(excludeindvds,j))>0
     else
        for k=2:length(indcell{j}(:,1)), % scan a specific result and organise it in the possible consequitive states
            cond=indcell{j}(k,1);
            preccond=indcell{j}(k-1,1);
            indseqcondcell{j,preccond,cond}=[indseqcondcell{j,preccond,cond}; indcell{j}(k,2)];
            seqcondcell{preccond,cond}=[seqcondcell{preccond,cond}; indcell{j}(k,2)];
        end 
     end  
end 

%%%%%%%%%%%%%%%    Not corrected yet      %%%%%%%%%%%%%%%%%
%%%%%%%Fig 1%%%%%%%%%%%%%
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

%@@@@@@@@@@@@@@@@@@@@@@@ FIGURE 1 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
combcondA=[5,7];% V-A-A
condAPrec=combcondA(1);
condACurr=combcondA(2);
mixedcell1=[seqcondcell{condAPrec,condACurr}];
% condBPrec=combcondB(1);
% condBCurr=combcondB(2);
% mixedcell1=[seqcondcell{condBPrec,condBCurr};seqcondcell{condAPrec,condACurr}];

combcondA=[5,10];% V-A-V
condAPrec=combcondA(1);
condACurr=combcondA(2);
mixedcell2=[seqcondcell{condAPrec,condACurr}];


combcondA=[5,13];% V-A-AV
condAPrec=combcondA(1);
condACurr=combcondA(2);
mixedcell3=[seqcondcell{condAPrec,condACurr}];

sortedcelltA=sort(mixedcell1); % sort conditioned cell
sortedcelltB=sort(mixedcell2); % sort conditioned cell
sortedcelltC=sort(mixedcell3); % sort conditioned cell

[cdevalpts,htA,htB,htC,hRM,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcellIRM,sortedcellSimRM] = CDFcomparitorGeneral(sortedcelltA,sortedcelltB,sortedcelltC,CDFsteps );
% hRM=htA+htB;
% hRM(hRM>1)=1;
DiffromRMFig1=htC-hRM; % this is for last comparision graph
DiffromIRMFig1=htC-htIRM;
cdevalptsFig1=cdevalpts;


Hfig1=figure;
plot(cdevalpts,htA,'--m','LineWidth',2);
hold on;
plot(cdevalpts,htB,'-.g','LineWidth',2);
plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
plot(cdevalpts,hRM,'-.c','LineWidth',2);
plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
axis([100 400 -inf inf]);
legend('V-A-A','V-A-V','V-A-AV','RM','Independent RM');
xlabel('Response delay ms');
ylabel('CDF');
title({'Comparision between empirical AV-AV response and Race Model of Collection 1 and 2,', strcat('mean(\tau_{C_1})=',num2str(meanA,'%.1f'), ', median(\tau_{C_1})=',num2str(medA,'%.1f'),', std(\tau_{C_1})=',num2str(stdA,'%.1f')), strcat('mean(\tau_{C_2})=',num2str(meanB,'%.1f'), ', median(\tau_{C_1})=',num2str(medB,'%.1f'),', std(\tau_{C_1})=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig1,strcat(Outdir,'\','Fig1'));
saveas(Hfig1,strcat(Outdir,'\','Fig1.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

%@@@@@@@@@@@@@@@@@@@@  FIGURE 2  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
combcondA=[10,5];% A-V-A
condAPrec=combcondA(1);
condACurr=combcondA(2);
mixedcell1=[seqcondcell{condAPrec,condACurr}];

combcondA=[10,8];%  A-V-V
condAPrec=combcondA(1);
condACurr=combcondA(2);
mixedcell2=[seqcondcell{condAPrec,condACurr}];

combcondA=[10,11];%  A-V-AV
condAPrec=combcondA(1);
condACurr=combcondA(2);
mixedcell3=[seqcondcell{condAPrec,condACurr}];

sortedcelltA=sort(mixedcell1); % sort conditioned cell
sortedcelltB=sort(mixedcell2); % sort conditioned cell
sortedcelltC=sort(mixedcell3); % sort conditioned cell

[cdevalpts,htA,htB,htC,hRM,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcellIRM,sortedcellSimRM] = CDFcomparitorGeneral(sortedcelltA,sortedcelltB,sortedcelltC,CDFsteps );
% hRM=htA+htB;
% hRM(hRM>1)=1;
DiffromRMFig2=htC-hRM; % this is for last comparision graph
DiffromIRMFig2=htC-htIRM;
cdevalptsFig2=cdevalpts;

Hfig2=figure;
plot(cdevalpts,htA,'--m','LineWidth',2);
hold on;
plot(cdevalpts,htB,'-.g','LineWidth',2);
plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
plot(cdevalpts,hRM,'-.c','LineWidth',2);
plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
axis([100 400 -inf inf]);
legend('A-V-A','A-V-V','A-V-AV','RM','Independent RM');
xlabel('Response delay ms');
ylabel('CDF');
title({'Comparision between empirical AV-AV response and Race Model of Collection 1 and 2,', strcat('mean(\tau_{C_1})=',num2str(meanA,'%.1f'), ', median(\tau_{C_1})=',num2str(medA,'%.1f'),', std(\tau_{C_1})=',num2str(stdA,'%.1f')), strcat('mean(\tau_{C_2})=',num2str(meanB,'%.1f'), ', median(\tau_{C_1})=',num2str(medB,'%.1f'),', std(\tau_{C_1})=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig2,strcat(Outdir,'\','Fig2'));
saveas(Hfig2,strcat(Outdir,'\','Fig2.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

%@@@@@@@@@@@@@@@@@@@@  FIGURE 3  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
combcondA=[7,7];% A-A-A
condAPrec=combcondA(1);
condACurr=combcondA(2);
mixedcell1=seqcondcell{condAPrec,condACurr};

combcondA=[7,10];% A-A-V
condAPrec=combcondA(1);
condACurr=combcondA(2);
mixedcell2=seqcondcell{condAPrec,condACurr};

combcondA=[7,13];% A-A-AV
condAPrec=combcondA(1);
condACurr=combcondA(2);
mixedcell3=seqcondcell{condAPrec,condACurr};

sortedcelltA=sort(mixedcell1); % sort conditioned cell
sortedcelltB=sort(mixedcell2); % sort conditioned cell
sortedcelltC=sort(mixedcell3); % sort conditioned cell

[cdevalpts,htA,htB,htC,hRM,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcellIRM,sortedcellSimRM] = CDFcomparitorGeneral(sortedcelltA,sortedcelltB,sortedcelltC,CDFsteps );
% hRM=htA+htB;
% hRM(hRM>1)=1;
DiffromRMFig3=htC-hRM; % this is for last comparision graph
DiffromIRMFig3=htC-htIRM;
cdevalptsFig3=cdevalpts;


Hfig3=figure;
plot(cdevalpts,htA,'--m','LineWidth',2);
hold on;
plot(cdevalpts,htB,'-.g','LineWidth',2);
plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
plot(cdevalpts,hRM,'-.c','LineWidth',2);
plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
axis([100 400 -inf inf]);
legend('A-A-A','A-A-V','A-A-AV','RM','Independent RM');
xlabel('Response delay ms');
ylabel('CDF');
title({'Comparision between empirical AV-AV-AV response and Race Model of A-A-A and V-V-V,', strcat('mean(\tau_{C_1})=',num2str(meanA,'%.1f'), ', median(\tau_{C_1})=',num2str(medA,'%.1f'),', std(\tau_{C_1})=',num2str(stdA,'%.1f')), strcat('mean(\tau_{C_2})=',num2str(meanB,'%.1f'), ', median(\tau_{C_1})=',num2str(medB,'%.1f'),', std(\tau_{C_1})=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig3,strcat(Outdir,'\','Fig3'));
saveas(Hfig3,strcat(Outdir,'\','Fig3.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

% @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

%@@@@@@@@@@@@@@@@@@@@  FIGURE 3  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
combcondA=[8,5];% V-V-A
condAPrec=combcondA(1);
condACurr=combcondA(2);
mixedcell1=seqcondcell{condAPrec,condACurr};

combcondA=[8,8];% V-V-V
condAPrec=combcondA(1);
condACurr=combcondA(2);
mixedcell2=seqcondcell{condAPrec,condACurr};

combcondA=[8,11];% V-V-AV
condAPrec=combcondA(1);
condACurr=combcondA(2);
mixedcell3=seqcondcell{condAPrec,condACurr};

sortedcelltA=sort(mixedcell1); % sort conditioned cell
sortedcelltB=sort(mixedcell2); % sort conditioned cell
sortedcelltC=sort(mixedcell3); % sort conditioned cell

[cdevalpts,htA,htB,htC,hRM,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcellIRM,sortedcellSimRM] = CDFcomparitorGeneral(sortedcelltA,sortedcelltB,sortedcelltC,CDFsteps );
% hRM=htA+htB;
% hRM(hRM>1)=1;
DiffromRMFig4=htC-hRM; % this is for last comparision graph
DiffromIRMFig4=htC-htIRM;
cdevalptsFig4=cdevalpts;


Hfig4=figure;
plot(cdevalpts,htA,'--m','LineWidth',2);
hold on;
plot(cdevalpts,htB,'-.g','LineWidth',2);
plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
plot(cdevalpts,hRM,'-.c','LineWidth',2);
plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
axis([100 400 -inf inf]);
legend('A-A-A','A-A-V','A-A-AV','RM','Independent RM');
xlabel('Response delay ms');
ylabel('CDF');
title({'Comparision between empirical AV-AV-AV response and Race Model of A-A-A and V-V-V,', strcat('mean(\tau_{C_1})=',num2str(meanA,'%.1f'), ', median(\tau_{C_1})=',num2str(medA,'%.1f'),', std(\tau_{C_1})=',num2str(stdA,'%.1f')), strcat('mean(\tau_{C_2})=',num2str(meanB,'%.1f'), ', median(\tau_{C_1})=',num2str(medB,'%.1f'),', std(\tau_{C_1})=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig4,strcat(Outdir,'\','Fig4'));
saveas(Hfig4,strcat(Outdir,'\','Fig4.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name


% %@@@@@@@@@@@@@@@@@@@@@@@@@@ Figure 10  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
% [mRMVio1,indm1]=max(DiffromRMFig1);
% [mRMVio2,indm2]=max(DiffromRMFig2);
% [mRMVio3,indm3]=max(DiffromRMFig3);
% 
% Hfig10=figure;
% plot(cdevalptsFig3,DiffromRMFig3,'-.b','LineWidth',2);
% hold on;
% plot(cdevalptsFig1,DiffromRMFig1,'-.r','LineWidth',2);
% plot(cdevalptsFig2,DiffromRMFig2,'-.g','LineWidth',2);
% legend('Double Repeat','(AV-V-V) plus (A-V-V)','(AV-V-V) plus (V-V-V) ');
% xlabel('Response delay ms');
% ylabel('CDF');
% title({'Comparision between violation of AV response from Race Model'}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
% hold off;
% savefig(Hfig10,strcat(Outdir,'\','Fig10'));
% saveas(Hfig10,strcat(Outdir,'\','Fig10.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
% 
% 
% %@@@@@@@@@@@@@@@@@@@@@@@@@@ Figure 10  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
% [mIRMVio1,indI1]=max(DiffromIRMFig1);
% [mIRMVio2,indI2]=max(DiffromIRMFig2);
% [mIRMVio3,indI3]=max(DiffromIRMFig3);
% 
% Hfig11=figure;
% plot(cdevalptsFig3,DiffromIRMFig3,'-.b','LineWidth',2);
% hold on;
% plot(cdevalptsFig1,DiffromIRMFig1,'-.r','LineWidth',2);
% plot(cdevalptsFig2,DiffromIRMFig2,'-.g','LineWidth',2);
% legend('Double Repeat','(AV-V-V) plus (A-V-V)','(AV-V-V) plus (V-V-V) ');
% xlabel('Response delay ms');
% ylabel('CDF');
% title({'Comparision between violation of AV response from Independent Race Model (RM No2)'}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
% hold off;
% savefig(Hfig11,strcat(Outdir,'\','Fig11'));
% saveas(Hfig11,strcat(Outdir,'\','Fig11.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
