function SendToDiscord(message)
    local embed = {
        {
            ['title'] = 'New chat log',
            ['description'] = message
        }
    }
--ADD YOUR DISCORD WEBHOOK HERE. Inside the '' you see after PerformHttpRequest(
    PerformHttpRequest('', function(err, text, headers) end, 'POST', json.encode({
        username = 'Chat Logs', embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end

-- CONVERT THE SCRIPT TO YOUR FRAMEWORK. The functions below will be activated when you put FrameworkName = "Standalone"

function Custom_CheckIfStaff(source)
-- Put the function of your framework that checks if you are Administrator
end

function Custom_GetPlayerRPName(source)
-- Put the function of your framework that gives the name of your character
end

function Custom_GetPlayerJobName(source)
-- Put the function of your framework that gives the name of your job
end

function Custom_GetPlayerJobLabel(source)
-- Put the function of your framework that gives the label of your job
end