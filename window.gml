#define WindowCreate
///WindowCreate( width, height, virtual_scale, physical_scale )
   // DESCRIPTION: Creates and returns a new window configuration.
   var Wind = ds_grid_create(PARAM_ARRAY, $05);
   Wind[# $00, WP_WIDTH] = argument[$00];
   Wind[# $00, WP_HEIGHT] = argument[$01];
   Wind[# $00, WP_VIRTUALSCALE] = argument[$02];
   Wind[# $00, WP_PHYSICALSCALE] = argument[$03];
   Wind[# $00, WP_RESOLUTION] = argument[$01] / argument[$00];
   return Wind;

#define WindowAutoDraw
///WindowAutoDraw( draw )
   // DESCRIPTION: Toggles the auto draw for the application surface.
   application_surface_draw_enable(argument[$00]);

#define WindowDraw
///WindowDraw( window, scene, guix, guiy, xorigin, yorigin, angle )
   // DESCRIPTION: Draws the window--perferably to the [DRAW GUI END] event.
   var Wind = argument[$00],
      Scene = argument[$01],
      GuiX = argument[$02],
      GuiY = argument[$03],
      ScaleX = ScrAspectRatio($01, Scene[# $00, SP_WIDTH]) * (Wind[# $00, WP_WIDTH] * Wind[# $00, WP_VIRTUALSCALE]),
      ScaleY = undefined;
      
   if (argument[$07]) {
      ScaleY = ScrAspectRatio($01, Scene[# $00, SP_HEIGHT]) * (Wind[# $00, WP_HEIGHT] * Wind[# $00, WP_VIRTUALSCALE]);
   } else {
      ScaleY = ScrAspectRatio($01, Scene[# $00, SP_HEIGHT]) * (Wind[# $00, WP_WIDTH] * Scene[# $00, SP_RESOLUTION] * Wind[# $00, WP_VIRTUALSCALE]);
   }
   
   ScrDrawSurfaceExt(application_surface, GuiX, GuiY, ScaleX, ScaleY, argument[$04], argument[$05], argument[$06], $FFFFFF, $01);

#define WindowGuiX
///WindowGuiX( window, scene )
   // DESCRIPTION: Returns the x-position of the window configuration within the GUI.
   var Wind = argument[$00],
      Scene = argument[$01],
      ScaleX = Scene[# $00, SP_WIDTH] * Wind[# $00, WP_VIRTUALSCALE];
   return (display_get_gui_width() - ScaleX) >> $01;

#define WindowGuiY
///WindowGuiY( window, scene )
   // DESCRIPTION: Returns the y-position of the window configuration within the GUI.
   var Wind = argument[$00],
      Scene = argument[$01],
      ScaleY = Scene[# $00, SP_HEIGHT] * Wind[# $00, WP_VIRTUALSCALE];
   return (display_get_gui_height() - ScaleY) >> $01;

#define WindowHidden
///WindowHidden()
   // DESCRIPTION: Returns TRUE if the physical window is hidden, otherwise returns FALSE.
   return (window_get_width() == $00 && window_get_height() == $00);

#define WindowIsUpdated
///WindowIsUpdated(window)
   // DESCRIPTION: Returns TRUE if the physical window is up to date with the window, otherwise returns FALSE.
   var Wind = argument[$00],
      WindWidth = Wind[# $00, WP_WIDTH] * Wind[# $00, WP_PHYSICALSCALE],
      WindHeight = Wind[# $00, WP_HEIGHT] * Wind[# $00, WP_PHYSICALSCALE];
   return (WindWidth == window_get_width() && WindHeight == window_get_height()) && !ScrWindowHidden();

#define WindowSetMax
///WindowSetMax( maxw, maxh )
   // DESCRIPTION: Sets the minimum width and height for the window.
   window_set_max_width(argument[$00]);
   window_set_max_height(argument[$01]);

#define WindowSetMin
///WindowSetMin( minw, minh )
   // DESCRIPTION: Sets the maximum width and height for the window.
   window_set_min_width(argument[$00]);
   window_set_min_height(argument[$01]);

#define WindowSetRes
///WindowSetRes( window, xfactor, yfactor )
   // DESCRIPTION: Sets the resolution for a window with the given aspect ratio.
   var Wind = argument[$00];
   var Xfact = argument[$01], Yfact = argument[$02];
   var Res = ScrAspectRatio(Yfact, Xfact);
   Wind[# $00, WP_HEIGHT] = ceil(Wind[# $00, WP_WIDTH] * Res);

#define WindowSetSize
///WindowSetSize( window, width, height )
   // DESCRIPTION: Sets the width, height and resolution of a window.
   var Wind = argument[$00];
   Wind[# $00, WP_WIDTH] = argument[$01];
   Wind[# $00, WP_HEIGHT] = argument[$02];
   Wind[# $00, WP_RESOLUTION] = argument[$02] / argument[$01];

#define WindowUpdate
///WindowUpdate( window )
   // DESCRIPTION: Updates the physical window to a given window.
   var Wind = argument[$00],
      WindWidth = Wind[# $00, WP_WIDTH] * Wind[# $00, WP_PHYSICALSCALE],
      WindHeight = Wind[# $00, WP_HEIGHT] * Wind[# $00, WP_PHYSICALSCALE],
      WindUpdateW = window_get_width(),
      WindUpdateH = window_get_height();
      
   if ((WindWidth != WindUpdateW || WindHeight != WindUpdateH) && !ScrWindowHidden()) {
      display_reset($00, false);
      
      var wx = window_get_x(), wy = window_get_y();
      wx += (WindUpdateW - WindWidth) / $02;
      wy += (WindUpdateH - WindHeight) / $02;
      window_set_position(wx, wy);
      window_set_size(WindWidth, WindHeight);
   }
   
   if (display_get_gui_width() != WindWidth || display_get_gui_height() != WindHeight)
      display_set_gui_size(WindWidth, WindHeight);
