require 'lib.moonloader'
--------------------------------------------------------------------------------
-------------------------------------META---------------------------------------
--------------------------------------------------------------------------------
script_name("waypoint")
script_version("05.07.2019-1")
script_author("qrlk")
script_description("Z - set waypoint")
script_url("https://github.com/qrlk/waypoint")

-- https://github.com/qrlk/qrlk.lua.moonloader
local enable_sentry = true -- false to disable error reports to sentry.io
if enable_sentry then
  local sentry_loaded, Sentry = pcall(loadstring, [=[return {init=function(a)local b,c,d=string.match(a.dsn,"https://(.+)@(.+)/(%d+)")local e=string.format("https://%s/api/%d/store/?sentry_key=%s&sentry_version=7&sentry_data=",c,d,b)local f=string.format("local target_id = %d local target_name = \"%s\" local target_path = \"%s\" local sentry_url = \"%s\"\n",thisScript().id,thisScript().name,thisScript().path:gsub("\\","\\\\"),e)..[[require"lib.moonloader"script_name("sentry-error-reporter-for: "..target_name.." (ID: "..target_id..")")script_description("���� ������ ������������� ������ ������� '"..target_name.." (ID: "..target_id..")".."' � ���������� �� � ������� ����������� ������ Sentry.")local a=require"encoding"a.default="CP1251"local b=a.UTF8;local c="moonloader"function getVolumeSerial()local d=require"ffi"d.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local e=d.new("unsigned long[1]",0)d.C.GetVolumeInformationA(nil,nil,0,e,nil,nil,nil,0)e=e[0]return e end;function getNick()local f,g=pcall(function()local f,h=sampGetPlayerIdByCharHandle(PLAYER_PED)return sampGetPlayerNickname(h)end)if f then return g else return"unknown"end end;function getRealPath(i)if doesFileExist(i)then return i end;local j=-1;local k=getWorkingDirectory()while j*-1~=string.len(i)+1 do local l=string.sub(i,0,j)local m,n=string.find(string.sub(k,-string.len(l),-1),l)if m and n then return k:sub(0,-1*(m+string.len(l)))..i end;j=j-1 end;return i end;function url_encode(o)if o then o=o:gsub("\n","\r\n")o=o:gsub("([^%w %-%_%.%~])",function(p)return("%%%02X"):format(string.byte(p))end)o=o:gsub(" ","+")end;return o end;function parseType(q)local r=q:match("([^\n]*)\n?")local s=r:match("^.+:%d+: (.+)")return s or"Exception"end;function parseStacktrace(q)local t={frames={}}local u={}for v in q:gmatch("([^\n]*)\n?")do local w,x=v:match("^	*(.:.-):(%d+):")if not w then w,x=v:match("^	*%.%.%.(.-):(%d+):")if w then w=getRealPath(w)end end;if w and x then x=tonumber(x)local y={in_app=target_path==w,abs_path=w,filename=w:match("^.+\\(.+)$"),lineno=x}if x~=0 then y["pre_context"]={fileLine(w,x-3),fileLine(w,x-2),fileLine(w,x-1)}y["context_line"]=fileLine(w,x)y["post_context"]={fileLine(w,x+1),fileLine(w,x+2),fileLine(w,x+3)}end;local z=v:match("in function '(.-)'")if z then y["function"]=z else local A,B=v:match("in function <%.* *(.-):(%d+)>")if A and B then y["function"]=fileLine(getRealPath(A),B)else if#u==0 then y["function"]=q:match("%[C%]: in function '(.-)'\n")end end end;table.insert(u,y)end end;for j=#u,1,-1 do table.insert(t.frames,u[j])end;if#t.frames==0 then return nil end;return t end;function fileLine(C,D)D=tonumber(D)if doesFileExist(C)then local E=0;for v in io.lines(C)do E=E+1;if E==D then return v end end;return nil else return C..D end end;function onSystemMessage(q,type,i)if i and type==3 and i.id==target_id and i.name==target_name and i.path==target_path and not q:find("Script died due to an error.")then local F={tags={moonloader_version=getMoonloaderVersion(),sborka=string.match(getGameDirectory(),".+\\(.-)$")},level="error",exception={values={{type=parseType(q),value=q,mechanism={type="generic",handled=false},stacktrace=parseStacktrace(q)}}},environment="production",logger=c.." (no sampfuncs)",release=i.name.."@"..i.version,extra={uptime=os.clock()},user={id=getVolumeSerial()},sdk={name="qrlk.lua.moonloader",version="0.0.0"}}if isSampAvailable()and isSampfuncsLoaded()then F.logger=c;F.user.username=getNick().."@"..sampGetCurrentServerAddress()F.tags.game_state=sampGetGamestate()F.tags.server=sampGetCurrentServerAddress()F.tags.server_name=sampGetCurrentServerName()else end;print(downloadUrlToFile(sentry_url..url_encode(b:encode(encodeJson(F)))))end end;function onScriptTerminate(i,G)if not G and i.id==target_id then lua_thread.create(function()print("������ "..target_name.." (ID: "..target_id..")".."�������� ���� ������, ����������� ����� 60 ������")wait(60000)thisScript():unload()end)end end]]local g=os.tmpname()local h=io.open(g,"w+")h:write(f)h:close()script.load(g)os.remove(g)end}]=])
  if sentry_loaded and Sentry then
    pcall(Sentry().init, { dsn = "https://dd76e332e438467fbccce705c62edceb@o1272228.ingest.sentry.io/6530028" })
  end
end

-- https://github.com/qrlk/moonloader-script-updater
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
  local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('��������� %d �� %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('�������� ���������� ���������.')sampAddChatMessage(b..'���������� ���������!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'���������� ������ ��������. �������� ���������� ������..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': ���������� �� ���������.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, ������� �� �������� �������� ����������. ��������� ��� ��������� �������������� �� '..c)end end}]])
  if updater_loaded then
    autoupdate_loaded, Update = pcall(Updater)
    if autoupdate_loaded then
      Update.json_url = "https://raw.githubusercontent.com/qrlk/waypoint/master/version.json?" .. tostring(os.clock())
      Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
      Update.url = "https://github.com/qrlk/waypoint"
    end
  end
end

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

  -- ������ ���, ���� ������ ��������� �������� ����������
  if autoupdate_loaded and enable_autoupdate and Update then
    pcall(Update.check, Update.json_url, Update.prefix, Update.url)
  end
  -- ������ ���, ���� ������ ��������� �������� ����������

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
