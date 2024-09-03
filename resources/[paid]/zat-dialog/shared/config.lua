Config = {}

Config.Framework        = "esx" -- "qb"
Config.Inventory        = "ox" -- "ps", "qb", "ox", "qs"
Config.FrameworkPseudo  = 'ESX'
Config.Target           = "ox" -- ox !!!!!!!!! IMPORTANT
Config.UseInteract      = true
Config.Img              = 'ox_inventory/web/images/'
Config.SpawnPeds        = true -- set it to false if you spawn peds using another script
Config.Tax = 0.08;


-- just an example on how to use can interact.
-- as it is not possible to pass a function into json.
local function CanToggleSignIn()
    return true
end

Config.NPCs = {
    -- roofrunning
    {
        ped         = 'a_m_m_hillbilly_02',
        anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        coords      =  vector4(574.08, 133.01, 98.47, 249.26),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'RUFIS',
        lastname    = 'MDRID',
        rep         = 0,
        mission     = 'Roof Running',
        text        = 'Hey there, always on the lookout for a side gig, huh? I have got this idea that is a bit out there, but trust me, it pays off. Imagine sneaking onto rooftops, nabbing those AC units, and turning them into a sweet wad of cash, quick and discreet. what do you say? Insterested in a profitable adventure ?',
        buttons     = {
            {
                text= 'I want to work',
                rep = 0,
                answer ='Ready for a day of hard work?',
                buttons={{
                        text = 'yes',
                        shop =false,
                        rep = 0,
                        action= {
                            isServer= false,
                            event= 'zat-roofrunning:client:StartWorking',
                            data= {}
                        },
                        canInteract = CanToggleSignIn(),
                    },
                    {
                        text = 'Leave Conversation',
                        shop =false,
                        rep = 0,
                        action= {
                            isServer= false,
                            event= 'zat-dialog:client:HideUi',
                            data= {}
                        },
                        canInteract = true
                    }
                },
                canInteract = true
            },
            {
                text = 'Abandon Mission',
                rep = 0,
                shop =false,
                action= {
                    isServer= false,
                    event= 'zat-roofrunning:client:StopWorking',
                    data= {}
                },
                canInteract = true
            },
            {
                text = 'Join/Create Group',
                rep = 0,
                shop =false,
                action= {
                    isServer= false,
                    event= 'zat-groups:client:OpenUi',
                    data= {}
                },
                canInteract = true
            },
            {
                text    = 'Open Shop',
                rep = 0,
                shop    = true,
                answer  = null,
                canInteract = true
            },
        },
        items={
            {
                name   = 'screwdriver',
                label  = 'Screwdriver',
                image  = 'nui://'..Config.Img..'screwdriver.png',
                type   = 'Equipement',
                price  = 1000,
                rep    = 0,
                amount = 0, -- keep it 0
                info   = {},
                canInteract = true
            },        
        }
    }, 
    -- garbage
    {
        ped         = 's_m_y_garbage',
        anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        coords      =  vector4(-322.08, -1539.33, 26.73, 272.88),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'LEO',
        lastname    = 'EARTHWELL',
        rep         = 0,
        mission     = 'Garbage Job',
        text        = 'Nice To see you again, What can I do for you?',
        buttons     = {
            {
                text = 'Sign in/out',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'zat-garbagejob:client:ToggleSingin',
                    data= {}
                },
                canInteract = CanToggleSignIn(),
            },
            {
                text = 'Join/Create Group',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'zat-groups:client:OpenUi',
                    data= {}
                },
                canInteract = true
            },
            {
                text= 'I want to work',
                answer ='Ready for a day of hard work?',
                rep = 0,
                buttons={{
                        text = 'yes',
                        shop =false,
                        rep = 0,
                        action= {
                            isServer= false,
                            event= 'zat-garbagejob:client:StartWorking',
                            data= {}
                        },
                        canInteract = true
                    },
                    {
                        text = 'Leave Conversation',
                        shop =false,
                        rep = 0,
                        action= {
                            isServer= false,
                            event= 'zat-dialog:client:HideUi',
                            data= {}
                        },
                        canInteract = true
                    }
                },
                canInteract = true
            },
            {
                text = 'Work Clothes',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'zat-garbagejob:client:Clothes',
                    data= {}
                },
                canInteract = true
            },
            

        },
        items={}
    }, 
    -- snr buns
    {
        ped         = 'csb_burgerdrug',
        anim        = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
        coords      =  vector4(-504.14, -697.66, 32.67, 291.65),
        job         = "all", -- { ["police"] = 0, ["ambulance"] = 0}  if you are using target
        gang        = "all", -- { ["ballas"] = 2, ["thelostmc"] = 0}  if you are using target
        groups      = "all", -- { ["police"] = 2, ["ambulance"] = 0}  if you are using intearaction
        firstname   = 'MITCH',
        lastname    = 'BUN',
        rep         = 0,
        mission     = 'Snr Bun Worker',
        text        = 'Hey there, I do not think we have crossed paths before. I am Mitch, and I am in charge of the Snr Buns. You thinking about joining our crew ?',
        buttons     = {
            {
                text = 'Sign in/out',
                shop =false,
                rep = 0,
                action= {
                    isServer= true,
                    event= 'zat-snrbuns:server:ToggleSingin',
                    data = 1 -- first job in snrbuns Config.Jobs --> Config.Jobs[1] in Snr buns Script
                },
                canInteract = CanToggleSignIn(),
            },
            {
                text = 'Work Clothes',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'zat-snrbuns:client:Clothes',
                    data= {}
                },
                canInteract = true
            },
            {
                text = 'Leave Conversation',
                shop =false,
                rep = 0,
                action= {
                    isServer= false,
                    event= 'zat-dialog:client:HideUi',
                    data= {}
                },
                canInteract = true
            },
            

        },
        items={}
    }, 
}

