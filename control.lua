Control={
    key={},
    okey={},
    settings={
        up="w",
        down="s",
        left="a",
        right="d",
        rotl="j",
        rotr="k",
        load="l"
    }
}

function Control:Init()
    for k,_ in pairs(self.settings) do
        self.key[k],self.okey[k]=false,false
    end
end

function Control:Update()
    local p=love.keyboard.isDown
    for k,v in pairs(self.settings) do
        self.okey[k],self.key[k]=self.key[k],p(v)
    end
end

function Control:Draw()
    local s=""
    for k,v in pairs(self.key) do
        if v then
            s=s.." "..(v and k or "")
        end
    end
    love.graphics.print(s,0,0)
end

function Control:IsPress(k)
    return self.key[k] and not self.okey[k]
end
