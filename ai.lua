AI={}
AI.Field={}

function AI:Init()

end

function AI:Update()

end

local function GetHeight(field)
    for i=22,1,-1 do
        for j=1,10 do
            if field[i][j]>0 then
                return i
            end
        end
    end
end

local function GetScore(field)

end

local function GetPath()

end

function AI:GetBestPosition()
    -- 复制方块数据
    local height=GetHeight(Field)
    local rotateL,rotateR=Block.RotateL,Block.RotateR
    local check=Field.Check
    local block={
        data={},
        i=Block.i,
        j=Block.j,
        dir=Block.dir,
        type=Block.type,
        canhold=Block.canhold
    }
    local field,candidates,blockdata,_={},{},block.data,1
    for i=1,#Block.data do
        local p=Block.data[i]
        block.data[i]={p[1],p[2]}
    end
    for i=1,40 do
        local row={}
        for j=1,10 do
            row[j]=Field[i][j]
        end
        field[i]=row
    end
    for dir=1,4 do
        for j=-2,7 do
            local flag=0
            for i=height,1,-1 do
                if check(field,blockdata,i,j) then
                    for k=1,#blockdata do
                        local p=blockdata[k]
                        self[22-i-p[1]][j+p[2]]=10
                    end
                    candidates[_],_={{i,j,dir},GetScore(field)},_+1
                    for k=1,#blockdata do
                        local p=blockdata[k]
                        self[22-i-p[1]][j+p[2]]=0
                    end
                else
                    flag=flag+1
                    if flag>4 then
                        break
                    end
                end
            end
        end
        rotateR(block)
    end
end
