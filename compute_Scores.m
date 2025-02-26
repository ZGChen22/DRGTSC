function [All_triplet_Scores_a_match_1] = compute_Scores(triple_index,curData)
    triple_matches_coord_P = curData(1:2,triple_index);%提取3元组点横轴坐标

    
    X_J = triple_matches_coord_P(:,1);
    X_I = triple_matches_coord_P(:,2);
    X_K = triple_matches_coord_P(:,3);
    %1.两两计算再相加   弹箭学报用的计算公式
      [Score_X_J_I] = pairwise_score(X_J,X_I);
     [Score_X_J_K] = pairwise_score(X_J,X_K);
      [Score_X_I_K] = pairwise_score(X_I,X_K); 
% 
     All_triplet_Scores_a_match_1 = Score_X_J_I + Score_X_J_K + Score_X_I_K;

    %1.三个加一起
  %  [All_triplet_Scores_a_match] = all_score( X_J,X_I,X_K);
  
    

    %2.直接用第一个点与其他两个点计算得分
     % var =0.28;%标准偏差0.78
     % [All_triplet_Scores_a_match_1] = triple_score( X_J,X_I,X_K,var); %  TRESAC++用的计算公式
end