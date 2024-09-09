Config = { }

Config.Framework = {
    FrameworkName = 'ESX', -- ESX, QBCore or Standalone
    QBCoreFileName = 'qb-core', 
    OldESX = false, -- If you are using an old version of ESX set this to true
    ESXEvent = 'esx:getSharedObject',
    ESXObject = 'es_extended',
    SQLWrapper = 'oxmysql' --  oxmysql / mysql-async / ghmattimysql
}

Config.Keybinds = {
    OpenChat = 245, -- Normally it is the "T" -> https://docs.fivem.net/docs/game-references/controls/
    ChangeVisibility = 182 -- Normally it is the "L" -> https://docs.fivem.net/docs/game-references/controls/
}

Config.ProximityCheck = 3.0 -- The distance from where they will read your messages if you set "Proximity = true,"

Config.Shortcuts = {'me', 'do', 'e'} -- You can put all the Shortcuts you want, copy and paste

Config.PopUpCharAdd = 0.2 -- Time that will be added to the popup display time per character (in seconds)

Config.ChatDisappearTimeout = 5000 -- The time it takes for the chat to disappear from the screen (in seconds)

Config.UseStaffLabel = true -- If you want a "STAFF" label to appear in front of the names of administrators when they write in chat

Config.ShowIdForAll = true -- If you set it to true, the ID will appear in all messages that people write, and everyone will see it. If you set it to false, only administrators will see the ID

Config.AutoMessages = { -- Automatic messages that will appear in the chat automatically at the time you set.
    -- {
    --     Interval = 300,
    --     Message = "Remember to read the rules"
    -- },
}

Config.PopupDistance = 25 -- If you enable the head POPUP in any command, this will be the distance at which the POPUP will be visible. If you don't use it, forget about this

Config.UseWordsBlacklist = true -- If you set it to true, there will be a list of prohibited words, and anyone using one of these words will be muted
Config.BlacklistTimeout = 300 -- The duration of the mute that will be applied to each player who uses a bad word
Config.WordsBlacklist = { -- You can add as many words as you want
    "badword", "flameword", "toxicword"
}

Config.LongMessageMute = true -- If you set this to true, it will automatically mute people who write messages that are too long. Designed to prevent TROLLS or SPAWM
Config.LongMessageTimeout = 5 -- The muted time of the offender
Config.LongMessageMaxLength = 30 -- The words that will be considered "too long"

Config.SpamMessageMute = true -- If they put too many chats in a row, they can be muted by SPAWN
Config.SpamMessageTimeout = 5 -- The muted time of the offender
Config.SpamMessageInSeconds = 5 -- is a "time window"
Config.SpamMessageMaxCount = 5 -- is how many messages are possible to send before mute, for example, in your case, if user sends more than 5 messages in 5 seconds he will get muted

Config.BlockSendingLinks = true -- If you set it to true, people won't be able to send links.

Config.Commands = {
    {
        Command = 'me',
        Label = '<strong>ME</strong>',
        Proximity = true,
        ShowPopUp = true,
        Style = {
            LabelBoxContainer = '0px 0px 10px rgba(255, 194, 122, 0.4)',
            LabelBoxBackground = 'linear-gradient(270deg, rgba(255, 168, 0, 0) 0%, rgba(255, 168, 0, 0.228) 46.31%)',
            LabelBoxBorder = '1px solid rgba(255, 168, 0, 0.4)'
        },
        Help = {
            Title = 'Message',
            Subtitle = 'The message you would like to send as a me'
        }
    },
    {
        Command = 'do',
        Label = '<strong>DO</strong>',
        Proximity = true,
        ShowPopUp = true,
        Style = {
            LabelBoxContainer = '0px 0px 10px rgba(0, 194, 255, 0.4)',
            LabelBoxBackground = 'linear-gradient(270deg, rgba(0, 179, 255, 0) 0%, rgba(0, 209, 255, 0.228) 46.31%)',
            LabelBoxBorder = '1px solid rgba(0, 209, 255, 0.4)'
        },
        Help = {
            Title = 'Message',
            Subtitle = 'The message you would like to send as a do'
        }
    },
    {
        Command = 'announce',
        Label = 'Announce <strong>server</strong>',
        Role = 'Server',
        AdminOnly = true,
        AdminCheck = {
            Global = true,
            Ranks = { 'god', 'superadmin' }
        },
        Style = {
            Background = 'linear-gradient(270deg, rgba(182, 255, 148, 0.216) 0%, rgba(96, 94, 94, 0.248) 99.18%)',
            Border = '1px solid #b6ff94',
            AuthorColor = '#b6ff94',
            LabelBoxContainer = '0px 0px 10px rgba(182, 255, 148, 0.4)',
            LabelBoxBackground = 'linear-gradient(270deg, rgba(182, 255, 148, 0) 0%, rgba(182, 255, 148, 0.228) 46.31%)',
            LabelBoxBorder = '1px solid rgba(182, 255, 148, 0.4)'
        },
        Help = {
            Title = 'Global',
            Subtitle = 'The message you would like to send as globally'
        }
    },
    {
        Command = 'ooc',
        Label = '<strong>OOC</strong>',
        JobLabel = true,
        ColorJobLabel = 'black',
        Style = {
            LabelBoxContainer = '0px 0px 10px rgba(255, 255, 255, 0.4)',
            LabelBoxBackground = 'linear-gradient(270deg, rgba(139, 139, 139, 0) 0%, rgba(128, 128, 128, 0.228) 46.31%)',
            LabelBoxBorder = '1px solid rgba(143, 143, 143, 0.4)'
        },
        Help = {
            Title = 'Global',
            Subtitle = 'The message you would like to send as globally'
        }
    },
    
    -- [!!] Here below you have all the variables that you can use to create your command. You can create all the commands you want. [!!]

    -- {
    --     Command = 'help', -- This will be the command
    --     Label = '<strong>HELP</strong>', -- The name that will appear on the label
    --     Role = 'Help', -- In case you want something to appear in front of the player's name
    --     JobLabel = true, -- -- This will add in front of the player's name, a label with their work
    --     ColorJobLabel = 'black', -- -- The color with which the label of the player's job will appear 
    --     PlayerName = 'RP', -- RP / Steam / None
    --     Proximity = true, -- If you set it to true, only people who are nearby will see the message
    --     Style = { -- Here you modify the entire design of the rectangle that accompanies the message
    --         Background = 'linear-gradient(270deg, rgba(0, 0, 0, 0.136) 0%, rgba(0, 0, 0, 0.4) 99.18%)',
    --         Border = '1px solid rgba(0, 0, 0, 0.18)',
    --         AuthorColor = '#b6ff94',
    --         LabelBoxContainer = '0px 0px 10px rgba(250, 250, 250, 0.4)',
    --         LabelBoxBackground = 'linear-gradient(270deg, rgba(0, 0, 0, 0) 0%, rgba(0, 0, 0, 0.228) 46.31%)',
    --         LabelBoxBorder = '1px solid rgba(0, 0, 0, 0.4)'
    --     },
    --     JobCheck = { -- In case you want to have a job to send the message, if you don't want this, you will have to delete it
    --         Global = true, -- If you put true, the message will be seen by everyone, if you put false, only whoever has the job will see it, being like an internal chat
    --         Jobs = { 'ambulance' }
    --     },
    --     AdminOnly = true, -- This is in case you don't want to split between different ranges. Only all the STAFF will be able to use the command. If you want something more concrete, use the variable below.
    --     AdminCheck = { -- Check if the player is admin, to perform different actions that I explain below
    --         Global = true, -- If set to true, the written message will be read by everyone. If you put false, it will only be read by someone with the correct admin rank.
    --         Ranks = { 'god', 'superadmin' } -- Here you will put the rank of administrator that you want to be able to write the command. Either a single range or several. You can put the range you want or use.
    --},
    --     Help = { -- The information that people will see when typing the command
    --         Title = 'Help Text',
    --         Subtitle = 'Ask the community for help'
    --     }
    -- },
}