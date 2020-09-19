--[[ This state is used to keep track of and record the countdown
right before the game starts. And after the count down is over in
this state, the gameplay starts.]]

CountdownState = Class{__includes = BaseState}

countdowntime = 0.75

function CountdownState:init()
self.timer = 0
self.count = 3
end

function CountdownState:update(dt)
self.timer = self.timer + 1 * dt
  if self.timer > countdowntime then
    self.timer = self.timer % countdowntime
    self.count = self.count - 1

    if self.count == 0 then
      gStateMachine:change('play')
    end

  end
end

function CountdownState:render()
love.graphics.setFont(mediumfont)
love.graphics.printf(tostring(self.count),0,120,VIRTUAL_WIDTH,'center')
end
