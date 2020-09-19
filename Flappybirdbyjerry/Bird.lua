Bird = Class{}
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288-50
function Bird : init()
self.bird = love.graphics.newImage("bird.png")
self.width = self.bird:getWidth()
self.height = self.bird:getHeight()

self.x = VIRTUAL_WIDTH/2 - (self.width/2)
self.y = VIRTUAL_HEIGHT/2 - (self.height/2)

--THE SUPPOSED SPEED ALONG THE STRAIGHT PATH??]]

self.dy = 150
gravity = 250
end

function Bird: render()
love.graphics.draw(self.bird,self.x,self.y)
end
function Bird:collides(pipe)
    -- the 2's are left and top offsets
    -- the 4's are right and bottom offsets
    -- both offsets are used to shrink the bounding box to give the player
    -- a little bit of leeway with the collision
    if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
        if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end

    return false
end

function Bird : update(dt)
if love.keyboard.Allpressedkeys("space") then
  self.dy = -100

end

  self.dy = self.dy + gravity * dt
  self.y = self.y + self.dy *dt
end
