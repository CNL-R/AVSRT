sampleperiod=0.001; %
adjsigframe=5; 
filtth=0.5; %; real number between 0 and 1 
alphath=0.05;
timecolumn=4;
electrodecolumn=5;
reducedresolution=10;

contrastname={'switch-repeat','incongruent-congruent','respswitch-resprepeat'};

meassize=size(ElecTimeCut);
ElecTimeCut=incon_cong;
[Pmat1,Sigmat1,FiltSigmat1] = Anova1Heatmap(sampleperiod,adjsigframe,filtth,alphath,timecolumn,electrodecolumn,'incongruent-congruent','time','electrode',ElecTimeCut );


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
[Pmat2,Sigmat2,FiltSigmat2] = Anova1Heatmap(sampleperiod*reducedresolution,adjsigframe,filtth,alphath,timecolumn,electrodecolumn,'filtered incongruent-congruent','time','electrode',ElecTimeReduced );
% addTitle(hmo, 'filtered incongruent-congruent')



%%%%%%%%%%%%%%%%%%%%%%%%%
ElecTimeCut=respsw_respre; 
[Pmat3,Sigmat3,FiltSigmat3] = Anova1Heatmap(sampleperiod,adjsigframe,filtth,alphath,timecolumn,electrodecolumn,'respswitch-resprepeat','time','electrode',ElecTimeCut );

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
[Pmat4,Sigmat4,FiltSigmat4] = Anova1Heatmap(sampleperiod*reducedresolution,adjsigframe,filtth,alphath,timecolumn,electrodecolumn,'filtered respswitch-resprepeat','time','electrode',ElecTimeReduced );

%%%%%%%%%%%%%%%%%%%%%%%%%
ElecTimeCut=sw_rep; 
[Pmat5,Sigmat5,FiltSigmat5] = Anova1Heatmap(sampleperiod,adjsigframe,filtth,alphath,timecolumn,electrodecolumn,'switch-repeat','time','electrode',ElecTimeCut );

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
[Pmat6,Sigmat6,FiltSigmat6] = Anova1Heatmap(sampleperiod*reducedresolution,adjsigframe,filtth,alphath,timecolumn,electrodecolumn,'filtered switch-repeat','time','electrode',ElecTimeReduced);
