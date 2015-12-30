#define DrawSurfaceExt
///DrawSurfaceExt( surface, xpos, ypos, xscale, yscale, xorigin, yorigin, angle, blend, alpha )
   var Surface = argument[ $00 ], Xpos = argument[ $01 ], Ypos = argument[ $02 ],
   Xscale = argument[ $03 ], Yscale = argument[ $04 ], Xorig = argument[ $05 ],
   Yorig = argument[ $06 ], Angle = argument[ $07 ], Color = argument[ $08 ],
   Alpha = argument[ $09 ];
   
   if ( Xscale == $00 || Yscale == $00 ) {
      return TY_FALSE;
   }
   
   if ( Xorig == $00 && Yorig == $00 ) {
      draw_surface_ext( Surface, Xpos, Ypos, Xscale, Yscale, Angle, Color, Alpha );
      return TY_FALSE;
   }
   
   var X1 = Xscale * Xorig, Y1 = Yscale * Yorig, X2, Y2,
   Height = sqrt( sqr( X1 ) + sqr( Y1 ) ), Radians = degtorad( Angle ), Angle1, Angle2;
   
   if ( X1 != $00 ) {
      Angle1 = arctan( Y1 / X1 );
   } else {
      Angle1 = pi / $02;
   }
   
   Angle2 = Angle1 - Radians;
   X2 = cos( Angle2 ) * Height;
   Y2 = sin( Angle2 ) * Height;
   
   if ( X1 < $00 ) {
      X2 *= -$01;
      Y2 *= -$01;
   }
   
   draw_surface_ext( Surface, Xpos - X2, Ypos - Y2, Xscale, Yscale, Angle, Color, Alpha );
