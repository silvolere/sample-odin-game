package sample_game

import rl "vendor:raylib"


rec_collision :: proc(player, platform: ^rl.Rectangle, player_vel: ^rl.Vector2, grounded: ^bool) {
    player_b := player.y + player.height
    player_r := player.x + player.width
    platform_b := platform.y + platform.height
    platform_r := platform.x + platform.width
    left_dist := player_r - platform.x
    right_dist := platform_r - player.x 
    top_dist := player_b - platform.y
    bottom_dist := platform_b - player.y
    // top collision
    if player_b > platform.y && player.y < platform.y && left_dist > top_dist && right_dist > top_dist {
        player.y = platform.y - player.height
        grounded^ = true
        if player_vel.y > 0 {
            player_vel.y = 0
        }
    } // right collision
    if player_r > platform.x && player.x < platform.x && top_dist > left_dist && bottom_dist > left_dist {
        player.x = platform.x - player.width
    } // left collision
    if player.x < platform_r && player_r > platform_r && top_dist > right_dist && bottom_dist > right_dist {
        player.x = platform_r
    } // bottom collision
    if player.y < platform_b && player_b > platform_b && left_dist > bottom_dist && right_dist > bottom_dist {
        player.y = platform_b
        if player_vel.y < 0 {
            player_vel.y = 0
        }
    }
}