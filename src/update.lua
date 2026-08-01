G.RUNTRIGGER = false
G.HEART_ACTIVE = false
G.current_blind_key = nil  -- Track current blind for pattern spawning
G.right_bullet_timer = 0
G.fams_timer = G.fams_timer + 1
G.playing_battle = false


G.CONDITIONALS = {
	x = 0,
	y = 0,
	text = "TESTER"
}

--objects

G.cutbartop = {
    x = 0,
    y = -400
}

G.cutbarbottom = {
    x = 0,
    y = love.graphics.getHeight() + 400
}



G.heart = {
    x = 0,
    y = 0,
    speed = 5,
    img = new_arbituary_image("textures/earl_heart.png")
}

G.light = {
    x = 0,
    y = 0,
    img = new_arbituary_image("textures/flash.png")
}

G.lightoff = {
    x = 0,
    y = 0,
    img = new_arbituary_image("textures/flashoff.png")
}

G.timer = {
    x = love.graphics.getWidth() / 2,
    y = 0,
    img = new_arbituary_image("textures/timer.png"),
	rot = 0,
	xscale = 1,
	yscale = 1
}

-- Deltarune-like battle grid
G.battle_grid = {
    cell_size = 125,
    rows = 10,
    cols = 10,
    opacity = 0.3,
    color = {1, 1, 1, 1},  
    time = 0,
    scroll_speed = 125,  
    current_alpha = 0,
    target_alpha = 0
}

G.battle_grid_alt = {
    cell_size = 125,
    rows = 10,
    cols = 10,
    opacity = 0.3,
    color = {1, 0, 0, 1},  
    time = 0,
    scroll_speed = 500,  
    current_alpha = 0,
    target_alpha = 0
}


function draw_battle_grid()
    local grid = G.battle_grid
	local camera_offset_y = G.battle_box.cameray or 0
    
    local screen_width = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()
    
    love.graphics.setColor(0, 0, 0, grid.current_alpha * 1)
    love.graphics.rectangle("fill", 0, 0, screen_width, screen_height)
    
    love.graphics.setColor(grid.color[1], grid.color[2], grid.color[3], grid.color[4] * grid.current_alpha)
    
    love.graphics.setLineWidth(6)
    
    local offset = grid.time * grid.scroll_speed
    offset = offset % grid.cell_size  
    
    local cols = math.ceil(screen_width / grid.cell_size) + 2
    local rows = math.ceil(screen_height / grid.cell_size) + 2
    
    for row = 0, rows do
        for col = 0, cols do
            local x = col * grid.cell_size + offset
            local y = row * grid.cell_size + offset
            
            if (row + col) % 2 == 0 then
                love.graphics.setColor(grid.color[1], grid.color[2], grid.color[3], grid.color[4] * 0.5 * grid.current_alpha)
            else
                love.graphics.setColor(grid.color[1], grid.color[2], grid.color[3], grid.color[4] * 0.5 * grid.current_alpha)
            end
            
            love.graphics.rectangle("line", x - grid.cell_size, y - grid.cell_size, grid.cell_size, grid.cell_size)
        end
    end
    
    love.graphics.setColor(1, 1, 1, 1)  
end

function draw_armor_info(card)
	local width = 250
	local height = 150

	local mx = love.mouse.getX()
	if mx < 150 then
		mx = 150
	end



	local my = love.mouse.getY()
	if my - (height * 1.5) + 15 < 232 then
		my = 15
	end

	love.graphics.setColor(0.71, 0.353, 0.118, 1) 
	love.graphics.rectangle("fill", (mx - 5) - (width * 0.5), my - (height * 1.5) + 15, width, height)
	love.graphics.setColor(1, 0.498, 0.153, 1) 
	love.graphics.rectangle("fill", (mx - 5) - (width * 0.5), my - (height * 1.5), width, height)
	love.graphics.setColor(0, 0, 0, 1) 
	love.graphics.rectangle("fill", (mx + 6) - 5 - (width * 0.5), my + 6 - (height * 1.5), width - 15, height - 15)
	love.graphics.setColor(1, 0.498, 0.153, 1)

	local plainText = "* ATK: "..tostring((G and G.GAME and G.GAME.STATS and G.GAME.STATS.atk or 0)).."\n"
	plainText = plainText.."* DEF: "..tostring((G and G.GAME and G.GAME.STATS and G.GAME.STATS.def or 0)).."\n"
	plainText = plainText.."* AGL: "..tostring((G and G.GAME and G.GAME.STATS and G.GAME.STATS.agl or 0)).."\n"

	local font = love.graphics.newFont("resources/fonts/m6x11plus.ttf", 140)
	local statshow = love.graphics.newText(font, plainText)

	love.graphics.draw(statshow, love.mouse.getX(), love.mouse.getY() - (height * 1.5) + 6, 0, 0.2, 0.2, statshow:getWidth() * 1.3, 0);



	love.graphics.setColor(1, 1, 1, 1) 
end

function draw_battle_grid_speed()
    local grid = G.battle_grid_alt
	local camera_offset_y = G.battle_box.cameray or 0
    
    local screen_width = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()
    
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 0, screen_width, screen_height)
    
    love.graphics.setColor(1, 0, 0, 1)
    
    love.graphics.setLineWidth(6)
    
    local offset = G.battle_grid.time * grid.scroll_speed
    offset = offset % grid.cell_size
    
    local cols = math.ceil(screen_width / grid.cell_size) + 2
    local rows = math.ceil(screen_height / grid.cell_size) + 2
    
    for row = 0, rows do
        for col = 0, cols do
            local x = col * grid.cell_size
            local y = row * grid.cell_size + offset
            
            if (row + col) % 2 == 0 then
                love.graphics.setColor( math.abs(math.sin(G.battle_grid.time * 1 ) * 1), grid.color[2], grid.color[3], 1)
            else
                love.graphics.setColor( math.abs(math.sin(G.battle_grid.time * 1 ) * 1), grid.color[2], grid.color[3], 1)
            end
            
            love.graphics.rectangle("line", x - grid.cell_size, y - grid.cell_size, grid.cell_size, grid.cell_size)
        end
    end
    
    love.graphics.setColor(1, 1, 1, 1)  
end





isChallenge = function(key)
	return G.GAME.challenge == "c_" .. "yogi_" .. key
end

ForceLoss = function()
	if G.STATE ~= G.STATES.GAME_OVER and G.STATE ~= 11 then
		G.STATE = G.STATES.GAME_OVER
		G.STATE_COMPLETE = false
	end
end

G.yogi_update = function(dt)
	

	position = G.get_song_position()
	beatdur = 60 / G.BPM or 120
	beatcur = G.get_song_position() / beatdur

	if fams_loaded then
		BPM = G.BPM
	end


	if G.STATE == G.STATES.GAME_OVER then
		G.MOD_TIMERS = {}
		G.wantedfaces = {}
	end

	if G.STATE == 11 then
		setMenuBG({1, 1, 1, 1}, {0.3, 0.3, 0.3, 1}, {0.2, 0.2, 0.0, 12, 0.0, 1}, 1, 0)
		G.MOD_TIMERS = {}
		G.niceloop = false
		G.CUTSCENE = false
	end

	if isChallenge("krab") and not run_lost() and not timer_exists("krab") then
		make_timer("krab", 150, function()
			ForceLoss()
		end, false, 0.2)
		set_deathwish_timer("krab")
		G.GAME.win_ante = 6
    end

	if isChallenge("onemore") and not timer_exists("onemore") and G.GAME.round_resets.ante < 11 then
		G.GAME.win_ante = 10
        make_timer("onemore", 500, function()
			ForceLoss()
		end, false, 1)
		set_deathwish_timer("onemore")
    end

	if isChallenge("onemore") and G.GAME.blind.name == "" and G.TIMER_TRACK ~= "onemore" and G.GAME.round_resets.ante < 11 then
	set_deathwish_timer("onemore")
	else
	
	end

	if G and G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_yogi_view" and G.CUTSCENE == true then
		if G.buttons then
		G.buttons.states.visible = false
		end

		if love.mouse.isDown(1) and G.CUTSCENE == true then
			restoreCARDAREA()
			restoreUIBOX()
			G.buttons.states.visible = true
			G.CUTSCENE = false
		end
	end
	
	G.CONDITIONALS.text = ""
	G.CONDITIONALS.text = G.CONDITIONALS.text .. "TASKS LIST:\n"

	if G.DASH then
		G.ROOM.jiggle = 1
	end

	if has_modifier("bigmoney") and G and G.GAME and G.GAME.dollars then
		G.CONDITIONALS.text = G.CONDITIONALS.text .. "Gain " .. get_modifier_value("bigmoney") .. "$ before ante 8\n"
		if G.GAME.dollars < get_modifier_value("bigmoney") and G.GAME.round_resets.ante == 8 then
			ForceLoss()
		end
	end

	if has_modifier("cardlimit") and G and G.GAME and G.GAME.hands_played then
		G.CONDITIONALS.text = G.CONDITIONALS.text .. "Do not play more than 24 hands total\n" .. "Currently " .. tostring(G.GAME.hands_played) .. "/24\n"
		if G.GAME.hands_played > 24 then
			ForceLoss()
		end
	end

	if has_modifier("earlboss") then
		G.CONDITIONALS.text = G.CONDITIONALS.text .. "Defeat All 5 Dawgs\n"
	end

	if has_modifier("timer") then
		G.CONDITIONALS.text = G.CONDITIONALS.text .. "Reach Ante 4 in 350 seconds\n"
		if not run_lost() and not timer_exists("late") then
			make_timer("late", get_modifier_value("timer"), function()
				ForceLoss()
			end, false, 1)
			set_deathwish_timer("late")
			G.GAME.win_ante = 4
		end
	end

	if has_modifier("flipryth") then

		
		
	end

	if G.GAME.cutscene3 == true then
		G.LGendalpha = 1
		G.LGalpha = 0
	end


	if G and G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_yogi_nosee" then
		if G.GAME.light > -1 then
			G.GAME.light = G.GAME.light - 0.01
		end
	end

	G.battle_grid.time = G.battle_grid.time + dt

	if G and G.GAME and G.GAME.blind and G.GAME.blind.name and G.GAME.blind.name ~= '' then
		local blind_colour = nil
		-- Update grid color based on blind color
		if G.GAME and G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind then
			blind_colour = get_blind_main_colour(G.GAME.blind.config.blind.key or '')
			if blind_colour and #blind_colour >= 3 then
				G.battle_grid.color = {blind_colour[1] or 1, blind_colour[2] or 1, blind_colour[3] or 1, 1}
			end
			-- Fade based on if blind name is empty
			if G.GAME.blind.name and G.GAME.blind.name ~= '' then
				G.battle_grid.target_alpha = 1
			else
				G.battle_grid.target_alpha = 0
			end
		end

		if timer_exists("speed") and G.GAME.blind.name and G.TIMER_TRACK.paused == true then
			play_sound('yogi_weaponpull', 0.7, 1)
			G.TIMER_TRACK.paused = false
			G.niceloop = true
		end

		if G.STATE == 7 then
			restoreUIBOX()
			restoreCARDAREA()
		end
		
		-- Handle battle box for "The Graze" blind
		if G and G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_yogi_graze" or G.GAME.blind.name == "bl_yogi_earl" then
			G.playing_battle = true
			if G.GAME.blind.name == "bl_yogi_graze" then
				G.STATE = 5
				G.battle_box.width = G.battle_box.width + ((350 - G.battle_box.width) / 5)
    			G.battle_box.height = G.battle_box.height + ((350 - G.battle_box.height) / 5)
			end

			if G.GAME.blind.name ~= "bl_yogi_graze" and not G.OVERLAY_MENU then
				if G.GAME.attacktime > 0 or G.GAME.blind.name == "bl_yogi_graze" then
					G.STATE = 5
					G.GAME.attacktime = G.GAME.attacktime - dt
				else
					if G.STATE == 5 and G.GAME.blind.name ~= "bl_yogi_graze" then
						G.STATE = 1
						restoreUIBOX()
						restoreCARDAREA()
					end
				end
			end


			if G.GAME.chips >= G.GAME.blind.chips and G.GAME.GRAZEWIN == false then
				G.GAME.GRAZEWIN = true
				play_sound('yogi_won', 1, 1)
				end_round()
			else
			end
			G.battle_box.target_alpha = 1
			G.battle_box.target_scale = 1
			update_soul(dt)
			update_battle_box(blind_colour or {1, 1, 1})


			if G and G.GAME and (G.GAME.attacktime or 0) < 0.1 then
			G.warner.x = -100
			G.warner.y = -100
			G.bullets = {}
			G.battle_box.width = G.battle_box.width + ((48 - G.battle_box.width) / 5)
    		G.battle_box.height = G.battle_box.height + ((48 - G.battle_box.height) / 5)
			end

			if G.GAME and G.GAME.attacktype then
				if G.GAME.attacktype == "earl" and G.GAME.attacktime > 0 then
					G.battle_box.width = G.battle_box.width + ((600 - G.battle_box.width) / 5)
    				G.battle_box.height = G.battle_box.height + ((200 - G.battle_box.height) / 5)
				end
				if G.GAME.attacktype == "earl_2" and G.GAME.attacktime > 0 then
					G.battle_box.width = G.battle_box.width + ((800 - G.battle_box.width) / 5)
					G.battle_box.height = G.battle_box.height + ((300 - G.battle_box.height) / 5)
				end
				if G.GAME.attacktype == "earl_3" and G.GAME.attacktime > 0 and not G.OVERLAY_MENU then
					G.battle_box.width = G.battle_box.width + ((500 - G.battle_box.width) / 5)
					G.battle_box.height = G.battle_box.height + ((800 - G.battle_box.height) / 5)

					G.soul.target_y = G.soul.target_y + 1
					G.battle_box.cameray = G.battle_box.cameray + 1
				end
				if G.GAME.attacktype == "earl_4" and G.GAME.attacktime > 0 then
					G.battle_box.width = G.battle_box.width + ((500 - G.battle_box.width) / 5)
					G.battle_box.height = G.battle_box.height + ((500 - G.battle_box.height) / 5)
				end
			end

			G.right_bullet_timer = G.right_bullet_timer + dt
			if G.right_bullet_timer >= G.bullet_spawn_rate and G.GAME.GRAZEWIN == false and G.STATE ~= G.STATES.GAME_OVER and not G.OVERLAY_MENU then
				G.right_bullet_timer = 0
				if G.GAME and G.GAME.attacktype then
					if G.GAME.attacktype == "graze" then
						spawn_random_right_bullet()
						G.GAME.attacktime = 2
						
					end
					if G.GAME.attacktype == "earl" and G.GAME.attacktime > 0 then
						earl_bullets()
					end
					if G.GAME.attacktype == "earl_2" and G.GAME.attacktime > 0  then
						earl_bullets_2()
					end
					if G.GAME.attacktype == "earl_3" and G.GAME.attacktime > 0  then
						earl_bullets_3()
					end
					if G.GAME.attacktype == "earl_4" and G.GAME.attacktime > 0  then
						earl_bullets_4()
					end
				end
				
			end
			G.current_blind_key = "bl_yogi_graze"
		else
			G.battle_box.target_alpha = 0
			G.battle_box.target_scale = 0
			G.right_bullet_timer = 0
			G.current_blind_key = nil
		end
	else
		G.battle_grid.target_alpha = 0
		G.battle_box.target_alpha = 0
		G.battle_box.target_scale = 0
		G.GAME.GRAZEWIN = false
		local box = G.battle_box
		G.playing_battle = false
	end
	-- Smooth alpha and scale transition
	G.battle_grid.current_alpha = G.battle_grid.current_alpha + ((G.battle_grid.target_alpha - G.battle_grid.current_alpha) / 5)
	G.battle_box.current_alpha = G.battle_box.current_alpha + ((G.battle_box.target_alpha - G.battle_box.current_alpha) / 5)
	G.battle_box.current_scale = G.battle_box.current_scale + ((G.battle_box.target_scale - G.battle_box.current_scale) / 5)

	if G.GAME.GRAZEWIN == true and G.GAME.GRAZEWIN and G.STATE ~= G.STATES.GAME_OVER then
		restoreCARDAREA()
        restoreUIBOX()
	end
	
	-- Handle soul movement input
	local dx, dy = 0, 0
	if love.keyboard.isDown("up") or love.keyboard.isDown("w") then dy = -1 end
	if love.keyboard.isDown("down") or love.keyboard.isDown("s") then dy = 1 end
	if love.keyboard.isDown("left") or love.keyboard.isDown("a") then dx = -1 end
	if love.keyboard.isDown("right") or love.keyboard.isDown("d") then dx = 1 end
	moving = false
	if dx ~= 0 or dy ~= 0 then
		moving = true
		move_soul(dx, dy)
	end

	if G.STATE ~= G.STATES.GAME_OVER and not G.OVERLAY_MENU then
	-- Update soul
	
	-- Update bullets
	update_bullets(dt)
	update_face(dt)
	end

	if G.STATE == 2 then
		if G and G.GAME and G.GAME.ante_save and G.GAME.current_round.hands_left < 1 then
            G.GAME.current_round.hands_left = 1
            G.GAME.chips = G.GAME.blind.chips
			G.GAME.round_resets.ante = G.GAME.ante_save
			G.GAME.ante_save = nil
			G.GAME.CHARM = nil
        	G.GAME.CHARM_NAME = "c_yogi_empty"
        end
	end



	if G.STATE ~= G.STATES.GAME_OVER and not G.OVERLAY_MENU and G.STATE ~= 11 then
	for _, timer in ipairs(G.MOD_TIMERS) do
		timer.seconds = timer.seconds
		if timer and timer.seconds and not timer.paused then
			timer.seconds = timer.seconds - (dt * timer.scale)
			if timer.seconds <= 0 then

				if timer.onend then
					timer.onend()
				end
				table.remove(G.MOD_TIMERS, _)
				G.GAME.MOD_TIMERS = G.MOD_TIMERS
			end
		end
	end
end







	local num = math.random(0, 10000)

	--armor shit
	if G.GAME.ARMOR ~= nil and G.GAME.ARMOR ~= "none" then
		if G.GAME.ARMOR == "test" then
			G.GAME.STATS.grazeadd = 0.015
		end

	end

	if G.GAME.CHARM ~= nil and G.GAME.CHARM ~= "none" then
		if G.GAME.CHARM == "cat" and num < 1 then
			print(num)
			play_sound('yogi_meow', math.random(0.7, 1.3), 1)
		end
	end





end


G.mountain1 = new_arbituary_image("textures/mount1.png")
G.mountain2 = new_arbituary_image("textures/mount2.png")
G.mountain3 = new_arbituary_image("textures/mount3.png")
G.mountback = new_arbituary_image("textures/mountback.png")
G.sky1 = new_arbituary_image("textures/sky1.png")

G.sky1night = new_arbituary_image("textures/sky1night.png")
G.mountbacknight = new_arbituary_image("textures/mountbacknight.png")


G.LGalpha = 1
G.LGendalpha = 0

G.last_goodbye_battleback = function()


	love.graphics.setColor(1, 1, 1, G.LGalpha)
	local speedmult = 1


	if isChallenge("sun") then
		for obj = -4, 4 do
			speedmult = 5
			love.graphics.draw(G.sky1, ((G.sky1:getWidth() * 7) * obj) - (G.TIMERS.REAL * (10 * speedmult) % (G.sky1:getWidth() * 7)) + (G.ease_screen.x * 0.5), -25 + math.sin(G.TIMERS.REAL * 1) * 0, 0, 7, 7);
		end
	else
		for obj = -4, 4 do
			love.graphics.draw(G.sky1, ((G.sky1:getWidth() * 7) * obj) - (G.TIMERS.REAL * (10 * speedmult) % (G.sky1:getWidth() * 7)) + (G.ease_screen.x * 0.5), -25 + math.sin(G.TIMERS.REAL * 1) * 0, 0, 7, 7);
		end
	end

	if isChallenge("sun") then
		return
	end
	

	local scalar = math.abs(math.sin(G.TIMERS.REAL * 0.2) * 1)
	love.graphics.draw(G.mountback, 0 + (G.ease_screen.x * 0.2), (G.ease_screen.y * 0.2) + math.sin(G.TIMERS.REAL * 1) * 2, 0, 1, 1);

	for obj = -4, 4 do
	love.graphics.draw(G.mountain3, ((G.mountain3:getWidth() * 4) * obj) - (G.TIMERS.REAL * (200 * speedmult) % G.mountain3:getWidth() * 4), 60, 0, 4, 4);
	end
	for obj = -4, 4 do
	love.graphics.draw(G.mountain1, ((G.mountain1:getWidth() * 4) * obj) - (G.TIMERS.REAL * (600 * speedmult) % G.mountain1:getWidth() * 4), 150, 0, 4, 4);
	end

	love.graphics.setColor(0, 0, 1, G.LGendalpha)
	local speedmult = 1
	for obj = -4, 4 do
	love.graphics.draw(G.sky1night, ((G.sky1:getWidth() * 7) * obj) - (G.TIMERS.REAL * (10 * speedmult) % (G.sky1:getWidth() * 7)) + (G.ease_screen.x * 0.5), -25 + math.sin(G.TIMERS.REAL * 1) * 14, 0, 7, 7);
	end
	local scalar = math.abs(math.sin(G.TIMERS.REAL * 0.2) * 1)
	love.graphics.draw(G.mountbacknight, 0 + (G.ease_screen.x * 0.2), (G.ease_screen.y * 0.2) + math.sin(G.TIMERS.REAL * 1) * 2, 0, 1, 1);

	for obj = -4, 4 do
	love.graphics.draw(G.mountain3, ((G.mountain3:getWidth() * 4) * obj) - (G.TIMERS.REAL * (25 * speedmult) % G.mountain3:getWidth() * 4), 60, 0, 4, 4);
	end
	for obj = -4, 4 do
	love.graphics.draw(G.mountain1, ((G.mountain1:getWidth() * 4) * obj) - (G.TIMERS.REAL * (45 * speedmult) % G.mountain1:getWidth() * 4), 150, 0, 4, 4);
	end

end

G.yogi_draw = function()

	draw_battle_grid()

	if G.niceloop == true then
		draw_battle_grid_speed()
	end

	if isChallenge("sun") then
		G.last_goodbye_battleback()
	end

	if isChallenge("onemore") then
		G.last_goodbye_battleback()
		G.GAME.win_ante = 10
		G.GAME.dollars = 100

		if G.TIMER_TRACK.evil then
			if G.GAME.cutscene3 then
			G.GAME.starting_params.ante_scaling = 1
			else
			G.GAME.starting_params.ante_scaling = 5
			end
		else
			G.GAME.starting_params.ante_scaling = 0.5
		end

	end

	if isChallenge("onemore") then
		G.last_goodbye_battleback()

	end

	if isChallenge("krab") then
		love.graphics.draw(G.krusty, (G.ease_screen.x * 0.5) + (G.heart.img:getWidth() / 5) - 55, (G.ease_screen.y * 0.5) - (G.heart.img:getHeight() / 5) - 55, 0, 5, 5);
	end

	if isChallenge("borf") then
		love.graphics.draw(G.borfroom, (G.ease_screen.x * 0.5) + (G.heart.img:getWidth() / 5) - 55, (G.ease_screen.y * 0.5) - (G.heart.img:getHeight() / 2) - 55, 0, 1, 1);
	end

	if isChallenge("magic") then
		love.graphics.draw(G.lightoff.img, 0, 0, 0, 255, 255);

		if G.GAME.round_resets.ante == 1 and G.GAME.blind.name == "Big Blind" then
			love.graphics.draw(G.lore1[(math.floor(G.TIMERS.REAL * 25) % #G.lore1) + 1], (G.ease_screen.x * 0.5) + love.graphics:getWidth() / 2, (G.ease_screen.y * 0.5) + love.graphics:getHeight() / 2, 0, 2, 2, G.lore1[1]:getWidth() / 2, G.lore1[1]:getHeight() / 2)
		end

		if G.GAME.round_resets.ante == 2 and G.GAME.blind.name == "Small Blind" then
			love.graphics.draw(G.lore2[(math.floor(G.TIMERS.REAL * 25) % #G.lore2) + 1], (G.ease_screen.x * 0.5) + love.graphics:getWidth() / 2, (G.ease_screen.y * 0.5) + love.graphics:getHeight() / 2, 0, 2, 2, G.lore2[1]:getWidth() / 2, G.lore2[1]:getHeight() / 2)
		end

		if G.GAME.round_resets.ante == 2 and G.GAME.blind.name == "Big Blind" then
			love.graphics.draw(G.lore3[(math.floor(G.TIMERS.REAL * 25) % #G.lore3) + 1], (G.ease_screen.x * 0.5) + love.graphics:getWidth() / 2, (G.ease_screen.y * 0.5) + love.graphics:getHeight() / 2, 0, 2, 2, G.lore3[1]:getWidth() / 2, G.lore3[1]:getHeight() / 2)
		end

		if G.GAME.round_resets.ante == 3 and G.GAME.blind.name == "Small Blind" then
			love.graphics.draw(G.lore4[(math.floor(G.TIMERS.REAL * 25) % #G.lore4) + 1], (G.ease_screen.x * 0.5) + love.graphics:getWidth() / 2, (G.ease_screen.y * 0.5) + love.graphics:getHeight() / 2, 0, 2, 2, G.lore4[1]:getWidth() / 2, G.lore4[1]:getHeight() / 2)
		end

		if G.GAME.round_resets.ante == 3 and G.GAME.blind.name == "Big Blind" then
			love.graphics.draw(G.lore5[(math.floor(G.TIMERS.REAL * 25) % #G.lore5) + 1], (G.ease_screen.x * 0.5) + love.graphics:getWidth() / 2, (G.ease_screen.y * 0.5) + love.graphics:getHeight() / 2, 0, 2, 2, G.lore5[1]:getWidth() / 2, G.lore5[1]:getHeight() / 2)
		end

		if G.GAME.round_resets.ante == 4 and G.GAME.blind.name == "Small Blind" then
			love.graphics.draw(G.lore6[(math.floor(G.TIMERS.REAL * 25) % #G.lore6) + 1], (G.ease_screen.x * 0.5) + love.graphics:getWidth() / 2, (G.ease_screen.y * 0.5) + love.graphics:getHeight() / 2, 0, 2, 2, G.lore6[1]:getWidth() / 2, G.lore6[1]:getHeight() / 2)
		end

		if G.GAME.round_resets.ante == 4 and G.GAME.blind.name ~= "" and G.GAME.blind.name ~= "Small Blind" and G.GAME.blind.name ~= "Big Blind" then
			love.graphics.draw(G.lore7[(math.floor(G.TIMERS.REAL * 25) % #G.lore7) + 1], (G.ease_screen.x * 0.5) + love.graphics:getWidth() / 2, (G.ease_screen.y * 0.5) + love.graphics:getHeight() / 2, 0, 2, 2, G.lore7[1]:getWidth() / 2, G.lore7[1]:getHeight() / 2)
		end

	end

	draw_faces()


	draw_battle_box()
	draw_bullets()
	draw_soul()

end


G.yogi_draw_front = function()
	local mx = love.mouse.getX();
	local my = love.mouse.getY();
	G.ease_screen = { x = (G.ARGS.eased_cursor_pos.sx - 960) * 0.03 or 0, y = (G.ARGS.eased_cursor_pos.sy - 21) * 0.03 or 0 }


	if G and  G.GAME and not G.GAME.light then
		G.GAME.light = 100
	end

	if G.HEART_ACTIVE then
		love.graphics.draw(G.heart.img, G.heart.x - (G.heart.img:getWidth() / 2), G.heart.y - (G.heart.img:getHeight() / 2), 0, 2, 2);
		love.mouse.setVisible(false)
	else
		love.mouse.setVisible(true)
	end

	if G and G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_yogi_nosee" then
		
		love.graphics.draw(G.light.img, G.light.x - (G.light.img:getWidth() / 2), G.light.y - (G.light.img:getHeight() / 2), 0, 1, 1);

		if G.GAME.light > 0 then
		-- Create font at high render scale to avoid blur
		local font = love.graphics.newFont("resources/fonts/m6x11plus.ttf", 140)
		--regular text
		local plainText = love.graphics.newText(font, tostring(math.floor(G.GAME.light)).."%")
		love.graphics.draw(plainText, math.floor(G.light.x), math.floor(G.light.y) - 55, 0, 0.2, 0.2, plainText:getWidth() * 0.5, 0);
		else
		love.graphics.draw(G.lightoff.img, G.light.x - (G.light.img:getWidth() / 2), G.light.y - (G.light.img:getHeight() / 2), 0, 1, 1);


	end
	else
		if G.GAME and not G.GAME.light then
			G.GAME.light = 100
		end
	end


if isChallenge("flipmania") then


	if G.GAME.FLIPSPEED then G.GAME.FLIPSPEED = G.GAME.round_resets.ante end
	
	local i = 0
	if G.hand and G.hand.cards then
		for _, card in ipairs(G.hand.cards) do
			i = i + 1

			local speed = (G.TIMERS.REAL * (G.GAME.FLIPSPEED or 1))

			local valid = math.floor((speed % #G.hand.cards * 1.5) + 1) == 1 * i or math.floor((speed % #G.hand.cards * 1.5) + 1) - 1 == 1 * i or math.floor((speed % #G.hand.cards * 1.5) + 1) - 2 == 1 * i
			if G.hand and valid then

				if not card.debuff then card:juice_up() end
				card.debuff = true
			else
				card.debuff = false
			end
		end
	end
end

if isChallenge("focus") and not run_lost() then


	G.BPM = 50

	G.GAME.clickgrace = (G.GAME.clickgrace or 0)
	print(G.GAME.clickgrace)
	G.GAME.tickvalue = (G.GAME.tickvalue or 1)

	if beatcur % 1 < 0.5 then
		if G.GAME.tickvalue ~= 1 then
		play_sound("yogi_tingpart1", 1, 1)
		G.GAME.tickvalue = 1
		G.GAME.clickgrace = 0.3
		end
	else
		if G.GAME.tickvalue ~= 2 then
		play_sound("yogi_tingpart2", 1, 1)
		G.GAME.tickvalue = 2
		G.GAME.clickgrace = 0.3
		end
	end

	G.GAME.clickgrace = G.GAME.clickgrace - 0.01
	

end

	




	

	if G and G.TIMER_TRACK then
		if (G.TIMER_TRACK.seconds or 999) < 10 then
			if beatcur % 0.5 <= 0.1 then
				G.timer.xscale = 1.1
				G.timer.yscale = 1.1
			end
		else
			if beatcur % 1 <= 0.1 then
				G.timer.xscale = 1.1
				G.timer.yscale = 1.1
			end
		end
	end

	G.timer.xscale = G.timer.xscale + ((1 - G.timer.xscale) / 6)
	G.timer.yscale = G.timer.yscale + ((1 - G.timer.yscale) / 6)

	if G.TIMER_TRACK.evil then
	love.graphics.setColor(1, 0, 0, 1)
	else
	love.graphics.setColor(1, 1, 1, 1)
	end

	love.graphics.draw(G.timer.img, G.timer.x, G.timer.y, 0, G.timer.xscale, G.timer.yscale);
		
	if G.TIMER_TRACK and G.TIMER_TRACK.seconds then
		local timer_font = love.graphics.newFont("resources/fonts/m6x11plus.ttf", 90)

		local time_display_raw = tostring(G.TIMER_TRACK.seconds or 0)

		local time_display = string.find(tostring(G.TIMER_TRACK.seconds or 0), ".", 1, true)

		local time_trim = string.sub(time_display_raw or "0", 0, (time_display or 0) + 2)

		local timer_text = love.graphics.newText(timer_font, tostring(time_trim))
		
		if G.TIMER_TRACK.evil then
		love.graphics.setColor(1, 0, 0, 1)
		else
		love.graphics.setColor(1, 1, 0, 1)
		end
		love.graphics.draw(timer_text, math.floor(G.timer.x) + 115, math.floor(G.timer.y) + 210, -0.3, G.timer.xscale, G.timer.yscale);
	end

	if G.STATE ~= 11 then
		love.graphics.setColor(1,1,1,1)
		local cond_font = love.graphics.newFont("resources/fonts/m6x11plus.ttf", 25)
		local texter = love.graphics.newText(cond_font, G.CONDITIONALS.text or "")
		love.graphics.draw(texter, math.floor(G.CONDITIONALS.x), math.floor(G.CONDITIONALS.y), 0, 1, 1, texter:getWidth() * 0.5, 0);


		G.CONDITIONALS.x = 1709 + G.ease_screen.x
		G.CONDITIONALS.y = 385 + G.ease_screen.y
	end

	if G.playing_battle and G.GAME.attacktime and G.GAME.attacktime < 1 then
		love.graphics.draw(G.warner.img, G.warner.x - (G.warner.img:getWidth() / 2), G.warner.y - (G.warner.img:getHeight() / 2), 0, 1, 1);
	end

	G.heart.x = mx
	G.heart.y = my
	G.light.x = G.light.x + ((mx - G.light.x) / 5)
	G.light.y = G.light.y + ((my - G.light.y) / 5)

	if G.TIMER_TRACK and G.TIMER_TRACK.seconds and G.TIMER_TRACK.seconds > 0 and timer_exists(G.TIMER_TRACK.id) then
		G.timer.x = G.timer.x + ((1500 + (math.random() * G.ROOM.jiggle) - G.timer.x) / 5)
		G.timer.y = G.timer.y + ((700 + (math.random() * G.ROOM.jiggle) - G.timer.y) / 5)
	else
		G.timer.x = G.timer.x + ((1900 - G.timer.x) / 5)
		G.timer.y = G.timer.y + ((1000 - G.timer.y) / 5)
	end

	draw_overlays()
end

function draw_overlays()
	if isChallenge("magic") then
		love.graphics.setBlendMode("multiply", "premultiplied")
		love.graphics.draw(G.blue, 0, 0, 0, 55, 55);
		love.graphics.setBlendMode("alpha")
	end
end

G.yogi_draw_UI = function(self)
	if G.hoveringitemcard then
		-- draw_armor_info(self)
	end

	if G.CUTSCENE then
		G.cutbartop.y = G.cutbartop.y + ((-300 - G.cutbartop.y) / 15)
		G.cutbarbottom.y = G.cutbarbottom.y + (((love.graphics:getHeight() - 75) - G.cutbarbottom.y) / 15)
	else

		G.cutbartop.y = G.cutbartop.y + ((-400 - G.cutbartop.y) / 15)
		G.cutbarbottom.y = G.cutbarbottom.y + (((love.graphics.getHeight()) + 75 - G.cutbarbottom.y) / 15)
	end
	
	love.graphics.setColor(0,0,0,1)
	love.graphics.rectangle("fill", G.cutbartop.x, G.cutbartop.y, 5000, 400)
	love.graphics.rectangle("fill", G.cutbarbottom.x, G.cutbarbottom.y, 5000, 400)
end