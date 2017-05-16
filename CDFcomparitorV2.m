function [cdevalpts,htA,htB,htC,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcelltA,sortedcelltB,sortedcelltC,sortedcelltIRM] = CDFcomparitorV2(condA,condB,condC, indconditionedcell,CDFsteps )
%CDFcomparitor calculate an empirical cumulative distribution function for
%three different conditions with the same evaluation intervals
%   Detailed explanation goes here

  focond=[condA,condB,condC];
  sortedcelltA=sort(indconditionedcell{focond(1)}); % sort individual conditioned cell
  sortedcelltB=sort(indconditionedcell{focond(2)}); % sort individual conditioned cell
  sortedcelltC=sort(indconditionedcell{focond(3)}); % sort individual conditioned cell
 
  temp3=zeros(1,length(sortedcelltA)*length(sortedcelltB));
  for i=1:length(sortedcelltA)
      for j=1:length(sortedcelltB)
          temp3(j+(i-1)*length(sortedcelltB))=min(sortedcelltA(i),sortedcelltB(j)); % no repeat on temp3 elements
      end
  end
  sortedcelltIRM=sort(temp3); % this is the empirical min(tA,tB) calculated through minum of samples directly instead of the CDF formula
  
  meanA=mean(sortedcelltA);
  if mod(length(sortedcelltA),2)==0;
     medA=0.5*(sortedcelltA(length(sortedcelltA)/2)+sortedcelltA(length(sortedcelltA)/2+1));
  else
      medA=sortedcelltA((length(sortedcelltA)+1)/2);
  end    
  stdA=std(sortedcelltA);
  
  
  meanB=mean(sortedcelltB);
  if mod(length(sortedcelltB),2)==0;
     medB=0.5*(sortedcelltB(length(sortedcelltB)/2)+sortedcelltB(length(sortedcelltB)/2+1));
  else
      medB=sortedcelltB((length(sortedcelltB)+1)/2);
  end    
  stdB=std(sortedcelltB);
  
  meanC=mean(sortedcelltC);
  if mod(length(sortedcelltC),2)==0;
     medC=0.5*(sortedcelltC(length(sortedcelltC)/2)+sortedcelltC(length(sortedcelltC)/2+1));
  else
      medC=sortedcelltC((length(sortedcelltC)+1)/2);
  end    
  stdC=std(sortedcelltC);
  
  
  mintAtB=min([sortedcelltA(1),sortedcelltB(1),sortedcelltC(1)]);
  maxtAtB=max([sortedcelltA(length(sortedcelltA)),sortedcelltB(length(sortedcelltB)),sortedcelltC(length(sortedcelltC))]);
  cdevalpts=mintAtB:CDFsteps:maxtAtB;  % This is common evaluation points used for all CDF s
    
  htA=zeros(size(cdevalpts));
  htB=zeros(size(cdevalpts));
  htC=zeros(size(cdevalpts));
  htIRM=zeros(size(cdevalpts));% this should match h_min_tAtB to very good extent , this is tested and give very similar response as h_min_tAtB
     
for ievth=1:length(cdevalpts),
    evth=cdevalpts(ievth);
    htA(ievth)= sum(sortedcelltA <=evth)/length(sortedcelltA);
    htB(ievth)= sum(sortedcelltB <=evth)/length(sortedcelltB);
    htC(ievth)= sum(sortedcelltC <=evth)/length(sortedcelltC);  
    htIRM(ievth)=sum(sortedcelltIRM <=evth)/length(sortedcelltIRM); % this should match h_min_tAtB to very good extent , this is tested and give very similar response as h_min_tAtB
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

