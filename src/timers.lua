G.MOD_TIMERS = {}
G.TIMER_TRACK = "not found :("

function make_timer(id,seconds,onend,paused,scalar)
    for _, timer in ipairs(G.MOD_TIMERS) do
        if timer.id == id then
            print("this exists!")
            return nil
        end
    end
    local timer = {}
    timer.id = id or "new_timer"
    timer.seconds = seconds or 69
    timer.onend = onend or function() end
    timer.paused = paused or false
    timer.scale = scalar or 1
    timer.starttime = seconds or 0
    table.insert(G.MOD_TIMERS, timer)
end

function timer_exists(id)
    for _, timer in ipairs(G.MOD_TIMERS) do
        if timer.id == id then
            return true
        end
    end
    return false
end

function get_timer_seconds(id)
    for _, timer in ipairs(G.MOD_TIMERS) do
        if timer.id == id then
            return timer.seconds
        end
    end
    return nil 
end

-- sets ID to track on the deathwish display
function set_deathwish_timer(id)
    for _, timer in ipairs(G.MOD_TIMERS) do
        if timer.id == id then
            G.TIMER_TRACK = timer
            return
        end
    end
    G.TIMER_TRACK = {}
end

function pause_deathwish_timer(id)
    for _, timer in ipairs(G.MOD_TIMERS) do
        if timer.id == id then
            timer.paused = true
        end
    end
    G.TIMER_TRACK = {}
end

function unpause_deathwish_timer(id)
    for _, timer in ipairs(G.MOD_TIMERS) do
        if timer.id == id then
            timer.paused = false
        end
    end
    G.TIMER_TRACK = {}
end

function remove_timer(id)
    for _, timer in ipairs(G.MOD_TIMERS) do
        if timer.id == id then
            table.remove(G.MOD_TIMERS, _)
        end
    end
end

function save_file_timers()
    if G.GAME then
        G.GAME.MOD_TIMERS = G.MOD_TIMERS
    end
end