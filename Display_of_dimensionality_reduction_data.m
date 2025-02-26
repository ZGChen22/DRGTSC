function  Display_of_dimensionality_reduction_data(curX,groundtrue)
%DISPLAY_OF_DIMENSIONALITY_REDUCTION_DATA 此处显示有关此函数的摘要
    Green =[];Red = [];
    for d = 1:length(groundtrue)
        if curX(d,3)>0
            Green = [curX(d,:) ;Green];
        else
            Red = [curX(d,:) ;Red];
        end
    end
        plot(Green(:,1), Green(:,2), 'o','color',[0 1 0]);
        hold on;
        plot(Red(:,1), Red(:,2), 'o','color',[1 0 0]);
        axis equal;
%添加坐标轴标签
 xlabel('x');
 ylabel('y');

%添加标题
 title('Plot of Points');
end

