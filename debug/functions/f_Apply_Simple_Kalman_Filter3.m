function [x, y, z] = f_Apply_Simple_Kalman_Filter3( Acc_in )
    % This is a code I adapted from the author
    % H J Jayakrishnan
    % and which I found at: https://github.com/hjjayakrishnan
    
    n = size( Acc_in, 1 );

    % corrected state vectors
%     x = zeros(n,1);
%     y = zeros(n,1);
%     z = zeros(n,1);
    
    
    x_hat = zeros( 3, 1, n );
    
    % corrected error co-variance matrix
    P( :, :, n ) = eye( 3 );
    
    % predicted state vectors
    x_hat_bar( :, :, n ) = zeros( 3, 1 );
    
    % predicted error co-variance matrix
    P_bar( :, :, n ) = eye( 3 );

    % variance of disturbance noise
    Q = .01 * eye( 3 );

    % variance of sensor noise
    R = .1 * eye( 3 );

    A = [1, 0, 0;
         0, 1, 0;
         0, 0, 1];
        
    B = [ 0 ];
    
    H = [1, 0, 0;
         0, 1, 0,
         0, 0, 1];
     

	stop = ( n - 1 );
    for k = 1 : stop


        sensor( :, :, k + 1 ) = Acc_in( k + 1, : )';

        % prediction
        x_hat_bar( :, :, k + 1 ) = A * x_hat( :, :, k );

        % prediction
        P_bar( :, :, k + 1 ) = P( :, :, k ) + Q;

        
        % correction
        K_z = P_bar( :, :, k + 1 ) / ( P_bar( :, :, k + 1 ) + R );
        deter = abs(  K_z );
        if( deter < eps )
            fprintf( 'K_z is singular for k = %i\n', k );
            break;
        end
        x_hat( :, :, k + 1 ) = x_hat_bar( :, :, k + 1 ) + K_z*( sensor( :, :, k + 1 ) - x_hat_bar( :, :, k + 1 ) );
        P( :, :, k + 1 ) = ( eye( 3 ) - K_z )* P_bar( :, :, k + 1 );
    end
    
    nCols = 1;
    
    row_x = 1;
    row_y = 2;
    row_z = 3;
    
    nElems = size( x_hat, 3 );
    
    x = reshape( x_hat( row_x, nCols, : ), nElems, 1 );
    y = reshape( x_hat( row_y, nCols, : ), nElems, 1 );
    z = reshape( x_hat( row_z, nCols, : ), nElems, 1 );
end
