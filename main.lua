require "game"
require "layer"
require "control"
require "ga"

function love.load2()
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

function love.load()
    local rand,int=math.random,math.floor
    math.randomseed(os.time())
    -- Field:Init()
    -- Next:Init()
    -- Block:Load(Next:Shift())
    InitGroup()
    for i=1,100 do
        AIGroup[i].score=AIEvaluate(AIGroup[i].net)
        print(string.format("[%3d] score=%d",i,AIGroup[i].score))
    end
    AISort(AIGroup)
    print(AIGroup[1].score)
    for i=51,100 do
        AIGroup[i].net=AICopy(AIGroup[int(rand()*50)+1].net)
        AIChange(AIGroup[i].net,4)
        AIGroup[i].score=0
    end
end

function love.update(dt)
    Control:Update()
    GameUpdate()
    LayerUpdate()
end

function TestDraw()

end

function love.draw(dt)
    -- Field:Draw()
    -- Next:Draw()
    -- Block:Draw()
    -- LayerDraw()
    -- TestDraw()
end
