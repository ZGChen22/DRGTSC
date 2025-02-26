function [All_triplet_Scores_a_match_1] = triple_score( X_J,X_I,X_K,var)
  P_j = X_J(1:2) ;
  P_i = X_I(1:2) ;
  P_k = X_K(1:2) ;
  %Normalization_constants = nc;
     m_P_j = P_j(1);%第一个点的横坐标
     n_P_j = P_j(2);%第一个点的纵坐标
     m_P_i = P_i(1);%第二个点的横坐标
     n_P_i = P_i(2);%第二个点的纵坐标
     m_P_k = P_k(1);%第三个点的横坐标
     n_P_k = P_k(2);%第三个点的纵坐标
     
    L_ij = sqrt( (m_P_i - m_P_j)^2 + (n_P_i - n_P_j)^2 );
    L_ik = sqrt( (m_P_i - m_P_k)^2 + (n_P_i - n_P_k)^2 );
   % L_jk = sqrt( (m_P_j - m_P_k)^2 + (n_P_j - n_P_k)^2 );
   % x_mean = (m_P_i+m_P_j+m_P_k)/3;
  %  y_mean = (n_P_i+n_P_j+n_P_k)/3;
%    var_x = ((m_P_i-x_mean)^2+(m_P_j-x_mean)^2+(m_P_k-x_mean)^2)/3;%方差
%    var_y = ((n_P_i-y_mean)^2+(n_P_j-y_mean)^2+(n_P_k-y_mean)^2)/3;%方差
 %   var = (var_x+var_y)/2;
  %  Normalization_constants = 
   % Score_X_J_I = 1/Normalization_constants*exp( (-(L_ij )^2 -(L_ik )^2)/var);
    Score_X_J_I = exp( (-(L_ij )^2 -(L_ik )^2)/var^2);
  All_triplet_Scores_a_match_1 = Score_X_J_I;
   
end

