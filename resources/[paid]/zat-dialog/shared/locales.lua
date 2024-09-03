local Locales = {
    ['dia_noe'] = "Not enough reputation ",
	['dia_rep'] = " rep required...",
	['dia_tal'] = "Talk",
	['dia_ncs'] = "Not Enough Cash",
	['dia_ncs'] = "Not Enough Cash",
	['dui_rep'] = "REP",
	['dui_ext'] = "Exit",
	['dui_esc'] = "ESC",
	['dui_eqp'] = "EQUIPEMENT",
	['dui_stt'] = "Subtotal",
	['dui_tax'] = "Tax",
	['dui_ttp'] = "Total Price",
	['dui_cur'] = "$",
	['dui_pvc'] = "Pay via Cash",
	['dui_mre'] = "My REP",
}

function _U(entry)
	return Locales[entry] 
end

function GetLocales()
	return Locales
end
