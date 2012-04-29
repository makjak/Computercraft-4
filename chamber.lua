-- local turtle = {}
-- local function placeholder() return true end
-- turtle.up = placeholder
-- turtle.down = placeholder
-- turtle.digUp = placeholder
-- turtle.digDown = placeholder
-- turtle.dig = placeholder
-- turtle.forward = placeholder
-- turtle.turnLeft = placeholder
-- turtle.turnRight = placeholder

local tArgs = { ... }

local height = tonumber(tArgs[1])
local width = tonumber(tArgs[2])
local length = tonumber(tArgs[3])

print("Will create chamber of "..height.."x"..width.."x"..length)

local verbose = true
-- x, y
local difference = {0, 0}

local function up()
	local success = turtle.up()
	if success then
		difference[2] = difference[2] + 1;
	end

	return success
end

local function down()
	local success = turtle.down()
	if success then
		difference[2] = difference[2] - 1;
	end

	return success
end

local function fup()
	while not up() do turtle.digUp() end
end

local function fdown()
	while not down() do turtle.digDown() end
end

local function fdig()
	while turtle.detect() do turtle.dig() end
end

local function fforward()
	while not turtle.forward() do turtle.dig() end
end

-- direction = 0 -> up
-- direction = 1 -> down
local function dig(height, direction)
	local df = nil
	if direction == 0 then df = fup else df = fdown end
	for h = 2,height do
		df()
	end
end

-- Digs a hall
-- height height of the hall
-- length length of the hall
-- starting_direction 0 start going up, 1 start going down
local function hall(height, length, starting_direction)
	local direction = starting_direction
	for l = 1,length do
		dig(height, direction)
		if direction == 0 then direction = 1 else direction = 0 end 
		if l < length then fforward() end
	end

	return direction
end

local function repeate(number, f)
	for i = 2,number do f() end
end

-- Creates a chamber where he stands, starts at the bottom, rotates to the right
-- height height of the chamber
-- width width of the chamber
-- length length of the chamber
local function chamber(height, width, length)
	local location = 0 -- 0 == "should go up"
	local rotation = 0 -- 0 == "should turn left"
	for w = 1,width do
		location = hall(height, length, location)
		local rf = nil
		if rotation == 0 then rf = turtle.turnLeft; rotation = 1 else rf = turtle.turnRight; rotation = 0 end
		rf()
		if w < width then fforward() end
		rf()
	end

	if location == 1 then repeate(height, down) end
end

chamber(height, width, length)
print("Ended at difference of " .. tostring(difference))