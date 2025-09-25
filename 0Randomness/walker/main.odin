package main

import rl "vendor:raylib"

main :: proc() {
	WINDOW_WIDTH :: 750
	WINDOW_HEIGHT :: 750
	fps: i32 = 240

	rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "simulation walker")
	rl.SetTargetFPS(fps)

	walker := new(Walker)
	walker^ = Walker {
		x      = WINDOW_WIDTH / 2,
		y      = WINDOW_HEIGHT / 2,
		radius = 1,
	}


	for !rl.WindowShouldClose() {
		walker_step(walker)
		rl.BeginDrawing()
		// rl.ClearBackground(rl.WHITE)
		walker_show(walker)
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
