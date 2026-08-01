
G.songtracker_data = {
    current_music = nil,
    position = 0,
    duration = 0,
    is_playing = false,
}

function G.songtracker_update(dt)
    if not G.SOUND_MANAGER then return end
    
    -- Initialize channels once
    if not G.SOUND_MANAGER._channels_init then
        G.SOUND_MANAGER.track_info_query = love.thread.getChannel('track_info_query')
        G.SOUND_MANAGER.track_info_response = love.thread.getChannel('track_info_response')
        G.SOUND_MANAGER._channels_init = true
    end
    
    -- Query for track info every frame
    G.SOUND_MANAGER.track_info_query:push({})
    local response = G.SOUND_MANAGER.track_info_response:pop()
    
    if response and response.is_playing then
        G.songtracker_data.current_music = response.track_key
        G.songtracker_data.duration = response.duration or 0
        G.songtracker_data.is_playing = true
        G.songtracker_data.position = response.position or 0
    else
        G.songtracker_data.is_playing = false
    end
end

function G.get_song_position()
    return G.songtracker_data.position
end

function G.get_song_duration()
    return G.songtracker_data.duration
end

function G.get_song_elapsed()
    return G.songtracker_data.position
end

function G.get_song_is_playing()
    return G.songtracker_data.is_playing
end

function G.get_song_progress()
    return G.songtracker_data.duration > 0 and (G.songtracker_data.position / G.songtracker_data.duration) or 0
end
