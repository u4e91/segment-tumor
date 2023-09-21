function [J] = RegionGrowing(I,x,y,reg_maxdist,i)
%区域生长
init_pos=[x,y];
[n1,n2]=size(I);               % 输入图像的维数 
J = zeros(n1, n2);               % 输出
x0 = init_pos(1);                   % 初始点
y0 = init_pos(2);
reg_mean = I(x0, y0);       % 生长起始点灰度值
J(x0, y0) = 1;                    % 生长起始点设置为白色
reg_sum = reg_mean;                     % 符合生长条件的灰度值总和
reg_num = 1;                                  % 符合生长条件的点的个数
count = 1;                                       % 每次判断周围八个点中符合条件的数目
reg_choose = zeros(n1*n2, 2);      % 记录已选择点的坐标
reg_choose(reg_num, :) = init_pos;
num = 1;               % 第一个点   
while count > 0
    s_temp = 0;                  % 周围八个点中符合条件的点的灰度值总和
    count = 0;
    for k = 1 : num      % 对新增的每个点遍历，避免重复
        i = reg_choose(reg_num - num + k, 1);
        j = reg_choose(reg_num - num +k, 2);
        if J(i, j) == 1 && i > 1 && i < n1 && j > 1 && j < n2   % 已确定且不是边界上的点
            % 八邻域
            for u =  -1 : 1      
                for v = -1 : 1
                    % 未处理且满足生长条件的点
                    if  J(i + u, j + v) == 0&&abs(I(i + u, j + v) - reg_mean) <= reg_maxdist
                        J(i + u, j + v) = 1;           % 对应点设置为白色
                        count = count + 1;
                        reg_choose(reg_num + count, :) = [i + u, j + v];
                        s_temp = s_temp + I(i + u, j + v);   % 灰度值存入s_temp中
                    end
                end
            end
        end
    end
    num = count;                                      % 新增的点
    reg_num = reg_num + count;              % 区域内总点数
    reg_sum = reg_sum + s_temp;            % 区域内总灰度值
    reg_mean = reg_sum / reg_num;         % 区域灰度平均值
end