task.wait(0.5)

-- The module checker!
local module local succ=pcall(function()module=require(game.ReplicatedStorage.TheAllInOneModule)end)if not succ then succ=pcall(function()module=loadstring(game:HttpGet("The Link"))()end)end if not succ then print("No can do! Can't get the module.") return end


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