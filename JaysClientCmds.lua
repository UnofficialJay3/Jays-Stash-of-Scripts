-- Made by RBX: @IlIl_ILovAltAccsHAHA / Unofficial Jay | Git: UnofficialJay3

task.wait(0.5)

-- Configs
local cmdkey = "semicolon"

-- Custom commands configs and variables
local infJumpConnection
local spinner = false
local AV
local att
local ltoConnection
local noclipConnection
local cfWalkConnection
local CFWalkModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/JaysCFrameWalk.lua"))()



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
	if AV then
		spinner = false
		AV:Destroy()
		AV = nil
		att:Destroy()
		att = nil
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
