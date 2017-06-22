function [ p1,tb1 ] = Anova1Conditioned(conditioncolumn,sessioncolumn,subjectcolumn,alphath,time,electrod,expdata1)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

ElecTimeCut=expdata1(:,:,:,time,electrod); 
meassize=size(ElecTimeCut);

y=[];
f1=[];
f2=[];
f3=[];
f23=[];

for i=1:meassize(1,conditioncolumn), % condition
    for j=1:meassize(1,sessioncolumn), % session number
        for k=1:meassize(1,subjectcolumn), % subject number
            f1=[f1 i]; %  represents conditions
            f2=[f2 j]; % represents sessions
            f3=[f3 k]; % represents the subjects
            f23=[f23 j*10+k];% to treat each session of a subject as a seperate independent group
            y =[y ElecTimeCut(i,j,k)];
        end
    end
end

[p1,tb1]  = anovan(y,{f1},'display','off');


%%
end

