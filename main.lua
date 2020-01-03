require "game"
require "control"

function love.load()
    Field:Init()
    Next:Init()
    Block:Load(Next:Shift())
end

function love.update(dt)
    Control:Update()
    if Control:IsPress("left") then
        if Field:Check(Block,Block.i,Block.j-1) then
            Block.j=Block.j-1
        end
    end
    if Control:IsPress("right") then
        if Field:Check(Block,Block.i,Block.j+1) then
            Block.j=Block.j+1
        end
    end
    if Control:IsPress("up") then
        while Field:Check(Block,Block.i+1,Block.j) do
            Block.i=Block.i+1
        end
        Field:Lock(Block)
        Field:ClearLine()
        Block:Load(Next:Shift())
    end
    if Control:IsPress("down") then
        if Field:Check(Block,Block.i+1,Block.j) then
            Block.i=Block.i+1
        end
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
    Next:Draw()
    Block:Draw()
end
