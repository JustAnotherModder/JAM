JAM.Commands = {}
local JCMD = JAM.Commands

function JCMD:PrintPlayerPosition()
	if not self then return; end

	local plyPed = PlayerPedId()
	if not plyPed then return; end

	local plyPos = GetEntityCoords(plyPed)
	local plyHead = GetEntityHeading(plyPed)
	local plyRot = GetEntityRotation(plyPed, 2)
	if not plyPos or not plyHead or not plyRot then return; end

	TriggerEvent("chatMessage", "", {255, 0, 0}, "---" )
	TriggerEvent("chatMessage", "POSITION", {255, 0, 0}, "X = " .. math.floor(plyPos.x * 100)/100 .. " : Y = " .. math.floor(plyPos.y * 100)/100 .. " : Z = " .. math.floor(plyPos.z * 100)/100 )
	TriggerEvent("chatMessage", "ROTATION", {255, 0, 0}, "X = " .. math.floor(plyRot.x * 100)/100 .. " : Y = " .. math.floor(plyRot.y * 100)/100 .. " : Z = " .. math.floor(plyRot.z * 100)/100 )
	TriggerEvent("chatMessage", "HEADING", {255, 0, 0}, "H = " .. math.floor(plyHead * 100)/100 )
	TriggerEvent("chatMessage", "", {255, 0, 0}, "---" )
end

RegisterCommand('getpos', function(...) JCMD:PrintPlayerPosition(...); end)
