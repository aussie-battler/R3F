

/**
 * Passe la variable R3F_LOG_joueur_deplace_objet à objNull pour informer le script "deplacer" d'arrêter de déplacer l'objet
 */
 
private _foundTrader = false;

if (R3F_LOG_mutex_local_verrou) then
{
    hintC STR_R3F_LOG_mutex_action_en_cours;
}
else
{
    R3F_LOG_mutex_local_verrou = true;
    
    {
        _foundTrader = true;
    } forEach nearestObjects [player, ["Exile_Trader_WasteDump"], 12];

    if (_foundTrader) then {
    
        private _crate = R3F_LOG_joueur_deplace_objet;
        private _cargo = _crate call ExileClient_util_containerCargo_list;    
        private _revenue = _cargo call ExileClient_util_gear_calculateTotalSellPrice;
        
        clearWeaponCargoGlobal         _crate;
        clearItemCargoGlobal         _crate;
        clearMagazineCargoGlobal     _crate;
        clearBackpackCargoGlobal     _crate;
        
        private _cash = _crate getVariable ["ExileMoney", 0];
    
        _crate setVariable ["ExileMoney",_revenue+_cash, true];
        
        R3F_LOG_joueur_deplace_objet = objNull;
        sleep 0.25;
    
        R3F_LOG_mutex_local_verrou = false;
        
        ["SuccessTitleAndText", ["Crate Cargo Sold", format["Cargo was sold for %1 Poptabs. THE POPTABS ARE IN THE CRATE. Crate will self destruct in 2 minutes!", _revenue]]] call ExileClient_gui_toaster_addTemplateToast;
        
        sleep 120;
        deleteVehicle _crate;
    
    } else {
    
        R3F_LOG_joueur_deplace_objet = objNull;
        sleep 0.25;
    
        R3F_LOG_mutex_local_verrou = false;
    };
};
