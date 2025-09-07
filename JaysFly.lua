-- Made by RBX: @IlIl_ILovAltAccsHAHA / Unofficial Jay | Git: UnofficialJay3

-- Configs
local keybind = "f" -- Your key to toggle fly mode.
local vel = 50 -- Your speed for flying.
local flyState = false -- Turn this true and you already be flyin'!
local applyVel = true -- Determines if you use velocity or CFrame.
local applyRot = true -- Determines if you use angular velocity or just... None.
local platstand = true -- Determines if you platform stand every heartbeat. Disable this to potentiolly fly vehicles.
local applyCFRot = true -- Determines if when you rotate the camera, your character updates to the forward vector.
local useBody = false -- Determines if you use the deprecated bodyvel and bodyangvel instead of the linearvel and angularvel.
local useAnims = true -- Determines if when you fly, you fly with the idle r6/r15 animations. Instead of the player goin' around with animations.
local flyAnimR6 = 130025294780390
local flyAnimR15 = 121812367375506
local UNIVERSALSTOP = false -- Stops everything that is happening. (In the script. I am trying my best to stop everything.)

-- Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

-- Variables
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")
local camera = workspace.CurrentCamera
local FlyAnimation
local FlyTrack

-- The velocities
local att
local LV
local AV
if useBody then
	LV = Instance.new("BodyVelocity", root)
	LV.MaxForce = Vector3.zero
	LV.Velocity = Vector3.zero
	
	AV = Instance.new("BodyAngularVelocity", root)
	AV.MaxTorque = Vector3.zero
	AV.AngularVelocity = Vector3.zero
else
	att = Instance.new("Attachment", root)

	LV = Instance.new("LinearVelocity", root)
	LV.Attachment0 = att
	LV.ForceLimitMode = Enum.ForceLimitMode.Magnitude
	LV.MaxForce = 0
	LV.VectorVelocity = Vector3.zero

	AV = Instance.new("AngularVelocity", root)
	AV.Attachment0 = att
	AV.MaxTorque = 0
	AV.AngularVelocity = Vector3.zero
end


-- TR-AF - The Re-Aliver Function
player.CharacterAdded:Connect(function()
	if UNIVERSALSTOP then return end
	
	-- Player
	player = Players.LocalPlayer
	char = player.Character or player.CharacterAdded:Wait()
	root = char:WaitForChild("HumanoidRootPart")
	hum = char:WaitForChild("Humanoid")
	
	-- Velocity stuff
	att = nil
	LV = nil
	AV = nil
	if useBody then
		LV = Instance.new("BodyVelocity", root)
		LV.MaxForce = Vector3.zero
		LV.Velocity = Vector3.zero

		AV = Instance.new("BodyAngularVelocity", root)
		AV.MaxTorque = Vector3.zero
		AV.AngularVelocity = Vector3.zero
	else
		att = Instance.new("Attachment", root)

		LV = Instance.new("LinearVelocity", root)
		LV.Attachment0 = att
		LV.ForceLimitMode = Enum.ForceLimitMode.Magnitude
		LV.MaxForce = 0
		LV.VectorVelocity = Vector3.zero

		AV = Instance.new("AngularVelocity", root)
		AV.Attachment0 = att
		AV.MaxTorque = 0
		AV.AngularVelocity = Vector3.zero
	end
end)



-- Hello everybody, today this script is brought to you by the MMMAAAIIINNN LLLAAANNNEEE!!!



-- Play fly animation
local function PlayFlyAnimation()
	pcall(function()
		if FlyTrack then FlyTrack:Stop() end

		if hum.RigType == Enum.HumanoidRigType.R6 then
			FlyAnimation = Instance.new("Animation")
			FlyAnimation.AnimationId = "rbxassetid://" .. flyAnimR6
		else
			FlyAnimation = Instance.new("Animation")
			FlyAnimation.AnimationId = "rbxassetid://" .. flyAnimR15
		end

		FlyTrack = hum:LoadAnimation(FlyAnimation)
		FlyTrack.Priority = Enum.AnimationPriority.Action4
		FlyTrack:Play()
		FlyTrack.Looped = true
	end)
end



-- Stop fly animation
local function StopFlyAnimation()
	pcall(function()
		if FlyTrack then
			FlyTrack:Stop()
			FlyTrack = nil
		end
	end)
end



-- Init Fly
local function InitFly()
	if UNIVERSALSTOP then return end
	if useBody then
		LV.MaxForce = Vector3.one * math.huge
		AV.MaxTorque = Vector3.one * math.huge
	else
		LV.MaxForce = math.huge
		AV.MaxTorque = math.huge
	end
	
	if useAnims then
		PlayFlyAnimation()
	end
end

local function UnInitFly()
	if UNIVERSALSTOP then return end
	if useBody then
		LV.MaxForce = Vector3.zero
		AV.MaxTorque = Vector3.zero
	else
		LV.MaxForce = 0
		AV.MaxTorque = 0
	end
	
	task.delay(0, function()
		hum.PlatformStand = false
		hum:ChangeState(Enum.HumanoidStateType.Freefall)
		
		if useAnims then
			StopFlyAnimation()
		end
	end)
end



-- The PROMPT!!!
local function Prompt()
	if UNIVERSALSTOP then return end
	-- Make ui
	local gui = Instance.new("ScreenGui", playerGui)
	gui.IgnoreGuiInset = true
	local box = Instance.new("TextBox", gui)
	local label = Instance.new("TextLabel", box)
	
	box.BackgroundColor3 = Color3.new(0,0,0)
	box.BackgroundTransparency = 0.75
	box.BorderSizePixel = 0
	box.Position = UDim2.new(0.25,0,0.25,0)
	box.Size = UDim2.new(0.5,0,0.5,0)
	box.PlaceholderText = "Type it."
	task.delay(0,function()
		box.Text = ""
	end)
	box.TextColor3 = Color3.new(255,255,255)
	box.TextScaled = true
	
	label.BackgroundTransparency = 1
	label.BorderSizePixel = 0
	label.Position = UDim2.new(0,0,0,0)
	label.Size = UDim2.new(1,0,0.2,0) -- {1, 0},{0.2, 0}
	label.Text = "The OFFICIALIZED Prompt! T.O.P!"
	label.TextColor3 = Color3.new(255,255,255)
	label.TextScaled = true
	
	box:CaptureFocus()
	
	-- Logic
	box.FocusLost:Connect(function(ep)
		local args = string.split(box.Text, " ")
		local cmd = args[1]:lower()
		table.remove(args, 1)
		
		if ep then
			if cmd == "test" then
				print("TEST SUCCESSFUL!1!1")
				for _, v in pairs(args) do
					print(v)
				end
			elseif cmd == "speed" then
				local speed = tonumber(args[1]) or 50
				if speed then
					vel = speed
					print("vel:",vel)
				end
			elseif cmd == "vel" then
				applyVel = not applyVel
				print("vel:", applyVel)
			elseif cmd == "ang" then
				applyRot = not applyRot
				print("ang:",applyRot)
			elseif cmd == "cfrot" then
				applyCFRot = not applyCFRot
				print("cfrot:",applyCFRot)
			elseif cmd == "platstand" then
				platstand = not platstand
				print("platstand:",platstand)
			elseif cmd == "key" then
				keybind = args[1]
				print("keybind",keybind)
			elseif cmd == "flingpreset" then
				print("Fling preset activated")
				applyVel = false
				applyRot = false
				applyCFRot = false
				platstand = true	
			elseif cmd == "defaultpreset" then
				print("Default preset")
				applyVel = true
				applyRot = true
				applyCFRot = true
				platstand = true
			elseif cmd == "usebody" then
				useBody = not useBody
				print("useBody:",useBody)
			elseif cmd == "cmds" then
				print("The OFFICIALIZED Prompt! T.O.P!")
				print("speed [speed] | Sets speed")
				print("vel | Toggles usage of velocity or CFrame")
				print("ang | Toggles usage of angular velocity")
				print("cfrot | Toggles usage of rotating root to lookvector")
				print("platstand | Toggles usage of making humanoid platformstand every heartbeat")
				print("key [keybind] | Sets your keybind")
				print("flingpreset | A preset to have a flinging stuff")
				print("defaultpreset | The default preset")
				print("cmds | Self-explanitory")
				print("usebody | Uses the instance bodyvel and bodyangvel instead of linearvel and angvel.")
			end
		end
		
		gui:Destroy()
	end)
end



-- Is key held pressed function
local function IsHeld(key)
	if UNIVERSALSTOP then return end
	key = Enum.KeyCode[key]
	if UIS:GetFocusedTextBox() then
		return false
	end
	return UIS:IsKeyDown(key)
end
 


-- Input
UIS.InputBegan:Connect(function(inp, gp)
	if gp or UNIVERSALSTOP then return end
	inp = inp.KeyCode.Name:lower()
	
	-- Toggle fly
	if inp == keybind then
		flyState = not flyState
		if flyState then
			InitFly()
		else
			UnInitFly()
		end
	end
	
	-- The PROMPT!
	if inp == "l" then
		Prompt()
	end
	
	-- UNIVERSAL STOP!!!
	if inp == "p" then
		flyState = false
		UnInitFly()
		task.wait(1)
		UNIVERSALSTOP = true
	end
end)



-- The loop
RS.Heartbeat:Connect(function(dt)
	if UNIVERSALSTOP then return end
	if flyState then
		-- Init some stuff
		if platstand then
			hum.PlatformStand = true
			hum:ChangeState(Enum.HumanoidStateType.PlatformStanding)
		end
		
		-- Camera stuff
		local camCF = camera.CFrame
		local f = camCF.LookVector
		local r = camCF.RightVector
		local u = Vector3.new(0,camCF.UpVector.Y,0)
		
		-- Get moveVec from camera
		local moveVec = Vector3.zero
		
		if IsHeld("W") then moveVec += f end
		if IsHeld("A") then moveVec -= r end	
		if IsHeld("S") then moveVec -= f end
		if IsHeld("D") then moveVec += r end
		if IsHeld("Space") or IsHeld("E") then moveVec += u end
		if IsHeld("Q") then moveVec -= u end
		
		moveVec = moveVec.Unit
		
		-- Movement logic
		if moveVec.Magnitude > 0 then
			if applyVel then
				if useBody then LV.Velocity = moveVec * vel else LV.VectorVelocity = moveVec * vel end
			else
				if useBody then LV.Velocity = Vector3.zero else LV.VectorVelocity = Vector3.zero end
				local finalPos = root.Position + moveVec * vel * dt
				root.CFrame = CFrame.new(finalPos) * (root.CFrame - root.Position)
				--CFrame.new(finalPos, finalPos + root.CFrame.LookVector)
			end
		else
			if useBody then LV.Velocity = Vector3.zero else LV.VectorVelocity = Vector3.zero end
		end
		
		if applyRot then
			if useBody then
				AV.MaxTorque = Vector3.one * math.huge
				AV.AngularVelocity = Vector3.zero
			else
				AV.MaxTorque = math.huge
				AV.AngularVelocity = Vector3.zero
			end
		else
			if useBody then
				AV.MaxTorque = Vector3.zero
				AV.AngularVelocity = Vector3.zero
			else
				AV.MaxTorque = 0
				AV.AngularVelocity = Vector3.zero
			end
		end
		
		if applyCFRot then
			root.CFrame = CFrame.new(root.Position, root.Position + f)
		end
	end
end)