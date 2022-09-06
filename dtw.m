% dynamic time warping of two signals
function [W]=dtw(s,t,w)
% s: signal 1, size is ns*k, row for time, colume for channel 
% t: signal 2, size is nt*k, row for time, colume for channel 
% w: window parameter
% if s(i) is matched with t(j) then |i-j|<=w
% d: resulting distance
if nargin<3
 w=Inf;
end
ns=size(s,1);
nt=size(t,1);
if size(s,2)~=size(t,2)
 error('Error in dtw(): the dimensions of the two input signals do not match.');
end
w=max(w, abs(ns-nt)); % adapt window size
%% initialization
D=zeros(ns+1,nt+1)+Inf; % cache matrix
D(1,1)=0;
%% begin dynamic programming
for i=1:ns
 for j=max(i-w,1):min(i+w,nt)
 oost=norm(s(i,:)-t(j,:)); % 计算 s，t 每个点之间的欧氏距离
 D_i_jplus1 = D(i,j+1);% D(i,j+1) 上
 D_iplus1_j = D(i+1,j);% D(i+1,j) 左
 D_i_j = D(i,j);% D(i,j) 斜左
 D(i+1,j+1)=oost+min( [D(i,j+1), D(i+1,j), D(i,j)] );
 D_iplus1_jplus1 = D(i+1,j+1); % D(i+1,j+1)
 
 end
end
d=D(ns+1,nt+1);
%% 回朔，记录序列匹配信息
W = zeros(2, max(ns, nt));
W(1,1) = ns;%存储行初值
W(2,1) = nt;%存储列初值
i = ns; j = nt;
w_j=2; %回朔
while 1
 if D(i-1,j)<D(i-1,j-1)
 W(1,w_j) = i-1;
 W(2,w_j) = j; 
 dist_temp = D(i-1,j);
 else
 W(1,w_j) = i-1;
 W(2,w_j) = j-1;
 dist_temp = D(i-1,j-1);
 end
 if D(i,j-1) < dist_temp
 W(1,w_j) = i;
 W(2,w_j) = j-1; 
 end
 i = W(1,w_j);
 j = W(2,w_j);
 w_j = w_j +1 ;
 %退出循环
 if i==1&&j==1
 break;
 end
end
W = fliplr(W);%倒序输出
%% 显示路径
for k=1:size(W,2)
 D(W(1,k), W(2,k)) = 0;
end
i=1;