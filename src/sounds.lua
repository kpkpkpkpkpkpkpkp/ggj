sounds = {}
function sounds.load()
    playing = 0
    layers = {
        love.audio.newSource(
            'assets/sounds/Mysterious BGM Edit 1 Export 1 Mids 1 Render 1.ogg',
            'stream'), love.audio.newSource(
            'assets/sounds/Mysterious BGM Edit 1 Export 1 Mids 2 Render 1.ogg',
            'stream'), love.audio.newSource(
            'assets/sounds/Mysterious BGM Edit 1 Export 1 Mids 3 Render 1.ogg',
            'stream'), love.audio.newSource(
            'assets/sounds/Mysterious BGM Edit 1 Export 1 Melody Render 1.ogg',
            'stream'), love.audio.newSource(
            'assets/sounds/Mysterious BGM Edit 1 Export 1 Melody Render 1.ogg',
            'stream'), love.audio.newSource(
            'assets/sounds/Mysterious BGM Edit 1 Export 1 Melody Render 1.ogg',
            'stream'), love.audio.newSource(
            'assets/sounds/Mysterious BGM Edit 1 Export 1 Melody Render 1.ogg',
            'stream'), love.audio.newSource(
            'assets/sounds/Mysterious BGM Edit 1 Export 1 Melody Render 1.ogg',
            'stream')
    }
    for i, sound in ipairs(layers) do
        sound:setVolume(0)
        sound:setLooping(true)
        love.audio.play(sound)
    end
end

function sounds.playmore()
    if playing < #layers then
        playing = playing + 1
        layers[playing]:setVolume(1)
    end
end

function sounds.playless()
    if playing > 0 then
        layers[playing]:setVolume(0)
        playing = playing - 1
    end
end

function sounds.playnone()
    for i, sound in ipairs(layers) do
        sound:setVolume(0)
        playing = 0
    end
end
