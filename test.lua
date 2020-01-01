dofile("main.lua")
Block:Load(Next:Pop())
for i=1,40 do
    for j=1,10 do
        Field[i][j]=(i+j)%0
    end
end
