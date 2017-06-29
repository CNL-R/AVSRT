% Developed by Arian Shoari. Copyright 2017 John Foxe's Lab, University of Rochester. 
% Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
% http://www.apache.org/licenses/LICENSE-2.0
% Unless agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
% https://www.apache.org/licenses/LICENSE-2.0

function [ Pmat,Sigmat, FiltSigmat ] = Anova1Heatmap(sampleperiod,adjsigframe,filtth,alphath,timecolumn,electrodecolumn,Xtick,Xticklabel,Ytick,Yticklabel,Title,XLabel,YLabel,expdata1)
% adjsigframe specify the number of adjacent significant violation time frame that requires to consider a violation in time a valid violation   
% Pmat is the matrix of p values over time and electrode
% Sigmat stores only the significant p values compared with the alphath and
% assume the rest as alphath
% FiltSigmat is the filtered Sigmat considering adjsigframe criteria in the time domain  
% expdata1 is the input Matrix contains all the data
% timecolumn,electrodecolumn are the columns of the matrix refering to the
% time and electrode number of the samples
% alphath is the significant level threshold for P values 
% 
% Xtick,Xticklabel,Ytick,Yticklabel are the tick points and labels to be
% domonstared on the X, Y axis.
% Title,XLabel,YLabel are the labels should be displayed on the heatmap
% sampleperiod,adjsigframe,filtth are disabled in this version 
% Original elecrode Mapping as follows
% A1:A32  1:32
% B1:B32  33:64
% C1:C32  65:96
% D1:D32  97:128
% E1:E32  129:160
% F1:F32  161:192
% G1:G32  193:224

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
        if p1<alphath,
            Sigmat(i,j)=p1;
        else
            Sigmat(i,j)=alphath;
        end    
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

%illusmap=(Pmat).'; if you want to show all the P-values without filtering
illusmap=Sigmat.';
% next line flip the columns to reflect the order requested i.e [D1:D32 C1:C32 E1:E32 G1:G32 B1:B32 F1:F32 A1:A32]
OrderedIllusmap=[illusmap(97:128,:); illusmap(65:96,:); illusmap(129:160,:); illusmap(193:224,:); illusmap(33:64,:); illusmap(161:192,:); illusmap(1:32,:)];% because illusmap was transposed of Pmat

%%

hs=size(OrderedIllusmap);
rows=hs(1,1);
columns=hs(1,2);
if  columns>rows,
    scalec=floor(columns/rows);
    scaler=1;
else
    scalec=1;
    scaler=floor(rows/columns);
end    
newWidth = [1 scalec*rows];
newLength= [1 scaler*columns];
figure;

if  columns>rows,
    imshow(OrderedIllusmap,[] , 'YData',newWidth);
else
    imshow(OrderedIllusmap,[] , 'XData',newLength);
end

axis on;

cmap=colormap(jet);
cmap=flipud(cmap);
colormap(cmap);
%colormap(jet);
colorbar;
    
ax = gca;
ax.YTick=scalec*Ytick;
ax.YTickLabel =Yticklabel;
ax.XTick = scaler*Xtick;
ax.XTickLabel = Xticklabel;

ax.Title.String = Title;
ax.XLabel.String =XLabel;
ax.YLabel.String =YLabel;

set(gca,'YDir','normal'); % flip bottom and top display on Y axis

%% sample code that employs HeatMap function for drawing but can not colorbar or identify the ticks
%  hmo=HeatMap(OrderedIllusmap,'ColumnLabels',sampleperiod*[1:tindexmax],'Standardize',3,'Colormap',jet); %  color map could be redbluecmap instead of jet
%  addTitle(hmo, Title);
%  addXLabel(hmo, XLabel);
%  addYLabel(hmo, YLabel);
% %%%

%% sample code to resize the actual image! 
%  stretchedImage =imresize(OrderedIllusmap,newWidth);
%  imshow(stretchedImage , 'YData','');
%  axis on;
%  colormap(jet);
%  colorbar
% %%%
%%
toc
end

