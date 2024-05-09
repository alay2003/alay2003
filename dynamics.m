function dx = dynamics(t, x, control, m1, m2, k1, k2, c1, c2)
    % Extract states
    x1 = x(1);
    v1 = x(2);
    x2 = x(3);
    v2 = x(4);
    
    % Compute accelerations
    a1 = (control(1) - k1 * x1 - c1 * v1) / m1;
    a2 = (control(2) - k2 * x2 - c2 * v2) / m2;
    
    % Return derivatives of state variables
    dx = [v1; a1; v2; a2];
end
