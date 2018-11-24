local _, _, _, hex = GetItemQualityColor(0);
local grayHex = string.sub(hex, 3);

local frame = CreateFrame("Frame");
frame:RegisterEvent("PLAYER_MONEY");
frame:SetScript("OnEvent", function (self, event)
    if event == "PLAYER_MONEY" then 
        DEFAULT_CHAT_FRAME:AddMessage(GetMoney());
    end
end)

function GrayAway_Init()
    -- Vanilla WoW nonsense - fetch hex color code for grey items, store it.
    -- Quality goes from 0 - 6 in Vanilla, 0 being grey items.
    local _, _, _, hex = GetItemQualityColor(0);
    grayHex = string.sub(hex, 3);
	this:RegisterEvent("MERCHANT_SHOW");
end

function GrayAway_Event()
    local currentCopper = GetMoney();
    -- Iterate through bags, starting from 0 (backpack).
    for bagId = 0, NUM_BAG_SLOTS do
        -- Bag slots start from 1 (Lua pls).
        for slotId = 1, GetContainerNumSlots(bagId) do
            local item = GetContainerItemLink(bagId, slotId);
            -- nil is returned if slot is empty.
            if item ~= nil and string.find(item, grayHex) then
                UseContainerItem(bagId, slotId);
            end
        end
    end
end