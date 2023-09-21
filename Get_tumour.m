function [J2] = Get_tumour(I,x,y,reg_maxdist,n1,n2)
%肿瘤分割
J2=RegionGrowing(I,x,y,reg_maxdist);%肿瘤所在的像素点灰度较低，取得阈值较小
% 孔洞填充
J2=imfill(J2,'holes');
% %开运算
% se=strel('disk',10);
% J2=imopen(J2,se);
% for i=1:n1%方便区分肿瘤和肝脏
%     for j=1:n2
%         if J2(i,j)==1;
%             J2(i,j)=2;
%         end
%     end
% end
figure();
imshow(J2,[]);