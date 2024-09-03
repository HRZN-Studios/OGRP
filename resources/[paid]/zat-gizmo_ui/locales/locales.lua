local Locales = {
	['ui_rota'] = "Rotate",
	['ui_tran'] = "Translate",
	['ui_plac'] = "Place",
	['ui_grnd'] = "Ground",
	['ui_teup'] = "Position your object and press G to ensure it's properly aligned with the ground.",
	['ui_tedo'] = "You can adjust its position later by selecting the object directly.",
	['ui_canc'] = "Cancel",
	['ui_conf'] = "Confirm",
}

function _U(entry)
	return Locales[entry] 
end

function GetLocales()
	return Locales
end