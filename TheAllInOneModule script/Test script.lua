-- Scripted by RBX: @IlIl_ILovAltAccsHAHA / Unofficial Jay | Git: @UnofficialJay3

-- The module checker!
local module
local succ = pcall(function()
	module = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Unofficial-Jays-Stash-Of-Scripts/refs/heads/main/TheAllInOneModule%20script/TheAllInOneModule.lua"))()
end)
if not succ then print("Sorry bro. No module founded.") end

local z = module.services
local Players, UserInputService, RunService, TextChatService = z.Players, z.UserInputService, z.RunService, z.TextChatService
local player, char, root, hum = unpack(module.GetPlayer())
 
local Message = module.Message
Message("lol")

local function Prompter()
	local box = module.Prompter()
	task.wait(0)
	box.FocusLost:Connect(function(ep)
		local cmd, args = module.GetCommand(box.Text)
		if cmd == "test" then
			print("TEST SUCCESSFUL!1!1")
			Message("TEST SUCCESSFUL!1!1")
		end
	end)
end

UserInputService.InputBegan:Connect(function(inp, gp)
	if gp then return end
	inp = inp.KeyCode.Name:lower()
	
	if inp == "m" then
		Prompter()
	end
end)