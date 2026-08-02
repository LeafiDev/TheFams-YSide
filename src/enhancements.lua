SMODS.Atlas {
    key = "boost",
    path = "boost.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "blonk",
    path = "blonk.png",
    px = 71,
    py = 95
}



SMODS.Enhancement{
    key = "boost",
    loc_txt = {
        name = "Bloost",
        text = {
            "{C:chips}+15%{} chips",
            "{s:0.5}15% of the blind requirement{}"
        },
    },
    atlas = "boost",
    pos = { x = 0, y = 0 },
    config = {
        
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    apply = function(self, card)
        
    end,
    remove = function(self, card)
        
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {chips = G.GAME.blind.chips * 0.15}
        end
    end,
}

SMODS.Enhancement{
    key = "blonk",
    loc_txt = {
        name = "Borf License",
        text = {
            "A license from the State Of Barklas",
            "{C:purple,E:1}+0.25{} reputation",
            "{X:mult,C:white}X0.25{} for each reputation point",
            "Currently {X:mult,C:white}X#1#{}"
        },
    },
    atlas = "blonk",
    pos = { x = 0, y = 0 },
    config = {
        
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { ((G.GAME.reputation or 1) * 0.25) + 1 } }
    end,
    apply = function(self, card)
        
    end,
    remove = function(self, card)
        
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            G.GAME.reputation = (G.GAME.reputation or 0) + 0.25
            if G.GAME.reputation < 1 then
                final = 1 * 0.25
            else
                final = G.GAME.reputation * 0.25
            end

            return {xmult = final, message = "+0.25", colour = G.C.PURPLE}
        end
    end,
}