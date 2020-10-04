# CS-229-Project
Reinforcement Learning for a Pitch Controller

Installing
1. Download 2019b Matlab and Simulink
2. Download control systems toolbox, deep learning toolbox and Reinforcement Learning toolbox

Running Tests
1. Download all the files. Open Matlab R2019b
2. Run Adaptive_Gain_Neural_Net.mlx. This will also open up and run RL_Model.slx which contains the RL agent and the aircraft dynamics mode. 
3. Terminate training and stored the responses for the random validation cases as a .mat file
4. Run the script response_plotter.m. This will plot all the responses and show the transient characteristics for each case.

The zeigler_nichols_old.slx file contains the linearized model and a PID controller that has been tuned with MATLAB's PID tuner app (Baseline controller 3). The zn_method_plotter.m script plots the responses obtained with this controller.  
