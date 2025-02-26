function [xy,I1,I2,data,groundtrue] = D_CVPR_data_process_F_H (pack)
    %------- Adelaide data ---------
%     xy = pack.data;
%     I1 = pack.img1;
%     I2 = pack.img2;
%     groundtrue = pack.label;    
    %------- new data ------------
         I1 = pack.Ia;
         I2 = pack.Ib;
         xy = pack.xy;
         groundtrue = pack.groundtrue;     %% SNU_GT   groundtrue
    %------- new data -------------
         
    [dat_img_1,T1] = normalise2dpts(xy(1:3,:));
    [dat_img_2,T2] = normalise2dpts(xy(4:6,:));
    data = [ dat_img_1 ; dat_img_2 ];
end 