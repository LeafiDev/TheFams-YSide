SMODS.Atlas {
    key = "yogi",
    path = "yogi.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "fallback",
    path = "fallback.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "fajitas",
    path = "fajitas.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "man",
    path = "man.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "walk",
    path = "WalkingManCard.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "testicles",
    path = "testicles.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "krab",
    path = "krab.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "patrick",
    path = "patrick.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "spong",
    path = "spong.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "krabs",
    path = "krabs.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "steve",
    path = "steve.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "jackpot",
    path = "jackpot.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "dogstache",
    path = "dogstache.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "mirror",
    path = "mirrorj.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "jokers",
    path = "jokers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "contract",
    path = "contract.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "miau",
    path = "miau.png",
    px = 71,
    py = 95
}







-- old shit for lore reasons

hasJoker = function(key)
	if G and G.jokers and G.jokers.cards then
		for _, joker in ipairs(G.jokers.cards) do
			if joker.label == key then
				return true
			end
		end
	end
	return false
end

calculate_div_dollars = function(divider, minimum, maximum)
	minimum = minimum or 0;
	maximum = maximum or 1e+30;
	divider = divider or 0;
	
	local dollars = force_number(G.GAME.dollars);
	local loss = 0;
	if (divider > 0) then 
		loss = math.floor(dollars / (divider)); 
	end;
	
	if (loss > maximum) then
		loss = maximum;
	end

	if (dollars - loss < minimum) then
		loss = minimum - (dollars-loss);
	end

	return -loss;
end

removeCards = function(amount)
				local removed = 0
			   local sources = {G.deck, G.hand, G.discard}
			   for _, area in ipairs(sources) do
					   if area and area.cards then

							   for i = #area.cards, 1, -1 do
									   local c = area.cards[i]

									   if c then
											   table.remove(area.cards, i)
											   c:remove(true)
											   removed = removed + 1
											   if removed >= amount then break end
									   end
							   end
					   end
					   if removed >= amount then break end
			   end
end

SMODS.Joker {
	key = 'earl',
	loc_txt = {
		name = 'Earl Joe',
		text = {
			"Gives {X:mult,C:white}X0.5{} Mult for every {C:money}1${}. ",
			"Every hand eats {C:attention}half{} or {C:attention}up to 10${}",
			"{C:inactive}Currently{} {X:mult,C:white}X#1#{} {C:inactive}Mult{}",
			"{C:inactive}Eats{} {C:money}#2#${} {C:inactive}this hand{}"
		}
	},
	config = { extra = { xmult = 0.5 } },
	rarity = 4,
	atlas = 'jokers',
	pos = { x = 0, y = 0 },
	cost = 8,
loc_vars = function(self, info_queue, card)
	local dollars = G.GAME.dollars or 1
	local to_eat = math.min(math.floor(dollars / 2), 10)
	return { vars = { 0.5 * dollars, to_eat } }
end,
set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("DAWG", {0.7, 0.4, 0.1, 1}, G.C.WHITE, 1.2)
end,
calculate = function(self, card, context)

	   if context.joker_main and not context.blueprint then
		if hasJoker("j_fams_pedigree") then
			return { message = "blocked", colour = G.C.GREEN, xmult = 0.5 * force_number(G.GAME.dollars, 1) }
		else
			return { dollars = calculate_div_dollars(2, 0, 10), xmult = 0.5 * force_number(G.GAME.dollars, 1), message = "Munch" }
		end
	   	end
	   
end
}

SMODS.Joker {
	key = 'yogi',
	loc_txt = {
		name = 'Yogi',
		text = {
			"Gives {X:chips,C:white}X0.5{} chips for every {C:money}1${}. ",
			"Every hand eats {C:attention}half{} or {C:attention}up to 10${}",
			"{C:inactive}Currently{} {X:chips,C:white}X#1#{} {C:inactive}Mult{}",
			"{C:inactive}Eats{} {C:money}#2#${} {C:inactive}this hand{}"
		}
	},
	config = { extra = { xchips = 0.5 } },
	rarity = 4,
	atlas = 'jokers',
	pos = { x = 1, y = 0 },
	cost = 8,
loc_vars = function(self, info_queue, card)
	local dollars = G.GAME.dollars or 1
	local to_eat = math.min(math.floor(dollars / 2), 10)
	return { vars = { 0.5 * dollars, to_eat } }
end,
set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("DAWG", {0.7, 0.4, 0.1, 1}, G.C.WHITE, 1.2)
end,
calculate = function(self, card, context)
	   		if context.joker_main and not context.blueprint then
		if hasJoker("j_fams_pedigree") then
			return { message = "blocked", colour = G.C.GREEN, xmult = 0.5 * force_number(G.GAME.dollars, 1)}
		else
			return { dollars = calculate_div_dollars(2, 0, 10), xchips = 0.5 * force_number(G.GAME.dollars, 1), message = "Munch" }
		end
	   		end
end
}

SMODS.Joker {
	key = 'bear',
	loc_txt = {
		name = 'Bear',
		text = {
			"Gives {C:chips}+5{} chips for every {C:money}1${}. ",
			"Every hand eats {C:attention}half{} or {C:attention}up to 5${}",
			"{C:inactive}Currently{} {C:chips}+#1#{} {C:inactive}chips{}",
			"{C:inactive}Eats{} {C:money}#2#${} {C:inactive}this hand{}"
		}
	},
	config = { extra = { xchips = 0.5 } },
	rarity = 4,
	atlas = 'jokers',
	pos = { x = 2, y = 0 },
	cost = 8,
loc_vars = function(self, info_queue, card)
	local dollars = G.GAME.dollars or 1
	local to_eat = math.min(math.floor(dollars / 2), 5)
	return { vars = { 5 * dollars, to_eat } }
end,
set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("DAWG", {0.7, 0.4, 0.1, 1}, G.C.WHITE, 1.2)
end,
calculate = function(self, card, context)

	   if context.joker_main and not context.blueprint then
		if hasJoker("j_fams_pedigree") then
			return {	message = "blocked", colour = G.C.GREEN, xmult = 0.5 * force_number(G.GAME.dollars, 1)}
		else
			return { dollars = calculate_div_dollars(2, 0, 5), chips = 5 * force_number(G.GAME.dollars, 1), message = "Munch" }
		end
	   	end
	   
end
}

SMODS.Joker {
	key = 'radiation',
	loc_txt = {
		name = 'Toby Radiation Fox',
		text = {
			'You\'re carrying too much dog.',
			'{C:inactive}destroys 5 playing cards{}',
			'{C:red}Runs away{}'
		}
	},
	config = {},
	rarity = 1,
	cost = 2,
	atlas = 'jokers',
	pos = { x = 3, y = 0 },
calculate = function(self, card, context)
	   if context.joker_main then

			   removeCards(5)
			
				if card.ability and isEternal(card) then

					return {message = "absorbed"}
				else
					SMODS.destroy_cards(card, nil, nil, true)
					return {message = "see ya!"}
				end
	   end
end,
	set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("DAWG", {0.7, 0.4, 0.1, 1}, G.C.WHITE, 1.2)
end,
}

SMODS.Joker {
	key = 'butterdog', 
	atlas = 'jokers',
	pos = { x = 4, y = 0 },
	loc_txt = {
		name = 'ButterDog, The dog with da buttah on em', 
		text = {
			"Gains {C:red}+1{} mult for each {C:diamonds}Diamond{} card",
			"{C:attention}Resets at the end of the round{}",
			"{C:inactive}currently +#1# Mult{}"
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.mult or 0 } }
	end,
	config = { mult = 0 }, 
	rarity = 1,
	cost = 5, 

	calculate = function(self, card, context)
 		if context.individual and context.cardarea == G.play then
 			if context.other_card.base.suit == 'Diamonds' then
 				self.config.mult = (self.config.mult or 0) + 1
 				return {
					message = localize('k_upgrade_ex'),
					card = card
				}
			end
		end
 		if context.joker_main then
			if self.config.mult and self.config.mult > 0 then
				return { mult = self.config.mult }
			end
			return {}
		end
 		if context.end_of_round and context.cardarea == G.jokers then
			self.config.mult = 0
			return { message = "Reset" }
		end

		return {}
	end,
	set_card_type_badge = function(self, card, badges)

	badges[#badges+1] = create_badge("DAWG", {0.7, 0.4, 0.1, 1}, G.C.WHITE, 1.2)
end,
}

















-- new shit

SMODS.Joker {
    key = "coolyog",
    loc_txt = {
        name = "{C:money,E:1}Yogi 'chak-ching' Bear{}",
        text = {
            "{C:attention,E:2}Play well and gain benefits{}",
            "if you perform bad long enough the joker self destructs",
            "{C:legendary,E:1}#1# Reputation{}"
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = { G.GAME.reputation or 5 } }
    end,
    config = { card_to_check = nil, record = 2000 },
    cost = 7,
    unlocked = true,
    rarity = 4,
    atlas = "yogi",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0},
    blueprint_compat = true,
    eternal_compat = false,
    
    calculate = function(self, card, context)

        if context.end_of_round and not context.individual then
            if G.GAME.reputation < 1 then
                card:remove(true)
            end
        end

        if context.press_play then
            G.oldmoney = G.GAME.dollars
        end

        if context.individual and context.cardarea == G.play then
            if context.other_card.edition then
                G.GAME.yogi.reputation = (G.GAME.yogi.reputation or 0) + 0.5
                G.GAME.reputation = G.GAME.reputation + 0.5

                if G.GAME.yogi.reputation >= 10 then
                    return {message = "+0.5", colour = G.C.GREEN, sound = "yogi_coin", dollars = math.floor(G.GAME.yogi.reputation / 2)}
                end
                return {message = "+0.5", colour = G.C.GREEN, sound = "yogi_coin"}
            end
        end

        if context.end_of_round and context.individual and context.cardarea == G.hand then
            local card_to_check = context.other_card
            if card_to_check and card_to_check.config and card_to_check.config.center and card_to_check.config.center.key ~= 'c_base' then
                G.GAME.reputation = (G.GAME.reputation or 0) + 0.25
                return {
                    message = "+0.25",
                    colour = G.C.GREEN,
                    sound = "yogi_coin",
                    no_juice = true
                }
            end
        end

        if context.blind_disabled then
            G.GAME.reputation = (G.GAME.reputation or 0) + 2.5
                return {
                    message = "+2.5",
                    colour = G.C.GREEN,
                    sound = "yogi_won",
                }
        end

        if context.end_of_round and not context.individual then
            if G.GAME.current_round and G.GAME.current_round.hands_left then
                if G.GAME.current_round.hands_left >= 2 then
                    G.GAME.reputation = (G.GAME.reputation or 0) + 0.35
                    G.GAME.yogi.reputation = (G.GAME.yogi.reputation or 0) + 0.35
                    return {
                        message = "+0.35",
                        colour = G.C.GREEN,
                        sound = "yogi_coin",
                        no_juice = true
                    }
                end
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        -- if payday = true we need to apply the rental sticker until no longer payday.
        G.GAME.reputation = G.GAME.reputation or 5
        G.GAME.yogi = {judgement = 0, boredom = 0, impressed = 0, payday = false}
    end
}

SMODS.Joker {
    key = "jackpot",
    loc_txt = {
        name = "Jack-pot",
        text = {
            "if your hand is exactly three {C:attention}7's{}, apply gold seal to each card."
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = {  } }
    end,
    blueprint_compat = true,
    eternal_compat = false,
    config = { },
    cost = 7,
    unlocked = true,
    rarity = 2,
    atlas = "jackpot",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0},
    
    calculate = function(self, card, context)
        if context.before and not context.blueprint and #context.full_hand == 3 then
			for _, card in ipairs(context.full_hand) do
				if card.base and card.base.value == "7" then
					card:set_seal("Gold", nil, false)
				end
			end
	    end
    end,

    add_to_deck = function(self, card, from_debuff)
        play_sound('yogi_cash', 1, 1)
    end
}

--[[
SMODS.Joker {
    key = "fajitas",
    loc_txt = {
        name = "When them fajitas come out sizzlin",
        text = {
            ""
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = {  } }
    end,
    config = { },
    blueprint_compat = true,
    eternal_compat = false,
    cost = 7,
    unlocked = true,
    rarity = 3,
    atlas = "fajitas",
    pos = { x = 0, y = 0 },
    
    calculate = function(self, card, context)
        
    end,

    add_to_deck = function(self, card, from_debuff)
        
    end
}
]]

SMODS.Joker {
    key = "sponge",
    loc_txt = {
        name = "{C:MONEY,E:4,S:1.5}S P O N G E{}",
        text = {
            "on {C:chips}Hand Played{}",
            "Adds a random {C:edition,E:1}edition{} to each {C:attention}Krabby Patty{}"
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return {  }
    end,
    config = {  },
    cost = 15,
    unlocked = true,
    rarity = 2,
    atlas = "spong",
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    eternal_compat = true,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if G and G.jokers and G.jokers.cards then
                for _, joker in ipairs(G.jokers.cards) do

                    local joker_name = ""
                    if joker.config and joker.config.center and joker.config.center.name then
                        joker_name = joker.config.center.name
                    end
                    if joker_name == "j_yogi_krab" then

                        edition_map = { 'e_polychrome', 'e_holo', 'e_foil' }

                        local edition = edition_map[math.random(1, #edition_map)]
                        joker:set_edition(edition, false, false, 0)
                    end

                end
            end

        end
    end,

    add_to_deck = function(self, card, from_debuff)
        
    end
}

SMODS.Joker {
    key = "patrick",
    loc_txt = {
        name = "Patrick Star",
        text = {
            "Will give you quite literally {E:1}anything{}",
            "in his eternal search for instrumental mayonaise"
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return {  }
    end,
    config = {  },
    cost = 15,
    unlocked = true,
    rarity = 3,
    atlas = "patrick",
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    eternal_compat = true,
    
    calculate = function(self, card, context)

        if context.joker_main then

        if math.random(0, 1000) == 0 then
        love.system.openURL("https://youtu.be/xKLsfKY9Zms?si=j9hhakOepa7Y4dLH")
        end
        
        return { chips = math.random(0, 15), mult = math.random(0, 15), xmult = math.random(0, 5), dollars = math.random(0, 15)}
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        
    end
}

SMODS.Joker {
    key = "squidward",
    loc_txt = {
        name = "Squidward Testicles",
        text = {
            "on {C:attention}Blind Start{}",
            "#1# in 4 to create a {C:attention,E:1}Krabby Patty{}"
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = { G.GAME.probabilities.normal } }
    end,
    config = { },
    blueprint_compat = true,
    eternal_compat = true,
    cost = 7,
    unlocked = true,
    rarity = 3,
    atlas = "testicles",
    pos = { x = 0, y = 0 },
    
    calculate = function(self, card, context)
        if context.joker_main then
        if math.random(G.GAME.probabilities.normal, 4) <= G.GAME.probabilities.normal then
            G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function()
                SMODS.add_card  {
                set = "Joker",                
                legendary = false,            
                key = "j_yogi_krab",
                skip_materialize = false,     
                }
                return true
            end
        }))
        return { sound = "yogi_won", message = "Served", colour = G.C.GREEN}
        else
            return { sound = "yogi_no", message = "Failed", colour = G.C.RED}
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        
    end
}

SMODS.Joker {
    key = "krabs",
    loc_txt = {
        name = "Ugiene Krabs",
        text = {
            "{C:inactive}aaaaaaand there's no money in 'eeeeere{}",
            "gives {C:money}7${} at the end of every round",
            "if your money is at or below 0",
            "{C:red}You lose!{}"
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = { card.ability.extra.mult } }
    end,
    config = { extra = { mult = 20 } },
    cost = 4,
    unlocked = true,
    rarity = 2,
    atlas = "krabs",
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    eternal_compat = true,
    
    calculate = function(self, card, context)
        
    end,

    calc_dollar_bonus = function(self, card)
        if G.GAME.dollars > 0 then
            return 7
        else
            ForceLoss()
            return -999
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        
    end
}

SMODS.Joker {
    key = "krab",
    loc_txt = {
        name = "Krabby Patty",
        text = {
            "{C:red}#1#{} Mult every hand played",
            "Decreases mult by 1 every hand",
            "{C:inactive}Currently: #1#{}"
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = { card.ability.extra.mult } }
    end,
    config = { extra = { mult = 20 } },
    cost = 1,
    unlocked = true,
    rarity = 2,
    atlas = "krab",
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    eternal_compat = false,
    
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult - 1

            if card.ability.extra.mult < 1 then
                card.ability.extra.mult = 0
                SMODS.destroy_cards(card, nil, nil, true)
            end


        end

        if context.joker_main then

            return { message = "CROUNCH", sound = "yogi_munch", mult = card.ability.extra.mult,}
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        
    end
}

SMODS.Joker {
    key = "steve",
    loc_txt = {
        name = "Steve",
        text = {
            "Convinces the blind to give you 75% of the chips",
            "with {C:legendary,E:2}Good looks{}"
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = { card.ability.extra.mult } }
    end,
    config = { extra = {  } },
    cost = 1,
    unlocked = true,
    rarity = 3,
    atlas = "steve",
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    eternal_compat = true,
    
    calculate = function(self, card, context)
        if context.setting_blind then
            G.GAME.chips = (G.GAME.blind.chips * 0.75)
            return {message = "Charmed", sound = "yogi_stardrop"}
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        
    end
}

SMODS.Joker {
    key = "gentledog",
    loc_txt = {
        name = "Distinguished Gentleman",
        text = {
            "Gives {X:mult,C:white}X1{} mult for each hand remaining",
            "Currently: {X:mult,C:white}X#1#{}"
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = { G.GAME.current_round.hands_left } }
    end,
    config = { extra = {  } },
    cost = 1,
    unlocked = true,
    rarity = 3,
    atlas = "dogstache",
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    eternal_compat = true,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {xmult = (G.GAME.current_round.hands_left or 1)}
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        
    end
}

SMODS.Joker {
    key = "fallback",
    loc_txt = {
        name = "Unknown Object...?",
        text = {
            "If you're seeing this joker",
            "This is content from {C:orange,E:2}THE FAMS{}",
            "and is {C:red}Not loaded{} currently."
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = {  } }
    end,
    config = { extra = {  } },
    cost = 1,
    unlocked = true,
    no_collection = true,
    rarity = 4,
    atlas = "fallback",
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    eternal_compat = false,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {xmult = (G.GAME.current_round.hands_left or 1)}
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        SMODS.destroy_cards(card, nil, nil, true)
    end,

    in_pool = function(self, args)
        return false
    end
}
G.mirror_options = {}
for key, center in pairs(G.P_CENTERS) do
    if center.set == "Joker" then
        table.insert(G.mirror_options, key)
        print(key)
    end
end

SMODS.Joker {
    key = "mirror",
    loc_txt = {
        name = "Reflection",
        text = {
            "When blind is selected", "become {C:purple,E:yogi_wheel}any joker{}", "whoa"
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = {  } }
    end,
    config = {  },
    cost = 10,
    unlocked = true,
    rarity = 3,
    atlas = "mirror",
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    eternal_compat = false,
    
    calculate = function(self, card, context)
        if context.setting_blind then

            G.E_MANAGER:add_event(Event({
                trigger = "immediate",
                delay = 0 * G.SPEEDFACTOR,
                func = function()
                    Card:flip(true)
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1 * G.SPEEDFACTOR,
                func = function()
                    local grab = G.mirror_options[math.floor(pseudorandom('mirror') * #G.mirror_options)]
                    SMODS.destroy_cards(card, nil, nil, true)
                    SMODS.add_card  {
                        set = "Joker",                
                        legendary = false,            
                        key = grab,
                        skip_materialize = false,     
                    }
                    return true
                end
            }))
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.mirror_options = {}
    end
}

SMODS.Joker {
    key = "contract",
    loc_txt = {
        name = "{C:purple,E:yogi_wheel}Snatcher Contract{}",
        text = {
            "{X:mult,C:white}10X{} Mult",
            "{C:red}Must be sold before showdown (ante 8 boss blind){}"
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = {  } }
    end,
    config = { extra = {  } },
    cost = 1,
    unlocked = true,
    rarity = 3,
    atlas = "contract",
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    eternal_compat = false,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return { xmult = 10 }
        end

        if context.setting_blind then
            if G.GAME.round_resets.ante >= G.GAME.win_ante and G.GAME.blind:get_type() == 'Boss' then
                ForceLoss()
                card:juice_up()
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        
    end
}

SMODS.Joker {
    key = "man",
    loc_txt = {
        name = "Man",
        text = {
            "Man"
        }
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = {  } }
    end,
    blueprint_compat = true,
    eternal_compat = false,
    config = { },
    cost = 2,
    unlocked = true,
    rarity = 2,
    atlas = "man",
    pos = { x = 0, y = 0 },
    
    calculate = function(self, card, context)
        if context.joker_main then
			card:juice_up()
            if math.random(0, 1000) > 999 then
                return {xmult = 1000}
            end
	    end
    end,

    add_to_deck = function(self, card, from_debuff)
        
    end
}

SMODS.Joker {
    key = "walk",
    loc_txt = {
        name = "Walking Green Screen",
        text = {
            "Increases mult by 0.016 every frame, Modulates with 2.8",
            "Currently: {C:red}#1# / 2.8{}"
        }
    },
    loc_vars = function(self, info_queue, card)

        return { vars = { (card.ability.extra.mult or 0) } }
    end,
    blueprint_compat = true,
    eternal_compat = false,
    config = { extra = { mult = 0 } },
    cost = 4,
    unlocked = true,
    rarity = 2,
    atlas = "walk",
    pos = { x = 0, y = 0 },
    
    calculate = function(self, card, context)

        if context.joker_main then
        return {mult = card.ability.extra.mult}
        end

    end,

    update = function(self, card, front)

        if card and card.ability and card.ability.extra and card.ability.extra.mult then
        card.ability.extra.mult = (card.ability.extra.mult or 0) + 0.016
        card.ability.extra.mult = card.ability.extra.mult % 2.8
        end

        card.children.center.sprite_pos = { x = math.ceil(love.timer.getTime() * 30) % 41, y = 0 };
        card:set_sprites();
    end,

    add_to_deck = function(self, card, from_debuff)
        
    end
}

SMODS.Joker {
    key = "Miau",
    loc_txt = {
        name = "{E:yogi_shake}Miau{}",
        text = {
            "{C:red,E:yogi_shake}Loud ass cat!{}"
        }
    },
    loc_vars = function(self, info_queue, card)

        return { vars = {  } }
    end,
    blueprint_compat = true,
    eternal_compat = false,
    config = { extra = { mult = 0 } },
    cost = 4,
    unlocked = true,
    rarity = 1,
    atlas = "miau",
    pos = { x = 0, y = 0 },
    
    calculate = function(self, card, context)

    end,

    add_to_deck = function(self, card, from_debuff)
        play_sound("yogi_miau", 1, 1)
        card:juice_up()
        ForceLoss()
    end
}