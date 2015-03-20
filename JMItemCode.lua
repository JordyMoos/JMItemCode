
---
--- JMItemCode
---

---
-- @field name
--
local Config = {
    name = 'JMItemCode',
}

local Converter = {}

---
-- Create a unique enough code from the itemLink
-- Items are not unique enough, There is a big difference between a level 1 and level 50
-- So we add some more information to the code (sometimes)
--
-- @param itemLink
--
function Converter:getCodeFromItemLink(itemLink)
    local typeId = GetItemLinkItemType(itemLink)
    local pattern = "|H%d:item:(%d+):(%d+):(%d+):(%d+):.*:(%d+)|.+"
    local replacement = "%1"
    
    if typeId == 7 then
        replacement = "%1/%2/%3/%5"
    elseif typeId == 1 or typeId == 2 or typeId == 20 or typeId == 21 or typeId == 26 then
        replacement = "%1/%2/%3/%4"
    end
    
    return itemLink:gsub(pattern, replacement, 10000):sub(1, -1)
end

--[[

    Api

 ]]

JMItemCode = {

    ---
    -- Covert itemLink to a code
    --
    getCode = function(itemLink)
        return Converter:getCodeFromItemLink(itemLink)
    end,
}
