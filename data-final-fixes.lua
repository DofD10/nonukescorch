local remove_nuclear_ground_effect = function(projectile)
    local is_nuclear_ground_effect = function(effect)
        local to_remove = {
            {key="type", value="set-tile"},
            {key="type", value="create-decorative"},
        }
        for _, f in ipairs(to_remove) do
            if (effect[f.key] == f.value) then
                return true
            end
        end
        return false
    end

    local effects = {}
    for _, effect in ipairs(projectile.action.action_delivery.target_effects) do
        if not is_nuclear_ground_effect(effect) then
            table.insert(effects, effect)
        end
    end
    projectile.action.action_delivery.target_effects = effects
end


remove_nuclear_ground_effect(data.raw["projectile"]["atomic-rocket"])

if mods["AtomicArtillery"] then
    require("__AtomicArtillery__.prototypes.entity.projectiles")
    remove_nuclear_ground_effect(data.raw["artillery-projectile"]["atomic-artillery-projectile"])
end
