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

    A = [1, 0, 0;
         0, 1, 0;
         0, 0, 1];
    
%     R_mat = R * [1, 0, 0;
%                  0, 1, 0;
%                  0, 0, 1];
%              
%     P( :, :, 1 ) = [0, 0, 0;
%                     0, 0, 0;
%                     0, 0, 0];
%                 
%     Q_mat( :, :, 1 ) = 0.01 * [ 1, 0, 0;
%                                 0, 1, 0;
%                                 0, 0, 1];
                
    B = [ 0 ];
    
    H = [1, 0, 0;
         0, 1, 0,
         0, 0, 1];
     
%     v( :, :, 1 ) = [0, 0, 0]';
%     state( :, :, 1 ) = [Acc_in( 1, 1 ), Acc_in( 1, 2 ), Acc_in( 1, 3 )]'; 
%     z_mat( :, :, 1 ) = H * state( :, :, 1 ) + v( :, :, 1 );
%     u( 1 ) = 0;
%     x_hat( :, :, 1 ) = state( :, :, 1 );
%     x_hat_bar( :, :, 1 ) = state( :, :, 1 );
%     P_bar( :, :, 1 ) = [1, 0, 0; 
%                         0, 1, 0;
%                         0, 0, 1];
                    
    AT = A';
    for k = 1 : n - 1

        sensor_x( k + 1 ) = Acc_in( k + 1, 1 );
        sensor_y( k + 1 ) = Acc_in( k + 1, 2 );
        sensor_z( k + 1 ) = Acc_in( k + 1, 3 );

%         v( :, :, k + 1 ) = [0, 0, 0]';
%         
%         state( :, :, k + 1 ) = [Acc_in( k + 1, 1 ), Acc_in( k + 1, 2 ), Acc_in( k + 1, 3 )]';
%         z_mat( :, :, k + 1 ) = H * state( :, :, k + 1 ) + v( :, :, k + 1 );
        % prediction
        z_p( k + 1 ) = z( k );
        y_p( k + 1 ) = y( k );
        x_p( k + 1 ) = x( k );
        
        u( k + 1 ) = 0;
        
        % What we need
%         x_hat( :, :, k + 1 ) = x_hat( :, :, k );
%         
%         x_hat_bar( :, :, k + 1 ) = A * x_hat( :, :, k ) + B * u( k + 1 );
% 
%         P_bar( :, :, k + 1 ) = A * P( :, :, k ) * ( A' ) + Q_mat( :, :, k );
%         K( :, :, k + 1 ) = P_bar( :, :, k + 1 ) * ( H' ) * ( inv( H * P_bar( :, :, k + 1 ) * ( H') + R_mat ) );
%         x_hat( :, :, k + 1 ) = x_hat_bar( k + 1 ) + K( :, :, k + 1 ) * ( z_mat( :, :, k + 1 ) - H * x_hat_bar( :, :, k + 1 ) ); 
%         P( :, :, k + 1 ) = ( [1, 0, 0; 0, 1, 0; 0, 0, 1] - K( :, :, k + 1 )* H ) * P_bar( :, :, k + 1 );
%         Q_mat( :, :, k + 1 ) = ( Q_mat( :, :, k )^2 ) / ( A * P( :, :, k ) * ( A' ) + P_bar( :, :, k + 1 ) + Q_mat( :, :, k ) );
        % prediction
        P_p_z(k+1) = P_z(k) + Q;
        P_p_y(k+1) = P_y(k) + Q;
        P_p_x(k+1) = P_x(k) + Q;
        
        % correction
        K_z = P_p_z(k+1)/(P_p_z(k+1) + R);
        z(k+1) = z_p(k+1) + K_z*(sensor_z(k+1) - z_p(k+1));
        P_z(k+1) = (1 - K_z)* P_p_z(k+1);

        K_y = P_p_y(k+1)/(P_p_y(k+1) + R);
        y(k+1) = y_p(k+1) + K_y*(sensor_y(k+1) - y_p(k+1));
        P_y(k+1) = (1 - K_y)* P_p_y(k+1);

        K_x = P_p_x(k+1)/(P_p_x(k+1) + R);
        x(k+1) = x_p(k+1) + K_x*(sensor_x(k+1) - x_p(k+1));
        P_x(k+1) = (1 - K_x)* P_p_x(k+1);

        % handling k = 1
        if( k == 1 )
            x( k ) = x( k + 1 );
            y( k ) = y( k + 1 );
            z( k ) = z( k + 1 );
        end
    end
    
    nCols = 1;
    
    row_x = 1;
    row_y = 2;
    row_z = 3;
    
%     x = x_hat( row_x, nCols, : );
%     y = x_hat( row_y, nCols, : );
%     z = x_hat( row_z, nCols, : );
end
