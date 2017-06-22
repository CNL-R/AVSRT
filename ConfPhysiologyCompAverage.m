% This script calculate the use PhysExtract to compare some important
% average Physiology

% Electrodelist=[11 82 141 148 213];  % 11=A11 (Vis), 82=C18 (AudR), 141=E13 (M), 148=E20 (Logic), 213=G21 (AudL) 
% ElecIndicates= {'Visual' 'R Audio' 'Motor' 'Perception' 'L Audio'};  
% ElecNames={'A11' 'C18' 'E13' 'E20' 'G21'};
close all;

Electrodelist=[11 82];  % 11=A11 (Vis), 82=C18 (AudR), 141=E13 (M), 148=E20 (Logic), 213=G21 (AudL) 
ElecIndicates= {'Visual' 'R Audio'};  
ElecNames={'A11' 'C18'};


hsz=size(ERPavg);
Outdir = uigetdir('D:\Arian\Projects\SMART\Outputs\Physiology\','Select Output Directory for the Graphs!'); 


for j=1:length(Electrodelist),
   
   comcondlist=[1,6,4,5]; % 6-A-A 4-V-A 5-AV-A
   %%%%%%%%%%%%%%%%%%%%
   
       [resPureA,resA,resV,resAV,avePureA,averesA,averesV,averesAV] = PhysExtract(comcondlist,ERPavg,Electrodelist(j));
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
     
   
        Hfig17=figure;
        plot(0.5*(avePureA+averesV),'g');
        hold;
        plot(averesA,'b');
        plot(averesV,'r');
        plot(averesAV,'k');
        hold;
        legend('1/2(A+V)-A','A-A','V-A','AV-A');
        title({strcat('Average EEG over all participants for conditions: ',num2str(comcondlist)),strcat('at electrode: ', char(ElecNames(j)),', related to ',char(ElecIndicates(j)),' cortex' ) });
%       title({strcat('Conditioned Average EEG over all participants at electrode:', char(ElecIndicates(j))),strcat('for conditions: ',num2str(comcondlist)) });
        savefig(Hfig17,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig17'));
        saveas(Hfig17,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig17.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

        
       %%%%% Filtered graphs
       
%        niq=500; %niqist rate
%        fL=0.5/niq;
%        fH=4/niq;
%        
%        [b,a] = butter(3, [fL fH], 'bandpass');
%        favePureA=filtfilt(b,a,avePureA);
%        faveresA=filtfilt(b,a,averesA);
%        faveresV=filtfilt(b,a,averesV);
%        faveresAV=filtfilt(b,a,averesAV);
%        
%        Hfig2=figure;
%        plot(favePureA,'g');
%        hold;
%        plot(faveresA,'b');
%        plot(faveresV,'r');
%        plot(faveresAV,'k');
%        hold;
%        legend('Pure A','A-A','V-A','AV-A');
%        title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
%        savefig(Hfig2,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig12'));
%        saveas(Hfig2,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig12.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
%     
       
%        fL=0.5/niq;
%        fH=8/niq;
%        
%        [b,a] = butter(3, [fL fH], 'bandpass');
%        favePureA=filtfilt(b,a,avePureA);
%        faveresA=filtfilt(b,a,averesA);
%        faveresV=filtfilt(b,a,averesV);
%        faveresAV=filtfilt(b,a,averesAV);
%        
%        Hfig3=figure;
%        plot(favePureA,'g');
%        hold;
%        plot(faveresA,'b');
%        plot(faveresV,'r');
%        plot(faveresAV,'k');
%        hold;
%        legend('Pure A','A-A','V-A','AV-A');
%        title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
%        savefig(Hfig3,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig13'));
%        saveas(Hfig3,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig13.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
    
       fL=0.5/niq;
       fH=12/niq;
       
       [b,a] = butter(3, [fL fH], 'bandpass');
       favePureA=filtfilt(b,a,avePureA);
       faveresA=filtfilt(b,a,averesA);
       faveresV=filtfilt(b,a,averesV);
       faveresAV=filtfilt(b,a,averesAV);
       
       Hfig4=figure;
       plot(favePureA,'g');
       hold;
       plot(faveresA,'b');
       plot(faveresV,'r');
       plot(faveresAV,'k');
       hold;
       legend('Pure A','A-A','V-A','AV-A');
       title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
       savefig(Hfig4,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig14'));
       saveas(Hfig4,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig14.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

       fL=0.5/niq;
       fH=30/niq;
       
       [b,a] = butter(3, [fL fH], 'bandpass');
       favePureA=filtfilt(b,a,avePureA);
       faveresA=filtfilt(b,a,averesA);
       faveresV=filtfilt(b,a,averesV);
       faveresAV=filtfilt(b,a,averesAV);
       
       Hfig5=figure;
       plot(favePureA,'g');
       hold;
       plot(faveresA,'b');
       plot(faveresV,'r');
       plot(faveresAV,'k');
       hold;
       legend('Pure A','A-A','V-A','AV-A');
       title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
       savefig(Hfig5,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig15'));
       saveas(Hfig5,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig15.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name      
       %%%%% END Filtered  graphs
   
       
   comcondlist=[2,7,9,8]; % 2=pureV 7-V-V  9=A->V  8=AV->V
   
        [resPureA,resA,resV,resAV,avePureA,averesA,averesV,averesAV] = PhysExtract(comcondlist,ERPavg,Electrodelist(j));
        Hfig=figure;
        plot(avePureA,'g');
        hold;
        plot(averesA,'b');
        plot(averesV,'r');
        plot(averesAV,'k');
        hold;
        legend('Pure V','V-V','A-V','AV-V');
        title({strcat('Average EEG over all participants for conditions: ',num2str(comcondlist)),strcat('at electrode: ', char(ElecNames(j)),', related to ',char(ElecIndicates(j)),' cortex' ) });
%       title({strcat('Conditioned Average EEG over all participants at electrode:', char(ElecIndicates(j))),strcat('for conditions: ',num2str(comcondlist)) });
        savefig(Hfig,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig2'));
        saveas(Hfig,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig2.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
 
        Hfig27=figure;
        plot(0.5*(averesA+averesV),'g');
        hold;
        plot(averesA,'b');
        plot(averesV,'r');
        plot(averesAV,'k');
        hold;
        legend('1/2(A+V)-V','V-V','A-V','AV-V');
        title({strcat('Average EEG over all participants for conditions: ',num2str(comcondlist)),strcat('at electrode: ', char(ElecNames(j)),', related to ',char(ElecIndicates(j)),' cortex' ) });
%       title({strcat('Conditioned Average EEG over all participants at electrode:', char(ElecIndicates(j))),strcat('for conditions: ',num2str(comcondlist)) });
        savefig(Hfig27,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig27'));
        saveas(Hfig27,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig27.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

      
        
        
       %%%%% Filtered graphs
       
%        niq=500; %niqist rate
%        fL=0.5/niq;
%        fH=4/niq;
%        
%        [b,a] = butter(3, [fL fH], 'bandpass');
%        favePureA=filtfilt(b,a,avePureA);
%        faveresA=filtfilt(b,a,averesA);
%        faveresV=filtfilt(b,a,averesV);
%        faveresAV=filtfilt(b,a,averesAV);
%        
%        Hfig2=figure;
%        plot(favePureA,'g');
%        hold;
%        plot(faveresA,'b');
%        plot(faveresV,'r');
%        plot(faveresAV,'k');
%        hold;
%        legend('Pure V','V-V','A-V','AV-V');
%        title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
%        savefig(Hfig2,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig22'));
%        saveas(Hfig2,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig22.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
%     
%        
%        fL=0.5/niq;
%        fH=8/niq;
%        
%        [b,a] = butter(3, [fL fH], 'bandpass');
%        favePureA=filtfilt(b,a,avePureA);
%        faveresA=filtfilt(b,a,averesA);
%        faveresV=filtfilt(b,a,averesV);
%        faveresAV=filtfilt(b,a,averesAV);
%        
%        Hfig3=figure;
%        plot(favePureA,'g');
%        hold;
%        plot(faveresA,'b');
%        plot(faveresV,'r');
%        plot(faveresAV,'k');
%        hold;
%        legend('Pure V','V-V','A-V','AV-V');
%        title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
%        savefig(Hfig3,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig23'));
%        saveas(Hfig3,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig23.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
    
       fL=0.5/niq;
       fH=12/niq;
       
       [b,a] = butter(3, [fL fH], 'bandpass');
       favePureA=filtfilt(b,a,avePureA);
       faveresA=filtfilt(b,a,averesA);
       faveresV=filtfilt(b,a,averesV);
       faveresAV=filtfilt(b,a,averesAV);
       
       Hfig4=figure;
       plot(favePureA,'g');
       hold;
       plot(faveresA,'b');
       plot(faveresV,'r');
       plot(faveresAV,'k');
       hold;
       legend('Pure V','V-V','A-V','AV-V');
       title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
       savefig(Hfig4,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig24'));
       saveas(Hfig4,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig24.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

       fL=0.5/niq;
       fH=30/niq;
       
       [b,a] = butter(3, [fL fH], 'bandpass');
       favePureA=filtfilt(b,a,avePureA);
       faveresA=filtfilt(b,a,averesA);
       faveresV=filtfilt(b,a,averesV);
       faveresAV=filtfilt(b,a,averesAV);
       
       Hfig5=figure;
       plot(favePureA,'g');
       hold;
       plot(faveresA,'b');
       plot(faveresV,'r');
       plot(faveresAV,'k');
       hold;
       legend('Pure V','V-V','A-V','AV-V');
       title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
       savefig(Hfig5,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig25'));
       saveas(Hfig5,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig25.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name         

   
   comcondlist=[3,11,12,10]; % 3=pureAV 11=AV->AV  12=A->AV  10=V->AV
  
       [resPureA,resA,resV,resAV,avePureA,averesA,averesV,averesAV] = PhysExtract(comcondlist,ERPavg,Electrodelist(j));
        Hfig=figure;
        plot(avePureA,'g');
        hold;
        plot(averesA,'b');
        plot(averesV,'r');
        plot(averesAV,'k');
        hold;
        legend('Pure AV','AV-AV','A-AV','V-AV');
        title({strcat('Average EEG over all participants for conditions: ',num2str(comcondlist)),strcat('at electrode: ', char(ElecNames(j)),', related to ',char(ElecIndicates(j)),' cortex' ) });
%       title({strcat('Conditioned Average EEG over all participants at electrode:', char(ElecIndicates(j))),strcat('for conditions: ',num2str(comcondlist)) });
        savefig(Hfig,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig3'));
        saveas(Hfig,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig3.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
        
        Hfig37=figure;
        plot(0.5*(averesV+averesAV),'g'); % because averesAV represents 'V-AV'
        hold;
        plot(averesA,'b');
        plot(averesV,'r');
        plot(averesAV,'k');
        hold;
        legend('1/2(A+V)-AV','AV-AV','A-AV','V-AV');
        title({strcat('Average EEG over all participants for conditions: ',num2str(comcondlist)),strcat('at electrode: ', char(ElecNames(j)),', related to ',char(ElecIndicates(j)),' cortex' ) });
%       title({strcat('Conditioned Average EEG over all participants at electrode:', char(ElecIndicates(j))),strcat('for conditions: ',num2str(comcondlist)) });
        savefig(Hfig37,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig37'));
        saveas(Hfig37,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig37.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

        
       %%%%% Filtered graphs
       
%        niq=500; %niqist rate
%        fL=0.5/niq;
%        fH=4/niq;
%        
%        [b,a] = butter(3, [fL fH], 'bandpass');
%        favePureA=filtfilt(b,a,avePureA);
%        faveresA=filtfilt(b,a,averesA);
%        faveresV=filtfilt(b,a,averesV);
%        faveresAV=filtfilt(b,a,averesAV);
%        
%        Hfig2=figure;
%        plot(favePureA,'g');
%        hold;
%        plot(faveresA,'b');
%        plot(faveresV,'r');
%        plot(faveresAV,'k');
%        hold;
%        legend('Pure AV','AV-AV','A-AV','V-AV');
%        title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
%        savefig(Hfig2,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig32'));
%        saveas(Hfig2,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig32.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
%     
%        
%        fL=0.5/niq;
%        fH=8/niq;
%        
%        [b,a] = butter(3, [fL fH], 'bandpass');
%        favePureA=filtfilt(b,a,avePureA);
%        faveresA=filtfilt(b,a,averesA);
%        faveresV=filtfilt(b,a,averesV);
%        faveresAV=filtfilt(b,a,averesAV);
%        
%        Hfig3=figure;
%        plot(favePureA,'g');
%        hold;
%        plot(faveresA,'b');
%        plot(faveresV,'r');
%        plot(faveresAV,'k');
%        hold;
%        legend('Pure AV','AV-AV','A-AV','V-AV');
%        title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
%        savefig(Hfig3,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig33'));
%        saveas(Hfig3,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig33.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
    
       fL=0.5/niq;
       fH=12/niq;
       
       [b,a] = butter(3, [fL fH], 'bandpass');
       favePureA=filtfilt(b,a,avePureA);
       faveresA=filtfilt(b,a,averesA);
       faveresV=filtfilt(b,a,averesV);
       faveresAV=filtfilt(b,a,averesAV);
       
       Hfig4=figure;
       plot(favePureA,'g');
       hold;
       plot(faveresA,'b');
       plot(faveresV,'r');
       plot(faveresAV,'k');
       hold;
       legend('Pure AV','AV-AV','A-AV','V-AV');
       title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
       savefig(Hfig4,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig34'));
       saveas(Hfig4,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig34.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

       fL=0.5/niq;
       fH=30/niq;
       
       [b,a] = butter(3, [fL fH], 'bandpass');
       favePureA=filtfilt(b,a,avePureA);
       faveresA=filtfilt(b,a,averesA);
       faveresV=filtfilt(b,a,averesV);
       faveresAV=filtfilt(b,a,averesAV);
       
       Hfig5=figure;
       plot(favePureA,'g');
       hold;
       plot(faveresA,'b');
       plot(faveresV,'r');
       plot(faveresAV,'k');
       hold;
       legend('Pure AV','AV-AV','A-AV','V-AV');
       title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
       savefig(Hfig5,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig35'));
       saveas(Hfig5,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig35.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name         

   
   
  %%%%
   
   comcondlist=[3,4,7,10] ;% 3=pureAV 4=V->A 7=V->V 10=V->AV 
   

       [resPureA,resA,resV,resAV,avePureA,averesA,averesV,averesAV] = PhysExtract(comcondlist,ERPavg,Electrodelist(j));
        Hfig=figure;
        plot(averesA+averesV,'g');
        hold;
        plot(averesA,'b');
        plot(averesV,'r');
        plot(averesAV,'k');
        
        hold;
        legend('V-(A+V)','V-A','V-V','V-AV');
        title({strcat('Average EEG over all participants for conditions: ',num2str(comcondlist)),strcat('at electrode: ', char(ElecNames(j)),', related to ',char(ElecIndicates(j)),' cortex' ) });
%       title({strcat('Conditioned Average EEG over all participants at electrode:', char(ElecIndicates(j))),strcat('for conditions: ',num2str(comcondlist)) });
        savefig(Hfig,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig4'));
        saveas(Hfig,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig4.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
            
       %%%%% Filtered graphs
       
           
       fL=0.5/niq;
       fH=12/niq;
       
       [b,a] = butter(3, [fL fH], 'bandpass');
       faveresA=filtfilt(b,a,averesA);
       faveresV=filtfilt(b,a,averesV);
       faveresAV=filtfilt(b,a,averesAV);
       
       Hfig4=figure;
       plot(faveresA+faveresV,'g');
       hold;
       plot(faveresA,'b');
       plot(faveresV,'r');
       plot(faveresAV,'k');
       hold;
       legend('V-(A+V)','V-A','V-V','V-AV');
       title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
       savefig(Hfig4,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig44'));
       saveas(Hfig4,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig44.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name

   
   comcondlist=[3,6,9,12] ;% 3=pureAV 6=A->A  9=A->V 12=A->AV
   
  
       [resPureA,resA,resV,resAV,avePureA,averesA,averesV,averesAV] = PhysExtract(comcondlist,ERPavg,Electrodelist(j));
       Hfig=figure;
       plot(averesA+averesV,'g');
       hold;
       plot(averesA,'b');
       plot(averesV,'r');
       plot(averesAV,'k');
     
       hold;
       legend('A-(A+V)','A-A','A-V','A-AV');
       title({strcat('Average EEG over all participants for conditions: ',num2str(comcondlist)),strcat('at electrode: ', char(ElecNames(j)),', related to ',char(ElecIndicates(j)),' cortex' ) });
%       title({strcat('Conditioned Average EEG over all participants at electrode:', char(ElecIndicates(j))),strcat('for conditions: ',num2str(comcondlist)) });
       savefig(Hfig,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig5'));
       saveas(Hfig,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig5.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
       %%%%% Filtered graphs
         
       fL=0.5/niq;
       fH=12/niq;
       
       [b,a] = butter(3, [fL fH], 'bandpass');
       faveresA=filtfilt(b,a,averesA);
       faveresV=filtfilt(b,a,averesV);
       faveresAV=filtfilt(b,a,averesAV);
       
       Hfig4=figure;
       plot(faveresA+faveresV,'g');
       hold;
       plot(faveresA,'b');
       plot(faveresV,'r');
       plot(faveresAV,'k');
       hold;
       legend('A-(A+V)','A-A','V-A','AV-A');
       title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
       savefig(Hfig4,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig54'));
       saveas(Hfig4,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig54.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name


   
   comcondlist=[3,5,8,11] ;% 3=pureAV 5=AV->A 8=AV->V  11=AV->AV
   
  
       [resPureA,resA,resV,resAV,avePureA,averesA,averesV,averesAV] = PhysExtract(comcondlist,ERPavg,Electrodelist(j));
        Hfig=figure;
        plot(averesA+averesV,'g');
        hold;
        plot(averesA,'b');
        plot(averesV,'r');
        plot(averesAV,'k');
        hold;
        legend('A-(A+V)','A-A','V-A','AV-A');
        title({strcat('Average EEG over all participants for conditions: ',num2str(comcondlist)),strcat('at electrode: ', char(ElecNames(j)),', related to ',char(ElecIndicates(j)),' cortex' ) });
%       title({strcat('Conditioned Average EEG over all participants at electrode:', char(ElecIndicates(j))),strcat('for conditions: ',num2str(comcondlist)) });
        savefig(Hfig,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig6'));
        saveas(Hfig,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig6.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
            
       %%%%% Filtered graphs
       
            
         
       fL=0.5/niq;
       fH=12/niq;
       
       [b,a] = butter(3, [fL fH], 'bandpass');
       faveresA=filtfilt(b,a,averesA);
       faveresV=filtfilt(b,a,averesV);
       faveresAV=filtfilt(b,a,averesAV);
       
       Hfig4=figure;
       plot(faveresA+faveresV,'g');
       hold;
       plot(faveresA,'b');
       plot(faveresV,'r');
       plot(faveresAV,'k');
       hold;
       legend('A-(A+V)','A-A','V-A','AV-A');
       title({strcat('Filtered Average EEG response at electrode: ',char(ElecNames(j)),', related to ', char(ElecIndicates(j)), ' cortex'), strcat('f_H of filter=',num2str(fH*niq),'and f_L of filter=',num2str(fL*niq),'Htz')});
       savefig(Hfig4,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig64'));
       saveas(Hfig4,strcat(Outdir,'\Average\','Elect',strjoin(ElecNames(j)),'Fig64.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name


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