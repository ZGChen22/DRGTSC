function   AB_draw_cumulative_inlier_ratios(RANSAC,Dataname)
numData=size(RANSAC,2);
xRange = (1:1:numData)/numData; % X轴间隔变化范围LPM

xRange = (1:numData)/numData;
y = sort(RANSAC);
plot(xRange,[y(1:end)],'o-','color',[0 0 1],'markersize',10,'LineWidth',1.5);
hold on;
% y = sort(GS);
% plot(xRange,[y(1:end)],'h-','color',[0 0.451 0.761],'markersize',10,'LineWidth',1.5);
% hold on;
% y = sort(RANSAC_PLUS);
% plot(xRange,[y(1:end)],'gv-','markersize',10,'LineWidth',1.5);
% hold on;
% y = sort(GFC);
% plot(xRange,[y(1:end)],'bd-','markersize',10,'LineWidth',1.5);
% hold on;
% y = sort(LPM);
% plot(xRange,[y(1:end)],'^-','color',[0.655 0.404 0.792],'markersize',10,'LineWidth',1.5);
% hold on;
% y = sort(mTopKRP);
% plot(xRange,[y(1:end)],'cs-','markersize',10,'LineWidth',1.5);
% hold on;
% y = sort(LAF);
% plot(xRange,[y(1:end)],'p-','color',[1 0 1],'markersize',10,'LineWidth',1.5);
% hold on;
% y = sort(Ours_TGRS);
% plot(xRange,[y(1:end)],'ro-','markersize',10,'LineWidth',1.5);
% hold on;
% y = sort(Acr7);
% plot(xRange,[y(1:end)],'A-','color',[1 0.46 0.18],'markersize',10,'LineWidth',1.5);
% hold on;

axis([0 1 0 1]);  % axis([0 1.02 0 0.2]);
set(gca,'xtick',[0:0.1:1]);
set(gca,'ytick',[0:0.1:1]);
set(gca,'Fontsize',15);
RANSAC = sprintf('Average Inlier Ratio: %.2f%%', mean(RANSAC)*100);
% GS = sprintf('GS, ART=%.2f%', mean(GS));
% RANSAC_PLUS = sprintf('RANSAC++, ART=%.2f%', mean(RANSAC_PLUS));
% GFC = sprintf('GFC, ART=%.2f%', mean(GFC));
% LPM = sprintf('LPM, ART=%.2f%', mean(LPM));
% mTopKRP = sprintf('mTopKRP, ART=%.2f%', mean(mTopKRP));
% LAF = sprintf('LAF, ART=%.2f%', mean(LAF));
% Ours_TGRS = sprintf('Ours, ART=%.2f%', mean(Ours_TGRS));
% RBSC = sprintf('RANSAC+RBSC, %.3f%', mean(mTopKRP));


 II=legend({RANSAC});
TitleName = strcat(Dataname,' Dataset');
title(TitleName);  % CIAP2xmut  FE2xmut  PAN2xmut  UAV2xmut  
xlabel('Cumulative Distribution','fontsize',20);ylabel('Inlier Ratio','fontsize',20);
set(II,'color','none');
set(II,'fontsize',14);


end