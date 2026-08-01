
SMODS.Atlas {
    key = "DD",
    path = "DD.png",
    px = 32,
    py = 32
}

SMODS.Tag {
    key = "reptomoney",
    loc_txt = {
        name = "Dirty Dealings",
        text = {
            "Exchange all of your {C:purple}Reputation{}",
            "for {C:money}Money{}",
            "{C:inactive}Currently #1#${}"
        }
    },
    atlas = "DD", -- or your custom atlas
    pos = { x = 0, y = 0 },
    config = {},
    discovered = false,
    min_ante = 1,
    loc_vars = function()
        return { vars = { G.GAME.reputation } }
    end,

    set_ability = function(self, tag)
        
    end,
    
    in_pool = function(self, args)
        return true -- Always allow
    end,

    apply = function(self, tag, context)
        tag:yep(">", G.C.MONEY, function()
            G.GAME.dollars = G.GAME.dollars + (G.GAME.reputation or 0)
            G.GAME.reputation = 0
            return true
        end)
        tag.triggered = true
    end
}