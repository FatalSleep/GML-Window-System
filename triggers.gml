#define TriggerCreate
///TriggerCreate( active, absolute, xpos, ypos, stop, repeat )
   // DESCRIPTION: Creates and returns a new trigger configuration for a scene.
   var Trigger = ds_grid_create(PARAM_ARRAY, $08);
   Trigger[# $00, TP_ACTIVE] = argument[$00];
   Trigger[# $00, TP_ABSOLUTE] = argument[$01];
   Trigger[# $00, TP_XPOS] = argument[$02];
   Trigger[# $00, TP_YPOS] = argument[$03];
   Trigger[# $00, TP_STOP] = argument[$04];
   Trigger[# $00, TP_REPEAT] = argument[$05];
   Trigger[# $00, TP_TIMER] = $00;
   return Trigger;

#define TriggerRun
///TiggerRun( trigger )
   // DESCRIPTION: Executes a trigger when called.
   var Trigger = argument[$00];
   
   if (Trigger[# $00, TP_TIMER] >= Trigger[# $00, TP_STOP]) {
      if (Trigger[# $00, TP_REPEAT] > $00 || Trigger[# $00, TP_REPEAT] == undefined)
         Trigger[# $00, TP_TIMER] = $00;
   } else {
      Trigger[# $00, TP_TIMER] ++;
   }
