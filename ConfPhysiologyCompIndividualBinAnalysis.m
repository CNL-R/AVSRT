% This script calculate the use PhysExtract to compare some important
% average Physiology

Electrodelist=[11 82 141 148 213];  % 11=A11 (Vis), 82=C18 (AudR), 141=E13 (M), 148=E20 (Logic), 213=G21 (AudL) 
ElecIndicates= {'Visual' 'R Audio' 'Motor' 'Perception' 'L Audio'};  
ElecNames={'A11' 'C18' 'E13' 'E20' 'G21'};
hsz=size(ERPavg1);
Outdir = uigetdir('D:\Arian\Projects\SMART\Outputs\Physiology\','Select Output Directory for the Graphs!'); 


for k=1:length(Electrodelist),
   comcondlist=[1,6,4,5]; % 6-A-A 4-V-A 5-AV-A
   %%%%%%%%%%%%%%%%%%%%
   for j=1:length(Electrodelist),
       [resPureA, resA,resV,resAV,avePureA,averesA,averesV,averesAV] = PhysExtract(comcondlist,ERPavg1,Electrodelist(j));
        Hfig1=figure;
        plot(avePureA,'g');
        hold;
        plot(averesA,'b');
        plot(averesV,'r');
        plot(averesAV,'k');
        hold;
        legend('Pure A','A-A','V-A','AV-A');
        title({strcat('Average EEG over all participants for conditions: ',num2str(comcondlist)),strcat('at electrode: ', char(ElecNames(j)),', related to ',char(ElecIndicates(j)),' cortex' ) });
%       title({strcat('Conditioned Average EEG over all participants at electrode:', char(ElecIndicates(j))),strcat('for conditions: ',num2str(comcondlist)) });
        savefig(Hfig1,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig1'));
        saveas(Hfig1,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig1.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
        
       %%%%% Just Individual graphs
       for i =1:1:hsz(1,1), % draw one EEG signal for each individuals
            Hfig2=figure;
            plot(resPureA(i,:),'g');
            hold;
            plot(resA(i,:),'b');
            plot(resV(i,:),'r');
            plot(resAV(i,:),'k');
            hold;
            legend('Pure A','A-A','V-A','AV-A');
            title({strcat('Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('for individial: ',char(id(i)))});   
            savefig(Hfig2,strcat(Outdir,'\Individual\',strjoin(id(i)),'Elect',strjoin(ElecNames(j)),'Fig21'));
            saveas(Hfig2,strcat(Outdir,'\Individual\',strjoin(id(i)),'Elect',strjoin(ElecNames(j)),'Fig21.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name      
       end 
       %%%%% END Just Individual graphs
       
       %%%%% Filtered Individual graphs
       for i =1:1:hsz(1,1), % draw one EEG signal for each individuals
            niq=500; %niqist rate
            fL=0.5/niq;
            fH=5/niq;
            
            [b,a] = butter(3, [fL fH], 'bandpass');
            fresPureA=filtfilt(b,a,resPureA(i,:));
            fresA=filtfilt(b,a,resA(i,:));
            fresV=filtfilt(b,a,resV(i,:));
            fresAV=filtfilt(b,a,resAV(i,:));
            
            Hfig3=figure;
            plot(fresPureA,'g');
            hold;
            plot(fresA,'b');
            plot(fresV,'r');
            plot(fresAV,'k');
            hold;
            legend('filt Pure A','filt A-A','filt V-A','filt AV-A');
            title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('for individial: ',char(id(i))),strcat('fH of filter=',num2str(fH*niq),'Htz')});   
            savefig(Hfig3,strcat(Outdir,'\Individual\',strjoin(id(i)),'Elect',strjoin(ElecNames(j)),'Fig31'));
            saveas(Hfig3,strcat(Outdir,'\Individual\',strjoin(id(i)),'Elect',strjoin(ElecNames(j)),'Fig31.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name      
       end 
       %%%%% END Filtered Individual graphs
    end
   
     
   comcondlist=[2,7,9,8]; % 2=pureV 7-V-V  9=A->V  8=AV->V
   
   
   
   comcondlist=[3,11,12,10]; % 3=pureAV 11=AV->AV  12=A->AV  10=V->AV
   
  %%%%
   
   comcondlist=[3,4,7,10] ;% 3=pureAV 4=V->A 7=V->V 10=V->AV 
   
   comcondlist=[3,6,9,12] ;% 3=pureAV 6=A->A  9=A->V 12=A->AV
   
   comcondlist=[3,5,8,11] ;% 3=pureAV 5=AV->A 8=AV->V  11=AV->AV
   
end




    
    
    
%     dimension2 = "conditions"
% %note that all these values one less from the values in the log files
% %this was because of a preprocessing step that reallocated values
% 	1=pureA
% 	2=pureV
% 	3=pureAV
% 	4=V->A
% 	5=AV->A
% 	6=A->A
% 	7=V->V
% 	8=AV->V
% 	9=A->V
% 	10=V->AV
% 	11=AV->AV
% 	12=A->AV
% 	*virtual conditions*
% 	13=1+2
% 	14=6+7
% 	15=4+9
% 	16=50% combination of 11 and 12 to encompass "AV switch" but without doubling n
% 	17=13-3
% 	18=14-11
% 	19=15-16