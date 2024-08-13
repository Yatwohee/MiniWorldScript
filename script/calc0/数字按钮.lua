-- 数字按钮类属性
Number_Class =
{
    number_key =
    {
        {
            id = [[7183546817928307101_28]],
            value = 0
        },
        {
            id = [[7183546817928307101_8]],
            value = 1
        },
        {
            id = [[7183546817928307101_10]],
            value = 2
        },
        {
            id = [[7183546817928307101_12]],
            value = 3
        },
        {
            id = [[7183546817928307101_14]],
            value = 4
        },
        {
            id = [[7183546817928307101_16]],
            value = 5
        },
        {
            id = [[7183546817928307101_18]],
            value = 6
        },
        {
            id = [[7183546817928307101_20]],
            value = 7
        },
        {
            id = [[7183546817928307101_22]],
            value = 8
        },
        {
            id = [[7183546817928307101_24]],
            value = 9
        }
    }
}

-- 数字按钮类输出方法
function Number_Class:Output(button_id)
    for k,v in pairs(self.number_key)
    do
        if(v.id == button_id)
        then
            return v.value
        end
    end
end

-- 数字按钮类构造函数
function Number_Class:New(attr)
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