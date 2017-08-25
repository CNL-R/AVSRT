% Developed by Arian Shoari. Copyright 2017 John Foxe's Lab, University of Rochester. 
% Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
% http://www.apache.org/licenses/LICENSE-2.0
% Unless agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
% https://www.apache.org/licenses/LICENSE-2.0

% This illustrate all individual SW vs NonSW significant analysis in one
% graph for Visual Response
% This piece of program shall be run after NM2AllConditions.m and
% AnovaTestSWNotSWIndividualPaper.m
% multcompareV4.bak should be converted to .m and copied to the exact directory as original
% Matlab multcompare.m is located.
% In addition AnovaIndAnalysisVecOut.m will be called by
% AnovaTestSWNotSWIndividualPaper to generate the results

randorder = [1:40]; % randorder = randperm(length(id)); % create a permutaed order for display of participants over the graph so that they can never be tracked from the graph

figure;
hold on;
for i=1:length(id), 
% goes over participants and draw the confidence interval
    yc=[randorder(i) randorder(i)]; % this is the scrambled order of showing participants but fixed during each run time
    if  (meansindvII{i}(1,1)<meansindvII{i}(2,1)),
      if (meansindvII{i}(1,1)+halfwidthindvII{i}(1,1))<(meansindvII{i}(2,1)-halfwidthindvII{i}(2,1)),
          NotSW_interval=[meansindvII{i}(1,1)-halfwidthindvII{i}(1,1),meansindvII{i}(1,1)+halfwidthindvII{i}(1,1)];
          SW_interval=[meansindvII{i}(2,1)-halfwidthindvII{i}(2,1),meansindvII{i}(2,1)+halfwidthindvII{i}(2,1)];
          plot(SW_interval,yc,'r-','LineWidth',3);
          plot(NotSW_interval,yc,'b-','LineWidth',3);
      else 
          NotSW_interval=[meansindvII{i}(1,1)-halfwidthindvII{i}(1,1),meansindvII{i}(2,1)-halfwidthindvII{i}(2,1)];
          SW_interval=[meansindvII{i}(1,1)+halfwidthindvII{i}(1,1),meansindvII{i}(2,1)+halfwidthindvII{i}(2,1)];
          OverlapSW_NotSW=[meansindvII{i}(2,1)-halfwidthindvII{i}(2,1),meansindvII{i}(1,1)+halfwidthindvII{i}(1,1)];
          plot(SW_interval,yc,'r-','LineWidth',3);
          plot(NotSW_interval,yc,'b-','LineWidth',3);
          plot(OverlapSW_NotSW,yc,'g:','LineWidth',3);     
      end    
    else    
      if (meansindvII{i}(2,1)+halfwidthindvII{i}(2,1))<(meansindvII{i}(1,1)-halfwidthindvII{i}(1,1)),
          SW_interval=[meansindvII{i}(2,1)-halfwidthindvII{i}(2,1),meansindvII{i}(2,1)+halfwidthindvII{i}(2,1)];
          NotSW_interval=[meansindvII{i}(1,1)-halfwidthindvII{i}(1,1),meansindvII{i}(1,1)+halfwidthindvII{i}(1,1)];
          plot(SW_interval,yc,'r-','LineWidth',3);
          plot(NotSW_interval,yc,'b-','LineWidth',3);
      else 
          SW_interval=[meansindvII{i}(2,1)-halfwidthindvII{i}(2,1),meansindvII{i}(1,1)-halfwidthindvII{i}(1,1)];
          NotSW_interval=[meansindvII{i}(2,1)+halfwidthindvII{i}(2,1),meansindvII{i}(1,1)+halfwidthindvII{i}(1,1)];
          OverlapSW_NotSW=[meansindvII{i}(1,1)-halfwidthindvII{i}(1,1),meansindvII{i}(2,1)+halfwidthindvII{i}(2,1)];
          plot(SW_interval,yc,'r-','LineWidth',3);
          plot(NotSW_interval,yc,'b-','LineWidth',3);
          plot(OverlapSW_NotSW,yc,'g:','LineWidth',3);     
      end 
    end  
end
ylabel('Participants No.')
xlabel('Individual Participants Response Time Confidence Interval, V-V vs A-V')
hold off;