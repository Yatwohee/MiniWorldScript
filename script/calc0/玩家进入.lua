-- 玩家类属性
Player_Class =
{
    playerid = 0,
    screen_obj = {},
    numkey_obj = {},
    operakey_obj = {},
    backspace_obj = {},
    calculate_obj = {}
}

-- 玩家类构造函数
function Player_Class:New(attr)
    local tab = {}
    for k,v in pairs(self)
    do
        if(attr and attr[k])
        then
            tab[k] = attr[k]
        else
            tab[k] = v
        end
    end
    return tab
end