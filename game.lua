local int,rand=math.floor,math.random

Field={}
Next={}

Bag={}

function Field:Init()
    for _=1,40 do self[_]={0,0,0,0,0,0,0,0,0,0} end
end

function Field:ClearLine()
    local new,_={
        Init=self.Init,
        ClearLine=self.ClearLine
    },1
    for i=1,40 do
        local line,copy=self[i],false
        for j=1,10 do
            if self[j]==0 then
                copy=true
                break
            end
        end
        if copy then
            new[_],_=line,_+1
        end
    end
    for i=#new+1,40 do
        new[i]={0,0,0,0,0,0,0,0,0,0}
    end
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
