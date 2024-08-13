-- 运算符按钮类属性
Operator_Class =
{
    operator_key =
    {
        {
            id = [[7183546817928307101_32]],
            text = "+"
        },
        {
            id = [[7183546817928307101_34]],
            text = "-"
        },
        {
            id = [[7183546817928307101_36]],
            text = "*"
        },
        {
            id = [[7183546817928307101_38]],
            text = "/"
        }
    }
}

-- 运算符按钮类输出方法
function Operator_Class:Output(button_id)
    for k,v in pairs(self.operator_key)
    do
        if(v.id == button_id)
        then
            return v.text
        end
    end
end

-- 运算符按钮类构造函数
function Operator_Class:New(attr)
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