tsm=[0:0.001:300];
thconfidence_x=0.9;
thconfidence_y=0.9;
thconfidence_z=0.9;
stconfidence=0.01;

st_x=0.5; % this is the start time for firing of sensors i.e. reaching the start confidence level, stconfidence, which assumed to remain fixed
st_y=0.5; % this is the start time for firing of sensors i.e. reaching the start confidence level, stconfidence, which assumed to remain fixed
rt_x=120;   % is the time x get to thconfidence level
rt_y=100;   % is the time y get to thconfidence level
al_x=1/(rt_x-st_x)*(log(1/stconfidence-1)-log(1/thconfidence_x-1));   % sigmoid spreading parameter for x
c_x=rt_x+1/al_x*log(1/thconfidence_x-1);

al_y=1/(rt_y-st_y)*(log(1/stconfidence-1)-log(1/thconfidence_y-1));   % sigmoid spreading parameter for y
c_y=rt_y+1/al_y*log(1/thconfidence_y-1);



sigx=sigmf(tsm,[al_x c_x]);
sigy=sigmf(tsm,[al_y c_y]);
sigz=sigx+sigy-sigx.*sigy;



figure;
plot(tsm,sigx,'--b');
hold;
plot(tsm,sigy,'-.r');
plot(tsm,sigz,'-.g');
legend('sigx','sigy','sigz')
%plot(tsm,sigm,'-.m');
%legend('sigx','sigy','sigz','multimplication')
hold;


