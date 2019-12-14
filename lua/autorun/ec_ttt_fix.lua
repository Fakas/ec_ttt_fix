-- Set up EC_TTT_Fix object
EC_TTT_Fix = {}
EC_TTT_Fix.__index = EC_TTT_Fix

-- Set up ConVars
CreateConVar("sv_ec_enforce", "1", FCVAR_NONE, "Enable Enhanced Camera dynamic height enforcement", 0, 1)

-- Set up commands
concommand.Add("sv_ec_dynamicheight_reset", function() EC_TTT_Fix:reset_dynamicheight() end, nil, "Reset dynamic height for all players with their current playermodel")

-- EC TTT Fix functions
function EC_TTT_Fix:enforce()
    -- Reset dynamic height for all players
    if GetConVar("sv_ec_enforce"):GetInt() == 1 then
        -- We have to set this 0 timer to ignore the gamemode from overriding our model changes
        timer.Simple(0.1, function() EC_TTT_Fix:reset_dynamicheight() end)
    end
end

function EC_TTT_Fix:reset_dynamicheight()
    RunConsoleCommand("sv_ec_dynamicheight", "0")
    RunConsoleCommand("sv_ec_dynamicheight", "1")
end

function EC_TTT_Fix:init()
    -- Initialise setup for EC_TTT_Fix
    hook.Add("PlayerSpawn", "EC_TTT_Fix", function(_) EC_TTT_Fix:enforce() end)
    print("EC_TTT_Fix: Done initialising Enhanced Camera TTT Fix!")
end

-- First time init
EC_TTT_Fix:init()
