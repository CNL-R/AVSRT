alpha=0.05;
electrod=124;
time=200;
numcontrast=3;

includeanova=[1 1 1];
contrastname={'switch-repeat','incongruent-congruent','respswitch-resprepeat'};
contrast=1:3;
ElecTimeCut=cell(1,numcontrast);

ElecTimeCut{1}=incon_cong(:,:,:,time,electrod); % 224 is the electrode
ElecTimeCut{2}=respsw_respre(:,:,:,time,electrod); % 224 is the electrode
ElecTimeCut{3}=sw_rep(:,:,:,time,electrod); % 224 is the electrode

meassize=cell(1,numcontrast);
for ih=1:numcontrast, 
  meassize{ih}=size(ElecTimeCut{ih});
end  

%%
y=[];
f0=[];
f1=[];
f2=[];
f3=[];
f23=[];
f13=[];
f10=[];

inci=contrast(contrast.*includeanova>0);


for ih=inci, 
    h=meassize{ih};
    for i=1:h(1,1), % condition
        for j=1:h(1,2), % session number
            for k=1:h(1,3), % subject number
              f0=[f0 ih]; %  represents contrast
              f1=[f1 i]; %  represents conditions
              f2=[f2 j]; % represents sessions
              f3=[f3 k]; % represents the subjects  
              f23=[f23 j*10+k];% to treat each session of a subject as a seperate independent group
              f10=[f10 ih*10+i];
              y =[y ElecTimeCut{ih}(i,j,k)];
            end
        end
    end
end

[p1,tb1]  = anovan(y,{f1});

[p2,tb2]  = anovan(y,{f2}); % along with sessions considering averaging over both subjects and considitions

[p23,tb23]  = anovan(y,{f23}); % along with subject-sessions averaging over considitions

[p10,tb10]  = anovan(y,{f1 f0},'model','interaction','varnames',{'f1','f0'});

% [p5,tb5]  = anovan(y,{f1,f23});
% [p6,tb6]  = anovan(y,{f1 f23},'model','interaction','varnames',{'f1','f23'});
% 

[p7,tb7]  = anovan(y,{f1,f3});
[p8,tb8]  = anovan(y,{f1 f3},'alpha',a,'model','interaction','varnames',{'f1','f3'}); % interaction between condition and subject

[p9,tb9]  = anovan(y,{f1 f23},'model','interaction','varnames',{'f1','f23'}); % interaction between condition and subject


[Pmat,Sigmat,FiltSigmat] = Anova1Heatmap(0.01,6,0.5,0.05,4,5,incon_cong )

%scatter3()
%%%%%%% sessions as new subjects

% y=[];
% g1=[];
% g23=[];
% for i=1:h(1,1),
%     for j=1:h(1,2),
%         for k=1:h(1,3),
%           g1=[g1 i];
%      %         g23={g23; strcat(num2str(j),'-',num2str(k))};% that dash needed to difrentiate for examlple 1-23 from 12-3 if j and k values have potentially more than 10 elements
%           y =[y ElecTimeCut(i,j,k)];
%         end
%     end
% end

