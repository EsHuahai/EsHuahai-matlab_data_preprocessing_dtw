%{
% 程序功能说明：对 n 组数据进行处理 DTW 处理
% 
% 要求：
% 输入的每组数据点维度必须相同，但每组数据点个数可以不同;
% 本程序对原始数据点数进行缩减50倍处理，加速学习速度；
% 需要指定一组数据作为 DTW 匹配的模板数据;
% 输入：
% nbSample 组待预处理的数据
% 输出：
% 可直接进行 GMM 训练的双臂位置数据和关节角度数据
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 由于数据已经被分离到了四个矩阵，因此撤除了源代码 %%选取部分数据进行 dtw 匹配%%的部分代码，可以直接读取数据后进行匹配使用；
% }
%% 加载数据
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;clc;%close all;
nbSample = 10;%设置数据组数
dim = 2;%数据点维度；
Rawdata = cell(1,nbSample);%定义元胞数组存储不同维度示教的数据
j = 0;%定义一个
% 加载 数据
for i=1:nbSample
 Rawdata{i} = importdata(['theta_Fx' num2str(i) '.mat']);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 定义模板组和 wrap 窗口
%k = 4;%定义 DTW 匹配方向
t = 5;%定义模板组
w=500;%wrap 窗口
%% 选取部分数据进行 dtw 匹配
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% select_col = [2:4 14:16];%选择指定列进行 dtw 匹配，此处选择左/右臂的 xyz 数据
% rawdata_temp = cell(1,nbSample);%初始化
% for i=1:nbSample
%  rawdata_temp{i} = rawdata{i}(:,select_col);
% end
%% 以第 t 组数据为模板，执行 DTW，并寻找出一条扭曲路径
template_data = Rawdata{t};%设置模板
template_size = size(template_data,1); %模板数据点个数
W = cell(1,nbSample);
for i=1:nbSample
 if i~= t
%  此处rawdata_temp更改为rawdata
%  W{i} = dtw(rawdata_temp{i}, template_data, w);%以整组训练数据进行 DTW
%dtw训练的数据，行方向必须为数据点个数，列对应维度
 W{i} = dtw(Rawdata{i}, template_data, w);%以整组训练数据进行 DTW
 else
 W{i}=[];
 end
end
%% 相对于模板数据，对其他数据进行缩放，缩放后，各组数据维度相同
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = zeros(template_size,dim,nbSample);
for i=1:nbSample
 if i ~= t
 for j=1:template_size
 label = find(W{i}(2,:)==j);
 label_tmp = W{i}(1,label);
 if length(label) > 1
 data(j,:,i) = mean(Rawdata{i}(label_tmp,:)); 
 else
 data(j,:,i) = Rawdata{i}(label_tmp,:);
 end
 end
 else
 data(:,:,i) = Rawdata{t};
 end
end
%% 为对齐后的数据增加一列到首部，该列为数据点序号
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nbData = size(data,1);
theta_Fx = zeros(nbData,3,nbSample);%初始化，此处第二维度根据实际情况改变
for i=1:nbSample
    for j=2:3
    theta_Fx(:,j,i) = data(:,j-1,i);
    end
end
%将每组数据的第一列写成 1,2...nbData
for i=1:nbSample
 theta_Fx(:,1,i) = 1:nbData;
end
%% 保存所有示教组dtw结果到一个mat矩阵中
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
joint_cell = cell(1,nbSample);%初始化
for i=1:nbSample
 joint_cell{i} = theta_Fx(:,:,i)';
end
%将元胞数组转换为矩阵
theta_FX = cell2mat(joint_cell);
%存储数据，可直接进行后续 GMM 训练
save('theta_Fx.mat','theta_FX');
%% 寻找最大的数据点个数，以便后面设置坐标轴尺寸
size_num = zeros(1,nbSample);%初始化变量，存储各组数据点个数
for i=1:nbSample
 size_num(1,i) = size(Rawdata{i},1);
end
size_max = max(size_num);
%% 设置线条颜色
color = [255 155 0;
 176 124 230;
 128 82 82;
 124 252 0;
 255 0 0;
 0 0 255;
 160 32 240;
 218 112 214;
 0 255 255;
 8 46 84;
 102 205 170;
 155 205 155;
 118 238 0;
 46 139 87;
 139 58 58;];%设置 10 种线条颜色(RGB)
color = color./255;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% 绘制左臂位置数据
% figure('name','position_left');
% %2~4 列存储的是位置数据：x,y,z
% for i=2:4
%  %经过 DTW 处理
%  subplot(3,2,2*(i-2)+1);hold on;
%  for j=1:nbSample
%  plot(data(:,i,j),'x','markersize',2,'color',color(j,:)); 
%  end
%  min_ = min(min(data(:,i,:)));
%  max_ = max(max(data(:,i,:)));
%  axis([0 nbData+50 min_-0.1 max_+0.1 ]);
%  %未经过 DTW 处理
%  subplot(3,2,2*(i-1));hold on;
%  for j=1:nbSample
%  plot(rawdata{j}(:,i),'x','markersize',2,'color',color(j,:)); 
%  end
%  min_ = min(min(data(:,i,:)));
%  max_ = max(max(data(:,i,:)));
%  axis([0 size_max+50 min_-0.1 max_+0.1 ]);
%  legend('1','2','3','4','5','6','7','8','9','10','11','12');
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 绘制角度与FX数据
figure('name','\theta_fx');
for i=1:2
 %%%%%%%%%经过 DTW 处理%%%%%%%%%
 subplot(2,2,2*(i-1)+1);hold on;
 for j=1:nbSample
 plot(data(:,i,j),'x','markersize',2,'color',color(j,:)); 
 end
 min_ = min(min(data(:,i,:)));
 max_ = max(max(data(:,i,:)));
 axis([0 nbData+50 min_-0.5 max_+0.5 ]);
 %%%%%%%未经过 DTW 处理%%%%%%%%
 subplot(2,2,2*(i));hold on;
 for j=1:nbSample
 plot(Rawdata{j}(:,i),'x','markersize',2,'color',color(j,:)); 
 end
 min_ = min(min(data(:,i,:)));
 max_ = max(max(data(:,i,:)));
 axis([0 size_max+50 min_-0.5 max_+0.5 ]);
end

figure('name','joint3-6');
for i=4:6
 %%%%%%%%%经过 DTW 处理%%%%%%%%%
 subplot(3,2,2*(i-4)+1);hold on;
 for j=1:nbSample
 plot(data(:,i,j),'x','markersize',2,'color',color(j,:)); 
 end
 min_ = min(min(data(:,i,:)));
 max_ = max(max(data(:,i,:)));
 axis([0 nbData+50 min_-0.5 max_+0.5 ]);
 %%%%%%%未经过 DTW 处理%%%%%%%%
 subplot(3,2,2*(i-3));hold on;
 for j=1:nbSample
 plot(rawdata{j}(:,i),'x','markersize',2,'color',color(j,:)); 
 end
 min_ = min(min(data(:,i,:)));
 max_ = max(max(data(:,i,:)));
 axis([0 size_max+50 min_-0.5 max_+0.5 ]);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% 绘制右臂位置数据
% %14~16 列存储的是位置数据：x,y,z
% figure('name','position_right');
% for i=14:16
%  %经过 DTW 处理
%  subplot(3,2,2*(i-14)+1);hold on;
%  for j=1:nbSample
%  plot(data(:,i,j),'x','markersize',2,'color',color(j,:)); 
%  end
%  min_ = min(min(data(:,i,:)));
%  max_ = max(max(data(:,i,:)));
%  axis([0 nbData+50 min_-0.1 max_+0.1 ]);
%  %未经过 DTW 处理
%  subplot(3,2,2*(i-13));hold on;
%  for j=1:nbSample
%  plot(rawdata{j}(:,i),'x','markersize',2,'color',color(j,:)); 
%  end
%  min_ = min(min(data(:,i,:)));
%  max_ = max(max(data(:,i,:)));
%  axis([0 size_max+50 min_-0.1 max_+0.1 ]);
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% 绘制右臂关节角度数据
% %20~25 列存储的左臂角度数据：theta1~theta6
% figure('name','joint_right');
% for i=20:25
%  %%%%%%%%%经过 DTW 处理%%%%%%%%%
%  subplot(6,2,2*(i-20)+1);hold on;
%  for j=1:nbSample
%  plot(data(:,i,j),'x','markersize',2,'color',color(j,:)); 
%  end
%  min_ = min(min(data(:,i,:)));%设置坐标轴
%  max_ = max(max(data(:,i,:)));
%  axis([0 nbData+50 min_-0.5 max_+0.5 ]);
%  %%%%%%%未经过 DTW 处理%%%%%%%%
%  subplot(6,2,2*(i-19));hold on;
%  for j=1:nbSample
%  plot(rawdata{j}(:,i),'x','markersize',2,'color',color(j,:)); 
%  end
%  min_ = min(min(data(:,i,:)));
%  max_ = max(max(data(:,i,:)));
%  axis([0 size_max+50 min_-0.5 max_+0.5 ]);
% end