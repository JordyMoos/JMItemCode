
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
--    local array = {ZO_LinkHandler_ParseLink(itemLink)}
--    array[6] = 0 -- Looted from
--    array[20] = 0 -- Crafted
--    array[22] = 0 -- Stolen
--    array[23] = 0 -- Condition
--
--    return table.concat(array, '_')


---[[

    local _, setName, setBonusCount, _ = GetItemLinkSetInfo(itemLink)
    local glyphMinLevel, glyphMaxLevel, glyphMinVetLevel, glyphMaxVetLevel = GetItemLinkGlyphMinMaxLevels(itemLink)
    local _, enchantHeader, _ = GetItemLinkEnchantInfo(itemLink)
    local hasAbility, abilityHeader, _ = GetItemLinkOnUseAbilityInfo(itemLink)
    local traitType, _ = GetItemLinkTraitInfo(itemLink)
    local craftingSkillRank = GetItemLinkRequiredCraftingSkillRank(itemLink)

    local abilityInfo = abilityHeader
    if not hasAbility then
        for i = 1, GetMaxTraits() do
            local hasTraitAbility, traitAbilityDescription, _ = GetItemLinkTraitOnUseAbilityInfo(itemLink, i)
            if(hasTraitAbility) then
                abilityInfo = abilityInfo .. ':' .. traitAbilityDescription
            end
        end
    end

    return string.format(
        '%s_%s_%s_%s_%s_' .. '%s_%s_%s_%s_%s_' .. '%s_%s_%s_%s_%s_' .. '%s_%s',

        GetItemLinkQuality(itemLink),
        GetItemLinkRequiredLevel(itemLink),
        GetItemLinkRequiredVeteranRank(itemLink),
        GetItemLinkWeaponPower(itemLink),
        GetItemLinkArmorRating(itemLink),

        GetItemLinkValue(itemLink),
        GetItemLinkMaxEnchantCharges(itemLink),
        setName,
        glyphMinLevel or '',
        glyphMaxLevel or '',

        glyphMinVetLevel or '',
        glyphMaxVetLevel or '',
        enchantHeader,
        traitType or '',
        setBonusCount or '',

        craftingSkillRank,
        abilityInfo
    )
---]]--
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
