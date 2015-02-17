function [array, array_types, array_types_as_numbers, array_time, array_counter, array_values] = f_doImport_From_Text_File( filename )
    format = '%c, %li, %i, %f, %f, %f\n';
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
    return;
end
