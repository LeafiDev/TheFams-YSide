function G.UIDEF.challenge_description_tab(args)
  args = args or {}
  if args._tab == 'Rules' then
    local challenge = G.CHALLENGES[args._id]
    local start_rules = {}
    local modded_starts = nil
    local game_rules = {}
    local starting_params = get_starting_params()
    local base_modifiers = {
      dollars = {value = starting_params.dollars, order = 6},
      discards = {value = starting_params.discards, order = 2},
      hands = {value = starting_params.hands, order = 1},
      reroll_cost = {value = starting_params.reroll_cost, order = 7},
      joker_slots = {value = starting_params.joker_slots, order = 4},
      consumable_slots = {value = starting_params.consumable_slots, order = 5},
      hand_size = {value = starting_params.hand_size, order = 3},
  }
  local bonus_mods = 100
  if challenge.rules then
    if challenge.rules.modifiers then
      for k, v in ipairs(challenge.rules.modifiers) do
        base_modifiers[v.id] = {value = v.value, order = base_modifiers[v.id] and base_modifiers[v.id].order or bonus_mods, custom = true, old_val = base_modifiers[v.id].value}
        bonus_mods = bonus_mods + 1
      end
    end
  end
  local nu_base_modifiers = {}
  for k, v in pairs(base_modifiers) do
    v.key = k
    nu_base_modifiers[#nu_base_modifiers+1] = v
  end
  table.sort(nu_base_modifiers, function(a,b) return a.order < b.order end)
  for k, v in ipairs(nu_base_modifiers) do
    if v.old_val then
      modded_starts = modded_starts or {}
      modded_starts[#modded_starts+1] = {n=G.UIT.R, config={align = "cl", maxw = 3.5}, nodes= localize{type = 'text', key = 'ch_m_'..v.key, vars = {v.value}, default_col = G.C.L_BLACK}}
    
    else
      start_rules[#start_rules+1] = {n=G.UIT.R, config={align = "cl", maxw =3.5}, nodes= localize{type = 'text', key = 'ch_m_'..v.key, vars = {v.value}, default_col = not v.custom and G.C.UI.TEXT_INACTIVE or nil}}
    end
  end

  if modded_starts then
    start_rules = {
      modded_starts and {n=G.UIT.R, config={align = "cl", padding = 0.05}, nodes=modded_starts} or nil,
      {n=G.UIT.R, config={align = "cl", padding = 0.05, colour = G.C.GREY}, nodes={}},
      {n=G.UIT.R, config={align = "cl", padding = 0.05}, nodes=start_rules},
    }
  end

    if challenge.rules then
      if challenge.rules.custom then
        for k, v in ipairs(challenge.rules.custom) do
          game_rules[#game_rules+1] = {n=G.UIT.R, config={align = "cl"}, nodes= localize{type = 'text', key = 'ch_c_'..v.id, vars = {v.value}}}
        end  
      end
    end
    if (not start_rules[1]) and (not modded_starts) then  start_rules[#start_rules+1] = {n=G.UIT.R, config={align = "cl"}, nodes= localize{type = 'text', key = 'ch_m_none', vars = {}}} end
    if not game_rules[1] then  game_rules[#game_rules+1] = {n=G.UIT.R, config={align = "cl"}, nodes= localize{type = 'text', key = 'ch_c_none', vars = {}}} end

    local starting_rule_list = {n=G.UIT.C, config={align = "cm", minw = 3, r = 0.1, colour = G.C.BLUE}, nodes={
      {n=G.UIT.R, config={align = "cm", padding = 0.08, minh = 0.6}, nodes={
        {n=G.UIT.T, config={text = localize('k_game_modifiers'), scale = 0.4, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
      }},
      {n=G.UIT.R, config={align = "cm", minh = 4.1, minw = 4.2, padding = 0.05, r = 0.1, colour = G.C.WHITE}, nodes= start_rules}
    }}

    local override_rule_list = {n=G.UIT.C, config={align = "cm", minw = 3, r = 0.1, colour = G.C.BLUE}, nodes={
      {n=G.UIT.R, config={align = "cm", padding = 0.08, minh = 0.6}, nodes={
        {n=G.UIT.T, config={text = localize('k_custom_rules'), scale = 0.4, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
      }},
      {n=G.UIT.R, config={align = "cm", minh = 4.1, minw = 6.8, maxw = 6.7, padding = 0.05, r = 0.1, colour = G.C.WHITE}, nodes= game_rules}
    }}

    return {n=G.UIT.ROOT, config={align = "cm", padding = 0.05, colour = G.C.CLEAR}, nodes={
      {n=G.UIT.C, config={align = "cm", padding = 0.1, colour = G.C.L_BLACK, r = 0.1, minw = 3}, nodes={
        override_rule_list,starting_rule_list
      }}
    }}
  elseif args._tab == 'Restrictions' then
    local challenge = G.CHALLENGES[args._id]

    local banned_cards, banned_tags, banned_other = {}, {}, {}

    if challenge.restrictions then
      if challenge.restrictions.banned_cards then
        local row_cards = {}
        local n_rows = math.max(1, math.floor(#challenge.restrictions.banned_cards/10) + 2 - math.floor(math.log(6, #challenge.restrictions.banned_cards)))
        local max_width = 1
        for k, v in ipairs(challenge.restrictions.banned_cards) do
          local _row = math.floor((k-1)*n_rows/(#challenge.restrictions.banned_cards)+1)
          row_cards[_row] = row_cards[_row] or {}
          row_cards[_row][#row_cards[_row]+1] = v
          if #row_cards[_row] > max_width then max_width = #row_cards[_row] end
        end

        local card_size = math.max(0.3, 0.75 - 0.01*(max_width*n_rows))

        for _, row_card in ipairs(row_cards) do
          local banned_card_area = CardArea(
            0,0,
            6.7,
            3.3/n_rows,
            {card_limit = nil, type = 'title_2', view_deck = true, highlight_limit = 0, card_w = G.CARD_W*card_size})
          table.insert(banned_cards, 
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.O, config={object = banned_card_area}}
          }}
          )
          for k, v in ipairs(row_card) do
            local card = Card(0,0, G.CARD_W*card_size, G.CARD_H*card_size, nil, G.P_CENTERS[v.id], {bypass_discovery_center = true,bypass_discovery_ui = true})
            banned_card_area:emplace(card)
          end
        end
      end
      if challenge.restrictions.banned_tags then
        local tag_tab = {}
        for k, v in pairs(challenge.restrictions.banned_tags) do
          tag_tab[#tag_tab+1] = G.P_TAGS[v.id]
        end
      
        table.sort(tag_tab, function (a, b) return a.order < b.order end)

        for k, v in ipairs(tag_tab) do
          local temp_tag = Tag(v.key)
          local temp_tag_ui = temp_tag:generate_UI(1.1 - 0.25*(math.sqrt(#challenge.restrictions.banned_tags)))
          table.insert(banned_tags, 
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            temp_tag_ui
          }}
          )
        end
      end
      if challenge.restrictions.banned_other then
        local other_tab = {}
        for k, v in pairs(challenge.restrictions.banned_other) do
          if v.type == 'blind' then
            other_tab[#other_tab+1] = G.P_BLINDS[v.id]
          end
        end
      
        table.sort(other_tab, function (a, b) return a.order < b.order end)

        for k, v in ipairs(other_tab) do
          local temp_blind = AnimatedSprite(0,0,1,1, G.ANIMATION_ATLAS['blind_chips'], v.pos)
          temp_blind:define_draw_steps({
            {shader = 'dissolve', shadow_height = 0.05},
            {shader = 'dissolve'}
          })
          temp_blind.float = true
          temp_blind.states.hover.can = true
          temp_blind.states.drag.can = false
          temp_blind.states.collide.can = true
          temp_blind.config = {blind = v, force_focus = true}
          temp_blind.hover = function()
            if not G.CONTROLLER.dragging.target or G.CONTROLLER.using_touch then 
                if not temp_blind.hovering and temp_blind.states.visible then
                  temp_blind.hovering = true
                  temp_blind.hover_tilt = 3
                  temp_blind:juice_up(0.05, 0.02)
                  play_sound('chips1', math.random()*0.1 + 0.55, 0.12)
                  temp_blind.config.h_popup = create_UIBox_blind_popup(v, true)
                  temp_blind.config.h_popup_config ={align = 'cl', offset = {x=-0.1,y=0},parent = temp_blind}
                  Node.hover(temp_blind)
                end
            end
          end
          temp_blind.stop_hover = function() temp_blind.hovering = false; Node.stop_hover(temp_blind); temp_blind.hover_tilt = 0 end

          table.insert(banned_other, 
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.O, config={object = temp_blind}}
          }}
          )
        end
      end
    end
    if not banned_cards[1] then  banned_cards[#banned_cards+1] = {n=G.UIT.R, config={align = "cl"}, nodes= localize{type = 'text', key = 'ch_m_none', vars = {}}} end
    if not banned_tags[1] then  banned_tags[#banned_tags+1] = {n=G.UIT.R, config={align = "cl"}, nodes= localize{type = 'text', key = 'ch_c_none', vars = {}}} end
    if not banned_other[1] then  banned_other[#banned_other+1] = {n=G.UIT.R, config={align = "cl"}, nodes= localize{type = 'text', key = 'ch_c_none', vars = {}}} end

    local banned_cards = {n=G.UIT.C, config={align = "cm", r = 0.1, colour = G.C.RED}, nodes={
      {n=G.UIT.R, config={align = "cm", padding = 0.08, minh = 0.6}, nodes={
        {n=G.UIT.T, config={text = localize('k_banned_cards'), scale = 0.4, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
      }},
      {n=G.UIT.R, config={align = "cm", minh = 4.1, minw =7.33, padding = 0.05, r = 0.1, colour = G.C.WHITE}, nodes= 
        banned_cards
      }
    }}

    local banned_tags = {n=G.UIT.C, config={align = "cm", r = 0.1, colour = G.C.RED}, nodes={
      {n=G.UIT.R, config={align = "cm", padding = 0.08, minh = 0.6, maxw = 1.48}, nodes={
        {n=G.UIT.T, config={text =  localize('k_banned_tags'), scale = 0.3, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
      }},
      {n=G.UIT.R, config={align = "cm", minh = 4.1, minw = 1.48, padding = 0.05, r = 0.1, colour = G.C.WHITE}, nodes= 
      banned_tags}
    }}

    local banned_other = {n=G.UIT.C, config={align = "cm", r = 0.1, colour = G.C.RED}, nodes={
      {n=G.UIT.R, config={align = "cm", padding = 0.08, minh = 0.6, maxw = 1.84}, nodes={
        {n=G.UIT.T, config={text = localize('k_other'), scale = 0.4, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
      }},
      {n=G.UIT.R, config={align = "cm", minh = 4.1, minw = 2, padding = 0.05, r = 0.1, colour = G.C.WHITE}, nodes= 
      banned_other}
    }}

    return {n=G.UIT.ROOT, config={align = "cm", padding = 0.05, colour = G.C.CLEAR}, nodes={
      {n=G.UIT.C, config={align = "cm", padding = 0.1, colour = G.C.L_BLACK, r = 0.1}, nodes={
        banned_cards, banned_tags, banned_other
      }}
    }}
  elseif args._tab == 'Deck' then
    local challenge = G.CHALLENGES[args._id]
    local deck_tables = {}
    local SUITS = {
      S = {},
      H = {},
      C = {},
      D = {},
    }
    local suit_map = {'S', 'H', 'C', 'D'}
    local card_protos = nil
    local _de = nil
    if challenge then
        _de = challenge.deck
    end

    if _de and _de.cards then
        card_protos = _de.cards
    end

    if not card_protos then 
        card_protos = {}
        for k, v in pairs(G.P_CARDS) do
            local _r, _s = string.sub(k, 3, 3), string.sub(k, 1, 1)
            local keep, _e, _d, _g = true, nil, nil, nil
            if _de then
                if _de.yes_ranks and not _de.yes_ranks[_r] then keep = false end
                if _de.no_ranks and _de.no_ranks[_r] then keep = false end
                if _de.yes_suits and not _de.yes_suits[_s] then keep = false end
                if _de.no_suits and _de.no_suits[_s] then keep = false end
                if _de.enhancement then _e = _de.enhancement end
                if _de.edition then _d = _de.edition end
                if _de.seal then _g = _de.seal end
            end
            
            if keep then card_protos[#card_protos+1] = {s=_s,r=_r,e=_e,d=_d,g=_g} end
        end
    end 
    for k, v in ipairs(card_protos) do
      local _card = Card(0,0, G.CARD_W*0.45, G.CARD_H*0.45, G.P_CARDS[v.s..'_'..v.r], G.P_CENTERS[v.e or 'c_base'])
      if v.d then _card:set_edition({[v.d] = true}, true, true) end
      if v.g then _card:set_seal(v.g, true, true) end
      SUITS[v.s][#SUITS[v.s]+1] = _card
    end

  for j = 1, 4 do
    if SUITS[suit_map[j]][1] then
      table.sort(SUITS[suit_map[j]], function(a,b) return a:get_nominal() > b:get_nominal() end )
      local view_deck = CardArea(
        0,0,
        5.5*G.CARD_W,
        0.42*G.CARD_H,
        {card_limit = #SUITS[suit_map[j]], type = 'title_2', view_deck = true, highlight_limit = 0, card_w = G.CARD_W*0.5, draw_layers = {'card'}})
      table.insert(deck_tables, 
      {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
        {n=G.UIT.O, config={object = view_deck}}
      }}
      )

      for i = 1, #SUITS[suit_map[j]] do
        if SUITS[suit_map[j]][i] then
          view_deck:emplace(SUITS[suit_map[j]][i])
        end
      end
    end
  end
    return {n=G.UIT.ROOT, config={align = "cm", padding = 0, colour = G.C.BLACK, r = 0.1, minw = 11.4, minh = 4.2}, nodes=deck_tables}
  end
end