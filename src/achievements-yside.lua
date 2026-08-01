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
        return get_current_profile().BSScore >= 10
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
        return get_current_profile().BSScore >= 15
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
        return get_current_profile().BSScore >= 25
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
        return get_current_profile().BSScore >= 50
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