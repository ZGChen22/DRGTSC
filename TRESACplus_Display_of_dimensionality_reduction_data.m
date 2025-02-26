function TRESACplus_Display_of_dimensionality_reduction_data(curX,inlierinx)
%TRESACPLUS_DISPLAY_OF_DIMENSIONALITY_REDUCTION_DATA 此处显示有关此函数的摘要
figure ()
    Green_1 =[];Red_1 = [];
    curX(:,3)=inlierinx;
    for d = 1:length(inlierinx)
        if curX(d,3)>0
            Green_1 = [curX(d,:) ;Green_1];
        else
            Red_1 = [curX(d,:) ;Red_1];
        end
    end
        plot(Green_1(:,1), Green_1(:,2), 'o','color',[0 1 0]);
        hold on;
        plot(Red_1(:,1), Red_1(:,2), 'o','color',[1 0 0]);
%添加坐标轴标签
 xlabel('x');
 ylabel('y');

%添加标题
 title('Plot of Points');
end

