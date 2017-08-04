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
cumulativecondcell=cell(ncond,1);% conditioned individual cell
excludeindvds=[]; % this is the id index of individuals which should be excluded from analysis due to unreliable or impossible results or wrong measurements

Outdir = uigetdir('D:\Arian\Projects\SMART\Outputs\mintAtBHypoth\Average\','Select Output Directory for the Graphs!'); 

for j=1:size(id,2), % the index of individual in the indcell
  if any(excludeindvds==j) , % this means j is an excluded individual also may be implemented by  sum(ismember(excludeindvds,j))>0
  else
    for cond=2:ncond,
        condindx=find(indcell{j}(:,1)==cond);
        cumulativecondcell{cond}=[cumulativecondcell{cond}; indcell{j}(condindx,2)];
    end
  end
end % for 1:size(id,2)..    
    
    

%%%%%%%Fig 1 Pure Mode %%%%%%%%%%%%%
focusconds=[2,3,4];
condA=focusconds(1);
condB=focusconds(2);
condC=focusconds(3);
%[cdevalpts,htA,htB,htC,h_min_tAtB,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC]=CDFcomparitor(condA,condB,condC,cumulativecondcell,CDFsteps);
[cdevalpts,htA,htB,htC,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcelltA,sortedcelltB,sortedcelltC,sortedcelltIRM,sortedcellSimRM] = CDFcomparitorV2(condA,condB,condC, cumulativecondcell,CDFsteps );



hRM=htA+htB;
hRM(hRM>1)=1;

htpureA=htA;
htpureV=htB;
htpureAV=htC;
htpureIRM=h_min_tAtB;
htpureRM=hRM;
cdevalptspure=cdevalpts;

puremeanA=meanA;
puremedA=medA;
purestdA=stdA;
puremeanV=meanB;
puremedV=medB;
purestdV=stdB;
puremeanAV=meanC;
puremedAV=medC;
purestdAV=stdC;

Hfig1=figure;
plot(cdevalpts,hRM,'-.c','LineWidth',2);
hold on;
plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
plot(cdevalpts,htA,'--m','LineWidth',2);
plot(cdevalpts,htB,'-.g','LineWidth',2);
axis([100 400 -inf inf]);
legend('RM No. 1','Audio-Visual','RM No. 2','Audio','Visual');
xlabel('Reaction Time (ms)');
ylabel('CDF');
title({'Group-Level Cumulative Probability Distributions','-pure mode A-A,V-V,AV-AV, ',strjoin(id(j)),strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(medA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(medB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig1,strcat(Outdir,'\','Fig1'));
saveas(Hfig1,strcat(Outdir,'\','Fig1.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

%%%%%%%Fig 2 Multi Auditory History%%%%%%%%%%%%%
focusconds=[7,10,13];
condA=focusconds(1);
condB=focusconds(2);
condC=focusconds(3);
%[cdevalpts,htA,htB,htC,h_min_tAtB,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC]=CDFcomparitor(condA,condB,condC,cumulativecondcell,CDFsteps);
[cdevalpts,htA,htB,htC,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcelltA,sortedcelltB,sortedcelltC,sortedcelltIRM,sortedcellSimRM] = CDFcomparitorV2(condA,condB,condC, cumulativecondcell,CDFsteps );

hRM=htA+htB;
hRM(hRM>1)=1;

htmultiA_A=htA;
htmultiA_V=htB;
htmultiA_AV=htC;
htmultipsA_IRM=h_min_tAtB;
htmultipsA_RM=hRM;
cdevalptsmultipsA=cdevalpts;

multimeanA_A=meanA;
multimedA_A=medA;
multistdA_A=stdA;
multimeanA_V=meanB;
multimedA_V=medB;
multistdA_V=stdB;
multimeanA_AV=meanC;
multimedA_AV=medC;
multistdA_AV=stdC;

Hfig2=figure;
plot(cdevalpts,hRM,'-.c','LineWidth',2);
hold on;
plot(cdevalpts,htC,'--b','LineWidth',2);% you may specify marker size too by 'MarkerSize',6
plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
plot(cdevalpts,htA,'--m','LineWidth',2);
plot(cdevalpts,htB,'-.g','LineWidth',2);
axis([100 400 -inf inf]);
legend('RM No. 1','Audio-Visual','RM No. 2','Audio','Visual');
xlabel('Reaction Time (ms)');
ylabel('CDF');
title({'Group-Level Cumulative Probability Distributions','-multi mode A-A,A-V,A-AV, ',strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(medA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(medB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig2,strcat(Outdir,'\','Fig2'));
saveas(Hfig2,strcat(Outdir,'\','Fig2.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

%%%%%%%Fig 3  Multi AV History%%%%%%%%%%%%%%%
focusconds=[6,9,12];
condA=focusconds(1);
condB=focusconds(2);
condC=focusconds(3);
[cdevalpts,htA,htB,htC,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcelltA,sortedcelltB,sortedcelltC,sortedcelltIRM,sortedcellSimRM] = CDFcomparitorV2(condA,condB,condC, cumulativecondcell,CDFsteps );
%[cdevalpts,htA,htB,htC,h_min_tAtB,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC]=CDFcomparitor(condA,condB,condC,cumulativecondcell,CDFsteps);
hRM=htA+htB;
hRM(hRM>1)=1;

htmultiAV_A=htA;
htmultiAV_V=htB;
htmultiAV_AV=htC;
htmultipsAV_IRM=h_min_tAtB;
htmultipsAV_RM=hRM;
cdevalptsmultipsAV=cdevalpts;

multimeanAV_A=meanA;
multimedAV_A=medA;
multistdAV_A=stdA;
multimeanAV_V=meanB;
multimedAV_V=medB;
multistdAV_V=stdB;
multimeanAV_AV=meanC;
multimedAV_AV=medC;
multistdAV_AV=stdC;

Hfig3=figure;
plot(cdevalpts,hRM,'-.c','LineWidth',2);
hold on;
plot(cdevalpts,htC,'--b','LineWidth',2);
plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
plot(cdevalpts,htA,'--m','LineWidth',2);
plot(cdevalpts,htB,'-.g','LineWidth',2);
axis([100 400 -inf inf]);
legend('RM No. 1','Audio-Visual','RM No. 2','Audio','Visual');
xlabel('Reaction Time (ms)');
ylabel('CDF');
title({'Group-Level Cumulative Probability Distributions','-multi mode AV-A,AV-V,AV-AV, ',strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(medA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(medB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig3,strcat(Outdir,'\','Fig3'));
saveas(Hfig3,strcat(Outdir,'\','Fig3.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name



%%%%%%%Fig 4 Multi Vision History %%%%%%%%%%%%%%%
focusconds=[5,8,11];
condA=focusconds(1);
condB=focusconds(2);
condC=focusconds(3);
[cdevalpts,htA,htB,htC,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcelltA,sortedcelltB,sortedcelltC,sortedcelltIRM,sortedcellSimRM] = CDFcomparitorV2(condA,condB,condC, cumulativecondcell,CDFsteps );
%[cdevalpts,htA,htB,htC,h_min_tAtB,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC]=CDFcomparitor(condA,condB,condC,cumulativecondcell,CDFsteps);
hRM=htA+htB;
hRM(hRM>1)=1;

htmultiV_A=htA;
htmultiV_V=htB;
htmultiV_AV=htC;
htmultipsV_IRM=h_min_tAtB;
htmultipsV_RM=hRM;
cdevalptsmultipsV=cdevalpts;

multimeanV_A=meanA;
multimedV_A=medA;
multistdV_A=stdA;
multimeanV_V=meanB;
multimedV_V=medB;
multistdV_V=stdB;
multimeanV_AV=meanC;
multimedV_AV=medC;
multistdV_AV=stdC;

Hfig4=figure;
plot(cdevalpts,hRM,'-.c','LineWidth',2);
hold on;
plot(cdevalpts,htC,'--b','LineWidth',2);
plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
plot(cdevalpts,htA,'--m','LineWidth',2);
plot(cdevalpts,htB,'-.g','LineWidth',2);
axis([100 400 -inf inf]);
legend('RM No. 1','Audio-Visual','RM No. 2','Audio','Visual');
xlabel('Reaction Time (ms)');
ylabel('CDF');
title({'Group-Level Cumulative Probability Distributions','-multi mode V-A,V-V,V-AV, ',strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(medA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(medB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig4,strcat(Outdir,'\','Fig4'));
saveas(Hfig4,strcat(Outdir,'\','Fig4.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

%%%%%%%Fig 5 Repeat %%%%%%%%%%%%%%%
focusconds=[7,8,12];
condA=focusconds(1);
condB=focusconds(2);
condC=focusconds(3);
[cdevalpts,htA,htB,htC,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcelltA,sortedcelltB,sortedcelltC,sortedcelltIRM,sortedcellSimRM] = CDFcomparitorV2(condA,condB,condC, cumulativecondcell,CDFsteps );
%[cdevalpts,htA,htB,htC,h_min_tAtB,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC]=CDFcomparitor(condA,condB,condC,cumulativecondcell,CDFsteps);
hRM=htA+htB;
hRM(hRM>1)=1;

htrepeatA=htA; %Not needed because already calculated conditions
htrepeatV=htB;
htrepeatAV=htC;
htrepeat_IRM=h_min_tAtB;
htrepeat_RM=hRM;
cdevalptsrepeat=cdevalpts;

Hfig5=figure;
plot(cdevalpts,hRM,'-.c','LineWidth',2);
hold on;
plot(cdevalpts,htC,'--b','LineWidth',2);
plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
plot(cdevalpts,htA,'--m','LineWidth',2);
plot(cdevalpts,htB,'-.g','LineWidth',2);
axis([100 400 -inf inf]);
legend('RM No. 1','Audio-Visual','RM No. 2','Audio','Visual');
xlabel('Reaction Time (ms)');
ylabel('CDF');
title({'Group-Level Cumulative Probability Distributions','-repeat A-A,V-V,AV-AV, ',strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(medA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(medB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig5,strcat(Outdir,'\','Fig5'));
saveas(Hfig5,strcat(Outdir,'\','Fig5.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

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
 mixedcellA=[mixedcellA; cumulativecondcell{comcondA(ind)}];
end 
for ind=1:length(comcondB),
 mixedcellB=[mixedcellB; cumulativecondcell{comcondB(ind)}];
end 
for ind=1:length(comcondC),
 mixedcellC=[mixedcellC; cumulativecondcell{comcondC(ind)}];
end 

sortedcelltA=sort(mixedcellA); % sort conditioned cell
sortedcelltB=sort(mixedcellB); % sort conditioned cell
sortedcelltC=sort(mixedcellC); % sort conditioned cell

[cdevalpts,htA,htB,htC,hRM,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcellIRM,sortedcellSimRM] = CDFcomparitorGeneral(sortedcelltA,sortedcelltB,sortedcelltC,CDFsteps );

htclassA=htA;
htclassV=htB;
htclassAV=htC;
htclassical_IRM=h_min_tAtB;
htclassical_RM=hRM;
cdevalptsclassical=cdevalpts;

classicmeanA=meanA;
classicmedA=medA;
classicstdA=stdA;
classicmeanV=meanB;
classicmedV=medB;
classicstdV=stdB;
classicmeanAV=meanC;
classicmedAV=medC;
classicstdAV=stdC;

Hfig6=figure;
plot(cdevalpts,hRM,'-.c','LineWidth',2);
hold on;
plot(cdevalpts,htC,'--b','LineWidth',2);
plot(cdevalpts,h_min_tAtB,'-.r','LineWidth',2);
plot(cdevalpts,htA,'--m','LineWidth',2);
plot(cdevalpts,htB,'-.g','LineWidth',2);
axis([100 400 -inf inf]);
legend('RM No. 1','Audio-Visual','RM No. 2','Audio','Visual');
xlabel('Reaction Time (ms)');
ylabel('CDF');
title({'Group-Level Cumulative Probability Distributions','-multi mode classical A,V,AV, ',strcat('mean(\tau_A)=',num2str(meanA,'%.1f'), ', median(\tau_A)=',num2str(medA,'%.1f'),', std(\tau_A)=',num2str(stdA,'%.1f')), strcat('mean(\tau_V)=',num2str(meanB,'%.1f'), ', median(\tau_V)=',num2str(medB,'%.1f'),', std(\tau_V)=',num2str(stdB,'%.1f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig6,strcat(Outdir,'\','Fig6'));
saveas(Hfig6,strcat(Outdir,'\','Fig6.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

%%%%%%%%%%%%%%%%%% Figure 21  the Miller differnce %%%%%%%%%%%%
Hfig21=figure;
plot(cdevalptspure,htpureAV-htpureRM,'-.b','LineWidth',2);
hold on;
plot(cdevalptsrepeat,htrepeatAV-htrepeat_RM,'-.g','LineWidth',2);
plot(cdevalptsmultipsA,htmultiA_AV-htmultipsA_RM,'-.r','LineWidth',2);
plot(cdevalptsmultipsAV,htmultiAV_AV-htmultipsAV_RM,'-.c','LineWidth',2);
plot(cdevalptsmultipsV,htmultiV_AV-htmultipsV_RM,'-.m','LineWidth',2);
plot(cdevalptsclassical,htclassAV-htclassical_RM,'-.k','LineWidth',2);
axis([100 400 -inf inf]);
legend('Pures','Repeats','Mixed Switches-Audio history','Mixed Switches-AV history','Mixed Switches-V history','Classic' );
xlabel('Reaction Time (ms)');
ylabel('CDF');
title({'Miller Inequality (Bimodal response difference from Race Model No. 1)'}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig21,strcat(Outdir,'\','Fig21'));
saveas(Hfig21,strcat(Outdir,'\','Fig21.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

%%%%%%%%%%%%%%%%%%%% Figure 22  the Miller differnce %%%%%%%%%%%%
Hfig22=figure;
plot(cdevalptspure,htpureAV-htpureIRM,'-.b','LineWidth',2);
hold on;
plot(cdevalptsrepeat,htrepeatAV-htrepeat_IRM,'-.g','LineWidth',2);
plot(cdevalptsmultipsA,htmultiA_AV-htmultipsA_IRM,'-.r','LineWidth',2);
plot(cdevalptsmultipsAV,htmultiAV_AV-htmultipsAV_IRM,'-.c','LineWidth',2);
plot(cdevalptsmultipsV,htmultiV_AV-htmultipsV_IRM,'-.m','LineWidth',2);
plot(cdevalptsclassical,htclassAV-htclassical_IRM,'-.k','LineWidth',2);
axis([100 400 -inf inf]);
legend('Pures','Repeats','Mixed Switches-Audio history','Mixed Switches-AV history','Mixed Switches-V history','Classic' );
xlabel('Reaction Time (ms)');
ylabel('CDF');
title({'Miller Inequality (Bimodal response difference from Race Model No. 2'}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig22,strcat(Outdir,'\','Fig22'));
saveas(Hfig22,strcat(Outdir,'\','Fig22.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name



%%%%%%%%%%% Figures Signals Versus previous conditions comparision%%%%%%%%%%%%%% 

Hfig17=figure;
plot(cdevalptspure,htpureA,'-.r','LineWidth',2);
hold on;
plot(cdevalptsmultipsA,htmultiA_A,'-.b','LineWidth',2);
plot(cdevalptsmultipsV,htmultiV_A,'-.g','LineWidth',2);
plot(cdevalptsmultipsAV,htmultiAV_A,'-.c','LineWidth',2);
axis([100 400 -inf inf]);
legend('Pure A','Repeat A','Switch V-A ','Switch AV-A');
xlabel('Reaction Time (ms)');
ylabel('CDF');
title({'Comparision between Group-Level Audio response based on hitory','-pure vs multi A-A,V-A,AV-A, ',strcat('mean(\tau_A|pu)=',num2str(puremeanA,'%.0f'),', mean(\tau_A|rep)=',num2str(multimeanA_A,'%.0f'),', mean(\tau_A|V-A)=',num2str(multimeanV_A,'%.0f'),', mean(\tau_A|AV-A)=',num2str(multimeanAV_A,'%.0f')),strcat(', std(\tau_A|pu)=',num2str(purestdA,'%.0f'),', std(\tau_A|rep)=',num2str(multistdA_A,'%.0f'),', std(\tau_A|V-A)=',num2str(multistdV_A,'%.0f'),', std(\tau_A|AV-A)=',num2str(multistdAV_A,'%.0f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig17,strcat(Outdir,'\','Fig17'));
saveas(Hfig17,strcat(Outdir,'\','Fig17.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

Hfig18=figure;
plot(cdevalptspure,htpureV,'-.r','LineWidth',2);
hold on;
plot(cdevalptsmultipsV,htmultiV_V,'-.b','LineWidth',2);
plot(cdevalptsmultipsA,htmultiA_V,'-.g','LineWidth',2);
plot(cdevalptsmultipsAV,htmultiAV_V,'-.c','LineWidth',2);
axis([100 400 -inf inf]);
legend('Pure V','Repeat V','Switch A-V ','Switch AV-V');
xlabel('Reaction Time (ms)');
ylabel('CDF');
title({'Comparision between Group-Level Visual response based on hitory','-pure vs multi V-V,A-V,AV-V, ',strcat('mean(\tau_V|pu)=',num2str(puremeanV,'%.0f'),', mean(\tau_V|rep)=',num2str(multimeanV_V,'%.0f'),', mean(\tau_V|A-V)=',num2str(multimeanA_V,'%.0f'),', mean(\tau_V|AV-V)=',num2str(multimeanAV_V,'%.0f')),strcat('std(\tau_V|pu)=',num2str(purestdV,'%.0f'),', std(\tau_V|rep)=',num2str(multistdV_V,'%.0f'),', std(\tau_V|A-V)=',num2str(multistdA_V,'%.0f'),', std(\tau_V|AV-V)=',num2str(multistdAV_V,'%.0f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig18,strcat(Outdir,'\','Fig18'));
saveas(Hfig18,strcat(Outdir,'\','Fig18.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

Hfig19=figure;
plot(cdevalptspure,htpureAV,'-.r','LineWidth',2);
hold on;
plot(cdevalptsmultipsAV,htmultiAV_AV,'-.b','LineWidth',2);
plot(cdevalptsmultipsA,htmultiA_AV,'-.g','LineWidth',2);
plot(cdevalptsmultipsV,htmultiV_AV,'-.c','LineWidth',2);
axis([100 400 -inf inf]);
legend('Pure AV','Repeat AV','Switch A-AV ','Switch V-AV');
xlabel('Reaction Time (ms)');
ylabel('CDF');
title({'Comparision between Group-Level Audio-Vision response based on hitory','-pure vs multi AV-AV,A-AV,V-AV, ',strcat('mean(\tau_{AV}|pu)=',num2str(puremeanAV,'%.0f'),', mean(\tau_{AV}|rep)=',num2str(multimeanAV_AV,'%.0f'),', mean(\tau_{AV}|A-AV)=',num2str(multimeanA_AV,'%.0f'),', mean(\tau_{AV}|V-AV)=',num2str(multimeanV_AV,'%.0f')),strcat('std(\tau_{AV}|pu)=',num2str(purestdAV,'%.0f'),', std(\tau_{AV}|rep)=',num2str(multistdAV_AV,'%.0f'),', std(\tau_{AV}|A-AV)=',num2str(multistdA_AV,'%.0f'),', std(\tau_{AV}|V-AV)=',num2str(multistdV_AV,'%.0f'))}); %  id(excludeindvds) is the id number of excluded individuals and shall be convert to string
hold off;
savefig(Hfig19,strcat(Outdir,'\','Fig19'));
saveas(Hfig19,strcat(Outdir,'\','Fig19.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

%%%%%%%%%

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