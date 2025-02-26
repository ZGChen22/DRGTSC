  clear all;
  close all;
  %文件数据写入
  %CIAP
%   pre = fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\DanJianXueBao\CIAP\pre.txt', 'w');
%  rec =fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\DanJianXueBao\CIAP\re.txt', 'w');
%  f_s = fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\DanJianXueBao\CIAP\fs.txt', 'w');
%  runtime =fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\DanJianXueBao\CIAP\runtime.txt', 'w');
  
%FE
%  pre = fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\TRESAC++\FE\pre.txt', 'w');
%  rec =fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\TRESAC++\FE\re.txt', 'w');
%  f_s = fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\TRESAC++\FE\fs.txt', 'w');
%  runtime =fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\TRESAC++\FE\runtime.txt', 'w');

%UAV
%  pre = fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\TRESAC++\UAV\pre.txt', 'w');
%  rec =fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\TRESAC++\UAV\re.txt', 'w');
%  f_s = fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\TRESAC++\UAV\fs.txt', 'w');
% runtime =fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\TRESAC++\UAV\runtime1.txt', 'w');

%PAN
%   pre = fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\DanJianXueBao\PAN\pre.txt', 'w');
%  rec =fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\DanJianXueBao\PAN\re.txt', 'w');
%  f_s = fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\DanJianXueBao\PAN\fs.txt', 'w');
%  runtime =fopen('D:\TezhenPipei\TezhenPipei\7_2019RFM-SCAN-master\YAOyx_data_result\DanJianXueBao\PAN\runtime.txt', 'w');
  %%数据集导入
  file_namesdataset={'BostonLibA','physics','road','images55a'};
     %  dataNum = 2;
file_namesUAV1Result={'1','2','3','4','6','7','8','9','10','12','13','14','15','16','17','18','19','20',...%18
    '22','23','24','25','26','27','28','29','30','31','33','34','35','36','37','38','39','40',...%36
     '41','42','43','44','45','46','48','49','50','51','52','53','54','55','56','57','58','59','60',...%55
     '61','62','63','64','65','66','67','68','69','70','71','72','73','74','75','76','77','78','79',...%74
     '81','82','84','85','86','87','88','89','90','95','98','99','F3','feijiZhui2'};%11,21,32,47,,要加上91.93.94.96.97   %87
file_namesUAV1Result_desktop={'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20',...%18
    '21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40',...%36
     '41','42','43','44','45','46','47','48','49','50','51','52','53','54','55','56','57','58','59','60',...%55
     '61','62','63','64','65','66','67','68','69','70','71','72','73','74','75','76','77','78','79','80',...%74
     '81','82','83','84','85','86'};
% file_namesUAV1Result={'1','2','3','4','5','6','7','8','9','10','12','13','14','15','16','17','18','19','20',...
%     '22','23','24','25','26','27','28','29','30','31','33','34','35','36','37','38','39','40',...
%      '41','42','43','44','45','46','48','49','50','51','52','53','54','55','56','57','58','59','60',...
%      '61','62','63','64','65','66','67','68','69','70','71','72','73','74','75','76','77','78','79','80',...
%      '81','82','83','84','85','86','87','88','89','90','91','92','93','94','95','96','97','98','99','F3'};%11,21,32,47
%  file_namesH={'unihouse','bonython','physics','unionhouse','elderhalla','hartley','library','sene',... % 8
%     'nese','ladysymon','oldclassicswing','neem','napiera','barrsmith',... % 14
%     'elderhallb','napierb','johnsona','bonhall','johnsonb','mc1','mc3','raglan'};%22
file_namesH={'bonython','physics','unionhouse','elderhalla','hartley','library','sene',... % 7
    'nese','ladysymon','oldclassicswing','neem','napiera','barrsmith',... % 13
    'elderhallb','napierb','johnsona','unihouse','bonhall','johnsonb','mc1','mc3','raglan'}; % 22  BostonA  BostonLibA  BrusselsA cityA  ExtremeZoomA
file_namesF={'cube','breadcartoychips','biscuit','book','cube','game', 'cubechips','cubetoy','breadcube',... %7
    'gamebiscuit','breadtoy','breadtoycar','biscuitbook','biscuitbookbox','breadcubechips',...%13
    'cubebreadtoychips','breadcartoychips','carchipscube','toycubecar','boardgame','dinobooks'}; %19  21 用1，3，4，5，
file_namesnew_car_data={'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20',...
    '21','22','23','24','25','26','27','28','29','30','31','32','33','34','35'};
     file_namesnew_car_data_test={'2','7','8','11','12'};
% pre = fopen('F:\鲁棒模型拟合_Hanlin_TIE&SPL\UAV1Result\降维TRESAC新公式\pre.txt', 'w');
% runtime =fopen('F:\鲁棒模型拟合_Hanlin_TIE&SPL\UAV1Result\降维TRESAC新公式\runtime.txt', 'w');
 %pre = fopen('C:\Users\62349\Desktop\三元论文部分结果合集\新数据集结果\TRESAC++\pre.txt', 'w');
% runtime =fopen('C:\Users\62349\Desktop\三元论文部分结果合集\新数据集结果\TRESAC++\runtime.txt', 'w');
file_namesCIAP2xmut={'xmut120_1.5','xmut121_1.5','xmut122_1.5','xmut123_1.5','xmut124_1.5','xmut125_1.5','xmut127_1.5','xmut128_1.5','xmut129_1.5','xmut130_1.5',...
    'xmut131_1.5','xmut132_1.5','xmut133_1.5','xmut134_1.5','xmut135_1.5','xmut136_1.5','xmut137_1.5','xmut138_1.5','xmut139_1.5','xmut140_1.5',...
    'xmut141_1.5','xmut142_1.5','xmut143_1.5','xmut145_1.5','xmut146_1.5','xmut147_1.5','xmut148_1.5','xmut149_1.5','xmut150_1.5','xmut151_1.5',...
    'xmut152_1.5','xmut153_1.5','xmut154_1.5','xmut155_1.5','xmut156_1.5','xmut157_1.5','xmut158_1.5','xmut159_1.5',...%38
    'xmut120','xmut123','xmut124','xmut125','xmut127','xmut128','xmut130','xmut131','xmut132','xmut133','xmut134','xmut135','xmut136','xmut137','xmut149','xmut159'}; % 54
file_namesFE2xmut={'xmut_ErrorImagUniversity0_5_0_9','xmut_ErrorImagUniversity1_0_1_4','xmut_ErrorImagUniversity2_10_2_14','xmut_ErrorImagUniversity3_0_3_4','xmut_ErrorImagUrban_200_215','xmut_ErrorImagUrban_200_230','xmut_ErrorImagUrban_200_260',... % 7
    'xmut_ErrorImagUrban_260_265','xmut_ErrorImagUrban_260_270','xmut_ErrorImagUrban_360_365','xmut_ErrorImagUrban_360_370','xmut_ErrorImagUrban_800_810','xmut_ErrorImagUrban_800_820',...%13
    'xmutFE_pair1','xmutFE_pair1new','xmutFE_pair2','xmutFE_pair2new','xmutUniversity0_5_0_9'}; % 18
file_namesUAV2xmut={'xmut1_1.5','xmut2_1.5','xmut3_1.5','xmut4_1.5','xmut5_1.5','xmut6_1.5','xmut7_1.5','xmut8_1.5','xmut9_1.5','xmut10_1.5',... % 10
    'xmut11_1.5','xmut12_1.5','xmut13_1.5','xmut14_1.5','xmut15_1.5','xmut16_1.5','xmut17_1.5','xmut18_1.5','xmut20_1.5','xmut21_1.5',...%20
    'xmut22_1.5','xmut23_1.5','xmut24_1.5','xmut25_1.5','xmut26_1.5','xmut2','xmut3','xmut4','xmut6','xmut7',...%30
    'xmut10','xmut11','xmut19','xmut21','xmut23','xmut25','xmut26','xmut27','xmut29','xmut32','xmut35'}; % 41
file_namesPAN2xmut={'xmut80_1.5','xmut81_1.5','xmut82_1.5','xmut83_1.5','xmut84_1.5','xmut85_1.5','xmut86_1.5','xmut87_1.5','xmut88_1.5','xmut90_1.5',...%10
    'xmut100_1.5','xmut101_1.5','xmut102_1.5','xmut103_1.5','xmut104_1.5','xmut105_1.5','xmut106_1.5','xmut107_1.5','xmut108_1.5','xmut109_1.5','xmut110_1.5',...%21
    'xmut80','xmut83','xmut85','xmut86','xmut87','xmut88','xmut90','xmut101','xmut102','xmut103','xmut105','xmut110'};%33
 av_pr=[];av_rec=[];av_fs=[];
 ALL_data_error = [];
 TIMES_ALL_data_error = [];
 ALL_data_AVGTIME=[];  
 TIMES_ALL_data_AVGTIME=[]; 
 IOU =[];all_Outlier_ration=[];
 ExploopOneDate =  1 ; 
 K=3;%取K个近邻点来判断是否能组成三元  5 car 3 CIAP 3  UAV 3   FE 4 PAN 4 
length_KNN = 0;
m_model_size =25; %模型最小点数  20，目标检测11  F3 20   car 5 CIAP 25 UAV 31   FE 33 PAN27
ransac_noise_th = 0.01;%ransac的阈值   0.141 目标检测0.05 0.032 F3 0.031  car 0.02 CIAP 0.005   UAV 0.172  FE 0.15  PAN 0.07
sumrunningTime=0; 
Debug_show_triplet_data = 1 ;
 for dataNum =4:4%11:72  1：87
 %%数据集打包
    packName = file_namesdataset(dataNum);
    pack = load([packName{1},'.mat']);
    [xy,I1,I2,data_normal,groundtrue] = D_CVPR_data_process_F_H (pack);%读取通过特征提取后的数据集mat的内部数据，并将数据分开命名，xy为坐标，I1,I2为图像对，groundtrue为数据标签（1为内点，0为离群点）
 %%初始化
%       figure('name','LeftImage','position',[300 200 900 333]); set(gca,'Position',[0 0 1 1]);
%     imshow(I1);
%       figure('name','RightImage','position',[300 200 900 333]); set(gca,'Position',[0 0 1 1]);
%       imshow(I2);
     
 %  figure (3);
    data0 = xy; 
    data0([3, 6],:) = []; %=imag_1 去除第3维和第6位数的坐标，而不是3:6的坐标
    data0 = data0'; 
    %%开始计时，recordRunningTimeEx为计时函数，start开始，stop结束
timerNum1 = recordRunningTimeEx([], 'start');
% 使用 SVD 进行降维
[U, S, V] = svd(data0 - mean(data0, 1), 'econ'); % 对数据进行中心化后做 SVD
X_svd = U(:, 1:2) * S(1:2, 1:2); % 取前两个奇异值对应的成分，降到2维
    x = X_svd(:,1);
    y = X_svd(:,2); 
     curX=[x y groundtrue'];%降维后的数据集，x,y为降维后的坐标，groundtrue为标签，用于后续验证算法是否正确区分内点和离群点
%% 添加网格线
% axis on;
% grid on;
%拟合类型选择
model_type = 'affspace_All';   %% affspace_All   fundamental8  hyperplane超平面 homography单应矩阵
[fitfn,resfn,degenfn,psize,numpar,fit_model] = getModelParaXmu(model_type); 
%%显示图像的离群率
    lengthOutliers = length(find(groundtrue==0));
    Outlier_ration = lengthOutliers/length(groundtrue);
    all_Outlier_ration = [all_Outlier_ration Outlier_ration];
    fprintf('All_data_Inlier_ratio= %.4f; All_data_Outlier_ration= %.4f \n',(1-Outlier_ration),Outlier_ration);
% %--KNN for each featuer point about each match--

%%算法主要步骤：
curData=curX';
X_view_1 =  curData(1:2,:);
before_Each_data_all_error = [];
    for ikk=1:ExploopOneDate
%%开始计时，计算

kdtreeX = vl_kdtreebuild(X_view_1); 
[neighborX,~] = vl_kdtreequery(kdtreeX, X_view_1, X_view_1, 'NumNeighbors', K+1) ;%查询X_view_1中每个点的K+1个最近邻，K+1表示查询K个最近邻（排除自身）。
 neighborIndexKDX = neighborX';  % Data index+neighborhood indices 每个点和它距离最近的5个点
  %--X_KNN_matrix---------------------------------
    X_KNN_Matrix = zeros(max(size(curData)));
    for i=1:max(size(curData))
        for j = 2 : K
            if neighborIndexKDX(i,j)~= 0 % neighborIndexKD
                X_KNN_Matrix(i,neighborIndexKDX(i,j)) = 1; %its element is 1,if they are neighbors  设置了一个nXn的矩阵，将每个点和其最近的4个点标1，其他为0；
            end
        end
    end
   % %--Find the matches that satisfy triplet relationship-- 
    [Save_triplet_X] = find_triplet_of_each_point(curData,X_KNN_Matrix);%有三元关系的点
%%%
    %--whether the other point of a match satisfy triplet relationship--
    triple_matches_with_all_data = zeros(max(size(curData)),1) ;
    Save_all_matches_triplet_Scores = cell(length(curData),1);
    for m_data = 1:length(curData) % judging for each point from Y
        Normalization_constants = 0;%归一化量
        triplet_Scores_of_a_match = []; %一个点的所有triplet 分数
        if  ~isempty(Save_triplet_X{m_data,1})
           triplet_X_One_point = Save_triplet_X{m_data,1};
           number_of_triplet = length(triplet_X_One_point)/3; % number of triplet   即有几个三元组
           triple_matches = [];
           while ~isempty(triplet_X_One_point) % having triple
               A_triplet_X = triplet_X_One_point(1:3);
               triple_index = A_triplet_X;%取一组三元组
               triple_matches = triple_index(1);%该三元组对应的主元素
               %[triple_matches,triple_index] = judging_triplet_for_other_point_Y...
              % (A_triplet_X,Y_KNN_Matrix); % find triple_data_matches
    %            triple_matches_with_all_data (m_data,1) =  triple_matches ;   
               if triple_matches~=0; % 取出triplet 的索引号
                   triple_matches_with_all_data (m_data,1) =  triple_matches ;
                   [One_triplet_Scores] = compute_Scores(triple_index,curData);%curData为2 X m的数据集，2为横轴坐标，m为点个数
                  %  break; 
               else
                   One_triplet_Scores = 0 ;
               end
               Normalization_constants = Normalization_constants + One_triplet_Scores;%归一化量计算
               [triplet_Scores_of_a_match] = [triplet_Scores_of_a_match One_triplet_Scores];
               if number_of_triplet == 1 % 判断是否用完triplet
                  break;
               else
                   triplet_X_One_point(1:3)  = []; % 取出所有的Triplet，即去掉用过的三元组
                   number_of_triplet = number_of_triplet-1;
               end         
           end % 找完了一个点  的所有triplet元素
           Save_all_matches_triplet_Scores{m_data,1} = triplet_Scores_of_a_match;
        else
           Save_all_matches_triplet_Scores{m_data,1} = 0 ; % 没有triplet 关系，score为0  eps
        end   
           if Normalization_constants ~= 0   
    Save_all_matches_triplet_Scores{m_data,1} = Normalization_constants*Save_all_matches_triplet_Scores{m_data,1};%乘上归一化量，得最后得计算得分
           end
    end
    %--whether the other point of a match satisfy triplet relationship-- 
    New_all_matches_triplet_Scores = zeros(length(curData),1);
    for i = 1 : length(curData)
      New_all_matches_triplet_Scores(i)= max(Save_all_matches_triplet_Scores{i,1});
    end
    [Sorted_matches_triplet_Scores,triplet_Scores_Index] = sort(New_all_matches_triplet_Scores,'descend');
    Top_rank_triplet_Scores_Index = triplet_Scores_Index(1:6);%%抽取前几个作为子集，默认设置1：5（5个）   PAN 6个
%%模型抽样
[par,res_1,triple_minimal_pinx]  = the_4_th_point(data_normal,Top_rank_triplet_Scores_Index,model_type);%直接用前5个
%[par,res_1,triple_minimal_pinx]  = triplet_guided_sampling(data_normal,New_all_matches_triplet_Scores,model_type);%原来使用的三元随机抽样函数
 All_matches_triplet_Scores = New_all_matches_triplet_Scores;
 [hypothese_2, res_2,refine_minimal_subset,Iter_counter] = Update_triplet_sample_hypothese ...
          (model_type,xy,data_normal,res_1,triple_minimal_pinx',length_KNN,I1,I2,groundtrue,All_matches_triplet_Scores,m_model_size);%迭代更新策略
  %------ find the maximum number of inliers --------------
        [ ~, maxinx ] = max(sum(res_2 <=ransac_noise_th)); %% 寻找具有最大内点数的   假设位置
   inlierinx = res_2 (:,maxinx)<=ransac_noise_th;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
      runningTime = recordRunningTimeEx(timerNum1, 'stop'); % 计时结束，输入运行时间 runningTime
     %  fprintf(runtime, '%f\n', runningTime);
        %sumrunningTime=sumrunningTime+runningTime;
        
        
        if Debug_show_triplet_data  == 1 ;  % show for groundture
            label_triplet = zeros(1,length(groundtrue));
            label_triplet(find(triple_matches_with_all_data)) = 1; % label for the triple data   
              % ----------- showing triplet guided matching results ----
            [ ~, maxinx1 ] = max(sum(res_1 <=ransac_noise_th)); %% 寻找具有最大内点数的   假设位置
            inlierinx1 = res_1 (:,maxinx1)<=ransac_noise_th;
            inlierinx1  = double(inlierinx1);
            %------ show_hyperplane --------------
            inlierinx  = double(inlierinx);
            Show_triple_matching_results_retinal_images_all_inlier_outliers (I1,I2,xy,inlierinx1');
          %   Show_triple_matching_results_retinal_images_only_inliers (I1,I2,xy,inlierinx1');
            end       
        
       % clusterIndex = label_triplet';
       groundtrue_1_index = find(groundtrue);
        groundtrue(groundtrue_1_index) = 1;
        %细化前的错误率
         before_Each_data_1_time_error = segmentationError(groundtrue, inlierinx1' )*100;  % 1* 800, 1*800  label_cross'  groundtrue,clusterIndex
 %       before_Each_data_1_time_ture = 1-(before_Each_data_1_time_error/100);
        before_Each_data_all_error = [before_Each_data_all_error  before_Each_data_1_time_error];  
        
        %细化策略后的错误率
        Each_data_1_time_error = segmentationError(groundtrue, inlierinx' )*100;  % 1* 800, 1*800  label_cross'  groundtrue,clusterIndex
        Each_data_1_time_ture = 1-(Each_data_1_time_error/100);
    %    fprintf(pre, '%f\n', Each_data_1_time_ture);  % 将 Each_data_1_time_ture 的值写入文本文件
        Each_data_all_error = [];
        Each_data_all_error = [Each_data_all_error  Each_data_1_time_error];      % Save error for the same dataset
    % 暂时    Iter_counter_All   = [Iter_counter_All Iter_counter];
    end
   % end for the same dataset
 %   Show_updated_matching_line_on_retinal_images (I1,I2,xy,refine_minimal_subset);%（暂时注释掉）
    inlierinx  = double(inlierinx);
 %   Show_matching_line_results_retinal_images_all_inlier_outliers (I1,I2,xy,inlierinx');%（暂时注释掉,但论文中有用到）
 %   Show_matching_line_results_retinal_images_all_inlier_outliers_r (I1,I2,xy,inlierinx');%（暂时注释掉,论文中有用到）
 %  Show_triple_matching_results_TP_TN_FN_FP(I1,I2,xy,groundtrue,inlierinx);%分类
 %  TRESACplus_Display_of_dimensionality_reduction_data(curX,inlierinx);%降维数据显示
  %        Show_triple_matching_results_retinal_images_only_inliers (I1,I2,xy,inlierinx');
%%%% show triplet     
 %Show_matching_results_TIE_column_some_inlier_outlier (I1,I2,xy,groundtrue)%（暂时注释掉）
 % Show_matching_results_TIE_row_some_inlier_outlier (I1,I2,xy,groundtrue)%（暂时注释掉）
%%%% show triplet 
    fprintf('before_Each_data_all_error-%.3f \n',before_Each_data_all_error);  
    fprintf('Each_data_all_error-%.3f \n',Each_data_all_error);    
    %-- A mean, for the same dataset -------------------------------------
  %  AvgTime = sumrunningTime/ExploopOneDate;
    ALL_data_AVGTIME = [ALL_data_AVGTIME runningTime];
%画框
% 
%     %------------ 图像高度不同时，填白处理 --------------
%  [Iaa, Ibb] = D_CVPR_Different_image_heigh (I1,I2);  %%  记住仍然保存原始的Ia, Ib，只是显示用Iaa, Ibb. 坐标xy始终保持不变
%     %------------ 图像高度不同时，填白处理 --------------    
ind=find(inlierinx>0);%inlierinx 加了精细搜索策略；inlierinx1 未加精细搜索策略
% zz=ind';%为目标检测选坐标
% zx=xy(1,zz(1,:));
% zy=xy(2,zz(1,:));
%     figure(4) ; clf ;
%    imagesc(cat(1, I1)) ; 
%    axis off;%去掉坐标值和坐标轴
%    set(gca, 'xtick', [], 'ytick', []);
%   % imagesc(cat(2, Iaa, Ibb)) ; 
%     x_min=min(zx);x_max=max(zx);%x_z=(x_max-x_min)/2+x_min;
%     y_min=min(zy);y_max=max(zy);%y_z=(y_max-y_min)/2+y_min;
%     xL=(x_max-x_min);xh=(y_max-y_min);
%     rectangle('position',[x_min,y_min,xL,xh],'edgecolor','r');
% % % %         %保存带有矩形框的图像
%     filename = ['C:\Users\62349\Desktop\三元论文部分结果合集\新数据集结果\TRESAC++\',num2str(dataNum),'.jpg'];
% %     % 保存带有矩形框的图像
  %   saveas(gcf,filename);
% %%
%计算IOU
% hold on;
% ture = groundtrue_1_index;%标签索引
% ture_x=xy(1,ture(1,:));%标签x轴
% ture_y=xy(2,ture(1,:));%标签y轴
%    axis off;%去掉坐标值和坐标轴
%    set(gca, 'xtick', [], 'ytick', []);
%     x_min1=min(ture_x);x_max1=max(ture_x);%x_z=(x_max-x_min)/2+x_min;
%     y_min1=min(ture_y);y_max1=max(ture_y);%y_z=(y_max-y_min)/2+y_min;
%     xL1=(x_max1-x_min1);xh1=(y_max1-y_min1);
%     rectangle('position',[x_min1,y_min1,xL1,xh1],'edgecolor','g');
%     x_inter1 = max(x_min,x_min1);x_inter2 = min(x_max,x_max1);
%     y_inter1 = max(y_min,y_min1);y_inter2 = min(y_max,y_max1);
%  width_inter = abs(x_inter2-x_inter1);
%  height_inter = abs(y_inter2 - y_inter1);
%  area_inter = width_inter * height_inter;
%  area_box1 = xL * xh;
%  area_box2 = xL1 * xh1;
%  area_union = area_box1 + area_box2 - area_inter ;
%  iou = area_inter /area_union;
%  fprintf('IOU = %.4f\n',iou);
%  IOU = [IOU iou];
%  IOU1= IOU';
%%
   % fprintf('DataName_TRESAC:%s;\n AvgTime-%.4f;mean-%.4f;std-%.4f;median-%.4f;min-%.4f;ransac_noise_th=%.4f; K = %d; m_model_size= %d; dataLength=%d; Outlier_ration=%.6f  \n', ...
  %   packName{1},runningTime,mean(Each_data_all_error),std(Each_data_all_error),median(Each_data_all_error),min(Each_data_all_error), ransac_noise_th,K,m_model_size,length(xy),Outlier_ration);
     ALL_data_error = [ALL_data_error mean(Each_data_all_error)];
     fprintf('Mean_ALL_data_error-%.4f \n',mean(ALL_data_error));
mean(ALL_data_AVGTIME)
TIMES_ALL_data_error = [TIMES_ALL_data_error mean(ALL_data_error)];
%TIMES_ALL_data_AVGTIME = [TIMES_ALL_data_AVGTIME mean(ALL_data_AVGTIME)];

%%
%计算指标pre,re,fs
    %pre reacll f-score
    CorrectInd=find(groundtrue>0); 
    CorrectInd = CorrectInd';
    pr  = length(intersect(ind,CorrectInd'))/length(ind);
    re  = length(intersect(ind,CorrectInd))/length(CorrectInd);
    f_1 = 2*pr*re/(pr+re);
  %%
  %写入文件
%  fprintf(pre, '%f\n', pr);  fprintf(rec, '%f\n', re); fprintf(f_s, '%f\n', f_1); 
%    fprintf(runtime, '%f\n', runningTime);
  %%
    av_pr=[av_pr pr];av_rec=[av_rec re];av_fs=[av_fs f_1];
 end

%  fprintf('平均错误-%.4f \n',mean(TIMES_ALL_data_error));
%  fprintf('平均时间-%.4f \n',mean(ALL_data_AVGTIME));
%  fprintf('max_outliers-%.4f \n',max(all_Outlier_ration));
%  fprintf('min_outliers-%.4f \n',min(all_Outlier_ration));
%  fprintf('mean_outliers-%.4f \n',mean(all_Outlier_ration));
%fprintf('iou-%.4f \n',IOU);
%计算一个数据集的平均指标pre,re,fs
      Av_pr = mean(av_pr)
     Av_re = mean(av_rec)
     Av_fs = mean(av_fs)
  % fprintf('Av_pr=%f Av_re=%f Av_fs=%f\n', Av_pr,Av_re,Av_fs);
%  fclose(pre);fclose(rec); fclose(f_s);
%  fclose(runtime);