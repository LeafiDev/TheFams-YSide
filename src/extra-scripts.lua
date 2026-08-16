function ExtraScriptActivate()

    if G.GAME.YOGICHALLENGEMODE then
        local currentChallenge = G.GAME.challenge
        
        if currentChallenge == "c_yogi_first" then
            G.GAME.modifiers.bigmoney = 1000

            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.5 * G.SPEEDFACTOR,
                func = function()
                    ease_ante(1);
                    return true
                end
            }))
        end

        if currentChallenge == "c_yogi_2" then
            G.GAME.modifiers.cardlimit = 18
        end

        if currentChallenge == "c_yogi_krab" then
            G.jokers.config.card_limits.base = 4
        end

        if currentChallenge == "c_yogi_scale" and G.GAME.YOGICHALLENGEMODE == true then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.5 * G.SPEEDFACTOR,
                func = function()
                    G.GAME.starting_params.ante_scaling = 2.4
                    G.GAME.modifiers.lowest_score_increases = 1200
                    return true
                end
            }))
        end

        if currentChallenge == "c_yogi_ASP" and G.GAME.YOGICHALLENGEMODE == true then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.5 * G.SPEEDFACTOR,
                func = function()
                    G.GAME.modifiers.rep_required = 40
                    G.GAME.win_ante = 9
                    return true
                end
            }))
        end

        if currentChallenge == "c_yogi_places" then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.5 * G.SPEEDFACTOR,
                func = function()
                    G.GAME.modifiers.lowest_score = 100
                    G.GAME.modifiers.lowest_score_increases = 150
                    return true
                end
            }))
        end
    end

end