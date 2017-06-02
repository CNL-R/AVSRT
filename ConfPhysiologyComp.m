% This script calculate the use PhysExtract to compare some important
% average Physiology

Electrodelist=[11 82 141 148 213];  % 11=A11 (Vis), 82=C18 (AudR), 141=E13 (M), 148=E20 (Logic), 213=G21 (AudL) 
ElecIndicates= {'Visual' 'R Audio' 'Motor' 'Perception' 'L Audio'};  
ElecNames={'A11','C18','E13','E20','G21'};

%%%%%%%%%%%%%%%%%%%%
for k=1:length(Electrodelist),
   comcondlist=[6,4,5]; % 6-A-A 4-V-A 5-AV-A
   for j=1:length(Electrodelist),
       [resA,resV,resAV,averesA,averesV,averesAV ] = PhysExtract(comcondlist,ERPavg,Electrodelist(j));
        figure;
        plot(averesA);
        hold;
        plot(averesV);
        plot(averesAV);
        hold;
        legend('A-A','V-A','AV','AV-A');
        title({strcat('Conditioned Average EEG over all participants at electrode:', ElecNames(j)),strcat('for conditions: ',num2str(comcondlist)) });
   
       for i =1:5:hsz(1,1), % draw one EEG signal for each individuals
            figure;
            plot(resA);
            hold;
            plot(resV);
            plot(resAV);
            hold;
            legend('A-A','V-A','AV','AV-A');
            title({strcat('Average Audio response comparision at electrode:', ElecNames(j)), strcat('for individial: ',id(i))});   
       end 
    end
   
   

   
   comcondlist=[7,9,8]; % 7-V-V  9=A->V  8=AV->V
   
   
   
   comcondlist=[11,12,10]; % 11=AV->AV  12=A->AV  10=V->AV
    
   
   
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