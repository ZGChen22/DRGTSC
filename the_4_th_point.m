function [par,res,triple_minimal_pinx]  = the_4_th_point(data_normal,Top_rank_triplet_Scores_Index,model_type)

[fitfn,resfn,degenfn,psize,numpar,fit_model] = getModelParaXmu(model_type);
%将前四个信息提取
pinx = Top_rank_triplet_Scores_Index;%前4个的序号
psub = data_normal(:,pinx); % 取得最小子集的索引，即坐标信息
%数据初始化
Num_sample = 1;
par = zeros(numpar,Num_sample);
res = zeros(length(data_normal),Num_sample);
inx = zeros(psize,Num_sample);

% Check for degeneracy.
isdegen = feval(degenfn,psub);   %%% 返回0没有退化
if (isdegen==1)
    error('Cannot find a valid p-subset!');
    % continue;
end
% Fit the model on the p-subset.%计算res等信息
st = feval(fitfn,psub);
st = reshape(st, numpar, 1);%% change the matrix shape
% Compute residuals.
ds = feval(resfn,st,data_normal);
%输出
par(:,1) = st;
res(:,1) = ds;   %%%% 参数是numpar*1  即  25*1  MotionFourSubspace 记得变为5*5处理
triple_minimal_pinx = pinx;
end

