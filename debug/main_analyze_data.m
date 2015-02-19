% main_analyze_data.m

clear all;
close all;
clc;

addpath( './functions/' );

options.doPlot_accelerometer                = false;
options.doPlot_gyroscope                    = false;
options.doSave_data                         = false;

% Import and MAT-export data from textfile and to MAT file
options.doImport_From_Text_File             = false;
options.doSave_Data_Imported_From_Text_File = false;

options.doImport_Data_From_MAT_File         = true;
options.doApply_conversion_factors          = false;


filename = 'data_Mon Feb 16 11_54_06 2015.txt';
c = strsplit( filename, '.' );
filename_data_export = [ c{ 1 }, '.mat' ];

directory = './';
filenameRenamedData = '02_16_2015.mat';

% Import Data from Text file
if( true == options.doImport_From_Text_File )
    [~, array_types, array_types_as_numbers, array_time, array_counter, array_values] = f_doImport_From_Text_File( filename );

    if( true == options.doSave_Data_Imported_From_Text_File )
        c = strsplit( filename, '.' );
        filename_data_export = [ c{ 1 }, '.mat' ];
        save( filename_data_export, 'array', 'array_types',...
            'array_types_as_numbers',...
        'array_time', 'array_counter', 'array_values' );
    end
end

if( true == options.doImport_Data_From_MAT_File )
    load( filename_data_export );
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

if( true == options.doPlot_gyroscope )
    hFig = figure;
    set( hFig, 'Color', 'White' );
    hold on;
    plot( array_gyros( :, 1 ), array_gyros( :, 2 ), 'Color', 'Red' );
    plot( array_gyros( :, 1 ), array_gyros( :, 3 ), 'Color', 'Green' );
    plot( array_gyros( :, 1 ), array_gyros( :, 4 ), 'Color', 'Blue' );
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

    A_SI_to_Gs = ( 1 / 9.81 );
    G_SI_to_DegS = ( 180 / pi );
    uT_to_Gauss = 0.01;
    ms_to_Sec = ( 1 / 1000 );
    % 1 Tesla = 10 000 Gauss
    Accelerometer   = array_accels( :, 2 : 1 : 4 ); % m / s / s
    Gyroscope       = array_gyros( :, 2 : 1 : 4 ); % rad / s
    Magnetometer    = array_mag( :, 2 : 1 : 4 ); % Micro Tesla
    time            = ms_to_Sec * linspace( lower_t, upper_t, nElements_o );
    if( true == options.doApply_conversion_factors )
        Accelerometer   = A_SI_to_Gs * Accelerometer; % Gs
        Gyroscope       = G_SI_to_DegS * Gyroscope; % deg / s
        Magnetometer    = uT_to_Gauss * Magnetometer; % Gauss
    end
    
    if( true == options.doSave_data )
        save( [directory ,filename], 'Accelerometer', 'Gyroscope', 'Magnetometer','time' );
        fprintf( 'Saved!\n' );
    end

    [x, y, z] = f_Apply_Simple_Kalman_Filter3( array_accels( :, 2 : 1 : 4 ) );
    hFig = figure;
    set( hFig, 'Color', 'White' );
    
    kalman.color = 'Black';
    kalman.LineStyle = ':';
    kalman.LineWidth = 2;
    nRows = 3;
    nCols = 1;
    
    plot_idx = 1; sig = x;
    subplot( nRows, nCols, plot_idx );
    hold on;
    plot( array_accels( :, 2 ), 'Color', 'Red' );
    plot( sig, 'Color', kalman.color, 'LineStyle', kalman.LineStyle, 'LineWidth', kalman.LineWidth );
    
    plot_idx = 2; sig = y;
    subplot( nRows, nCols, plot_idx );
    hold on;
    plot( array_accels( :, 3 ), 'Color', 'Green' );
    plot( sig, 'Color', kalman.color, 'LineStyle', kalman.LineStyle, 'LineWidth', kalman.LineWidth );
    
    plot_idx = 3; sig = z;
    subplot( nRows, nCols, plot_idx );
    hold on;
    plot( array_accels( :, 4 ), 'Color', 'Blue' );
    plot( sig, 'Color', kalman.color, 'LineStyle', kalman.LineStyle, 'LineWidth', kalman.LineWidth );
end
