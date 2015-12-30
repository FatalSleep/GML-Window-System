#define AspectRatio
///AspectRatio( width, height )
   return argument[ $00 ] / argument[ $01 ];


#define ParamsDestroy
///ParamsDestroy( params )
   var Params = argument[ 0 ], Check = ds_exists( Params, ds_type_grid );
  
   if ( Check ) {
      ds_grid_destroy( Params );
   }
   
   return Check;


#define ShowDebugMsg
///ShowDebugMsg( string, param1, param2, param3, ... )
    var builder = argument[ $00 ];
    
    for( var i = 1; i < argument_count; i ++ ) {
        builder = string_replace_all( builder, "{" + string( i - 1 ) +"}", string( argument[ i ] ) );
    }
    
    show_debug_message( builder );
