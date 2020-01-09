require "game"
require "control"

function love.load()
    math.randomseed(os.time())
    Field:Init()
    Next:Init()
    Block:Load(Next:Shift())
end

function love.update(dt)
    Control:Update()
    GameUpdate()
end

function love.draw(dt)
    Field:Draw()
    Next:Draw()
    Block:Draw()
end
