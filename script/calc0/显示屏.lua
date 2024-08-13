-- 显示屏类属性
Screen_Class =
{
    text = "",
    text_id = [[7183546817928307101_7]],
    playerid = 0,
    uiid = [[7183546817928307101]]
}

-- 显示屏类刷新方法
function Screen_Class:Refresh()
    local playerid = self.playerid
    local uiid = self.uiid
    local elementid = self.text_id
    local text = self.text
    result = Coustomui:setText(playerid, uiid, elementid, text)
end

-- 显示屏类构造函数
function Screen_Class:New(attr)
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