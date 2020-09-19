push = require 'push'
Class = require 'class'
require 'Bird'
require 'Pipe'
require 'PipePair'

require 'StateMachine'
require 'states/BaseState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'
-- local bird = Bird()
-- This is for adding fullscreen manually and globally
WINDOW_WIDTH = 1280-10
WINDOW_HEIGHT = 720-50
--This is for making the actual pixels look retro by reducing the quality
--by extending the virtual borders of the same.
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288-50
background_movement = 0
ground_movement = 0
BACKGROUND_SPEED = 30
GROUND_SPEED = 60
--gravity = 50
-- This is calculated according to the tile size of the image that is used as
-- the bg. so this number will seamlessly bring the image back to the startingpoint.
BACKGROUND_LOOPING_POINT = 413
--create an pipe table
pipetable = {}
pipetimespawn = 0
scrolling = true
function love.load()
  --This is for adding a local background and ground image to the game by your own
  --Background is just a variable
  background = love.graphics.newImage("background.png")
  ground = love.graphics.newImage("ground.png")


  --this to not make the image look blurry and interpolated
  love.graphics.setDefaultFilter('nearest','nearest')
  love.window.setTitle("jerry bird game")

smallfont = love.graphics.newFont("3Dventure.ttf", 8)
mediumfont = love.graphics.newFont("3Dventure.ttf", 12)
love.graphics.setFont(mediumfont)


--screen settings you give manually
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
      vsync = true,
      fullscreen = false,
      resizable = true
  })
-- this table is created to keep a count on all the keys that are pressed and are added to the table.
 love.keyboard.anykeypressed = {}

gStateMachine = StateMachine{
  ['title'] = function() return TitleScreenState() end,
  ['countdown'] = function() return CountdownState() end,
  ['play'] = function() return PlayState() end,
  ['score'] = function() return ScoreState() end,
}
gStateMachine:change('title')
end

function love.resize(w,h)
  push:resize(w,h)  --push has its own function to enable/disable the resizing feature.
end

function love.keypressed(key)
love.keyboard.anykeypressed[key] = true --upon pressing any key - BOOLEAN TRUE IS ASSIGNED TO THE KEY/table ITSELF!

  if key=="escape" then
    love.event.quit()
  end
  if key=="r" then
    love.load()
    love.event.clear()
  end
end

function love.keyboard.Allpressedkeys(key)
  --This function is returning the value of the key pressed along with whether its true or false
  if love.keyboard.anykeypressed[key] then
    return true
  else
    return false
  end
end


function love.update(dt)
background_movement = (background_movement + BACKGROUND_SPEED * dt) % BACKGROUND_LOOPING_POINT
ground_movement = (ground_movement + GROUND_SPEED * dt) % VIRTUAL_WIDTH

gStateMachine:update(dt)
--[[pipetimespawn = pipetimespawn + dt
if pipetimespawn > 2 then
  table.insert(pipetable,Pipe())
  print("Added new pipe")
  pipetimespawn = 0
end--]]
--[[EXPLATION OF THE IF STATEMENT^^ --
What is happening here is, in every single frame we are adding a new pipes
into the table by calling the pipe function itself and when the function is called i believe athat
a pipe is created with all its values and variables and this process is done in every second of the frame buffer.
So instead of having like a continous flow of non stop pipes, we are limiting it to every two frames. So now there would be some kind of a differnce in the frame timing
this would ultimately lead to gaps in pipes with delta time. and we are resetting the value of the pipespawner/delayer back to zero after every two frames to keep it going non stop.
complex indeed.

bird:update(dt)
  for k,pipe in pairs(pipetable) do
    pipe:update(dt)
    if pipe.x < -pipe.width then
      table.remove(pipetable,k)
    end
  end]]
  love.keyboard.anykeypressed = {} --function is called every frame and keeps on refreshing

end

function love.draw()
  push:start()

-- draw the background starting at top left (0, 0)
 love.graphics.draw(background, -background_movement, 0)
--[[render pipes before them ground to make it look better - ORDER MATERS.
for k, pipe in pairs(pipetable) do
pipe:render()
end

 -- draw the ground on top of the background, toward the bottom of the screen]]
 love.graphics.draw(ground, -ground_movement, VIRTUAL_HEIGHT - 16)
gStateMachine:render()

  push:finish()
end
