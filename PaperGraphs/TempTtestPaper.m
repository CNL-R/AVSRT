percentiles = [.05 .1 .15 .2 .25 .3 .35 .4 .45 0.5 0.55 0.6 0.65 0.7];
AVvarlist = {'htpureAV' 'htmultiA_AV' 'htmultiAV_AV' 'htmultiV_AV' 'htrepeatAV' 'htclassAV'}; % these are list of CDF variables calculated in the TimeAnalysisAveragePaper 
RM1varlist= {'htpureRM' 'htmultipsA_RM'  'htmultipsAV_RM'  'htmultipsV_RM' 'htrepeat_RM'  'htclassical_RM'};
RM2varlist={'htpureIRM' 'htmultipsA_IRM' 'htmultipsAV_IRM' 'htmultipsV_IRM' 'htrepeat_IRM' 'htclassical_IRM'};
evalptslist={'cdevalptspure' 'cdevalptsmultipsA' 'cdevalptsmultipsAV'  'cdevalptsmultipsV' 'cdevalptsrepeat' 'cdevalptsclassical'};

AVperctimevarlist = {'pureAV_perctime' 'multiA_AV_perctime' 'multiAV_AV_perctime' 'multiV_AV_perctime' 'repeatAV_perctime' 'classAV_perctime'}; % this is the time the CDF variables reach to specific percetiles
RM1perctimevarlist = {'pureRM_perctime' 'multipsA_RM_perctime'  'multipsAV_RM_perctime'  'multipsV_RM_perctime' 'repeat_RM_perctime'  'classical_RM_perctime'}; % these are the time the Race Model reach to specific percetiles
RM2perctimevarlist = {'pureIRM_perctime' 'multipsA_IRM_perctime' 'multipsAV_IRM_perctime' 'multipsV_IRM_perctime' 'repeat_IRM_perctime' 'classical_IRM_perctime'};



for i = 1:length(AVvarlist)
    AVCDFdat = evalin('base',AVvarlist{i});
    RM1CDFdat = evalin('base',RM1varlist{i});
    RM2CDFdat = evalin('base',RM2varlist{i});
    evalptsdat = evalin('base',evalptslist{i});
    
    tempAV_out=zeros(size(id,2),size(percentiles));
    tempRM1_out=zeros(size(id,2),size(percentiles));
    tempRM2_out=zeros(size(id,2),size(percentiles));
    
    for j=1:size(id,2), % the index of individual in the indcell
        for k = 1:length(percentiles),
            tempAV_out(j,k) = evalptsdat(find(AVCDFdat{j}>percentiles(k),1)); % identify the first index where AVCDFdat becomes greater than percentiles
            tempRM1_out(j,k) = evalptsdat(find(RM1CDFdat{j}>percentiles(k),1)); % identify the first index where AVCDFdat becomes greater than percentiles
            tempRM2_out(j,k) = evalptsdat(find(RM2CDFdat{j}>percentiles(k),1)); % identify the first index where AVCDFdat becomes greater than percentiles       
        end      
    end  
    
    assignin('base',AVperctimevarlist{i}, tempAV_out);
    assignin('base',RM1perctimevarlist{i}, tempRM1_out);
    assignin('base',RM2perctimevarlist{i}, tempRM2_out);       
      
end

