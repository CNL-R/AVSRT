function [pindv,statsindv,meansindv,resultsindv] = AnovaIndAnalysis(Outdir,alphath,indseqcondcell,id,invarlist,listcond)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

pindv=cell(1,size(id,2));
statsindv=cell(1,size(id,2));
meansindv=cell(1,size(id,2));
resultsindv=cell(1,size(id,2));

for j=1:size(id,2), %over individuals
    RTAcc=[]; % for each person it should be initialized again
    GroupAcc=[];
    GroupStrAcc=[];
    for i=1:length(invarlist), % group index
        condA=listcond(1,i);
        condB=listcond(2,i);
        RTcond=indseqcondcell{j,condA,condB}; % look at the way refrencing index 
        groupcond=i*ones(size(RTcond));
        groupstr=char(36*ones([length(RTcond) length(invarlist{i})])); % cautious about list indexing, invarlist{i}
        for istr=1:length(RTcond),
            groupstr(istr,:)=invarlist{i};
        end    
            
        GroupStrAcc=[GroupStrAcc; groupstr]; 
        RTAcc=[RTAcc; RTcond];
        GroupAcc=[GroupAcc; groupcond];
        %emptygroup=strings(size(RTindiv));
    end    
    [p,~,stats] = anova1(RTAcc,GroupStrAcc,'off'); % p is the F value for anova test
    pindv{j}=p;
    statsindv{j}=stats;
    H1=figure;
    % [results,means] = multcompare(stats,'CType','bonferroni')
    [results,means] = multcompare(stats,alphath,'on','hsd'); % hsd is tukey-kramer 
    title({strcat('Group Statistical Comparision for participant: ',strjoin(id(j))),strcat('alhpa=',num2str(alphath,'%.2f'))});
    savefig(H1,strcat(Outdir,'\',strjoin(id(j)),'Fig1'));
    saveas(H1,strcat(Outdir,'\',strjoin(id(j)),'Fig1.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name
    meansindv{j}=means;
    resultsindv{j}=results;

end

end

