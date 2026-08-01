SMODS.Atlas {
    key = "dangerous",
    path = "dangerous.png",
    px = 71,
    py = 95
}


SMODS.Sticker{
    key = "danger",
    loc_txt = {
        name = "Dodgy",
        text = {"According to dog investors, {C:red,E:yogi_shake}This product sucks!{}", "Each time it's triggered you will lose 3 reputation and 3$"},
        label = "Liability"
    },
    atlas = "dangerous",
    pos = {x = 0, y = 0},
    badge_colour = {1, 0, 0, 1},
    hide_badge = false,
    default_compat = true,
    compat_exceptions = {},
    sets = {Joker = true},
    rate = 0.0007,
    needs_enable_flag = false,
    calculate = function(self, card, context)
        if context.joker_main then
            G.GAME.reputation = G.GAME.reputation - 3
            return {dollars = -3}
        end
    end,
    should_apply = function(self, card, center, area, bypass_roll)
		if math.random(1, 100) > 90 and not G.GAME.challenge then
        return center.set == "Joker"
		end
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end,
}