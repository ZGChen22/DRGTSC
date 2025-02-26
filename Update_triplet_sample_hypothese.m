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
BestJ = 1e7;   %%%% һ���Ӽ����Ӧ�Ĳв��
Iter_counter = 0;
stop_type = 'trplet_compatibility_Scores';  %  'TIPresidual' ; trplet_compatibility_Scores ; pairwise_compatibility_Scores
psizeForUpdata = psize;

P_Sub = data_normal(:,inx_1);
while (Iter_counter < N_iterations)
    theta = feval(fitfn,P_Sub);  % Fit the model on the p-subset % ��ǰ�ļ���
    dist = feval(resfn,theta,data_normal);% Compute residuals.
    
    [SRes,I] = sort(dist); %������⵱ǰ�� k-th �в�
    pinx = I( (k-psizeForUpdata+1):k ); % Get new tupple around kth sorted residual % ���´��õ�index
    P_Sub = data_normal(:,pinx); % �в�ܽӽ���һ������ɼ��� % ���´ε����Ӽ�
    Jnew = sum( SRes( (k-psizeForUpdata+1):k ) ); % cost function
    if (Jnew < BestJ) % store the best value % �����������ж�
        BestJ = Jnew;
        theta_f = theta;
        f_inx = pinx;
    end
    if (Iter_counter ==0) % ��ʼ���Ӽ���������
        old_pinx1 = pinx;
        old_pinx = pinx;
    end
    switch stop_type
        case 'TIPresidual'
            dist = feval(resfn,theta,data_normal(:,old_pinx));  %����L-1�β������Ӽ� �� ��ǰ����Ĳв�
            dist = mean(dist); % L-1���Ӽ� ��Ӧ�Ĳв��ֵ
            dist1 = feval(resfn,theta,data_normal(:,old_pinx1)); % %����L-2�β������Ӽ� �� ��ǰ����Ĳв�
            dist1 = mean(dist1); % L-2���Ӽ� ��Ӧ�Ĳв��ֵ
            sd = SRes(k);%the kth residual with respect to current theta
            %%%% ����ֹͣ�ж�
            if ( ( sd < dist   ) && ( sd < dist1 )  &&  (Iter_counter > 10))  %%% ԭ�� sd > dist
                break;
            end
        case 'trplet_compatibility_Scores' % ��������ķ��� ��Դ����Ԫ�� ���� �ɶԼ�
            %--------------- the score according to triplet set -----------
            k_res_data  = I(k); % ���µ�һ������  ��Ӧ��K-th�в������
            [k_Scores] = all_neighbors_score_measure_triplet (k_res_data,All_matches_triplet_Scores);
            [old_pinx_Scores] = neighbors_score_measure_for_old_pinx_triplet (old_pinx,All_matches_triplet_Scores);
            [old_pinx1_Scores] = neighbors_score_measure_for_old_pinx_triplet (old_pinx1,All_matches_triplet_Scores);
            %--------------- the score according to triplet set -----------
            if ( ( k_Scores > old_pinx_Scores   ) && ( k_Scores > old_pinx1_Scores )  &&  (Iter_counter > 6))  %%% ԭ�� sd > dist
                break;
            end
% % %         case 'pairwise_compatibility_Scores'
% % %             k_res_data  = I(k); % ���µ�һ������  ��Ӧ��K-th�в������
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
% % %             if ( ( k_Scores > old_pinx_Scores   ) && ( k_Scores > old_pinx1_Scores )  &&  (Iter_counter > 6))  %%% ԭ�� sd > dist
% % %                 break;
% % %             end
    end
    old_pinx1 = old_pinx;
    old_pinx = pinx;
    Iter_counter = Iter_counter + 1;
    %         Show_updated_matching_line_on_retinal_images (I1,I2,xy,f_inx);
    res_2 = feval(resfn,theta_f,data_normal);  %      Iter_counter
end %%% ����׼��

end


