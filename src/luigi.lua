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

function mouse_over_face(face)
    local mx = love.mouse.getX()
    local my = love.mouse.getY()

    local dx = mx - face.x
    local dy = my - face.y

    return math.sqrt(dx * dx + dy * dy) < face.size
end

function draw_faces()
    love.graphics.setColor(1, 1, 1, 1)

    for _, face in ipairs(G.wantedfaces) do
        local mouse_x = love.mouse.getX()
        local mouse_y = love.mouse.getY()

        if face.image then
            local img_width = face.image:getWidth()
            local img_height = face.image:getHeight()
            local scale = face.size / math.max(img_width, img_height)

            local face_x = face.x + (img_width / scale)
            local face_y = face.y

            local dx = face_x - mouse_x
            local dy = face_y - mouse_y
            local dist = math.sqrt(dx * dx + dy * dy)

            love.graphics.setColor(0.5, 0.5, 0.5, 1)

            if dist < face.size then
                love.graphics.setColor(1, 1, 1, 1)
            end

            local addsize = G.GAME.luigieasy1 or 0

            if face.luigi == true then
                love.graphics.draw(
                    G.luigi_img,
                    face_x,
                    face_y,
                    0,
                    scale + addsize,
                    scale + addsize,
                    img_width,
                    img_height
                )
            else
                love.graphics.draw(
                    face.image,
                    face_x,
                    face_y,
                    0,
                    scale,
                    scale,
                    img_width,
                    img_height
                )
            end
        else
            love.graphics.circle("fill", face.x, face.y, face.size)
        end
    end

    love.graphics.setColor(1, 1, 1, 1)
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
    local mouse_x = love.mouse.getX()
    local mouse_y = love.mouse.getY()
    local click = love.mouse.isDown(1)

    for i, face in ipairs(G.wantedfaces) do
        if face.image then
            local img_width = face.image:getWidth()
            local img_height = face.image:getHeight()
            local scale = face.size / math.max(img_width, img_height)

            local face_x = face.x + (img_width / scale)
            local face_y = face.y

            local dx = face_x - mouse_x
            local dy = face_y - mouse_y
            local dist = math.sqrt(dx * dx + dy * dy)

            if dist < face.size then
                if click and G.luigiwin == false then
                    table.insert(G.clicklist, face)

                    for _, clicked_face in ipairs(G.clicklist) do
                        if clicked_face.luigi == true then
                            G.GAME.chips = G.GAME.blind.chips
                        end
                    end
                end
            end
        end

        face.x = face.x + math.cos(face.direction) * face.speed * dt
        face.y = face.y + math.sin(face.direction) * face.speed * dt

        face.x = face.x % 2200
        face.y = face.y % 1400

        face.speed = face.speed + dt

        face:updater()
        face.timer = face.timer + dt
    end

    if G and G.GAME and G.GAME.blind
        and G.GAME.blind.name == 'bl_yogi_luigi'
        and G.ENDSTOP == false then

        removeUIBOX()
        removeCARDAREA()
    end

    if click
        and G and G.GAME and G.GAME.blind
        and G.GAME.blind.name == 'bl_yogi_luigi'
        and G.ENDSTOP == false then

        G.ENDSTOP = true
        restoreUIBOX()
        end_round()
        G.wantedfaces = {}
    end

    for i = #faces_to_remove, 1, -1 do
        table.remove(G.wantedfaces, faces_to_remove[i])
    end
end