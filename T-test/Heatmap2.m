% Developed by Arian Shoari. Copyright 2017 John Foxe's Lab, University of Rochester. 
% Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
% http://www.apache.org/licenses/LICENSE-2.0
% Unless agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
% https://www.apache.org/licenses/LICENSE-2.0

sampleperiod=0.001; %
adjsigframe=5; 
filtth=0.5; %; real number between 0 and 1 
alphath=0.05;
timecolumn=4;
electrodecolumn=5;
reducedresolution=10;

contrastname={'switch-repeat','incongruent-congruent','respswitch-resprepeat'};

Ytick=[32 64 96 128 160 192 224];
Yticklabel ={'D32','C32','E32','G32','B32','F32','A32'};
XtickVec = [0 100 200 300  400 500 600 700 800 900 1000];
Xticklabel = [0 100 200 300  400 500 600 700 800 900 1000];

ElecTimeCut=incon_cong;
meassize=size(ElecTimeCut);
Xtick=XtickVec;
[Tmat1,Sigmat1,FiltSigmat1] = Ttest1Heatmap(sampleperiod,adjsigframe,filtth,alphath,timecolumn,electrodecolumn,Xtick,Xticklabel,Ytick,Yticklabel,'incongruent-congruent','time','electrode',ElecTimeCut);


timebinmax=floor(meassize(1,timecolumn)/reducedresolution);
ElecTimeReduced=zeros(meassize(1,1),meassize(1,2),meassize(1,3),timebinmax,meassize(1,5));
for i=1:meassize(1,1),
    for j=1:meassize(1,2),
        for k=1:meassize(1,3),
          for l=1:meassize(1,5),
                for tind=1:timebinmax,
                    ElecTimeReduced(i,j,k,tind,l)=mean(ElecTimeCut(i,j,k,reducedresolution*(tind-1)+1:(tind*reducedresolution),l));
                end
          end
        end  
    end
end
Xtick=floor((1/reducedresolution)*XtickVec);
[Tmat2,Sigmat2,FiltSigmat2] = Ttest1Heatmap(sampleperiod*reducedresolution,adjsigframe,filtth,alphath,timecolumn,electrodecolumn,Xtick,Xticklabel,Ytick,Yticklabel,'filtered incongruent-congruent','time (ms)','electrode',ElecTimeReduced );
% addTitle(hmo, 'filtered incongruent-congruent')



%%%%%%%%%%%%%%%%%%%%%%%%%
ElecTimeCut=respsw_respre; 
Xtick=XtickVec;
[Tmat3,Sigmat3,FiltSigmat3] = Ttest1Heatmap(sampleperiod,adjsigframe,filtth,alphath,timecolumn,electrodecolumn,Xtick,Xticklabel,Ytick,Yticklabel,'respswitch-resprepeat','time','electrode',ElecTimeCut );

ElecTimeReduced=zeros(meassize(1,1),meassize(1,2),meassize(1,3),timebinmax,meassize(1,5));
for i=1:meassize(1,1),
    for j=1:meassize(1,2),
        for k=1:meassize(1,3),
          for l=1:meassize(1,5),
                for tind=1:timebinmax,
                    ElecTimeReduced(i,j,k,tind,l)=mean(ElecTimeCut(i,j,k,reducedresolution*(tind-1)+1:(tind*reducedresolution),l));
                end
          end
        end  
    end
end
Xtick=floor((1/reducedresolution)*XtickVec);
[Tmat4,Sigmat4,FiltSigmat4] = Ttest1Heatmap(sampleperiod*reducedresolution,adjsigframe,filtth,alphath,timecolumn,electrodecolumn,Xtick,Xticklabel,Ytick,Yticklabel,'filtered respswitch-resprepeat','time','electrode',ElecTimeReduced );

%%%%%%%%%%%%%%%%%%%%%%%%%
ElecTimeCut=sw_rep; 
Xtick=XtickVec;
[Tmat5,Sigmat5,FiltSigmat5] = Ttest1Heatmap(sampleperiod,adjsigframe,filtth,alphath,timecolumn,electrodecolumn,Xtick,Xticklabel,Ytick,Yticklabel,'switch-repeat','time','electrode',ElecTimeCut );

ElecTimeReduced=zeros(meassize(1,1),meassize(1,2),meassize(1,3),timebinmax,meassize(1,5));
for i=1:meassize(1,1),
    for j=1:meassize(1,2),
        for k=1:meassize(1,3),
          for l=1:meassize(1,5),
                for tind=1:timebinmax,
                    ElecTimeReduced(i,j,k,tind,l)=mean(ElecTimeCut(i,j,k,reducedresolution*(tind-1)+1:(tind*reducedresolution),l));
                end
          end
        end  
    end
end
Xtick=floor((1/reducedresolution)*XtickVec);
[Tmat6,Sigmat6,FiltSigmat6] = Ttest1Heatmap(sampleperiod*reducedresolution,adjsigframe,filtth,alphath,timecolumn,electrodecolumn,Xtick,Xticklabel,Ytick,Yticklabel,'filtered switch-repeat','time','electrode',ElecTimeReduced);
