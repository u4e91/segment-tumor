function [J1] = Get_liver(I,x,y,reg_maxdist)
%提取肝脏
%肝脏分割
J1=RegionGrowing(I,x,y,reg_maxdist);%手动找的种子点
%孔洞填充
J1=imfill(J1,'holes');
%开闭运算处理
se=strel('disk',3);
J1=imclose(J1,se);
se=strel('disk',10);
J1=imopen(J1,se);
figure();
imshow(J1,[]);