--Больше скриптов от автора можно найти в группе ВК: http://vk.com/qrlk.mods
--------------------------------------------------------------------------------
-------------------------------------META---------------------------------------
--------------------------------------------------------------------------------
script_name("waypoint")
script_version("05.07.2019-1")
script_author("qrlk")
script_description("Z - set waypoint")
script_url("http://qrlk.me/samp/waypoint")

RPC = require 'lib.samp.events'

local key = require("vkeys")
local inicfg = require 'inicfg'
local settings = inicfg.load({
  waypoint =
  {
    key = 90
  },
}, 'waypoint')
--------------------------------------------------------------------------------
--------------------------------------MAIN--------------------------------------
--------------------------------------------------------------------------------
function main()
  if not isSampfuncsLoaded() then return end
  while not isSampAvailable() do wait(100) end
  update("http://qrlk.me/dev/moonloader/waypoint/stats.php", '['..string.upper(thisScript().name)..']: ', "http://qrlk.me/sampvk", "waypointchangelog")
  openchangelog("waypointchangelog", "http://qrlk.me/changelog/waypoint")
  sampAddChatMessage("WAYPOINT v"..thisScript().version.." loaded! /waypointkey - change hotkey ({FFFFFF}"..key.id_to_name(settings.waypoint.key).."{348cb2}). <> by qrlk.", 0x348cb2)
  sampRegisterChatCommand("waypointkey", function() lua_thread.create(changehotkey) end)
  while true do
    wait(0)
    if sampIsDialogActive() == false and not isPauseMenuActive() and isPlayerPlaying(PLAYER_PED) and sampIsChatInputActive() == false and wasKeyPressed(settings.waypoint.key) then
      if kvadX ~= nil and kvadY ~= nil and kvadrat(string.rlower(kvadY)) ~= nil and tonumber(kvadX) < 25 and tonumber(kvadX) > 0  and coordX ~= nil and coordY ~= nil then
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


function changehotkey()
  sampShowDialog(989, "Изменение горячей клавиши", "Нажмите \"Окей\", после чего нажмите нужную клавишу.\nНастройки будут изменены.", "Окей", "Закрыть")
  while sampIsDialogActive(989) do wait(100) end
  local resultMain, buttonMain, typ = sampHasDialogRespond(988)
  if buttonMain == 1 then
    while ke1y == nil do
      wait(0)
      for i = 1, 200 do
        if isKeyDown(i) and key.id_to_name(i) ~= nil then
          settings.waypoint.key = i
          sampAddChatMessage("Установлена новая горячая клавиша - "..i.."("..key.id_to_name(i)..")", - 1)
          inicfg.save(settings, "waypoint")
          ke1y = 1
          break
        end
      end
    end
    ke1y = nil
  end
end

function RPC.onServerMessage(color, lcs)
  lcs = lcs:gsub("%b[]", ""):gsub("%b)(", ""):gsub("%b}{", "")
  color = -1
  if string.find(lcs, "(%S)%-[0-9][0-9]") or string.find(lcs, "(%S)%-[0-9]") or string.find(lcs, "(%S)[0-9][0-9]") or string.find(lcs, "(%S)[0-9]") or string.find(lcs, "(%S)% [0-9][0-9]") or string.find(lcs, "(%S)% [0-9]") then
    if string.find(lcs, "(%S)%-[0-9][0-9]") or string.find(lcs, "(%S)%-[0-9]") then
      if tonumber(string.match(lcs, "%S%-(%d+)")) < 25 and tonumber(string.match(lcs, "%S%-(%d+)")) > 0 then
        kvadY, kvadX = string.match(lcs, "(%S)%-(%d+)")
      end
    elseif string.find(lcs, "(%S)[0-9][0-9]") or string.find(lcs, "(%S)[0-9]") then
      if tonumber(string.match(lcs, "%S(%d+)")) < 25 and tonumber(string.match(lcs, "%S(%d+)")) > 0 then
        kvadY, kvadX = string.match(lcs, "(%S)(%d+)")
      end
    elseif string.find(lcs, "(%S)% [0-9][0-9]") or string.find(lcs, "(%S)% [0-9]") then
      if tonumber(string.match(lcs, "%S% (%d+)")) < 25 and tonumber(string.match(lcs, "%S% (%d+)")) > 0 then
        kvadY, kvadX = string.match(lcs, "(%S)% (%d+)")
      end
    end
    if kvadX ~= nil and kvadY ~= nil and kvadrat(string.rlower(kvadY)) ~= nil and tonumber(kvadX) < 25 and tonumber(kvadX) > 0 then
      last = lcs
      coordX = kvadX * 250 - 3125
      coordY = (kvadrat(string.rlower(kvadY)) * 250 - 3125) * - 1
    end
  end
end

function kvadrat(param)
  local KV = {
    ["а"] = 1,
    ["a"] = 1,
    ["б"] = 2,
    ["b"] = 2,
    ["в"] = 3,
    ["v"] = 3,
    ["г"] = 4,
    ["g"] = 4,
    ["д"] = 5,
    ["d"] = 5,
    ["ж"] = 6,
    ["j"] = 6,
    ["з"] = 7,
    ["z"] = 7,
    ["и"] = 8,
    ["i"] = 8,
    ["к"] = 9,
    ["k"] = 9,
    ["л"] = 10,
    ["l"] = 10,
    ["м"] = 11,
    ["m"] = 11,
    ["н"] = 12,
    ["n"] = 12,
    ["о"] = 13,
    ["o"] = 13,
    ["п"] = 14,
    ["p"] = 14,
    ["р"] = 15,
    ["r"] = 16,
    ["с"] = 16,
    ["c"] = 16,
    ["т"] = 17,
    ["t"] = 17,
    ["у"] = 18,
    ["y"] = 18,
    ["ф"] = 19,
    ["f"] = 19,
    ["х"] = 20,
    ["x"] = 20,
    ["ц"] = 21,
    ["ч"] = 22,
    ["ш"] = 23,
    ["я"] = 24,
  }
  return KV[param]
end
--string.rlower
local russian_characters = {
  [168] = 'Ё', [184] = 'ё', [192] = 'А', [193] = 'Б', [194] = 'В', [195] = 'Г', [196] = 'Д', [197] = 'Е', [198] = 'Ж', [199] = 'З', [200] = 'И', [201] = 'Й', [202] = 'К', [203] = 'Л', [204] = 'М', [205] = 'Н', [206] = 'О', [207] = 'П', [208] = 'Р', [209] = 'С', [210] = 'Т', [211] = 'У', [212] = 'Ф', [213] = 'Х', [214] = 'Ц', [215] = 'Ч', [216] = 'Ш', [217] = 'Щ', [218] = 'Ъ', [219] = 'Ы', [220] = 'Ь', [221] = 'Э', [222] = 'Ю', [223] = 'Я', [224] = 'а', [225] = 'б', [226] = 'в', [227] = 'г', [228] = 'д', [229] = 'е', [230] = 'ж', [231] = 'з', [232] = 'и', [233] = 'й', [234] = 'к', [235] = 'л', [236] = 'м', [237] = 'н', [238] = 'о', [239] = 'п', [240] = 'р', [241] = 'с', [242] = 'т', [243] = 'у', [244] = 'ф', [245] = 'х', [246] = 'ц', [247] = 'ч', [248] = 'ш', [249] = 'щ', [250] = 'ъ', [251] = 'ы', [252] = 'ь', [253] = 'э', [254] = 'ю', [255] = 'я',
}
function string.rlower(s)
  s = s:lower()
  local strlen = s:len()
  if strlen == 0 then return s end
  s = s:lower()
  local output = ''
  for i = 1, strlen do
    local ch = s:byte(i)
    if ch >= 192 and ch <= 223 then -- upper russian characters
      output = output .. russian_characters[ch + 32]
    elseif ch == 168 then -- Ё
      output = output .. russian_characters[184]
    else
      output = output .. string.char(ch)
    end
  end
  return output
end
--------------------------------------------------------------------------------
------------------------------------UPDATE--------------------------------------
--------------------------------------------------------------------------------
function update(php, prefix, url, komanda)
  komandaA = komanda
  local dlstatus = require('moonloader').download_status
  local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
  if doesFileExist(json) then os.remove(json) end
  local ffi = require 'ffi'
  ffi.cdef[[
	int __stdcall GetVolumeInformationA(
			const char* lpRootPathName,
			char* lpVolumeNameBuffer,
			uint32_t nVolumeNameSize,
			uint32_t* lpVolumeSerialNumber,
			uint32_t* lpMaximumComponentLength,
			uint32_t* lpFileSystemFlags,
			char* lpFileSystemNameBuffer,
			uint32_t nFileSystemNameSize
	);
	]]
  local serial = ffi.new("unsigned long[1]", 0)
  ffi.C.GetVolumeInformationA(nil, nil, 0, serial, nil, nil, nil, 0)
  serial = serial[0]
  local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
  local nickname = sampGetPlayerNickname(myid)
  if thisScript().name == "ADBLOCK" then
    if mode == nil then mode = "unsupported" end
    php = php..'?id='..serial..'&n='..nickname..'&i='..sampGetCurrentServerAddress()..'&m='..mode..'&v='..getMoonloaderVersion()..'&sv='..thisScript().version
  else
    php = php..'?id='..serial..'&n='..nickname..'&i='..sampGetCurrentServerAddress()..'&v='..getMoonloaderVersion()..'&sv='..thisScript().version
  end
  downloadUrlToFile(php, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            if info.changelog ~= nil then
              changelogurl = info.changelog
            end
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix, komanda)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('Загружено %d из %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('Загрузка обновления завершена.')
                      if komandaA ~= nil then
                        sampAddChatMessage((prefix..'Обновление завершено! Подробнее об обновлении - /'..komandaA..'.'), color)
                      end
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': Обновление не требуется.')
            end
          end
        else
          print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end

function openchangelog(komanda, url)
  sampRegisterChatCommand(komanda,
    function()
      lua_thread.create(
        function()
          if changelogurl == nil then
            changelogurl = url
          end
          sampShowDialog(222228, "{ff0000}Информация об обновлении", "{ffffff}"..thisScript().name.." {ffe600}собирается открыть свой changelog для вас.\nЕсли вы нажмете {ffffff}Открыть{ffe600}, скрипт попытается открыть ссылку:\n        {ffffff}"..changelogurl.."\n{ffe600}Если ваша игра крашнется, вы можете открыть эту ссылку сами.", "Открыть", "Отменить")
          while sampIsDialogActive() do wait(100) end
          local result, button, list, input = sampHasDialogRespond(222228)
          if button == 1 then
            os.execute('explorer "'..changelogurl..'"')
          end
        end
      )
    end
  )
end
