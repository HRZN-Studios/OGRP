EDITABLE = {}

---@return boolean
EDITABLE.CanOpenMDT = function()
    return not LocalPlayer.state.dead and not LocalPlayer.state.isHandcuffed
end

RegisterNetEvent('qf_mdt:esxBilling', function (zPlayersource, ConfigSocietyname, ConfigSocietylabel, datafine)
    TriggerServerEvent('esx_billing:sendBill', zPlayersource, ConfigSocietyname, ConfigSocietylabel, datafine)
end)

RegisterNetEvent('qf_mdt:pickleSent', function (zPlayersource, datajail)
    if Config.Jails.pickle_prisons then
        TriggerServerEvent("pickle_prisons:jailPlayer", zPlayersource, datajail) 
    end
end)

RegisterNetEvent('qf_mdt:brutalSend', function (zPlayersource, datareason, datajail)
    if Config.Jails.brutal_policejob_jail then
        TriggerServerEvent('brutal_policejob:server:policeMenuEvent', zPlayersource, 'jail', datajail, datareason)
    end
end)

RegisterNetEvent('qf_mdt:qbPrisonSend', function (zPlayersource, datajail)
    if Config.Jails.qb_prison then
        TriggerServerEvent('police:server:JailPlayer', zPlayersource, datajail)
    end
end)

RegisterNetEvent('qf_mdt:s7packJail', function (tgsrc, time, rsn)
    if Config.Jails.s7pack_jail then
        TriggerServerEvent('7pack-jail:jailPlayer', tgsrc, time, rsn)
    end
end)

RegisterNetEvent('qf-mdt:okokBilling', function (target, price, reason, invoiceSource, society, societyName)
    if Config.BillingScripts.okokBilling then
        TriggerServerEvent("okokBilling:CreateCustomInvoice", target, price, reason, invoiceSource, society, societyName)
    end
end)