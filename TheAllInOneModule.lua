-- Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: UnofficialJay3
print("TheAllInOneModule - TAIOM loaded!1!1 - Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: UnofficialJay3")
local module = {}

local uikit = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/JaysUIToolKitModule.lua"))()

-- make a charset with all available characters
local charset = {}
for i = 32, 126 do -- printable ASCII characters
	table.insert(charset, string.char(i))
end

-- function to make a random string of custom length
function module.randomString(length)
	local str = {}
	for i = 1, length do
		str[i] = charset[math.random(1, #charset)]
	end
	return table.concat(str)
end


-- Get all relevant services
module.services = {
	Players = game:GetService("Players"),
	UserInputService = game:GetService("UserInputService"),
	RunService = game:GetService("RunService"),
	TweenService = game:GetService("TweenService"),
	TextChatService = game:GetService("TextChatService"),
}


-- Get player stuff
function module.GetPlayer()
	local player = game:GetService("Players").LocalPlayer
	local char = player.Character
	local root = char:WaitForChild("HumanoidRootPart")
	local hum = char:WaitForChild("Humanoid")
	local playerGui = player:WaitForChild("PlayerGui")
	return {
		player,
		char,
		root,
		hum,
		playerGui
	}
end


-- Send message for client
function module.Message(message)
	if type(message) ~= "string" then return end
	game.TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(message)
end

function module.Prompter(topText, placeholderText)
	local playerGui = game.Players.LocalPlayer.PlayerGui
	
	-- Make ui
	local gui = Instance.new("ScreenGui", playerGui)
	gui.IgnoreGuiInset = true
	local box = Instance.new("TextBox", gui)
	local label = Instance.new("TextLabel", box)
	uikit.ApplyJaysStyleAuto(box)
	local c, b = uikit.ApplyJaysStyleAuto(label)
	c:Destroy()
	b:Destroy()
	gui.Name = module.randomString(10)
	box.Name = module.randomString(10)
	label.Name = module.randomString(10)
	

	box.BackgroundColor3 = Color3.new(0,0,0)
	box.BackgroundTransparency = 0.75
	box.BorderSizePixel = 0
	box.Position = UDim2.new(0.25,0,0.25,0)
	box.Size = UDim2.new(0.5,0,0.5,0)
	box.PlaceholderText = placeholderText or "Type something."
	task.delay(0,function()
		box.Text = ""
	end)
	box.TextColor3 = Color3.new(255,255,255)
	box.TextScaled = true

	label.BackgroundTransparency = 1
	label.BorderSizePixel = 0
	label.Position = UDim2.new(0,0,0,0)
	label.Size = UDim2.new(1,0,0.2,0) -- {1, 0},{0.2, 0}
	label.Text = topText or "The OFFICIALIZED Prompt! T.O.P!"
	label.TextColor3 = Color3.new(255,255,255)
	label.TextScaled = true

	box:CaptureFocus()
	
	box.FocusLost:Connect(function()
		gui:Destroy()
		gui = nil
		box = nil
		label = nil
	end)
	
	return box
end


-- Get args
function module.GetArgs(message, splitter)
	if not message then return module.Message("Bro... Send in a message.") end
	return string.split(message, splitter or " ")
end


-- Args and command
function module.GetCommand(message)
	if not message then return module.Message("Bro... Send in a message.") end
	local args = module.GetArgs(message)
	local cmd = args[1]:lower()
	table.remove(args, 1)
	return cmd, args
end


-- Apply linear velocity overrider
function module.ApplyLinearVelocityOverrider(part)
	local att = Instance.new("Attachment", part)
	local LV = Instance.new("LinearVelocity", part)
	att.Name = module.randomString(10)
	LV.Name = module.randomString(10)
	LV.Attachment0 = att
	LV.ForceLimitMode = Enum.ForceLimitMode.Magnitude
	LV.MaxForce = 0
	LV.VectorVelocity = Vector3.zero
	return LV, att
end

-- Apply angular velocity overrider
function module.ApplyAngularVelocityOverrider(part)
	local att = Instance.new("Attachment", part)
	local AV = Instance.new("AngularVelocity", part)
	att.Name = module.randomString(10)
	AV.Name = module.randomString(10)
	AV.Attachment0 = att
	AV.MaxTorque = 0
	AV.AngularVelocity = Vector3.zero
	return AV, att
end

-- Override linear velocity once
function module.OverrideLinearVelocityOnce(part, velocity)
	local LV, att = module.ApplyLinearVelocityOverrider(part)
	LV.MaxForce = math.huge
	LV.VectorVelocity = velocity
	task.delay(0,function()
		LV:Destroy()
		att:Destroy()
	end)
end

-- Override angular velocity once
function module.OverrideAngularVelocityOnce(part, velocity)
	local AV, att = module.ApplyAngularVelocityOverrider(part)
	AV.MaxForce = math.huge
	AV.VectorVelocity = velocity
	task.delay(0,function()
		AV:Destroy()
		att:Destroy()
	end)
end


-- Get Single player
function module.GetSinglePlayer(input)
	if typeof(input) ~= "string" then
		warn("Expected string, got:", typeof(input))
		return nil
	end

	input = input:lower()

	for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
		local username = player.Name:lower()
		local displayName = player.DisplayName:lower()

		if username:sub(1, #input) == input or displayName:sub(1, #input) == input then
			return player
		end
	end

	return nil
end


-- Tp plr 2 plr
function module.Tp(a, b)
	print("asd")
	a = a.Character.HumanoidRootPart
	b = b.Character.HumanoidRootPart
	a.CFrame = b.CFrame
end


-- Get key pressed
function module.GetKeyHold(key)
	local UserInputService = game:GetService("UserInputService")
	key = Enum.KeyCode[key]
	if UserInputService:GetFocusedTextBox() then return false end
	return UserInputService:IsKeyDown(key)
end


-- Play animation (by ID)
function module.PlayAnimationById(id, player) -- Unfinished due to lazyness
	local character = player.Character
	local humanoid = character and character:FindFirstChild("Humanoid")
	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://" .. id
end
	



return module
