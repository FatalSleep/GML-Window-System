#define TriggerCreate
///TriggerCreate( type, active, absolute, xpos, ypos, stop, repeat )
   var Trigger = ds_grid_create( $01, $08 );
   Trigger[# $00, TP_INDEX ] = argument[ $00 ];
   Trigger[# $00, TP_ACTIVE ] = argument[ $01 ];
   Trigger[# $00, TP_ABSOLUTE ] = argument[ $02 ];
   Trigger[# $00, TP_XPOS ] = argument[ $03 ];
   Trigger[# $00, TP_YPOS ] = argument[ $04 ];
   Trigger[# $00, TP_STOP ] = argument[ $05 ];
   Trigger[# $00, TP_REPEAT ] = argument[ $06 ];
   Trigger[# $00, TP_TIMER ] = $00;
   return Trigger;

#define TriggerRun
///TiggerRun( trigger )
   var Trigger = argument[ $00 ];
   
   if ( Trigger[# $00, TP_TIMER ] >= Trigger[# $00, TP_STOP ] ) {
      if ( Trigger[# $00, TP_REPEAT ] ) {
         Trigger[# $00, TP_TIMER ] = $00;
      };
   } else {
      Trigger[# $00, TP_TIMER ] ++;
   }
