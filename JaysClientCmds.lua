-- Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: UnofficialJay3
print("JaysClientCmds - Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: UnofficialJay3")

-- Configs
local cmdkey = "semicolon"

-- Custom commands configs and variables
local infJumpConnection
local spinner = false
local AV
local att -- This is a comment
local ltoConnection
local noclipConnection
local cfWalkConnection
local CFWalkModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/JaysCFrameWalk.lua"))()
local JaysFlyin = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/JaysFlyModule.lua"))()
local JaysFlyinLoader = "https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/JaysFly.lua"
local JaysStupiddestBypasserLoader = "https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/JaysStupiddestBypasserObfuscated.lua"
local Lighting = game:GetService("Lighting")
local defaultLighting = {
	Brightness = Lighting.Brightness,
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient,
	GlobalShadows = Lighting.GlobalShadows,
}
local FLINGCONN



-- Module grabber
local main = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/TheAllInOneModule.lua"))()

-- Services
local z = main.services
local Players, UserInputService, RunService = z.Players, z.UserInputService, z.RunService

-- Variables
local player, char, root, hum, playerGui = unpack(main.GetPlayer())
local Message = main.Message
local dSpeed = hum.WalkSpeed
local dJumpP = hum.JumpPower
hum.UseJumpPower = true

local function UniversalResetter()
	if infJumpConnection then
		infJumpConnection:Disconnect()
		infJumpConnection = nil
	end
	if cfWalkConnection then
		cfWalkConnection:Disconnect()
		cfWalkConnection = nil
	end
	if ltoConnection then
		ltoConnection:Disconnect()
		ltoConnection = nil
	end
	if noclipConnection then
		noclipConnection:Disconnect()
		noclipConnection = nil
	end
	if AV then
		spinner = false
		AV:Destroy()
		AV = nil
		att:Destroy()
		att = nil
	end
	if FLINGCONN then
		FLINGCONN:Disconnect()
		FLINGCONN = nil
	end
end

-- TR-AF
player.CharacterAdded:Connect(function()
	-- Get player
	player, char, root, hum, playerGui = unpack(main.GetPlayer())
	
	-- Reset stuff
	hum.Died:Connect(UniversalResetter)
end)
hum.Died:Connect(UniversalResetter)



-- You don't realize, but this is the main lane. Get out of my lane!



-- Command handler
local function CommandHandler(message)
	local cmd, args = main.GetCommand(message)
	
	if cmd == "test" then
		Message("This worked")
	elseif cmd == "speed" then
		local speed = tonumber(args[1]) or dSpeed
		hum.WalkSpeed = speed
	elseif cmd == "jump" then
		hum.Jump = true
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
		main.OverrideLinearVelocityOnce(root, Vector3.new(root.Velocity.X,dJumpP,root.Velocity.Z))
	elseif cmd == "infjump" then
		if infJumpConnection then
			infJumpConnection:Disconnect()
			infJumpConnection = nil
		else
			infJumpConnection = UserInputService.JumpRequest:Connect(function()
				hum.Jump = true
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
				main.ApplyLinearVelocityOverrider(root, Vector3.new(root.Velocity.X,dJumpP,root.Velocity.Z))
			end)
		end
	elseif cmd == "spin" then
		local speed = tonumber(args[1]) or 10
		if not spinner then
			spinner = true
			AV, att = main.ApplyAngularVelocityOverrider(root)
		end
		AV.MaxTorque = math.huge
		AV.AngularVelocity = Vector3.new(0,speed,0)
	elseif cmd == "unspin" then
		spinner = false
		AV:Destroy()
		AV = nil
		att:Destroy()
		att = nil
	elseif cmd == "re" then
		local s = pcall(function()
			player:LoadCharacter()
		end)
		if not s then
			local head = char:FindFirstChild("Head")
			if head then
				head:Destroy()
			end
			hum.Health = -math.huge
		end
	elseif cmd == "selfkick" then
		pcall(function()
			player:Kick("Was your choice. Literally.")
		end)
	elseif cmd == "getplayer" then
		local player = main.GetSinglePlayer(args[1] or nil)
		if player then
			Message(`PLAYUH FOUNDED!1!1 Hello to {player.DisplayName} commonly known as {player.Name}`)
		end
	elseif cmd == "to" then
		local target = main.GetSinglePlayer(args[1] or nil)
		if target then
			main.Tp(player, target)
		end
	elseif cmd == "lto" then
		local target = main.GetSinglePlayer(args[1] or nil)
		if target then
			ltoConnection = RunService.Heartbeat:Connect(function()
				main.Tp(player, target)
			end)
		end
	elseif cmd == "unlto" then
		if ltoConnection then
			ltoConnection:Disconnect()
			ltoConnection = nil
		end
	elseif cmd == "noclip" then
		if noclipConnection then
			noclipConnection:Disconnect()
			noclipConnection = nil
		else
			noclipConnection = RunService.Stepped:Connect(function()
				if player.Character then
					for _, part in ipairs(player.Character:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end)
		end
	elseif cmd == "fps" then
		local fps = tonumber(args[1]) or 60
		pcall(function()
			setfpscap(fps)
		end)
	elseif cmd == "cfwalk" then
		local speed = tonumber(args[1]) or 16
		
		if CFWalkModule.Connection and not args[1] then
			CFWalkModule.Disconnect()
		else
			CFWalkModule.Connect(speed)
		end
	elseif cmd == "fly" then
		local value = tonumber(args[1]) or 50
		JaysFlyin.ChangeSettings({speed = value})
		JaysFlyin.Connect()
	elseif cmd == "unfly" then
		JaysFlyin.Disconnect()
	elseif cmd == "jaysflyinloader" then
		print("Loading JaysFlyinLoader.lua")
		if JaysFlyinLoader then
			local s, r = pcall(function()
				return loadstring(game:HttpGet(JaysFlyinLoader))()
			end)
			
			if s then
				print("LOADED!!! :D")
			else
				print("ERROR LOADING: " .. tostring(r))
			end
		else
			print("No source.")
		end
	elseif cmd == "flingo" then
		hum.Sit = true
		local intensity = tonumber(args[1]) or 200
		local a,b,c = (math.random(-5,5)/5)*intensity,(math.random(-5,5)/5)*intensity,(math.random(-5,5)/5)*intensity
		main.OverrideLinearVelocityOnce(root, Vector3.new(a,b,c))
		main.OverrideAngularVelocityOnce(root, Vector3.new(-a,c,-b))
	elseif cmd == "jaystupiddestbypasserloader" then
		print("Loading JaysStupiddestBypasser.lua")
		if JaysFlyinLoader then
			local s, r = pcall(function()
				return loadstring(game:HttpGet(JaysStupiddestBypasserLoader))()
			end)

			if s then
				print("LOADED!!! :D")
			else
				print("ERROR LOADING: " .. tostring(r))
			end
		else
			print("No source.")
		end
	elseif cmd == "nightvision" or cmd == "nv" then
		-- Nuke the darkness 👊
		Lighting.Brightness = 2 -- crank up brightness (default is 2)
		Lighting.Ambient = Color3.new(1, 1, 1) -- pure white = fills in shadowy areas
		Lighting.OutdoorAmbient = Color3.new(1, 1, 1) -- same for outdoors
		Lighting.GlobalShadows = false -- turn OFF shadows completely
	elseif cmd == "unnightvision" or cmd == "unnv" then
		for i,v in defaultLighting do
			Lighting[i] = v
		end
	elseif cmd == "fling" then
		print("I promise you. You are spinning on the server side, you can still fling stuff!")
		local value = tonumber(args[1]) or 1e32 -- PLEASE set this value to a high number. This is why it's called "fling"
		--JaysFlyin.ChangeSettings({camrotation = false})
		
		JaysFlyin.Connect()
		
		FLINGCONN = RunService.RenderStepped:Connect(function()
			for _, part in ipairs(char:GetDescendants()) do
				if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
					part.CanCollide = false
					part.Massless = true
				end
			end
		end)
		
		local AV, att = main.ApplyAngularVelocityOverrider(root)

		AV.MaxTorque = math.huge
		AV.AngularVelocity = Vector3.new(-value,value,-value)
	elseif cmd == "unfling" then
		if FLINGCONN then
			--JaysFlyin.ChangeSettings({camrotation = true})
			local lastCF = root.CFrame
			
			FLINGCONN:Disconnect()
			FLINGCONN = nil
			
			hum.Health = 0
			local h = char:FindFirstChild("Head")
			if h then h:Destroy() end
			
			for _, v in pairs(char:GetChildren()) do
				if v:IsA("AngularVelocity") or v:IsA("LinearVelocity") then
					v:Destroy()
				end
			end
			
			task.spawn(function()
				player.CharacterAdded:Connect(function()
					task.wait(0.1)
					local root = char:WaitForChild("HumanoidRootPart")
					root.CFrame = lastCF
				end)
			end)
		end
	end
end



-- Prompter
local function Prompter()
	local box = main.Prompter("Jay's Client Commands", "Type a command.")
	task.wait(0)
	box.FocusLost:Connect(function(ep)
		CommandHandler(box.Text)
	end)
end



-- Input handler
UserInputService.InputBegan:Connect(function(inp, gp)
	if gp then return end
	inp = inp.KeyCode.Name:lower()
	
	if inp == cmdkey then
		Prompter()
	end
end)
