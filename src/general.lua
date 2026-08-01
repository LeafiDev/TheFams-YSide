-- title custom
local original_main_menu = Game.main_menu
-- Table to track viewed title screens (no duplicates)
local viewed_title_screens = {}

Game.main_menu = function(self, change_context)
    if not title_screen_randomized then
        title_variant = 1
        title_screen_randomized = false
    else
        math.randomseed(os.time())
        title_variant = math.random(1, 1)
    end

    -- Mark this title_variant as viewed (no duplicates)
    if not viewed_title_screens[title_variant] then
        viewed_title_screens[title_variant] = false
        if #viewed_title_screens == 1 then
        end
    end
     local title_logos = {
        [1] = {atlas = "balatro", pos = {x = 0, y = 0}}, 
    }
    
    local selected_logo = title_logos[title_variant] or title_logos[1]
    if G.ASSET_ATLAS[selected_logo.atlas] then
         G.ASSET_ATLAS["balatro"] = G.ASSET_ATLAS[selected_logo.atlas]
    else
    end
     original_main_menu(self, change_context)
      if G.title_top then
        G.title_top.config.card_limit = 16  -- Allow up to 8 cards
         local original_width = G.title_top.T.w
         G.title_top.T.w = G.title_top.T.w * 16
         G.title_top.T.x = G.title_top.T.x - (G.title_top.T.w - original_width) / 2
        G.title_top:hard_set_T()  -- Apply the changes
    end
     G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 2,
        func = function()
            if G.title_top and G.title_top.cards then
                 for i = #G.title_top.cards, 1, -1 do
                    local card = G.title_top.cards[i]
                    if card then
                        card:remove()
                    end
                end
                G.title_top.cards = {}
                 local variants = {
                     {
                        {key = "j_yogi_coolyog", x = -1.5, y = 0},
						{key = "j_yogi_yogi", x = 1.5, y = 0}
                    },
                }
                
                -- Function to get all cards of any type
                local function get_all_cards()
                    local all_cards = {}
                    if G.P_CENTERS then
                        for key, card_center in pairs(G.P_CENTERS) do
                            if card_center.can_spend ~= false then -- Exclude non-spendable cards
                                table.insert(all_cards, {key = key, x = 0, y = 0})
                            end
                        end
                    end
                    return all_cards
                end
                 local selected_variant = variants[title_variant] or variants[1]
                 
                 -- If selected_variant is empty or we want to use all cards, get them dynamically
                 local cards_to_display = selected_variant
                 if not cards_to_display or #cards_to_display == 0 then
                    cards_to_display = get_all_cards()
                    -- Limit to 8 cards for display purposes
                    local limited_cards = {}
                    for i = 1, math.min(8, #cards_to_display) do
                        limited_cards[i] = cards_to_display[i]
                    end
                    cards_to_display = limited_cards
                 end
                 for i, card_info in ipairs(cards_to_display) do
                    local card_center = G.P_CENTERS[card_info.key]
                    if card_center then
                        local joker_card = Card(
                            G.title_top.T.x + (card_info.x or 0) * G.CARD_W, 
                            G.title_top.T.y + (card_info.y or 0) * G.CARD_H, 
                            1.2 * G.CARD_W, 
                            1.2 * G.CARD_H, 
                            nil, 
                            card_center
                        )
                        G.title_top:emplace(joker_card)
                        joker_card.states.visible = true
                        joker_card.no_ui = true
                        joker_card.ambient_tilt = 0.0
                        joker_card.title_card_index = i
                    end
                end
                 G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    delay = 2, -- Change sprites every 2 seconds
                    repeatable = true,
                    func = function()
                        if G.title_top and G.title_top.cards and G.STATE == G.STATES.MAIN_MENU then
                            -- Get a list of all available cards
                            local all_card_keys = {}
                            if G.P_CENTERS then
                                for key, card_center in pairs(G.P_CENTERS) do
                                    if card_center.can_spend ~= false then
                                        table.insert(all_card_keys, key)
                                    end
                                end
                            end
                            
                            if #all_card_keys > 0 then
                                for _, card in ipairs(G.title_top.cards) do
                                    if card.title_card_index then
                                        local current_time = math.floor(G.TIMERS.REAL / 2) -- Change every 2 seconds
                                        local sprite_index = ((current_time + card.title_card_index) % #all_card_keys) + 1
                                        local new_center = G.P_CENTERS[all_card_keys[sprite_index]]
                                        
                                        if new_center and card.config.center ~= new_center then
                                            card.config.center = new_center
                                            card:set_sprites(card.config.center, card.config.card)
                                            card:juice_up(0.1, 0.1) -- Add a small juice effect when changing
                                        end
                                    end
                                end
                            end
                        end
                        return G.STATE == G.STATES.MAIN_MENU -- Continue only if still in main menu
                    end
                }))
            end
            return true
        end
    }))
end

function CreateColor(key, hex)
	if type(hex) == "string" then
		local s = hex:gsub("^#", "")
		G.C[key] = HEX(s)
	elseif type(hex) == "table" then
		G.C[key] = hex
	else
		G.C[key] = HEX('8867a5')
	end
end
CreateColor("deathwish", HEX("4f2e65"))

get_current_profile = function()
	return G.PROFILES[G.SETTINGS.profile] or "not valid"
end

-- menu bg
setMenuBG = function(colour1, colour2, colour3, contrast, spin_amount)
	if G and G.SPLASH_BACK and G.SPLASH_BACK.draw_steps then
		for _, step in ipairs(G.SPLASH_BACK.draw_steps) do
			if step.shader == 'splash' and step.send then
				for _, entry in ipairs(step.send) do
					if entry.name == 'colour_1' then
						entry.ref_table = nil
						entry.ref_value = nil
						entry.val = colour1
					elseif entry.name == 'colour_2' then
						entry.ref_table = nil
						entry.ref_value = nil
						entry.val = colour2
					elseif entry.name == 'colour_3' then
						entry.ref_table = nil
						entry.ref_value = nil
						entry.val = colour3
					elseif entry.name == 'contrast' then
						entry.ref_table = nil
						entry.ref_value = nil
						entry.val = contrast
					elseif entry.name == 'spin_amount' then
						entry.ref_table = nil
						entry.ref_value = nil
						entry.val = spin_amount
					end
				end
			end
		end
	end
end

-- image shit
local lovely = require("lovely");
local nativefs = require("nativefs");

local info = nativefs.getDirectoryItemsInfo(lovely.mod_dir);
fams2_path = "";

for i, v in pairs(info) do
	if v.type == "directory" and nativefs.getInfo(lovely.mod_dir .. "/" .. v.name .. "/yogi.lua") then 
		fams2_path = v.name 
	end
end

new_arbituary_image = function(path)
	return love.graphics.newImage("mods/"..fams2_path.."/assets/"..path)
end

function has_modifier(index)
    if G.GAME.modifiers[index] then
        return true
    end
    return false
end

function get_modifier_value(index)
    if G.GAME.modifiers[index] then
        return G.GAME.modifiers[index]
    end
    return false
end

function run_lost()
    return G.STATE == G.STATES.GAME_OVER
end

function convert_direction(deg)
    return deg * (math.pi / 180)
end

force_number = function(amount, min)
	if (type(amount) ~= "number") then
		return math.max(amount:to_number(), min or 0)
	end

	return math.max(amount, min or 0);
end

isEternal = function(card)
	return card and card.ability and card.ability.eternal
end

currentDeck = function()
    if G and G.GAME and G.GAME.selected_back 
        and G.GAME.selected_back.effect 
        and G.GAME.selected_back.effect.center 
        and G.GAME.selected_back.effect.center.key then
        return G.GAME.selected_back.effect.center.key
    end
    return nil
end