
function  Mine_compare_with_TRESAC
%=========== initialization ===============================
close all;
clear all;


Debug_Image_show = 1 ;
Debug_show_triplet_data = 1 ;

ExploopOneDate =  1 ;  % loop number for experiment
ALL_data_error = [];
 ALL_data_AVGTIME=[];
%================= Prepare data ===================================

file_namesH={'unihouse','bonython','physics','unionhouse','elderhalla','hartley','library','sene',... % 7
    'nese','ladysymon','oldclassicswing','neem','napiera','barrsmith',... % 13
    'elderhallb','napierb','johnsona','unihouse','bonhall','johnsonb','mc1','mc3','raglan'}; % 22  BostonA  BostonLibA  BrusselsA cityA  ExtremeZoomA
% 15                                     % 17                % 19
file_namesF={'cube','breadcartoychips0.1','biscuit','book','cube','game', 'cubechips','cubetoy','breadcube',... %7
    'gamebiscuit','breadtoy','breadtoycar','biscuitbook','biscuitbookbox','breadcubechips',...%13
    'cubebreadtoychips','breadcartoychips','carchipscube','toycubecar','boardgame','dinobooks'}; %19
% 14                                         % 16
file_namesTestResult={'1','11','F1','F3','UAV2A','F4_1','feijiA_1','feijiA_6lil1','feijiC1','feijiZhui2','feijiC1','feijiC2','feijiZhuiDEMO'};
file_namesUAV1Result={'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20',...
    '21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40',...
     '41','42','43','44','45','46','47','48','49','50','51','52','53','54','55','56','57','58','59','60',...
     '61','62','63','64','65','66','67','68','69','70','71','72','73','74','75','76','77','78','79','80',...
     '81','82','83','84','85','86','87','88','89','90','91','92','93','94','95','96','97','98','99','F3'};
 
 for dataNum = 100 : 100 % 8 9 0.02 overview 11 12 13考虑
    %-- parameter setting -------------------------------
    packName = file_namesUAV1Result(dataNum);
    model_type = 'affspace_All';   %% affspace_All   fundamental8  hyperplane超平面 homography单应矩阵
    ransac_noise_th = 0.01 ; % 34  0.05   55 0.06 78 0.06  MRIR (0.02)
     % epsilon =  0.05  ;  % 0.3 plane ransac  %  epsilon =  0.005 ; F 0.005     H 0.5      A 0.1  % F Adelaide 0.01  Seg 0.005   A  MRIR 0.1 (0.2) SNU 0.1 (0.2)
    KNN_number = 5;  % KNN  5 目标检测数据集改16
    m_model_size = 20 ; %% 20 常 目标检测数据集改9
    [fitfn,resfn,degenfn,psize,numpar,fit_model] = getModelParaXmu(model_type);   
    pack = load([packName{1},'.mat']); 
    [xy,I1,I2,data_normal,groundtrue] = D_CVPR_data_process_F_H (pack);  % Data process
     %-- parameter setting -------------------------------
    if Debug_Image_show  == 1 ;  % show for groundture 
 %暂时     Show_matching_groundtrue_retinal_images_all_inlier_outliers (I1,I2,xy,groundtrue');
    end
    lengthOutliers = length(find(groundtrue==0));
    Outlier_ration = lengthOutliers/length(groundtrue);
    fprintf('All_data_Inlier_ratio= %.4f; All_data_Outlier_ration= %.4f \n',(1-Outlier_ration),Outlier_ration);
    %------------- initialize for ExploopOneDate ------------------
    Each_data_all_error = [];
    Iter_counter_All = [];
    sumrunningTime=0;    
    for ikk=1:ExploopOneDate
        
        timerNum1 = recordRunningTimeEx([], 'start');       
        %== begin for proposed algorithm ===========================================          
        %------ data that satisfies triplet relationship --------
        curData = xy;
        [triple_matches_with_all_data,All_matches_triplet_Scores,Top_rank_triplet_Scores_Index,length_KNN]...
            = B_triplet_relationship(curData,KNN_number);
        %------ data that satisfies triplet relationship --------      
        %------ triplet sampling data -----------------------------------
       [par,res_1,triple_minimal_pinx]  = triplet_guided_sampling(data_normal,All_matches_triplet_Scores,model_type);
      
%         [par,res_1,triple_minimal_pinx]  = triplet_elements_random_sampling ...
%             (triple_matches_with_all_data,Top_rank_triplet_Scores_Index,data_normal,model_type);
%        [par,res_1,triple_minimal_pinx]  =  random_sampling_initial_minimal_subset ...
%             (triple_matches_with_all_data,Top_rank_triplet_Scores_Index,data_normal,model_type);
        %------ triplet sampling data -----------------------------------        
        %------ updating sampling data --------------------------
    [hypothese_2, res_2,refine_minimal_subset,Iter_counter] = Update_triplet_sample_hypothese ...
          (model_type,xy,data_normal,res_1,triple_minimal_pinx',length_KNN,I1,I2,groundtrue,All_matches_triplet_Scores,m_model_size);
        %------ updating sampling data --------------------------
        %------ find the maximum number of inliers --------------
        [ ~, maxinx ] = max(sum(res_2 <=ransac_noise_th)); %% 寻找具有最大内点数的   假设位置  %%暂时res2改res1
        inlierinx = res_2 (:,maxinx)<=ransac_noise_th;%%暂时res2改res1
        %------ find the maximum number of inliers --------------
        %== end for proposed algorithm ===========================================     
        runningTime = recordRunningTimeEx(timerNum1, 'stop'); % runningTime from Start to Stop
     %   fprintf(runtime, '%f\n', runningTime);
        sumrunningTime=sumrunningTime+runningTime;
         jiangwei(res_1,triple_minimal_pinx);%降维程序函数！！！！
        
        if Debug_show_triplet_data  == 1 ;  % show for groundture
            label_triplet = zeros(1,length(groundtrue));
            label_triplet(find(triple_matches_with_all_data)) = 1; % label for the triple data        
   %         Show_matching_line_results_first_version (I1,I2,xy,label_triplet); %（暂时注释掉）
            %------ show_selected_triplet--------------
  %             Show_some_matching_line_on_retinal_images (I1,I2,xy,triple_minimal_pinx);%（暂时注释掉）
% % % %             Show_one_matching_line_on_retinal_images (I1,I2,xy,triple_minimal_pinx(2));
            %------ show_selected_triplet--------------
            % ----------- showing triplet guided matching results ----
            [ ~, maxinx1 ] = max(sum(res_1 <=ransac_noise_th)); %% 寻找具有最大内点数的   假设位置
            inlierinx1 = res_1 (:,maxinx1)<=ransac_noise_th;
            inlierinx1  = double(inlierinx1);
      %   Show_triple_matching_results_retinal_images_all_inlier_outliers (I1,I2,xy,inlierinx1');
      %       Show_triple_matching_results_retinal_images_only_inliers (I1,I2,xy,inlierinx1');
% % %             ------ show registration results -----------------
% % %             ----------- showing triplet guided matching results ----
 %           Show_updated_matching_line_on_retinal_images (I1,I2,xy,refine_minimal_subset);%（暂时注释掉）
            
% % %             ------ show_hyperplane --------------
 %           show_hyperplane_triplet_subset (I1,I2,data_normal,xy,inlierinx1);  %（暂时注释掉） 
  %          show_hyperplane (I1,I2,data_normal,xy,inlierinx);%（暂时注释掉）
            %------ show_hyperplane --------------
            inlierinx  = double(inlierinx);
             Show_matching_line_results_retinal_images_all_inlier_outliers (I1,I2,xy,inlierinx');
        end       
        
       % clusterIndex = label_triplet';
       groundtrue_1_index = find(groundtrue);
        groundtrue(groundtrue_1_index) = 1;
        
        Each_data_1_time_error = segmentationError(groundtrue, inlierinx' )*100;  % 1* 800, 1*800  label_cross'  groundtrue,clusterIndex
        Each_data_1_time_ture = 1-(Each_data_1_time_error/100);
    %    fprintf(pre, '%f\n', Each_data_1_time_ture);  % 将 Each_data_1_time_ture 的值写入文本文件
        Each_data_all_error = [Each_data_all_error  Each_data_1_time_error];      % Save error for the same dataset
    % 暂时    Iter_counter_All   = [Iter_counter_All Iter_counter];
        
    end  % end for the same dataset
 %   Show_updated_matching_line_on_retinal_images (I1,I2,xy,refine_minimal_subset);%（暂时注释掉）
    inlierinx  = double(inlierinx);
%    Show_matching_line_results_retinal_images_all_inlier_outliers (I1,I2,xy,inlierinx');%（暂时注释掉,但论文中有用到）
 %暂时     Show_matching_line_results_retinal_images_all_inlier_outliers_r (I1,I2,xy,inlierinx');%（暂时注释掉,论文中有用到）
        Show_triple_matching_results_retinal_images_only_inliers (I1,I2,xy,inlierinx');
%%%% show triplet     
% Show_matching_results_TIE_column_some_inlier_outlier (I1,I2,xy,groundtrue)%（暂时注释掉）
%  Show_matching_results_TIE_row_some_inlier_outlier (I1,I2,xy,groundtrue)%（暂时注释掉）
%%%% show triplet 
    fprintf('Each_data_all_error-%.3f \n',Each_data_all_error);    
    %-- A mean, for the same dataset -------------------------------------
    AvgTime = sumrunningTime/ExploopOneDate;
    ALL_data_AVGTIME = [ALL_data_AVGTIME AvgTime];
%       %%
% %画框
% ind=find(inlierinx>0);
% zz=ind';%为目标检测选坐标
% zx=xy(1,zz(1,:));
% zy=xy(2,zz(1,:));
%     figure(5) ; clf ;
%         %------------ 图像高度不同时，填白处理 --------------
%      %%  记住仍然保存原始的Ia, Ib，只是显示用Iaa, Ibb. 坐标xy始终保持不变
%    %[Iaa, Ibb] = D_CVPR_Different_image_heigh (I1,I2);  
%     %------------ 图像高度不同时，填白处理 --------------   
%    imagesc(cat(1, I1)) ; 
%    axis off;%去掉坐标值和坐标轴
%    set(gca, 'xtick', [], 'ytick', []);
%  %imagesc(cat(2, Ia, Ib)) ;
%     x_min=min(zx)-10;x_max=max(zx);%x_z=(x_max-x_min)/2+x_min;
%     y_min=min(zy);y_max=max(zy);%y_z=(y_max-y_min)/2+y_min;
%     xL=(x_max-x_min+30);xh=(y_max-y_min);
%     rectangle('position',[x_min,y_min,xL,xh],'edgecolor','r');
%     %保存带有矩形框的图像
%     filename = ['F:\鲁棒模型拟合_Hanlin_TIE&SPL\UAV2Result\aim1\',num2str(dataNum),'.jpg'];
%     % 保存带有矩形框的图像
%      saveas(gcf,filename);
% %%
     fprintf('DataName_TRESAC:%s;\n AvgTime-%.4f;mean-%.4f;std-%.4f;median-%.4f;min-%.4f;Iter_counter= %.2f;ransac_noise_th=%.4f; KNN_number= %d; m_model_size= %d; dataLength=%d; Outlier_ration=%.6f  \n', ...
         packName{1},AvgTime,mean(Each_data_all_error),std(Each_data_all_error),median(Each_data_all_error),min(Each_data_all_error),mean(Iter_counter_All), ransac_noise_th,KNN_number,m_model_size,length(xy),Outlier_ration);
     ALL_data_error = [ALL_data_error mean(Each_data_all_error)];  %  Save error for the different dataset
%  %   close all;
end  % end for the different dataset
fprintf('Mean_ALL_data_error-%.4f \n',mean(ALL_data_error));
fprintf('Mean_ALL_data_AVGTIME-%.4f \n',mean(ALL_data_AVGTIME));
%fclose(pre);
%fclose(runtime);
end

