clc;clear;close all;
resp= load ('pos.mat');
response= resp.resp;
target= resp.tgt;
times= resp.times;time_gains= resp.time_gains;
kp= resp.kp;     
kd= resp.kd;
ki= resp.ki;
rise_time=[];
st_time=[];
os=[];
ss_err=[];
for i=1: length(target)
    time= cell2mat(times(i));
    time_g= cell2mat(time_gains(i));
    res= cell2mat(response(i));
    p_gain= cell2mat(kp(i));
    i_gain= cell2mat(ki(i));
    d_gain= cell2mat(kd(i));
    tgt_vec=  target(i)+ zeros(length(time),1);
    x= stepinfo(res, time);
    rise_time=[rise_time x.RiseTime];
    st_time=[st_time x.SettlingTime]; 
    if target(i)> 0
    overshoot= ((max(res)- target(i))./(target(i))).*100;
    else
        overshoot= ((min(res)- target(i))./(target(i))).*100;
    end
    overshoot= x.Overshoot;
    os=[os overshoot]; 
    ss_err=[ss_err abs(target(i)-res(end))];
    figure
    set(gcf,'color','w');
    plot(time,tgt_vec,'b-', 'LineWidth',2)
    hold on
    plot(time,res,'r-', 'LineWidth',2)
    hold off
    grid on
    title('Target Value and Actual Response')
    xlabel('Time (seconds)')
    ylabel('Pitch Angle (radians)')
    legend('Target Value','Actual Response')
    figure
    set(gcf,'color','w');
    p= (squeeze(p_gain(1,1,:)));
    i= (squeeze(i_gain(1,1,:)));
    d= (squeeze(d_gain(1,1,:)));
    plot(time_g,p,'LineWidth',2)
    hold on
    plot(time_g,i,'LineWidth',2)
    plot(time_g,d,'LineWidth',2)
    hold off
    grid on
    title('Adaptive Gain Values')
    xlabel('Time (seconds)')
    ylabel('Gain Values')
    legend('Kp','Ki','Kd')
    
end
%append all vectors
disp('Target, Rise Time (secs),Settling Time (secs),Overshoot, Steady State Error')
transient_resp= [target' rise_time' st_time' os' ss_err']
