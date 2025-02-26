function   AB_draw_cumulative_imageTim(RANSAC,RANSAC_PLUS,LGSC,Ours,Dataname)
numData=size(RANSAC,2);
xRange = (1:1:numData)/numData; % X轴间隔变化范围LPM

xRange = (1:numData)/numData;
y = sort(RANSAC); % 'v','p','s','d','o','<','*','h','^','+','>','.'
plot(xRange,[y(1:end)],'*-','color',[1 0.75 0],'markersize',10,'LineWidth',1.5);
hold on;
y = sort(RANSAC_PLUS);
plot(xRange,[y(1:end)],'h-','color',[0 0.451 0.761],'markersize',10,'LineWidth',1.5);
hold on;
y = sort(LGSC);
plot(xRange,[y(1:end)],'gv-','markersize',10,'LineWidth',1.5); 
hold on;
y = sort(Ours);
plot(xRange,[y(1:end)],'^-','color',[0.655 0.404 0.792],'markersize',10,'LineWidth',1.5);
hold on;


axis([0 1 0 3]);  % axis([0 1.02 0 0.2]);
set(gca,'xtick',[0:0.1:1]);
set(gca,'ytick',[0:0.5:3]);
set(gca,'Fontsize',15);
RANSAC = sprintf('RANSAC, Average Runtime=%.2f%', mean(RANSAC));
RANSAC_PLUS = sprintf('RANSAC++, Average Runtime=%.2f%', mean(RANSAC_PLUS));
LGSC = sprintf('LGSC, Average Runtime=%.2f%', mean(LGSC));
Ours= sprintf('Ours, Average Runtime=%.2f%', mean(Ours));


II=legend({RANSAC,RANSAC_PLUS,LGSC,Ours,Dataname});
TitleName = strcat(Dataname,'-Runtime');
title(TitleName);  % CIAP2xmut  FE2xmut  PAN2xmut  UAV2xmut  
xlabel('Cumulative Distribution','fontsize',20);ylabel('Runtime(s)','fontsize',20);
set(II,'color','none');
set(II,'fontsize',14);


end