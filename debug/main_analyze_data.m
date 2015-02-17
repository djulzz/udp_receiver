% main_analyze_data.m
clear all;
close all;
clc;

options.doPlot_accelerometer = false;
options.doSave_data = true;

format = '%c, %li, %i, %f, %f, %f\n';

filename = 'data_Mon Feb 16 11_54_06 2015.txt';

f = fopen( filename, 'r' );

array                   = [  ];
array_types             = [  ];
array_types_as_numbers  = [  ];
array_time              = [  ];
array_counter           = [  ];
array_values            = [  ];

while( ~feof( f ) )
    s = fgets( f );
    A = sscanf( s, format );
    
    type = char( A( 1 ) );

    time = A( 2 );
    counter = A( 3 );
    vals = A( 4 : 6 )';
    array = [array; {type, time, counter, vals}];
    
    array_types = [array_types, type];
    array_types_as_numbers = [array_types_as_numbers, A( 1 )];
    array_time = [array_time, time];
    array_counter = [array_counter, counter];
    array_values = [array_values; vals];
end

nValues = size( array_values, 1 );

first_time = array_time( 1 );
array_time = array_time - array_time( 1 );

delta_time = diff( array_time );
avg_T = sum( delta_time ) / length( delta_time );
avg_T = avg_T / 1000; % convert ms to secs.
avg_Fs = 1 / avg_T;

fprintf( 'avg_T = %.2f sec\n', avg_T );
fprintf( 'avg_Fs = %.2f Hz\n', avg_Fs );

% sort values
array_accels = [  ];
array_mag = [  ];
array_gyros = [  ];
for i = 1 : 1 : nValues
    if( array_types( i ) == 'A' )
        array_accels = [array_accels; [array_time( i ), array_values( i, : )]];
    elseif( array_types( i ) == 'M' )
        array_mag = [array_mag; [array_time( i ), array_values( i, : )]];
    elseif( array_types( i ) == 'O' )
        array_gyros = [array_gyros; [array_time( i ), array_values( i, : )]];
    end
end

if( true == options.doPlot_accelerometer )
    hFig = figure;
    set( hFig, 'Color', 'White' );
    hold on;
    plot( array_accels( :, 1 ), array_accels( :, 2 ), 'Color', 'Red' );
    plot( array_accels( :, 1 ), array_accels( :, 3 ), 'Color', 'Green' );
    plot( array_accels( :, 1 ), array_accels( :, 4 ), 'Color', 'Blue' );
end

% hFig2 = figure;
% hold on;
% plot( array_accels( :, 2 ), array_accels( :, 3 ), 'Color', 'Red' );
array = [array_accels( :, 1 ), array_mag( :, 1 ), array_gyros( :, 1 )];

diff_a = diff( array_accels( :, 1 ) );
diff_m = diff( array_mag( :, 1 ) );
diff_g = diff( array_gyros( :, 1 ) );

avg_T_a = sum( diff_a ) / length( diff_a );
avg_T_m = sum( diff_m ) / length( diff_m );
avg_T_g = sum( diff_g ) / length( diff_g );

% convert ms to secs;
avg_T_a = avg_T_a / 1000;
avg_T_m = avg_T_m / 1000;
avg_T_g = avg_T_g / 1000;

avg_Fs_a = 1 / avg_T_a;
avg_Fs_m = 1 / avg_T_m;
avg_Fs_g = 1 / avg_T_g;

fprintf( 'Fs_a = %.2f Hz\n', avg_Fs_a );
fprintf( 'Fs_m = %.2f Hz\n', avg_Fs_m );
fprintf( 'Fs_g = %.2f Hz\n', avg_Fs_g );

upper_t = max( [array_accels( end, 1 ), array_mag( end, 1 ), array_gyros( end, 1 )] );
lower_t = min( [array_accels( 1, 1 ), array_mag( 1, 1 ), array_gyros( 1, 1 )] );
timespan_ms = [lower_t, upper_t];

nElements_a = size( array_accels( :, 1 ), 1 );
nElements_m = size( array_mag( :, 1 ), 1 );
nElements_o = size( array_gyros( :, 1 ), 1 );

same_size_tf = ( ( nElements_a == nElements_m ) && ( nElements_m == nElements_o ) );
if( true == same_size_tf )
    directory = 'C:\Users\djulzz\Desktop\madgwick_algorithm_matlab\';
    filename = '02_16_2015.mat';
    A_SI_to_Gs = ( 1 / 9.81 );
    G_SI_to_DegS = ( 180 / pi );
    uT_to_Gauss = 0.01;
    ms_to_Sec = ( 1 / 1000 );
    % 1 Tesla = 10 000 Gauss
    Accelerometer   = A_SI_to_Gs * array_accels( :, 2 : 1 : 4 ); % m / s / s
    Gyroscope       = G_SI_to_DegS * array_gyros( :, 2 : 1 : 4 ); % rad / s
    Magnetometer    = uT_to_Gauss * array_mag( :, 2 : 1 : 4 ); % Micro Tesla
    time            = ms_to_Sec * linspace( lower_t, upper_t, nElements_o);
    if( true == options.doSave_data )
        save( [directory ,filename], 'Accelerometer', 'Gyroscope', 'Magnetometer','time' );
        fprintf( 'Saved!\n' );
    end

    n = nElements_o;
    z = zeros(n,1);
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

    for k=1:n-1

        sensor_x(k+1) = Accelerometer( k, 1 );
        sensor_y(k+1) = Accelerometer( k, 2 );
        sensor_z(k+1) = Accelerometer( k, 3 );


        % Z axis
        % prediction

        z_p(k+1) = z(k);
        P_p_z(k+1) = P_z(k) + Q;

        % correction

        K_z = P_p_z(k+1)/(P_p_z(k+1) + R);
        z(k+1) = z_p(k+1) + K_z*(sensor_z(k+1) - z_p(k+1));
        P_z(k+1) = (1 - K_z)* P_p_z(k+1);

        % plotting

        title('Z axis accelerometer ');
        subplot(3,1,1);
        plot(k,z(k),'-ro',k,sensor_z(k), '-b*');
        axis([0 k+10 0 20]);
        pause(.0001);
        drawnow
        grid on
        hold on;

        % Y axis
        % prediction

        y_p(k+1) = y(k);
        P_p_y(k+1) = P_y(k) + Q;

        % correction

        K_y = P_p_y(k+1)/(P_p_y(k+1) + R);
        y(k+1) = y_p(k+1) + K_y*(sensor_y(k+1) - y_p(k+1));
        P_y(k+1) = (1 - K_y)* P_p_y(k+1);

        % plotting

        title('Y axis accelerometer ');
        subplot(3,1,2);
        plot(k,y(k),'-ro',k,sensor_y(k), '-b*');
        axis([0 k+10 0 20]);
        pause(.0001);
        drawnow
        grid on
        hold on;

        % X axis
        % prediction

        x_p(k+1) = x(k);
        P_p_x(k+1) = P_x(k) + Q;

        % correction

        K_x = P_p_x(k+1)/(P_p_x(k+1) + R);
        x(k+1) = x_p(k+1) + K_x*(sensor_x(k+1) - x_p(k+1));
        P_x(k+1) = (1 - K_x)* P_p_x(k+1);

        % plotting

        title('X axis accelerometer ');
        subplot(3,1,3);
        plot(k,x(k),'-ro',k,sensor_x(k), '-b*');
        axis([0 k+10 0 20]);
        pause(.0001);
        drawnow
        grid on
        hold on;

    end
    
    
end
