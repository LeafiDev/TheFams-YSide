SMODS.Blind {
    key = "nosee",
	atlas = "nosee",
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "The Night Light",
        text = {"You have limited vision"}
    },
	boss = ({ min = 1 }),
    dollars = 5,
    mult = 2,
	boss_colour = HEX('000000'),
    set_blind = function(self)
        
    end,
    debuff_hand = function(self, cards, hand, handname, check)
         
    end,
    get_loc_debuff_text = function(self)
        
    end
}

SMODS.Blind {
    key = "graze",
	atlas = "graze",
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "The Graze",
        text = {"Graze Bullets to gain chips.", "WASD or Arrows to move."}
    },
	boss = ({ min = 2 }),
    dollars = 5,
    mult = 1,
	boss_colour = HEX('FF7F27'),
    set_blind = function(self)
        G.bullet_spawn_rate = 0.25
        G.GAME.CANCHIPGRAZE = true
        G.GAME.GRAZEWIN = false
        G.GAME.attacktype = "graze"
    end,
    debuff_hand = function(self, cards, hand, handname, check)
         
    end,
    get_loc_debuff_text = function(self)
        
    end
}


SMODS.Blind {
    key = "earl",
	atlas = "earl",
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Earl Joe",
        text = {"graze to earn hands", "WASD or Arrows to move.", "New attack every hand played", "same attack if discarding"}
    },
	boss = ({ min = 1 }),
    dollars = 5,
    mult = 20,
	boss_colour = HEX('663300'),
    set_blind = function(self)
        G.GAME.attacktime = 0
        G.GAME.earlattack = -1
        play_sound('yogi_weaponpull', 1, 1)
        G.GAME.CANCHIPGRAZE = false
        G.GAME.GRAZEWIN = false
            G.soul.x = love.graphics.getWidth() / 2
            G.soul.y = love.graphics.getHeight() / 2
        if G.GAME then
            G.GAME.attacktime = 0
            G.GAME.attacktype = "earl"
        end

        make_timer("earl", 350, function()
            ForceLoss()
        end, false, 1)
        set_deathwish_timer("earl")
    end,
    debuff_hand = function(self, cards, hand, handname, check)
         
    end,
    press_play = function(self)
        G.battle_box.width = 500
        G.battle_box.width = 500
        G.GAME.earlattack = math.random(0, 2)
        if G.GAME.earlattack == 1 then
            G.soul.inv = 65
            G.warner.x = 960
            G.soul.x = 900 - 700
            G.soul.y = love.graphics.getHeight() / 2
        end
    end,
    defeat = function(self, cards, hand, handname, check)
        remove_timer("earl")
        restoreUIBOX()
        G.bullets = {}
    end,
    drawn_to_hand = function(self)
        removeUIBOX()
        removeCARDAREA()

        if G.GAME.earlattack == -1 then
            restoreUIBOX()
            restoreCARDAREA()
        end

        if G.GAME.earlattack == 0 then
            G.GAME.attacktime = 12
            G.GAME.attacktype = "earl"
            G.bullet_spawn_rate = 0.09
        end

        if G.GAME.earlattack == 1 then
            G.GAME.attacktime = 12
            G.GAME.attacktype = "earl_2"
            G.bullet_spawn_rate = 0.08
        end

        if G.GAME.earlattack == 2 then
            G.GAME.attacktime = 12
            G.GAME.attacktype = "earl_3"
            G.bullet_spawn_rate = 0.08
        end

        if G.GAME.earlattack == 3 then
            G.GAME.attacktime = 12
            G.GAME.attacktype = "earl_4"
            G.bullet_spawn_rate = 0.24
        end

    end,
    in_pool = function(self)
        return has_modifier("earlboss")
    end
}

SMODS.Blind {
    key = "luigi",
	atlas = "luigi",
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "BLIND WANTED",
        text = {"Find Luigi"}
    },
	boss = ({ min = 1 }),
    dollars = 10,
    mult = 99,
	boss_colour = HEX('3DAE2B'),
    set_blind = function(self)
        G.ENDSTOP = false
        G.luigiwin = false
        if not timer_exists("speed") then
            make_timer("luigi", 60, function()
                ForceLoss()
            end, false, 0.3)
            set_deathwish_timer("luigi")
        end
        spawn_face(true)
        G.FACECOUNT = 0
        for face = 0, 300 do
            spawn_face()
        end
    end,

    debuff_hand = function(self, cards, hand, handname, check)
        
    end,

    get_loc_debuff_text = function(self)
        
    end,

    drawn_to_hand = function(self)
        
    end,

    defeat = function(self, cards, hand, handname, check)
        
        remove_timer("luigi")
        G.bullets = {}
    end
}

SMODS.Blind {
    key = "clock",
	atlas = "clock",
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "The Quick Time",
        text = {"5 seconds per hand", "lose the run on timeout"}
    },
	boss = ({ min = 3 }),
    dollars = 7,
    mult = 1.5,
	boss_colour = HEX('d8a5ff'),
    set_blind = function(self)
        if not timer_exists("quick") then
            make_timer("quick", 5, function()
                ForceLoss()
            end, false, 1)
            set_deathwish_timer("quick")
        end
    end,

    debuff_hand = function(self, cards, hand, handname, check)
        
    end,

    get_loc_debuff_text = function(self)
        
    end,

    press_play = function(self)
        remove_timer("quick")
    end,

    drawn_to_hand = function(self)
        if not timer_exists("quick") and context.drawn_to_hand then
            make_timer("quick", 5, function()
                ForceLoss()
            end, false, 1)
            set_deathwish_timer("quick")
        end
    end,

    calculate = function(self, blind, context)
        if not timer_exists("quick") and context.hand_drawn then
            make_timer("quick", 5, function()
                ForceLoss()
            end, false, 1)
            set_deathwish_timer("quick")
        end
    end,

    defeat = function(self, cards, hand, handname, check)
        
    end
}

SMODS.Blind {
    key = "salary",
	atlas = "salary",
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "The Salary",
        text = {"Complete the blind in #1# seconds", "You have no hand limit", "time is lowered based on ante"}
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = { 500 / G.GAME.round_resets.ante } }
    end,
	boss = ({ min = 3 }),
    dollars = 10,
    mult = 5,
	boss_colour = HEX('ffd3a5'),
    set_blind = function(self)
        if not timer_exists("work") then
            make_timer("work", 500 / G.GAME.round_resets.ante, function()
                ForceLoss()
            end, false, 1)
            set_deathwish_timer("work")
        end
    end,

    calculate = function(self, blind, context)
        if not timer_exists("work") then
            make_timer("work", 500 / G.GAME.round_resets.ante, function()
                ForceLoss()
            end, false, 1)
            set_deathwish_timer("work")
        end
    end,

    recalc_debuff = function(self, card, from_blind)
        
    end,

    get_loc_debuff_text = function(self)

    end,

    press_play = function(self)
        
    end,

    drawn_to_hand = function(self)
        G.GAME.current_round.hands_left = G.GAME.round_resets.hands
    end,

    defeat = function(self, cards, hand, handname, check)
        remove_timer("work")
    end


}

SMODS.Blind {
    key = "mash",
	atlas = "salary",
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "The Masher",
        text = {"Mash Space #1# times in 10 seconds"}
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = { math.floor(25 * G.GAME.round_resets.ante) } }
    end,
	boss = ({ min = 2 }),
    dollars = 5,
    mult = 0,
	boss_colour = HEX('ffd3a5'),
    set_blind = function(self)
        G.GAME.mashcount = 0
        if not timer_exists("mash") then
            make_timer("mash", 10, function()
            ForceLoss()
            end, false, 1)
            set_deathwish_timer("mash")
        end
    end,

    calculate = function(self, blind, context)
        if not timer_exists("mash") and not G.STATE == 8 then
            make_timer("mash", 10, function()
            ForceLoss()
            end, false, 1)
            set_deathwish_timer("mash")
        end
    end,

    recalc_debuff = function(self, card, from_blind)
        
    end,

    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        
    end,

    get_loc_debuff_text = function(self)

    end,

    press_play = function(self)
        
    end,

    drawn_to_hand = function(self)
        
    end,

    defeat = function(self, cards, hand, handname, check)
        
    end


}

SMODS.Blind {
    key = "view",
	atlas = "view",
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "The View",
        text = {"Take a break and view your achievement.", "click when ready to continue!", "Thanks for playing <3"}
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = {  } }
    end,
	boss = ({ min = 11 }),
    dollars = 0,
    mult = 0,
	boss_colour = HEX('000071'),
    set_blind = function(self)
        G.CUTSCENE = true
    end,

    calculate = function(self, blind, context)
        if context.setting_blind then
            removeUIBOX()
		    removeCARDAREA()
        end
    end,

    recalc_debuff = function(self, card, from_blind)
        
    end,

    get_loc_debuff_text = function(self)

    end,

    press_play = function(self)
        
    end,

    drawn_to_hand = function(self)
        if G.CUTSCENE == true then
            G.HUD.states.visible = false
            G.HUD_blind.states.visible = false
            G.jokers.states.visible = false
            G.consumeables.states.visible = false
            G.hand.states.visible = false
        end
    end,

    defeat = function(self, cards, hand, handname, check)
        G.HUD.states.visible = true
        G.HUD_blind.states.visible = true
        G.jokers.states.visible = true
        G.consumeables.states.visible = true
        G.hand.states.visible = true
        restoreUIBOX()
        restoreCARDAREA()
        G.CUTSCENE = false
    end


}

SMODS.Blind {
    key = "last",
	atlas = "lastdash",
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "The Last Dash",
        text = {"Give everything you got"}
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = {  } }
    end,
	boss = ({ showdown = true }),
    dollars = 0,
    mult = 11,
	boss_colour = HEX('ffff00'),
    set_blind = function(self)
        G.GAME.current_round.hands_left = 10
        G.CUTSCENE = true
        G.DASH = false
        G.TIMER_TRACK.paused = true
        for _, joker in ipairs(G.jokers.cards) do
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 1,
            func = function()
                local index = joker
                index:flip(true)
                return true
            end
        }))
    end

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 1,
            func = function()
                play_sound("yogi_snd_lastboost", 1, 1)
                return true
            end
        }))

    for _, joker in ipairs(G.jokers.cards) do
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.46,
            func = function()
                local index = joker
                index:flip(false)
                G.TIMER_TRACK.paused = false
                G.TIMER_TRACK.scale = 4
                G.CUTSCENE = false
                G.DASH = true
                return true
            end
        }))
    end
        
    end,

    calculate = function(self, blind, context)

    end,

    recalc_debuff = function(self, card, from_blind)
        
    end,

    get_loc_debuff_text = function(self)

    end,

    press_play = function(self)
        
    end,

    drawn_to_hand = function(self)

    end,

    defeat = function(self, cards, hand, handname, check)
        
    end,

    in_pool = function(self)
        return isChallenge("onemore")
    end


}