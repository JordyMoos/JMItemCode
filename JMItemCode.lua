
---
--- JMItemCode
---

--[[

    Variable declaration

 ]]

---
-- @field name
--
local Config = {
    name = 'JMItemCode',
}

--[[

    Sale History

 ]]

local Converter = {}

---
-- Create a unique enough code from the itemLink
-- Items are not unique enough, There is a big difference between a level 1 and level 50
-- So we add some more information to the code
--
-- @param itemLink
--
function Converter:getCodeFromItemLink(itemLink)
    local pattern = "(|[^:]+:[^:]+:[^:]+:[^:]+:[^:]+):[^:]+:([^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+):[^:]+:([^:]+)(.*)"

    return itemLink:gsub(pattern, "%1:0:%2:0:%3:0:0|h|h", 10000):sub(1, -1)
end

--[[

    Initialize

 ]]

---
-- Start of the addon
--
local function Initialize()

end

--[[

    Events

 ]]

--- Adding the initialize handler
EVENT_MANAGER:RegisterForEvent(
    Config.name,
    EVENT_ADD_ON_LOADED,
    function (_, addonName)
        if addonName ~= Config.name then
            return
        end

        Initialize()
        EVENT_MANAGER:UnregisterForEvent(Config.name, EVENT_ADD_ON_LOADED)
    end
)

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
