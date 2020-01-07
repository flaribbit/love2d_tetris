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
    DAS=8,
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
        -- self.okey[k],key[k]=key[k],p(v)
        self.okey[k],key[k]=key[k],key[k]
    end
    if p("l") then key["load"]=true end
    if key.left or key.right or key.down then
        if self.okey.left or self.okey.right or self.okey.down then
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
    return self.key[k] and (not self.okey[k] or (k=="left" or k=="right" or k=="down") and self.timer==0)
end
