package main

import "core:math"
import "core:math/rand"
import "vendor:raylib"

main :: proc() {
	// 初始化窗口
	width: i32 = 800
	height: i32 = 600
	raylib.InitWindow(width, height, "Normal Distribution Histogram")
	defer raylib.CloseWindow()

	raylib.SetTargetFPS(60)

	// 参数
	N := 20000
	bins := 40
	mean := 0.0
	std := 1.0
	min_x := -4.0
	max_x := 4.0
	bin_width := (max_x - min_x) / f64(bins)

	// 生成样本
	samples := make([]f64, N)
	for i in 0 ..< N {
		samples[i] = rand.norm_float64() * std + mean
	}

	// 计算直方图
	counts := make([]int, bins)
	for val in samples {
		if val < min_x || val >= max_x {
			continue
		}
		idx := int((val - min_x) / bin_width)
		if idx < 0 {idx = 0}
		if idx >= bins {idx = bins - 1}
		counts[idx] += 1
	}

	// 找最大值用于缩放
	max_count := 0
	for c in counts {
		if c > max_count {
			max_count = c
		}
	}

	// 主循环
	for !raylib.WindowShouldClose() {
		raylib.BeginDrawing()
		raylib.ClearBackground(raylib.RAYWHITE)

		// 画坐标轴
		margin: i32 = 50
		plot_w := width - margin * 2
		plot_h := height - margin * 2
		bar_w := f32(plot_w) / f32(bins)

		// 绘制直方图
		for i in 0 ..< bins {
			c := counts[i]
			h := 0.0
			if max_count > 0 {
				h = f64(c) / f64(max_count) * f64(plot_h)
			}
			x := f32(margin) + f32(i) * bar_w
			y := f32(height - margin) - f32(h)
			raylib.DrawRectangle(i32(x), i32(y), i32(bar_w * 0.9), i32(h), raylib.BLUE)
		}

		// 画边框
		raylib.DrawRectangleLines(margin, margin, plot_w, plot_h, raylib.BLACK)

		// 标题
		raylib.DrawText("Normal Distribution Histogram", 200, 10, 20, raylib.DARKGRAY)

		raylib.EndDrawing()
	}
}
