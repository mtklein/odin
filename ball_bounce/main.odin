package main

import rl "vendor:raylib"

SCREEN_WIDTH  :: 800
SCREEN_HEIGHT :: 450

main :: proc() {
    rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Bouncing Ball")
    defer rl.CloseWindow()

    ball_pos   := rl.Vector2{f32(SCREEN_WIDTH) / 2, f32(SCREEN_HEIGHT) / 2}
    ball_speed := rl.Vector2{200, 150} // pixels per second
    ball_radius: f32 = 20

    rl.SetTargetFPS(60)

    for !rl.WindowShouldClose() {
        dt := rl.GetFrameTime()
        ball_pos.x += ball_speed.x * dt
        ball_pos.y += ball_speed.y * dt

        if ball_pos.x > f32(SCREEN_WIDTH) - ball_radius || ball_pos.x < ball_radius {
            ball_speed.x = -ball_speed.x
        }
        if ball_pos.y > f32(SCREEN_HEIGHT) - ball_radius || ball_pos.y < ball_radius {
            ball_speed.y = -ball_speed.y
        }

        rl.BeginDrawing()
            rl.ClearBackground(rl.RAYWHITE)
            rl.DrawCircleV(ball_pos, ball_radius, rl.RED)
        rl.EndDrawing()
    }
}
