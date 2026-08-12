

function get_fams_joker(key)
  if fams_loaded then
    return tostring(key)
  else
    return 'j_yogi_fallback'
  end
end



SMODS.Challenge {
  key = 'first',
  loc_txt = {
	name = "Bite Of The Golden Ticket",
	text = {''}
  },
  jokers = {{id = 'j_yogi_coolyog', eternal = true}},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.MONEY,
  rules = {
	custom = {{id = 'bigmoney', value = 600}},
	modifiers = {
        
	}
  },
  restrictions = {
		banned_cards = {
      {id = get_fams_joker('j_fams_kitchgun')}
		},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = '2',
  loc_txt = {
	name = "Rate Limited",
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.CHIPS,
  rules = {
	custom = {{id = 'cardlimit', value = 24}},
	modifiers = {
        
	}
  },
  restrictions = {
		banned_cards = {
			{id = get_fams_joker('j_fams_kitchgun')}
		},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'krab',
  loc_txt = {
	name = "ORRRRRRRDER UP!",
	text = {''}
  },
  jokers = {{id = 'j_yogi_squidward', eternal = false}, {id = 'j_yogi_krabs', eternal = true}, {id = 'j_yogi_sponge', eternal = false}, {id = 'j_yogi_patrick', eternal = false}},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.MONEY,
  rules = {
	custom = {{id = 'discard_cost', value = 5}},
	modifiers = {
    {id = "dollars", value = 10},
    {id = "joker_slots", value = 9}
	}
  },
  restrictions = {
		banned_cards = {
			
		},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'borf',
  loc_txt = {
	name = "Borf Meeting",
	text = {''}
  },
  jokers = {{id = 'j_yogi_gentledog', eternal = true}, {id = 'j_yogi_gentledog', eternal = true}, {id = 'j_yogi_gentledog', eternal = true}},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.BLACK,
  rules = {
	custom = {},
	modifiers = {
    {id = "joker_slots", value = 4}
	}
  },
  restrictions = {
		banned_cards = {
			{id = get_fams_joker('j_fams_kitchgun')}
		},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'TIM',
  loc_txt = {
	name = "Time Is Money",
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.MONEY,
  rules = {
	custom = {{id = 'moneydecay', value = -0.1}},
	modifiers = {
        
	}
  },
  restrictions = {
		banned_cards = {
      {id = get_fams_joker('j_fams_kitchgun')}
		},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'flipmania',
  loc_txt = {
	name = "Spin it to win it!",
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.GREEN,
  rules = {
	custom = {{id = "roulette"}, {id = "roulette2"}, {id = "roulette3"}},
	modifiers = {
    
	}
  },
  restrictions = {
		banned_cards = {
		},
	banned_tags = {},
	banned_other = {{id = "bl_final_heart", type = "blind"}, {id = "bl_final_leaf", type = "blind"}, {id = "bl_final_acorn", type = "blind"},
  {id = "bl_club", type = "blind"}, {id = "bl_goad", type = "blind"}, {id = "bl_plant", type = "blind"}, 
  {id = "bl_window", type = "blind"}, {id = "bl_pillar", type = "blind"}, {id = "bl_head", type = "blind"}}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'magic',
  loc_txt = {
	name = "Did you get a haircut?",
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.BLUE,
  rules = {
	custom = {{id = "magic"}, {id = "ante_up", value = 4}},
	modifiers = {
    
	}
  },
  restrictions = {
		banned_cards = {
		},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'M',
  loc_txt = {
	name = "Marathon",
	text = {''}
  },
  jokers = {{id = "j_yogi_walk", eternal = true},{id = "j_yogi_walk", eternal = true},{id = "j_yogi_walk", eternal = true},{id = "j_yogi_walk", eternal = true},{id = "j_yogi_walk", eternal = true}},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.GREEN,
  rules = {
	custom = {},
	modifiers = {
        
	}
  },
  restrictions = {
		banned_cards = {
		},
	banned_tags = {},
	banned_other = {{id = 'c_ectoplasm'}}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'ASP',
  loc_txt = {
	name = "All Star Payout",
	text = {''}
  },
  jokers = {{id = "j_yogi_coolyog"}, {id = "j_yogi_earl"}},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.PURPLE,
  rules = {
	custom = {{id = "rep_required", value = 20}, {id = "set_rep", value = 5}, {id = "ante_up", value = 10}},
	modifiers = {
        
	}
  },
  restrictions = {
		banned_cards = {
		},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'places',
  loc_txt = {
	name = "The Places We Were",
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.BLUE,
  rules = {
	custom = {{id = "scorelimit", value = 9999}},
	modifiers = {
    {id = "hands", value = 8},
	}
  },
  restrictions = {
		banned_cards = {
      {id = "j_yogi_coolyog"}
		},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = '10',
  loc_txt = {
	name = "1/10ths Social Distancing",
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.YELLOW,
  rules = {
	custom = {},
	modifiers = {
    
	}
  },
  restrictions = {
		banned_cards = {
		},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'sun',
  loc_txt = {
	name = "Acquire Canine(s)",
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.ORANGE,
  rules = {
	custom = {},
	modifiers = {
    
	}
  },
  restrictions = {
		banned_cards = {
		},
	banned_tags = {},
	banned_other = {}
  },
  consumeables = {},
  vouchers = {}
}

SMODS.Challenge {
  key = 'onemore',
  loc_txt = {
	name = "Last Goodbye",
	text = {''}
  },
  jokers = {},
  deck = {
	type = 'Challenge Deck'
  },
  button_colour = G.C.MONEY,
  rules = {
	custom = {{id = "last"}, {id = "last2"}, {id = "last3"}, {id = "last4"}},
	modifiers = {
    {id = "hands", value = 3}
	}
  },
  restrictions = {
		banned_cards = {
			{id = get_fams_joker('j_fams_kitchgun')}
		},
	banned_tags = {},
	banned_other = {{id = "bl_final_vessel", type = "blind"}, {id = "bl_final_heart", type = "blind"}, {id = "bl_final_bell", type = "blind"}, {id = "bl_final_leaf", type = "blind"}, {id = "bl_final_acorn", type = "blind"}}
  },
  consumeables = {},
  vouchers = {}
}