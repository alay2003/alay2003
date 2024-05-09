function cost = cost_function(control, m1, m2, k1, k2, c1, c2, x1_initial, v1_initial, x2_initial, v2_initial, x1_final, v1_final, x2_final, v2_final)
    % Simulate the system with given control inputs
    tspan = linspace(0, 10, 1000); % Time span for simulation
    [~, x] = ode45(@(t, x) dynamics(t, x, control, m1, m2, k1, k2, c1, c2), tspan, [x1_initial; v1_initial; x2_initial; v2_initial]); % Simulate the system
    
    % Compute the total energy of the system
    total_energy = 0.5 * sum(m1 * x(end, 2)^2 + k1 * x(end, 1)^2 + c1 * x(end, 2)^2 + ...
                             m2 * x(end, 4)^2 + k2 * x(end, 3)^2 + c2 * x(end, 4)^2);
    
    % Penalty for deviation from initial and final positions
    penalty = (x(end, 1) - x1_final)^2 + (x(end, 2) - v1_final)^2 + (x(end, 3) - x2_final)^2 + (x(end, 4) - v2_final)^2;
    
    % Combine cost and penalty
    cost = total_energy + penalty;
end
