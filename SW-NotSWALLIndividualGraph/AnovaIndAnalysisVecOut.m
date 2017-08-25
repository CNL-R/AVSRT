function [halfwidthindv,pindv,statsindv,tblindv,meansindv,resultsindv,critindv,seindv,pvalindv,hindv] = AnovaIndAnalysisVecOut(Outdir,alphath,indseqcondcell,id,invarlist,listcond)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

pindv=cell(1,size(id,2));
statsindv=cell(1,size(id,2));
meansindv=cell(1,size(id,2));
resultsindv=cell(1,size(id,2));
tblindv=cell(1,size(id,2));
critindv=cell(1,size(id,2));
seindv=cell(1,size(id,2));
pvalindv=cell(1,size(id,2));
hindv=cell(1,size(id,2));
halfwidthindv=cell(1,size(id,2));


for j=1:size(id,2), % over individuals
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
    [p,tb1,stats] = anova1(RTAcc,GroupStrAcc,'off'); % p is the F value for anova test
    pindv{j}=p;
    statsindv{j}=stats;
    tblindv{j}=tb1;
    H1=figure;
    % [results,means] = multcompare(stats,'CType','bonferroni')
    % [results,means] = multcompare(stats,alphath,'on','hsd'); % hsd is tukey-kramer 
    
    %[se,crit,pval,results,means,h,gnames]= multcompareV3(stats,alphath,'on','hsd');
    [halfwidth,se,crit,pval,results,means,h,gnames]= multcompareV4(stats,alphath,'on','hsd');
    critindv{j}=crit;
    seindv{j}=se;
    pvalindv{j}=pval;
    meansindv{j}=means;
    resultsindv{j}=results;
    hindv{j}=h;
    halfwidthindv{j}=halfwidth;
    
%     title({strcat('Group Statistical Comparision for participant: ',strjoin(id(j))),strcat('alhpa=',num2str(alphath,'%.2f'))});
%     savefig(H1,strcat(Outdir,'\',strjoin(id(j)),'Fig1'));
%     saveas(H1,strcat(Outdir,'\',strjoin(id(j)),'Fig1.png')); %draw and save figures in the appropriate format in the specified directory and with an automatic name


end

end

