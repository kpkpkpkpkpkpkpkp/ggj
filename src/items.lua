function entity.animation(image, width, height, duration)
    local animation = {}
    animation.sheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width,
                                                                height,
                                                                image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.ct = 0

    return animation
end