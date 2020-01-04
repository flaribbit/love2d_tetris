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
        hold="u",
        load="l"
    },
    DAS=10,
    ARR=1,
    timer=0
}

function Control:Init()
    for k,_ in pairs(self.settings) do
        self.key[k],self.okey[k]=false,false
    end
end

function Control:Update()
    local p=love.keyboard.isDown
    local key=self.key
    for k,v in pairs(self.settings) do
        self.okey[k],key[k]=key[k],p(v)
    end
    if key.left or key.right then
        if self.okey.left or self.okey.right then
            self.timer=self.timer+1
            if self.timer==self.ARR then
                self.timer=0
            end
        else
            self.timer=-self.DAS
        end
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
    return self.key[k] and (not self.okey[k] or (k=="left" or k=="right") and self.timer==0)
end
