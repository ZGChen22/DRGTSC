function [theta_f, res_2,f_inx,Iter_counter] = Update_triplet_sample_hypothese_iteration...
    (model_type,xy,data_normal,res_1,inx_1,length_KNN,I1,I2,groundtrue,All_matches_triplet_Scores,m_model_size)
switch model_type
    case 'hyperplane'
        data_normal = [data_normal(1:2,:);data_normal(4:5,:)];
    otherwise
end
[fitfn,resfn,degenfn,psize,numpar,fit_model] = getModelParaXmu(model_type);
k = m_model_size  ; % 20
N_iterations = 50;
BestJ = 1e7;   %%%% 一个子集点对应的残差和
Iter_counter = 0;
stop_type = 'trplet_compatibility_Scores';  %  'TIPresidual' ; trplet_compatibility_Scores ; pairwise_compatibility_Scores
psizeForUpdata = psize;

P_Sub = data_normal(:,inx_1);
while (Iter_counter < N_iterations)
    theta = feval(fitfn,P_Sub);  % Fit the model on the p-subset % 当前的假设
    dist = feval(resfn,theta,data_normal);% Compute residuals.
    
    [SRes,I] = sort(dist); %用来求解当前的 k-th 残差
    pinx = I( (k-psizeForUpdata+1):k ); % Get new tupple around kth sorted residual % 给下次用的index
    P_Sub = data_normal(:,pinx); % 残差很接近的一组点生成假设 % 给下次的新子集
    Jnew = sum( SRes( (k-psizeForUpdata+1):k ) ); % cost function
    if (Jnew < BestJ) % store the best value % 假设质量的判断
        BestJ = Jnew;
        theta_f = theta;
        f_inx = pinx;
    end
    if (Iter_counter ==0) % 初始的子集索引设置
        old_pinx1 = pinx;
        old_pinx = pinx;
    end
    switch stop_type
        case 'TIPresidual'
            dist = feval(resfn,theta,data_normal(:,old_pinx));  %计算L-1次采样的子集 和 当前假设的残差
            dist = mean(dist); % L-1次子集 对应的残差均值
            dist1 = feval(resfn,theta,data_normal(:,old_pinx1)); % %计算L-2次采样的子集 和 当前假设的残差
            dist1 = mean(dist1); % L-2次子集 对应的残差均值
            sd = SRes(k);%the kth residual with respect to current theta
            %%%% 迭代停止判断
            if ( ( sd < dist   ) && ( sd < dist1 )  &&  (Iter_counter > 10))  %%% 原版 sd > dist
                break;
            end
        case 'trplet_compatibility_Scores' % 根据输入的分数 来源于三元集 或者 成对集
            %--------------- the score according to triplet set -----------
            k_res_data  = I(k); % 最新的一个假设  对应的K-th残差的搜引
            [k_Scores] = all_neighbors_score_measure_triplet (k_res_data,All_matches_triplet_Scores);
            [old_pinx_Scores] = neighbors_score_measure_for_old_pinx_triplet (old_pinx,All_matches_triplet_Scores);
            [old_pinx1_Scores] = neighbors_score_measure_for_old_pinx_triplet (old_pinx1,All_matches_triplet_Scores);
            %--------------- the score according to triplet set -----------
            if ( ( k_Scores > old_pinx_Scores   ) && ( k_Scores > old_pinx1_Scores )  &&  (Iter_counter > 6))  %%% 原版 sd > dist
                break;
            end
% % %         case 'pairwise_compatibility_Scores'
% % %             k_res_data  = I(k); % 最新的一个假设  对应的K-th残差的搜引
% % %             k_data_NN = length_KNN(k_res_data,:);
% % %             k_data_NN_ind = (find(k_data_NN~=0));
% % %             tr_k_data_NN = k_data_NN(k_data_NN_ind);
% % %             if length(tr_k_data_NN) == 1
% % %                 k_Scores = 0;
% % %             else
% % %                 [k_Scores] = all_neighbors_score_measure (xy,tr_k_data_NN);
% % %                 [old_pinx_Scores] = neighbors_score_measure_for_old_pinx (old_pinx,xy,length_KNN);
% % %                 [old_pinx1_Scores] = neighbors_score_measure_for_old_pinx (old_pinx1,xy,length_KNN);
% % %             end
% % %             if ( ( k_Scores > old_pinx_Scores   ) && ( k_Scores > old_pinx1_Scores )  &&  (Iter_counter > 6))  %%% 原版 sd > dist
% % %                 break;
% % %             end
    end
    old_pinx1 = old_pinx;
    old_pinx = pinx;
    Iter_counter = Iter_counter + 1;
    %         Show_updated_matching_line_on_retinal_images (I1,I2,xy,f_inx);
    res_2 = feval(resfn,theta_f,data_normal);  %      Iter_counter
end %%% 迭代准则处

end


