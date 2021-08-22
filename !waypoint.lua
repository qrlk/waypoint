--������ �������� �� ������ ����� ����� � ������ ��: http://vk.com/qrlk.mods
--------------------------------------------------------------------------------
-------------------------------------META---------------------------------------
--------------------------------------------------------------------------------
script_name("waypoint")
script_version("05.07.2019-1")
script_author("qrlk")
script_description("Z - set waypoint")
script_url("https://github.com/qrlk/waypoint")

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
        sampAddChatMessage('[waypoint]: ����������� ����� �� '..kvadY..'-'..kvadX.. '. ���������: '..math.ceil(getDistanceBetweenCoords2d(coordX, coordY, cX, cY))..' �.', - 1)
        placeWaypoint(coordX, coordY, 0)
      end
    end
  end
end


function changehotkey()
  sampShowDialog(989, "��������� ������� �������", "������� \"����\", ����� ���� ������� ������ �������.\n��������� ����� ��������.", "����", "�������")
  while sampIsDialogActive(989) do wait(100) end
  local resultMain, buttonMain, typ = sampHasDialogRespond(988)
  if buttonMain == 1 then
    while ke1y == nil do
      wait(0)
      for i = 1, 200 do
        if isKeyDown(i) and key.id_to_name(i) ~= nil then
          settings.waypoint.key = i
          sampAddChatMessage("����������� ����� ������� ������� - "..i.."("..key.id_to_name(i)..")", - 1)
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
    ["�"] = 1,
    ["a"] = 1,
    ["�"] = 2,
    ["b"] = 2,
    ["�"] = 3,
    ["v"] = 3,
    ["�"] = 4,
    ["g"] = 4,
    ["�"] = 5,
    ["d"] = 5,
    ["�"] = 6,
    ["j"] = 6,
    ["�"] = 7,
    ["z"] = 7,
    ["�"] = 8,
    ["i"] = 8,
    ["�"] = 9,
    ["k"] = 9,
    ["�"] = 10,
    ["l"] = 10,
    ["�"] = 11,
    ["m"] = 11,
    ["�"] = 12,
    ["n"] = 12,
    ["�"] = 13,
    ["o"] = 13,
    ["�"] = 14,
    ["p"] = 14,
    ["�"] = 15,
    ["r"] = 16,
    ["�"] = 16,
    ["c"] = 16,
    ["�"] = 17,
    ["t"] = 17,
    ["�"] = 18,
    ["y"] = 18,
    ["�"] = 19,
    ["f"] = 19,
    ["�"] = 20,
    ["x"] = 20,
    ["�"] = 21,
    ["�"] = 22,
    ["�"] = 23,
    ["�"] = 24,
  }
  return KV[param]
end
--string.rlower
local russian_characters = {
  [168] = '�', [184] = '�', [192] = '�', [193] = '�', [194] = '�', [195] = '�', [196] = '�', [197] = '�', [198] = '�', [199] = '�', [200] = '�', [201] = '�', [202] = '�', [203] = '�', [204] = '�', [205] = '�', [206] = '�', [207] = '�', [208] = '�', [209] = '�', [210] = '�', [211] = '�', [212] = '�', [213] = '�', [214] = '�', [215] = '�', [216] = '�', [217] = '�', [218] = '�', [219] = '�', [220] = '�', [221] = '�', [222] = '�', [223] = '�', [224] = '�', [225] = '�', [226] = '�', [227] = '�', [228] = '�', [229] = '�', [230] = '�', [231] = '�', [232] = '�', [233] = '�', [234] = '�', [235] = '�', [236] = '�', [237] = '�', [238] = '�', [239] = '�', [240] = '�', [241] = '�', [242] = '�', [243] = '�', [244] = '�', [245] = '�', [246] = '�', [247] = '�', [248] = '�', [249] = '�', [250] = '�', [251] = '�', [252] = '�', [253] = '�', [254] = '�', [255] = '�',
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
    elseif ch == 168 then -- �
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
                sampAddChatMessage((prefix..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('��������� %d �� %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('�������� ���������� ���������.')
                      if komandaA ~= nil then
                        sampAddChatMessage((prefix..'���������� ���������! ��������� �� ���������� - /'..komandaA..'.'), color)
                      end
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'���������� ������ ��������. �������� ���������� ������..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': ���������� �� ���������.')
            end
          end
        else
          print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..url)
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
          sampShowDialog(222228, "{ff0000}���������� �� ����������", "{ffffff}"..thisScript().name.." {ffe600}���������� ������� ���� changelog ��� ���.\n���� �� ������� {ffffff}�������{ffe600}, ������ ���������� ������� ������:\n        {ffffff}"..changelogurl.."\n{ffe600}���� ���� ���� ���������, �� ������ ������� ��� ������ ����.", "�������", "��������")
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
