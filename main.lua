require "game"
require "control"

function love.load()
    Field:Init()
    Next:Init()
    for i=1,40 do
        for j=1,10 do
            Field[i][j]=(i+j)%2
        end
    end
end

function love.update(dt)
    Control:Update()
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
    love.graphics.print("hello",0,0)
    Field:Draw()
end
