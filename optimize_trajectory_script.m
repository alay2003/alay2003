function [opt_control, min_cost] = optimize_trajectory_script(m1, m2, k1, k2, c1, c2, x1_initial, v1_initial, x2_initial, v2_initial, x1_final, v1_final, x2_final, v2_final)
    % Define the optimization problem
    initial_guess = zeros(2, 1);
    lb = [-1; -1];
    ub = [1; 1];
    obj_fun = @(control) cost_function_script(control, m1, m2, k1, k2, c1, c2, x1_initial, v1_initial, x2_initial, v2_initial, x1_final, v1_final, x2_final, v2_final);
    
    % Define options for fmincon
    options = optimoptions('fmincon', 'Display', 'iter', 'OutputFcn', @outputFcn);
    
    % Perform the optimization
    [opt_control, min_cost] = fmincon(obj_fun, initial_guess, [], [], [], [], lb, ub, [], options);

    % Nested function to output iteration information
    function stop = outputFcn(~, optimValues, state)
        stop = false;
        switch state
            case 'iter'
                disp(['Iteration: ', num2str(optimValues.iteration)]);
                disp(['Cost: ', num2str(optimValues.fval)]);
            case 'done'
                disp('Optimization completed.');
        end
    end
end
