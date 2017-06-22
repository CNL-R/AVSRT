function [ outmixedcell ] = combinecondition(condAPrec,condACurr,condBPrec,condBCurr,seqcondcell )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
outmixedcell=[seqcondcell{condBPrec,condBCurr};seqcondcell{condAPrec,condACurr}];

end

