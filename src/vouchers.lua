
SMODS.Atlas {
    key = "grazeup1",
    path = "grazeup1.png",
    px = 71,
    py = 95
}

SMODS.Voucher {
    key = "grazeup1",
    loc_txt = {
        name = "Working Harder, Not Hardly Working",
        text = {
            "graze chip amount increases from 1.5% to 3.5%",
            "Decreases invulnerability frames from 12 to 9",
            "{C:inactive}Frame invincibility decreases by 0.1 every frame{}"
        }
    },
    atlas = "grazeup1", 
    pos = {x = 0, y = 0},
    cost = 6,

    add_to_deck = function(self, card, from_debuff)
        G.GAME.grazevoucher1 = 0.025
    end,
	calculate = function(self, card, context)
		
	end,
}

SMODS.Atlas {
    key = "grazeup2",
    path = "grazeup2.png",
    px = 71,
    py = 95
}

SMODS.Voucher {
    key = "grazeup2",
    loc_txt = {
        name = "Chip Hungarian",
        text = {
            "graze chip amount increases further by 5%",
            "Decreases invulnerability frames from 9 to 3",
            "{C:inactive}Frame invincibility decreases by 0.1 every frame{}"
        }
    },
    atlas = "grazeup2", 
    pos = {x = 0, y = 0},
    cost = 15,
    requires = {"v_yogi_grazeup1"},

    add_to_deck = function(self, card, from_debuff)
        G.GAME.grazevoucher2 = 0.05
    end,
	calculate = function(self, card, context)
		
	end,
}

SMODS.Atlas {
    key = "L_expand",
    path = "L_expand.png",
    px = 71,
    py = 95
}

SMODS.Voucher {
    key = "L_expand",
    loc_txt = {
        name = "Mansion's Worst Hider",
        text = {
            "Makes Luigi more obvious to see"
        }
    },
    atlas = "L_expand", 
    pos = {x = 0, y = 0},
    cost = 7,

    add_to_deck = function(self, card, from_debuff)
        G.GAME.luigieasy1 = 4
    end,
}