SMODS.Atlas {
    key = "yogi",
    path = "yogi.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "5dollar",
    loc_txt = {
        name = "5$ Biggie Bag",
        text = {
            "When clicked, Destroys and {C:attention}stores your joker{} to the {C:attention}right{}",
            "While stored when clicked again will {C:attention}restore the joker{}.",
            "Currently Storing: #1#",
            "{C:inactive}Due to a bug if you leave a run the card will deload{}"
        }
    },
    loc_vars = function(self, info_queue, card)

        local uh = nil
        if card and card.ability and card.ability.extra and card.ability.extra.stored and card.ability.extra.stored ~= false then
            if  card.ability.extra.stored.config.center and card.ability.extra.stored.config.center.loc_txt and card.ability.extra.stored.config.center.loc_txt.name then
                uh = card.ability.extra.stored.config.center.loc_txt.name
            else
                uh = tostring(card.ability.extra.stored.label)
            end
        end

        return { vars = { (uh or "Nothing") } }
    end,
    blueprint_compat = true,
    eternal_compat = false,
    config = { extra = { stored = false } },
    cost = 5,
    unlocked = true,
    rarity = 3,
    atlas = "biggie",
    pos = { x = 0, y = 0 },
    
    calculate = function(self, card, context)
        
    end,

    add_to_deck = function(self, card, from_debuff)
    
    end
}
