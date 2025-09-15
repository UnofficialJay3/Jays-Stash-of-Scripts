-- Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: UnofficialJay3
print("JaysFlyin' module - Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: UnofficialJay3")
local module = {}

-- Configurations
module.connection = nil -- The connection for the runservice handling the fly.
module.speed = 50 -- The speed for your flight.
module.useCF = false -- If true, you will fly using CFrame instead of using velocity
module.platformStand = true -- If true, you will be platformstanding while flying.
module.camRotation = true -- If true, your character will rotate with the lookvector of the camera.
module.useAnim = true -- If true, you will fly with the fly animation. (R6 and R15) It's basically idle animations so it's more cleaner.
local flyAnimR6 = 130025294780390
local flyAnimR15 = 121812367375506



-- Module grabber
local main = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/TheAllInOneModule.lua"))
local uikit = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/JaysUIToolKitModule.lua"))

-- Services
local z = main.services
local UserInputService, RunService = z.UserInputService, z.RunService

-- Variables
local player, char, root, hum, playerGui = unpack(main.GetPlayer())
local cam = workspace.CurrentCamera
local defaultSpeed = hum.WalkSpeed
local GetKeyHold = main.GetKeyHold
local lv
local av
local att
local flyAnim
local flyTrack
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Grab ControlModule
local PlayerModule = player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
local ControlModule = require(PlayerModule:WaitForChild("ControlModule"))

local function ApplyVel()
	att = root:FindFirstChild("ClankerAttachment") or Instance.new("Attachment") -- Asked chatgpt to fix something and then I see "ClankerAttachment" WHAT IS A CLANKER ATTACHMENT?
	-- At this point I am leaving this here because why not.
	att.Name = "ClankerAttachment"
	att.Parent = root

	lv = Instance.new("LinearVelocity")
	lv.Attachment0 = att
	lv.MaxForce = math.huge
	lv.VectorVelocity = Vector3.zero
	lv.Parent = root

	av = Instance.new("AngularVelocity")
	av.Attachment0 = att
	av.MaxTorque = math.huge
	av.AngularVelocity = Vector3.zero
	av.Parent = root
end

-- TR-AV
player.CharacterAdded:Connect(function()
	-- Player
	player, char, root, hum, playerGui = unpack(main.GetPlayer())
	defaultSpeed = hum.WalkSpeed
end)




-- The Main Lane? ?enaL niaM ehT


-- Play animation
local function PlayFlyAnimation()
	if FlyTrack then FlyTrack:Stop() end

	if hum.RigType == Enum.HumanoidRigType.R6 then
		flyAnim = Instance.new("Animation")
		flyAnim.AnimationId = "rbxassetid://" .. flyAnimR6
	else
		flyAnim = Instance.new("Animation")
		flyAnim.AnimationId = "rbxassetid://" .. flyAnimR15
	end

	FlyTrack = hum:LoadAnimation(flyAnim)
	FlyTrack.Priority = Enum.AnimationPriority.Action4
	FlyTrack:Play()
	FlyTrack.Looped = true
end

-- Stop animation
local function StopFlyAnimation()
	if FlyTrack then
		FlyTrack:Stop()
		FlyTrack = nil
	end
end


-- ApplyVel
function module.ApplyVel(state)
	if state then
		if lv then lv:Destroy() end
		if av then av:Destroy() end
		if att then att:Destroy() end
		ApplyVel()
	else
		if lv then lv:Destroy() end
		if av then av:Destroy() end
		if att then att:Destroy() end
	end
end


-- Disconnect to unfly.
function module.Disconnect()
	if module.connection then
		module.connection:Disconnect()
		module.connection = nil
		hum.WalkSpeed = defaultSpeed
		hum.PlatformStand = false
		hum:ChangeState(Enum.HumanoidStateType.Freefall)
		module.ApplyVel(false)
		
		pcall(function()
			StopFlyAnimation()
		end)
	end
end


-- Connect to fly, input a speed value to change your speed.
function module.Connect(data)
	-- If the connection is already there, disconnect it.
	if module.connection then
		module.connection:Disconnect()
		module.connection = nil
		module.ApplyVel(false)
	end
	
	-- General Initialization
	defaultSpeed = hum.WalkSpeed
	hum.WalkSpeed = 0
	
	module.ApplyVel(true)
	lv.MaxForce = math.huge
	av.MaxTorque = math.huge
	
	-- Setting fly settings
	if data.speed ~= nil then module.speed = data.speed end
	if data.useCF ~= nil then module.useCF = data.useCF end
	if data.camRotation ~= nil then module.camRotation = data.camRotation end
	if data.platformStand ~= nil then module.platformStand = data.platformStand end
	if data.useAnim ~= nil then module.useAnim = data.useAnim end
	
	-- If useAnim is on
	if module.useAnim then PlayFlyAnimation() end
	
	
	-- RunService
	module.connection = RunService.Heartbeat:Connect(function(dt)
		-- Get cam
		local camCF = cam.CFrame
		local f = camCF.LookVector
		local r = camCF.RightVector
		local u = (camCF.UpVector * Vector3.new(0,1,0)).Unit
		
		-- Get moveVec
		local moveVec = Vector3.zero
		
		if isMobile then
			-- Mobile moveVec
			local mobileVec = ControlModule:GetMoveVector()
			if mobileVec.Magnitude > 0 then
				local forward = Vector3.new(camCF.LookVector.X, camCF.LookVector.Y, camCF.LookVector.Z).Unit
				local right = Vector3.new(camCF.RightVector.X, camCF.LookVector.Y, camCF.RightVector.Z).Unit
				moveVec += (forward * -mobileVec.Z + right * mobileVec.X)
			end
		else
			-- Computer moveVec
			if GetKeyHold("W") then moveVec += f end
			if GetKeyHold("A") then moveVec -= r end
			if GetKeyHold("S") then moveVec -= f end
			if GetKeyHold("D") then moveVec += r end
			if GetKeyHold("Space") or GetKeyHold("E") then moveVec += u end
			if GetKeyHold("LeftControl") or GetKeyHold("Q") then moveVec -= u end
		end
		
		-- Movement
		if moveVec.Magnitude > 0 then
			moveVec = moveVec.Unit
			if module.useCF then
				local finalPos = root.Position + moveVec * module.speed * dt
				root.CFrame = CFrame.new(finalPos) * (root.CFrame - root.Position)
			else
				lv.VectorVelocity = moveVec * module.speed
			end
		else
			lv.VectorVelocity = Vector3.zero
		end
		
		-- Rotation
		if module.camRotation then
			root.CFrame = CFrame.new(root.Position, root.Position + f)
		end
		
		-- Platform stand
		if module.platformStand then
			hum.PlatformStand = true
			hum:ChangeState(Enum.HumanoidStateType.PlatformStanding)
		end
	end)
end



--Toggle fly
function module.ToggleFly(data)
	if module.connection then
		module.Disconnect()
	else
		module.Connect(data)
	end
end








return module