sounds = {}
function sounds.load()
    openingbg = love.audio.newSource('assets/sounds/old/20210127_mysterious_tune.mp3', 'stream')
    openingbg:setLooping(true)
    endingbg = love.audio.newSource('assets/sounds/credits.ogg', 'stream')
    endingbg:setLooping(true)

    playing = 0
    layers = {
        love.audio.newSource(
            'assets/sounds/bgm1.ogg',
            'stream'),
        love.audio.newSource(
            'assets/sounds/bgm2.ogg',
            'stream'),
        love.audio.newSource(
            'assets/sounds/bgm3.ogg',
            'stream'),
        love.audio.newSource(
            'assets/sounds/bgm4.ogg',
            'stream'),
        love.audio.newSource(
            'assets/sounds/bgm5.ogg',
            'stream'),
        love.audio.newSource(
            'assets/sounds/bgm6.ogg',
            'stream'),
        love.audio.newSource(
            'assets/sounds/bgm7.ogg',
            'stream'),
        love.audio.newSource(
            'assets/sounds/bgm8.ogg',
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
