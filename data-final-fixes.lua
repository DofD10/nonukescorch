-- Diese Datei wird beim starten des Spiels als drittes und letztes geladen. Hier ändert man Mods ab

if mods["AtomicArtillery"] then --definiert ob die Mod AtomicArtillery aktiviert ist und ändert dann die Nuklear Artillery ab

    local sounds = require("__base__.prototypes.entity.demo-sounds")

    require("__AtomicArtillery__.prototypes.entity.projectiles")

    data.raw["artillery-projectile"]["atomic-artillery-projectile"].action =
    {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                --Damage effects
                {
                    type = "nested-result",
                    action =
                    {
                        radius = 35, --same size as the shockwave to follow, needed to get auto-targeting to space shots correctly. Switched to fire because the thermal pulse is also a thing on nukes.
                        --Finally, by having this here, you get the radar update with everything dying like you expect with a nuke.
                        type = "area",
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "damage",
                                    damage = { amount = 1500, type = "fire" },
                                },
                            },
                        },
                    },
                },
                {
                    type = "destroy-cliffs",
                    radius = 9,
                    explosion = "explosion"
                },
                {
                    type = "nested-result",
                    action =
                    {
                        type = "area",
                        target_entities = false,
                        trigger_from_target = true,
                        repeat_count = 1000,
                        radius = 35,
                        action_delivery =
                        {
                            type = "projectile",
                            projectile = "atomic-bomb-wave",
                            starting_speed = 0.5 * 0.7,
                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                        }
                    }
                },
                {
                    type = "nested-result",
                    action =
                    {
                        type = "area",
                        target_entities = false,
                        trigger_from_target = true,
                        repeat_count = 1000,
                        radius = 7,
                        action_delivery =
                        {
                            type = "projectile",
                            projectile = "atomic-bomb-ground-zero-projectile",
                            starting_speed = 0.6 * 0.8,
                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                        }
                    }
                },
                --Sound effects
                {
                    type = "play-sound",
                    sound = sounds.nuclear_explosion_aftershock(0.4),
                    play_on_target_position = false,
                    -- min_distance = 200,
                    max_distance = 1000,
                    -- volume_modifier = 1,
                    audible_distance_modifier = 3
                },
                {
                    type = "play-sound",
                    sound = sounds.nuclear_explosion(0.9),
                    play_on_target_position = false,
                    -- min_distance = 200,
                    max_distance = 1000,
                    -- volume_modifier = 1,
                    audible_distance_modifier = 3
                },
                --Graphical effects
                {
                    type = "create-entity",
                    entity_name = "nuke-explosion"
                },
                {
                    type = "camera-effect",
                    effect = "screen-burn",
                    duration = 60,
                    ease_in_duration = 5,
                    ease_out_duration = 60,
                    delay = 0,
                    strength = 6,
                    full_strength_max_distance = 200,
                    max_distance = 800
                },
                {
                    type = "invoke-tile-trigger",
                    repeat_count = 1,
                },
                {
                    type = "destroy-decoratives",
                    include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                    include_decals = true,
                    invoke_decorative_trigger = true,
                    decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                    radius = 14 -- large radius for demostrative purposes
                },
                {
                    type = "nested-result",
                    action =
                    {
                        type = "area",
                        show_in_tooltip = false,
                        target_entities = false,
                        trigger_from_target = true,
                        repeat_count = 1000,
                        radius = 26,
                        action_delivery =
                        {
                            type = "projectile",
                            projectile = "atomic-bomb-wave-spawns-cluster-nuke-explosion",
                            starting_speed = 0.5 * 0.7,
                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                        }
                    }
                },
                {
                    type = "nested-result",
                    action =
                    {
                        type = "area",
                        show_in_tooltip = false,
                        target_entities = false,
                        trigger_from_target = true,
                        repeat_count = 700,
                        radius = 4,
                        action_delivery =
                        {
                            type = "projectile",
                            projectile = "atomic-bomb-wave-spawns-fire-smoke-explosion",
                            starting_speed = 0.5 * 0.65,
                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                        }
                    }
                },
                {
                    type = "nested-result",
                    action =
                    {
                        type = "area",
                        show_in_tooltip = false,
                        target_entities = false,
                        trigger_from_target = true,
                        repeat_count = 1000,
                        radius = 8,
                        action_delivery =
                        {
                            type = "projectile",
                            projectile = "atomic-bomb-wave-spawns-nuke-shockwave-explosion",
                            starting_speed = 0.5 * 0.65,
                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                        }
                    }
                },
                {
                    type = "nested-result",
                    action =
                    {
                        type = "area",
                        show_in_tooltip = false,
                        target_entities = false,
                        trigger_from_target = true,
                        repeat_count = 300,
                        radius = 26,
                        action_delivery =
                        {
                            type = "projectile",
                            projectile = "atomic-bomb-wave-spawns-nuclear-smoke",
                            starting_speed = 0.5 * 0.65,
                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                        }
                    }
                },
                {
                    type = "nested-result",
                    action =
                    {
                        type = "area",
                        show_in_tooltip = false,
                        target_entities = false,
                        trigger_from_target = true,
                        repeat_count = 10,
                        radius = 8,
                        action_delivery =
                        {
                            type = "instant",
                            target_effects =
                            {
                                {
                                    type = "create-entity",
                                    entity_name = "nuclear-smouldering-smoke-source",
                                    tile_collision_mask = { "water-tile" }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
end