
function error=segmentationError(groundTrueLabel,label)
groundTrueLabel=groundTrueLabel+ones(1,length(groundTrueLabel));
label=label+ones(1,length(label));
number=length(unique(groundTrueLabel));
flag=zeros(1,number);
% label=groundTrueLabel;
n=length(unique(label));
rightnumber=0;
for i=1:n
    A(i)=sum(label == i); % 每类的个数
end

[ss,sortnumber]=sort(A, 'descend');

for i=1:n
    each_cluster=(label == sortnumber(i));
    max = 0;
    kk=-1;
    for j=1:number
        if flag(j)==1 
            continue
        end
        True_cluster=(groundTrueLabel == j);
        k=length(find(each_cluster+True_cluster>1));
        if k> max
            max = k; 
            kk=j;
        end
    end
    
    if max>0
        flag(kk)=1;
        rightnumber=rightnumber+max;
    end  
end

error=(length(label)-rightnumber)/length(label);

