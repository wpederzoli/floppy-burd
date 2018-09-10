-- require the push library for dimensions handling
push = require 'push'
Class = require 'class'

require 'Burd'

-- Set the phisical window dimensions constants
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Set the virtual window constants
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background =  love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

local burd = Burd()

function love.load()
    --To avoid bluriness
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Sets the window title
    love.window.setTitle('Flappy Burd')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resize = true,
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

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % VIRTUAL_WIDTH
end

function love.draw()
    push:start()
    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    
    burd:render()

    push:finish()
end 