%���ڼ�������������
%����˵��
%index:     ���μ���Ƭ����ԭʼ���������е����
%doc_index: �ü���ԭʼ�������
%[a,b] :    ���βü�Ƭ�ε�������ֹ������
%--------------------------------------------------------
    clear all;
    index = 18;
    doc_index = 1;
    data0 = load(['dem_data_wrench_dual',num2str(doc_index),'.txt']);%�˴�����ԭʼ����ȱ�ٻ��з����Ա�����һ�е���
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
%     plot(data1,'DisplayName','data1')%�˴����öϵ�鿴��ȡ����
%     figure(3);
%     plot(data3(:,10),'DisplayName','data3')
    a = 29730; 
    b = 30200;
    data1 = data1(a:b,:);%�޸Ľ�ȡ����
    data2 = data2(a:b,:);%�޸Ľ�ȡ����
    data3 = data3(a:b,:);%�޸Ľ�ȡ����
    eval(['wrench_dual',num2str(doc_index),num2str(index),'=data1;']);
    save(['E:\�ٶ�����ͬ���ļ���\BaiduNetdiskWorkspace\˶ʿ-���пƼ���ѧ\04 ʵ��\03 ʵ����������Ƶ\02-Ԥ�������������Ƶ����\02-2022.9.2-ʾ�����ݴ���\01-�ü���ԭʼ����\wrench_dual\wrench_dual',num2str(doc_index),num2str(index),'.mat'],['wrench_dual',num2str(doc_index),num2str(index)]);
    eval(['wrench_world',num2str(doc_index),num2str(index),'=data2;']);
    save(['E:\�ٶ�����ͬ���ļ���\BaiduNetdiskWorkspace\˶ʿ-���пƼ���ѧ\04 ʵ��\03 ʵ����������Ƶ\02-Ԥ�������������Ƶ����\02-2022.9.2-ʾ�����ݴ���\01-�ü���ԭʼ����\wrench_world\wrench_world',num2str(doc_index),num2str(index),'.mat'],['wrench_world',num2str(doc_index),num2str(index)]);
    eval(['theta',num2str(doc_index),num2str(index),'=data3(:,10);']);
    save(['E:\�ٶ�����ͬ���ļ���\BaiduNetdiskWorkspace\˶ʿ-���пƼ���ѧ\04 ʵ��\03 ʵ����������Ƶ\02-Ԥ�������������Ƶ����\02-2022.9.2-ʾ�����ݴ���\01-�ü���ԭʼ����\theta\theta',num2str(doc_index),num2str(index),'.mat'],['theta',num2str(doc_index),num2str(index)]);
    eval(['theta_dot_ori',num2str(doc_index),num2str(index),'=data3(:,11);']);
    save(['E:\�ٶ�����ͬ���ļ���\BaiduNetdiskWorkspace\˶ʿ-���пƼ���ѧ\04 ʵ��\03 ʵ����������Ƶ\02-Ԥ�������������Ƶ����\02-2022.9.2-ʾ�����ݴ���\01-�ü���ԭʼ����\theta_dot_ori\theta_dot_ori',num2str(doc_index),num2str(index),'.mat'],['theta_dot_ori',num2str(doc_index),num2str(index)]);
    eval(['w_dual_ori',num2str(doc_index),num2str(index),'=data3(:,7:9);']);
    save(['E:\�ٶ�����ͬ���ļ���\BaiduNetdiskWorkspace\˶ʿ-���пƼ���ѧ\04 ʵ��\03 ʵ����������Ƶ\02-Ԥ�������������Ƶ����\02-2022.9.2-ʾ�����ݴ���\01-�ü���ԭʼ����\w_dual_ori\w_dual_ori',num2str(doc_index),num2str(index),'.mat'],['w_dual_ori',num2str(doc_index),num2str(index)]);