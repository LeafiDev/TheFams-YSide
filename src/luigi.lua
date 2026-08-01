G.wantedfaces = {}



function spawn_face(luigi)
    
    local face = {
        x = x or math.random(-1000, 2500),
        y = y or math.random(-1000, 2500),
        size = size or 100,
        direction = direction or math.random(0,360),
        speed = speed or 150,
        image = G.facelist[math.random(1, #G.facelist)] or G.earl_face_img,
        updater = updater or function() end,
        timer = 0,
        luigi = luigi or false
    }
    
    table.insert(G.wantedfaces, face)
end

function draw_faces()
    love.graphics.setColor(1, 1, 1, 1)  -- Reset color
    for _, face in ipairs(G.wantedfaces) do
        
        mouse = {x = love.mouse.getX(), y = love.mouse.getY(), size = 1}

        if face.image then

            local img_width = face.image:getWidth()
            local img_height = face.image:getHeight()
            local scale = face.size / (math.max(img_width, img_height))

            local dx = (face.x - mouse.x) * scale
            local dy = (face.y - mouse.y) * scale
            local dist = math.sqrt(dx * dx + dy * dy)
            love.graphics.setColor(0.5, 0.5, 0.5, 1)  -- Reset color
            if dist < mouse.size + face.size then
                love.graphics.setColor(1, 1, 1, 1)  -- Reset color
            end


            local addsize = 0 + (G.GAME.luigieasy1 or 0)


            if face.luigi == true then

                love.graphics.draw(G.luigi_img, face.x + (face.image:getWidth() / scale), face.y, 0, scale + addsize, scale + addsize, img_width, img_height)
            else
                love.graphics.draw(face.image or face.image, face.x + (face.image:getWidth() / scale), face.y, 0, scale, scale, img_width, img_height)
            end


        else
            -- Fallback to circle if texture fails to load
            love.graphics.circle("fill", face.x + (face.image.width / 2), face.y, face.size)
        end
    end
    love.graphics.setColor(1, 1, 1, 1)  -- Reset color
end

G.luigi_img = new_arbituary_image("textures/luigi.png")
G.mario_img = new_arbituary_image("textures/mario.png")
G.yoshi_img = new_arbituary_image("textures/yoshi.png")
G.wario_img = new_arbituary_image("textures/wario.png")

G.facelist = {G.mario_img, G.yoshi_img, G.wario_img}
G.clicklist = {}

function update_face(dt)
    if G and G.STATE == G.STATES.GAME_OVER then
        return
    end

    local faces_to_remove = {}
    
    mouse = {x = love.mouse.getX(), y = love.mouse.getY(), size = 1}

    for i, face in ipairs(G.wantedfaces) do
        local dx = (face.x - mouse.x) * 2
        local dy = (face.y - mouse.y) * 2
        local dist = math.sqrt(dx * dx + dy * dy)
        local click = love.mouse.isDown( 1 )

        if dist < face.size then
                if click and G.luigiwin == false then
                    table.insert(G.clicklist, face)

                    if click then
                    for _, face in ipairs(G.clicklist) do
                        if face.luigi == true then
                            G.GAME.chips = G.GAME.blind.chips
                        end
                    end
                end
            end
        end


        -- Move face (math library literally is not real dude)
        face.x = face.x + math.cos(face.direction) * (face.speed) * dt
        face.y = face.y + math.sin(face.direction) * (face.speed) * dt

        face.x = (face.x % 2200)
        face.y = (face.y % 1400)

        face.speed = face.speed + dt

        face:updater()
        face.timer = face.timer + dt
    end

    local click = love.mouse.isDown( 1 )

    if G and G.GAME and G.GAME.blind and G.GAME.blind.name == 'bl_yogi_luigi' and G.ENDSTOP == false then
        removeUIBOX()
        removeCARDAREA()
    end

    if click and G and G.GAME and G.GAME.blind and G.GAME.blind.name == 'bl_yogi_luigi' and G.ENDSTOP == false then
        G.ENDSTOP = true
        restoreUIBOX()
        end_round()
        G.wantedfaces = {}
    end

    
    -- Remove out-of-bounds faces (in reverse to preserve indices)
    for i = #faces_to_remove, 1, -1 do
        table.remove(G.wantedfaces, faces_to_remove[i])
    end
end