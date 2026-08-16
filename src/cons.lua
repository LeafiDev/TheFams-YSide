SMODS.ConsumableType{
    key = "armor",
    primary_colour = {1, 0.498, 0.153, 1},
    secondary_colour = {1, 0.498, 0.153, 1},
    loc_txt = {
        name = "ARMOR",
        collection = "ARMOR",
        undiscovered = {
            name = "???",
            text = {"This ARMOR has not been discovered yet."},
        },
    },
    collection_rows = {5},
    shop_rate = 0.4,
}

SMODS.ConsumableType{
    key = "armor",
    primary_colour = {1, 0.498, 0.153, 1},
    secondary_colour = {1, 0.498, 0.153, 1},
    loc_txt = {
        name = "ARMOR",
        collection = "ARMOR",
        undiscovered = {
            name = "???",
            text = {"This ARMOR has not been discovered yet."},
        },
    },
    collection_rows = {5},
    shop_rate = 0.4,
}

SMODS.ConsumableType{
    key = "charm",
    primary_colour = {0.667, 0.153, 1, 1},
    secondary_colour = {0.667, 0.153, 1, 1},
    loc_txt = {
        name = "CHARM",
        collection = "CHARM",
        undiscovered = {
            name = "???",
            text = {"This CHARM has not been discovered yet."},
        },
    },
    collection_rows = {5},
    shop_rate = 0.4,
}

SMODS.Atlas {
    key = "timeup",
    path = "timeup.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "testarmor",
    path = "testarmor.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "noarmor",
    path = "noarmor.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "nocharm",
    path = "nocharm.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "tradmaker",
    path = "tradmaker.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "catcharm",
    path = "catcharm.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "confuser",
    path = "confuser.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "charmboost1",
    path = "charmboost1.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "boosttarot",
    path = "boosttarot.png",
    px = 71,
    py = 95
}


SMODS.Consumable {
    key = "boosttarot",
    set = "Tarot",
    loc_txt = {
        name = "Mountain",
        text = {"Applies {C:chips,E:1}Bloost{} to 5 cards"}
    },
    atlas = "boosttarot",
    pos = { x = 0, y = 0 },
    cost = 3,
	use = function(self, card)
        for _, card in ipairs(G.hand.cards) do
            if card.highlighted then
                card:set_ability("m_yogi_boost")
            end
        end
    end,
	can_use = function(self, card)
    return amountselected() <= 5 and amountselected() ~= 0
end
}

SMODS.Consumable {
    key = "boosttarot2",
    set = "Spectral",
    loc_txt = {
        name = "NOT Mountain",
        text = {"Applies {C:chips,E:1}Bloost{} to 5 cards"}
    },
    atlas = "boosttarot",
    pos = { x = 0, y = 0 },
    cost = 3,
	use = function(self, card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                G.target = SMODS.add_card({ set = 'Joker', legendary = true})
                check_for_unlock { type = 'spawn_legendary' }
                play_sound('yogi_sfx_cardappear', 1, 1)
                return true
            end
        }))

        local wobble = 5000
        local side = 1

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0,
            func = function()

                if side == 1 then
                    side = -1
                else
                    side = 1
                end

                G.target.CT.x = (wobble * side) + 8.75

                

                wobble = wobble + ((0 - wobble ) / 9)
                return wobble < 1
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0,
            func = function()
                play_sound("yogi_mus_sfx_a_grab", 1, 1)
                return true;
            end
        }))
    end,
	can_use = function(self, card)
    return true
end
}



-- armors

SMODS.Consumable {
    key = "empty",
    set = "armor",
    loc_txt = {
        name = "",
        text = {"{C:inactive}Your Armor slot is empty...{}"}
    },
    atlas = "noarmor",
    config = { extra = { stats = {atk = 0, def = 0, agl = 0} } },
    pos = { x = 0, y = 0 },
    cost = 0,
    no_collection = true,
    calculate = function(self, card, context)
        
    end,

    use = function(self, card)
        
    end,

    update = function(self, card, front)
        
    end,

	can_use = function(self, card)
    return true
    end,

    in_pool = function(self, args)
        return false
    end
}

SMODS.Consumable {
    key = "emptycharm",
    set = "charm",
    loc_txt = {
        name = "",
        text = {"{C:inactive}Your Charm slot is empty...{}"}
    },
    atlas = "nocharm",
    config = { extra = { stats = {atk = 0, def = 0, agl = 0} } },
    pos = { x = 0, y = 0 },
    cost = 0,
    no_collection = true,
    calculate = function(self, card, context)
        
    end,

    use = function(self, card)
        
    end,

    update = function(self, card, front)
        
    end,

	can_use = function(self, card)
    return true
    end,

    in_pool = function(self, args)
        return false
    end
}

-- armors

SMODS.Consumable {
    key = "trad",
    set = "armor",
    loc_txt = {
        name = "TradMaker",
        text = {"While Equipped", "when a hand is played you will gain back 1 discard"}
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = { G.GAME.ante_save or G.GAME.round_resets.ante or 1 } }
    end,
    atlas = "tradmaker",
    config = { extra = { stats = {atk = 0, def = 0, agl = 0} } },
    pos = { x = 0, y = 0 },
    cost = 15,
    calculate = function(self, card, context)
        
    end,

    use = function(self, card)
        G.GAME.ARMOR = "trad"
        G.GAME.ARMOR_NAME = card.label
    end,

    update = function(self, card, front)
        
        
    end,

	can_use = function(self, card)
    return true
    end
}

SMODS.Consumable {
    key = "trad",
    set = "armor",
    loc_txt = {
        name = "LifeStabil",
        text = {"While Equipped", "When you reach your last hand if discards are more than 1", "swap hands and discards"}
    },
    loc_vars = function(self, info_queue, card)

        local returner = nil
        if G.GAME.current_round.discards_left > 1 then
            returner = "gain" 
        end
        
        return { vars = {  } }
    end,
    atlas = "tradmaker",
    config = { extra = { stats = {atk = 0, def = 0, agl = 0} } },
    pos = { x = 0, y = 0 },
    cost = 8,
    calculate = function(self, card, context)
        
    end,

    use = function(self, card)
        G.GAME.ARMOR = "stabil"
        G.GAME.ARMOR_NAME = card.label
    end,

    update = function(self, card, front)
        
        
    end,

	can_use = function(self, card)
    return true
    end
}

-- charms

SMODS.Consumable {
    key = "cat",
    set = "charm",
    loc_txt = {
        name = "Meowry",
        text = {"While Equipped", "you will hear meowing {E:yogi_shake}sometimes{}"}
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = { G.GAME.ante_save or G.GAME.round_resets.ante or 1 } }
    end,
    atlas = "catcharm",
    config = { extra = { stats = {atk = 0, def = 0, agl = 0} } },
    pos = { x = 0, y = 0 },
    cost = 1,
    calculate = function(self, card, context)
        
    end,

    use = function(self, card)
        G.GAME.CHARM = "cat"
        G.GAME.CHARM_NAME = card.label
    end,

    update = function(self, card, front)
        
        
    end,

	can_use = function(self, card)
    return true
    end
}

SMODS.Consumable {
    key = "confuser",
    set = "charm",
    loc_txt = {
        name = "Confusion",
        text = {"While Equipped", "after the first hand all jokers will be {E:yogi_wheel}flipped and shuffled{}", "gain {C:chips}+3 hands{}"}
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = { G.GAME.ante_save or G.GAME.round_resets.ante or 1 } }
    end,
    atlas = "confuser",
    config = { extra = { stats = {atk = 0, def = 0, agl = 0} } },
    pos = { x = 0, y = 0 },
    cost = 1,
    calculate = function(self, card, context)
        
    end,

    use = function(self, card)
        G.GAME.CHARM = "confuser"
        G.GAME.CHARM_NAME = card.label
    end,

    update = function(self, card, front)
        
        
    end,

	can_use = function(self, card)
    return true
    end
}

SMODS.Consumable {
    key = "wafer1",
    set = "charm",
    loc_txt = {
        name = "WaferCard",
        text = {"While Equipped", "On Blind Start, Increase chip gain on all {E:1}deck cards{} by {C:chips}+15{}"}
    },
    loc_vars = function(self, info_queue, card)
        
        return { vars = { G.GAME.ante_save or G.GAME.round_resets.ante or 1 } }
    end,
    atlas = "charmboost1",
    config = { extra = { stats = {atk = 0, def = 0, agl = 0} } },
    pos = { x = 0, y = 0 },
    cost = 1,
    calculate = function(self, card, context)
        
    end,

    use = function(self, card)
        G.GAME.CHARM = "boost1"
        G.GAME.CHARM_NAME = card.label
    end,

    update = function(self, card, front)
        
        
    end,

	can_use = function(self, card)
    return true
    end
}