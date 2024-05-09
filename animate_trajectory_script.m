function animate_trajectory_script(opt_control, m1, k1, c1, m2, k2, c2, x1_initial, v1_initial, x2_initial, v2_initial, x1_final, v1_final, x2_final, v2_final)
    % Simulate the system with optimized control inputs
    tspan = linspace(0, 10, 1000); % Time span for simulation
    [~, x] = ode45(@(t, x) dynamics(t, x, opt_control, m1, m2, k1, k2, c1, c2), tspan, [x1_initial; v1_initial; x2_initial; v2_initial]); % Simulate the system
    
    % Extract final positions for labeling
    x1_final_pos = x(end, 1);
    x2_final_pos = x(end, 3);

    % Initialize plot
    figure;
    hold on;
    xlabel('Position 1');
    ylabel('Position 2');
    title('Optimized Trajectory Animation');
    axis([-2 2 -2 2]);
    grid on;

    % Plot initial and final positions
    plot(x1_initial, 0, 'ro', 'MarkerSize', 10, 'DisplayName', 'Initial Position');
    plot(x2_initial, 0, 'ro', 'MarkerSize', 10);
    plot(x1_final_pos, 0, 'go', 'MarkerSize', 10, 'DisplayName', 'Final Position');
    plot(x2_final_pos, 0, 'go', 'MarkerSize', 10);

    % Animation
    for i = 1:length(tspan)
        % Compute joint and end effector positions
        x_joint1 = 0;
        y_joint1 = 0;
        x_joint2 = cos(x(i, 1)); % Extract joint positions from simulation results
        y_joint2 = sin(x(i, 1));
        x_endeffector = x_joint2 + cos(x(i, 1) + x(i, 3));
        y_endeffector = y_joint2 + sin(x(i, 1) + x(i, 3));

        % Plot arm
        plot([x_joint1, x_joint2, x_endeffector], [y_joint1, y_joint2, y_endeffector], 'b-', 'LineWidth', 2, 'DisplayName', 'Arm');
        
        % Update plot
        drawnow;
        
        % Pause for smoother animation
        pause(0.00001);
        
        % Clear previous arm plot
        if i < length(tspan)
            cla;
            plot(x1_initial, 0, 'ro', 'MarkerSize', 10);
            plot(x2_initial, 0, 'ro', 'MarkerSize', 10);
            plot(x1_final_pos, 0, 'go', 'MarkerSize', 10);
            plot(x2_final_pos, 0, 'go', 'MarkerSize', 10);
            xlabel('Position 1');
            ylabel('Position 2');
            title('Optimized Trajectory Animation');
            axis([-2 2 -2 2]);
            grid on;
        end
    end
    
    % Display legend
    legend('show');
end
