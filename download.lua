local tArgs = { ... }
local url = "http://example.net/computercraft/"
local x = http.get(url..tArgs[1]).readAll()
hFile = io.open(tArgs[2], "w")
hFile:write(x)
hFile:close()
