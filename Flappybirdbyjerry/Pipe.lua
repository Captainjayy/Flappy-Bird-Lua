Pipe= Class{}
PIPE_HEIGHT = 430
PIPE_WIDTH = 70
function Pipe : init()
pipeimage = love.graphics.newImage("pipe.png")
self.x = VIRTUAL_WIDTH
self.y = math.random(VIRTUAL_HEIGHT/4,VIRTUAL_HEIGHT-10)
pipescroll = -60

self.width = PIPE_WIDTH
self.height=PIPE_HEIGHT
self.orientation= orientation
end

function Pipe:update(dt)
--self.x = self.x + pipescroll *dt
end

function Pipe:render()
--love.graphics.draw(pipeimage,math.floor(self.x+0.5),math.floor(self.y))
love.graphics.draw(pipeimage, self.x,
      (self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y),
      0, 1, self.orientation == 'top' and -1 or 1)
end
