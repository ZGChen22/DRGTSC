function [par,res,triple_minimal_pinx]  = the_4_th_point(data_normal,Top_rank_triplet_Scores_Index,model_type)

[fitfn,resfn,degenfn,psize,numpar,fit_model] = getModelParaXmu(model_type);
%��ǰ�ĸ���Ϣ��ȡ
pinx = Top_rank_triplet_Scores_Index;%ǰ4�������
psub = data_normal(:,pinx); % ȡ����С�Ӽ�����������������Ϣ
%���ݳ�ʼ��
Num_sample = 1;
par = zeros(numpar,Num_sample);
res = zeros(length(data_normal),Num_sample);
inx = zeros(psize,Num_sample);

% Check for degeneracy.
isdegen = feval(degenfn,psub);   %%% ����0û���˻�
if (isdegen==1)
    error('Cannot find a valid p-subset!');
    % continue;
end
% Fit the model on the p-subset.%����res����Ϣ
st = feval(fitfn,psub);
st = reshape(st, numpar, 1);%% change the matrix shape
% Compute residuals.
ds = feval(resfn,st,data_normal);
%���
par(:,1) = st;
res(:,1) = ds;   %%%% ������numpar*1  ��  25*1  MotionFourSubspace �ǵñ�Ϊ5*5����
triple_minimal_pinx = pinx;
end

