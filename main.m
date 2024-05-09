% Main script
clear;
clc;

% Define system parameters
m1 = 1; % Mass of the first degree of freedom
m2 = 2; % Mass of the second degree of freedom
k1 = 1; % Spring constant for the first degree of freedom
k2 = 1; % Spring constant for the second degree of freedom
c1 = 1.3; % Damping coefficient for the first degree of freedom
c2 = 2.0; % Damping coefficient for the second degree of freedom

% Define initial and final positions and velocities
x1_initial = 0;
v1_initial = 0;
x2_initial = 0;
v2_initial = 0;
x1_final = 3;
v1_final = 4;
x2_final = 6;
v2_final = 2;

% Call the optimize_trajectory_script to find the optimized control inputs
[opt_control, min_cost] = optimize_trajectory_script(m1, m2, k1, k2, c1, c2, ...
                                                      x1_initial, v1_initial, x2_initial, v2_initial, ...
                                                      x1_final, v1_final, x2_final, v2_final);

% Display the optimized control inputs and minimum cost
disp('Optimized Control Inputs:');
disp(opt_control);
disp('Minimum Cost:');
disp(min_cost);

% Animate trajectory with the optimized control inputs
animate_trajectory_script(opt_control, m1, k1, c1, m2, k2, c2, ...
                           x1_initial, v1_initial, x2_initial, v2_initial, ...
                           x1_final, v1_final, x2_final, v2_final);
