function AB_Show_CumulativeDistributionAllMethod_DanJianXueBao
    close all;
    clear all;
    clc;

    Dataname = 'CIAP';  % CIAP 2xmut  FE 2xmut  PAN 2xmut  UAV 2xmut  输入的数据集 
    %读取RANSAC的数据结果
    file_names_RANSAC = strcat('RANSAC_',Dataname,'2xmut'); % CIAP2xmut  FE2xmut  PAN2xmut  UAV2xmut      
    pack = load([file_names_RANSAC,'.mat']) ;  
    RANSAC_results = pack.Ours_results ;  % inlier_num(1),inlierRate(2),precision_rate(3),Recall_rate(4),f_1(5),RANSAC_Time(6)
% RANSAC_results = pack.RANSAC_results ;  
    %读取RANSAC++的数据结果
    file_names_RANSAC_PLUS = strcat('RANSAC_PLUS_',Dataname,'2xmut');  %  CIAP2xmut  FE2xmut  PAN2xmut  UAV2xmut     
    pack = load([file_names_RANSAC_PLUS,'.mat']) ;  
    RANSAC_PLUS_results = pack.Ours_results ;
    %读取LGSC的数据结果
    file_names_LGSC = strcat('LGSC_',Dataname,'2xmut'); % CIAP2xmut  FE2xmut  PAN2xmut  UAV2xmut GS_FE2xmut
    pack = load([file_names_LGSC,'.mat']) ;
    LGSC_results = pack.Ours_results ;
    %读取我们算法的数据结果
    file_names_Ours = strcat('DanJian_',Dataname,'2xmut');     % CIAP2xmut  FE2xmut  PAN2xmut  UAV2xmut
    pack = load([file_names_Ours,'.mat']) ;    
    Ours_results = pack.Ours_results ;
%     file_names_LOGO = strcat('LOGO_',Dataname,'2xmut');     % CIAP2xmut  FE2xmut  PAN2xmut  UAV2xmut
%     pack = load([file_names_LOGO,'.mat']) ;    
%     LOGO_results = pack.LOGO_results ;

    %%%%%%%%%% UAV dataset precision %%%%%%%%%%%%%%
    %读取各算法结果数据集中的准确率
    figure('name','CIAP_Precision'),
    RANSACpr = RANSAC_results(:,2)';
    RANSAC_PLUSpr= RANSAC_PLUS_results(:,2)';
    LGSCpr = LGSC_results(:,2)';
    Ours_pr = Ours_results(:,2)';
    % 将读取的结果进行绘画，输入参数根据你输入的算法个数进行更改，子函数里面也需要更改；后面的其他显示也一样。
    AB_draw_cumulative_imagePre(RANSACpr,RANSAC_PLUSpr,LGSCpr,Ours_pr,Dataname); 

    %%%%%%%%%% UAV dataset recall %%%%%%%%%%%%%%
    %读取各算法结果数据集中的召回率
    figure('name','CIAP_Recall'),
    RANSACre = RANSAC_results(:,3)';
    RANSAC_PLUSre= RANSAC_PLUS_results(:,3)';  
    LGSCre = LGSC_results(:,3)';
    Oursre = Ours_results(:,3)';
 AB_draw_cumulative_imageRec(RANSACre,RANSAC_PLUSre,LGSCre,Oursre,Dataname); % ,LAFpr
    %%%%%%%%%% UAV dataset F-Score %%%%%%%%%%%%%%
    %读取各算法结果数据集中的F分数
    figure('name','CIAP_F-score'),
    RANSACFs = RANSAC_results(:,4)';
    RANSAC_PLUSFs= RANSAC_PLUS_results(:,4)';
    LGSCFs = LGSC_results(:,4)';
    Ours_Fs = Ours_results(:,4)';

   AB_draw_cumulative_imageFscor(RANSACFs,RANSAC_PLUSFs,LGSCFs,Ours_Fs,Dataname); % ,LAFpr
    %%%%%%%%%% UAV dataset Runtime(s) %%%%%%%%%%%%%%
    %读取各算法结果数据集中的运行时间
    figure('name','Runtime(s)'),
    RANSACTime = RANSAC_results(:,5)';
    RANSAC_PLUSTime= RANSAC_PLUS_results(:,5)';
     LGSCTime = LGSC_results(:,5)';
    Ours_Time = Ours_results(:,5)';
  
 AB_draw_cumulative_imageTim(RANSACTime,RANSAC_PLUSTime,LGSCTime,Ours_Time,Dataname); % ,LAFpr

    %%%%%%%%%% show inlier ratios %%%%%%%%%%%%%%
    %读取数据集的内点比例
    figure('name','Inlier Ratio'),
    RANSACTinlierratio = RANSAC_results(:,1)';
    AB_draw_cumulative_inlier_ratios(RANSACTinlierratio,Dataname);







end