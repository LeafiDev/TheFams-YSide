-- Deltarune Battle Box System
G.fams_timer = 0
G.alternation = 0

G.battle_box = {
    width = 500,
    height = 500,
    x = 0,
    y = 0,
    border_width = 12,
    color = {1, 1, 1, 1},  -- Will be overridden by blind color
    current_alpha = 0,
    target_alpha = 0,
    current_scale = 0,
    target_scale = 0,
    camerax = 0,
    cameray = 0,
    x_real = 0,
    y_real = 0
}

G.warner = {
    x = -100,
    y = -100,
    img = new_arbituary_image("textures/warner.png")
}

local screen_width = love.graphics.getWidth()
local screen_height = love.graphics.getHeight()

G.soul = {
    x = 0,
    y = 0,
    target_x = screen_width / 2,
    target_y = screen_height / 2,
    size = 12,
    color = {1, 0, 0, 1},  -- Red heart
    current_alpha = 0,
    img = new_arbituary_image("textures/earl_heart.png"),
    graze_radius = 60,
    graze_img = new_arbituary_image("textures/graze.png"),
    graze_active = false,
    graze_timer = 0,
    graze_flash_duration = 0.1,
    graze_wait_duration = 0,
    graze_fade_duration = 0.2,
    graze_alpha = 0,
    graze_count = 0,
    inv = 0,
    moving = false
}

-- Bullet image
G.bullet_img = new_arbituary_image("textures/circ.png")
G.earl_bullet_img = new_arbituary_image("textures/earl_bullet.png")

-- Bullets list
G.bullets = {}
G.bullet_spawn_rate = 0.25

function spawn_random_right_bullet()
    local box = G.battle_box
    local right_x = box.x + box.width + 200
    local center_y = box.y + box.height / 2
    local y = center_y + math.random(-400, 400)
    local speed = math.random(110, 500)
    local rotation = math.random(-0.5, 0.5)

    spawn_bullet(right_x, y, 18, math.pi, speed, false, {1, 1, 1, 1}, nil, 0, 0, 0, 500, function(self)
        
        if self.x < 960 - G.battle_box.width then
            self.size = self.size - 0.1
            if self.size <= 0 then
                self.size = 0
            end
        end
    end)
end

function earl_bullets()
    local box = G.battle_box
    local center_x = box.x + box.width / 2
    local center_y = box.y + box.height / 2
    local speed = 100
    local rotation = love.timer.getTime() * 3

    spawn_bullet(center_x + box.width / 2, center_y, 18, math.pi + rotation, speed, false, {1, 1, 1, 1}, G.earl_bullet_img, 55)
    spawn_bullet(center_x - box.width / 2, center_y, 18, math.pi - rotation, speed, false, {1, 1, 1, 1}, G.earl_bullet_img, 55)
end

G.delay = 0
function earl_bullets_2()

    local box = G.battle_box
    local center_x = box.x + box.width / 2
    local center_y = box.y + box.height / 2
    local speed = 0
    local rotation = love.timer.getTime() * 45


    if G.delay == 2 then

        spawn_bullet(center_x - 400, center_y + math.random(-box.height, box.height), 35, convert_direction(0), speed, false, {1, 1, 1, 1}, G.earl_bullet_img, 400, 0, 0, 500, function(self)
            local y = self.y
            y = y + math.sin(self.timer * 5) * 2
        end)
        
        spawn_bullet(center_x + 400, center_y + math.random(-box.height, box.height), 35, convert_direction(180), speed, false, {1, 1, 1, 1}, G.earl_bullet_img, 400, 0, 0, 500, function(self)
            local y = self.y
            y = y + math.sin(self.timer * 5) * 2
        end)
        
        
        
        
        G.delay = 0
    else
        G.delay = G.delay + 1
    end


end


G.delay = 0
function earl_bullets_3()

    local box = G.battle_box
    local center_x = box.x + box.width / 2
    local center_y = box.y + box.height / 2
    local speed = 0
    local rotation = love.timer.getTime() * 45


    if G.delay == 1 then
        spawn_bullet(center_x - 200, center_y + math.random(-box.height, box.height), 35, convert_direction(0), speed, false, {1, 0, 0, 1}, G.earl_bullet_img, 400, 0, 75)
        spawn_bullet(center_x + 200, center_y + math.random(-box.height, box.height), 35, convert_direction(180), speed, false, {1, 0, 0, 1}, G.earl_bullet_img, 400, 0, 75)
        play_sound('yogi_petaldrain', math.random(0.5, 2), 1)
        G.delay = 0
    else
        G.delay = G.delay + 1
    end


end

function earl_bullets_4()

    local box = G.battle_box
    local center_x = box.x + box.width / 2
    local center_y = box.y + box.height / 2
    local speed = 600
    local rotation = love.timer.getTime() * 45


    if G.delay == 1 then
        spawn_bullet(center_x - 1000, center_y + box.height / 3.5, 250, convert_direction(0), speed, false, {0, 0, 0, 1}, G.earl_bullet_long_img, 0, 0, 0)
        play_sound('yogi_petaldrain', math.random(0.5, 2), 1)
        G.delay = 0
    else
        spawn_bullet(center_x + 1000, center_y - box.height / 3.5, 250, convert_direction(180), speed, false, {0, 0, 0, 1}, G.earl_bullet_long_img, 0, 0, 0)
        G.delay = G.delay + 1
    end


end


function draw_battle_box()
    local box = G.battle_box
    
    -- Center the box on screen
    local screen_width = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()
    box.x = ((screen_width - box.width) / 2)
    box.y = ((screen_height - box.height) / 2)
    
    -- Push transform for scaling
    love.graphics.push()
    love.graphics.translate(screen_width / 2, screen_height / 2)
    love.graphics.scale(box.current_scale, box.current_scale)
    love.graphics.translate(-screen_width / 2, -screen_height / 2)
    
    -- Draw black background with current alpha
    love.graphics.setColor(0, 0, 0, box.current_alpha * 1)
    love.graphics.rectangle("fill", box.x, box.y, box.width, box.height)
    
    -- Draw the battle box with current alpha
    love.graphics.setColor(box.color[1], box.color[2], box.color[3], box.color[4] * box.current_alpha)
    
    -- Draw box border
    love.graphics.setLineWidth(box.border_width)
    love.graphics.rectangle("line", box.x, box.y, box.width, box.height)
    
    -- Draw box corners (Deltarune style)
    local corner_size = 20
    
    -- Top-left corner
    love.graphics.line(box.x, box.y, box.x + corner_size, box.y)
    love.graphics.line(box.x, box.y, box.x, box.y + corner_size)
    
    -- Top-right corner
    love.graphics.line(box.x + box.width, box.y, box.x + box.width - corner_size, box.y)
    love.graphics.line(box.x + box.width, box.y, box.x + box.width, box.y + corner_size)
    
    -- Bottom-left corner
    love.graphics.line(box.x, box.y + box.height, box.x + corner_size, box.y + box.height)
    love.graphics.line(box.x, box.y + box.height, box.x, box.y + box.height - corner_size)
    
    -- Bottom-right corner
    love.graphics.line(box.x + box.width, box.y + box.height, box.x + box.width - corner_size, box.y + box.height)
    love.graphics.line(box.x + box.width, box.y + box.height, box.x + box.width, box.y + box.height - corner_size)
    
    love.graphics.pop()
    love.graphics.setColor(1, 1, 1, 1)  -- Reset color
end

function draw_soul()
    local soul = G.soul

    if G.playing_battle then
        
        -- Only draw soul if battle box is active
        if soul.current_alpha <= 0 then
            return
        end
        
        -- Lazy load graze image if not loaded
        if not soul.graze_img or (type(soul.graze_img) ~= "userdata") then
            soul.graze_img = new_arbituary_image("textures/graze.png")
        end
        
        -- Draw graze texture with fallback
        if soul.graze_img then
            love.graphics.setColor(1, 1, 1, soul.graze_alpha * 0.8)
            local gw = soul.graze_img:getWidth()
            local gh = soul.graze_img:getHeight()
            
            -- Scale up if image is small
            local scale = math.max(2, 120 / math.max(gw, gh))
            love.graphics.draw(soul.graze_img, soul.x, soul.y, 0, scale, scale, gw / 2, gh / 2)
        else
            -- Fallback white circle
            love.graphics.setColor(1, 1, 1, soul.graze_alpha * 0.6)
            love.graphics.circle("fill", soul.x, soul.y, 60)
        end
        
        -- Draw heart image
        if soul.inv > 0 then
            love.graphics.setColor(0.5, 0, 0, soul.current_alpha)
            soul.inv = soul.inv - 0.1
        else
            love.graphics.setColor(1, 1, 1, soul.current_alpha)
        end
        
        if soul.img then
            love.graphics.draw(soul.img, soul.x - (soul.img:getWidth() / 2) * 2, soul.y - (soul.img:getHeight() / 2) * 2, 0, 2, 2)
        end

    end
    
    love.graphics.setColor(1, 1, 1, 1)  -- Reset color
end

function spawn_bullet(x, y, size, direction, speed, grazed, colour, texture, accel, scx, scy, lifetime, updater, fake)
    
    local bullet = {
        x = x or 0,
        y = y or 0,
        size = size or 18,
        direction = direction or 0,
        speed = speed or 100,
        grazed = grazed or false,
        colour = colour or {1, 1, 1, 1},
        image = texture or G.bullet_img,
        accel = accel or 0,
        scroll_x = scx or 0,
        scroll_y = scy or 0,
        lifetime = lifetime or 500,
        timer = 0,
        updater = updater or function() end,
        fake = fake or false
    }
    
    table.insert(G.bullets, bullet)
end

function draw_bullets()
    for _, bullet in ipairs(G.bullets) do
        love.graphics.setColor(bullet.colour[1], bullet.colour[2], bullet.colour[3], bullet.colour[4] or 1)

        if bullet.grazed == true then
             love.graphics.setColor(bullet.colour[1] - .5, bullet.colour[2] - .5, bullet.colour[3] - .5, bullet.colour[4] or 1)
        else
             love.graphics.setColor(bullet.colour[1], bullet.colour[2], bullet.colour[3], bullet.colour[4] or 1)
        end
        
        if bullet.image then
            local img_width = bullet.image:getWidth()
            local img_height = bullet.image:getHeight()
            local scale = bullet.size / (math.max(img_width, img_height) / 2)
            love.graphics.draw(bullet.image or bullet.image, bullet.x, bullet.y, 0, scale, scale, img_width / 2, img_height / 2)
        else
            -- Fallback to circle if texture fails to load
            love.graphics.circle("fill", bullet.x, bullet.y, bullet.size)
        end
    end
    
    love.graphics.setColor(1, 1, 1, 1)  -- Reset color
end

function update_bullets(dt)
    if G and G.STATE == G.STATES.GAME_OVER then
        return
    end

    local soul = G.soul
    local box = G.battle_box
    local bullets_to_remove = {}
    
    for i, bullet in ipairs(G.bullets) do
        -- Move bullet (math library literally is not real dude)
        bullet.x = bullet.x + math.cos(bullet.direction) * (bullet.speed) * dt
        bullet.y = bullet.y + math.sin(bullet.direction) * (bullet.speed) * dt
        bullet.x = bullet.x + bullet.scroll_x * dt
        bullet.y = bullet.y + bullet.scroll_y * dt

        bullet.speed = bullet.speed + (bullet.accel * dt)

        bullet:updater()
        bullet.timer = bullet.timer + dt
        
        -- Check for collision (direct hit) (why the fuck did I call it direct hit that's cringe)
        local dx = (bullet.x - soul.x) * 1.5
        local dy = (bullet.y - soul.y) * 1.5
        local dist = math.sqrt(dx * dx + dy * dy)

        if bullet.timer > bullet.lifetime then
          table.insert(bullets_to_remove, i) 
        end
        
        if dist < soul.size + bullet.size and G.soul.inv < 1 and not bullet.fake == true then
            lose_hand()
            local voucher1 = 0
            local voucher2 = 0

            if G.GAME.grazevoucher1 then
                voucher1 = 3
            end
            if G.GAME.grazevoucher2 then
                voucher2 = 5
            end

            soul.inv = 12 - voucher1 - voucher2
            play_sound('yogi_hurt', 1, 1)
            G.ROOM.jiggle = 2
            table.insert(bullets_to_remove, i)
        elseif not bullet.grazed and dist < soul.graze_radius + bullet.size and G.soul.inv < 1 and G.soul.graze_alpha < 1 then
            trigger_graze()
            bullet.grazed = false
        end
    end
    
    -- Remove out-of-bounds bullets (in reverse to preserve indices)
    for i = #bullets_to_remove, 1, -1 do
        table.remove(G.bullets, bullets_to_remove[i])
    end
end

function update_soul(dt)
    local soul = G.soul
    local box = G.battle_box
    
    -- Soul alpha matches battle box alpha
    soul.current_alpha = box.current_alpha
    
    -- Initialize soul position to center of battle box
    if soul.target_x == 0 and soul.target_y == 0 then
        soul.target_x = 900
        soul.target_y = 640
    end
    
    -- Move directly to target position (no easing)
    soul.x = soul.target_x
    soul.y = soul.target_y
    
    -- Keep soul within battle box bounds (accounting for 2x image scale)
    local padding_x = (soul.img and soul.img:getWidth() or soul.size)
    local padding_y = (soul.img and soul.img:getHeight() or soul.size)
    soul.target_x = math.max(box.x + padding_x, math.min(box.x + box.width - padding_x, soul.target_x))
    soul.target_y = math.max(box.y + padding_y, math.min(box.y + box.height - padding_y, soul.target_y))
    
    -- Update graze effect
    if soul.graze_active then
        soul.graze_timer = soul.graze_timer + dt
        local flash_wait_total = soul.graze_flash_duration + soul.graze_wait_duration
        
        if soul.graze_timer < soul.graze_flash_duration then
            -- Flash phase
            soul.graze_alpha = 1
        elseif soul.graze_timer < flash_wait_total then
            -- Wait phase
            soul.graze_alpha = 1
        elseif soul.graze_timer < flash_wait_total + soul.graze_fade_duration then
            -- Fade phase
            local fade_progress = (soul.graze_timer - flash_wait_total) / soul.graze_fade_duration
            soul.graze_alpha = 1 - fade_progress
        else
            -- Done
            soul.graze_active = false
            soul.graze_timer = 0
            soul.graze_alpha = 0
        end
    end
end

function move_soul(dx, dy)
    moving = true
    local soul = G.soul
    local speed = 2
    
    -- Check for slowdown (X or Shift key)
    if love.keyboard.isDown("x") or love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
        speed = 1
    end
    
    soul.target_x = soul.target_x + (dx * speed)
    soul.target_y = soul.target_y + (dy * speed)
end

function update_battle_box(blind_colour)
    if blind_colour and #blind_colour >= 3 then
        G.battle_box.color = {blind_colour[1], blind_colour[2], blind_colour[3], 1}
    end
end

function trigger_graze()
    G.soul.graze_active = true
    G.soul.graze_timer = 0
    G.soul.graze_alpha = 1
    G.soul.graze_count = G.soul.graze_count + 1
    
    -- Play graze sound
    play_sound('yogi_graze', 1, 1)
    G.ROOM.jiggle = 0.25
    if G.GAME.attacktime then
        G.GAME.attacktime = G.GAME.attacktime - 0.1
    end
    
    -- Add chips: 1% of blind's chips
    if G.GAME.blind and G.GAME.blind.chips then
        bonus = bonus or 0
        if G.GAME.CANCHIPGRAZE == true then
            local voucher1 = (G.GAME.grazevoucher1 or 0)
            local voucher2 = (G.GAME.grazevoucher2 or 0)
            bonus = math.floor(G.GAME.blind.chips * (0.015 + (G.GAME.STATS.grazeadd or 0) + voucher1 + voucher2))
        end
        if G.GAME.blind.name == "bl_yogi_earl" then
            G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 0.05
        end
        G.GAME.chips = G.GAME.chips + bonus
    end
end

function lose_hand()
    if G.GAME and G.GAME.current_round then
        G.GAME.current_round.hands_left = (G.GAME.current_round.hands_left or 1) - 1
        
        if G.GAME.current_round.hands_left <= 0 then
            ForceLoss()
        end
    end
end
