

SMODS.Atlas {
    key = "speedback",
    path = "speedback.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "deal",
    path = "deal.png",
    px = 71,
    py = 95
}

SMODS.Back {
    key = "QB",
    loc_txt = {
        name = "Quick Buck Deck",
        text = {
            "Start with {C:purple,E:1,T:v_crystal_ball}60 seconds{}",
            "Every boss blind defeated adds {C:attention}35 seconds{}",
            "Every boss blind defeated increases speed by {C:red}+0.05{}",
            "pausing {C:red}ends{} the run {C:red}(and discards your time){}",
            "High Score: {C:money}#1#{}",
            "Seed: #2#"
        }
    },
    loc_vars = function()
        return { vars = { (get_current_profile().BSScore or "No Ante Score"), (get_current_profile().BSSeed or "No Seed") } }
    end,
    atlas = "speedback",
    pos = {x = 0, y = 0},
    apply = function(self, back)
    G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function()
                G.GAME.win_ante = 8
                make_timer("speed", 60, function()
                if (get_current_profile().BSScore or 1) < G.GAME.round_resets.ante then
                    get_current_profile().BSScore = G.GAME.round_resets.ante
                    get_current_profile().BSSeed = G.GAME.pseudorandom.seed
                end

                ForceLoss()

                return true
            end, true, 1)
                set_deathwish_timer("speed")
                return true
            end
        }))
end
}

SMODS.Back {
    key = "SD",
    loc_txt = {
        name = "Special Deal Deck",
        text = {
            "start with {C:money}$10{}",
            "start with {C:purple,E:1}10 Reputation{}"
        }
    },
    loc_vars = function()
        return { vars = {  } }
    end,
    atlas = "deal",
    pos = {x = 0, y = 0},
    apply = function(self, back)
    G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function()
                G.GAME.dollars = 10
                G.GAME.reputation = 10
                return true
            end
        }))
end
}

SMODS.Back {
    key = "SD",
    loc_txt = {
        name = "Special Deal Deck",
        text = {
            "start with {C:money}$10{}",
            "start with {C:purple,E:1}10 Reputation{}"
        }
    },
    loc_vars = function()
        return { vars = {  } }
    end,
    atlas = "deal",
    pos = {x = 0, y = 0},
    apply = function(self, back)
    G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function()
                G.GAME.dollars = 10
                G.GAME.reputation = 10
                return true
            end
        }))
end
}