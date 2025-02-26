function  [Score_X_J_I] = pairwise_score(X_J,X_I)
% X_J = (P_j,P_jj)   X_I = (P_i,P_ii)
% P_j = (m_P_j,n_P_j)
     P_j = X_J(1:2) ;
    % P_jj = X_J(3:4) ;
     
     P_i = X_I(1:2) ;
  %   P_ii = X_I(3:4) ;
     
     m_P_j = P_j(1);%第一个点的横坐标
     n_P_j = P_j(2);%第一个点的纵坐标
     m_P_i = P_i(1);%第二个点的横坐标
     n_P_i = P_i(2);%第二个点的纵坐标
     L_ij = sqrt( (m_P_j - m_P_i)^2 + (n_P_j - n_P_i)^2 );
     
%      m_P_jj = P_jj(1);
%      n_P_jj = P_jj(2);
%      m_P_ii = P_ii(1);
%      n_P_ii = P_ii(2);
     
   %  L_iijj = sqrt( (m_P_jj - m_P_ii)^2 + (n_P_jj - n_P_ii)^2 );
      Score_X_J_I = exp( -(L_ij ) );
%     Score_X_J_I = exp( -(L_ij )^2 );
     

end