SMODS.Atlas {
	key = "stake",
	path = "stake.png",
	px = 29,
	py = 29
}

SMODS.Stake {
	key = 'shiverstake',
	prefix_config = {
	applied_stakes = false
    },
	applied_stakes = {
        "stake_white",
        "stake_red",
        "stake_green",
        "stake_black",
        "stake_blue",
        "stake_purple",
        "stake_orange",
        "stake_gold",
		"stake_fams_walmert",
		"stake_fams_poor",
		"stake_fams_fuckyou",
		"stake_fams_clankers",
		"stake_fams_egg",
		"stake_fams_half",
		"stake_fams_theft",
		"stake_fams_copyright",
		"stake_fams_taxes",
		"stake_fams_lock",
    },
	loc_txt = {
		name = 'Shiver Stake',
		text = {
			'Begins a 600 seconds timer (x0.5)',
			"{C:red,E:yogi_shake}You are not allowed to pause{}"
		},
		sticker = {
			name = 'Shiver Stake Winner',
			text = {'Win a run with the Shiver Stake active.'}
		}
	},
	atlas = 'stake',
	pos = { x = 0, y = 0 },
	sticker_pos = { x = 0, y = 0 },
	unlocked = true,
	colour = {1, 1, 1, 1}, 
	above_stake = "stake_fams_lock",
	modifiers = function(self)
		
	end
}

SMODS.Stake {
	key = 'evilstake',
	prefix_config = {
	applied_stakes = false
    },
	applied_stakes = {
        "stake_white",
        "stake_red",
        "stake_green",
        "stake_black",
        "stake_blue",
        "stake_purple",
        "stake_orange",
        "stake_gold",
		"stake_fams_walmert",
		"stake_fams_poor",
		"stake_fams_fuckyou",
		"stake_fams_clankers",
		"stake_fams_egg",
		"stake_fams_half",
		"stake_fams_theft",
		"stake_fams_copyright",
		"stake_fams_taxes",
		"stake_fams_lock",
		"stake_yogi_shiver"
    },
	loc_txt = {
		name = 'Evil Stake',
		text = {
			"+5 ante",
		},
		sticker = {
			name = 'Evil Stake Winner',
			text = {'Win a run with the Evil Stake active.'}
		}
	},
	atlas = 'stake',
	pos = { x = 1, y = 0 },
	sticker_pos = { x = 0, y = 0 },
	unlocked = true,
	colour = {1, 0, 0, 1}, 
	above_stake = "stake_yogi_shiver",
	modifiers = function(self)
		G.GAME.win_ante = G.GAME.win_ante + 5
	end
}

SMODS.Stake {
	key = 'crownstake',
	prefix_config = {
	applied_stakes = false
    },
	applied_stakes = {
        "stake_white",
        "stake_red",
        "stake_green",
        "stake_black",
        "stake_blue",
        "stake_purple",
        "stake_orange",
        "stake_gold",
		"stake_fams_walmert",
		"stake_fams_poor",
		"stake_fams_fuckyou",
		"stake_fams_clankers",
		"stake_fams_egg",
		"stake_fams_half",
		"stake_fams_theft",
		"stake_fams_copyright",
		"stake_fams_taxes",
		"stake_fams_lock",
		"stake_yogi_shiver",
		"stake_yogi_evil"
    },
	loc_txt = {
		name = 'Crown Stake',
		text = {
			"Reduces existing timer down to 475 seconds (x1.0)",
			"Increases ante scaling by 1.3x",
			"Inflation set to 30",
			"{C:money}The last stake{}",
		},
		sticker = {
			name = 'Crown Stake Winner',
			text = {'Win a run with the Crown Stake active.'}
		}
	},
	atlas = 'stake',
	pos = { x = 2, y = 0 },
	sticker_pos = { x = 0, y = 0 },
	unlocked = true,
	colour = {1, 1, 0, 1}, 
	above_stake = "stake_yogi_evil",
	modifiers = function(self)
		G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling + 1.3
		G.GAME.inflation = 30
	end
}