local tArgs = { ... }
local url = "http://example.net/computercraft/"
local x = http.get(url..tArgs[1]).readAll()
f = loadstring(x)
f(unpack(tArgs, 2))
