-- -- -- -- -- -- -- -- -- -- -- -- --
-- -- PvP Token System by Salja. -- --
-- -- -- -- -- -- -- -- -- -- -- -- --

-- Settings
local ItemOrGold = 0                     -- 0 = Gold and Item, 1 = Only Item, 2 = Only Gold
local WorldAnnounce = 1                  -- Sends a World Announce 0 = Off, 1 = On
local GoldCount = 10000                  -- 1 Gold
local ItemEntry = 20558                  -- Warsong Gulch Mark of Honor
local ItemCount = 1                      -- Count of the Item
local ItemName = GetItemLink(ItemEntry)


local function PvPTokenItem(event, killer, killed)
    local receiver = killer:GetGUIDLow()

    if (WorldAnnounce == 1) then
        SendWorldMessage("[PVP] |Hplayer:"..killer:GetName().."|h["..killer:GetName().."]|h killed |Hplayer:"..killed:GetName().."|h["..killed:GetName().."]|h")
    end

    if (ItemOrGold == 0) then
        if (killer:AddItem(ItemEntry, ItemCount)) then
            if (ItemCount == 1) then
                killer:SendBroadcastMessage("|CFF20C000 You get: "..ItemName.."|CFF20C000.|r")
                killer:ModifyMoney(GoldCount)
                killer:SendBroadcastMessage("|CFF20C000 You get: "..GoldCount.."|CFF20C000 Chopper.|r")
            else
                killer:SendBroadcastMessage("|CFF20C000 You get: "..ItemName.."|CFF20C000 x"..ItemCount..".|r")
                killer:ModifyMoney(GoldCount)
                killer:SendBroadcastMessage("|CFF20C000 You get: "..GoldCount.."|CFF20C000 Chopper.|r")
            end
        else
            killer:SendBroadcastMessage("|cffff0000 Your bags are full, we will send it by mail.|r")
            killer:ModifyMoney(GoldCount)
            killer:SendBroadcastMessage("|CFF20C000 You get: "..GoldCount.."|CFF20C000 Chopper.|r")
            -- SendMail("PvP Token System", "Your Bags are full we send via Mail", receiver, nil, 41, nil, ItemEntry, ItemCount)
        end
    end

    if (ItemOrGold == 1) then
        if (killer:AddItem(ItemEntry, ItemCount)) then
            if (ItemCount == 1) then
                killer:SendBroadcastMessage("|CFF20C000 You get: "..ItemName.."|CFF20C000.|r")
            else
                killer:SendBroadcastMessage("|CFF20C000 You get: "..ItemName.."|CFF20C000 x"..ItemCount..".|r")
            end
        else
            killer:SendBroadcastMessage("|cffff0000 Your bags are full, we will send it by mail.|r")
            -- SendMail("PvP Token System", "Your Bags are full we send via Mail", receiver, nil, 41, nil, ItemEntry, ItemCount)
        end
    end

    if (ItemOrGold == 2) then
        killer:ModifyMoney(GoldCount)
        killer:SendBroadcastMessage("|CFF20C000 You get: "..GoldCount.."|CFF20C000 Chopper.|r")
    end
end

RegisterPlayerEvent(6, PvPTokenItem)