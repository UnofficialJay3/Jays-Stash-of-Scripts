-- Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: UnofficialJay3
task.wait(1)

-- Module grabber
local main = require(game.ReplicatedStorage:FindFirstChild("TheAllInOneModule")) or loadstring(game:HttpGet("https://tinyurl.com/3nm8m3kc"))()
local uikit = require(game.ReplicatedStorage:FindFirstChild("JaysUIModuleKit")) or loadstring("No url :(")



-- Player gui and ui setup
local player, char, root, hum, playerGui = unpack(main.GetPlayer())
local Message = main.Message -- Why not?

local gui = Instance.new("ScreenGui", playerGui)
gui.IgnoreGuiInset = true
gui.Name = main.randomString(10)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0.303, 0, 0.323, 0)--{0.303, 0},{0.323, 0}
frame.Position = UDim2.new(0.25, 0, 0.25, 0)
uikit.ApplyJaysStyleAuto(frame)
local drag = Instance.new("UIDragDetector", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.186, 0) -- {1, 0},{0.186, 0}
title.Text = "Jay's Stupiddest Bypasser"
local a, b = uikit.ApplyJaysStyleAuto(title)
title.BackgroundTransparency = 1
a:Destroy()
b:Destroy()

local bypasser = Instance.new("TextBox", frame)
bypasser.Size = UDim2.new(0.933, 0, 0.255, 0)--{0.933, 0},{0.255, 0}
bypasser.Position = UDim2.new(0.033, 0, 0.242, 0)--{0.033, 0},{0.242, 0}
bypasser.PlaceholderText = "Type your string."
bypasser.Text = ""
uikit.ApplyJaysStyleAuto(bypasser)


-- Are you sure this is the main- MAAAAAAIIIIIINNN LAAAAAAAANNEE!


-- The bypasser function
-- RTLConverter function
local function RTLConverter(message, rtl)
	rtl = rtl or "؍"
	local result = {}

	-- get UTF-8 codepoints
	for _, codepoint in utf8.codes(message) do
		local char = utf8.char(codepoint)
		table.insert(result, 1, rtl .. char) -- insert at front = reverse
	end

	result = table.concat(result)
	print(`Passed string {message}`)
	print(`RTL converted: {result}`)
	return result
end

-- Standerd RTL character "؍" others "ا", "و"
task.spawn(function()
	Message("Thank your-")
	task.wait(0.05)
	Message(RTLConverter("FUCKING..."))
	task.wait(0.05)
	Message("Lord and Master, Unofficial Jay")
	task.wait(0.05)
	Message("@lIl_ILovAltAccsHAHA <-- thank this guy :3")
end)

--game.TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(RTL)



-- When bypasser... Yeah...
bypasser.FocusLost:Connect(function(ep)
	if ep then
		local text = bypasser.Text
		Message(RTLConverter(text))
	end
end)