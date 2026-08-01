yogi_loaded = true
G.BPM = 120
G.REMOVE_MAIN = false

G.CUTSCENE = false

if fams_loaded then
    love.window.showMessageBox( "A Bone To Pick", "Hey. I noticed that THE FAMS is loaded. This mod is meant to be played without the base fams loaded. You may continue to run it if you'd like but it's recommended to play without it.", warning, true )
end

-- Initialize mod namespace
YGMod = {}



SMODS.Atlas {
    key = "balatro",
    path = "balatro.png",
    px = 450,
    py = 216,
    prefix_config = {
        key = { mod = false },   -- disables mod prefix for 'key'
        atlas = false            -- disables all prefixes for 'atlas'
    }
}





assert(SMODS.load_file('src/general.lua'))()
assert(SMODS.load_file('src/deltarune.lua'))()
assert(SMODS.load_file('src/SongTracker.lua'))()
assert(SMODS.load_file('src/sounds.lua'))()
assert(SMODS.load_file('src/cons.lua'))()
assert(SMODS.load_file('src/update.lua'))()
assert(SMODS.load_file('src/scoring.lua'))()
assert(SMODS.load_file('src/shaders.lua'))()
assert(SMODS.load_file('src/jokers.lua'))()
assert(SMODS.load_file('src/challenges.lua'))()
assert(SMODS.load_file('src/atlas.lua'))()
assert(SMODS.load_file('src/biggerboys.lua'))()
assert(SMODS.load_file('src/timers.lua'))()
assert(SMODS.load_file('src/backs.lua'))()
assert(SMODS.load_file('src/achievements-yside.lua'))()
assert(SMODS.load_file('src/luigi.lua'))()
assert(SMODS.load_file('src/dynatext.lua'))()
assert(SMODS.load_file('src/runinfo.lua'))()
assert(SMODS.load_file('src/pokerhands.lua'))()
assert(SMODS.load_file('src/quips.lua'))()
assert(SMODS.load_file('src/collector.lua'))()
assert(SMODS.load_file('src/editions.lua'))()
assert(SMODS.load_file('src/vouchers.lua'))()
assert(SMODS.load_file('src/stickers.lua'))()
assert(SMODS.load_file('src/tags.lua'))()
assert(SMODS.load_file('src/enhancements.lua'))()
build_large_textures()
print("[LEAFI] - I'm gonna be honest the lore panels is why your load time went up by possibly 3.5 seconds :(")

if fams_loaded then
    assert(SMODS.load_file('src/FamsExc.lua'))()
    print("FAMS was found! ")
end

G.krusty = new_arbituary_image("textures/krustykrab.png")
G.borfroom = new_arbituary_image("textures/borfroom.png")
G.blue = new_arbituary_image("textures/squaredeco.png")


function removeUIBOX()
    G.HUD.states.visible = false
    G.HUD_blind.states.visible = false
end

function restoreUIBOX()
    G.HUD.states.visible = true
    G.HUD_blind.states.visible = true
end

function removeCARDAREA()
    G.jokers.states.visible = false
    G.consumeables.states.visible = false
    G.hand.states.visible = false
end

function restoreCARDAREA()
    G.consumeables.states.visible = true
    G.jokers.states.visible = true
    G.hand.states.visible = true
end

amountselected = function()
    local selected = {}
    for i, card in ipairs(G.hand.cards) do
         if card.highlighted then
            table.insert(selected, card)
        end
    end
    return #selected
end

function yogi_gameover()
    print("u lost hahahahahahahahhahahahaahhaahahhahhhahhahhaha")

    restoreCARDAREA()
    restoreUIBOX()

    if isChallenge("krab") then
        play_sound('yogi_bowomp', 1, 1)
    end

    if G.GAME.blind.name == "bl_yogi_graze" then
        play_sound('yogi_break', 1, 1)
    end




    get_current_profile().deathcount = (get_current_profile().BSScore or 0) + 1
end

function yogi_startgame()
    G.DASH = false
    print("setup!")
    G.wantedfaces = {}
    G.MOD_TIMERS = {}
    G.LGalpha = 1
    G.LGendalpha = 0
    if not timer_exists("speed") then
        G.niceloop = false
    end

    if isChallenge("onemore") and G.GAME.round_resets.ante < 11 then
        make_timer("onemore", 500, function()
			ForceLoss()
		end, false, 1)
		set_deathwish_timer("onemore")
    end

    if isChallenge("sun") then
        G.GAME.base_reroll_cost = 2
    end

    if has_modifier("ante_up") then
        G.GAME.win_ante = G.GAME.modifiers.ante_up
    end


end



function pause_trigger()
    print("opened pause")

    if timer_exists("speed") and G.STATE ~= G.STATES.GAME_OVER then
        ForceLoss()
	end

    if isChallenge("onemore") and G.STATE ~= G.STATES.GAME_OVER and G.GAME.round_resets.ante < 11 then
        ForceLoss()
	end
end

function eval_trigger()

    if has_modifier("magic") then

        yogi_magic_reload()

        for _, card in ipairs(G.deck.cards) do
        G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            delay = 0,
            func = function()
                card:flip(true)
                card:set_seal(G.sealcollection[math.random(1, #G.sealcollection)], true, true)
                card:set_edition(G.editioncollection[math.random(1, #G.editioncollection)], true, true, false)
                card:set_ability(G.enhancedcollection[math.random(1, #G.enhancedcollection)], false, true)
                card:flip(false)
                return true
            end
        }))
    end

    G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            delay = 0,
            func = function()
                G.deck.cards[1]:juice_up()
                play_sound("tarot2", 1, 1)
                return true
            end
        }))
    
    end



    G.DASH = false

    if G.GAME.FLAGS.confuserflag then
    G.GAME.FLAGS.confuserflag = false

    for _, joker in ipairs(G.jokers.cards) do
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 1,
            func = function()
                local index = joker
                index:flip(false)
                return true
            end
        }))
    end
end


    restoreUIBOX()
	restoreCARDAREA()

    if G.GAME.blind.name == "bl_yogi_last" then
        play_sound("yogi_snd_bigdefeat", 1, 1)
    end

    if timer_exists("speed") and G.GAME.blind:get_type() == 'Boss' then
        G.TIMER_TRACK.seconds = G.TIMER_TRACK.seconds + 35
        G.TIMER_TRACK.scale = G.TIMER_TRACK.scale + 0.05
        play_sound('yogi_won', 1, 1)
    end

    if isChallenge("onemore") and G.GAME.round_resets.ante == 10 and not G.TIMER_TRACK.evil2 and G.GAME.cutscene2 == false then
        G.TIMER_TRACK.evil2 = true
        G.TIMER_TRACK.scale = 3
        G.GAME.cutscene2 = true
        play_sound('yogi_angry', 1, 1)
    end

    if isChallenge("onemore") and G.GAME.round_resets.ante >= 11 and not G.TIMER_TRACK.paused == true and G.GAME.cutscene3 == false then
        G.TIMER_TRACK.paused = true
        G.TIMER_TRACK.scale = 0
        set_deathwish_timer("onemore")

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 5,
            func = function()
                local cutscene_push = 0
                if love.mouse.isDown(1) then
                    cutscene_push = 0.05
                end

                G.LGalpha = G.LGalpha - (0.001 + cutscene_push)
                G.LGendalpha = G.LGendalpha + (0.001 + cutscene_push)
                
                if (G.LGendalpha > 1 and G.LGalpha < 0) then
                    G.GAME.cutscene3 = true
                end
                return G.LGendalpha > 1 and G.LGalpha < 0
            end
        }))
    end

    if isChallenge("onemore") and G.GAME.round_resets.ante >= 8 and not G.TIMER_TRACK.evil and G.GAME.cutscene1 == false then
        play_sound('yogi_break', 1, 1)
        G.TIMER_TRACK.scale = 2
        G.TIMER_TRACK.evil = true

        G.GSAVE = G.SETTINGS.GAMESPEED

        G.SETTINGS.GAMESPEED = 2
        G.TIMER_TRACK.paused = true

        G.returnx = G.jokers.CT.x
        G.returny = G.jokers.CT.y
        G.returncardw = G.jokers.card_w

        G.CUTSCENE = true

        G.jokers.cards = {}

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 1,
            func = function()
                removeUIBOX()
                G.jokers.CT.y = 4.4
                G.jokers.CT.x = 5.1
                G.jokers.card_w = 2.8
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 5,
            func = function()
                play_sound("yogi_japhit", 1, 1)
                SMODS.add_card  {
                    set = "Joker",         
                    edition = "e_polychrome",        
                    legendary = false,            
                    key = "j_yogi_earl",
                    skip_materialize = false,     
                }
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 1,
            func = function()
                play_sound("yogi_japhit", 1.02, 1)
                SMODS.add_card  {
                    set = "Joker",           
                    edition = "e_polychrome",      
                    legendary = false,            
                    key = "j_yogi_yogi",
                    skip_materialize = false,     
                }
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 1,
            func = function()
                play_sound("yogi_japhit", 1.05, 1)
                SMODS.add_card  {
                    set = "Joker",        
                    edition = "e_polychrome",         
                    legendary = false,            
                    key = "j_yogi_bear",
                    skip_materialize = false,     
                }
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 1,
            func = function()
                play_sound("yogi_japhit", 1.07, 1)
                SMODS.add_card  {
                    set = "Joker",         
                    edition = "e_polychrome",        
                    legendary = false,            
                    key = "j_yogi_radiation",
                    skip_materialize = false,     
                }
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 1,
            func = function()
                play_sound("yogi_japhit", 1.1, 1)
                SMODS.add_card  {
                    set = "Joker",
                    edition = "e_polychrome", 
                    legendary = false,            
                    key = "j_yogi_butterdog",
                    skip_materialize = false,  
                }
                G.SETTINGS.GAMESPEED = G.GSAVE
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 3,
            func = function()
                restoreUIBOX()
                G.CUTSCENE = false
                G.jokers.CT.y = G.returny
                G.jokers.CT.x = G.returnx
                G.TIMER_TRACK.paused = false
                G.jokers.card_w = G.returncardw
                G.GAME.cutscene1 = true
                return true
            end
        }))
    end


    you_won()
end

function Reset_High_Score()
    get_current_profile().BSScore = 1
    get_current_profile().BSSeed = nil
end

function yogi_press_play()
    print("Pressed Play")


    if G.GAME.ARMOR == "trad" then
        print("Trad Effect")
        play_sound("yogi_break", 1, 1)
        play_sound("yogi_coin", 1, 1)
        G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + 1
    end

    if G.GAME.CHARM == "confuser" and not G.GAME.FLAGS.confuserflag then
        print("confuser Effect")
        G.GAME.FLAGS.confuserflag = true

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
                G.jokers:shuffle('aajk')
                return true
            end
        }))

        G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 4
    end
end

function you_won()
    
end

function yogi_hover_card(card)

    YGMod.lasthovered = card
    G.hoveringitemcard = card.ability.set == "armor" or card.ability.set == "charm"

    if G.hoveringitemcard then
        play_sound('yogi_snd_noise', 1.2, 1)
    end

end

function yogi_prehover_card(card)

end

function yogi_stop_hover(card)

    if G.hoveringitemcard then
        play_sound('yogi_snd_noise', 0.7, 1)
    end

    G.hoveringitemcard = false
end

function yogi_create_event(acttype, waittime, actions)
    G.E_MANAGER:add_event(Event({
        trigger = tostring(acttype),
        delay = waittime * G.SPEEDFACTOR,
        func = actions or function()    return true end
    }))
end

function yogi_add_game(self)
    self.GAME.ARMOR = nil
    self.GAME.ARMOR_NAME = "c_yogi_empty"
    self.GAME.CHARM = nil
    self.GAME.CHARM_NAME = "c_yogi_emptycharm"
    self.GAME.STATS = {atk = 0, def = 0, agl = 0, grazeadd = 0, base = {  }}
    self.GAME.timeroffset = {}
    self.GAME.FLAGS = {}
    self.GAME.FLIPSPEED = 1

    if isChallenge("onemore") then
        self.GAME.cutscene1 = false
        self.GAME.cutscene2 = false
        self.GAME.cutscene3 = false
    end

end


function yogi_blind_set()
    print("setting blind stuff!")

    if G.GAME.CHARM == "boost1" then
        for _, card in ipairs(G.deck.cards) do
            card.ability.perma_bonus = card.ability.perma_bonus + 15
        end
        play_sound('tarot2', 1, 0.4)
    end
end

function yogi_card_clicked(self)
    if self.debuff and isChallenge("flipmania") then
        play_sound("yogi_damage", 1, 1)
        G.GAME.chips = G.GAME.chips - (G.GAME.blind.chips / 10)
        self:juice_up()
    end

    if isChallenge("10") then
        ease_ante(-0.01);
    end
end


