% % 对原始力矩数据、角速度进行均值滤波
% for i = 1:25
%     N = eval(['wrench',num2str(i)]);
%     M = eval(['wrench_FT',num2str(i)]);
% %     K = eval(['w',num2str(i)]);
% %     L = eval(['w_b',num2str(i)]);
%     window_size = 30;
%     window_size2 = 30;
%     b = (1/window_size)*ones(1,window_size);
%     b2 = (1/window_size2)*ones(1,window_size2);
%     a = 1;
%     eval(['filtered_wrench',num2str(i),'=','filter(b,a,N)',';']);
%     eval(['filtered_wrench_FT',num2str(i),'=','filter(b,a,M)',';']);
% %     eval(['filtered_w',num2str(i),'=','filter(b2,a,K)',';']);
% %     eval(['filtered_w_b',num2str(i),'=','filter(b2,a,L)',';']);
%     save(['filtered_wrench_FT',num2str(i),'.mat'],strcat('filtered_wrench_FT',num2str(i)));
%     save(['filtered_wrench',num2str(i),'.mat'],strcat('filtered_wrench',num2str(i)));
% %     save(['filtered_w',num2str(i),'.mat'],strcat('filtered_w',num2str(i)));
% %     save(['filtered_w_b',num2str(i),'.mat'],strcat('filtered_w_b',num2str(i)));
% end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %利用带通滤波器对力矩进行滤波
% i = 6;
% N = eval(['wrench',num2str(i)]);
% M = eval(['wrench_FT',num2str(i)]);
% Fpass = 0.1;  % Passband Frequency 15
% Fstop = 20;    % Stopband Frequency 16
% Apass = 0.1;  % Passband Ripple (dB)
% Astop = 60;   % Stopband Attenuation (dB)
% Fs    = 125;  % Sampling Frequency
% h = fdesign.lowpass('fp,fst,ap,ast', Fpass, Fstop, Apass, Astop, Fs);
% Hd = design(h, 'kaiserwin'); % kaiser绐楁硶
% k = filtfilt(Hd.Numerator, 1, N(:,7)); % filter desired velocity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %对原始力数据（世界）进行低通滤波
% Fpass = 0.1;  % Passband Frequency 15
% Fstop = 15;    % Stopband Frequency 16
% Apass = 0.1;  % Passband Ripple (dB)
% Astop = 60;   % Stopband Attenuation (dB)
% Fs    = 125;  % Sampling Frequency
% h = fdesign.lowpass('fp,fst,ap,ast', Fpass, Fstop, Apass, Astop, Fs);
% Hd = design(h, 'kaiserwin'); % kaiser绐楁硶
% 
% Fpass = 0.1;  % Passband Frequency 15
% Fstop = 10;    % Stopband Frequency 16
% Apass = 0.1;  % Passband Ripple (dB)
% Astop = 60;   % Stopband Attenuation (dB)
% Fs    = 125;  % Sampling Frequency
% h2 = fdesign.lowpass('fp,fst,ap,ast', Fpass, Fstop, Apass, Astop, Fs);
% Hd2 = design(h2, 'kaiserwin'); % kaiser绐楁硶
% 
% doc_index = 1;
% 
% 
% 
% for i=1:5
%     data = eval(['wrench_dual',num2str(doc_index),num2str(i)]);
%     force = data(:,1:3);
%     torque = data(:,4:6);
%     wb = data(:,7:9);
% %     figure(1);
% %     plot(force,'-')
% %     hold on;
% %     force = smoothdata(force,1,'movmean',5);
% %     plot(force,':')
%     
% %     figure(2);
% %     plot(torque,'-')
% %     hold on;
% %     torque = smoothdata(torque,1,'movmean',5);
% %     plot(torque,':')
%     
% %     figure(3);
% %     plot(ws(:,2),'-b')
% %     hold on;
% %     ws = smoothdata(ws,1,'movmean',20);
% %     figure(4)
% %     plot(ws(:,2),':r')
%     
%     for j = 1:3    
%         eval(['filtered_forceFT',num2str(doc_index),num2str(i),'(:,j)','= filtfilt(Hd.Numerator, 1, force(:,j));'])  % filter desired velocity
%         
%     end
%     for j = 1:3   
%         eval(['filtered_torqueFT',num2str(doc_index),num2str(i),'(:,j)','= filtfilt(Hd.Numerator, 1, torque(:,j));'])  % filter desired velocity
%     end 
%     for j = 1:3   
%         eval(['filtered_wb',num2str(doc_index),num2str(i),'(:,j)','= filtfilt(Hd2.Numerator, 1, wb(:,j));'])  % filter desired velocity
%         
%         %     ws = smoothdata(ws,1,'movmean',20);
%     end 
%     eval(['filtered_wb',num2str(doc_index),num2str(i),'= smoothdata(filtered_wb',num2str(doc_index),num2str(i),',1,''movmean'', 50);']);  % filter desired velocity
%     eval(['filtered_forceFT',num2str(doc_index),num2str(i),'= smoothdata(filtered_forceFT',num2str(doc_index),num2str(i),',1,''movmean'', 10);']);  % filter desired velocity
%     eval(['filtered_torqueFT',num2str(doc_index),num2str(i),'= smoothdata(filtered_torqueFT',num2str(doc_index),num2str(i),',1,''movmean'', 10);']);  % filter desired velocity
%     save(['filtered_data/filtered_forceFT',num2str(doc_index),num2str(i),'.mat'],['filtered_forceFT',num2str(doc_index),num2str(i)]);
%     save(['filtered_data/filtered_torqueFT',num2str(doc_index),num2str(i),'.mat'],['filtered_torqueFT',num2str(doc_index),num2str(i)]);
%     save(['filtered_data/filtered_wb',num2str(doc_index),num2str(i),'.mat'],['filtered_wb',num2str(doc_index),num2str(i)]);
% %     mean_q(:,1) = smooth(q(:,1),10);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%对原始四元数/位置/角度进行低通滤波%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fpass = 0.1;  % Passband Frequency 15
% Fstop = 15;    % Stopband Frequency 16
% Apass = 0.1;  % Passband Ripple (dB)
% Astop = 60;   % Stopband Attenuation (dB)
% Fs    = 125;  % Sampling Frequency
% h = fdesign.lowpass('fp,fst,ap,ast', Fpass, Fstop, Apass, Astop, Fs);
% Hd = design(h, 'kaiserwin'); % kaiser绐楁硶
% doc_index = 1;
% for i=1:5
%     data = eval(['quat',num2str(doc_index),num2str(i)]);
%     q = data(:,1:4);
%     p = data(:,5:7);
%     theta = data(:,8);
% %     figure(1);
% %     plot(q);
% %     hold on
%     for j = 1:4    
%        eval(['filtered_q',num2str(doc_index),num2str(i),'(:,j)','= filtfilt(Hd.Numerator, 1, q(:,j));'])  % filter desired velocity
%     end
% %     plot(filtered_q);
% %     figure(2);
% %     plot(p);
% %     hold on;
%     for j = 1:3   
%         eval(['filtered_p',num2str(doc_index),num2str(i),'(:,j)','= filtfilt(Hd.Numerator, 1, p(:,j));'])  % filter desired velocity
%     end 
% %     plot(filtered_p);
%     eval(['filtered_theta',num2str(doc_index),num2str(i),'(:,1)','= filtfilt(Hd.Numerator, 1, theta(:,1));']);
%     save(['filtered_data/filtered_q',num2str(doc_index),num2str(i),'.mat'],['filtered_q',num2str(doc_index),num2str(i)]);
%     save(['filtered_data/filtered_p',num2str(doc_index),num2str(i),'.mat'],['filtered_p',num2str(doc_index),num2str(i)]);
%     save(['filtered_data/filtered_theta',num2str(doc_index),num2str(i),'.mat'],['filtered_theta',num2str(doc_index),num2str(i)]);
% %     mean_q(:,1) = smooth(q(:,1),10);
% end




% figure(1);
% plot(quat6(:,1));
% hold on;
% plot(filtered_q6(:,1));
% figure(2);
% plot(quat6(:,5));
% hold on;
% plot(filtered_p6(:,1));