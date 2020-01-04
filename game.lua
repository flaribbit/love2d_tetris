local int,rand=math.floor,math.random
local rect=love.graphics.rectangle
local color=love.graphics.setColor

local blockdata=require "blockdata"
local wallkick=require "wallkick"
local colordata=require "colordata"
local Bag={}

Field={}
Next={}
Block={}

function Field:Init()
    Block.canhold=true
    for _=1,40 do self[_]={0,0,0,0,0,0,0,0,0,0} end
end

function Field:ClearLine()
    local to=1
    for i=1,40 do
        for j=1,10 do
            if self[i][j]==0 then
                self[to],to=self[i],to+1
                break
            end
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
                color(colordata[line[j]])
                rect("fill",x0+(j-1)*20,y0-(i-1)*20,20,20)
            end
        end
    end
end

function Field:Check(data,bi,bj)
    for _=1,#data do
        local p=data[_]
        local i,j=22-bi-p[1],bj+p[2]
        if i<1 or j<1 or j>10 or self[i][j]>0 then
            return false
        end
    end
    return true
end

function Field:Lock(block)
    block.canhold=true
    for _=1,#block.data do
        local p=block.data[_]
        local i,j=22-block.i-p[1],block.j+p[2]
        self[i][j]=block.type
    end
    self:ClearLine()
    Block:Load(Next:Shift())
    if not self:Check(Block.data,Block.i,Block.j) then
        self:Init()
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
    self[0]=0
    for i=1,6 do
        self[i]=Bag:Pop()
    end
end

function Next:Shift()
    local b=table.remove(self,1)
    self[6]=Bag:Pop()
    return b
end

function Next:Draw()
    local x0,y0=100,420-380
    if self[0]>0 then
        local b=blockdata[self[0]][1]
        for j=1,#b do
            local p=b[j]
            color(colordata[self[0]])
            rect("fill",x0-80+12*p[2],y0+12*p[1],12,12)
        end
    end
    for i=1,6 do
        local b=blockdata[self[i]][1]
        for j=1,#b do
            local p=b[j]
            color(colordata[self[i]])
            rect("fill",x0+220+12*p[2],y0+(i-1)*40+12*p[1],12,12)
        end
    end
end

function Block:Load(type)
    local block=blockdata[type]
    self.data={}
    self.type=type
    self.dir=1
    self.center=block[2]
    self.i=0
    self.j=3
    for i=1,4 do
        local p=block[1][i]
        self.data[i]={p[1],p[2]}
    end
end

function Block:RotateL()
    local o=self.center
    local new={}
    local kick=wallkick[self.type<7 and 1 or 2][self.dir+4]
    for i=1,#self.data do
        local p=self.data[i]
        new[i]={o[1]-(p[2]-o[2]),o[2]+(p[1]-o[1])}
    end
    for i=1,5 do
        local di,dj=kick[i][2],kick[i][1]
        if Field:Check(new,self.i-di,self.j+dj) then
            self.i=self.i-di
            self.j=self.j+dj
            self.data=new
            self.dir=self.dir-1
            if self.dir==0 then self.dir=4 end
            break
        end
    end
end

function Block:RotateR()
    local o=self.center
    local new={}
    local kick=wallkick[self.type<7 and 1 or 2][self.dir]
    for i=1,#self.data do
        local p=self.data[i]
        new[i]={o[1]+(p[2]-o[2]),o[2]-(p[1]-o[1])}
    end
    for i=1,5 do
        local di,dj=kick[i][2],kick[i][1]
        if Field:Check(new,self.i-di,self.j+dj) then
            self.i=self.i-di
            self.j=self.j+dj
            self.data=new
            self.dir=self.dir+1
            if self.dir==5 then self.dir=1 end
            break
        end
    end
end

function Block:Draw()
    local x0,y0=100,420-380
    local ighost=Block.i
    local c=colordata[self.type]
    color(c[1],c[2],c[3],0.5)
    while Field:Check(Block.data,ighost+1,Block.j) do
        ighost=ighost+1
    end
    for i=1,#self.data do
        local p=self.data[i]
        rect("fill",x0+(self.j+p[2]-1)*20,y0+(ighost+p[1]-2)*20,20,20)
    end
    color(c)
    for i=1,#self.data do
        local p=self.data[i]
        rect("fill",x0+(self.j+p[2]-1)*20,y0+(self.i+p[1]-2)*20,20,20)
    end
end
