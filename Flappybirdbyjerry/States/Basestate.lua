--[[BaseState is used for the mere purpose of
declaring functions..more like the concept of abstract functions
so they are just declared such that where ever this class is
inherited, the methods can be used DEFINED.]]

 BaseState = Class{}

 --DECLARING METHODS

 function BaseState:init() end
 function BaseState:enter() end
 function BaseState:exit() end
 function BaseState:update(dt) end
 function BaseState:render() end 
