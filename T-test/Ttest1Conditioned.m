% Developed by Arian Shoari. Copyright 2017 John Foxe's Lab, University of Rochester. 
% Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
% http://www.apache.org/licenses/LICENSE-2.0
% Unless agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
% https://www.apache.org/licenses/LICENSE-2.0

function [ h,p,ci,stats ] = Ttest1Conditioned(conditioncolumn,sessioncolumn,subjectcolumn,alphath,time,electrod,expdata1)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

ElecTimeCut=expdata1(:,:,:,time,electrod); 
meassize=size(ElecTimeCut);


f1=[];
f2=[];
f3=[];
f23=[];
y=cell(1,meassize(1,conditioncolumn)); % equal to condition 1

for i=1:meassize(1,conditioncolumn), % condition
    for j=1:meassize(1,sessioncolumn), % session number
        for k=1:meassize(1,subjectcolumn), % subject number
%             f1=[f1 i]; %  represents conditions
%             f2=[f2 j]; % represents sessions
%             f3=[f3 k]; % represents the subjects
%             f23=[f23 j*10+k];% to treat each session of a subject as a seperate independent group
              y{i} =[y{i} ElecTimeCut(i,j,k)];
        end
    end
end

[h,p,ci,stats] = ttest2(y{1},y{2},'Vartype','unequal','Alpha',alphath);  % 'unequal' with the assumption that not from same 

%%
end

