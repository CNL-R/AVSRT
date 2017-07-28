% Developed by Arian Shoari. Copyright 2017 John Foxe's Lab, University of Rochester. 
% Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
% http://www.apache.org/licenses/LICENSE-2.0
% Unless agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
% https://www.apache.org/licenses/LICENSE-2.0
% This code do one sided significant test for conditioned Response Times
% between selected conditions

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
alphath=0.05;
ncond=13;
cumulativecondcell=cell(ncond,1);% conditioned individual cell
excludeindvds=[]; % this is the id index of individuals which should be excluded from analysis due to unreliable or impossible results or wrong measurements

Outdir = uigetdir('D:\Arian\Projects\SMART\Outputs\mintAtBHypoth\Average\','Select Output Directory for the Graphs!'); 
hmat=zeros(ncond,ncond);
pmat=zeros(ncond,ncond);
tmat=zeros(ncond,ncond);

hbothmat=zeros(ncond,ncond);

for j=1:size(id,2), % the index of individual in the indcell
  if any(excludeindvds==j) , % this means j is an excluded individual also may be implemented by  sum(ismember(excludeindvds,j))>0
  else
    for cond=1:ncond,
        condindx=find(indcell{j}(:,1)==cond);
        cumulativecondcell{cond}=[cumulativecondcell{cond}; indcell{j}(condindx,2)];
    end
  end
end % for 1:size(id,2)..    
    
for l=1:ncond,
    for k=1:ncond,
        comparecondlist=[l,k];
%         cond1=comparecondlist(1);
%         cond2=comparecondlist(2);
        sortcellcond1=sort(cumulativecondcell{l}); % sort conditioned cell
        sortcellcond2=sort(cumulativecondcell{k}); % sort conditioned cell

        [h,p,ci,stats] = ttest2(sortcellcond1,sortcellcond2,'Tail','left','Vartype','unequal','Alpha',alphath);  % 'unequal' with the assumption that not from same 
        hmat(l,k)=h;
        pmat(l,k)=p;
        tmat(l,k)=stats.tstat;
        
        
       [h,p,ci,stats] = ttest2(sortcellcond1,sortcellcond2,'Tail','both','Vartype','unequal','Alpha',alphath);  % 'unequal' with the assumption that not from same 
        
        hbothmat(l,k)=h;
        
        
    end
end    

savefile=strcat(Outdir,'\','CondTtestAve.mat')
save(savefile,'hmat','pmat','tmat','hbothmat');

dlmwrite('D:\Arian\Projects\SMART\Outputs\mintAtBHypoth\Average\DoubleSequenceOneSidedTtest\onesidedtest.txt',hmat(2:13,2:13));
dlmwrite('D:\Arian\Projects\SMART\Outputs\mintAtBHypoth\Average\DoubleSequenceOneSidedTtest\bothsidedtest.txt',hbothmat(2:13,2:13));

hmat
hbothmat