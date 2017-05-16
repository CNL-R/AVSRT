tsm=[-2:0.001:2];
sigx=sigmf(tsm,[4 0.5]);
sigy=sigmf(tsm,[2 0.2]);
sigz=sigx+sigy-sigx.*sigy;

figure(500);
plot(tsm,sigx,'--b');
hold;
plot(tsm,sigy,'-.r');
plot(tsm,sigz,'-.g');
legend('sigx','sigy','sigz')
hold;

