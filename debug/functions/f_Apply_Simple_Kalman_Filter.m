function [x, y, z] = f_Apply_Simple_Kalman_Filter( Acc_in )
    % This is a code I adapted from the author
    % H J Jayakrishnan
    % and which I found at: https://github.com/hjjayakrishnan
    
    n = size( Acc_in, 1 );

    % corrected state vectors
    x = zeros(n,1);
    y = zeros(n,1);
    z = zeros(n,1);
    
    % corrected error co-variance matrix
    P_x = ones(n,1);
    P_y = ones(n,1);
    P_z = ones(n,1);
    
    % predicted state vectors
    x_p = zeros(n,1);
    x_p = zeros(n,1);
    x_p = zeros(n,1);
    
    % predicted error co-variance matrix
    P_p_x = zeros(n,1);
    P_p_y = zeros(n,1);
    P_p_z = zeros(n,1);
    %P_p(1) = 2;

    % variance of disturbance noise
    Q = .01;
    
    % variance of sensor noise
    R = .1;

    for k = 1 : n - 1

        sensor_x(k+1) = Acc_in( k, 1 );
        sensor_y(k+1) = Acc_in( k, 2 );
        sensor_z(k+1) = Acc_in( k, 3 );

        % Z axis
        % prediction
        z_p(k+1) = z(k);
        P_p_z(k+1) = P_z(k) + Q;

        % correction
        K_z = P_p_z(k+1)/(P_p_z(k+1) + R);
        z(k+1) = z_p(k+1) + K_z*(sensor_z(k+1) - z_p(k+1));
        P_z(k+1) = (1 - K_z)* P_p_z(k+1);

        % Y axis
        % prediction
        y_p(k+1) = y(k);
        P_p_y(k+1) = P_y(k) + Q;

        % correction
        K_y = P_p_y(k+1)/(P_p_y(k+1) + R);
        y(k+1) = y_p(k+1) + K_y*(sensor_y(k+1) - y_p(k+1));
        P_y(k+1) = (1 - K_y)* P_p_y(k+1);

        % X axis
        % prediction
        x_p(k+1) = x(k);
        P_p_x(k+1) = P_x(k) + Q;

        % correction
        K_x = P_p_x(k+1)/(P_p_x(k+1) + R);
        x(k+1) = x_p(k+1) + K_x*(sensor_x(k+1) - x_p(k+1));
        P_x(k+1) = (1 - K_x)* P_p_x(k+1);

        if( k == 1 )
            x( k ) = x( k + 1 );
            y( k ) = y( k + 1 );
            z( k ) = z( k + 1 );
        end
    end
end
