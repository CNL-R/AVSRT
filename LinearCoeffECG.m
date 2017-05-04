% This script calculate the optimum coefficient for combining the A and V signal to minimize the mean squerre error from the AV response during the corraxis period 
% selection of corraxis is important and may use knowledge from biology
corraxis=100:200; % this is the interval the correlation of signals are calculated over each other to be used in solving alpha and beta equations
%assuming no delay on combining A and V
hsz=size(ERPavg);
alpha=zeros(1,hsz(1,1)); % coeeficient corresponding to V contribution, hsz(1,1) represent the number of individuals
beta=zeros(1,hsz(1,1));  % coeeficient corresponding to A contribution, hsz(1,1) represent the number of individuals

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



optcomb=zeros(hsz(1,1),hsz(1,4)); %store the optimum closest combination of A and V to AV for each individual based on correlation period corraxis
                                  % first index over individual and second
                                  % over time

for i =1:hsz(1,1), % draw one EEG signal for all individuals
    resA=zeros(i,512);
    resV=zeros(i,512);
    resAV=zeros(i,512);

    resA=squeeze(ERPavg(i,1,11,:)); %pureA
    resV=squeeze(ERPavg(i,2,11,:)); %pureV
    resAV=squeeze(ERPavg(i,3,11,:)); %pureAV
  
    CorrA_A=0;
    CorrV_V=0;
    CorrAV_AV=0;
    CorrA_V=0;
    CorrA_AV=0;
    CorrV_AV=0;
    
    CorrA_A=dot(resA(corraxis),resA(corraxis));
    CorrV_V=dot(resV(corraxis),resV(corraxis));
    CorrAV_AV=dot(resAV(corraxis),resAV(corraxis));
    CorrA_V=dot(resA(corraxis),resV(corraxis));
    CorrA_AV=dot(resA(corraxis),resAV(corraxis));
    CorrV_AV=dot(resV(corraxis),resAV(corraxis));
    
    SolV=[CorrV_V   CorrA_V; CorrA_V   CorrA_A]\  [CorrV_AV; CorrA_AV ]; % equivalent to inv([   ;   ])*[]
    alpha(i)=SolV(1);
    beta(i)=SolV(2);
    
    optcomb(i,:)=alpha(i)*resV+beta(i)*resA;
%     for j=corraxis, % calculate correlation the other method
%       CorrA_A=CorrA_A+resA(j)*resA(j);
%      end
end


for i =1:hsz(1,1), % draw one EEG signal for all individuals
  
    resA=zeros(i,512);
    resV=zeros(i,512);
    resAV=zeros(i,512);

    resA=squeeze(ERPavg(i,1,11,:)); %pureA
    resV=squeeze(ERPavg(i,2,11,:)); %pureV
    resAV=squeeze(ERPavg(i,3,11,:)); %pureAV
    resAplusV=resA+resV;
    resoptcomb=optcomb(i,:).'; % transpose vector to agree with others
    
    
    
    figure;
    plot(resA);
    hold;
    plot(resV);
    plot(resAV);
    plot(resAplusV);
    plot(resoptcomb);
    hold;
    legend('A','V','AV','A+V','\alpha V+\beta A');
    title({'Average EEG signal of pure trials at H28',  strcat('for individial: ',num2str(indvd(i))),  strcat('\alpha=',num2str(alpha(i)),', \beta=',num2str(beta(i))) });
 
    figure;
    plot(resAV-resAplusV);
    hold;
    plot(resAV-resoptcomb);
    hold;
    legend('AV-(A+V)','AV-(\alpha V+\beta A)');
    title({'Average Error of AV EEG from predicted signals at H28 in pure blocks',  strcat('for individial: ',num2str(indvd(i))),  strcat('\alpha=',num2str(alpha(i)),', \beta=',num2str(beta(i))) }); 
   
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