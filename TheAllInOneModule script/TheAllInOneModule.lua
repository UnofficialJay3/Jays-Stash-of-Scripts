-- Scripted by RBX: @IlIl_ILovAltAccsHAHA / Unofficial Jay | Git: @UnofficialJay3

local module = {}

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
	return {
		player,
		char,
		root,
		hum
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
function module.GetCommand(message, prefix)
	if not message then return module.Message("Bro... Send in a message.") end
	local args = module.GetArgs(message)
	local cmd = args[1]:lower()
	table.remove(args, 1)
	return cmd, args
end

return module
