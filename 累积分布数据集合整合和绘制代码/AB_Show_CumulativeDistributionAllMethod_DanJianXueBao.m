function AB_Show_CumulativeDistributionAllMethod_DanJianXueBao
    close all;
    clear all;
    clc;

    Dataname = 'CIAP';  % CIAP 2xmut  FE 2xmut  PAN 2xmut  UAV 2xmut  ��������ݼ� 
    %��ȡRANSAC�����ݽ��
    file_names_RANSAC = strcat('RANSAC_',Dataname,'2xmut'); % CIAP2xmut  FE2xmut  PAN2xmut  UAV2xmut      
    pack = load([file_names_RANSAC,'.mat']) ;  
    RANSAC_results = pack.Ours_results ;  % inlier_num(1),inlierRate(2),precision_rate(3),Recall_rate(4),f_1(5),RANSAC_Time(6)
% RANSAC_results = pack.RANSAC_results ;  
    %��ȡRANSAC++�����ݽ��
    file_names_RANSAC_PLUS = strcat('RANSAC_PLUS_',Dataname,'2xmut');  %  CIAP2xmut  FE2xmut  PAN2xmut  UAV2xmut     
    pack = load([file_names_RANSAC_PLUS,'.mat']) ;  
    RANSAC_PLUS_results = pack.Ours_results ;
    %��ȡLGSC�����ݽ��
    file_names_LGSC = strcat('LGSC_',Dataname,'2xmut'); % CIAP2xmut  FE2xmut  PAN2xmut  UAV2xmut GS_FE2xmut
    pack = load([file_names_LGSC,'.mat']) ;
    LGSC_results = pack.Ours_results ;
    %��ȡ�����㷨�����ݽ��
    file_names_Ours = strcat('DanJian_',Dataname,'2xmut');     % CIAP2xmut  FE2xmut  PAN2xmut  UAV2xmut
    pack = load([file_names_Ours,'.mat']) ;    
    Ours_results = pack.Ours_results ;
%     file_names_LOGO = strcat('LOGO_',Dataname,'2xmut');     % CIAP2xmut  FE2xmut  PAN2xmut  UAV2xmut
%     pack = load([file_names_LOGO,'.mat']) ;    
%     LOGO_results = pack.LOGO_results ;

    %%%%%%%%%% UAV dataset precision %%%%%%%%%%%%%%
    %��ȡ���㷨������ݼ��е�׼ȷ��
    figure('name','CIAP_Precision'),
    RANSACpr = RANSAC_results(:,2)';
    RANSAC_PLUSpr= RANSAC_PLUS_results(:,2)';
    LGSCpr = LGSC_results(:,2)';
    Ours_pr = Ours_results(:,2)';
    % ����ȡ�Ľ�����л滭���������������������㷨�������и��ģ��Ӻ�������Ҳ��Ҫ���ģ������������ʾҲһ����
    AB_draw_cumulative_imagePre(RANSACpr,RANSAC_PLUSpr,LGSCpr,Ours_pr,Dataname); 

    %%%%%%%%%% UAV dataset recall %%%%%%%%%%%%%%
    %��ȡ���㷨������ݼ��е��ٻ���
    figure('name','CIAP_Recall'),
    RANSACre = RANSAC_results(:,3)';
    RANSAC_PLUSre= RANSAC_PLUS_results(:,3)';  
    LGSCre = LGSC_results(:,3)';
    Oursre = Ours_results(:,3)';
 AB_draw_cumulative_imageRec(RANSACre,RANSAC_PLUSre,LGSCre,Oursre,Dataname); % ,LAFpr
    %%%%%%%%%% UAV dataset F-Score %%%%%%%%%%%%%%
    %��ȡ���㷨������ݼ��е�F����
    figure('name','CIAP_F-score'),
    RANSACFs = RANSAC_results(:,4)';
    RANSAC_PLUSFs= RANSAC_PLUS_results(:,4)';
    LGSCFs = LGSC_results(:,4)';
    Ours_Fs = Ours_results(:,4)';

   AB_draw_cumulative_imageFscor(RANSACFs,RANSAC_PLUSFs,LGSCFs,Ours_Fs,Dataname); % ,LAFpr
    %%%%%%%%%% UAV dataset Runtime(s) %%%%%%%%%%%%%%
    %��ȡ���㷨������ݼ��е�����ʱ��
    figure('name','Runtime(s)'),
    RANSACTime = RANSAC_results(:,5)';
    RANSAC_PLUSTime= RANSAC_PLUS_results(:,5)';
     LGSCTime = LGSC_results(:,5)';
    Ours_Time = Ours_results(:,5)';
  
 AB_draw_cumulative_imageTim(RANSACTime,RANSAC_PLUSTime,LGSCTime,Ours_Time,Dataname); % ,LAFpr

    %%%%%%%%%% show inlier ratios %%%%%%%%%%%%%%
    %��ȡ���ݼ����ڵ����
    figure('name','Inlier Ratio'),
    RANSACTinlierratio = RANSAC_results(:,1)';
    AB_draw_cumulative_inlier_ratios(RANSACTinlierratio,Dataname);







end