# love2d 俄罗斯方块

一个简洁的俄罗斯方块小游戏，没有任何的美化，代码也算是比较优雅吧

![QQ截图20200104190720.png](https://i.loli.net/2020/01/04/tJkem2FMcXQLoux.png)

### 注释：
* `game.lua` 游戏主要函数
* `main.lua` 游戏主体逻辑
* `Field` 存储场地，长度为40，按照表示从下到上的顺序
* `Block` 存储当前手里的方块，`ij`是他相对于可视场地的坐标，`(1,1)`表示左上角，数组索引序
* `Next` 存储Next序列，长度为6，遵循[bag7规则](https://tetris.wiki/Random_Generator)生成，外加`[0]`表示hold，取出下一个方块调用`Next:Shift()`
* `blockdata.lua` 存储各个方块的数据，包括**每个小块的坐标和旋转中心**(坐标按数组索引序)，按照`ZSLJTOI`的顺序，**可自己自由添加其他方块**
* `colordata.lua` 存储各个方块的颜色，HTML代码表示
* `wallkick.lua` 存储[SRS旋转系统](https://tetris.wiki/Super_Rotation_System)的踢墙表数据
* `control.lua` 自己定义的按键类，负责统一按键操作处理，便于触摸操作和ai接入
* 代码逻辑清晰，函数的名字就是它的功能，我觉得不需要多余注释的
