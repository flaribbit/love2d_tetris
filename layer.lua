local rand,int=math.random,math.floor
local setColor=love.graphics.setColor
local circle,line=love.graphics.circle,love.graphics.line
Layerpos={{},{},{},{}}

function LayerDrawInit()
    local x0,y0=100,420-380
    local p,_=Layerpos[1],1
    for i=1,20 do
        for j=1,10 do
            p[_],_={x0+j*20-10,y0+i*20-10},_+1
        end
    end
    p=Layerpos[2]
    for i=1,32 do
        p[i]={x0+300,y0+(i-1)*12}
    end
    p=Layerpos[3]
    for i=1,32 do
        p[i]={x0+400,y0+(i-1)*12}
    end
    p=Layerpos[4]
    for i=1,8 do
        p[i]={x0+500,y0+(i-1)*12}
    end
end

function LinearLayer(m,n)
    local a,b={},{}
    for i=1,m do
        local t={}
        for j=1,n do
            t[j]=rand()*2-1
        end
        a[i]=t
    end
    for j=1,n do
        b[j]=rand()*2-1
    end
    return {a,b}
end

local function normalize(x)
    return x>=0 and x or 0
end

function GetInput()
    local t,_={},1
    for i=20,1,-1 do
        local row=Field[i]
        for j=1,10 do
            t[_],_=row[j]>0 and 1 or 0,_+1
        end
    end
    local b=Block.data
    for i=1,#b do
        local p=b[i]
        t[(p[1]+Block.i-2)*10+p[2]+Block.j]=-1
    end
    return t
end

function LayerCalculate(weights,x)
    local a,b=weights[1],weights[2]
    local m,n=#a,#b
    local y={}
    for i=1,n do
        local t=0
        for j=1,m do
            t=t+x[j]*a[j][i]
        end
        y[i]=normalize(t+b[i])
    end
    return y
end

local function InRect(x0,y0,x,y,w,h)
    return x0>x and y0>y and x0<x+w and y0<y+h
end

function LayerUpdate()
    AILayer[1]=GetInput()
    AILayer[2]=LayerCalculate(AINet[1],AILayer[1])
    AILayer[3]=LayerCalculate(AINet[2],AILayer[2])
    AILayer[4]=LayerCalculate(AINet[3],AILayer[3])
    Control.key.left=AILayer[4][1]>0.5 and true or false
    Control.key.right=AILayer[4][2]>0.5 and true or false
    Control.key.up  =AILayer[4][3]>0.5 and true or false
    Control.key.down=AILayer[4][4]>0.5 and true or false
    Control.key.rotl=AILayer[4][5]>0.5 and true or false
    Control.key.rotr=AILayer[4][6]>0.5 and true or false
    Control.key.hold=AILayer[4][7]>0.5 and true or false
end

function LayerDraw()
    local x,y=love.mouse.getPosition()
    ----------------------------------------------------------------------------
    -- 权重显示
    local p=Layerpos[2]
    local x0,y0=p[1][1]-6,p[1][2]-6
    if InRect(x,y,x0,y0,12,32*12) then
        local j=int((y-y0)/12)+1
        for i=1,#Layerpos[1] do
            local w=AINet[1][1][i][j]
            if w<0 then
                if w<-1 then w=-1 end
                setColor(-w,0,0)
            else
                if w>1 then w=1 end
                setColor(0,w,0)
            end
            line(Layerpos[1][i][1],Layerpos[1][i][2],p[j][1],p[j][2])
        end
    end
    p=Layerpos[3]
    x0,y0=p[1][1]-6,p[1][2]-6
    if InRect(x,y,x0,y0,12,32*12) then
        local j=int((y-y0)/12)+1
        for i=1,#Layerpos[2] do
            local w=AINet[2][1][i][j]
            if w<0 then
                if w<-1 then w=-1 end
                setColor(-w,0,0)
            else
                if w>1 then w=1 end
                setColor(0,w,0)
            end
            line(Layerpos[2][i][1],Layerpos[2][i][2],p[j][1],p[j][2])
        end
    end
    p=Layerpos[4]
    x0,y0=p[1][1]-6,p[1][2]-6
    if InRect(x,y,x0,y0,12,8*12) then
        local j=int((y-y0)/12)+1
        for i=1,#Layerpos[2] do
            local w=AINet[2][1][i][j]
            if w<0 then
                if w<-1 then w=-1 end
                setColor(-w,0,0)
            else
                if w>1 then w=1 end
                setColor(0,w,0)
            end
            line(Layerpos[3][i][1],Layerpos[3][i][2],p[j][1],p[j][2])
        end
    end
    ----------------------------------------------------------------------------
    -- 神经元显示
    p=Layerpos[2]
    for i=1,#p do
        local w=AILayer[2][i]
        if w<0 then
            if w<-1 then w=-1 end
            setColor(-w,0,0)
        else
            if w>1 then w=1 end
            setColor(0,w,0)
        end
        circle("fill",p[i][1],p[i][2],6,6)
    end
    p=Layerpos[3]
    for i=1,#p do
        local w=AILayer[3][i]
        if w<0 then
            if w<-1 then w=-1 end
            setColor(-w,0,0)
        else
            if w>1 then w=1 end
            setColor(0,w,0)
        end
        circle("fill",p[i][1],p[i][2],6,6)
    end
    p=Layerpos[4]
    for i=1,#p do
        local w=AILayer[4][i]
        if w<0 then
            if w<-1 then w=-1 end
            setColor(-w,0,0)
        else
            if w>1 then w=1 end
            setColor(0,w,0)
        end
        circle("fill",p[i][1],p[i][2],6,6)
    end
end
