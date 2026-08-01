SMODS.JimboQuip({
    key = 'yogi',
    extra = {
        center = 'j_yogi_coolyog',
        particle_colours = {
            G.C.GOLD,
            darken(G.C.RED, 0.5),
            lighten(G.C.GOLD, 0.5)
        },
        sound = 'yogi_bark'
    },
    filter = function(self, type)
        if not isChallenge("onemore") then
            if type == 'win' then
                self.extra.text_key = "yogi_winner"..tostring(math.random(1,3))
                return true, { weight = 999 }
            elseif type == 'loss' then
                self.extra.text_key = "yogi_loser"..tostring(math.random(1,3))
                return true, { weight = 999 }
            end
        else
                if type == 'loss' then
                self.extra.text_key = "yogi_lose"..tostring(math.random(1,6))
                return true, { weight = 999 }
            end
        end
    end
})