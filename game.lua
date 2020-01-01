local int,rand=math.floor,math.random
local rect=love.graphics.rectangle
local color=love.graphics.setColor

local blockdata=require "blockdata"
local Bag={}

Field={}
Next={}
Block={}

function Field:Init()
    for _=1,40 do self[_]={0,0,0,0,0,0,0,0,0,0} end
end

function Field:ClearLine()
    local to=1
    for i=1,40 do
        local copy=false
        for j=1,10 do
            if self[j]==0 then
                copy=true
                break
            end
        end
        if copy then
            to=to+1
        else
            self[to]=self[i]
        end
    end
    for i=to,40 do
        self[i]={0,0,0,0,0,0,0,0,0,0}
    end
end

function Field:Draw()
    local x0,y0=100,420
    color(1,1,1)
    rect("line",x0,y0-380,200,400)
    for i=1,20 do
        local line=self[i]
        for j=1,10 do
            if line[j]>0 then
                rect("fill",x0+(j-1)*20,y0-(i-1)*20,20,20)
            end
        end
    end
end

function Field:Collide(block,bi,bj)
    for _=1,#block.data do
        local p=block.data[_]
        local i,j=20-bi-p[1],bj+p[2]
        if i<1 or j<1 or j>10 or self[i][j]>0 then
            return true
        end
    end
    return false
end

function Field:Lock(block)
    for _=1,#block.data do
        local p=block.data[_]
        local i,j=20-block.i-p[1],block.j+p[2]
        self[i][j]=block.type
    end
end

function Bag:Init()
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
        self:Init()
    end
    return v
end

function Next:Init()
    Bag:Init()
    for i=1,6 do
        Next[i]=Bag:Pop()
    end
end

function Next:Shift()
    local b=table.remove(self,1)
    self[6]=Bag:Pop()
    return b
end

function Next:Draw()
    local x0,y0=100,420-380
    for i=1,6 do
        local b=blockdata[Next[i]][1]
        for j=1,#b do
            local p=b[j]
            rect("fill",x0+220+5*p[2],y0+i*20+5*p[1],5,5)
        end
    end
end

function Block:Load(type)
    local block=blockdata[type]
    self.data={}
    self.type=type
    self.center=block[2]
    self.i=1
    self.j=3
    for i=1,4 do
        local p=block[1][i]
        self.data[i]={p[1],p[2]}
    end
end

function Block:RotateL()
    local o=self.center
    for i=1,#self.data do
        local p=self.data[i]
        p[1],p[2]=o[1]-(p[2]-o[2]),o[2]+(p[1]-o[1])
    end
end

function Block:RotateR()
    local o=self.center
    for i=1,#self.data do
        local p=self.data[i]
        p[1],p[2]=o[1]+(p[2]-o[2]),o[2]-(p[1]-o[1])
    end
end

function Block:Draw()
    local x0,y0=100,420-380
    color(1,0,0)
    for i=1,#self.data do
        local p=self.data[i]
        rect("fill",x0+(self.j+p[2]-1)*20,y0+(self.i+p[1]-2)*20,20,20)
    end
end

function GameNext()
    Block:Load(Next:Pop())
end
