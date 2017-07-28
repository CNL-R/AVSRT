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
combcondB=[6,7];% AV-A-A
condAPrec=combcondA(1);
condACurr=combcondA(2);
condBPrec=combcondB(1);
condBCurr=combcondB(2);
mixedcell1=[seqcondcell{condBPrec,condBCurr};seqcondcell{condAPrec,condACurr}];

combcondA=[10,8];% A-V-V
combcondB=[9,8]; % AV-V-V
condAPrec=combcondA(1);
condACurr=combcondA(2);
condBPrec=combcondB(1);
condBCurr=combcondB(2);
mixedcell2=[seqcondcell{condBPrec,condBCurr};seqcondcell{condAPrec,condACurr}];


combcondA=[13,12];% A-AV-AV
combcondB=[12,12];% AV-AV-AV
combcondC=[11,12];% V-AV-AV
condAPrec=combcondA(1);
condACurr=combcondA(2);
condBPrec=combcondB(1);
condBCurr=combcondB(2);
condCPrec=combcondC(1);
condCCurr=combcondC(2);
mixedcell3=[seqcondcell{condCPrec,condCCurr};seqcondcell{condBPrec,condBCurr};seqcondcell{condAPrec,condACurr}];

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
legend('(AV-V-V) plus (A-V-V)','(V-A-A) plus (AV-A-A)','AV-AV','RM','Independent RM');
xlabel('Response delay ms');
ylabel('CDF');
title({'Comparision between empirical AV-AV response and Race Model of Collection 1 and 2,', strcat('mean(\tau_{C_1})=',num2str(meanA,'%.1f'), ', median(\tau_{C_1})=',num2str(medA,'%.1f'),', std(\tau_{C_1})=',num2str(stdA,'%.1f')), strcat('mean(\tau_{C_2})=',num2str(meanB,'%.1f'), ', median(\tau_{C_1})=',num2str(medB,'%.1f'),', std(\tau_{C_1})=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig1,strcat(Outdir,'\','Fig1'));
saveas(Hfig1,strcat(Outdir,'\','Fig1.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

%@@@@@@@@@@@@@@@@@@@@  FIGURE 2  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
combcondA=[7,7];% A-A-A
combcondB=[6,7];% AV-A-A
condAPrec=combcondA(1);
condACurr=combcondA(2);
condBPrec=combcondB(1);
condBCurr=combcondB(2);
mixedcell1=[seqcondcell{condBPrec,condBCurr};seqcondcell{condAPrec,condACurr}];

combcondA=[8,8];% V-V-V
combcondB=[9,8]; % AV-V-V
condAPrec=combcondA(1);
condACurr=combcondA(2);
condBPrec=combcondB(1);
condBCurr=combcondB(2);
mixedcell2=[seqcondcell{condBPrec,condBCurr};seqcondcell{condAPrec,condACurr}];


combcondA=[13,12];% A-AV-AV
combcondB=[12,12];% AV-AV-AV
combcondC=[11,12];% V-AV-AV
condAPrec=combcondA(1);
condACurr=combcondA(2);
condBPrec=combcondB(1);
condBCurr=combcondB(2);
condCPrec=combcondC(1);
condCCurr=combcondC(2);
mixedcell3=[seqcondcell{condCPrec,condCCurr};seqcondcell{condBPrec,condBCurr};seqcondcell{condAPrec,condACurr}];

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
legend('(AV-V-V) plus (V-V-V)','(A-A-A) plus (AV-A-A)','AV-AV','RM','Independent RM');
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

combcondA=[8,8];% V-V-V
condAPrec=combcondA(1);
condACurr=combcondA(2);
mixedcell2=seqcondcell{condAPrec,condACurr};

combcondA=[12,12];% AV-AV-AV
%combcondB=[13,12];% A-AV-AV
%combcondC=[11,12];% V-AV-AV
condAPrec=combcondA(1);
condACurr=combcondA(2);
mixedcell3=seqcondcell{condAPrec,condACurr};
% condBPrec=combcondB(1);
% condBCurr=combcondB(2);
% condCPrec=combcondC(1);
% condCCurr=combcondC(2);
%mixedcell3=[seqcondcell{condCPrec,condCCurr};seqcondcell{condBPrec,condBCurr};seqcondcell{condAPrec,condACurr}];

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
legend('V-V-V','A-A-A','AV-AV-AV','RM','Independent RM');
xlabel('Response delay ms');
ylabel('CDF');
title({'Comparision between empirical AV-AV-AV response and Race Model of A-A-A and V-V-V,', strcat('mean(\tau_{C_1})=',num2str(meanA,'%.1f'), ', median(\tau_{C_1})=',num2str(medA,'%.1f'),', std(\tau_{C_1})=',num2str(stdA,'%.1f')), strcat('mean(\tau_{C_2})=',num2str(meanB,'%.1f'), ', median(\tau_{C_1})=',num2str(medB,'%.1f'),', std(\tau_{C_1})=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig3,strcat(Outdir,'\','Fig3'));
saveas(Hfig3,strcat(Outdir,'\','Fig3.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
%@@@@@@@@@@@@@@@@@@@@@@@@@@ Figure 10  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
[mRMVio1,indm1]=max(DiffromRMFig1);
[mRMVio2,indm2]=max(DiffromRMFig2);
[mRMVio3,indm3]=max(DiffromRMFig3);
% quiver(cdevalptsFig3(indm3),0,0,mRMVio3,0);
% quiver(cdevalptsFig1(indm1),0,0,mRMVio1,0);
% quiver(cdevalptsFig2(indm2),0,0,mRMVio2,0);

Hfig10=figure;
plot(cdevalptsFig3,DiffromRMFig3,'-.b','LineWidth',2);
hold on;
plot(cdevalptsFig1,DiffromRMFig1,'-.r','LineWidth',2);
plot(cdevalptsFig2,DiffromRMFig2,'-.g','LineWidth',2);
legend('Double Repeat','(AV-V-V) plus (A-V-V)','(AV-V-V) plus (V-V-V) ');
xlabel('Response delay ms');
ylabel('CDF');
title({'Comparision between violation of AV response from Race Model'}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig10,strcat(Outdir,'\','Fig10'));
saveas(Hfig10,strcat(Outdir,'\','Fig10.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name


%@@@@@@@@@@@@@@@@@@@@@@@@@@ Figure 10  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
[mIRMVio1,indI1]=max(DiffromIRMFig1);
[mIRMVio2,indI2]=max(DiffromIRMFig2);
[mIRMVio3,indI3]=max(DiffromIRMFig3);

Hfig11=figure;
plot(cdevalptsFig3,DiffromIRMFig3,'-.b','LineWidth',2);
hold on;
plot(cdevalptsFig1,DiffromIRMFig1,'-.r','LineWidth',2);
plot(cdevalptsFig2,DiffromIRMFig2,'-.g','LineWidth',2);
legend('Double Repeat','(AV-V-V) plus (A-V-V)','(AV-V-V) plus (V-V-V) ');
xlabel('Response delay ms');
ylabel('CDF');
title({'Comparision between violation of AV response from Independent Race Model (RM No2)'}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig11,strcat(Outdir,'\','Fig11'));
saveas(Hfig11,strcat(Outdir,'\','Fig11.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name



% %%%%%%%Fig 2%%%%%%%%%%%%%
% focusconds=[7,10,13];
% condA=focusconds(1);
% condB=focusconds(2);
% condC=focusconds(3);
% [cdevalpts,htA,htB,htC,h_min_tAtB,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC]=CDFcomparitor(condA,condB,condC,cumulativecondcell,CDFsteps);
% hRM=htA+htB;
% hRM(hRM>1)=1;
% 
% htmultiA_A=htA;
% htmultiA_V=htB;
% htmultiA_AV=htC;
% htmultipsA_min=h_min_tAtB;
% htmultipsA_RM=hRM;
% cdevalptsmultipsA=cdevalpts;
% 
% multimeanA_A=meanA;
% multimedA_A=medA;
% multistdA_A=stdA;
% multimeanA_V=meanB;
% multimedA_V=medB;
% multistdA_V=stdB;
% multimeanA_AV=meanC;
% multimedA_AV=medC;
% multistdA_AV=stdC;
% 
% Hfig2=figure;
% plot(cdevalpts,hRM,'-.c','LineWidth',2);
% hold on;
% plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
% plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
% plot(cdevalpts,htA,'--m','LineWidth',2);
% plot(cdevalpts,htB,'-.g','LineWidth',2);
% axis([100 400 -inf inf]);
% legend('RM','AV response','min(tA,tV)','Audio','Visual');
% xlabel('Response delay ms');
% ylabel('CDF');
% title({'Comparision between min(tA,tV) and empirical AV response on average','-multi mode A-A,A-V,A-AV, ',strcat('-excluded individuals: ',strjoin(id(excludeindvds))),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(medA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(medB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
% hold off;
% savefig(Hfig2,strcat(Outdir,'\','Fig2'));
% saveas(Hfig2,strcat(Outdir,'\','Fig2.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
% 
% %%%%%%%Fig 3%%%%%%%%%%%%%%%
% focusconds=[6,9,12];
% condA=focusconds(1);
% condB=focusconds(2);
% condC=focusconds(3);
% [cdevalpts,htA,htB,htC,h_min_tAtB,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC]=CDFcomparitor(condA,condB,condC,cumulativecondcell,CDFsteps);
% hRM=htA+htB;
% hRM(hRM>1)=1;
% 
% htmultiAV_A=htA;
% htmultiAV_V=htB;
% htmultiAV_AV=htC;
% htmultipsAV_min=h_min_tAtB;
% htmultipsAV_RM=hRM;
% cdevalptsmultipsAV=cdevalpts;
% 
% multimeanAV_A=meanA;
% multimedAV_A=medA;
% multistdAV_A=stdA;
% multimeanAV_V=meanB;
% multimedAV_V=medB;
% multistdAV_V=stdB;
% multimeanAV_AV=meanC;
% multimedAV_AV=medC;
% multistdAV_AV=stdC;
% 
% Hfig3=figure;
% plot(cdevalpts,hRM,'-.c','LineWidth',2);
% hold on;
% plot(cdevalpts,htC,'--b','LineWidth',2);
% plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
% plot(cdevalpts,htA,'--m','LineWidth',2);
% plot(cdevalpts,htB,'-.g','LineWidth',2);
% axis([100 400 -inf inf]);
% legend('RM','AV response','min(tA,tV)','Audio','Visual');
% xlabel('Response delay ms');
% ylabel('CDF');
% title({'Comparision between min(tA,tV) and empirical AV response on average','-multi mode AV-A,AV-V,AV-AV, ',strcat('-excluded individuals: ',strjoin(id(excludeindvds))),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(medA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(medB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
% hold off;
% savefig(Hfig3,strcat(Outdir,'\','Fig3'));
% saveas(Hfig3,strcat(Outdir,'\','Fig3.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
% 
% 
% 
% %%%%%%%Fig 4%%%%%%%%%%%%%%%
% focusconds=[5,8,11];
% condA=focusconds(1);
% condB=focusconds(2);
% condC=focusconds(3);
% [cdevalpts,htA,htB,htC,h_min_tAtB,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC]=CDFcomparitor(condA,condB,condC,cumulativecondcell,CDFsteps);
% hRM=htA+htB;
% hRM(hRM>1)=1;
% 
% htmultiV_A=htA;
% htmultiV_V=htB;
% htmultiV_AV=htC;
% htmultipsV_min=h_min_tAtB;
% htmultipsV_RM=hRM;
% cdevalptsmultipsV=cdevalpts;
% 
% multimeanV_A=meanA;
% multimedV_A=medA;
% multistdV_A=stdA;
% multimeanV_V=meanB;
% multimedV_V=medB;
% multistdV_V=stdB;
% multimeanV_AV=meanC;
% multimedV_AV=medC;
% multistdV_AV=stdC;
% 
% Hfig4=figure;
% plot(cdevalpts,hRM,'-.c','LineWidth',2);
% hold on;
% plot(cdevalpts,htC,'--b','LineWidth',2);
% plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
% plot(cdevalpts,htA,'--m','LineWidth',2);
% plot(cdevalpts,htB,'-.g','LineWidth',2);
% axis([100 400 -inf inf]);
% legend('RM','AV response','min(tA,tV)','Audio','Visual');
% xlabel('Response delay ms');
% ylabel('CDF');
% title({'Comparision between min(tA,tV) and empirical AV response on average','-multi mode V-A,V-V,V-AV, ',strcat('-excluded individuals: ',strjoin(id(excludeindvds))),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(medA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(medB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
% hold off;
% savefig(Hfig4,strcat(Outdir,'\','Fig4'));
% saveas(Hfig4,strcat(Outdir,'\','Fig4.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
% 
% %%%%%%%Fig 5%%%%%%%%%%%%%%%
% focusconds=[7,8,12];
% condA=focusconds(1);
% condB=focusconds(2);
% condC=focusconds(3);
% [cdevalpts,htA,htB,htC,h_min_tAtB,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC]=CDFcomparitor(condA,condB,condC,cumulativecondcell,CDFsteps);
% hRM=htA+htB;
% hRM(hRM>1)=1;
% 
% % htrepeatA=htA; Not needed because already calculated conditions
% % htrepeatV=htB;
% % htrepeatAV=htC;
% % htrepeat_min=h_min_tAtB;
% % htrepeat_RM=hRM;
% % cdevalptsrepeat=cdevalpts;
% 
% Hfig5=figure;
% plot(cdevalpts,hRM,'-.c','LineWidth',2);
% hold on;
% plot(cdevalpts,htC,'--b','LineWidth',2);
% plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
% plot(cdevalpts,htA,'--m','LineWidth',2);
% plot(cdevalpts,htB,'-.g','LineWidth',2);
% axis([100 400 -inf inf]);
% legend('RM','AV response','min(tA,tV)','Audio','Visual');
% xlabel('Response delay ms');
% ylabel('CDF');
% title({'Comparision between min(tA,tV) and empirical AV response on average','-multi mode A-A,V-V,AV-AV, ',strcat('-excluded individuals: ',strjoin(id(excludeindvds))),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(medA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(medB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
% hold off;
% savefig(Hfig5,strcat(Outdir,'\','Fig5'));
% saveas(Hfig5,strcat(Outdir,'\','Fig5.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
% 
% %%%%%%%%%%% Figures Signals Versus previous conditions comparision%%%%%%%%%%%%%% 
% 
% Hfig6=figure;
% plot(cdevalptspure,htpureA,'-.r','LineWidth',2);
% hold on;
% plot(cdevalptsmultipsA,htmultiA_A,'-.b','LineWidth',2);
% plot(cdevalptsmultipsV,htmultiV_A,'-.g','LineWidth',2);
% plot(cdevalptsmultipsAV,htmultiAV_A,'-.c','LineWidth',2);
% axis([100 400 -inf inf]);
% legend('Pure A','Repeat A','Switch V-A ','Switch AV-A');
% xlabel('Response delay ms');
% ylabel('CDF');
% title({'Comparision between average Audio response','-pure vs multi A-A,V-A,AV-A, ',strcat('mean(\tau_A|pu)=',num2str(puremeanA,'%.0f'),', mean(\tau_A|rep)=',num2str(multimeanA_A,'%.0f'),', mean(\tau_A|V-A)=',num2str(multimeanV_A,'%.0f'),', mean(\tau_A|AV-A)=',num2str(multimeanAV_A,'%.0f')),strcat(', std(\tau_A|pu)=',num2str(purestdA,'%.0f'),', std(\tau_A|rep)=',num2str(multistdA_A,'%.0f'),', std(\tau_A|V-A)=',num2str(multistdV_A,'%.0f'),', std(\tau_A|AV-A)=',num2str(multistdAV_A,'%.0f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
% %title({'Comparision between average Audio response','-pure vs multi A-A,V-A,AV-A, ',strcat('-excluded individuals: ',strjoin(id(excludeindvds))),strcat('mean(\tau_A|pu)=',num2str(puremeanA,'%.0f'),', mean(\tau_A|rep)=',num2str(multimeanA_A,'%.0f'),', mean(\tau_A|V-A)=',num2str(multimeanV_A,'%.0f'),', mean(\tau_A|AV-A)=',num2str(multimeanAV_A,'%.0f')),strcat(', std(\tau_A|pu)=',num2str(purestdA,'%.0f'),', std(\tau_A|rep)=',num2str(multistdA_A,'%.0f'),', std(\tau_A|sw V-A)=',num2str(multistdV_A,'%.0f'),', std(\tau_A|sw AV-A)=',num2str(multistdAV_A,'%.0f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
% hold off;
% savefig(Hfig6,strcat(Outdir,'\','Fig6'));
% saveas(Hfig6,strcat(Outdir,'\','Fig6.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
% 
% Hfig7=figure;
% plot(cdevalptspure,htpureV,'-.r','LineWidth',2);
% hold on;
% plot(cdevalptsmultipsV,htmultiV_V,'-.b','LineWidth',2);
% plot(cdevalptsmultipsA,htmultiA_V,'-.g','LineWidth',2);
% plot(cdevalptsmultipsAV,htmultiAV_V,'-.c','LineWidth',2);
% axis([100 400 -inf inf]);
% legend('Pure V','Repeat V','Switch A-V ','Switch AV-V');
% xlabel('Response delay ms');
% ylabel('CDF');
% title({'Comparision between average Vision response','-pure vs multi V-V,A-V,AV-V, ',strcat('mean(\tau_V|pu)=',num2str(puremeanV,'%.0f'),', mean(\tau_V|rep)=',num2str(multimeanV_V,'%.0f'),', mean(\tau_V|A-V)=',num2str(multimeanA_V,'%.0f'),', mean(\tau_V|AV-V)=',num2str(multimeanAV_V,'%.0f')),strcat('std(\tau_V|pu)=',num2str(purestdV,'%.0f'),', std(\tau_V|rep)=',num2str(multistdV_V,'%.0f'),', std(\tau_V|A-V)=',num2str(multistdA_V,'%.0f'),', std(\tau_V|AV-V)=',num2str(multistdAV_V,'%.0f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
% %title({'Comparision between average Vision response','-pure vs multi V-V,A-V,AV-V, ',strcat('-excluded individuals: ',strjoin(id(excludeindvds))),strcat('mean(\tau_V|pu)=',num2str(puremeanV,'%.0f'),'mean(\tau_V|rep)=',num2str(multimeanV_V,'%.0f'),'mean(\tau_V|A-V)=',num2str(multimeanA_V,'%.0f'),'mean(\tau_V|AV-V)=',num2str(multimeanAV_V,'%.0f')),strcat('std(\tau_V|pu)=',num2str(purestdV,'%.0f'),'std(\tau_V|rep)=',num2str(multistdV_V,'%.0f'),'std(\tau_V|A-V)=',num2str(multistdA_V,'%.0f'),'std(\tau_V|AV-V)=',num2str(multistdAV_V,'%.0f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
% hold off;
% savefig(Hfig7,strcat(Outdir,'\','Fig7'));
% saveas(Hfig7,strcat(Outdir,'\','Fig7.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
% 
% Hfig8=figure;
% plot(cdevalptspure,htpureAV,'-.r','LineWidth',2);
% hold on;
% plot(cdevalptsmultipsAV,htmultiAV_AV,'-.b','LineWidth',2);
% plot(cdevalptsmultipsA,htmultiA_AV,'-.g','LineWidth',2);
% plot(cdevalptsmultipsV,htmultiV_AV,'-.c','LineWidth',2);
% axis([100 400 -inf inf]);
% legend('Pure AV','Repeat AV','Switch A-AV ','Switch V-AV');
% xlabel('Response delay ms');
% ylabel('CDF');
% title({'Comparision between average Audio-Vision response','-pure vs multi AV-AV,A-AV,V-AV, ',strcat('mean(\tau_{AV}|pu)=',num2str(puremeanAV,'%.0f'),', mean(\tau_{AV}|rep)=',num2str(multimeanAV_AV,'%.0f'),', mean(\tau_{AV}|A-AV)=',num2str(multimeanA_AV,'%.0f'),', mean(\tau_{AV}|V-AV)=',num2str(multimeanV_AV,'%.0f')),strcat('std(\tau_{AV}|pu)=',num2str(purestdAV,'%.0f'),', std(\tau_{AV}|rep)=',num2str(multistdAV_AV,'%.0f'),', std(\tau_{AV}|A-AV)=',num2str(multistdA_AV,'%.0f'),', std(\tau_{AV}|V-AV)=',num2str(multistdV_AV,'%.0f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
% %title({'Comparision between average Audio-Vision response','-pure vs multi AV-AV,A-AV,V-AV, ',strcat('-excluded individuals: ',strjoin(id(excludeindvds))),strcat('mean(\tau_{AV}|pu)=',num2str(puremeanAV,'%.0f'),', mean(\tau_{AV}|rep)=',num2str(multimeanAV_AV,'%.0f'),', mean(\tau_{AV}|A-AV)=',num2str(multimeanA_AV,'%.0f'),', mean(\tau_{AV}|V-AV)=',num2str(multimeanV_AV,'%.0f')),strcat('std(\tau_{AV}|pu)=',num2str(purestdAV,'%.0f'),', std(\tau_{AV}|rep)=',num2str(multistdAV_AV,'%.0f'),', std(\tau_{AV}|A-AV)=',num2str(multistdA_AV,'%.0f'),', std(\tau_{AV}|V-AV)=',num2str(multistdV_AV,'%.0f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
% hold off;
% savefig(Hfig8,strcat(Outdir,'\','Fig8'));
% saveas(Hfig8,strcat(Outdir,'\','Fig8.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name






%Possible useful function:
% kernel PDF estimation from a data set
%[f,xi] = ksdensity(x);
%[f,xi] = ksdensity(x,pts);  %specify the sample point

% histogram PDF;
% [counts binCenters] = hist(yourData, 256); % Use 256 bins. 
% plot(binCenters, counts);

%plot derivative of a function
%dydx = diff(y(:))./diff(x(:));