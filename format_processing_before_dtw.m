%用于dtw训练的数据需要整理成N×M的原始数据
%N：原始数据维度
%M：数据样本点个数
for i = 1:18
    eval(['raw_theta_Fx',num2str(i),'=[theta1',num2str(i),',wrench_dual1',num2str(i),'(:,1)];']);
    save(['E:\百度网盘同步文件夹\BaiduNetdiskWorkspace\硕士-华中科技大学\04 实验\03 实验数据与视频\02-预处理后数据与视频剪辑\02-2022.9.2-示教数据处理\02-数据滤波及dtw格式处理\format_before_dtw\data_theta_FX\theta_Fx',num2str(i),'.mat'],['raw_theta_Fx',num2str(i)]);
end
for i = 1:18
    eval(['raw_theta_Fz',num2str(i),'=[theta1',num2str(i),',wrench_dual1',num2str(i),'(:,3)];']);
    save(['E:\百度网盘同步文件夹\BaiduNetdiskWorkspace\硕士-华中科技大学\04 实验\03 实验数据与视频\02-预处理后数据与视频剪辑\02-2022.9.2-示教数据处理\02-数据滤波及dtw格式处理\format_before_dtw\data_theta_FZ\theta_Fz',num2str(i),'.mat'],['raw_theta_Fz',num2str(i)]);
end
for i = 1:18
    eval(['raw_theta_wy',num2str(i),'=[theta1',num2str(i),',w_dual_y1',num2str(i),'];']);
    save(['E:\百度网盘同步文件夹\BaiduNetdiskWorkspace\硕士-华中科技大学\04 实验\03 实验数据与视频\02-预处理后数据与视频剪辑\02-2022.9.2-示教数据处理\02-数据滤波及dtw格式处理\format_before_dtw\data_theta_wy\theta_wy',num2str(i),'.mat'],['raw_theta_wy',num2str(i)]);
end