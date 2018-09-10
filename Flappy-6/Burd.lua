Burd = Class{}

local GRAVITY = 20

function Burd:init()
    self.image = love.graphics.newImage('burd.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    self.dy = 0
end

function Burd:update(dt)
   self.dy = self.dy + GRAVITY * dt 

   if love.keyboard.wasPressed('space') then
        self.dy = -5
   end

   self.y = self.y + self.dy
end

function Burd:render()
    love.graphics.draw(self.image, self.x, self.y)
end

