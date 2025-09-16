-- Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: UnofficialJay3
print("JaysFlyin' - Loader - Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: UnofficialJay3")

-- Module grabber
local JaysFlyin = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/JaysFlyModule.lua"))()
local main = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/TheAllInOneModule.lua"))()
local uikit = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/JaysUIToolKitModule.lua"))()

-- Services
local UserInputService = main.services.UserInputService

-- Variables
local player, _, _, _, playerGui = unpack(main.GetPlayer())
local gui
local flyBtn

local function THEINITIALIZER()
	player, _, _, _, playerGui = unpack(main.GetPlayer())
	
	gui = Instance.new("ScreenGui", playerGui)
	gui.IgnoreGuiInset = true
	gui.Name = "JaysFlyin"
	
	flyBtn = Instance.new("TextButton", gui)
	flyBtn.Name = "FlyButton"
	flyBtn.Text = "Fly"
	flyBtn.Size = UDim2.new(0,95,0,95)--{0, 95},{0, 95}
	flyBtn.Position = UDim2.new(0.919,0,0.663,0)--{0.919, 0},{0.663, 0}
	uikit.ApplyJaysStyleAuto(flyBtn)
	local aspect = Instance.new("UIAspectRatioConstraint", flyBtn)
	aspect.AspectRatio = 1
	aspect.AspectType = Enum.AspectType.ScaleWithParentSize
	aspect.DominantAxis = Enum.DominantAxis.Height
	local padding = Instance.new("UIPadding", flyBtn)
	padding.PaddingLeft = UDim.new(0.1,0)
	padding.PaddingRight = UDim.new(0.1,0)
	padding.PaddingTop = UDim.new(0.1,0)
	padding.PaddingBottom = UDim.new(0.1,0)
	local drag = Instance.new("UIDragDetector", flyBtn)
	
	flyBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			JaysFlyin.ToggleFly({
				speed = 50,
				useCF = false,
				camRotation = true,
				platformStand = true,
				useAnim = true,
			})
		end
	end)
end
THEINITIALIZER()

-- TR-AV
player.CharacterAdded:Connect(THEINITIALIZER)



-- The... You know what? I am tired of- THE MAIN LANE!!!



local function HandleChangement(name, value)
	if value == "t" then
		JaysFlyin.ChangeSettings({[name] = true})
	elseif value == "f" then
		JaysFlyin.ChangeSettings({[name] = false})
	else -- If nothin', then toggle it.
		local orig = JaysFlyin[name]
		local new = not orig
		JaysFlyin.ChangeSettings({[name] = new})
	end
	print("Setting " .. name .. " value changed to", JaysFlyin[name])
end



local function CommandHandler(text)
	local cmd, args = main.GetCommand(text)
	
	if cmd == "speed" then
		local value = tonumber(args[1]) or 50
		JaysFlyin.ChangeSettings({speed = value})
		print("Setted speed to " .. value)
	elseif cmd == "usecf" then
		HandleChangement("usecf", args[1])
	elseif cmd == "camrot" then
		HandleChangement("camrotation", args[1])
	elseif cmd == "platformstand" then
		HandleChangement("platformstand", args[1])
	elseif cmd == "useanim" then
		HandleChangement("useanim", args[1])
	elseif cmd == "reset" then
		JaysFlyin.ChangeSettings({speed = 50, useCF = false, camRotation = true, platformStand = true, useAnim = true})
	elseif cmd == "flingp" then -- Fling Preset
		JaysFlyin.ChangeSettings({speed = JaysFlyin.speed, usecf = true, camrotation = false, platformstand = false, useanim = false})
	end
end

local function Prompter()
	local box = main.Prompter("T.O.P - JaysFlyin'", "Thank you ")
	task.wait(0)
	box.FocusLost:Connect(function(ep)
		CommandHandler(box.Text)
	end)
end



UserInputService.InputBegan:Connect(function(inp, gp)
	if gp then return end
	inp = inp.KeyCode.Name:lower()
	
	-- Fly
	if inp == "f" then
		JaysFlyin.ToggleFly()
	end
	
	if inp == "l" then
		Prompter()
	end
end)
