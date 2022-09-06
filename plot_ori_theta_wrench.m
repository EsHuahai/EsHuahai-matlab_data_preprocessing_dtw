% ���Ƶ���ʾ�̹����е�Fx/Fz/My_theta��Ϣ
f1 = figure;
f2 = figure;
f3 = figure;
f4 = figure;
f5 = figure;
figure(f1);%����Fx��theta
for i = 1:18
    eval(['theta=','theta1',num2str(i),';']);
    eval(['Fx=','wrench_dual1',num2str(i),'(:,1);']);
    scatter(theta,Fx,5,'filled','DisplayName',num2str(i));
    hold on;
end
legend;
title("\fontsize{16}Fx-\theta");
xlabel('\theta/��');
ylabel('Fx/N');

figure(f2);%����Fz��theta
for i = 1:18
    eval(['theta=','theta1',num2str(i),';']);
    eval(['Fz=','wrench_dual1',num2str(i),'(:,3);']);
    scatter(theta,Fz,5,'filled');
    hold on;
end
title("\fontsize{16}Fz-\theta");
xlabel('\theta/��');
ylabel('Fz/N');

figure(f3);%����My��theta
for i = 1:18
    eval(['theta=','theta1',num2str(i),';']);
    eval(['My=','wrench_dual1',num2str(i),'(:,5);']);
    scatter(theta,My,5,'filled');
    hold on;
end
title("\fontsize{16}My-\theta");
xlabel('\theta/��');
ylabel('My/Nm');

figure(f4);%����theta_dot��theta
for i = 1:18
    eval(['theta=','theta1',num2str(i),';']);
    eval(['theta_dot=','theta_d1',num2str(i)]);
    scatter(theta,theta_dot,5,'filled');
    hold on;
end
title("\fontsize{16}theta_dot-\theta");
xlabel('\theta/��');
ylabel('theta_dot/��/s');

figure(f5);%����wy��theta
for i = 1:18
    eval(['theta=','theta1',num2str(i),';']);
    eval(['wy=','w_dual_y1',num2str(i)]);
    scatter(theta,wy,5,'filled');
    hold on;
end
title("\fontsize{16}Wy\theta");
xlabel('\theta/��');
ylabel('Wy/rad/s');