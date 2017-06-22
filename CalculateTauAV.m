function [ TauAV ] = CalculateTauAV(st_x,st_y,rt_x,rt_y,tsm,thconfidence_x,thconfidence_y,thconfidence_z,stconfidence )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
al_x=1/(rt_x-st_x)*(log(1/stconfidence-1)-log(1/thconfidence_x-1));   % sigmoid spreading parameter for x
c_x=rt_x+1/al_x*log(1/thconfidence_x-1);

al_y=1/(rt_y-st_y)*(log(1/stconfidence-1)-log(1/thconfidence_y-1));   % sigmoid spreading parameter for y
c_y=rt_y+1/al_y*log(1/thconfidence_y-1);

sigx=sigmf(tsm,[al_x c_x]);
sigy=sigmf(tsm,[al_y c_y]);
sigz=sigx+sigy-sigx.*sigy;

TauAV=tsm(find(sigz>=thconfidence_z,1));


end

