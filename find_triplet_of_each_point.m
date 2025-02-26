function  [Save_triplet] = find_triplet_of_each_point(curData,X_KNN_Matrix)
%--Find the matches that satisfy triplet relationship-- 
Data_index_vector = [1:1:length(curData)];
Data_index_vector = Data_index_vector';
triplet_point_all = [];
Save_triplet = cell(length(curData),1);
for m = 1:length(curData) % finding triplet for each point
    X_j = Data_index_vector(m);
    N_X_j = find(X_KNN_Matrix(X_j,:)); % neighbors of X_j,namely, all X_i
    X_i  = N_X_j(2); %%%%%%%%%%%%%%% consider first neighbor as X_i
    % find neighbors of X_i
    N_X_i = find(X_KNN_Matrix(X_i,:)); 
    if find(N_X_i==X_j)
        [N_X_i_index] = find(N_X_i~=X_j); % X_j belong to N_X_i,removing corresponding X_j
        New_N_X_i = N_X_i(N_X_i_index); % one of X_k
    else
        New_N_X_i = N_X_i;
    end
    Maybe_X_k = New_N_X_i; 
    X_k_all = [];
    for n = 1:length(Maybe_X_k)
       X_k_1 = Maybe_X_k(n);
       N_X_k = find(X_KNN_Matrix(X_k_1,:));
       if find(N_X_k == X_j)
          X_k_all = [X_k_all X_k_1];
       end
    end
    %--save triplet for each point--------------
    if  ~isempty(X_k_all) % having the value X_k
        All_Triplet_of_a_point = [];
        for h = 1:length(X_k_all)
            X_k = X_k_all(h);
            One_Triplet = [X_j X_i X_k];
            All_Triplet_of_a_point = [All_Triplet_of_a_point One_Triplet];
            Save_triplet{m} = All_Triplet_of_a_point;
        end
    end
    %--save triplet for each point--------------    
end
%--Find the matches that satisfy triplet relationship-- 
end