/* 
	USAGE:
		Create a variable in an object to hold the current animation struct ( current_animation or currentAnim )
		Initialize your animations using the animation_init() functions.
		
		EXAMPLE:
			var walk = animation_init_finite(spr_player_walk, 0, 0);
			var jump = animation_init_chained(spr_player_jump, walk, 0, 0);
			
			^^ The Above code will init 2 animation structs 'walk' and 'jump'.
			'jump' is a chained animation that will return back to the 'walk' animation immediately after it finishes.
*/