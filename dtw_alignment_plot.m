%{
% ������˵������ n �����ݽ��д��� DTW ����
% 
% Ҫ��
% �����ÿ�����ݵ�ά�ȱ�����ͬ����ÿ�����ݵ�������Բ�ͬ;
% �������ԭʼ���ݵ�����������50����������ѧϰ�ٶȣ�
% ��Ҫָ��һ��������Ϊ DTW ƥ���ģ������;
% ���룺
% nbSample ���Ԥ���������
% �����
% ��ֱ�ӽ��� GMM ѵ����˫��λ�����ݺ͹ؽڽǶ�����
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���������Ѿ������뵽���ĸ�������˳�����Դ���� %%ѡȡ�������ݽ��� dtw ƥ��%%�Ĳ��ִ��룬����ֱ�Ӷ�ȡ���ݺ����ƥ��ʹ�ã�
% }
%% ��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;clc;%close all;
nbSample = 10;%������������
dim = 2;%���ݵ�ά�ȣ�
Rawdata = cell(1,nbSample);%����Ԫ������洢��ͬά��ʾ�̵�����
j = 0;%����һ��
% ���� ����
for i=1:nbSample
 Rawdata{i} = importdata(['theta_Fx' num2str(i) '.mat']);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ����ģ����� wrap ����
%k = 4;%���� DTW ƥ�䷽��
t = 5;%����ģ����
w=500;%wrap ����
%% ѡȡ�������ݽ��� dtw ƥ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% select_col = [2:4 14:16];%ѡ��ָ���н��� dtw ƥ�䣬�˴�ѡ����/�ұ۵� xyz ����
% rawdata_temp = cell(1,nbSample);%��ʼ��
% for i=1:nbSample
%  rawdata_temp{i} = rawdata{i}(:,select_col);
% end
%% �Ե� t ������Ϊģ�壬ִ�� DTW����Ѱ�ҳ�һ��Ť��·��
template_data = Rawdata{t};%����ģ��
template_size = size(template_data,1); %ģ�����ݵ����
W = cell(1,nbSample);
for i=1:nbSample
 if i~= t
%  �˴�rawdata_temp����Ϊrawdata
%  W{i} = dtw(rawdata_temp{i}, template_data, w);%������ѵ�����ݽ��� DTW
%dtwѵ�������ݣ��з������Ϊ���ݵ�������ж�Ӧά��
 W{i} = dtw(Rawdata{i}, template_data, w);%������ѵ�����ݽ��� DTW
 else
 W{i}=[];
 end
end
%% �����ģ�����ݣ����������ݽ������ţ����ź󣬸�������ά����ͬ
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
%% Ϊ��������������һ�е��ײ�������Ϊ���ݵ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nbData = size(data,1);
theta_Fx = zeros(nbData,3,nbSample);%��ʼ�����˴��ڶ�ά�ȸ���ʵ������ı�
for i=1:nbSample
    for j=2:3
    theta_Fx(:,j,i) = data(:,j-1,i);
    end
end
%��ÿ�����ݵĵ�һ��д�� 1,2...nbData
for i=1:nbSample
 theta_Fx(:,1,i) = 1:nbData;
end
%% ��������ʾ����dtw�����һ��mat������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
joint_cell = cell(1,nbSample);%��ʼ��
for i=1:nbSample
 joint_cell{i} = theta_Fx(:,:,i)';
end
%��Ԫ������ת��Ϊ����
theta_FX = cell2mat(joint_cell);
%�洢���ݣ���ֱ�ӽ��к��� GMM ѵ��
save('theta_Fx.mat','theta_FX');
%% Ѱ���������ݵ�������Ա��������������ߴ�
size_num = zeros(1,nbSample);%��ʼ���������洢�������ݵ����
for i=1:nbSample
 size_num(1,i) = size(Rawdata{i},1);
end
size_max = max(size_num);
%% ����������ɫ
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
 139 58 58;];%���� 10 ��������ɫ(RGB)
color = color./255;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% �������λ������
% figure('name','position_left');
% %2~4 �д洢����λ�����ݣ�x,y,z
% for i=2:4
%  %���� DTW ����
%  subplot(3,2,2*(i-2)+1);hold on;
%  for j=1:nbSample
%  plot(data(:,i,j),'x','markersize',2,'color',color(j,:)); 
%  end
%  min_ = min(min(data(:,i,:)));
%  max_ = max(max(data(:,i,:)));
%  axis([0 nbData+50 min_-0.1 max_+0.1 ]);
%  %δ���� DTW ����
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
%% ���ƽǶ���FX����
figure('name','\theta_fx');
for i=1:2
 %%%%%%%%%���� DTW ����%%%%%%%%%
 subplot(2,2,2*(i-1)+1);hold on;
 for j=1:nbSample
 plot(data(:,i,j),'x','markersize',2,'color',color(j,:)); 
 end
 min_ = min(min(data(:,i,:)));
 max_ = max(max(data(:,i,:)));
 axis([0 nbData+50 min_-0.5 max_+0.5 ]);
 %%%%%%%δ���� DTW ����%%%%%%%%
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
 %%%%%%%%%���� DTW ����%%%%%%%%%
 subplot(3,2,2*(i-4)+1);hold on;
 for j=1:nbSample
 plot(data(:,i,j),'x','markersize',2,'color',color(j,:)); 
 end
 min_ = min(min(data(:,i,:)));
 max_ = max(max(data(:,i,:)));
 axis([0 nbData+50 min_-0.5 max_+0.5 ]);
 %%%%%%%δ���� DTW ����%%%%%%%%
 subplot(3,2,2*(i-3));hold on;
 for j=1:nbSample
 plot(rawdata{j}(:,i),'x','markersize',2,'color',color(j,:)); 
 end
 min_ = min(min(data(:,i,:)));
 max_ = max(max(data(:,i,:)));
 axis([0 size_max+50 min_-0.5 max_+0.5 ]);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% �����ұ�λ������
% %14~16 �д洢����λ�����ݣ�x,y,z
% figure('name','position_right');
% for i=14:16
%  %���� DTW ����
%  subplot(3,2,2*(i-14)+1);hold on;
%  for j=1:nbSample
%  plot(data(:,i,j),'x','markersize',2,'color',color(j,:)); 
%  end
%  min_ = min(min(data(:,i,:)));
%  max_ = max(max(data(:,i,:)));
%  axis([0 nbData+50 min_-0.1 max_+0.1 ]);
%  %δ���� DTW ����
%  subplot(3,2,2*(i-13));hold on;
%  for j=1:nbSample
%  plot(rawdata{j}(:,i),'x','markersize',2,'color',color(j,:)); 
%  end
%  min_ = min(min(data(:,i,:)));
%  max_ = max(max(data(:,i,:)));
%  axis([0 size_max+50 min_-0.1 max_+0.1 ]);
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% �����ұ۹ؽڽǶ�����
% %20~25 �д洢����۽Ƕ����ݣ�theta1~theta6
% figure('name','joint_right');
% for i=20:25
%  %%%%%%%%%���� DTW ����%%%%%%%%%
%  subplot(6,2,2*(i-20)+1);hold on;
%  for j=1:nbSample
%  plot(data(:,i,j),'x','markersize',2,'color',color(j,:)); 
%  end
%  min_ = min(min(data(:,i,:)));%����������
%  max_ = max(max(data(:,i,:)));
%  axis([0 nbData+50 min_-0.5 max_+0.5 ]);
%  %%%%%%%δ���� DTW ����%%%%%%%%
%  subplot(6,2,2*(i-19));hold on;
%  for j=1:nbSample
%  plot(rawdata{j}(:,i),'x','markersize',2,'color',color(j,:)); 
%  end
%  min_ = min(min(data(:,i,:)));
%  max_ = max(max(data(:,i,:)));
%  axis([0 size_max+50 min_-0.5 max_+0.5 ]);
% end