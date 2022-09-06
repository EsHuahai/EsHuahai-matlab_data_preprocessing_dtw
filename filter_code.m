%% define filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fpass = 0.1;  % Passband Frequency 15
Fstop = 8;    % Stopband Frequency 16
Apass = 0.1;  % Passband Ripple (dB)
Astop = 60;   % Stopband Attenuation (dB)
Fs    = 125;  % Sampling Frequency
h = fdesign.lowpass('fp,fst,ap,ast', Fpass, Fstop, Apass, Astop, Fs);
%Hd = design(h, 'equiripple', 'MinOrder', 'any', 'StopbandShape', 'flat'); % 等波纹法
Hd = design(h, 'kaiserwin'); % kaiser窗法
% freqz(Hd) % 查看滤波器特�?

dataout = filtfilt(Hd.Numerator, 1, datain); % filter desired velocity