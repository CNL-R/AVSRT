% #### Average Triple Sequence Over ALL Participants ###
% this module should be run after SMARTeCDFs.m to have all the data related
% to any individual preloaded to Matlab.
% First we make a long conditional cell includes trials of all individual
% except some identified in "excludeindvds", then do the same analysis put
% forward in TimeAnalysis for each individual


ncond=13;
CDFsteps=0.1;
seqcondcell=cell(ncond,ncond);% conditioned individual cell
excludeindvds=[]; % this is the id index of individuals which should be excluded from analysis due to unreliable or impossible results or wrong measurements

%Outdir = uigetdir('D:\Arian\Projects\SMART\Outputs\mintAtBHypoth\Average\','Select Output Directory for the Graphs!'); 

% extracte individual and cumulative response times based on current and
% previous conditions
indseqcondcell=cell(size(id,2),ncond,ncond);
seqcondcell=cell(ncond,ncond);

for j=1:size(id,2), % the index of individual in the indcell
     if any(excludeindvds==j) , % this means j is an excluded individual also may be implemented by  sum(ismember(excludeindvds,j))>0
     else
        for k=2:length(indcell{j}(:,1)), % scan a specific result and organise it in the possible consequitive states
            cond=indcell{j}(k,1);
            preccond=indcell{j}(k-1,1);
            indseqcondcell{j,preccond,cond}=[indseqcondcell{j,preccond,cond}; indcell{j}(k,2)];
            seqcondcell{preccond,cond}=[seqcondcell{preccond,cond}; indcell{j}(k,2)];
        end 
     end  
end 


%%%%%%%%%%%%%%%    Not corrected yet      %%%%%%%%%%%%%%%%%
%%%%%%%Fig 1%%%%%%%%%%%%%
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
%@@@@@@@@@@@@@@@@@@@@@@@ Triple Condition Selection  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
combcondA=[5,7];% V-A-A
combcondB=[6,7];% AV-A-A
condAPrec=combcondA(1);
condACurr=combcondA(2);
condBPrec=combcondB(1);
condBCurr=combcondB(2);
mixedcell1=[seqcondcell{condBPrec,condBCurr};seqcondcell{condAPrec,condACurr}];

sortedmixedcell=sort(mixedcell1); % sort conditioned cell
meanA=mean(sortedmixedcell);
  if mod(length(sortedmixedcell),2)==0;
     medA=0.5*(sortedmixedcell(length(sortedmixedcell)/2)+sortedmixedcell(length(sortedmixedcell)/2+1));
  else
      medA=sortedmixedcell((length(sortedmixedcell)+1)/2);
  end    
  stdA=std(sortedmixedcell);
