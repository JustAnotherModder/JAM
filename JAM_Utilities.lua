JAM.Utilities = {}
JUtils = JAM.Utilities

JUtils.Keys = {
  ["ESC"]       = 322,  ["F1"]        = 288,  ["F2"]        = 289,  ["F3"]        = 170,  ["F5"]  = 166,  ["F6"]  = 167,  ["F7"]  = 168,  ["F8"]  = 169,  ["F9"]  = 56,   ["F10"]   = 57, 
  ["~"]         = 243,  ["1"]         = 157,  ["2"]         = 158,  ["3"]         = 160,  ["4"]   = 164,  ["5"]   = 165,  ["6"]   = 159,  ["7"]   = 161,  ["8"]   = 162,  ["9"]     = 163,  ["-"]   = 84,   ["="]     = 83,   ["BACKSPACE"]   = 177, 
  ["TAB"]       = 37,   ["Q"]         = 44,   ["W"]         = 32,   ["E"]         = 38,   ["R"]   = 45,   ["T"]   = 245,  ["Y"]   = 246,  ["U"]   = 303,  ["P"]   = 199,  ["["]     = 39,   ["]"]   = 40,   ["ENTER"]   = 18,
  ["CAPS"]      = 137,  ["A"]         = 34,   ["S"]         = 8,    ["D"]         = 9,    ["F"]   = 23,   ["G"]   = 47,   ["H"]   = 74,   ["K"]   = 311,  ["L"]   = 182,
  ["LEFTSHIFT"] = 21,   ["Z"]         = 20,   ["X"]         = 73,   ["C"]         = 26,   ["V"]   = 0,    ["B"]   = 29,   ["N"]   = 249,  ["M"]   = 244,  [","]   = 82,   ["."]     = 81,
  ["LEFTCTRL"]  = 36,   ["LEFTALT"]   = 19,   ["SPACE"]     = 22,   ["RIGHTCTRL"] = 70, 
  ["HOME"]      = 213,  ["PAGEUP"]    = 10,   ["PAGEDOWN"]  = 11,   ["DELETE"]    = 178,
  ["LEFT"]      = 174,  ["RIGHT"]     = 175,  ["UP"]        = 27,   ["DOWN"]      = 173,
  ["NENTER"]    = 201,  ["N4"]        = 108,  ["N5"]        = 60,   ["N6"]        = 107,  ["N+"]  = 96,   ["N-"]  = 97,   ["N7"]  = 117,  ["N8"]  = 61,   ["N9"]  = 118
}

function JUtils.PointOnSphere(alt,azu,radius,orgX,orgY,orgZ)
  local toradians = 0.017453292384744
  alt,azu,radius,orgX,orgY,orgZ = ( tonumber(alt or 0) or 0 ) * toradians, ( tonumber(azu or 0) or 0 ) * toradians, tonumber(radius or 0) or 0, tonumber(orgX or 0) or 0, tonumber(orgY or 0) or 0, tonumber(orgZ or 0) or 0
  if      vector3
  then
      return
      vector3(
           orgX + radius * math.sin( azu ) * math.cos( alt ),
           orgY + radius * math.cos( azu ) * math.cos( alt ),
           orgZ + radius * math.sin( alt )
      )
  end
end

function JUtils.ClampCircle(x,y,radius)
  x      = ( tonumber(x or 0)      or 0 )
  y      = ( tonumber(y or 0)      or 0 )
  radius = ( tonumber(radius or 0) or 0 )
  local d = math.sqrt(x*x+y*y)
  d = radius / d
  if d < 1 then x = x * (d/radius)*radius; y = y * (d/radius)*radius; end
  return x,y
end

function JUtils.GetHashKey(strToHash)
  if type(strToHash) == "number" then return strToHash; end;
  return GetHashKeyPrev(tostring(strToHash or "") or "")%0x100000000;
end
GetHashKeyPrev = GetHashKeyPrev or GetHashKey
GetHashKey     = JUtils.GetHashKey

function JUtils:FindNearestZone(position, table)
  if type(table) ~= 'table' or type(position) ~= 'vector3' then return 999999; end  
  local closestZone,closestAction,closestDist,closestCoords
  for _,zone in pairs(table) do
    if zone.Positions then 
      for act,pos in pairs(zone.Positions) do
        if type(pos) == 'vector3' then
          local curDist = JUtils:GetVecDist(position, pos)
          if not closestDist or curDist < closestDist then
            closestZone,closestAction,closestDist,closestCoords = zone,act,curDist,pos
          end
        end
      end
    end
  end
  return closestZone,closestAction,closestDist,closestCoords
end

function JUtils.GetXYDist(x1,y1,z1,x2,y2,z2)
  return math.sqrt(  ( (x1 or 0) - (x2 or 0) )*(  (x1 or 0) - (x2 or 0) )+( (y1 or 0) - (y2 or 0) )*( (y1 or 0) - (y2 or 0) )+( (z1 or 0) - (z2 or 0) )*( (z1 or 0) - (z2 or 0) )  )
end

function JUtils.GetV2Dist(v1, v2)
  if not v1 or not v2 or not v1.x or not v2.x or not v1.y or not v2.y then return 0; end
  return math.sqrt( ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) ) )
end

function JUtils:GetVecDist(v1,v2)
  if not v1 or not v2 or not v1.x or not v2.x then return 0; end
  return math.sqrt(  ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) )+( (v1.z or 0) - (v2.z or 0) )*( (v1.z or 0) - (v2.z or 0) )  )
end

function JUtils.GetCoordsInFrontOfCam(...)
  local unpack   = table.unpack
  local coords,direction    = GetGameplayCamCoord(), JUtils.RotationToDirection()
  local inTable  = {...}
  local retTable = {}

  if ( #inTable == 0 ) or ( inTable[1] < 0.000001 ) then inTable[1] = 0.000001 ; end

  for k,distance in pairs(inTable) do
    if ( type(distance) == "number" )
    then
      if    ( distance == 0 )
      then
        retTable[k] = coords
      else
        retTable[k] =
          vector3(
            coords.x + ( distance*direction.x ),
            coords.y + ( distance*direction.y ),
            coords.z + ( distance*direction.z )
          )
      end
    end
  end
  return unpack(retTable)
end

function JUtils.RotationToDirection(rot)
  if     ( rot == nil ) then rot = GetGameplayCamRot(2);  end
  local  rotZ = rot.z  * ( 3.141593 / 180.0 )
  local  rotX = rot.x  * ( 3.141593 / 180.0 )
  local  c = math.cos(rotX);
  local  multXY = math.abs(c)
  local  res = vector3( ( math.sin(rotZ) * -1 )*multXY, math.cos(rotZ)*multXY, math.sin(rotX) )
  return res
end

function JUtils:LoadModelTable(table)
  if type(table) ~= 'table' then return false; end
  for k,v in pairs(table) do
    if type(v) == 'string' then
      local hk = JUtils.GetHashKey(v)
      while not HasModelLoaded(hk) do
        RequestModel(hk)
        Citizen.Wait(0)
      end
    end
  end
  return true
end

function JUtils:ReleaseModelTable(table)
  if type(table) ~= 'table' then return false; end
  for k,v in pairs(table) do
    if type(v) == 'string' then
      local hk = JUtils.GetHashKey(v)
      if HasModelLoaded(hk) then
        SetModelAsNoLongerNeeded(hk)
      end
    end
  end
  return true
end

function JUtils.LoadWeaponTable(table)  
  if type(table) ~= 'table' then return false; end
  for k,v in pairs(table) do
    if type(v) == 'string' then
      local hk = JUtils.GetHashKey(v)
      while not HasWeaponAssetLoaded(hk) do
        RequestWeaponAsset(hk)
        Citizen.Wait(0)
      end
    end
  end
  return true
end

function JUtils.ReleaseWeaponTable(table)
  if type(table) ~= 'table' then return false; end
  for k,v in pairs(table) do
    if type(v) == 'string' then
      local hk = JUtils.GetHashKey(v)
      if HasWeaponAssetLoaded(hk) then
        RemoveWeaponAsset(hk)
      end
    end
  end
  return true
end

function JUtils.LoadAnimTable(table)
  if type(table) ~= 'table' then return false; end
  for k,v in pairs(table) do
    if type(v) == 'string' then
      while not HasAnimDictLoaded(v) do
        RequestAnimDict(v)
        Citizen.Wait(0)
      end
    end
  end
  return true
end

function JUtils.ReleaseAnimTable(table)
  if type(table) ~= 'table' then return false; end
  for k,v in pairs(table) do
    if type(v) == 'string' then
      if HasAnimDictLoaded(v) then
        RemoveAnimDict(v)
      end
    end
  end
  return true
end

function JUtils:LoadAnimDict(dict)
  if type(dict) ~= 'string' then return false; end
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Citizen.Wait(0)
  end
  return true
end

function JUtils:ReleaseAnimDict(dict)
  if type(dict) ~= 'string' then return false; end
  if HasAnimDictLoaded(dict) then
    RemoveAnimDict(dict)
  end
  return true
end

function JUtils.NetworkControlEntity(ent)
  if type(ent) ~= 'number' then return false; end
  while not NetworkHasControlOfEntity(ent) do
    NetworkRequestControlOfEntity(ent)
    Citizen.Wait(0)
  end
  return true
end

function JUtils.NetworkControlDoor(obj)
  if type(obj) ~= 'number' then return false; end
  while not NetworkHasControlOfDoor(obj) do
    NetworkRequestControlOfDoor(obj)
    Citizen.Wait(0)
  end
  return true
end

function JUtils.InRange(val, target, range)
  if target + range < val and target - range > val then return true;
  else return false; end
end

