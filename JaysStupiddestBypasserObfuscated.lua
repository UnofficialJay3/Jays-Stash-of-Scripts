-- Jays Stupiddest Bypasser ofuscated script:

-- Previously obfuscated the script but nah, feelin' generous today.

-- Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: UnofficialJay3

-- Module grabber
local main = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/TheAllInOneModule.lua"))()
local uikit = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/JaysUIToolKitModule.lua"))()



-- Are you sure this is the main- MAAAAAAIIIIIINNN LAAAAAAAANNEE! WAIT WAIT wait wait... Why is the main lane HERE?


-- Look-ALikes:
local lookAlikes = {
	a = {"а", "ạ", "Α", "А", "Ａ", "ɑ"},
	b = {"Β", "В", "Ｂ"},
	c = {"с", "С", "Ｃ"},
	d = {"Ｄ"},
	e = {"е", "ẹ", "Ε", "Е", "Ｅ"},
	f = {"Ｆ"},
	g = {"ɡ", "Ｇ"},
	h = {"Η", "Н", "Ｈ"},
	i = {"Ⅰ", "Ⅰ", "丨", "∣"},
	l = {"丨", "∣"},
	j = {"Ｊ"},
	k = {"κ", "Κ", "К", "Ｋ"},
	m = {"Μ", "М", "Ｍ"},
	n = {"Ν", "Ｎ"},
	o = {"о", "ο", "Ο", "О", "〇", "Ｏ"},
	p = {"р", "Ρ", "Р", "Ｐ"},
	q = {"Ｑ"},
	r = {"Ｒ"},
	s = {"Ｓ"},
	t = {"τ", "Τ", "Т", "Ｔ"},
	u = {"υ", "∪", "Ｕ", "υ"},
	v = {"ν", "∨", "Ｖ"},
	w = {"Ｗ", "ω"},
	x = {"х", "×", "Ｘ"},
	y = {"у", "Υ", "Ｙ"},
	z = {"Ｚ"}
}


-- List of swearies
local swearies = {
	"fuck",
	"shit",
	"ass",
	"horny",
	"porn",
	"dick",
	"pussy",
	"n- NO! Don't be racist 👍",
	"loli?",
	"cock",
	"cum",
}



-- The bypasser functions
-- Look-Alike Letter Converter
local function LALConverter(message)
	local result = {}
	for char in message:gmatch(".") do
		local lower = char:lower()
		local options = lookAlikes[lower]
		if options then
			local choice = options[math.random(1, #options)]
			table.insert(result, choice)
		else
			table.insert(result, char)
		end
	end
	return table.concat(result)
end

-- RTL Converter
local function RTLConverter(message, rtl)
	rtl = rtl or "؍"
	local result = {}
	for _, codepoint in utf8.codes(message) do
		local char = utf8.char(codepoint)
		table.insert(result, 1, rtl .. char) -- reverse with rtl char
	end
	return table.concat(result)
end

-- Unified Converter
local function FancyConverter(message, useRTL, useLAL)
	local original = message
	local method = ""
	if useLAL then
		message = LALConverter(message)
		method = "LAL"
	end
	if useRTL then
		message = RTLConverter(message)
		method = method == "" and "RTL" or method .. " + RTL"
	end

	if useLAL or useRTL then
		print("Passed string: " .. original)
		print("Method used: " .. method .. " Final conversion: " .. message)
	else
		print("No method. Passed string: " .. original)
	end


	return message
end



-- Player gui and ui setup AND and and variables cuz why not
local Message = main.Message -- Why not?
local player, char, root, hum, playerGui = unpack(main.GetPlayer())
local gui
local frame
local title
local bypasser
local Swearies
local RTLBtn
local LALBtn

local useLALMethod = false
local useRTLMethod = true

local function THEINITIALIZER()
	player, char, root, hum, playerGui = unpack(main.GetPlayer())

	gui = Instance.new("ScreenGui", playerGui)
	gui.IgnoreGuiInset = true
	gui.Name = ("ZZ" .. main.randomString(10) .. "ZZ")

	frame = Instance.new("Frame", gui)
	frame.Size = UDim2.new(0.303, 0, 0.323, 0)--{0.303, 0},{0.323, 0}
	frame.Position = UDim2.new(0.6, 0, 0.6, 0)
	uikit.ApplyJaysStyleAuto(frame)
	local drag = Instance.new("UIDragDetector", frame)

	title = Instance.new("TextLabel", frame)
	title.Size = UDim2.new(1, 0, 0.186, 0) -- {1, 0},{0.186, 0}
	title.Text = "Jay's Stupiddest Bypasser"
	local a, b = uikit.ApplyJaysStyleAuto(title)
	title.BackgroundTransparency = 1
	a:Destroy()
	b:Destroy()

	bypasser = Instance.new("TextBox", frame)
	bypasser.Size = UDim2.new(0.933, 0, 0.255, 0)--{0.933, 0},{0.255, 0}
	bypasser.Position = UDim2.new(0.033, 0, 0.242, 0)--{0.033, 0},{0.242, 0}
	bypasser.PlaceholderText = "Type your string."
	bypasser.Text = ""
	uikit.ApplyJaysStyleAuto(bypasser)
	bypasser.ClearTextOnFocus = false

	Swearies = Instance.new("TextButton", frame)
	Swearies.Size = UDim2.new(0.186, 0, 0.152, 0)--{0.186, 0},{0.152, 0}
	Swearies.Position = UDim2.new(0.795, 0, 0.817, 0)--{0.795, 0},{0.817, 0}
	Swearies.Text = "Swearies"
	uikit.ApplyJaysStyleAuto(Swearies)

	-- #ff6e6e red
	-- #70ff75 green (AI can figure out colors for HEX!)
	RTLBtn = Instance.new("TextButton", frame)
	RTLBtn.Size = UDim2.new(0.341, 0, 0.152, 0)--{0.341, 0},{0.152, 0}
	RTLBtn.Position = UDim2.new(0.033, 0, 0.549, 0)--{0.033, 0},{0.549, 0}
	RTLBtn.Text = "RTL Method"
	uikit.ApplyJaysStyleAuto(RTLBtn)
	if useRTLMethod then
		RTLBtn.BackgroundColor3 = Color3.fromHex("#70ff75")
	else
		RTLBtn.BackgroundColor3 = Color3.fromHex("#ff6e6e")
	end
	

	LALBtn = Instance.new("TextButton", frame)
	LALBtn.Size = UDim2.new(0.341, 0, 0.152, 0)--{0.341, 0},{0.152, 0}
	LALBtn.Position = UDim2.new(0.033, 0, 0.747, 0)--{0.033, 0},{0.747, 0}
	LALBtn.Text = "LAL Method"
	uikit.ApplyJaysStyleAuto(LALBtn)
	if useLALMethod then
		LALBtn.BackgroundColor3 = Color3.fromHex("#70ff75")
	else
		LALBtn.BackgroundColor3 = Color3.fromHex("#ff6e6e")
	end
	
	
	
	-- The real main lane? Or is it? (Vsauce thing music)
	-- When bypasser... Yeah...
	bypasser.FocusLost:Connect(function(ep)
		if ep then
			local text = bypasser.Text
			text = FancyConverter(text, useRTLMethod, useLALMethod)
			Message(text)
			bypasser.Text = text
		end
	end)
	
	-- When the swearies is pressed
	Swearies.MouseButton1Click:Connect(function()
		Message(RTLConverter("I fucking give up"))
	end)



	-- RTL btn
	RTLBtn.MouseButton1Click:Connect(function()
		useRTLMethod = not useRTLMethod
		if useRTLMethod then
			RTLBtn.BackgroundColor3 = Color3.fromHex("#70ff75")
		else
			RTLBtn.BackgroundColor3 = Color3.fromHex("#ff6e6e")	
		end
	end)

	-- LAL btn
	LALBtn.MouseButton1Click:Connect(function()
		useLALMethod = not useLALMethod
		if useLALMethod then
			LALBtn.BackgroundColor3 = Color3.fromHex("#70ff75")
		else
			LALBtn.BackgroundColor3 = Color3.fromHex("#ff6e6e")
		end
	end)
end

player.CharacterAdded:Connect(function()
	THEINITIALIZER()
end)
THEINITIALIZER()



-- Press , to capture focus to bypasser
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
	if gp then return end
	input = input.KeyCode.Name:lower()
	
	if input == "comma" then
		bypasser:CaptureFocus()
		--task.delay(0,function()
			bypasser.Text = ""
		--end)
	end
end)



-- The notifier
task.spawn(function()
	Message("Thank you Unofficial Jay :3")
	task.wait(0.05)
	Message("Now")
	task.wait(0.05)
	Message(RTLConverter("fuckola"))
	task.wait(0.05)
	Message("off.")
  task.wait(2)
  Message("Please don't remove this in the code.")
  -- If you do then me angy 😡🤬🤬🤬
end)
