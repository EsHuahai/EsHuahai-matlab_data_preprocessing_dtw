%用于将四元数矩阵输出为相应角速度矩阵并保存
% 
% for j=1:10
%     eval(['[r,c] = size(filtered_q',num2str(j),');']);
%     eval(['quat_0 = filtered_q',num2str(j),'(1:r-1,1:4);']);
% %     quat_0 = quat1(1:r-1,1:4);
%     eval(['quat_1 = filtered_q',num2str(j),'(2:r,1:4);']);
% %     quat_1 = quat1(2:r,1:4);
%     delt_q = quat_1 - quat_0;%四元数差值
%     delt_q = delt_q*2/0.008333;
%     quat_0_inverse = quat_0 * [-1,0,0,0;
%                             0,-1,0,0;
%                             0,0,-1,0;
%                             0,0,0,1;];
%     w = zeros(r-1,3);
%     w_b = zeros(r-1,3);%相对于刚体坐标系的角速度
%     for i = 1:r-1
%         w(i,1) = delt_q(i,1)*quat_0_inverse(i,4)+delt_q(i,4)*quat_0_inverse(i,1)+delt_q(i,2)*quat_0_inverse(i,3)-delt_q(i,3)*quat_0_inverse(i,2);
%         w(i,2) = delt_q(i,4)*quat_0_inverse(i,2)-delt_q(i,1)*quat_0_inverse(i,3)+delt_q(i,2)*quat_0_inverse(i,4)+delt_q(i,3)*quat_0_inverse(i,1);
%         w(i,3) = delt_q(i,4)*quat_0_inverse(i,3)+delt_q(i,1)*quat_0_inverse(i,2)-delt_q(i,2)*quat_0_inverse(i,1)+delt_q(i,3)*quat_0_inverse(i,4);
%     end
%     for i = 1:r-1
%         w_b(i,1) = quat_0_inverse(i,1)*delt_q(i,4)+quat_0_inverse(i,4)*delt_q(i,1)+quat_0_inverse(i,2)*delt_q(i,3)-quat_0_inverse(i,3)*delt_q(i,2);
%         w_b(i,2) = quat_0_inverse(i,4)*delt_q(i,2)-quat_0_inverse(i,1)*delt_q(i,3)+quat_0_inverse(i,2)*delt_q(i,4)+quat_0_inverse(i,3)*delt_q(i,1);
%         w_b(i,3) = quat_0_inverse(i,4)*delt_q(i,3)+quat_0_inverse(i,1)*delt_q(i,2)-quat_0_inverse(i,2)*delt_q(i,1)+quat_0_inverse(i,3)*delt_q(i,4);
%     end
%     eval(['w',num2str(j),'= w;']);
%     eval(['w_b',num2str(j),'= w_b;']);
% %     w1 = w;
%     save (['w',num2str(j),'.mat'],['w',num2str(j)]);
%     save (['w_b',num2str(j),'.mat'],['w_b',num2str(j)]);
% end


% 利用旋转矩阵计算角速度方法
for j = 1:10
    eval(['[r,c] = size(filtered_q',num2str(j),');']);
    eval(['w_s_',num2str(j),' = zeros(r-1,3);']);
    eval(['w_b_',num2str(j),' = zeros(r-1,3);']);
    temp_q = zeros(r,4);
    eval(['temp_q(:,1) =','filtered_q',num2str(j),'(:,4);']);
    eval(['temp_q(:,2:4) = ','filtered_q',num2str(j),'(:,1:3);']);
    for i = 1:r-1
        R_0 = quat2dcm(temp_q(i,:));
        R_1 = quat2dcm(temp_q(i+1,:));
        R_s = R_1*R_0^(-1);
        R_b = R_0^(-1)*R_1;
        eval(['w_s_',num2str(j),'(i,:) = -rotationMatrixToVector(R_s)/0.0083333;']);
        eval(['w_b_',num2str(j),'(i,:) = -rotationMatrixToVector(R_b)/0.0083333;']);
    end
    save(['w_s_',num2str(j),'.mat'],['w_s_',num2str(j)]);
    save(['w_b_',num2str(j),'.mat'],['w_b_',num2str(j)]);
end

% 检验:结论轴角获取函数结果取负值为理想结果
% r= eye(3);
% for i=1:90
%     r1 = rotx(90)*r;
%     R_S = r1*inv(r);
%     WWWW(i,:) = rotationMatrixToVector(R_S);
%     r = r1;
% end
