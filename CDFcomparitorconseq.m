function [cdevalpts,htA,htB,htC,h_min_tAtB,samplenum] = CDFcomparitorconseq(condAPrec,condACurr,condBPrec,condBCurr,condCPrec,condCCurr, indconditionedcell,CDFsteps )
%CDFcomparitor calculate an empirical cumulative distribution function for
%three different conditions with the same evaluation intervals
%   Detailed explanation goes here


  sortedcelltA=sort(indconditionedcell{condAPrec,condACurr}); % sort individual conditioned cell
  sortedcelltB=sort(indconditionedcell{condBPrec,condBCurr}); % sort individual conditioned cell
  sortedcelltC=sort(indconditionedcell{condCPrec,condCCurr}); % sort individual conditioned cell
  
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
%     [hteA,teA] = ecdf(indconditionedcell{focond(1)}); %emperical CDF
%     plot(teA,hteA,'--bx');
%     hold on;
%     plot(cdevalpts,htA,'-.ro');
%     legend('ecdf','implemented');
%     xlabel('response delay ms');
%     ylavbel('CDF');
%     title('comparision between implemented CDF and Matlab in-built ecdf')
%     hold off;


end

