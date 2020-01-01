require "game"
require "control"

function love.load()
    Field:Init()
    Bag:New()
end

function love.update(dt)
    Control:Update()
end

function love.draw(dt)
    love.graphics.print("hello",0,0)
end
