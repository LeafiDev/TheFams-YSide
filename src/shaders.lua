-- Custom Shaders for yg mod

SMODS.Shader {
    key = "gold",
    path = "gold.fs",
    send_vars = function(self, sprite, card)
        return {
            gold = {0, G.TIMERS.REAL or 0}
        }
    end
}
