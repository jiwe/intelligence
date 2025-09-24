package main

import "core:debug/pe"
import "core:debug/trace"
import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

Walker :: struct {
	x, y:   f32,
	radius: f32,
}

walker_show :: proc(using walker: ^Walker) {
	rl.DrawCircle(i32(x), i32(y), radius, rl.RED)
}

walker_step :: proc(using walker: ^Walker) {
	mouse_pos := rl.GetMousePosition()
	weight: int = -1
	max_val := 6

	if mouse_pos.x < 0 || mouse_pos.y < 0 {
		max_val = 4
		// y < x && y > -x => x += step
	} else if mouse_pos.y - y < mouse_pos.x - x && mouse_pos.y - y > -(mouse_pos.x - x) {
		weight = 0
		// y > x && y < -x => x -= step
	} else if mouse_pos.y - y > mouse_pos.x - x && mouse_pos.y - y < -(mouse_pos.x - x) {
		weight = 1
		// y > x && y > -x => y += step
	} else if mouse_pos.y - y > mouse_pos.x - x && mouse_pos.y - y > -(mouse_pos.x - x) {
		weight = 2
		// y < x && y < -x => y -= step
	} else if mouse_pos.y - y < mouse_pos.x - x && mouse_pos.y - y < -(mouse_pos.x - x) {
		weight = 3
	}

	step: f32 = 1.0
	choice := rand.int_max(max_val)
	choice = weight if choice > 3 else choice
	switch choice {
	case 0:
		x += step
	case 1:
		x -= step
	case 2:
		y += step
	case 3:
		y -= step
	}
}
