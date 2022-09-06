f1 = figure;
f2 = figure;
figure(f1);
%对原始角速度theta_dot_ori数据进行低通滤波
% 设计低通滤波器
Fpass = 0.1;  % Passband Frequency 15
Fstop = 30;    % Stopband Frequency 16
Apass = 0.1;  % Passband Ripple (dB)
Astop = 60;   % Stopband Attenuation (dB)
Fs    = 125;  % Sampling Frequency
h = fdesign.lowpass('fp,fst,ap,ast', Fpass, Fstop, Apass, Astop, Fs);
Hd = design(h, 'kaiserwin'); % kaiser绐楁硶
%对原始角速度w_dual_ori的y分量进行低通滤波
% 设计低通滤波器
Fpass = 0.1;  % Passband Frequency 15
Fstop = 30;    % Stopband Frequency 16
Apass = 0.1;  % Passband Ripple (dB)
Astop = 10;   % Stopband Attenuation (dB)
Fs    = 125;  % Sampling Frequency
h2 = fdesign.lowpass('fp,fst,ap,ast', Fpass, Fstop, Apass, Astop, Fs);
Hd2 = design(h2, 'kaiserwin'); % kaiser绐楁硶
% 对角速度theta_dot进行滤波并画图
index = 1;
eval(['theta_dot = theta_dot_ori1',num2str(index),';']); 
plot(theta_dot,'-r');
hold on;
eval(['theta_d_filtered1',num2str(index),'=  filtfilt(Hd.Numerator,1,theta_dot);']);
eval(['theta_d_filtered','=theta_d_filtered1',num2str(index)]);
theta_d_filtered_mean = smoothdata(theta_d_filtered,'movmean',40);
eval(['theta_d1',num2str(index),'=theta_d_filtered_mean']);
plot(theta_d_filtered,'-b');
hold on ;
plot(theta_d_filtered_mean,'-g');
save(['E:\百度网盘同步文件夹\BaiduNetdiskWorkspace\硕士-华中科技大学\04 实验\03 实验数据与视频\02-预处理后数据与视频剪辑\02-2022.9.2-示教数据处理\02-数据滤波处理\theta_dot\theta_d1',num2str(index),'.mat'],['theta_d1',num2str(index)]);
% 对w_dual_y首先将小于阈值的点设置为NAN，之后利用移动中值填充NAN数据，最后进行均值滤波
figure(f2)
eval(['w_dual_y =w_dual_ori1',num2str(index),'(:,2);']); 
plot(w_dual_y,'-r');
hold on;
w_dual_y(w_dual_y<1e-4&w_dual_y>-1e-4) = missing;
w_dual_y = fillmissing(w_dual_y,'movmedian',10);
w_dual_y = fillmissing(w_dual_y,'constant',0);
eval(['w_dual_y_filtered','=w_dual_y;'])
% w_dual_y_filtered = filtfilt(Hd2.Numerator,1,w_dual_y_filtered);
w_dual_y_filtered = smoothdata(w_dual_y,'movmean',40);
plot(w_dual_y_filtered,'--b')
eval(['w_dual_y1',num2str(index),'=w_dual_y_filtered']);
save(['E:\百度网盘同步文件夹\BaiduNetdiskWorkspace\硕士-华中科技大学\04 实验\03 实验数据与视频\02-预处理后数据与视频剪辑\02-2022.9.2-示教数据处理\02-数据滤波处理\w_dual_y\w_dual_y1',num2str(index),'.mat'],['w_dual_y1',num2str(index)]);