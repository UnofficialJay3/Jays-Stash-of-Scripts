-- Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: UnofficialJay3
print("JaysCFrameWalk module - Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: UnofficialJay3")
local module = {}

-- Module grabber
local main = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/TheAllInOneModule.lua"))()

-- Services
local z = main.services
local UserInputService, RunService = z.UserInputService, z.RunService

-- Variables
local UNIVERSALSTOP = false
local player, char, root, hum = unpack(main.GetPlayer())
local Message = main.Message
local speed = 16
module.Connection = nil
local defaultSpeed

-- Un-TR-AV-er
player.CharacterAdded:Connect(function()
	player, char, root, hum = unpack(main.GetPlayer())
	hum.Died:Connect(function()
		module.Connection:Disconnect()
		module.Connection = nil
	end)
end)

-- What? I am too lazy, I am going insane. Not really, maybe tiredness?
hum.Died:Connect(function()
	module.Connection:Disconnect()
	module.Connection = nil
end)


-- THE MAIN LANE? Yes it is the main lane.


-- Check if a key is held
local function IsHeld(key)
	if UNIVERSALSTOP then return end
	key = Enum.KeyCode[key]
	if UserInputService:GetFocusedTextBox() then
		return false
	end
	return UserInputService:IsKeyDown(key)
end

-- Disconnect connection
function module.Disconnect()
	if module.Connection then
		module.Connection:Disconnect()
		module.Connection = nil
		hum.WalkSpeed = defaultSpeed
	end
end

-- Connect connection to run service
function module.Connect(speedA)
	if module.Connection then
		module.Disconnect()
	end
	
	defaultSpeed = hum.WalkSpeed
	hum.WalkSpeed = 0

	speed = speedA or speed

	module.Connection = RunService.Heartbeat:Connect(function(dt)
		local cam = workspace.CurrentCamera
		local camCF = cam.CFrame

		-- Flattened, normalized directions
		local f = Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z).Unit
		local r = Vector3.new(camCF.RightVector.X, 0, camCF.RightVector.Z).Unit

		local moveVec = Vector3.zero
		if IsHeld("W") then moveVec += f end
		if IsHeld("A") then moveVec -= r end
		if IsHeld("S") then moveVec -= f end
		if IsHeld("D") then moveVec += r end

		if moveVec.Magnitude > 0 then
			moveVec = moveVec.Unit
			root.CFrame = root.CFrame + (moveVec * speed * dt)
		end
	end)

end

return module
