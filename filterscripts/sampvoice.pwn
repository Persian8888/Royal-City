#include <a_samp>
#include <core>
#include <float>
#include <sampvoice>

#pragma tabsize 0

new SV_LSTREAM:lstream[MAX_PLAYERS] = { SV_NULL, ... };

public SV_VOID:OnPlayerActivationKeyPress(
	SV_UINT:playerid,
	SV_UINT:keyid
) {
	if (keyid == 0x42 && lstream[playerid]) SvAttachSpeakerToStream(lstream[playerid], playerid);
}

public SV_VOID:OnPlayerActivationKeyRelease(
	SV_UINT:playerid,
	SV_UINT:keyid
) {
	if (keyid == 0x42 && lstream[playerid]) SvDetachSpeakerFromStream(lstream[playerid], playerid);
}

public OnPlayerConnect(playerid) {

	if (!SvGetVersion(playerid)) SendClientMessage(playerid, 0xFF0000FF, "{FF0000}The Voice Plugin Is Not Installed.");
	else if (!SvHasMicro(playerid)) SendClientMessage(playerid, 0xFF0000FF, "{FF0000}The Voice Plugin Is Not Installed");
	else {
	    SendClientMessage(playerid, 0x00FF00FF, "{7FFFD4}The Voice Chat Is Installed.");
		lstream[playerid] = SvCreateDLStreamAtPlayer(40.0, SV_INFINITY, playerid, 0x00FF00FF, "L");
		SvAddKey(playerid, 0x42);
	}
	return 1;
	
}

public OnPlayerDisconnect(playerid, reason) {
	if (lstream[playerid]) {
		SvDeleteStream(lstream[playerid]);
		lstream[playerid] = SV_NULL;
	}
	return 1;
	
}
