% main_analyze_data.m
clear all;
close all;
clc;

options.doPlot_accelerometer = true;

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
