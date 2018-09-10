-- require the push library for dimensions handling
push = require "push"
Class = require "class"

require "Burd"
require "Pipe"

-- Set the phisical window dimensions constants
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Set the virtual window constants
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage("background.png")
local backgroundScroll = 0

local ground = love.graphics.newImage("ground.png")
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

local burd = Burd()

local pipes = {}

local spawnTimer = 0

function love.load()
    --To avoid bluriness
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Sets the window title
    love.window.setTitle("Flappy Burd")

    math.randomseed(os.time())

    push:setupScreen(
        VIRTUAL_WIDTH,
        VIRTUAL_HEIGHT,
        WINDOW_WIDTH,
        WINDOW_HEIGHT,
        {
            fullscreen = false,
            resizable = true,
            vsync = true
        }
    )

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == "escape" then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

    spawnTimer = spawnTimer + dt

    if spawnTimer > 2 then
        table.insert(pipes, Pipe())
        spawnTimer = 0
    end

    burd:update(dt)

    for k, pipe in pairs(pipes) do
        pipe:update(dt)

        if pipe.x < -pipe.width then
            table.remove(pipes, k)
        end
    end

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    love.graphics.draw(background, -backgroundScroll, 0)

    for k, pipe in pairs(pipes) do
        pipe:render()
    end 

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    burd:render()

    push:finish()
end
