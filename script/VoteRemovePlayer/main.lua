local id = {
  Thispage = "7345472810178912669",                   --界面按钮 (Type: Button)
  Round_oneId = "7345472810178912669_4",              --环节1 (Type: Picture)
  Round_twoId = "7345472810178912669_17",             --环节2 (Type: Picture)
  Round_threeId = "7345472810178912669_36",           --环节3 (Type: Picture)
  Round_oneClose = "7345472810178912669_7",           --关闭按钮ID (Type: Button)

  inputPlayerID1 = "7345472810178912669_9",           --输入玩家前几位ID (Type: Input)
  inputPlayerID2 = "7345472810178912669_10",          --输入玩家后几位ID (Type: Input)
  SearchResultsText = "7345472810178912669_14",       --用于显示搜索结果 (Type: Text)
  InitiateVoting = "7345472810178912669_15",          --发起投票按钮ID (Type: Button)
  SearchPlayers = "7345472810178912669_11",           --搜索按钮ID (Type: Button)

  InitiateVotingPlayers = "7345472810178912669_23",   --显示发起投票玩家的名字 (Type: Text)
  VotedPlayer = "7345472810178912669_26",             --显示被票玩家的名字 (Type: Text)
  Time = "7345472810178912669_34",                    --显示剩余时间 (Type: Text)
  NumResultText = "7345472810178912669_27",           --显示投票结果 (Type: Text)
  MyResultText = "7345472810178912669_35",            --显示我投的票 (Type: Text)

  Endorse = "7345472810178912669_28",                 --同意票按钮ID (Type: Button)
  Against = "7345472810178912669_30",                 --反对票按钮ID (Type: Button)
  Abstained = "7345472810178912669_32",               --弃票按钮ID (Type: Button)

  ResultText = "7345472810178912669_39",              --显示投票结果 (Type: Text)
  Close = "7345472810178912669_40",                   --结束整个流程ID (Type: Button)
}
local InputPlayerID = {};                             --定义玩家输入框内容
local PlayerList = {};                                --定义玩家列表
local ThisSearchName = {};                            -- 玩家搜索结果存储
local Number = { 0, 0, 0, false };                    --定义票数
local function input_PlayerID(event)                  --获取输入
  print(id.inputPlayerID1);
  if (event.btnelenemt == id.inputPlayerID1) then     --获取前半段
    InputPlayerID[event.eventobjid].one = CurEventParam.EventString;
  elseif (event.btnelenemt == id.inputPlayerID2) then --获取后半段
    InputPlayerID[event.eventobjid].two = CurEventParam.EventString;
    --函数体
  end
end
local function ShowAllText(p)
  Customui:setText(
    World:getAllPlayers(-1),
    id.Thispage,
    id.InitiateVotingPlayers,
    ThisSearchName[p].one
  ); Customui:setText(
    World:getAllPlayers(-1),
    id.Thispage,
    id.VotedPlayer,
    ThisSearchName[p].two
  );
end
local function ShowAllNumber()
  Customui:setText(
    World:getAllPlayers(-1),
    id.Thispage,
    id.NumResultText,
    "赞同:" .. Number[1] .. " 反对:" .. Number[2] .. " 弃票:" .. Number[3]
  );
end
local function HideChooseButton()
  Customui:hideElement(World:getAllPlayers(-1), id.Thispage, id.Endorse)
  Customui:hideElement(World:getAllPlayers(-1), id.Thispage, id.Against)
  Customui:hideElement(World:getAllPlayers(-1), id.Thispage, id.Abstained)
end
local function SearchPlayers(ThisPlayerid) --搜索玩家
  local ThisInputId = tonumber(
    InputPlayerID[ThisPlayerid].one ..
    InputPlayerID[ThisPlayerid].two
  ) --合并输入
  -- `二分`搜索玩家
  local function binarySearch(arr, value)
    local low, high = 1, #arr;
    while (low <= high) do
      local mid = math.floor((low + high) / 2);
      if (arr[mid] == value) then
        return mid;
      elseif (arr[mid] < value) then
        low = mid + 1;
      else
        high = mid - 1;
      end
    end
    return -1                                                -- 如果未找到，返回-1
  end
  local Thispostion = binarySearch(PlayerList, ThisInputId); --查找玩家位置
  if (Thispostion ~= -1 and ThisInputId ~= "") then
    Customui:setText(
      ThisPlayerid, id.Thispage, id.SearchResultsText,
      "搜索结果:" .. Trigger.Player:getPlayerName(PlayerList[Thispostion])
    );
  else
    Player:notifyGameInfo2Self(ThisPlayerid, "Emmmmm玩家不存在哦~");
    Customui:setText(
      ThisPlayerid, id.Thispage, id.SearchResultsText,
      "结果会显示在这里"
    );
  end
  return PlayerList[Thispostion];
end

local function shouldRemovePlayer(supportCount, againstCount, abstainCount, threshold)
  local totalVotes = supportCount + againstCount + abstainCount;
  local supportPercentage = supportCount / totalVotes;
  local againstPercentage = againstCount / totalVotes;

  if (supportPercentage >= threshold or againstPercentage >= threshold) then
    return true;
  else
    return false;
  end
end

local function This(event) --按钮点击事件
  local ThisPlayer = event.eventobjid
  if (event.btnelenemt == id.SearchPlayers) then
    ThisSearchName[event.eventobjid].one = Trigger.Player:getPlayerName(ThisPlayer)                 --触发事件玩家的名字
    ThisSearchName[event.eventobjid].two = Trigger.Player:getPlayerName(SearchPlayers(ThisPlayer)); --搜索结果
  elseif (event.btnelenemt == id.InitiateVoting) then
    if (
          ThisSearchName[event.eventobjid].two == ""
        )
    then
      Trigger.Player:notifyGameInfo2Self(event.eventobjid, "无法发起投票!")
    else
      RemovePlayer = SearchPlayers(ThisPlayer)
      ShowAllText(event.eventobjid); --对所有玩家显示被投票玩家和发起投票玩家的名字
      Customui:showElement(World:getAllPlayers(-1), id.Thispage, id.Endorse)
      Customui:showElement(World:getAllPlayers(-1), id.Thispage, id.Against)
      Customui:showElement(World:getAllPlayers(-1), id.Thispage, id.Abstained)
      MiniTimer:startBackwardTimer(1, 20, false)
    end
  elseif (event.btnelenemt == id.Endorse) then
    HideChooseButton()
    Number[1] = Number[1] + 1; --同意
    ShowAllNumber();
    Customui:setText(
      event.eventobjid, id.Thispage, id.MyResultText,
      "我投了 同意"
    );
  elseif (event.btnelenemt == id.Against) then
    HideChooseButton()
    Number[2] = Number[2] + 1; --反对
    ShowAllNumber();
    Customui:setText(
      event.eventobjid, id.Thispage, id.MyResultText,
      "我投了 反对"
    );
  elseif (event.btnelenemt == id.Abstained) then
    HideChooseButton()
    Number[3] = Number[3] + 1; --放弃
    ShowAllNumber();
    Customui:setText(
      event.eventobjid, id.Thispage, id.MyResultText,
      "我放弃投票"
    );
  elseif (event.btnelenemt == id.Close) then
    if (event.eventobjid == RemovePlayer) then
      if (Number[4]) then
        Trigger.Player:notifyGameInfo2Self(event.eventobjid, "很遗憾，你被移除出游戏")
        Trigger.Player:setGameDefeat(RemovePlayer); --移除玩家
        Number = { 0, 0, 0, false };                --初始化票数
        ShowAllNumber();
      else
        Trigger.Player:notifyGameInfo2Self(event.eventobjid, "表现良好，可以继续参加游戏")
        Customui:hideElement(event.eventobjid, id.Thispage, id.Round_threeId)
      end
    else
      Customui:hideElement(event.eventobjid, id.Thispage, id.Round_threeId)
    end
  end
end
local function ThisPlayerEnter(event)
  HideChooseButton()
  table.insert(PlayerList, event.eventobjid) --把玩家加入进列表
  InputPlayerID[event.eventobjid] = {
    one = "",
    two = "",
  }; --初始化前后半段
  ThisSearchName[event.eventobjid] = {
    one = "",
    two = "",
  };                    --初始化搜索结果
end
local function Update() --实时更新
  if (Trigger.Timer:getTimerTime(1) == 0) then
    HideChooseButton()
  end
  Customui:setText(
    World:getAllPlayers(-1),
    id.Thispage,
    id.Time,
    "剩余时间:" .. Trigger.Timer:getTimerTime(1) .. "S"
  );
  Number[4] = shouldRemovePlayer(Number[1], Number[2], Number[3], 40)
  Customui:showElement(World:getAllPlayers(-1), id.Thispage, id.Round_threeId) --时间结束,公布结果
end
MiniTimer:createTimer("投票倒计时", nil, true) --创建一个计时器
--[[ -- 调用示例
local support = 10
local against = 5
local abstain = 3
local threshold = 0.1
local result = shouldRemovePlayer(support, against, abstain, threshold)
print(result) -- 输出 true 或者 false ]]
ScriptSupportEvent:registerEvent_NoError([=[minitimer.change]=], Update)
ScriptSupportEvent:registerEvent_NoError([=[UI.Button.Click]=], This)                     --点击事件
ScriptSupportEvent:registerEvent_NoError([=[UI.LostFocus]=], input_PlayerID)              --输入事件
ScriptSupportEvent:registerEvent_NoError([=[Game.AnyPlayer.EnterGame]=], ThisPlayerEnter) --玩家进入事件
