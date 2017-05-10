function [cdevalpts,htA,htB,htC,h_min_tAtB,samplenum,meanA,modA,stdA,meanB,modB,stdB,meanC,modC,stdC] = CDFcomparitorconseq(condAPrec,condACurr,condBPrec,condBCurr,condCPrec,condCCurr,indseqcondcell,CDFsteps )
%CDFcomparitor calculate an empirical cumulative distribution function for
%three different conditions with the same evaluation intervals
%   Detailed explanation goes here


  sortedcelltA=sort(indseqcondcell{condAPrec,condACurr}); % sort individual conditioned cell
  sortedcelltB=sort(indseqcondcell{condBPrec,condBCurr}); % sort individual conditioned cell
  sortedcelltC=sort(indseqcondcell{condCPrec,condCCurr}); % sort individual conditioned cell
  
  meanA=mean(sortedcelltA);
  if mod(length(sortedcelltA),2)==0;
     modA=0.5*(sortedcelltA(length(sortedcelltA)/2)+sortedcelltA(length(sortedcelltA)/2+1));
  else
      modA=sortedcelltA((length(sortedcelltA)+1)/2);
  end    
  stdA=std(sortedcelltA);
  
  meanB=mean(sortedcelltB);
  if mod(length(sortedcelltB),2)==0;
     modB=0.5*(sortedcelltB(length(sortedcelltB)/2)+sortedcelltB(length(sortedcelltB)/2+1));
  else
      modB=sortedcelltB((length(sortedcelltB)+1)/2);
  end    
  stdB=std(sortedcelltB);
  
  meanC=mean(sortedcelltC);
  if mod(length(sortedcelltC),2)==0;
     modC=0.5*(sortedcelltC(length(sortedcelltC)/2)+sortedcelltC(length(sortedcelltC)/2+1));
  else
      modC=sortedcelltC((length(sortedcelltC)+1)/2);
  end    
  stdC=std(sortedcelltC);
  
  samplenum=min([length(sortedcelltA),length(sortedcelltB),length(sortedcelltC)]);
  
  mintAtB=min([sortedcelltA(1),sortedcelltB(1),sortedcelltC(1)]);
  maxtAtB=max([sortedcelltA(length(sortedcelltA)),sortedcelltB(length(sortedcelltB)),sortedcelltC(length(sortedcelltC))]);
  cdevalpts=mintAtB:CDFsteps:maxtAtB;  % This is common evaluation points used for all CDF s
    
  htA=zeros(size(cdevalpts));
  htB=zeros(size(cdevalpts));
  htC=zeros(size(cdevalpts));
     
for ievth=1:length(cdevalpts),
    evth=cdevalpts(ievth);
    htA(ievth)= sum(sortedcelltA <=evth)/length(sortedcelltA);
    htB(ievth)= sum(sortedcelltB <=evth)/length(sortedcelltB);
    htC(ievth)= sum(sortedcelltC <=evth)/length(sortedcelltC);  
end

    h_min_tAtB=htA+htB-htB.*htA  ;% this is the CDf distribution of min(tA,tB) considering that tA and tB are independent random 
  
%   implemented CDF test
%     figure;
%     [hteA,teA] = ecdf(indseqcondcell{focond(1)}); %emperical CDF
%     plot(teA,hteA,'--bx');
%     hold on;
%     plot(cdevalpts,htA,'-.ro');
%     legend('ecdf','implemented');
%     xlabel('response delay ms');
%     ylavbel('CDF');
%     title('comparision between implemented CDF and Matlab in-built ecdf')
%     hold off;


end

