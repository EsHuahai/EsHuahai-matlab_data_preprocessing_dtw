%用于剪裁连续的数据
%参数说明
%index:     本次剪裁片段在原始连续数据中的序号
%doc_index: 裁剪的原始数据序号
%[a,b] :    本次裁剪片段的起至终止点坐标
%--------------------------------------------------------
    clear all;
    index = 18;
    doc_index = 1;
    data0 = load(['dem_data_wrench_dual',num2str(doc_index),'.txt']);%此处由于原始数据缺少换行符所以保存在一行当中
    for i = 1:6:length(data0)
        if (i+5)>length(data0)
            break;
        end
        data1(ceil(i/6),:) = data0(i:i+5);
    end
    data0 = load(['dem_data_wrench_world',num2str(doc_index),'.txt']);
    for i = 1:2:length(data0)
        if (i+1)>length(data0)
            break;
        end
        data2(ceil(i/2),1:3) = data0(i,:);
        data2(ceil(i/2),4:6) = data0(i+1,:);
    end
    data3 = load(['dem_data_ws_wb_wdual_theta_quat_pos',num2str(doc_index),'.txt']);
%     figure(1);
%     plot(data1,'DisplayName','data1')%此处设置断点查看截取区间
%     figure(3);
%     plot(data3(:,10),'DisplayName','data3')
    a = 29730; 
    b = 30200;
    data1 = data1(a:b,:);%修改截取区间
    data2 = data2(a:b,:);%修改截取区间
    data3 = data3(a:b,:);%修改截取区间
    eval(['wrench_dual',num2str(doc_index),num2str(index),'=data1;']);
    save(['E:\百度网盘同步文件夹\BaiduNetdiskWorkspace\硕士-华中科技大学\04 实验\03 实验数据与视频\02-预处理后数据与视频剪辑\02-2022.9.2-示教数据处理\01-裁剪后原始数据\wrench_dual\wrench_dual',num2str(doc_index),num2str(index),'.mat'],['wrench_dual',num2str(doc_index),num2str(index)]);
    eval(['wrench_world',num2str(doc_index),num2str(index),'=data2;']);
    save(['E:\百度网盘同步文件夹\BaiduNetdiskWorkspace\硕士-华中科技大学\04 实验\03 实验数据与视频\02-预处理后数据与视频剪辑\02-2022.9.2-示教数据处理\01-裁剪后原始数据\wrench_world\wrench_world',num2str(doc_index),num2str(index),'.mat'],['wrench_world',num2str(doc_index),num2str(index)]);
    eval(['theta',num2str(doc_index),num2str(index),'=data3(:,10);']);
    save(['E:\百度网盘同步文件夹\BaiduNetdiskWorkspace\硕士-华中科技大学\04 实验\03 实验数据与视频\02-预处理后数据与视频剪辑\02-2022.9.2-示教数据处理\01-裁剪后原始数据\theta\theta',num2str(doc_index),num2str(index),'.mat'],['theta',num2str(doc_index),num2str(index)]);
    eval(['theta_dot_ori',num2str(doc_index),num2str(index),'=data3(:,11);']);
    save(['E:\百度网盘同步文件夹\BaiduNetdiskWorkspace\硕士-华中科技大学\04 实验\03 实验数据与视频\02-预处理后数据与视频剪辑\02-2022.9.2-示教数据处理\01-裁剪后原始数据\theta_dot_ori\theta_dot_ori',num2str(doc_index),num2str(index),'.mat'],['theta_dot_ori',num2str(doc_index),num2str(index)]);
    eval(['w_dual_ori',num2str(doc_index),num2str(index),'=data3(:,7:9);']);
    save(['E:\百度网盘同步文件夹\BaiduNetdiskWorkspace\硕士-华中科技大学\04 实验\03 实验数据与视频\02-预处理后数据与视频剪辑\02-2022.9.2-示教数据处理\01-裁剪后原始数据\w_dual_ori\w_dual_ori',num2str(doc_index),num2str(index),'.mat'],['w_dual_ori',num2str(doc_index),num2str(index)]);