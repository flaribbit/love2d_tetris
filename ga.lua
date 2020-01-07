require "game"
require "layer"
require "control"

Timer=0
AILayer={}
AIGroup={}

function InitGroup()
    for i=1,100 do
        AIGroup[i]={
            net={
                LinearLayer(200,32),
                LinearLayer(32,32),
                LinearLayer(32,8)
            },
            score=0
        }
    end
end

function AIEvaluate(ainet)
    Score=0
    Timer=0
    math.randomseed(os.time())
    Field:Init()
    Next:Init()
    Block:Load(Next:Shift())
    AINet=ainet
    AILayer={}
    while Timer<3600 do
        Control:Update()
        GameUpdate()
        LayerUpdate()
        Timer=Timer+1
    end
    return Score
end

function AISort(t)
    table.sort(t,function(a,b)
        return a.score>b.score
    end)
end
