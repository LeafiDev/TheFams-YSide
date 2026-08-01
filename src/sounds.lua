SMODS.Sound {
  key = "music_main",
  pitch = 1,
  path = "music_main.ogg",
  select_music_track = function(self)
	return 5
  end
}

SMODS.Sound {
  key = "music_buster",
  pitch = 1,
  path = "music_buster.ogg",
  select_music_track = function(self)
    if G and G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_yogi_graze" then
      return 25
    end
  end
}

SMODS.Sound {
  key = "music_dogwar",
  pitch = 1,
  path = "music_dogwar.ogg",
  select_music_track = function(self)
    if has_modifier("earlboss") then
      return 55
    end
  end
}

SMODS.Sound {
  key = "music_luigi",
  pitch = 1,
  path = "music_luigi.ogg",
  select_music_track = function(self)
    if G and G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_yogi_luigi" then
      G.BPM = 184
      return 155
    end
  end
}

SMODS.Sound {
  key = "music_krab",
  pitch = 1,
  path = "music_krab.ogg",
  select_music_track = function(self)
    if isChallenge("krab") then
      G.BPM = 104
      return 125
    end
  end
}

SMODS.Sound {
  key = "music_boo",
  pitch = 1,
  path = "music_boo.ogg",
  select_music_track = function(self)
    if isChallenge("krab") and G.STATE == 4 then
      G.PITCH_MOD = 1
      return 999
    end
  end
}

SMODS.Sound {
  key = "music_sixty",
  pitch = 1,
  path = "music_sixty.ogg",
  select_music_track = function(self)
    if G.niceloop == true then
      if G.TIMER_TRACK and G.TIMER_TRACK.seconds < 10 and not run_lost() then
        G.PITCH_MOD = 1 + (10 - G.TIMER_TRACK.seconds) / 25
      end
      G.BPM = 141
      return 999
    end
  end
}

SMODS.Sound {
  key = "music_meeting",
  pitch = 1,
  path = "music_meeting.ogg",
  select_music_track = function(self)
    if isChallenge("borf") then
      return 400
    end
  end
}

SMODS.Sound {
  key = "music_omega",
  pitch = 1,
  path = "music_omega.ogg",
  select_music_track = function(self)
    if isChallenge("onemore") then
      G.BPM = 161
      return 9999
    end
  end
}

SMODS.Sound {
  key = "music_winner",
  pitch = 1,
  path = "music_winner.ogg",
  select_music_track = function(self)
    if (isChallenge("onemore") and G.GAME.round_resets.ante > 10) then
      G.BPM = 161
      return 10000
    end
  end
}

SMODS.Sound {
  key = "music_flipmania",
  pitch = 1,
  path = "music_flipmania.ogg",
  select_music_track = function(self)
    if (isChallenge("flipmania")) then
      G.BPM = 77
      return 5000
    end
  end
}

SMODS.Sound {
  key = "music_focus",
  pitch = 0.4,
  path = "music_focus.ogg",
  select_music_track = function(self)
    if (isChallenge("focus")) then

    end
  end
}

SMODS.Sound {
  key = "music_story",
  pitch = 0.9,
  path = "music_story.ogg",
  select_music_track = function(self)
    if (isChallenge("magic")) then
      return 988888
    end
  end
}

SMODS.Sound {
  key = "music_sun",
  pitch = 0.8,
  path = "music_sun.ogg",
  select_music_track = function(self)
    if (isChallenge("sun")) then
      return 9999
    end
  end
}

SMODS.Sound {
  key = "japhit",
  pitch = 1,
  volume = 1,
  path = "snd_japhit.ogg"
}

SMODS.Sound {
  key = "weaponpull",
  pitch = 1,
  volume = 1,
  path = "snd_weaponpull_fast.ogg"
}

SMODS.Sound {
  key = "coin",
  pitch = 1,
  volume = 1,
  path = "snd_coin.ogg"
}

SMODS.Sound {
  key = "angry",
  pitch = 1,
  volume = 1,
  path = "snd_angry.ogg"
}

SMODS.Sound {
  key = "miau",
  pitch = 1,
  volume = 1,
  path = "miau.ogg"
}

SMODS.Sound {
  key = "damage",
  pitch = 1,
  volume = 1,
  path = "snd_damage.ogg"
}

SMODS.Sound {
  key = "petaldrain",
  pitch = 1,
  volume = 1,
  path = "snd_petaldrain.ogg"
}

SMODS.Sound {
  key = "won",
  pitch = 1,
  volume = 1,
  path = "snd_won.ogg"
}

SMODS.Sound {
  key = "graze",
  pitch = 1,
  volume = 1,
  path = "snd_graze.ogg"
}

SMODS.Sound {
  key = "snd_noise",
  pitch = 1,
  volume = 1,
  path = "snd_noise.ogg"
}

SMODS.Sound {
  key = "hurt",
  pitch = 1,
  volume = 1,
  path = "snd_hurt1.ogg"
}

SMODS.Sound {
  key = "munch",
  pitch = 1,
  volume = 1,
  path = "munch.ogg"
}

SMODS.Sound {
  key = "no",
  pitch = 1,
  volume = 1,
  path = "snd_cantselect.ogg"
}

SMODS.Sound {
  key = "bowomp",
  pitch = 1,
  volume = 1,
  path = "bowomp.ogg"
}

SMODS.Sound {
  key = "break",
  pitch = 1,
  volume = 1,
  path = "snd_break2.ogg"
}

SMODS.Sound {
  key = "cash",
  pitch = 1,
  volume = 1,
  path = "snd_cash.ogg"
}

SMODS.Sound {
  key = "stardrop",
  pitch = 1,
  volume = 1,
  path = "snd_stardrop.ogg"
}

SMODS.Sound {
  key = "snd_item",
  pitch = 1,
  volume = 1,
  path = "snd_item.ogg"
}

SMODS.Sound {
  key = "bark",
  pitch = 1,
  volume = 1,
  path = "snd_bark.ogg"
}

SMODS.Sound {
  key = "meow",
  pitch = 1,
  volume = 1,
  path = "snd_meow.ogg"
}

SMODS.Sound {
  key = "snd_lastboost",
  pitch = 1,
  volume = 1,
  path = "snd_lastboost.ogg"
}

SMODS.Sound {
  key = "snd_bigdefeat",
  pitch = 1,
  volume = 1,
  path = "snd_bigdefeat.ogg"
}

SMODS.Sound {
  key = "sfx_cardappear",
  pitch = 1,
  volume = 1,
  path = "sfx_cardappear.ogg"
}

SMODS.Sound {
  key = "mus_sfx_a_grab",
  pitch = 1,
  volume = 1,
  path = "mus_sfx_a_grab.ogg"
}


-- rhythm needed

SMODS.Sound {
  key = "tingpart1",
  pitch = 1,
  volume = 1,
  path = "tingpart1.ogg"
}

SMODS.Sound {
  key = "tingpart2",
  pitch = 1,
  volume = 1,
  path = "tingpart2.ogg"
}