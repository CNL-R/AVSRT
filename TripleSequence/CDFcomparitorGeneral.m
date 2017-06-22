function [cdevalpts,htA,htB,htC,hRM,h_min_tAtB,htIRM,meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC,sortedcellIRM,sortedcellSimRM] = CDFcomparitorGeneral(sortedcelltA,sortedcelltB,sortedcelltC,CDFsteps )
%CDFcomparitor calculate an empirical cumulative distribution function for
%three different conditions with the same evaluation intervals
%   Detailed explanation goes here
% should receive the A, B, and C  response time collections in a sorted
% order and aim to calculate the race model of A and B for comparision
% with C  in addition to calculate the CDF and statistics of A, B, C and a
% simulated collection which has the same CDF as Race Model (RM) and Independent
% Race Model (IRM).
% cdevalpts represents the common x-axis for the CDFs
% htA,htB,htC,hRM,h_min_tAtB,htIRM store each CDF value corresponds to cdevalpts in time responses
% meanA,medA,stdA,meanB,medB,stdB,meanC,medC,stdC are simply the statistics
% of the three observations collection
% sortedcellIRM,sortedcellSimRM are the virtual collections whose CDF are
% equivalent to sortedcellIRM,sortedcellSimRM

 
  temp3=zeros(1,length(sortedcelltA)*length(sortedcelltB));
  for i=1:length(sortedcelltA)
      for j=1:length(sortedcelltB)
          temp3(j+(i-1)*length(sortedcelltB))=min(sortedcelltA(i),sortedcelltB(j)); % no repeat on temp3 elements
      end
  end
  sortedcellIRM=sort(temp3); % this is the empirical min(tA,tB) calculated through minum of samples directly instead of the CDF formula
  
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
    htIRM(ievth)=sum(sortedcellIRM <=evth)/length(sortedcellIRM); % this should match h_min_tAtB to very good extent , this is tested and give very similar response as h_min_tAtB
end

  h_min_tAtB=htA+htB-htB.*htA  ;% this is the CDf distribution of min(tA,tB) considering that tA and tB are independent random

  %%% we build a simulated version sortedcellAplusB such that the sample
  %%% times generate an hRM equal to Race Model. Note a simple
  %%% accumulate of events A and B will generate CDF equal to
  %%% 0.5*(CDF_A+CDF_B) thus we normalise it by removing all events that
  %%% have time greater than a threshold time euqal to hRM=1
  
  hRM=htA+htB;
  hRM(hRM>1)=1;
  ind_half=find(hRM==1,1);
  t_half=cdevalpts(ind_half);
  celltNormAplusB=[sortedcelltA(sortedcelltA <t_half); sortedcelltB(sortedcelltB <t_half)];
  sortedcellSimRM=sort(celltNormAplusB);

%%%%%% this part is to test if CDF of sortedcellSimRM will match hRM and it does!  
%   htSimRM=zeros(size(cdevalpts));% this should match h_min_tAtB to very good extent , this is tested and give very similar response as h_min_tAtB
% 
% for ievth=1:length(cdevalpts),
%     evth=cdevalpts(ievth);
%     htSimRM(ievth)=sum(sortedcellSimRM <=evth)/length(sortedcellSimRM); % this should match h_min_tAtB to very good extent , this is tested and give very similar response as h_min_tAtB
% end
%%%%%%%%%



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

