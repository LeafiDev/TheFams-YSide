-- Custom Editions for yg mod

SMODS.Edition {
    key = "Premium",
    shader = "gold",
    loc_txt = {
        name = "PREMIUM",
        label = "PREMIUM",
        text = {
            "Gives {X:money,C:white}$#1#{} {C:inactive,s:0.5}(Increases by 3 every hand it's played){}",
            "gives {C:red}Mult{} based on {C:purple}Reputation{}",
            "can {C:attention,E:yogi_wheel}always be played{} no matter the hand formation",
            "{C:inactive,s:0.6}Current Reputation: #2#{}"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.config.money or 12, G.GAME.reputation or 0 } }
    end,
    in_shop = true,
    weight = 1,
    extra_cost = 40,
    always_scores = true,
    config = { money = 12 },
    badge_colour = HEX("FFD700"),
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            card.config.money = (card.config.money or 12) + 3
            return {
                dollars = (card.config.money or 12),
                mult = G.GAME.reputation or 0,
                message = "+3"
            }
        end
    end
}
