package main

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
	step: f32 = 1.0
	choice := rand.int_max(4)
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
