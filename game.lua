local int,rand=math.floor,math.random

Field={}
Next={}

Bag={}

function Field:Init()
    for _=1,40 do self[_]={0,0,0,0,0,0,0,0,0,0} end
end

function Field:ClearLine()
    
end

function Bag:New()
    for _=1,7 do self[_]=_ end
    for _=1,6 do
        local __=int((8-_)*rand())+_
        self[_],self[__]=self[__],self[_]
    end
    self[8]=1
end

function Bag:Pop()
    local v=self[self[8]]
    if self[8]<7 then
        self[8]=self[8]+1
    else
        Bag:New()
    end
    return v
end

function Next:Init()
    Bag:New()
end

function Next:Shift()

end
