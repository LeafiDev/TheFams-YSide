-- Custom Scoring Parameter example for yg mod

-- Simple bonus parameter that tracks a custom score modifier
SMODS.Scoring_Parameter {
    key = "yog_bonus",
    default_value = 0,
    colour = HEX("FFD700"),  -- Gold color
    calculation_keys = {"yog_bonus"},  -- Cards can return this key in their calculate function
    hands = {
        ["High Card"] = {y_yog_bonus = 0, l_y_yog_bonus = 0, s_y_yog_bonus = 0},
        ["Pair"] = {y_yog_bonus = 0, l_y_yog_bonus = 0, s_y_yog_bonus = 0},
        ["Two Pair"] = {y_yog_bonus = 0, l_y_yog_bonus = 0, s_y_yog_bonus = 0},
        ["Three of a Kind"] = {y_yog_bonus = 0, l_y_yog_bonus = 0, s_y_yog_bonus = 0},
        ["Straight"] = {y_yog_bonus = 0, l_y_yog_bonus = 0, s_y_yog_bonus = 0},
        ["Flush"] = {y_yog_bonus = 0, l_y_yog_bonus = 0, s_y_yog_bonus = 0},
        ["Full House"] = {y_yog_bonus = 0, l_y_yog_bonus = 0, s_y_yog_bonus = 0},
        ["Four of a Kind"] = {y_yog_bonus = 0, l_y_yog_bonus = 0, s_y_yog_bonus = 0},
        ["Straight Flush"] = {y_yog_bonus = 0, l_y_yog_bonus = 0, s_y_yog_bonus = 0},
        ["Five of a Kind"] = {y_yog_bonus = 0, l_y_yog_bonus = 0, s_y_yog_bonus = 0},
    }
}

-- Optional: Custom Scoring Calculation that uses addition instead of multiplication
SMODS.Scoring_Calculation {
key = "yog_add",
text = "+",
colour = G.C.MONEY,
    func = function(self, chips, mult, flames)
        return chips + mult
    end
}
