require "game"
require "layer"
require "control"

local rand,int=math.random,math.floor

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

function AICross()

end

function LayerCopy(layer)
    local a,b=layer[1],layer[2]
    local m,n=#a,#b
    local newa,newb={},{}
    for i=1,m do
        local row=a[i]
        local t={}
        for j=1,n do
            t[j]=row[j]
        end
        newa[i]=t
    end
    for j=1,n do
        newb[j]=b[j]
    end
    return {newa,newb}
end

function AICopy(ainet)
    local new={}
    for i=1,#ainet do
        new[i]=LayerCopy(ainet[i])
    end
    return new
end

function AIChange(ainet,num)
    for _=1,#ainet do
        local layer=ainet[_]
        local a,b=layer[1],layer[2]
        local m,n=#a,#b
        for u=1,num do
            for v=1,m do
                a[int(rand()*m)+1][int(rand()*n)+1]=rand()*2-1
            end
            b[int(rand()*n)+1]=rand()*2-1
        end
    end
end
