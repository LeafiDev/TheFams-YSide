
assert(SMODS.load_file('src/3drenderer.lua'))()

G.C.EARL = {0.314, 0.22, 0.169, 1}

local mod = SMODS.Mods["y-side"]
local config = mod.config

config.music = config.music or {
    option_1 = "Y-SIDE",
    option_2 = "FAMS",
    option_3 = "FAMS (DAWG TRIALS)",
    option_4 = "BALATRO",
    current = 1
}

config.always_kill = config.always_kill or {
    option_1 = "REQUIRED",
    option_2 = "ALWAYS",
    current = 1
}

G.MUSIC_ID = config.music["option_" .. config.music.current]
G.MENUKILL = config.always_kill["option_" .. config.always_kill.current]

G.FUNCS.FAMS_CHANGE_MUSIC = function(args)
    config.music.current = args.cycle_config.current_option
    G.MUSIC_ID = config.music["option_" .. config.music.current]
    print(G.MUSIC_ID)
end

G.FUNCS.FAMS_CHANGE_KILL = function(args)
    config.always_kill.current = args.cycle_config.current_option
    G.MENUKILL = config.always_kill["option_" .. config.always_kill.current]
    print(G.MENUKILL)
end

mod.config_tab = function()
    local music = config.music
    local always_kill = config.always_kill
    local speedrun = config.speedrun

    local options = {
        "Y-SIDE",
        "FAMS",
        "FAMS (DAWG TRIALS)",
        "BALATRO"
    }

    local options2 = {
        "REQUIRED",
        "ALWAYS"
    }

    local options3 = {
        "VISIBLE",
        "INVISIBLE"
    }

    return {
        n = G.UIT.ROOT,
        config = { colour = G.C.CLEAR },
        nodes = {
        {
            n = G.UIT.R,
            config = {
                align = "cm",
                padding = 0.05
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        text = "Preferred Song Selection",
                        scale = 0.5,
                        colour = G.C.WHITE
                    }
                }
            }
        },
        {
            n = G.UIT.R,
            config = {
                align = "cm",
                padding = 0.05,
                r = 0.1,
                emboss = 0.1,
                colour = G.C.L_BLACK
            },
            nodes = {
                create_option_cycle({
                    options = options,
                    opt_callback = 'FAMS_CHANGE_MUSIC',
                    current_option = music.current,
                    colour = G.C.BLUE,
                    w = 6,
                    scale = 1
                })
            }
        },

        {
            n = G.UIT.R,
            config = {
                align = "cm",
                padding = 0.05
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        text = "Run Forfeiting",
                        scale = 0.5,
                        colour = G.C.WHITE
                    }
                },
            }
        },
        {
            n = G.UIT.R,
            config = {
                align = "cm",
                padding = 0.05,
                r = 0.1,
                emboss = 0.1,
                colour = G.C.L_BLACK
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        text = "The game will automatically fail the run if you open options or press ESC in a run",
                        scale = 0.25,
                        colour = G.C.WHITE
                    }
                },
            }
        },
        {
            n = G.UIT.R,
            config = {
                align = "cm",
                padding = 0.05,
                r = 0.1,
                emboss = 0.1,
                colour = G.C.L_BLACK
            },
            nodes = {
                create_option_cycle({
                    options = options2,
                    opt_callback = 'FAMS_CHANGE_KILL',
                    current_option = always_kill.current,
                    colour = G.C.ORANGE,
                    w = 6,
                    scale = 1
                })
            }
        }
    }
    }
end





SMODS.Rarity {
    key = "ultrarare",
    loc_txt = {
        name = "Super rare but ALSO not rare enough to be legendary"
    },
    default_weight = 0.01,
    badge_colour = HEX('D02D64'),
    get_weight = function(self, weight, object_type)
        return weight
    end,
}




-- below configs
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
assert(SMODS.load_file('src/boosters.lua'))()
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
assert(SMODS.load_file('src/challenge-def.lua'))()

assert(SMODS.load_file('src/extra-scripts.lua'))()


if not G.PROFILES[G.SETTINGS.profile].challenge_progress.completed_golden then
    G.PROFILES[G.SETTINGS.profile].challenge_progress.completed_golden = {}
end

if not G.PROFILES[G.SETTINGS.profile].challenge_progress.completed_earl then
    G.PROFILES[G.SETTINGS.profile].challenge_progress.completed_earl = {}
end


build_large_textures()

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

    if isChallenge("krab") then
        play_sound('yogi_bowomp', 1, 1)
    end

    if G.GAME.blind.name == "bl_yogi_graze" then
        play_sound('yogi_break', 1, 1)
    end

    if G.consumeables and G.jokers then
        restoreCARDAREA()
        restoreUIBOX()
    end




    get_current_profile().deathcount = (get_current_profile().BSScore or 0) + 1
end

function yogi_startgame()
    if not G.GAME.alreadystarted then
        ExtraScriptActivate()

        G.GAME.reputation = 0
        G.TIMERTICK = 0
        if G.YOGIHARDMODE then
            G.GAME.HARDMODE = true
        end
        if G.YOGICHALLENGEMODE then
            G.GAME.YOGICHALLENGEMODE = true
        end

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

        if has_modifier("set_rep") then
            G.GAME.reputation = G.GAME.modifiers.set_rep
        end

        if has_modifier("set_scaling") then
            G.GAME.starting_params.ante_scaling = G.GAME.modifiers.set_scaling
        end
        G.GAME.alreadystarted = true
    end




    if isChallenge("scale") then

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.5,
            func = function()

                local SC_scale = 1.3
                G.YOGICOMMUNICATION = Card(G.ROOM.T.w/2 - SC_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC_scale*G.CARD_H/2, SC_scale*G.CARD_W, SC_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS['j_yogi_yogi'])
                G.YOGICOMMUNICATION.T.y = G.ROOM.T.h/2 - SC_scale*G.CARD_H/2
                G.YOGICOMMUNICATION.ambient_tilt = 0.8
                G.YOGICOMMUNICATION.states.drag.can = false
                G.YOGICOMMUNICATION.states.hover.can = false
                G.YOGICOMMUNICATION.no_ui = false


                return true
            end
        }))


        local cutscenetimer = 0
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.5,
            func = function()
                cutscenetimer = cutscenetimer + 1

                if cutscenetimer == 25 then
                    G.YOGICOMMUNICATION:juice_up()
                    G.YOGICOMMUNICATION.edition = {type = "yogi_Premium", money = 12, yogi_Premium = true, key = "e_yogi_Premium"}
                end

                if cutscenetimer == 55 then
                    G.YOGICOMMUNICATION.T.x = 18
                    G.YOGICOMMUNICATION.T.y = 7
                    G.YOGICOMMUNICATION.T.scale = 0.5
                end
                
                return cutscenetimer > 100
            end
        }))
    end

    G.YOGIHARDMODE = false
end



function pause_trigger()
    print("opened pause")

    if timer_exists("speed") and G.STATE ~= G.STATES.GAME_OVER then
        ForceLoss()
	end

    if isChallenge("onemore") and G.STATE ~= G.STATES.GAME_OVER and G.GAME.round_resets.ante < 11 then
        ForceLoss()
	end

    if G.MENUKILL == "ALWAYS" then
        ForceLoss()
    end
end

function eval_trigger()
    print("winner winner chicken dinner")

    play_sound("yogi_goodjob", 1, 1)

    if isChallenge("scale") then



        local cutscenetimer = 0
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.5,
            func = function()
                G.CUTSCENE = true
                cutscenetimer = cutscenetimer + 1

                if cutscenetimer == 25 then
                    G.YOGICOMMUNICATION:juice_up()
                    G.YOGICOMMUNICATION.T.scale = 0.8
                    G.YOGICOMMUNICATION.T.x = 14
                    G.YOGICOMMUNICATION.T.y = 4
                end
                
                return cutscenetimer > 100 and love.mouse.isDown(1)
            end
        }))

        local cutscenetimer = 0
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.5,
            func = function()
                G.CUTSCENE = false
                G.YOGICOMMUNICATION.T.x = 18
                G.YOGICOMMUNICATION.T.y = 7
                G.YOGICOMMUNICATION.T.scale = 0.5
                return true
            end
        }))




    end

    if has_modifier("lowest_score") then
        if G.GAME.round_scores.hand.amt < G.GAME.modifiers.lowest_score then
            ForceLoss()
        end
    end

    if has_modifier("lowest_score_increases") and has_modifier("lowest_score") and G.GAME.blind:get_type() == 'Boss' then
        print("increased")
        G.GAME.modifiers.lowest_score = G.GAME.modifiers.lowest_score + G.GAME.modifiers.lowest_score_increases
        attention_text({
            scale = 1, text = "Bard Increased", hold = 5, align = 'cm',
            cover = G.HUD, cover_padding = 1, cover_colour = adjust_alpha(G.C.RED, 0.5)
        })
        play_sound('highlight2', 0.65, 0.2)
        G.GAME.playingboss = false
    end

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

        if G.GAME.YOGICHALLENGEMODE == true then

            play_sound("yogi_damage", 1, 1)
            ForceLoss()
            self:juice_up()

        else

            play_sound("yogi_damage", 1, 1)
            G.GAME.chips = G.GAME.chips - (G.GAME.blind.chips / 10)
            self:juice_up()

        end
    end

    if isChallenge("10") then
        if G.GAME.YOGICHALLENGEMODE then
            ease_ante(-0.05);
        else
            ease_ante(-0.01);
        end
    end

    if G.jokers and self.config.center_key == "j_yogi_5dollar" and G.jokers.cards[self.rank].highlighted == false then
        if (G.jokers.cards[self.rank + 1] ~= nil or G.jokers.cards[self.rank].ability.extra.stored ~= false) then
            local yogi = G.jokers.cards[self.rank]
            local extra = yogi.ability.extra

            if extra.stored == false then
                local card = G.jokers.cards[self.rank + 1]

                extra.stored = card

                G.jokers:remove_card(card)
                G.storearea:emplace(card)

            else
                local restore = extra.stored

                G.storearea:remove_card(restore)
                G.jokers:emplace(restore)

                extra.stored = false
            end

            G.jokers:align_cards()
        else
            self:juice_up()
            if G.jokers.cards[self.rank + 1] == nil then
                attention_text({
                    scale = 0.5, text = "No Card", hold = 0.9, align = 'cm',
                    cover = G.jokers, cover_padding = 0.1, cover_colour = adjust_alpha(G.C.BLACK, 0.7)
                })
            end
        end
    end
end









SMODS.current_mod.custom_card_areas = function(game)
 G.storearea = CardArea(
    game.jokers.T.x, game.jokers.T.y - 9,
    game.jokers.T.w, game.jokers.T.h / 2,
    { card_limit = 9999, type = 'joker', highlight_limit = 0 }
 )
end


function Game:splash_screen()
yogi_i = 0
    --If the skip splash screen option is set, immediately go to the main menu here
    if G.SETTINGS.skip_splash == 'Yes' then 
        G:main_menu()
        return 
    end

    G.CUTSCENE = true

    self:prep_stage(G.STAGES.MAIN_MENU, G.STATES.SPLASH, true)
    G.E_MANAGER:add_event(Event({
        func = (function()
            discover_card()
            return true
        end)
      }))

      G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function()
            G.TIMERS.TOTAL = 0
            G.TIMERS.REAL = 0
            --Prep the splash screen shaders for both the background(colour swirl) and the foreground(white flash), starting at black
            G.SPLASH_BACK = Sprite(-30, -13, G.ROOM.T.w+60, G.ROOM.T.h+22, G.ASSET_ATLAS["ui_1"], {x = 2, y = 0})
            G.SPLASH_BACK:define_draw_steps({{
                shader = 'splash',
                send = {
                    {name = 'time', ref_table = G.TIMERS, ref_value = 'REAL'},
                    {name = 'vort_speed', val = 1},
                    {name = 'colour_1', ref_table = G.C, ref_value = 'ORANGE'},
                    {name = 'colour_2', ref_table = G.C, ref_value = 'MONEY'},
                    {name = 'mid_flash', val = 0},
                    {name = 'vort_offset', val = (8*yogi_i*os.time())%10000000000000000000},
                }}})
            G.SPLASH_BACK:set_alignment({
                major = G.ROOM_ATTACH,
                type = 'cm',
                offset = {x=0,y=0}
            })
            G.SPLASH_FRONT = Sprite(0,-20, G.ROOM.T.w*2, G.ROOM.T.h*4, G.ASSET_ATLAS["ui_1"], {x = 2, y = 0})
            G.SPLASH_FRONT:define_draw_steps({{
                shader = 'flash',
                send = {
                    {name = 'time', ref_table = G.TIMERS, ref_value = 'REAL'},
                    {name = 'mid_flash', val = 1}
                }}})
            G.SPLASH_FRONT:set_alignment({
                major = G.ROOM_ATTACH,
                type = 'cm',
                offset = {x=0,y=0}
            })

            --spawn in splash card
            local SC = nil
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = (function()

                local SC_scale = 1.3
                SC = Card(G.ROOM.T.w/2 - SC_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC_scale*G.CARD_H/2, SC_scale*G.CARD_W, SC_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS['j_yogi_yogi'])
                SC.T.y = G.ROOM.T.h/2 - SC_scale*G.CARD_H/2
                SC.ambient_tilt = 0
                SC.states.drag.can = false
                SC.states.hover.can = false
                SC.no_ui = true

                G.VIBRATION = G.VIBRATION + 2

                play_sound('whoosh1', 0.7, 0.2)
                play_sound('introPad1', 0.704, 0.6)
            return true;end)}))

            --dissolve fool card and start to fade in the vortex
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 1.8,func = (function() --|||||||||||
            print(startupframe)
                SC:start_dissolve({G.C.CHIPS, G.C.CHIPS},true, 12, true)
                play_sound('magic_crumple', 1, 0.5)
                play_sound('splash_buildup', 1, 0.7)
            return true;end)}))

            --create all the cards and suck them in
            function make_splash_card(args)
                args = args or {}
                local angle = math.random()*2*3.14
                local card_size = (args.scale or 1.5)*(math.random() + 1)
                local card_pos = args.card_pos or {
                    x = (18 + card_size)*math.sin(angle),
                    y = (18 + card_size)*math.cos(angle)
                }
                local center = G.P_CENTERS.c_base
                local face = pseudorandom_element(G.P_CARDS)
                -- small chance to spawn a random mod 'yogi' joker instead of a regular playing card
                    local yogi = {}
                    for k, _ in pairs(G.P_CENTERS or {}) do
                        if type(k) == 'string' and (k:match('^j_yogi_') or k:match('^c_yogi_') or k:match('^bl_yogi_') or k:match('^tag_yogi_')) and not k:match('^j_yogi_skeleton') and not k:match('^c_yogi_A') then table.insert(yogi, k) end
                    end
                    if #yogi > 0 then
                        local chosen = yogi[math.random(#yogi)]
                        center = G.P_CENTERS[chosen] or center
                        face = nil
                    end
                local card = Card(  card_pos.x + G.ROOM.T.w/2 - G.CARD_W*card_size/2,
                                    card_pos.y + G.ROOM.T.h/2 - G.CARD_H*card_size/2,
                                    card_size*G.CARD_W, card_size*G.CARD_H, face, center)
                if math.random() > 1.1 then card.sprite_facing = 'back'; card.facing = 'back' end
                card.no_shadow = true
                card.states.hover.can = false
                card.states.drag.can = false
                card.vortex = true and not args.no_vortex
                card.T.r = angle
                return card, card_pos
            end

            G.vortex_time = G.TIMERS.REAL
            local temp_del = nil

            for i = 1, 300 do
                temp_del = temp_del or 3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blockable = false,
                    delay = temp_del,
                    func = (function()
                    local card, card_pos = make_splash_card({scale = 2 - i/300})
                    local speed = math.max(2. - i*0.005, 0.001)
                    ease_value(card.T, 'scale', -card.T.scale, nil, nil, nil, 1.*speed)
                    ease_value(card.T, 'x', -card_pos.x, nil, nil, nil, 0.9*speed)
                    ease_value(card.T, 'y', -card_pos.y, nil, nil, nil, 0.9*speed)
                    local temp_pitch = i*0.007 + 0.6
                    local temp_i = i
                    G.E_MANAGER:add_event(Event({
                        blockable = false,
                        func = (function()
                            if card.T.scale <= 0 then
                                if temp_i < 30 then 
                                    play_sound('whoosh1', temp_pitch + math.random()*0.05, 0.25*(1 - temp_i/50))
                                end

                                if temp_i == 15 then
                                    play_sound('whoosh_long',0.9, 0.7)
                                end
                                G.VIBRATION = G.VIBRATION + 0.1
                                card:remove()
                                return true
                            end
                        end)}))
                        return true
                    end)}))
                    temp_del = temp_del + math.max(1/(i), math.max(0.2*(170-i)/500, 0.016))
            end

            --when faded to white, spit out the 'Fool's' cards and slowly have them settle in to place
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = (function()
                G.SPLASH_BACK:remove()
                G.SPLASH_BACK = G.SPLASH_FRONT
                G.SPLASH_FRONT = nil
                G:main_menu('splash')
            return true;end)}))
        return true
    end)
    }))
end







-- challenge

function G.UIDEF.challenges(from_game_over)

    G.inchallenge = false

  if G.PROFILES[G.SETTINGS.profile].all_unlocked then G.PROFILES[G.SETTINGS.profile].challenges_unlocked = #G.CHALLENGES end

  if not G.PROFILES[G.SETTINGS.profile].challenges_unlocked then
    local deck_wins = 0
    for k, v in pairs(G.PROFILES[G.SETTINGS.profile].deck_usage) do
      if v.wins and v.wins[1] then
        deck_wins = deck_wins + 1
      end
    end
    local loc_nodes = {}
    localize{type = 'descriptions', key = 'challenge_locked', set = 'Other', nodes = loc_nodes, vars = {G.CHALLENGE_WINS, deck_wins}, default_col = G.C.WHITE}

    return {n=G.UIT.ROOT, config={align = "cm", padding = 0.1, colour = G.C.CLEAR, minh = 8.02, minw = 7}, nodes={
      transparent_multiline_text(loc_nodes)
    }}
  end

  G.run_setup_seed = nil
  if G.OVERLAY_MENU then 
    local seed_toggle = G.OVERLAY_MENU:get_UIE_by_ID('run_setup_seed')
    if seed_toggle then seed_toggle.states.visible = false end
  end

  
  local _ch_comp, _ch_tot = 0,#G.CHALLENGES
  for k, v in ipairs(G.CHALLENGES) do
    if v.id and G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[v.id or ''] then
      _ch_comp = _ch_comp + 1
    end
  end

  local _ch_tab = {comp = _ch_comp, unlocked = G.PROFILES[G.SETTINGS.profile].challenges_unlocked}

  return {n=G.UIT.ROOT, config={align = "cm", padding = 0.1, colour = G.C.CLEAR, minh = 8, minw = 7}, nodes={
    {n=G.UIT.R, config={align = "cm", padding = 0.1, r = 0.1 ,colour = G.C.BLACK}, nodes={
      {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
        {n=G.UIT.T, config={text = localize('k_challenge_mode'), scale = 0.4, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
      }},
      {n=G.UIT.R, config={align = "cm", minw = 8.5, minh = 1.5, padding = 0.2}, nodes={
        UIBox_button({id = from_game_over and 'from_game_over' or nil, label = {localize('b_new_challenge')}, button = 'challenge_list', minw = 4, scale = 0.4, minh = 0.6}),
      }},
      {n=G.UIT.R, config={align = "cm", minh = 0.8, r = 0.1, minw = 4.5, colour = G.C.L_BLACK, emboss = 0.05,
      progress_bar = {
        max = _ch_tot, ref_table = _ch_tab, ref_value = 'unlocked', empty_col = G.C.L_BLACK, filled_col = G.C.FILTER
      }}, nodes={
        {n=G.UIT.C, config={align = "cm", padding = 0.05, r = 0.1, minw = 4.5}, nodes={
          {n=G.UIT.T, config={text = localize{type = 'variable', key = 'unlocked', vars = {_ch_tab.unlocked, _ch_tot}}, scale = 0.3, colour = G.C.WHITE, shadow =true}},
        }},
      }},
      {n=G.UIT.R, config={align = "cm", minh = 0.8, r = 0.1, minw = 4.5, colour = G.C.L_BLACK, emboss = 0.05,
      progress_bar = {
        max = _ch_tot, ref_table = _ch_tab, ref_value = 'comp', empty_col = G.C.L_BLACK, filled_col = adjust_alpha(G.C.GREEN, 0.5)
      }}, nodes={
        {n=G.UIT.C, config={align = "cm", padding = 0.05, r = 0.1, minw = 4.5}, nodes={
          {n=G.UIT.T, config={text = localize{type = 'variable', key = 'completed', vars = {_ch_comp, _ch_tot}}, scale = 0.3, colour = G.C.WHITE, shadow = true}},
        }},
      }},
    }},
    G.F_DAILIES and {n=G.UIT.R, config={align = "cm", padding = 0.1, r = 0.1 ,colour = G.C.BLACK}, nodes={
      {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
        {n=G.UIT.T, config={text = localize('k_daily_run'), scale = 0.4, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
      }},
      {n=G.UIT.R, config={align = "cl", minw = 8.5, minh = 4}, nodes={
        G.UIDEF.daily_overview()
      }}
    }} or nil,
  }}
end

function G.UIDEF.challenge_list(from_game_over)
    G.inchallenge = true
  G.CHALLENGE_PAGE_SIZE = 10
  local challenge_pages = {}
  for i = 1, math.ceil(#G.CHALLENGES/G.CHALLENGE_PAGE_SIZE) do
    table.insert(challenge_pages, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#G.CHALLENGES/G.CHALLENGE_PAGE_SIZE)))
  end
  G.E_MANAGER:add_event(Event({func = (function()
    G.FUNCS.change_challenge_list_page{cycle_config = {current_option = 1}}
  return true end)}))

  local _ch_comp, _ch_tot = 0,#G.CHALLENGES
  for k, v in ipairs(G.CHALLENGES) do
    if v.id and G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[v.id or ''] then
      _ch_comp = _ch_comp + 1
    end
  end

  local t = create_UIBox_generic_options({ back_id = from_game_over and 'from_game_over' or nil, back_func = 'setup_run', back_id = 'challenge_list', contents = {
    {n=G.UIT.C, config={align = "cm", padding = 0.0}, nodes={
      {n=G.UIT.R, config={align = "cm", padding = 0.1, minh = 7, minw = 4.2}, nodes={
        {n=G.UIT.O, config={id = 'challenge_list', object = Moveable()}},
      }},
      {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
        create_option_cycle({id = 'challenge_page',scale = 1, h = 1, w = 3.5, options = challenge_pages, cycle_shoulders = true, opt_callback = 'change_challenge_list_page', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true}})
      }},
      {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
        {n=G.UIT.T, config={text = localize{type = 'variable', key = 'challenges_completed', vars = {_ch_comp, _ch_tot}}, scale = 0.4, colour = G.C.WHITE}},
      }},

    }},
    {n=G.UIT.C, config={align = "cm", minh = 9, minw = 11.5}, nodes={
      {n=G.UIT.O, config={id = 'challenge_area', object = Moveable()}},
    }},
  }})
  return t
end


-- move to patch when done
function G.UIDEF.challenge_list_page(_page)
  local snapped = false
  local challenge_list = {}
  for k, v in ipairs(G.CHALLENGES) do
    if k > G.CHALLENGE_PAGE_SIZE*(_page or 0) and k <= G.CHALLENGE_PAGE_SIZE*((_page or 0) + 1) then
      if G.CONTROLLER.focused.target and G.CONTROLLER.focused.target.config.id == 'challenge_page' then snapped = true end
      local challenge_completed = G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[v.id or '']
      local challenge_golden = G.PROFILES[G.SETTINGS.profile].challenge_progress.completed_golden[v.id or '']
      local challenge_extra = G.PROFILES[G.SETTINGS.profile].challenge_progress.completed_earl[v.id or '']
      local challenge_unlocked = G.PROFILES[G.SETTINGS.profile].challenges_unlocked and (G.PROFILES[G.SETTINGS.profile].challenges_unlocked >= k)

      local extra = nil
      if v.extrarules then
        extra = {n=G.UIT.C, config={minh = 0.4, minw = 0.4, emboss = 0, r = 0, colour = challenge_extra and G.C.EARL or G.C.BLACK, tooltip = { title = "Extra Completion", text = {"Complete earl's extra challenge"}} }, nodes = {
            challenge_extra and {n=G.UIT.O, config={object = Sprite(0,0,0.4,0.4, G.ASSET_ATLAS["icons"], {x=1, y=0})}} or nil
        }}
      end

      challenge_list[#challenge_list+1] = 
      {n=G.UIT.R, config={align = "cl"}, nodes={
        {n=G.UIT.C, config={align = 'cl', minw = 0.8}, nodes = {
          {n=G.UIT.T, config={text = k..'', scale = 0.4, colour = G.C.WHITE}},
        }},
        UIBox_button({id = k, col = true, emboss = 0, hover = true, label = {challenge_unlocked and localize(v.id, 'challenge_names') or localize('k_locked'),}, button = challenge_unlocked and 'change_challenge_description' or 'nil', colour = challenge_unlocked and G.C.EARL or G.C.GREY, minw = 4, scale = 0.4, minh = 0.6, focus_args = {snap_to = not snapped}}),
        {n=G.UIT.C, config={align = 'cl', padding = 0.05, minw = 0.6}, nodes = {
          {n=G.UIT.C, config={minh = 0.4, minw = 0.4, emboss = 0, r = 0, colour = challenge_completed and G.C.GREEN or G.C.BLACK, tooltip = { title = "Normal Completion", text = {"Complete the challenge normally"} }}, nodes = {
            challenge_completed and {n=G.UIT.O, config={object = Sprite(0,0,0.4,0.4, G.ASSET_ATLAS["icons"], {x=1, y=0})}} or nil
          }},
          {n=G.UIT.C, config={minh = 0.4, minw = 0.4, emboss = 0, r = 0, colour = challenge_golden and G.C.MONEY or G.C.BLACK, tooltip = { title = "Golden Completion", text = {"Complete the challenge with Gold Stake"} }}, nodes = {
            challenge_golden and {n=G.UIT.O, config={object = Sprite(0,0,0.4,0.4, G.ASSET_ATLAS["icons"], {x=1, y=0})}} or nil
          }},
          extra
        }},
      }}      
      snapped = true
    end
  end

  return {n=G.UIT.ROOT, config={align = "cm", padding = 0.1, colour = G.C.CLEAR}, nodes=challenge_list}
end

function G.UIDEF.challenge_description(_id, daily, is_row)
  local challenge = G.CHALLENGES[_id]

  G.CHALLENGEREF = challenge
  if not challenge then return {n=G.UIT.CLEAR, config={align = "cm", colour = G.C.CLEAR, minh = 8.82, minw = 11.5, r = 0.1}, nodes={{n=G.UIT.T, config={text = localize('ph_select_challenge'), scale = 0.3, colour = G.C.UI.TEXT_LIGHT}}}} end

  local joker_size = 0.6
  local jokers = CardArea(0,0,
      10*joker_size,
      0.6*G.CARD_H, 
      {card_limit = get_challenge_rule(challenge, 'modifiers', 'joker_limit') or 5,
      card_w = joker_size*G.CARD_W, type = 'title_2', highlight_limit = 0})
    
  if challenge.jokers  then 
    for k, v in ipairs(challenge.jokers) do
      local card = Card(0,0, G.CARD_W*joker_size, G.CARD_H*joker_size, nil, G.P_CENTERS[v.id], {bypass_discovery_center = true,bypass_discovery_ui = true, bypass_lock=true})
      if v.edition then card:set_edition({[v.edition] = true}, true, true) end
      if v.eternal then card:set_eternal(true) end
      if v.pinned then card.pinned = true end
      jokers:emplace(card)
    end
  end

  local joker_col = {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.L_BLACK, r = 0.1, maxh = 1.8}, nodes={
    {n=G.UIT.T, config={text = localize('k_jokers_cap'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT, vert = true, shadow = true}},
    {n=G.UIT.C, config={align = "cm", minh = 0.6*G.CARD_H, minw = 5, r = 0.1, colour = G.C.UI.TRANSPARENT_DARK}, nodes={
      jokers and {n=G.UIT.O, config={object = jokers}} or {n=G.UIT.T, config={text = localize('k_none'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT}}
    }}
  }}

  local consumeables = CardArea(0,0,
    3*joker_size,
    0.6*G.CARD_H, 
    {card_limit = get_challenge_rule(challenge, 'modifiers', 'consumable_limit') or 2,
    card_w = joker_size*G.CARD_W, type = 'title_2', spread = true, highlight_limit = 0})

  if challenge.consumeables then 
  for k, v in ipairs(challenge.consumeables) do
    local card = Card(0,0, G.CARD_W*joker_size, G.CARD_H*joker_size, nil, G.P_CENTERS[v.id], {bypass_discovery_center = true,bypass_discovery_ui = true, bypass_lock=true})
    if v.edition then card:set_edition({[v.edition] = true}, true, true) end
    if v.eternal then card:set_eternal(true) end
    consumeables:emplace(card)
  end
  end

  local consumable_col = {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.L_BLACK, r = 0.1, maxh = 1.8}, nodes={
    {n=G.UIT.T, config={text = localize('k_cap_consumables'), scale = 0.3, colour = G.C.UI.TEXT_LIGHT, vert = true, shadow = true}},
    {n=G.UIT.C, config={align = "cm", minh = 0.6*G.CARD_H, r = 0.1, colour = G.C.UI.TRANSPARENT_DARK}, nodes={
      consumeables and {n=G.UIT.O, config={object = consumeables}} or {n=G.UIT.T, config={text = localize('k_none'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT}},
    }}
  }}

  local vouchers = CardArea(0,0,
    3*joker_size,
    0.6*G.CARD_H, 
    {card_limit = nil,
    card_w = joker_size*G.CARD_W, type = 'title_2', spread = true, highlight_limit = 0})

  if challenge.vouchers then 
  for k, v in ipairs(challenge.vouchers) do
    local card = Card(0,0, G.CARD_W*joker_size, G.CARD_H*joker_size, nil, G.P_CENTERS[v.id], {bypass_discovery_center = true,bypass_discovery_ui = true, bypass_lock=true})
    if v.edition then card:set_edition({[v.edition] = true}, true, true) end
    if v.eternal then card:set_eternal(true) end
    vouchers:emplace(card)
  end
  end

  local voucher_col = {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.L_BLACK, r = 0.1, maxh = 1.8}, nodes={
    {n=G.UIT.T, config={text = localize('k_vouchers_cap'), scale = 0.33, colour = G.C.UI.TEXT_LIGHT, vert = true, shadow = true}},
    {n=G.UIT.C, config={align = "cm", minh = 0.6*G.CARD_H, r = 0.1, colour = G.C.UI.TRANSPARENT_DARK}, nodes={
      vouchers and {n=G.UIT.O, config={object = vouchers}} or {n=G.UIT.T, config={text = localize('k_none'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT}},
    }}
  }}

    

    local extrabutton = nil
    if challenge.extrarules and challenge.extrarules ~= false then
        local SC_scale = 0.3
        SC = Card(999 - SC_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC_scale*G.CARD_H/2, SC_scale*G.CARD_W, SC_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS['j_yogi_earl'])
        SC.T.y = G.ROOM.T.h/2 - SC_scale*G.CARD_H/2
        SC.ambient_tilt = 1
        SC.states.drag.can = false
        SC.states.hover.can = false
        SC.no_ui = true
        extrabutton = {n=G.UIT.C, config={align = "cm", padding = 0.1, minh = 0.7, minw = 3, r = 0.1, hover = true, colour = G.C.EARL, button = "start_challenge_run_extra", shadow = true, id = _id, tooltip = {title = "EARL'S EXTRA MODE", text = challenge.extrarules}}, nodes={
            {n=G.UIT.T, config={text = "PLAY EXTRA", scale = 0.5, colour = G.C.UI.TEXT_LIGHT,func = 'set_button_pip', focus_args = {button = 'x',set_button_pip = true}}},
            {n=G.UIT.O, config={object = SC}}
        }}
    end

    local extralabel = nil
    if challenge.extrarules then
        local SC_scale = 0.3
        SC = Card(999 - SC_scale*G.CARD_W/2, 10. + G.ROOM.T.h/2 - SC_scale*G.CARD_H/2, SC_scale*G.CARD_W, SC_scale*G.CARD_H, G.P_CARDS.empty, G.P_CENTERS['j_yogi_earl'])
        SC.T.y = G.ROOM.T.h/2 - SC_scale*G.CARD_H/2
        SC.ambient_tilt = 1
        SC.states.drag.can = false
        SC.states.hover.can = false
        SC.no_ui = true
        extralabel = {n=G.UIT.C, config={align = "cm", padding = 0.1, minh = 0.7, minw = 0.2, r = 1, hover = true, colour = G.C.EARL, shadow = true, id = _id, tooltip = {title = "EARL'S EXTRA MODE", text = challenge.extrarules}}, nodes={
            
            {n=G.UIT.O, config={object = SC}}
        }}
    end

  

  return {n=is_row and G.UIT.R or G.UIT.ROOT, config={align = "cm", r = 0.1, colour = G.C.BLACK}, nodes={
    {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
      joker_col, consumable_col, voucher_col
    }},
    {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
      create_tabs(
        {tabs = {
            {
                label = localize('b_rules'),
                chosen = true,
                tab_definition_function = G.UIDEF.challenge_description_tab,
                tab_definition_function_args = {_id = _id, _tab = 'Rules'}
            },
            {
                label = localize('b_deck'),
                tab_definition_function = G.UIDEF.challenge_description_tab,
                tab_definition_function_args = {_id = _id, _tab = 'Deck'}
            }
        },
        tab_h = 5,
        padding = 0,
        text_scale = 0.36,
        scale = 1,
        no_shoulders = true,
        no_loop = true}
    ),
    }},

    is_row and {n=G.UIT.R, config={align = "cm", minh = 0.9}, nodes={
        extralabel
    }} or nil,

    {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
      {n=G.UIT.T, config={text = "View Banned Items in Run Info", scale = 0.4, colour = G.C.UI.TEXT_LIGHT,func = 'set_button_pip', focus_args = {button = 'x',set_button_pip = true}}}
    }},
    not is_row and {n=G.UIT.R, config={align = "cm", minh = 0.9}, nodes={
      {n=G.UIT.C, config={align = "cm", padding = 0.1, minh = 0.7, minw = 3, r = 0.1, colour = G.C.BLUE, button = "start_challenge_run", shadow = true, id = _id}, nodes={
        {n=G.UIT.T, config={text = localize('b_play_cap'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT,func = 'set_button_pip', focus_args = {button = 'x',set_button_pip = true}}}
      }},
      {n=G.UIT.C, config={align = "cm", padding = 0.1, minh = 0.7, minw = 3, r = 0.1, colour = G.C.MONEY, button = "start_challenge_run_gold", shadow = true, id = _id}, nodes={
        {n=G.UIT.T, config={text = "GOLD STAKE PLAY", scale = 0.5, colour = G.C.UI.TEXT_LIGHT,func = 'set_button_pip', focus_args = {button = 'x',set_button_pip = true}}}
      }},
      extrabutton or nil
    }} or nil,
  }}
end

G.FUNCS.start_challenge_run = function(e)
  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.FUNCS.start_run(e, {stake = 1, challenge = G.CHALLENGES[e.config.id]})
  G.YOGIHARDMODE = true
  G.inchallenge = false
end

G.FUNCS.start_challenge_run_gold = function(e)
  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.FUNCS.start_run(e, {stake = 8, challenge = G.CHALLENGES[e.config.id]})
  G.YOGIHARDMODE = true
  G.inchallenge = false
end

G.FUNCS.start_challenge_run_extra = function(e)
  if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
  G.FUNCS.start_run(e, {stake = 1, challenge = G.CHALLENGES[e.config.id]})
  G.YOGICHALLENGEMODE = true
  G.inchallenge = false
end

-- extra completion checks
G.EXTRACHECK = {}
for k, v in ipairs(G.CHALLENGES) do
    if v.extrarules then
        table.insert(G.EXTRACHECK, v.original_key)
    end
end