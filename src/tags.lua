
SMODS.Atlas {
    key = "DD",
    path = "DD.png",
    px = 32,
    py = 32
}

SMODS.Tag {
    key = "reptomoney",
    loc_txt = {
        name = "Dirty Dealings",
        text = {
            "Exchange all of your {C:purple}Reputation{}",
            "for {C:money}Money{}",
            "{C:inactive}Currently #1#${}"
        }
    },
    atlas = "DD", -- or your custom atlas
    pos = { x = 0, y = 0 },
    config = {},
    discovered = false,
    min_ante = 1,
    loc_vars = function()
        return { vars = { G.GAME.reputation } }
    end,

    set_ability = function(self, tag)
        
    end,
    
    in_pool = function(self, args)
        return true -- Always allow
    end,

    apply = function(self, tag, context)
        tag:yep(">", G.C.MONEY, function()
            G.GAME.dollars = G.GAME.dollars + (G.GAME.reputation or 0)
            G.GAME.reputation = 0
            return true
        end)
        tag.triggered = true
    end
}


SMODS.Atlas {
    key = "T",
    path = "T.png",
    px = 32,
    py = 32
}

SMODS.Tag {
    key = "lazytext",

    loc_txt = {
        name = "The quick red fox jumped over the lazy dog",
        text = {
            "Gain +$ for each letter in the following word",
            "#1#"
        }
    },

    atlas = "T",
    pos = { x = 0, y = 0 },

    config = {
        vars = {
            word = "lorem"
        }
    },

    discovered = false,
    min_ante = 1,

    loc_vars = function(self, info_queue, tag)
        return {
            vars = {
                tag.config.vars.word
            }
        }
    end,

    set_ability = function(self, tag)
        local words_to_use = {
            "",
            "lorem",
            "ipsum",
            "TV",
            "bookworm",
            "fortnite",
            "shit yourself",
            "ruff",
            "tuff",
            "words of all time",
            "super awesome word that is super long and you're lucky as shit",
            "empty",
            "DAWG",
            "EARL",
            "YOGI",
            "BEAR",
            "TOBY RADIATION FOX",
            "BUTTER DOG, THE DOG WITH THE BUTTER",
            "REAL ESTATE",
            "BACKROOMS",
            "ROBLOX",
            "LAMP",
            "WALMART",
            "FLOWERY",
            "IT'S JOEVER",
            "IT'S OVER",
            "ARE YOU SURE?",
            "YAYA",
            "League of legends",
            "Peggle",
            "Peggle 2",
            "Ted",
            "Ted 2",
            "Spotify",
            "Soundcloud",
            "Geometry Dash",
            "Balatro",
            "Card",
            "Joker",
            "Consumables",
            "Vouchers",
            "Tags",
            "IGN",
            "BIG MONEY",
            "DOOM",
            "DOOM 2: HELL ON EARTH",
            "DOOM 3 (BAD)",
            "DOOM ETERNAL",
            "HYPOTHESIS",
            "GAST||",
            "Goner",
            "Love2D",
            "Gamemaker Studio",
            "Gamemaker Studio 2",
            "parameter",
            "sancturary",
            "crash",
            "THE FAMS",
            "Direction and Magnitude",
            "Insanity",
            "Scary",
            "OMG",
            "Short",
            "Tall",
            "Weeb",
            "Muse",
            "Archive",
            "Open",
            "Close",
            "Clopen",
            "SANS",
            "Layout",
            "Technically",
            "Array",
            "List",
            "Object",
            "Coke",
            "Pepsi",
            "Sprite",
            "Dr Pepper",
            "Gambling",
            "Jack Daniels",
            "DRIVING IN MY CAR, RIGHT AFTER A BEER",
            "Unsure",
            "Sure",
            "Poolrooms",
            "Game Theory",
            "Theorizing",
            "Hyper",
            "Death",
            "UNDERTALE",
            "PVZ",
            "Plants VS Zombies",
            "Nil's Fine Game",
            "Mining And Crafting",
            "Java",
            "Javascript",
            "Python",
            "Rust",
            "Lua"
        }

        tag.config.vars.word = words_to_use[math.random(1, #words_to_use)]
    end,

    in_pool = function(self, args)
        return true
    end,

    apply = function(self, tag, context)
        tag:yep("+", G.C.MONEY, function()
            G.GAME.dollars = G.GAME.dollars
                + string.len(tag.config.vars.word)

            return true
        end)

        tag.triggered = true
    end
}