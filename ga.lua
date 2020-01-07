require "game"
require "layer"
require "control"

Timer=0
AILayer={}
AIGroup={}

function InitGroup()
    for i=1,100 do
        AIGroup[i]={
            LinearLayer(200,32),
            LinearLayer(32,32),
            LinearLayer(32,8)
        }
    end
end

function AIEvaluate(ainet)
    Score=0
    math.randomseed(os.time())
    Field:Init()
    Next:Init()
    Block:Load(Next:Shift())
    AINet=ainet
    while Timer<3600 do
        Control:Update()
        GameUpdate()
        LayerUpdate()
        Timer=Timer+1
    end
    print(Score)
end
