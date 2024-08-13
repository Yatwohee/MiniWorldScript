-- 界面中的按钮被松开时运行
local function UI_Button_Click(event)
    local button_id = event.btnelenemt
    for k,v in pairs(player_list)
    do
        if(v.playerid == event.eventobjid)
        then
            local number = v.numkey_obj:Output(button_id)
            local operator = nil
            if (tonumber(string.sub(v.screen_obj.text,#v.screen_obj.text))) then
                --如果条件为真的执行体
                operator = v.operakey_obj:Output(button_id)
            end
            if(number or operator)
            then
                v.screen_obj.text = v.screen_obj.text..(tostring(number or operator))
            end
            v.screen_obj.text = v.backspace_obj:Backspace(button_id, v.screen_obj.text)
            local result = v.calculate_obj:Calculate(button_id, v.screen_obj.text)
            if (result) then
                --如果条件为真的执行体
                v.screen_obj.text=result
            end
            v.screen_obj:Refresh()
        end
    end
end

-- 注册界面中的按钮被松开监听器
ScriptSupportEvent:registerEvent([=[UI.Button.Click]=], UI_Button_Click)