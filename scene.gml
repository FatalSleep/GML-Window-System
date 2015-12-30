#define SceneCreate
///SceneCreate( viewid, xpos, ypos, width, height, hborder, vborder, hspd, vspd, scale, angle, visible, enable )
   var Scene = ds_grid_create( $01, $0E );
   Scene[# $00, SP_INDEX ] = argument[ $00 ];
   Scene[# $00, SP_XPOS ] = argument[ $01 ];
   Scene[# $00, SP_YPOS ] = argument[ $02 ];
   Scene[# $00, SP_WIDTH ] = argument[ $03 ];
   Scene[# $00, SP_HEIGHT ] = argument[ $04 ];
   Scene[# $00, SP_HBORDER ] = argument[ $05 ];
   Scene[# $00, SP_VBORDER ] = argument[ $06 ];
   Scene[# $00, SP_HSPEED ] = argument[ $07 ];
   Scene[# $00, SP_VSPEED ] = argument[ $08 ];
   Scene[# $00, SP_SCALE ] = argument[ $09 ];
   Scene[# $00, SP_ANGLE ] = argument[ $0A ];
   Scene[# $00, SP_VISIBLE ] = argument[ $0B ];
   Scene[# $00, SP_ENABLED ] = argument[ $0C ];
   Scene[# $00, SP_RESOLUTION ] = argument[ $04 ] / argument[ $03 ];
   return Scene;


#define SceneContact
///SceneContact( scene, xpos, ypos )
   var Scene = argument[ $00 ];
   var Xpos = argument[ $01 ], Ypos = argument[ 2 ];
   
   return ( Xpos >= Scene[# $00, SP_XPOS ] + Scene[# $00, SP_HBORDER ] &&
   Ypos >= Scene[# $00, SP_YPOS ] + Scene[# $00, SP_VBORDER ] &&
   Xpos <= Scene[# $00, SP_XPOS ] + Scene[# $00, SP_WIDTH ] - Scene[# $00, SP_HBORDER ] &&
   Ypos <= Scene[# $00, SP_YPOS ] + Scene[# $00, SP_HEIGHT ] - Scene[# $00, SP_VBORDER ] );


#define SceneUpdate
///SceneUpdate( scene, xpos, ypos )
   var Scene = argument[ $00 ];
   var Xpos = argument[ $01 ], Ypos = argument[ $02 ];
   
   var BoundLeft = Xpos < ( Scene[# $00, SP_XPOS ] + Scene[# $00, SP_HBORDER ] );
   var BoundRight = Xpos > ( Scene[# $00, SP_XPOS ] + Scene[# $00, SP_WIDTH ] - Scene[# $00, SP_HBORDER ] );
   
   if ( BoundLeft || BoundRight ) {
      if ( Scene[# $00, SP_HSPEED ] > $00 ) {
         Scene[# $00, SP_XPOS ] += Scene[# $00, SP_HSPEED ] * ( BoundRight - BoundLeft );
      } else {
         switch( BoundRight - BoundLeft ) {
            case -$01:
               Scene[# $00, SP_XPOS ] = Xpos - Scene[# $00, SP_HBORDER ];
            break;
            case $01:
               Scene[# $00, SP_XPOS ] = Xpos + Scene[# $00, SP_WIDTH ] - Scene[# $00, SP_HBORDER ];
            break;
         }
      }
   }
   
   var BoundTop = Ypos < ( Scene[# $00, SP_YPOS ] + Scene[# $00, SP_VBORDER ] );
   var BoundBottom = Ypos > ( Scene[# $00, SP_YPOS ] + Scene[# $00, SP_HEIGHT ] - Scene[# $00, SP_VBORDER ] );
   
   if ( BoundTop || BoundBottom ) {
      if ( Scene[# $00, SP_VSPEED ] > $00 ) {
         Scene[# $00, SP_YPOS ] += Scene[# $00, SP_VSPEED ] * ( BoundBottom - BoundTop );
      } else {
         switch( BoundBottom - BoundTop ) {
            case -$01:
               Scene[# $00, SP_YPOS ] = Ypos - Scene[# $00, SP_VBORDER ];
            break;
            case $01:
               Scene[# $00, SP_YPOS ] = Ypos + Scene[# $00, SP_HEIGHT ] - Scene[# $00, SP_VBORDER ];
            break;
         }
      }
   }


#define SceneRefresh
///SceneRefresh( scene )
   var Scene = argument[ $00 ];
   var Index = Scene[# $00, SP_INDEX ];
   
   view_xview[ Index ] = Scene[# $00, SP_XPOS ];
   view_yview[ Index ] = Scene[# $00, SP_YPOS ];
   view_wview[ Index ] = Scene[# $00, SP_WIDTH ] * Scene[# $00, SP_SCALE ];
   view_hview[ Index ] = Scene[# $00, SP_HEIGHT ] * Scene[# $00, SP_SCALE ];
   view_wport[ Index ] = view_wview[ Index ];
   view_hport[ Index ] = view_hview[ Index ];
   view_angle[ Index ] = Scene[# $00, SP_ANGLE ];
   view_enabled[ Index ] = Scene[# $00, SP_ENABLED ];
   view_visible[ Index ] = Scene[# $00, SP_VISIBLE ];
   
   if ( ( Scene[# $00, SP_WIDTH ] != surface_get_width( application_surface ) ||
   Scene[# $00, SP_HEIGHT ] != surface_get_height( application_surface ) ) &&
   ( Scene[# $00, SP_WIDTH ] > $00 && Scene[# $00, SP_HEIGHT ] > $00 ) ) {
      surface_resize( application_surface, Scene[# $00, SP_WIDTH ], Scene[# $00, SP_HEIGHT ] );
   }


#define SceneRefreshExt
///SceneRefreshExt( scene, trigger )
   var Scene = argument[ $00 ];
   var Trigger = argument[ $01 ];
   var Index = Scene[# $00, SP_INDEX ];
   
   if ( ds_exists( Trigger, ds_type_grid ) ) {
      if ( Trigger[? TP_ACTIVE ] ) {
         if ( Trigger[? TP_ABSOLUTE ] ) {
            view_xview[ Index ] = Trigger[# $00, TP_XPOS ];
            view_yview[ Index ] = Trigger[# $00, TP_YPOS ];
         } else {
            view_xview[ Index ] = Scene[# $00, SP_XPOS ] + Trigger[# $00, TP_XPOS ];
            view_yview[ Index ] = Scene[# $00, SP_YPOS ] + Trigger[# $00, TP_YPOS ];
         }
      }
   } else {
      view_xview[ Index ] = Scene[# $00, SP_XPOS ];
      view_yview[ Index ] = Scene[# $00, SP_YPOS ];
   }
   
   view_wview[ Index ] = Scene[# $00, SP_WIDTH ] * Scene[# $00, SP_SCALE ];
   view_hview[ Index ] = Scene[# $00, SP_HEIGHT ] * Scene[# $00, SP_SCALE ];
   view_wport[ Index ] = view_wview[ Index ];
   view_hport[ Index ] = view_hview[ Index ];
   view_angle[ Index ] = Scene[# $00, SP_ANGLE ];
   view_enabled[ Index ] = Scene[# $00, SP_ENABLED ];
   view_visible[ Index ] = Scene[# $00, SP_VISIBLE ];
   
   if ( ( Scene[# $00, SP_WIDTH ] != surface_get_width( application_surface ) ||
   Scene[# $00, SP_HEIGHT ] != surface_get_height( application_surface ) ) &&
   Scene[# $00, SP_WIDTH ] > $00 && Scene[# $00, SP_HEIGHT ] > $00 ) {
      surface_resize( application_surface, Scene[# $00, SP_WIDTH ], Scene[# $00, SP_HEIGHT ] );
   }


#define SceneSetSize
///SceneSetSize( scene, width, height )
   var Scene = argument[ $00 ];
   Scene[# $00, SP_WIDTH ] = argument[ $01 ];
   Scene[# $00, SP_HEIGHT ] = argument[ $02 ];
   Scene[# $00, SP_RESOLUTION ] = argument[ $02 ] / argument[ $01 ];

#define SceneSetRes
///SceneSetRes( scene, xfactor, yfactor )
   var Scene = argument[ $00 ];
   var Xfact = argument[ $01 ], Yfact = argument[ $02 ];
   var Res = AspectRatio( Yfact, Xfact );
   Scene[# $00, SP_HEIGHT ] = ceil( Scene[# $00, SP_WIDTH ] * Res );

#define SceneIsUpdated
///SceneIsUpdated( scene )
   var Scene = argument[ $00 ];
   return ( Scene[# $00, SP_WIDTH ] == surface_get_width( application_surface ) &&
   Scene[# $00, SP_HEIGHT ] == surface_get_height( application_surface ) ) &&
   ( Scene[# $00, SP_WIDTH ] > $00 && Scene[# $00, SP_HEIGHT ] > $00 );

