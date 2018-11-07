local greyHex;

function GrayAway_Init()
    -- Vanilla WoW nonsense - fetch hex color code for grey items, store it.
    -- Quality goes from 0 - 6 in Vanilla, 0 being grey items.
    local _, _, _, hex = GetItemQualityColor(0);
    greyHex = string.sub(hex, 3);
	this:RegisterEvent("MERCHANT_SHOW");
end

function GrayAway_Event()
        DEFAULT_CHAT_FRAME:AddMessage("test");
        -- Iterate through bags, starting from 0 (backpack).
        for bagId = 0, NUM_BAG_SLOTS do
            -- Bag slots start from 1 (Lua pls).
            for slotId = 1, GetContainerNumSlots(bagId) do
                local item = GetContainerItemLink(bagId, slotId);
                -- nil is returned if slot is empty.
                if item ~= nil and string.find(item, greyHex) then
                    UseContainerItem(bagId, slotId);
                end
            end
        end
end