
function Show_matching_groundtrue_retinal_images_all_inlier_outliers (I1,I2,xy,groundtrue)

    [Iaa, Ibb] = D_CVPR_Different_image_heigh (I1,I2);

    % %     fmt = {'g.','bo','rs','cd','m^','ys','kh','gp'};
    [X1,Y1,Z1]=size(Iaa);
    [X2,Y2,Z2]=size(Ibb);

    Move_white = 10;

    if Z1 == 1
        flag=255*ones(X1,Move_white,1);  %%%  1  3
    else
        flag=255*ones(X1,Move_white,3);  %%%  1  3
    end

%     fmt = {'g<','bo','rs','cd','ks','m^','yh','gp','g<','bo','rs','cd','ks','m^','yh','gp'};
    fmt = {'g.','b.','r.','c.','k.','m.','y.','g.','g.','b.','rs','cd','ks','m^','yh','gp'};
    % %           [X1,Y1,Z1]=size(I1);
    % %           [X2,Y2,Z2]=size(I2);
    % %           Move_white = 7;
    % %           flag=255*ones(X1,Move_white,3);  %%%  1  3
    figure('name','Groundtrue','position',[300 200 900 333]); set(gca,'Position',[0 0 1 1]);
    imshow([Iaa  flag Ibb]);
    hold on;
   elabel = groundtrue;
    
   Num_Outlier = 80;
   data_rand_index = round( rand(1,Num_Outlier) * length(groundtrue) );   % rand (1,Num_Outlier) �����С(0.1)����ֵ
   %%%% �Ƿ���ʾ���е�����
    data_rand_index = [1:1:length(groundtrue)];
   
    for i = min(elabel): max(elabel)
        each_cluster = (elabel == i); %% each_cluster ÿ�λ�ȡһ�����  ��ǩֵ 1 0 �߼�ֵ
        if i== min(elabel) %% ����Ⱥ��
          each_cluster =  find(elabel==i);
%            plot(xy(1,each_cluster), xy(2,each_cluster), fmt{i+1},'MarkerSize',8, 'LineWidth',2.5);
               
           for mm = 1:length(each_cluster)
               
               for nn = 1: length(data_rand_index)
                   if each_cluster(mm)== data_rand_index(nn)  %% each_cluster(mm) �ж�Ҫ��ʾ��ÿ���� [1 1 0]��  [1 0.75 0]����
                       %------------ ���ж� ----------
                       plot(xy(1,each_cluster(mm)), xy(2,each_cluster(mm)), 'r.','MarkerSize',13 , 'LineWidth',2);  % 'MarkerSize',8
                       plot(xy(4,each_cluster(mm))+size(I1,2)+Move_white, xy(5,each_cluster(mm)),'r.','MarkerSize',13 , 'LineWidth',2);
                       
                       X1 = [xy(1,each_cluster(mm)) xy(4,each_cluster(mm))+size(I1,2)+Move_white];  %% size(I1,2)�ڶ����ƶ�һ��ͼ���� + 10 ��λ��ֵ
                       Y1 = [xy(2,each_cluster(mm)) xy(5,each_cluster(mm))];
                       % plot(X1,Y1,strcat(fmt{i}(1),'-'),'LineWidth',2);
                       % if X1(1)>178 &&X1(1)<190
                       plot(X1,Y1,...
                           'r-','LineWidth',1.0,'MarkerSize',10); % [1 0.75 0] ����
                       hold on;
                       %------------ ���ж� ----------
                   end
               end               
           end
           
        elseif i>=1  %% ��ÿ���
            each_cluster = find(each_cluster);
           
            %%%%  ÿ������
            for jj = 1:length(each_cluster)
                
                for nn = 1: length(data_rand_index)
                    if each_cluster(jj)== data_rand_index(nn)  %% each_cluster(mm) �ж�Ҫ��ʾ��ÿ����
                        %------------ ���ж� ----------
                        plot(xy(1,each_cluster(jj)), xy(2,each_cluster(jj)), fmt{i} ,'MarkerSize',13 , 'LineWidth',2);  %% 'g.'
                        plot(xy(4,each_cluster(jj))+size(I1,2)+Move_white, xy(5,each_cluster(jj)),fmt{i},'MarkerSize',13 , 'LineWidth',2);
                        X1 = [xy(1,each_cluster(jj)) xy(4,each_cluster(jj))+size(I1,2)+Move_white];  %% size(I1,2)�ڶ����ƶ�һ��ͼ���� + 10 ��λ��ֵ
                        Y1 = [xy(2,each_cluster(jj)) xy(5,each_cluster(jj))];
                        % plot(X1,Y1,strcat(fmt{i}(1),'-'),'LineWidth',2);
                        % if X1(1)>178 &&X1(1)<190
                        plot(X1,Y1,...
                           'g-','LineWidth',1.0 ,'MarkerSize',16);   %% [1 0.75 0]   fmt{i}(1)
                        %   end
                        % % % % % % % %                                  clf;
                        %------------ ���ж� ----------
                    end
                end
                
            end
        end   %%% һ�����λ��
    end
end

