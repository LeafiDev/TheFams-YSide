--[[
SMODS.Achievement{
    key = "compat",
    loc_txt = {
        name = "Two Bones To Pick",
        description = {
            'Load YOGI-SIDE with THE FAMS'
        }
    },
    atlas = "modicon",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    unlock_condition = function(self, args)
        return fams_loaded
    end,
}
]]
-- DO NOT LOAD BASE FAMS

SMODS.Achievement{
    key = "QBD-1",
    loc_txt = {
        name = "Money Trader",
        description = {
            'Get to ante 10 using the Quick Buck Deck'
        }
    },
    atlas = "modicon",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    unlock_condition = function(self, args)
        return (get_current_profile().BSScore or 0) >= 10
    end,
}

SMODS.Achievement{
    key = "QBD-2",
    loc_txt = {
        name = "Big Deal!",
        description = {
            'Get to ante 15 using the Quick Buck Deck'
        }
    },
    atlas = "modicon",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    unlock_condition = function(self, args)
        return (get_current_profile().BSScore or 0) >= 15
    end,
}

SMODS.Achievement{
    key = "QBD-3",
    loc_txt = {
        name = "BIG MONEY, I LOVE IT!",
        description = {
            'Get to ante 25 using the Quick Buck Deck'
        }
    },
    atlas = "modicon",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    unlock_condition = function(self, args)
        return (get_current_profile().BSScore or 0) >= 25
    end,
}

SMODS.Achievement{
    key = "QBD-4",
    loc_txt = {
        name = "Money Hoarder",
        description = {
            'Get to ante 50 using the Quick Buck Deck'
        }
    },
    atlas = "modicon",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    unlock_condition = function(self, args)
        return (get_current_profile().BSScore or 0) >= 50
    end,
}

SMODS.Achievement{
    key = "KRAB-25",

    loc_txt = {
        name = "And there's money in 'eeeeere",
        description = {
            "Have 25 Kraby Patties at once"
        }
    },

    atlas = "modicon",
    pos = { x = 0, y = 0 },
    hidden_text = true,

    unlock_condition = function(self, args)
        if not G.jokers or not G.jokers.cards then
            return false
        end

        local krabs = 0

        for _, joker in ipairs(G.jokers.cards) do
            if joker.config and joker.config.center_key == "j_yogi_krab" then
                krabs = krabs + 1
            end
        end

        return krabs >= 25
    end,
}

G.gotmiau = false
SMODS.Achievement{
    key = "catscare",

    loc_txt = {
        name = "Ack! My ears!",
        description = {
            "Get jumpscared by Miau"
        }
    },

    atlas = "modicon",
    pos = { x = 0, y = 0 },
    hidden_text = true,

    unlock_condition = function(self, args)

        return G.gotmiau == true
    end,
}

SMODS.Achievement{
    key = "cube",

    loc_txt = {
        name = "A dimension upward",
        description = {
            "Find 'Earl Cubed'"
        }
    },

    atlas = "modicon",
    pos = { x = 0, y = 0 },
    hidden_text = true,

    unlock_condition = function(self, args)
        if not G.jokers or not G.jokers.cards then
            return false
        end

        local krabs = 0

        for _, joker in ipairs(G.jokers.cards) do
            if joker.config and joker.config.center_key == "j_yogi_earl3d" then
                krabs = krabs + 1
            end
        end

        return krabs >= 1
    end,
}

SMODS.Achievement{
    key = "ohshit",

    loc_txt = {
        name = "Power of chocolate labs",
        description = {
            "Complete Last Goodbye's extra mode"
        }
    },

    atlas = "modicon",
    pos = { x = 0, y = 0 },
    hidden_text = true,

    unlock_condition = function(self, args)
        return isChallenge("onemore") and G.YOGICHALLENGEMODE == true and G.GAME.worrn == true
    end,
}


SMODS.Achievement{
    key = "ending",
    loc_txt = {
        name = "A Nice Hike",
        description = {
            'Complete "Last Goodbye".'
        }
    },
    atlas = "modicon",
    pos = { x = 0, y = 0 },
    hidden_text = true,
    unlock_condition = function(self, args)
        return isChallenge("onemore") and G.GAME.round_resets.ante > 10
    end,
}