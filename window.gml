#define WindowCreate
///WindowCreate( width, height, scale )
   var Wind = ds_grid_create( $01, $04 );
   Wind[# $00, WP_WIDTH ] = argument[ $00 ];
   Wind[# $00, WP_HEIGHT ] = argument[ $01 ];
   Wind[# $00, WP_SCALE ] = argument[ $02 ];
   Wind[# $00, WP_RESOLUTION ] = argument[ $01 ] / argument[ $00 ];
   return Wind;


#define WindowHidden
///WindowHidden()
   return ( window_get_width() == $00 && window_get_height() == $00 );


#define WindowUpdate
///WindowUpdate( window )
   var Wind = argument[ $00 ];
   var WindWidth = Wind[# $00, WP_WIDTH ], WindHeight = Wind[# $00, WP_HEIGHT ];
   var WindUpdateW = window_get_width(), WindUpdateH = window_get_height();
   
   if ( ( WindWidth != WindUpdateW || WindHeight != WindUpdateH ) &&
   ( WindUpdateW > $00 && WindUpdateH > $00 ) ) {
      display_reset( $00, false );
      
      var wx = window_get_x(), wy = window_get_y();
      wx += ( WindUpdateW - WindWidth ) / 2;
      wy += ( WindUpdateH - WindHeight ) / 2;
      window_set_position( wx, wy );
      window_set_size( WindWidth, WindHeight );
   }
   
   if ( display_get_gui_width() != WindUpdateW || display_get_gui_height() != WindUpdateH ) {
      display_set_gui_size( WindUpdateW, WindUpdateH );
   }


#define WindowGuiX
///WindowGuiX( window, scene )
   var Wind = argument[ $00 ], Scene = argument[ $01 ];
   var ScaleX = Scene[# $00, SP_WIDTH ] * Wind[# $00, WP_SCALE ];
   return ( display_get_gui_width() - ScaleX ) >> $01;


#define WindowGuiY
///WindowGuiY( window, scene )
   var Wind = argument[ $00 ], Scene = argument[ $01 ];
   var ScaleY = Scene[# $00, SP_HEIGHT ] * Wind[# $00, WP_SCALE ];
   return ( display_get_gui_height() - ScaleY ) >> $01;


#define WindowSetMin
///WindowSetMin( minw, minh )
   window_set_min_width( argument[ $00 ] );
   window_set_min_height( argument[ $01 ] );


#define WindowSetMax
///WindowSetMax( maxw, maxh )
   window_set_min_width( argument[ $00 ] );
   window_set_min_height( argument[ $01 ] );


#define WindowSetRes
///WindowSetRes( window, xfactor, yfactor )
   var Wind = argument[ $00 ];
   var Xfact = argument[ $01 ], Yfact = argument[ $02 ];
   var Res = AspectRatio( Yfact, Xfact );
   Wind[# $00, WP_HEIGHT ] = ceil( Wind[# $00, WP_WIDTH ] * Res );

#define WindowDraw
///WindowDraw( window, scene, guix, guiy, xorigin, yorigin, angle, absolute )
   var Wind = argument[ $00 ], Scene = argument[ $01 ],
   GuiX = argument[ $02 ], GuiY = argument[ $03 ],
   ScaleX = AspectRatio( $01, Scene[# $00, SP_WIDTH ] ) * ( Wind[# $00, WP_WIDTH ] * Wind[# $00, WP_SCALE ] );
   
   var ScaleY = $00;
   if ( argument[ $07 ] ) {
      ScaleY = AspectRatio( $01, Scene[# $00, SP_HEIGHT ] ) * ( Wind[# $00, WP_HEIGHT ] * Wind[# $00, WP_SCALE ] );
   } else {
      ScaleY = AspectRatio( $01, Scene[# $00, SP_HEIGHT ] ) * ( ( Wind[# $00, WP_WIDTH ] * Scene[# $00, SP_RESOLUTION ] ) * Wind[# $00, WP_SCALE ] );
   }
   
   DrawSurfaceExt( application_surface, GuiX, GuiY, ScaleX, ScaleY, argument[ $04 ], argument[ $05 ], argument[ $06 ], $FFFFFF, $01 );

#define WindowSetSize
///WindowSetSize( window, width, height )
   var Wind = argument[ $00 ];
   Wind[# $00, WP_WIDTH ] = argument[ $01 ];
   Wind[# $00, WP_HEIGHT ] = argument[ $02 ];
   Wind[# $00, WP_RESOLUTION ] = argument[ $02 ] / argument[ $01 ];

#define WindowAutoDraw
///WindowAutoDraw( draw )
   application_surface_draw_enable( argument[ $00 ] );


#define WindowIsUpdated
///WindowIsUpdated( window )
   var Wind = argument[ $00 ];
   var WindWidth = Wind[# $00, WP_WIDTH ], WindHeight = Wind[# $00, WP_HEIGHT ];
   var WindUpdateW = window_get_width(), WindUpdateH = window_get_height();
   return ( WindWidth == WindUpdateW && WindHeight == WindUpdateH ) && ( WindUpdateW > $00 && WindUpdateH > $00 );

