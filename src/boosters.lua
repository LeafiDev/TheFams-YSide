G.C.CHARM = {0.667, 0.153, 1, 1}

SMODS.Atlas {
    key = "charmbooster",
    path = "charmbooster.png",
    px = 71,
    py = 95
}

SMODS.Booster {
    key = "charm",
    loc_txt = {
    name = "Charm Booster Packs",
    group_name = "Charm",
    text = { "Select {C:attention}1{} of {C:attention}3{}",
    "{C:charm}Charms{}" } 
	},
    atlas = "charmbooster", -- or your custom atlas key
    pos = { x = 0, y = 0 },
	draw_hand = true,
    cost = 6,
    weight = 0.5,
    config = { extra = 3, choose = 1 }, -- 3 cards, choose 1
	create_card = function(self, card, i)
        return { set = "charm", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "yogi" }
    end
}

G.C.ARMOR = {1, 0.498, 0.153, 1}

SMODS.Atlas {
    key = "armorbooster",
    path = "armorbooster.png",
    px = 71,
    py = 95
}

SMODS.Booster {
    key = "arms",
    loc_txt = {
    name = "Armor Booster Pack",
    group_name = "Armor",
    text = { "Select {C:attention}1{} of {C:attention}2{}",
    "{C:armor}Armors{}"} 
	},
    atlas = "armorbooster", -- or your custom atlas key
    pos = { x = 0, y = 0 },
	draw_hand = true,
    cost = 6,
    weight = 0.5,
    config = { extra = 2, choose = 1 }, -- 3 cards, choose 1
	create_card = function(self, card, i)
        return { set = "armor", area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "yogi" }
    end
}