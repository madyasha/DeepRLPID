clc;clear;close all;
open_system('zeigler_nichols_old')
%val_vals= 1.5*(rand(1,10));
val_vals=1;
Simulation_Time= 100;
resp={};
st_time=[];
os=[];
ss_err=[];
rise_time=[];
for i=1: length(val_vals)
    h = val_vals(i)
    blk = sprintf('zeigler_nichols_old/Desired\nPitch Angle');
    set_param(blk,'Value',num2str(h));
    exp= sim('zeigler_nichols_old',Simulation_Time);
    res= pitch_angle.signals.values;
    time= pitch_angle.time;
    x= stepinfo(res, time);
    rise_time=[rise_time x.RiseTime];
    st_time=[st_time x.SettlingTime]; 
    if h> 0
    overshoot= ((max(res)- h)./h)*100;
    else
        overshoot= ((min(res)- h)./(h)).*100;
    end
    os=[os overshoot]; 
    ss_err=[ss_err abs(h-res(end))]
end

disp('Target, Rise Time (secs),Settling Time (secs),Overshoot, Steady State Error')
transient_resp= [val_vals' rise_time' st_time' os' ss_err']

