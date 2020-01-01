require "game"
require "control"

function love.load()
    Field:Init()
    Next:Init()
    Block:Load(Next:Pop())
end

function love.update(dt)
    Control:Update()
    if Control:IsPress("left") then
        Block.j=Block.j-1
    end
    if Control:IsPress("right") then
        Block.j=Block.j+1
    end
    if Control:IsPress("up") then
        Block.i=Block.i-1
    end
    if Control:IsPress("down") then
        Block.i=Block.i+1
    end
    if Control:IsPress("rotl") then
        Block:RotateL()
    end
    if Control:IsPress("rotr") then
        Block:RotateR()
    end
    if Control:IsPress("load") then
        print("["..os.date("%Y-%m-%d %H:%M:%S").."] Loaded")
        dofile("test.lua")
    end
end

function love.draw(dt)
    love.graphics.print(tostring(Field:Collide(Block,Block.i,Block.j)),0,0)
    Field:Draw()
    Block:Draw()
end
