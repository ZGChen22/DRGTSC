function [output_image] = image_stitching_test(input_A, input_B, inlierinx,xy )
%IMAGE_STITCHING_TEST 此处显示有关此函数的摘要
%   此处显示详细说明
image_A = input_A;
image_B = input_B;
[height_wrap, width_wrap,~] = size(image_A);
[height_unwrap, width_unwrap,~] = size(image_B);
 ind=find(inlierinx>0);
 zz=ind';%
% % zx=xy(1,:);
% % zy=xy(2,:);
x_A1 = xy(1,zz(1,:));%%图像内点坐标
x_A = x_A1';
y_A1 = xy(2,zz(1,:));
y_A = y_A1';
x_B1 = xy(4,zz(1,:));
x_B = x_B1';
y_B1 = xy(5,zz(1,:));
y_B = y_B1';
npoints = length(x_A);
%%特征匹配
% USE 4-POINT RANSAC TO COMPUTE A ROBUST HOMOGRAPHY ESTIMATE
%%使用四点RANSAC算法计算的单应矩阵鲁棒估计
% KEEP THE FIRST IMAGE UNWARPED, WARP THE SECOND TO THE FIRST
%加权相关规则处理器，第二到第一个图，保持第一图像弯曲，
matcher_A = [x_A, y_A, ones(npoints,1)]'; %!!! previous x is y and y is x,
matcher_B = [x_B, y_B, ones(npoints,1)]'; %!!! so switch x and y here.

%[hh, inliers] = ransacfithomography(matcher_B, matcher_A, npoints, 10);%10
ref_P = matcher_B;
dst_P = matcher_A;
fpoints = 8;%抽取的点数 8
rd = randi([1 npoints],1,fpoints);
pR = ref_P(:,rd);
pD = dst_P(:,rd);
h = getHomographyMatrix(pR,pD,fpoints);
hh = h;

% USE INVERSE WARP METHOD
%使用逆翘曲法
% DETERMINE THE SIZE OF THE WHOLE IMAGE
%确定整个图像的大小
[newH, newW, newX, newY, xB, yB] = getNewSize(hh, height_wrap, width_wrap, height_unwrap, width_unwrap);

[X,Y] = meshgrid(1:width_wrap,1:height_wrap);
[XX,YY] = meshgrid(newX:newX+newW-1, newY:newY+newH-1);
AA = ones(3,newH*newW);
AA(1,:) = reshape(XX,1,newH*newW);
AA(2,:) = reshape(YY,1,newH*newW);

AA = hh*AA;
XX = reshape(AA(1,:)./AA(3,:), newH, newW);
YY = reshape(AA(2,:)./AA(3,:), newH, newW);

% INTERPOLATION, WARP IMAGE A INTO NEW IMAGE
%插值，变形图像a到新图像
newImage(:,:,1) = interp2(X, Y, double(image_A(:,:,1)), XX, YY);
newImage(:,:,2) = interp2(X, Y, double(image_A(:,:,2)), XX, YY);
newImage(:,:,3) = interp2(X, Y, double(image_A(:,:,3)), XX, YY);

% BLEND IMAGE BY CROSS DISSOLVE
%混合图像的交叉融合
[newImage] = blend(newImage, image_B, xB, yB);

% DISPLAY IMAGE MOSIAC
%显示图像的拼接
figure;
imshow(uint8(newImage));





function [hh] = getHomographyMatrix(point_ref, point_src, npoints)
% Use corresponding points in both images to recover the parameters of the transformation 
% Input:
% x_ref, x_src --- x coordinates of point correspondences
% y_ref, y_src --- y coordinates of point correspondences
% Output:
% h --- matrix of transformation

% NUMBER OF POINT CORRESPONDENCES
x_ref = point_ref(1,:)';
y_ref = point_ref(2,:)';
x_src = point_src(1,:)';
y_src = point_src(2,:)';

% COEFFICIENTS ON THE RIGHT SIDE OF LINEAR EQUATIONS
A = zeros(npoints*2,8);
A(1:2:end,1:3) = [x_ref, y_ref, ones(npoints,1)];
A(2:2:end,4:6) = [x_ref, y_ref, ones(npoints,1)];
A(1:2:end,7:8) = [-x_ref.*x_src, -y_ref.*x_src];
A(2:2:end,7:8) = [-x_ref.*y_src, -y_ref.*y_src];

% COEFFICIENT ON THE LEFT SIDE OF LINEAR EQUATIONS
B = [x_src, y_src];
B = reshape(B',npoints*2,1);

% SOLVE LINEAR EQUATIONS
h = A\B;

hh = [h(1),h(2),h(3);h(4),h(5),h(6);h(7),h(8),1];

function [newH, newW, x1, y1, x2, y2] = getNewSize(transform, h2, w2, h1, w1)
% Calculate the size of new mosaic
% Input:
% transform - homography matrix
% h1 - height of the unwarped image
% w1 - width of the unwarped image
% h2 - height of the warped image
% w2 - height of the warped image
% Output:
% newH - height of the new image
% newW - width of the new image
% x1 - x coordate of lefttop corner of new image
% y1 - y coordate of lefttop corner of new image
% x2 - x coordate of lefttop corner of unwarped image
% y2 - y coordate of lefttop corner of unwarped image
% 
% Yihua Zhao 02-02-2014
% zhyh8341@gmail.com
%

% CREATE MESH-GRID FOR THE WARPED IMAGE
[X,Y] = meshgrid(1:w2,1:h2);
AA = ones(3,h2*w2);
AA(1,:) = reshape(X,1,h2*w2);
AA(2,:) = reshape(Y,1,h2*w2);

% DETERMINE THE FOUR CORNER OF NEW IMAGE
newAA = transform\AA;
new_left = fix(min([1,min(newAA(1,:)./newAA(3,:))]));
new_right = fix(max([w1,max(newAA(1,:)./newAA(3,:))]));
new_top = fix(min([1,min(newAA(2,:)./newAA(3,:))]));
new_bottom = fix(max([h1,max(newAA(2,:)./newAA(3,:))]));

newH = new_bottom - new_top + 1;
newW = new_right - new_left + 1;
x1 = new_left;
y1 = new_top;
x2 = 2 - new_left;
y2 = 2 - new_top;

function [newImage] = blend(warped_image, unwarped_image, x, y)
% Blend two image by using cross dissolve
% Input:
% warped_image - original image
% unwarped_image - the other image
% x - x coordinate of the lefttop corner of unwarped image
% y - y coordinate of the lefttop corner of unwarped image
% Output:
% newImage
% 
% Yihua Zhao 02-02-2014
% zhyh8341@gmail.com
%


% MAKE MASKS FOR BOTH IMAGES 
warped_image(isnan(warped_image))=0;
maskA = (warped_image(:,:,1)>0 |warped_image(:,:,2)>0 | warped_image(:,:,3)>0);
newImage = zeros(size(warped_image));
newImage(y:y+size(unwarped_image,1)-1, x: x+size(unwarped_image,2)-1,:) = unwarped_image;
mask = (newImage(:,:,1)>0 | newImage(:,:,2)>0 | newImage(:,:,3)>0);
mask = and(maskA, mask);

% GET THE OVERLAID REGION
[~,col] = find(mask);
left = min(col);
right = max(col);
mask = ones(size(mask));
if( x<2)
mask(:,left:right) = repmat(linspace(0,1,right-left+1),size(mask,1),1);
else
mask(:,left:right) = repmat(linspace(1,0,right-left+1),size(mask,1),1);
end

% BLEND EACH CHANNEL
warped_image(:,:,1) = warped_image(:,:,1).*mask;
warped_image(:,:,2) = warped_image(:,:,2).*mask;
warped_image(:,:,3) = warped_image(:,:,3).*mask;

% REVERSE THE ALPHA VALUE
if( x<2)
mask(:,left:right) = repmat(linspace(1,0,right-left+1),size(mask,1),1);
else
mask(:,left:right) = repmat(linspace(0,1,right-left+1),size(mask,1),1);
end
newImage(:,:,1) = newImage(:,:,1).*mask;
newImage(:,:,2) = newImage(:,:,2).*mask;
newImage(:,:,3) = newImage(:,:,3).*mask;

newImage(:,:,1) = warped_image(:,:,1) + newImage(:,:,1);
newImage(:,:,2) = warped_image(:,:,2) + newImage(:,:,2);
newImage(:,:,3) = warped_image(:,:,3) + newImage(:,:,3);