local colors={"#F44336","#4caf50","#ff9800","#2196f3","#9c27b0","#ffeb3b","#00bcd4"}
for i=1,#colors do
    local c=colors[i]
    local r,g,b=tonumber(c:sub(2,3),16),tonumber(c:sub(4,5),16),tonumber(c:sub(6,7),16)
    colors[i]={r/255,g/255,b/255}
end
return colors
