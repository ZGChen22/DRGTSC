function [All_triplet_Scores_a_match_1] = compute_Scores(triple_index,curData)
    triple_matches_coord_P = curData(1:2,triple_index);%��ȡ3Ԫ����������

    
    X_J = triple_matches_coord_P(:,1);
    X_I = triple_matches_coord_P(:,2);
    X_K = triple_matches_coord_P(:,3);
    %1.�������������   ����ѧ���õļ��㹫ʽ
      [Score_X_J_I] = pairwise_score(X_J,X_I);
     [Score_X_J_K] = pairwise_score(X_J,X_K);
      [Score_X_I_K] = pairwise_score(X_I,X_K); 
% 
     All_triplet_Scores_a_match_1 = Score_X_J_I + Score_X_J_K + Score_X_I_K;

    %1.������һ��
  %  [All_triplet_Scores_a_match] = all_score( X_J,X_I,X_K);
  
    

    %2.ֱ���õ�һ�������������������÷�
     % var =0.28;%��׼ƫ��0.78
     % [All_triplet_Scores_a_match_1] = triple_score( X_J,X_I,X_K,var); %  TRESAC++�õļ��㹫ʽ
end