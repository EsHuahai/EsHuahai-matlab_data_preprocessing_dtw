%����dtwѵ����������Ҫ�����N��M��ԭʼ����
%N��ԭʼ����ά��
%M���������������
for i = 1:18
    eval(['raw_theta_Fx',num2str(i),'=[theta1',num2str(i),',wrench_dual1',num2str(i),'(:,1)];']);
    save(['E:\�ٶ�����ͬ���ļ���\BaiduNetdiskWorkspace\˶ʿ-���пƼ���ѧ\04 ʵ��\03 ʵ����������Ƶ\02-Ԥ�������������Ƶ����\02-2022.9.2-ʾ�����ݴ���\02-�����˲���dtw��ʽ����\format_before_dtw\data_theta_FX\theta_Fx',num2str(i),'.mat'],['raw_theta_Fx',num2str(i)]);
end
for i = 1:18
    eval(['raw_theta_Fz',num2str(i),'=[theta1',num2str(i),',wrench_dual1',num2str(i),'(:,3)];']);
    save(['E:\�ٶ�����ͬ���ļ���\BaiduNetdiskWorkspace\˶ʿ-���пƼ���ѧ\04 ʵ��\03 ʵ����������Ƶ\02-Ԥ�������������Ƶ����\02-2022.9.2-ʾ�����ݴ���\02-�����˲���dtw��ʽ����\format_before_dtw\data_theta_FZ\theta_Fz',num2str(i),'.mat'],['raw_theta_Fz',num2str(i)]);
end
for i = 1:18
    eval(['raw_theta_wy',num2str(i),'=[theta1',num2str(i),',w_dual_y1',num2str(i),'];']);
    save(['E:\�ٶ�����ͬ���ļ���\BaiduNetdiskWorkspace\˶ʿ-���пƼ���ѧ\04 ʵ��\03 ʵ����������Ƶ\02-Ԥ�������������Ƶ����\02-2022.9.2-ʾ�����ݴ���\02-�����˲���dtw��ʽ����\format_before_dtw\data_theta_wy\theta_wy',num2str(i),'.mat'],['raw_theta_wy',num2str(i)]);
end