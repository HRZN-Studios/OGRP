Config = {}

--// if you are using other / custom framework, set both framework to false and edit framework functions in server/framework.lua and client/framework.lua

Config.Language = 'en' --// Supported languages ['en' - English/US | 'fr' - French | 'pl' - Polish | 'de' - Deutsch | 'es' - Spanish]

Config.Society = { --// Society name, percents configs to receive after sending to jail or giving a fines
    name = "society_police",
    jobname = "police",
    label = "LSPD",
    percentToPoliceJob = 0.80,
    percentToPoliceMan = 0.20,
}

Config.SocietyScripts = { --// Society scripts are you use, if you use another then make it all false, and go to EDITABLE files
    esx_society = false,
    qb_management = false,
    qb_banking = false,
    bcs_CompanyManager = false,
}

Config.BillingScripts = {
    okokBilling = false,
    codemBilling = false,
    zerio_invoice = false,
    esx_billing = false,
    qs_billing = false,
    cs_billing = false,
}

Config.Banks = {
    qf_banking = false,
    okokBanking = false,
    codeMBanking = false,
    brutal_banking = false,
}

Config.Phones = {
    hype_phone = false,
    qs_smartphone = false,
    qs_smartphone_pro = false,
    yflip_phone = false,
    lb_phone = false,
    qb_phone = false,
    gks_phone = false,
    road_phone = false,
    npwd_phone = false,
    okok_phone = false,
}

Config.Licenses = {
    bcs_license = false,
    esx_license = true,
    qb_license = false,
    buty_license = false,
}

Config.MaxDistanceToJailFine = 15 --// Maximum distance for send player to jail or give fine

Config.OneFile = false --// If you want Citizen List / Car list in One or Seperate categories in MDT
Config.ShowRadio = true --// IF you want to radio channel will be seen in polcelist
Config.ShowNearest = true --// If you want to have button "nearest" in citizen files or car files

Config.UsingRadio = {
    pma_voice = true,
}

Config.Jobs = {
    OneJob = false, -- // If you want to seperate each job to have diffrent job list and dispatch set it to TRUE, if you want anyone that has access to have same job list and dispatch set to FALSE 
    OnDuty = {
        ['police'] = true, --// Job name to access to MDT
    },
    KickDuty = {
        name = 'unemployed', --// Job name to set after kick from duty
        Grade = {
            grade = 0, --// Grade number to set after kick from duty if you are using option "set_grade = true"
            set_grade = true, --// Set new grade to player
            same_grade = false, --// Set same grade to player what have
        }
    },
    AccessCode = {
        command = 'code',
        fromGrade = 4
    },
    AccessToManagementFunctions = {
        fromGrade = 4
    },
    ShowHours = true,
    ResetHours = 5,
}

Config.MessageColors = { --// Colors in RGB for /code command 
    BlackCode = {20, 20, 20},
    RedCode = {255, 0, 0},
    OrangeCode = {255, 123, 0},
    GreenCode = {120, 255, 120},
}

Config.ToggleMDT = {
    key = 'DELETE', --// Command default bind key
    commandName = 'mdtlspd', --// Command name
    keymappingLabel = 'Open tablet [LSPD]' --// Command Label in Keymapping
}

Config.Frameworks = {
    ESX = {
        enabled = true, --// if you are using esx, set it to true
        frameworkScript = 'es_extended',
        frameworkExport = 'getSharedObject'
    },
    QB = {
        enabled = false, --// if you are using qb-core, set it to true
        frameworkScript = 'qb-core',
        frameworkExport = 'GetCoreObject'
    }
}

Config.Properties = {
    qb_apartments = false, --// if you are using qb-apartments, set it to true
    esx_property_old = false, --// if you are using esx_property [not newest using SQL], set it to true
    esx_property_legacy = true, --// if you are using esx_property [newest using JSON], set it to true
    qs_housing = false, --// if you are using qs_housing, set it to true
    loaf_housing = false, --// if you are using loaf_housing, set it to true
    bcs_housing = false, --// if you are using bcs_housing, set it to true
    nolag_properties = false, --// if you are using nolag_properties, set it to true
    ps_housing = false, --// if you are using ps-housing, set it to true
    rx_housing = true, --// if you are using rx_housing, set it to true
}

Config.BlockSettings = {
    blockSettings = false,
    blockSettingsGrade = 0,
}

Config.Dispatch = {
    qf_dispatch = true,
    cd_dispatch = false,
    linden_dispatch = false,
    qs_dispatch = false,
    rcore_dispatch = false,
    ps_dispatch = false, -- // If you want to receive notfies in MDT qf_dispatch, notif_dispatch and Config.NotifDispatchAlerts must be true
    notif_dispatch = true, -- // TriggerClientEvent('qf_mdt:addDispatchAlert', -1, coords, 'title', 'subtitle', 'code f.e. 10-90', 'rgb(255, 0, 255)', '10 - max number of people that can response if you dont want it, set it to 0')

    IgnoredJobs = {
        "police",
    }
}

Config.NotifDispatchAlerts = true -- // If you have turn on notif_dispatch (if you don't it wouldnt work), and you add alert to mdt, player would be notifited abt it on top right corner

-- // Only works if you are using qf_dispatch then make sure the value in Config.Dispatch -> qf_dispatch is true
Config.DefaultAlertsDelay = 6

Config.DefaultAlerts = {
    Speeding = true,
    Shooting = true,
    Autotheft = true,
    Melee = true,
    PlayerDowned = true
}

Config.WeaponBlacklist = {
    'WEAPON_GRENADE',
    'WEAPON_BZGAS',
    'WEAPON_MOLOTOV',
    'WEAPON_STICKYBOMB',
    'WEAPON_PROXMINE',
    'WEAPON_SNOWBALL',
    'WEAPON_PIPEBOMB',
    'WEAPON_BALL',
    'WEAPON_SMOKEGRENADE',
    'WEAPON_FLARE',
    'WEAPON_PETROLCAN',
    'WEAPON_FIREEXTINGUISHER',
    'WEAPON_HAZARDCAN',
    'WEAPON_RAYCARBINE',
    'WEAPON_STUNGUN'
}

Config.Jails = {
    -- // pickle_prisons
    pickle_prisons = false,
    pickle_prisons_jailName = "default",
    -- // rcore_prison
    rcore_prison = false,
    -- // brutal_policejob_jail
    brutal_policejob_jail = false,
    -- // qb_prison
    qb_prison = false,
    -- // esx_jailer [xlem0n version]
    esx_jailer_xlem0n = false,
    -- // esx_jailer [qalle version]
    esx_qalle_jail = false,
    s7pack_jail = false,
    tk_jail = false,
    u_jail = false,
    -- // If you are using other Jail System contact with us we are and we'll help you add your jail trigger to MDT very quickly :3
}

Config.ShowBadgeSystem = false

Config.Sounds = {
    Default = { -- // PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
        use = true,
        frontArgs1 = "Mission_Pass_Notify",
        frontArgs2 = "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS",
    },
    Custom = { -- // Custom sound from your file with .ogg extension from sounds folder
        use = false,
        triggerName = "InteractSound_CL:PlayOnOne", --//InteractSound event name
        fileName = "demo", --//InteractSound filename
        volume = 0.2, --//InteractSound sound volume
    }
}

Config.GenderTable = {
    sqlUserName = 'sex', -- How you have named gender table in users (f.e. sex or gender) !!!!! SKIP THIS PART IF YOU HAVE QBCORE
    sqlNames = {
        ['male'] = 'm', -- If you have in users data f.e. "1" as male set it to "1" or just 1 depends on what data you use, if you have "m" set it to "m" and so on.
        ['female'] = 'f', -- If you have in users data f.e. "0" as female set it to "0" or just 0 depends on what data you use, if you have "f" set it to "f" and so on.
    }
}

Config.CitizenLicenses = {
    {
        sqlName = 'drive',
        isText = true, -- If you want icon set it to false, if you want text, set it to true!
        translateLicense = 'B', -- If "isText" is false set it to => ""!
        licenseIcon = '', -- search here => https://fontawesome.com/icons // If "isText" is true set it to => ""
    },
    {
        sqlName = 'drive_bike',
        isText = true, -- If you want icon set it to false, if you want text, set it to true!
        translateLicense = 'A', -- If "isText" is false set it to => ""
        licenseIcon = '', -- search here => https://fontawesome.com/icons // If "isText" is true set it to => ""
    },
    {
        sqlName = 'drive_truck',
        isText = true, -- If you want icon set it to false, if you want text, set it to true!
        translateLicense = 'C', -- If "isText" is false set it to => ""
        licenseIcon = '', -- search here => https://fontawesome.com/icons // If "isText" is true set it to => ""
    },
    {
        sqlName = 'weapon',
        isText = false, -- If you want icon set it to false, if you want text, set it to true!
        translateLicense = '', -- If "isText" is false set it to => ""!
        licenseIcon = 'fa-solid fa-gun', -- search here => https://fontawesome.com/icons // If "isText" is true set it to => ""
    },
}

Config.Colours = {
    ['0'] = "Metallic Black",
    ['1'] = "Metallic Graphite Black",
    ['2'] = "Metallic Black Steel",
    ['3'] = "Metallic Dark Silver",
    ['4'] = "Metallic Silver",
    ['5'] = "Metallic Blue Silver",
    ['6'] = "Metallic Steel Gray",
    ['7'] = "Metallic Shadow Silver",
    ['8'] = "Metallic Stone Silver",
    ['9'] = "Metallic Midnight Silver",
    ['10'] = "Metallic Gun Metal",
    ['11'] = "Metallic Anthracite Grey",
    ['12'] = "Matte Black",
    ['13'] = "Matte Gray",
    ['14'] = "Matte Light Grey",
    ['15'] = "Util Black",
    ['16'] = "Util Black Poly",
    ['17'] = "Util Dark silver",
    ['18'] = "Util Silver",
    ['19'] = "Util Gun Metal",
    ['20'] = "Util Shadow Silver",
    ['21'] = "Worn Black",
    ['22'] = "Worn Graphite",
    ['23'] = "Worn Silver Grey",
    ['24'] = "Worn Silver",
    ['25'] = "Worn Blue Silver",
    ['26'] = "Worn Shadow Silver",
    ['27'] = "Metallic Red",
    ['28'] = "Metallic Torino Red",
    ['29'] = "Metallic Formula Red",
    ['30'] = "Metallic Blaze Red",
    ['31'] = "Metallic Graceful Red",
    ['32'] = "Metallic Garnet Red",
    ['33'] = "Metallic Desert Red",
    ['34'] = "Metallic Cabernet Red",
    ['35'] = "Metallic Candy Red",
    ['36'] = "Metallic Sunrise Orange",
    ['37'] = "Metallic Classic Gold",
    ['38'] = "Metallic Orange",
    ['39'] = "Matte Red",
    ['40'] = "Matte Dark Red",
    ['41'] = "Matte Orange",
    ['42'] = "Matte Yellow",
    ['43'] = "Util Red",
    ['44'] = "Util Bright Red",
    ['45'] = "Util Garnet Red",
    ['46'] = "Worn Red",
    ['47'] = "Worn Golden Red",
    ['48'] = "Worn Dark Red",
    ['49'] = "Metallic Dark Green",
    ['50'] = "Metallic Racing Green",
    ['51'] = "Metallic Sea Green",
    ['52'] = "Metallic Olive Green",
    ['53'] = "Metallic Green",
    ['54'] = "Metallic Gasoline Blue Green",
    ['55'] = "Matte Lime Green",
    ['56'] = "Util Dark Green",
    ['57'] = "Util Green",
    ['58'] = "Worn Dark Green",
    ['59'] = "Worn Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Metallic Midnight Blue",
    ['62'] = "Metallic Dark Blue",
    ['63'] = "Metallic Saxony Blue",
    ['64'] = "Metallic Blue",
    ['65'] = "Metallic Mariner Blue",
    ['66'] = "Metallic Harbor Blue",
    ['67'] = "Metallic Diamond Blue",
    ['68'] = "Metallic Surf Blue",
    ['69'] = "Metallic Nautical Blue",
    ['70'] = "Metallic Bright Blue",
    ['71'] = "Metallic Purple Blue",
    ['72'] = "Metallic Spinnaker Blue",
    ['73'] = "Metallic Ultra Blue",
    ['74'] = "Metallic Bright Blue",
    ['75'] = "Util Dark Blue",
    ['76'] = "Util Midnight Blue",
    ['77'] = "Util Blue",
    ['78'] = "Util Sea Foam Blue",
    ['79'] = "Uil Lightning blue",
    ['80'] = "Util Maui Blue Poly",
    ['81'] = "Util Bright Blue",
    ['82'] = "Matte Dark Blue",
    ['83'] = "Matte Blue",
    ['84'] = "Matte Midnight Blue",
    ['85'] = "Worn Dark blue",
    ['86'] = "Worn Blue",
    ['87'] = "Worn Light blue",
    ['88'] = "Metallic Taxi Yellow",
    ['89'] = "Metallic Race Yellow",
    ['90'] = "Metallic Bronze",
    ['91'] = "Metallic Yellow Bird",
    ['92'] = "Metallic Lime",
    ['93'] = "Metallic Champagne",
    ['94'] = "Metallic Pueblo Beige",
    ['95'] = "Metallic Dark Ivory",
    ['96'] = "Metallic Choco Brown",
    ['97'] = "Metallic Golden Brown",
    ['98'] = "Metallic Light Brown",
    ['99'] = "Metallic Straw Beige",
    ['100'] = "Metallic Moss Brown",
    ['101'] = "Metallic Biston Brown",
    ['102'] = "Metallic Beechwood",
    ['103'] = "Metallic Dark Beechwood",
    ['104'] = "Metallic Choco Orange",
    ['105'] = "Metallic Beach Sand",
    ['106'] = "Metallic Sun Bleeched Sand",
    ['107'] = "Metallic Cream",
    ['108'] = "Util Brown",
    ['109'] = "Util Medium Brown",
    ['110'] = "Util Light Brown",
    ['111'] = "Metallic White",
    ['112'] = "Metallic Frost White",
    ['113'] = "Worn Honey Beige",
    ['114'] = "Worn Brown",
    ['115'] = "Worn Dark Brown",
    ['116'] = "Worn straw beige",
    ['117'] = "Brushed Steel",
    ['118'] = "Brushed Black Steel",
    ['119'] = "Brushed Aluminium",
    ['120'] = "Chrome",
    ['121'] = "Worn Off White",
    ['122'] = "Util Off White",
    ['123'] = "Worn Orange",
    ['124'] = "Worn Light Orange",
    ['125'] = "Metallic Securicor Green",
    ['126'] = "Worn Taxi Yellow",
    ['127'] = "Police Car Blue",
    ['128'] = "Matte Green",
    ['129'] = "Matte Brown",
    ['130'] = "Worn Orange",
    ['131'] = "Matte White",
    ['132'] = "Worn White",
    ['133'] = "Worn Olive Army Green",
    ['134'] = "Pure White",
    ['135'] = "Hot Pink",
    ['136'] = "Salmon pink",
    ['137'] = "Metallic Vermillion Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Mettalic Black Blue",
    ['142'] = "Metallic Black Purple",
    ['143'] = "Metallic Black Red",
    ['144'] = "hunter green",
    ['145'] = "Metallic Purple",
    ['146'] = "Metallic Dark Blue",
    ['147'] = "Black",
    ['148'] = "Matte Purple",
    ['149'] = "Matte Dark Purple",
    ['150'] = "Metallic Lava Red",
    ['151'] = "Matte Forest Green",
    ['152'] = "Matte Olive Drab",
    ['153'] = "Matte Desert Brown",
    ['154'] = "Matte Desert Tan",
    ['155'] = "Matte Foilage Green",
    ['156'] = "Default Alloy Color",
    ['157'] = "Epsilon Blue",
    ['158'] = "Pure Gold",
    ['159'] = "Brushed Gold",
    ['160'] = "MP100"
}