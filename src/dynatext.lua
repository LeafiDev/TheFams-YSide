SMODS.DynaTextEffect {
    key = "wheel",
    func = function (self, index, letter)
        letter.offset.x = math.sin(G.TIMERS.REAL * 6 + (index / 5)) * 15
        letter.offset.y = math.cos(G.TIMERS.REAL * 6 + (index / 5)) * 15
    end
}

SMODS.DynaTextEffect {
    key = "shake",
    func = function (self, index, letter)
        letter.offset.x = math.random(-5,5)
        letter.offset.y = math.random(-5,5)
    end
}

SMODS.DynaTextEffect {
    key = "spook",
    func = function (self, index, letter)
        letter.offset.y = math.sin(G.TIMERS.REAL * 25 + (index)) * 15
    end
}

SMODS.DynaTextEffect {
    key = "upside_down",
    func = function (self, index, letter)
        letter.r = 180
    end
}