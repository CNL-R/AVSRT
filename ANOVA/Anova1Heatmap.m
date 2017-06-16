function [ Pmat,Sigmat, FiltSigmat ] = Anova1Heatmap(sampleperiod,adjsigframe,filtth,alphath,timecolumn,electrodecolumn,Title,XLabel,YLabel,expdata1 )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% adjsigframe specify the number of adjacent significant violation time frame that requires to consider a violation in time a valid violation   
% Pmat is the matrix of p values over time and electrode
% Sigmat shows the significant of p values upon the alphath
% FiltSigmat is the filtered Sigmat considering adjsigframe criteria in the time domain  

tic;

expsize=size(expdata1);
tindexmax=expsize(1,timecolumn);
electmax=expsize(1,electrodecolumn);

conditioncolumn=1;
sessioncolumn=2;
subjectcolumn=3; 

Pmat=zeros(tindexmax,electmax);
Sigmat=zeros(tindexmax,electmax);
FiltSigmat =zeros(tindexmax,electmax);




for i=1:1:tindexmax,
    for j=1:electmax,
        [p1,tb1]= Anova1Conditioned(conditioncolumn,sessioncolumn,subjectcolumn,alphath,i,j,expdata1);
        Pmat(i,j)=p1;
        Sigmat(i,j)=(p1<alphath);
    end
end


% for j=1:electmax,
%     for i=1:1:tindexmax,
%         if (i-adjsigframe)>0,
%             sr=i-adjsigframe;
%         else 
%             sr=1;
%         end 
%         if (i+adjsigframe)<=tindexmax,
%             sp=i+adjsigframe;
%         else 
%             sp=tindexmax;
%         end 
%                 
%         if (sum(Sigmat(sr:sp,j))/(sp-sr+1))>filtth,
%             FiltSigmat(i,j)=1;
%         else
%             FiltSigmat(i,j)=0;
%         end            
%     end
% end

illusmap=(Pmat.*Sigmat).';
hmo=HeatMap(illusmap,'ColumnLabels',sampleperiod*[1:tindexmax],'Standardize',3,'Colormap',redbluecmap);
addTitle(hmo, Title);
addXLabel(hmo, XLabel);
addYLabel(hmo, YLabel)
% illusmap=(Pmat.*FiltSigmat).';
% hmo=HeatMap(illusmap,'ColumnLabels',sampleperiod*[1:meassize(1,timecolumn)],'Standardize',3,'Colormap',redbluecmap);
% addTitle(hmo, 'incongruent-congruent')

%%
toc
end

