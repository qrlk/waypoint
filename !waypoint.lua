--Больше скриптов от автора можно найти в группе ВК: http://vk.com/qrlk.mods
--Больше скриптов от автора можно найти на сайте: http://www.rubbishman.ru/samp
--------------------------------------------------------------------------------
-------------------------------------META---------------------------------------
--------------------------------------------------------------------------------
script_name("waypoint")
script_version("1.0")
script_author("qrlk")
script_description("Z - set waypoint")

RPC = require 'lib.samp.events'
--------------------------------------------------------------------------------
--------------------------------------MAIN--------------------------------------
--------------------------------------------------------------------------------
function main()
  if not isSampfuncsLoaded() then return end
  while not isSampAvailable() do wait(100) end
  while true do
    wait(0)
    if sampIsDialogActive() == false and not isPauseMenuActive() and isPlayerPlaying(playerHandle) and sampIsChatInputActive() == false and wasKeyPressed(90) then
      if coordX ~= nil and coordY ~= nil then
        cX, cY, cZ = getCharCoordinates(playerPed)
        cX = math.ceil(cX)
        cY = math.ceil(cY)
        cZ = math.ceil(cZ)
        sampAddChatMessage('[waypoint]: Установлена метка на '..kvadY..'-'..kvadX.. '. Дистанция: '..math.ceil(getDistanceBetweenCoords2d(coordX, coordY, cX, cY))..' м.', - 1)
        placeWaypoint(coordX, coordY, 0)
      end
    end
  end
end

function RPC.onServerMessage(color, lcs)
  if string.find(lcs, "(%A)-[0-9][0-9]") or string.find(lcs, "(%A)-[0-9]") then
    kvadY, kvadX = string.match(lcs, "(%A)-(%d+)")
    if kvadrat(kvadY) ~= nil and kvadX ~= nil and kvadY ~= nil and tonumber(kvadX) < 25 and tonumber(kvadX) > 0 then
      last = lcs
      coordX = kvadX * 250 - 3125
      coordY = (kvadrat(kvadY) * 250 - 3125) * - 1
    end
  end
end

function kvadrat(param)
  local KV = {
    ["А"] = 1,
    ["Б"] = 2,
    ["В"] = 3,
    ["Г"] = 4,
    ["Д"] = 5,
    ["Ж"] = 6,
    ["З"] = 7,
    ["И"] = 8,
    ["К"] = 9,
    ["Л"] = 10,
    ["М"] = 11,
    ["Н"] = 12,
    ["О"] = 13,
    ["П"] = 14,
    ["Р"] = 15,
    ["С"] = 16,
    ["Т"] = 17,
    ["У"] = 18,
    ["Ф"] = 19,
    ["Х"] = 20,
    ["Ц"] = 21,
    ["Ч"] = 22,
    ["Ш"] = 23,
    ["Я"] = 24,
    ["а"] = 1,
    ["б"] = 2,
    ["в"] = 3,
    ["г"] = 4,
    ["д"] = 5,
    ["ж"] = 6,
    ["з"] = 7,
    ["и"] = 8,
    ["к"] = 9,
    ["л"] = 10,
    ["м"] = 11,
    ["н"] = 12,
    ["о"] = 13,
    ["п"] = 14,
    ["р"] = 15,
    ["с"] = 16,
    ["т"] = 17,
    ["у"] = 18,
    ["ф"] = 19,
    ["х"] = 20,
    ["ц"] = 21,
    ["ч"] = 22,
    ["ш"] = 23,
    ["я"] = 24,
  }
  return KV[param]
end
