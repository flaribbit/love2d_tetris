require "game"
require "layer"
require "control"

function love.load()
    math.randomseed(os.time())
    Field:Init()
    Next:Init()
    Block:Load(Next:Shift())
    AINet={
        LinearLayer(200,32),
        LinearLayer(32,32),
        LinearLayer(32,8)
    }
    AILayer={}
    LayerDrawInit()
end

function love.update(dt)
    Control:Update()
    GameUpdate()
    LayerUpdate()
end

function TestDraw()

end

function love.draw(dt)
    Field:Draw()
    Next:Draw()
    Block:Draw()
    LayerDraw()
    TestDraw()
end
