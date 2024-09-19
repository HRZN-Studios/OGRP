EDITABLE = {}

---@return boolean
EDITABLE.CanOpenMDT = function()
    return not LocalPlayer.state.IsDead and not LocalPlayer.state.IsHandcuffed and not LocalPlayer.state.InTrunk
end

RegisterNetEvent('qf_mdt_ems:esxBilling', function (zPlayersource, ConfigSocietyname, ConfigSocietylabel, datafine)
    TriggerServerEvent('esx_billing:sendBill', zPlayersource, ConfigSocietyname, ConfigSocietylabel, datafine)
end)

RegisterNetEvent('qf-mdt:okokBilling', function (target, price, reason, invoiceSource, society, societyName)
    if Config.BillingScripts.okokBilling then
        TriggerServerEvent("okokBilling:CreateCustomInvoice", target, price, reason, invoiceSource, society, societyName)
    end
end)