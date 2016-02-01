#define AspectRatio
///AspectRatio( width, height )
   // DESCRIPTION: Returns the apect ratio for the given dimensions [INLINED].
   return argument[$00] / argument[$01];


#define ParamsDestroy
///ParamsDestroy( params )
   // DESCRIPTION: Destroys the given parameters as a ds_grid [INLINED].
   var Params = argument[$00],
      Check = ds_exists(Params, ds_type_grid);
   
   if (Check)
      ds_grid_destroy(Params);
   
   return Check;
