% This script calculate the optimum coefficient and time delay for combining the A and V signal to minimize the mean squerre error from the AV response during the corrperiod period 
% selection of corrperiod is important and may use knowledge from biology
% the program will scan over DelayA and DelayV and calculate optimum alpha
% and beta for each delay selection and pick the one which generate least
% Mean Squerred Error
% negative values for alpha and beta are excluded from optimization problem
% by assigning a very large cost
%close all; %close all previously visible figures
DelayGridA=0:1; % this is the number of sample delays that should be applied to Audio signal in the forward or backward direction before combining to Video signal
DelayGridV=0:1; % this is the number of sample delays that should be applied to Video signal in the forward or backward direction before combining to Audio signal
% DelayGrid should be such that adding them to corrperiod will not go over the time index of ERPavg
MaxDelayA=DelayGridA(length(DelayGridA));
MinDelayA=DelayGridA(1);
MaxDelayV=DelayGridV(length(DelayGridV));
MinDelayV=DelayGridV(1);
corrperiod=261:300; % this is the interval the correlation of signals are calculated over each other to be used in solving alpha and beta equations
%assuming no delay on combining A and V
hsz=size(ERPavg);
alpha=zeros(hsz(1,1),length(DelayGridA),length(DelayGridV)); % coeeficient corresponding to V contribution, hsz(1,1) represent the number of individuals
beta=zeros(hsz(1,1),length(DelayGridA),length(DelayGridV));  % coeeficient corresponding to A contribution, hsz(1,1) represent the number of individuals
comcondlist=[4 7 10];
indvd=zeros(1,16); % stores individual id numbers
indvd(1)=11801451;
indvd(2)=18959514;
indvd(3)=19567871;
indvd(4)=21606322;
indvd(5)=29751333;
indvd(6)=30788148;
indvd(7)=49896189;
indvd(8)=53491450;
indvd(9)=54891622;
indvd(10)=60963502;
indvd(11)=66696340;
indvd(12)=70129938;
indvd(13)=72110293;
indvd(14)=80108147;
indvd(15)=84666944;
indvd(16)=89511282;

resA=zeros(1,512);
resV=zeros(1,512);
resAV=zeros(1,512);

% % This part is for testing, should be disabled to avoid over riding 1st individual data 
% %%%%*****************************
% testt=1:512;
% testA=sin(testt*(2*pi)/512);
% testV=cos((testt-65)*5*pi/512);
% testAV=1.30*testA+0.8*testV;
% 
% figure;
% plot(testA);
% hold;
% plot(testV);
% plot(testAV);
% legend('A','V','AV');
% hold;
% 
% ERPavg(1,1,11,:)=testA;
% ERPavg(1,2,11,:)=testV;
% ERPavg(1,3,11,:)=testAV;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% end of testing

optcomb=zeros(hsz(1,1),hsz(1,4)); % store the optimum closest combination of A and V to AV for each individual based on correlation period corrperiod
                                  % first index over individual and second
                                  % over time
optalpha=zeros(1,hsz(1,1)); % store the optimum alpha for individual 
optbeta=zeros(1,hsz(1,1)); % store the optimum beta for individual 
optDelayA=zeros(1,hsz(1,1)); % store optimum Audio delay for individual
optDelayV=zeros(1,hsz(1,1)); % store optimum Video delay for individual
MSE=zeros(hsz(1,1),length(DelayGridA),length(DelayGridV));   % store the mean squerre error resulting from optimum alpha and beta selection for each delay per individual                                

resA=zeros(i,512);
resV=zeros(i,512);
resAV=zeros(i,512);
optDelayInd=zeros(hsz(1,1),2); % stores the index of optimum delay in audio and video which minimize the error 

for i =1:hsz(1,1), % draw one EEG signal for all individuals

    
    resA=squeeze(ERPavg(i,comcondlist(1),11,:)); %pureA
    resV=squeeze(ERPavg(i,comcondlist(2),11,:)); %pureV
    resAV=squeeze(ERPavg(i,comcondlist(3),11,:)); %pureAV
    
    for j=1:length(DelayGridA),
        for k=1:length(DelayGridV),
 
            DelayA=DelayGridA(j); % this is the selected audio delay from the grid
            DelayV=DelayGridV(k); % this is the selected video delay from the grid
            CorrA_A=0;
            CorrV_V=0;
            CorrAV_AV=0;
            CorrA_V=0;
            CorrA_AV=0;
            CorrV_AV=0;
            temperr=zeros(1,512);

            CorrA_A=dot(resA(corrperiod-DelayA),resA(corrperiod-DelayA));
            CorrV_V=dot(resV(corrperiod-DelayV),resV(corrperiod-DelayV));
            CorrAV_AV=dot(resAV(corrperiod),resAV(corrperiod)); % AV is the reference for delay
            CorrA_V=dot(resA(corrperiod-DelayA),resV(corrperiod-DelayV));
            CorrA_AV=dot(resA(corrperiod-DelayA),resAV(corrperiod));
            CorrV_AV=dot(resV(corrperiod-DelayV),resAV(corrperiod));

            SolV=[CorrV_V   CorrA_V; CorrA_V   CorrA_A]\  [CorrV_AV; CorrA_AV ]; % equivalent to inv([   ;   ])*[]
            tempalpha=SolV(1);
            tempbeta=SolV(2);  
            temperr(corrperiod)=resAV(corrperiod)-(tempalpha*resV(corrperiod-DelayV)+tempbeta*resA(corrperiod-DelayA));
            alpha(i,j,k)=SolV(1);
            beta(i,j,k)=SolV(2);   
            
            if (alpha(i,j,k)<-0.05) | (beta(i,j,k)<-0.05), % consider negative very close to zero as zero
                MSE(i,j,k)=100000; % punishment value to exclude negative alpha or beta from minimization evaluation
            else
                MSE(i,j,k)=sum(temperr(corrperiod).^2)/length(corrperiod); % it only consider the error over correlation period
            end

        end
    end  
    
   
    [minVal_eachcol,minIndex_overrow] = min(MSE(i,:,:));  % return the minum index along the delayed line
    [minVal_All,minIndex_overcol]=min(minVal_eachcol);
    
    optDelayInd(i,2)= minIndex_overcol; %index correspond to minimum DelayV
    optDelayInd(i,1)=minIndex_overrow(minIndex_overcol); %index correspond to DelayA
    
    optalpha(1,i)=alpha(i,optDelayInd(i,1),optDelayInd(i,2)); % store the optimum alpha for individual 
    optbeta(1,i)=beta(i,optDelayInd(i,1),optDelayInd(i,2)); % store the optimum beta for individual 
    optDelayA(1,i)=DelayGridA(optDelayInd(i,1)); % store optimum Audio delay for individual
    optDelayV(1,i)=DelayGridV(optDelayInd(i,2)); % store optimum Video delay for individual
    
    optcomb(i,corrperiod)=optalpha(1,i)*resV(corrperiod-optDelayV(1,i))+optbeta(1,i)*resA(corrperiod-optDelayA(1,i));
    %Only draw optcomb in the correlation period so as not to go out of
    %idex
    
    %     for j=corrperiod, % calculate correlation the other method
%       CorrA_A=CorrA_A+resA(j)*resA(j);
%      end
end

aveoptcomb=zeros(1,hsz(1,4));
averesAV=zeros(1,hsz(1,4));
averesA=zeros(1,hsz(1,4));
averesV=zeros(1,hsz(1,4));
aveoptalpha=0;
aveoptbeta=0;
aveoptDelayA=0;
aveoptDelayV=0;

for i =1:hsz(1,1),
    aveoptcomb=aveoptcomb+optcomb(i,:)/hsz(1,1);
    averesA=averesA+squeeze(ERPavg(i,comcondlist(1),11,:)).'*1/hsz(1,1);  % second index for condition
    averesV=averesV+squeeze(ERPavg(i,comcondlist(2),11,:)).'*1/hsz(1,1);
    averesAV=averesAV+squeeze(ERPavg(i,comcondlist(3),11,:)).'*1/hsz(1,1);  
 
    aveoptalpha=aveoptalpha+optalpha(1,i).'*1/hsz(1,1);  
    aveoptbeta=aveoptbeta+optbeta(1,i).'*1/hsz(1,1);  
    aveoptDelayA=aveoptDelayA+optDelayA(1,i)*1/hsz(1,1);
    aveoptDelayV=aveoptDelayV+optDelayV(1,i)*1/hsz(1,1);
end
averesAplusV=averesA+averesV;

figure;
plot(averesA);
hold;
plot(averesV);
plot(averesAV);
plot(averesAplusV);
plot(aveoptcomb);
hold;
legend('A','V','AV','A+V','\alpha V+\beta A');
title({'Total Conditioned Average EEG signal of pure trials at H28 for conditions: ',num2str(comcondlist) });

figure;
plot(averesAV-averesAplusV);
hold;
plot(averesAV-aveoptcomb);
hold;
legend('AV-(A+V)','AV-(\alpha V+\beta A)');
title({'Average Error of AV EEG from predicted signals at H28 in pure blocks from all individuals', strcat('average \alpha=',num2str(aveoptalpha),', average \beta=',num2str(aveoptbeta),',average OptDelayA=',num2str(aveoptDelayA), ',average OptDelayV=',num2str(aveoptDelayV)   ) }); 



% figure;
% plot(optalpha);
% hold;
% plot(optbeta);
% hold;
% legend('Optimum \alpha','Optimum \beta)');
% title('the optimum \alpha and \beta trends versus individual');


% for i =1:(hsz(1,1)-15), % draw one EEG signal for each individuals
%   
%     resA=zeros(i,512);
%     resV=zeros(i,512);
%     resAV=zeros(i,512);
% 
%     resA=squeeze(ERPavg(i,comcondlist(1),11,:)); %pureA
%     resV=squeeze(ERPavg(i,comcondlist(2),11,:)); %pureV
%     resAV=squeeze(ERPavg(i,comcondlist(3),11,:)); %pureAV
%     resAplusV=resA+resV;
%     resoptcomb=optcomb(i,:).'; % transpose vector to agree with others      
%     
%     figure;
%     plot(resA);
%     hold;
%     plot(resV);
%     plot(resAV);
%     plot(resAplusV);
%     plot(resoptcomb);
%     hold;
%     legend('A','V','AV','A+V','\alpha V+\beta A');
%     title({'Average EEG signal of pure trials at H28',  strcat('for individial: ',num2str(indvd(i))),  strcat('\alpha=',num2str(alpha(i)), ', \beta=',num2str(beta(i)),',OptDelayA=',num2str(optDelayA(1,i)), ',OptDelayV=',num2str(optDelayV(1,i)) )});
%  
%     figure;
%     plot(resAV-resAplusV);
%     hold;
%     plot(resAV-resoptcomb);
%     hold;
%     legend('AV-(A+V)','AV-(\alpha V+\beta A)');
%     title({'Average Error of AV EEG from predicted signals at H28 in pure blocks',  strcat('for individial: ',num2str(indvd(i))),  strcat('\alpha=',num2str(alpha(i)),', \beta=',num2str(beta(i)),',OptDelayA=',num2str(optDelayA(1,i)), ',OptDelayV=',num2str(optDelayV(1,i))   ) }); 
%    
% end 

%Averaging calculation for preset conditions





    
    
    
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