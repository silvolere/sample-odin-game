package sample_game

import rl "vendor:raylib"

main :: proc() {
    rl.InitWindow(1280, 720, "Sample_platformer_game")
    rl.SetTargetFPS(120)
    consolas := rl.LoadFont("CONSOLA.TTF")
    fps : i32

    player := rl.Rectangle {100, 656, 64, 64}
    player_vel : rl.Vector2
    grounded := false
    jump_buffer : int
    
    platform_1 := rl.Rectangle {1162, 640, 128, 48}
    platform_2 := rl.Rectangle {930, 590, 128, 48}
    platform_3 := rl.Rectangle {700, 540, 128, 48}
    platform_4 := rl.Rectangle {350, 540, 128, 48}
    platform_5 := rl.Rectangle {565, 340, 48, 128}


    for !rl.WindowShouldClose() { // start loop
        rl.BeginDrawing()
        rl.ClearBackground({70, 80, 100, 255})
        fps = rl.GetFPS()
        rl.DrawTextEx(consolas, "FPS: ", {5, 5}, 35, 1, rl.BLACK)
        rl.DrawFPS(5, 35)

        // movement
        if rl.IsKeyDown(.LEFT) ||rl.IsKeyDown(.A) do player_vel.x = -400
        else if rl.IsKeyDown(.RIGHT) || rl.IsKeyDown(.D) do player_vel.x = 400
        else do player_vel.x = 0

        // jump + y-velocity
        player_vel.y += 2000 * rl.GetFrameTime()
        if (rl.IsKeyPressed(.SPACE) || jump_buffer > 0) && grounded == true {
            player_vel.y = -600
            grounded = false
        }
        else if rl.IsKeyPressed(.SPACE) && jump_buffer == 0 {
            jump_buffer = 10
        }
        else if jump_buffer > 0 {
            jump_buffer -= 1
        }

        // vel -> pos
        player.x += player_vel.x * rl.GetFrameTime()
        player.y += player_vel.y * rl.GetFrameTime()

        // boundaries
        if player.x >= f32(rl.GetScreenWidth()) - 64 {
            player.x = f32(rl.GetScreenWidth()) - 64
        } 
        if player.x <= 0 {
            player.x = 0
        }
        grounded = false
        if player.y > f32(rl.GetScreenHeight()) - 64 {
            player.y = f32(rl.GetScreenHeight()) - 64
            grounded = true
        }

        // collision
        if rl.CheckCollisionRecs(player, platform_1) {
            rec_collision(&player, &platform_1, &player_vel, &grounded)
        }
        if rl.CheckCollisionRecs(player, platform_2) {
            rec_collision(&player, &platform_2, &player_vel, &grounded)
        }
        if rl.CheckCollisionRecs(player, platform_3) {
            rec_collision(&player, &platform_3, &player_vel, &grounded)
        }
        if rl.CheckCollisionRecs(player, platform_4) {
            rec_collision(&player, &platform_4, &player_vel, &grounded)
        }
        if rl.CheckCollisionRecs(player, platform_5) {
            rec_collision(&player, &platform_5, &player_vel, &grounded)
        }

        // game objects
        rl.DrawRectangleRec(platform_1, {50, 57, 70, 255})
        rl.DrawRectangleRec(platform_2, {50, 57, 70, 255})
        rl.DrawRectangleRec(platform_3, {50, 57, 70, 255})
        rl.DrawRectangleRec(platform_4, {50, 57, 70, 255})
        rl.DrawRectangleRec(platform_5, {50, 57, 70, 255})

        rl.DrawEllipse(589, rl.GetScreenHeight(), 70, 10, {100, 200, 150, 200})

        rl.DrawRectangleRec(player, {80, 110, 150, 255})
        rl.EndDrawing()

    }
    rl.CloseWindow()
}