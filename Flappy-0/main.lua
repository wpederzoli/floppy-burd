-- require the push library for dimensions handling
push = require 'push'

-- Set the phisical window dimensions constants
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Set the virtual window constants
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background =  love.graphics.newImage('background.png')
local ground = love.graphics.newImage('ground.png')

function love.load()
    --To avoid bluriness
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Sets the window title
    love.window.setTitle('Flappy Burd')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resize = false,
        vsync = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:start()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(ground, 0, VIRTUAL_HEIGHT - 16)
    push:finish()
end 