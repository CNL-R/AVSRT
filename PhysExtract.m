function [resA,resV,resAV,averesA,averesV,averesAV ] = PhysExtract(comcondlist,ERPavg,electrode)
%UNTITLED Summary of this function goes here
    hsz=size(ERPavg);
    averesAV=zeros(1,hsz(1,4));% hsz(1,4) is the duration of signal, 512
    averesA=zeros(1,hsz(1,4));
    averesV=zeros(1,hsz(1,4));
    
    resA=zeros(hsz(1,1),hsz(1,4));%
    resV=zeros(hsz(1,1),hsz(1,4));
    resAV=zeros(hsz(1,1),hsz(1,4)); 
    
    for i =1:hsz(1,1),       
        averesA=averesA+squeeze(ERPavg(i,comcondlist(1),electrode,:)).'*1/hsz(1,1);  % second index for condition
        averesV=averesV+squeeze(ERPavg(i,comcondlist(2),electrode,:)).'*1/hsz(1,1);
        averesAV=averesAV+squeeze(ERPavg(i,comcondlist(3),electrode,:)).'*1/hsz(1,1);
    end
    
    for i =1:hsz(1,1), % draw one EEG signal for all individuals

        resA(i,:)=squeeze(ERPavg(i,comcondlist(1),electrode,:)); %
        resV(i,:)=squeeze(ERPavg(i,comcondlist(2),electrode,:)); %
        resAV(i,:)=squeeze(ERPavg(i,comcondlist(3),electrode,:)); %
    end
    
    
end

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