function [All_triplet_Scores_a_match] = all_score( X_J,X_I,X_K)
  P_j = X_J(1:2) ;
  P_i = X_I(1:2) ;
  P_k = X_K(1:2) ;
  
     m_P_j = P_j(1);%��һ����ĺ�����
     n_P_j = P_j(2);%��һ�����������
     m_P_i = P_i(1);%�ڶ�����ĺ�����
     n_P_i = P_i(2);%�ڶ������������
     m_P_k = P_k(1);%��������ĺ�����
     n_P_k = P_k(2);%���������������
     
     L_ij = sqrt( (m_P_i - m_P_j)^2 + (n_P_i - n_P_j)^2 );
     L_ik = sqrt( (m_P_i - m_P_k)^2 + (n_P_i - n_P_k)^2 );
     L_jk = sqrt( (m_P_j - m_P_k)^2 + (n_P_j - n_P_k)^2 );
     All_triplet_Scores_a_match = exp(-(L_ij+L_ik+L_jk));
end

