clear
clc
close all
%% 第一问
%% 相关参数
dm = 28.57;     % kg/s
g = 9.8;        % N/s^2
A_phi = 35;     % 角度增益系数
Pe = 200e3;     % 发动机推力 N
m0 = 8e3;       % 起飞质量 kg
W = 7000;       % 排气速度

%% 初始状态
theta_0 = pi/2;   % 初始弹道倾角 rad
v_0 = 1e-9;        % 初始速度 m/s
x_0 = 0;        % 初始水平位置 m
y_0 = 0;        % 初始高度 m
dv_1k_0 = 0;      % 引力损失 m/s

%% 飞行程序角Phi_pr 及相关参数构造
fig = pi/60;
t1 = 10;
t2 = 130;
t3 = 150;
ppr = @(t) (pi/2) * (t >= 0 && t < t1) +...
    ( pi/2 + (pi/2 - fig)*( ((t-t1)/(t2-t1))^2 - 2*(t-t1)/(t2-t1) ) ) * (t >= t1 && t < t2)+...
    fig * (t >= t2 && t <= t3);
args = [dm,g,A_phi,Pe,m0];
y0 = [theta_0; v_0; x_0; y_0; dv_1k_0];
tspan = [0 t3];

%% 求解
[t,y] = ode45(@(t,y) odefcn(t,y,ppr,args), tspan, y0);
theta_fin = y(end,1);
V_fin = y(end,2);
x_fin = y(end,3);
y_fin = y(end,4);
DV_1k = y(end,5);

%% 可视化
figure(1)
plot(t,y(:,2),'k','linewidth',1)
grid on
title('速度v变化曲线')
legend('速度v变化曲线','Location','best')
xlabel('火箭飞行时间(单位:s)')
ylabel('火箭飞行速度(单位:m/s)')
fprintf('主动段终点火箭飞行速度为 %.2f m/s\n',V_fin);

figure(2)
plot(t,rad2deg(y(:,1)),'k','linewidth',1)
grid on
title('弹道倾角 \theta 变化曲线')
legend('弹道倾角 \theta 变化曲线','Location','best')
xlabel('火箭飞行时间(单位:s)')
ylabel('弹道倾角(单位:度)')
fprintf('主动段终点火箭弹道倾角为 %.4f°\n',theta_fin);

figure(3)
plot(y(:,3),y(:,4),'k','linewidth',1)
grid on
title('质心位置变化曲线')
legend('质心位置变化曲线','Location','best')
xlabel('火箭在地面发射坐标系下的水平位置(单位:m)')
ylabel('火箭在地面发射坐标系下的高度(单位:m)')
fprintf('主动段终点火箭在地面发射坐标系下的坐标为(%.2f, %.2f)m\n',x_fin,y_fin);


%% 第二问
%% V_k = -V_r * ln(m_k/m_0)

% 齐奥尔科夫斯基理想速度计算
m_k = m0 - dm * t3;
V_ideal = -W*log(m_k/m0);
fprintf('验证齐奥尔科夫斯基公式相对误差:(终点理想速度%.3f m/s)\n',V_ideal);
% 考虑引力损失
error1 = ( V_fin - V_ideal ) / V_ideal;
fprintf('\t\t\t 考虑引力损失终点速度为%.3f m/s \t相对误差为: %.3f%%\n',V_fin, error1*100);

% 无引力损失
V_fin_ = V_fin + DV_1k;
error2 = ( V_fin_ - V_ideal ) / V_ideal;
fprintf('\t\t\t 无引力损失终点速度为%.3f m/s \t相对误差为: %.3f%%\n',V_fin_, error2*100);