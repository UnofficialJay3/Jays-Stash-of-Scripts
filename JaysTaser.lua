-- Made by RBX: @IlIl_ILovAltAccsHAHA / Unofficial Jay | Git: UnofficialJay3
print("JAY'S TASER!1!1 AAAAAA!!! Emote menu is gone now :)")

-- Configs
local playbackSpeed = 1
local useCam = false
local filePath = "TAS_SavedActions.json" -- Exec- exclusive only. Sorry.

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

-- Variables
StarterGui:SetCoreGuiEnabled(Enum. CoreGuiType. EmotesMenu, false)
local player = Players.LocalPlayer
local plrGui = player:WaitForChild("PlayerGui")
local gui = Instance.new("ScreenGui", plrGui)
gui.Name = "ASDASDASD"
local cam = workspace.CurrentCamera
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")
local SavedActions = {}
local recordingTAS = false
local recording = false
local playing = false
local playbackConnection -- store Heartbeat connection for disconnect
local playbackStartTime
local playbackBaseTime
local recordStartTime = 0
local RecordIndex = 0
local PlaybackIndex = 0
local aKeysConnection
local aKeysToggle = false
local fbState = {
	f = false,
	b = false
}



-- The main lane? THE MAIN LANE IS REEEEAAAAL!



-- Init player
local function InitPlr()
	char = player.Character or player.CharacterAdded:Wait()
	root = char:WaitForChild("HumanoidRootPart")
	humanoid = char:WaitForChild("Humanoid")

	gui = Instance.new("ScreenGui", plrGui)
	gui.Name = "ASDASDASD"
end
player.CharacterAdded:Connect(InitPlr)


-- The prompter prompt
local function Prompt(state)
	-- Create prompt
	local ui = Instance.new("TextBox", gui)
	ui.Size = UDim2.new(0.5, 0, 0.5, 0)
	ui.Position = UDim2.new(0.25, 0, 0.25, 0)
	ui.TextScaled = true
	task.delay(0, function()
		ui.Text = ""
		task.wait(0)
		ui.Text = ""
	end)

	ui:CaptureFocus()

	ui.FocusLost:Connect(function(ep)
		local text = ui.Text:lower()
		local args = string.split(text, " ")
		local command = args[1]
		table.remove(args, 1)

		if ep then
			if not state then
				if command == "speed" then
					--Prompt("speed")
					if args[1] and tonumber(args[1]) then
						playbackSpeed = tonumber(args[1])
						print("Playback speed changed to " .. playbackSpeed)
					end
				elseif text == "cam" then
					useCam = not useCam
					print("Using cam is: " .. tostring(useCam):upper())
				elseif text == "save" then
					pcall(function()
						local json = HttpService:JSONEncode(SavedActions)
						writefile("TAS_SavedActions.json", json)
					end)
				elseif text == "load" then
					pcall(function()
						local data = readfile("TAS_SavedActions.json")
						SavedActions = HttpService:JSONDecode(data)
					end)
				elseif command == "akeys" then
					aKeysToggle = not aKeysToggle
					print("Alginment keys: " .. tostring(aKeysToggle):upper())
					if aKeysToggle then
						task.spawn(function()
							aKeysConnection = UserInputService.InputBegan:Connect(function(inp, gp)
								if gp then return end
								inp = inp.KeyCode.Name:lower()

								if inp == "comma" then
									game.Workspace.CurrentCamera:PanUnits(-1)
								elseif inp == "period" then
									game.Workspace.CurrentCamera:PanUnits(1)
								end
							end)
						end)
					else
						if aKeysConnection then
							aKeysConnection:Disconnect()
						end
					end
				end
			elseif state == "speed" then
				if tonumber(text) then
					playbackSpeed = tonumber(text)
					print("Playback speed changed to " .. playbackSpeed)
				end
			end
		end

		ui:Destroy()
	end)
end



-- Save/load playuh actions
local function SaveActions()
	local lastTime = 0
	if #SavedActions > 0 then
		lastTime = SavedActions[#SavedActions].t
	end

	table.insert(SavedActions, {
		t = lastTime + RunService.Heartbeat:Wait(), -- approximate delta time
		cf = root.CFrame,
		vel = root.AssemblyLinearVelocity,
		angvel = root.AssemblyAngularVelocity,
		humsat = humanoid:GetState(),
		jump = humanoid.Jump,
		plat = humanoid.PlatformStand,
		sit = humanoid.Sit,
		camData = {
			ccf = cam.CFrame, -- actual camera rotation + position
			camType = cam.CameraType,
			focus = cam.Focus, -- target CFrame the camera is looking at
			offset = cam.CFrame.Position - cam.Focus.Position, -- approximate offset
			subject = cam.CameraSubject,
		}
	})
end


local function LoadAction(i)
	local action = SavedActions[i]
	if action then
		root.CFrame = action.cf
		root.AssemblyLinearVelocity = action.vel
		root.AssemblyAngularVelocity = action.angvel
		humanoid:ChangeState(action.humsat)
		humanoid.Jump = action.jump
		humanoid.PlatformStand = action.plat
		humanoid.Sit = action.sit
		--UserGameSettings.RotationType = action.lock and Enum.RotationType.CameraRelative or Enum.RotationType.MovementRelative
		if action.camData and useCam then
			local cd = action.camData
			cam.CFrame = cd.ccf
			cam.CameraType = cd.camType
			cam.Focus = cd.focus
		end
	end
end



-- Freeze/unfreeze player
local function Freeze()
	root.Anchored = true
	humanoid.AutoRotate = false
end

local function Unfreeze()
	root.Anchored = false
	humanoid.AutoRotate = true
end



-- Step forward/backward 1 frame
local function StepForward()
	RecordIndex += 1
	if RecordIndex > #SavedActions then
		RecordIndex -= 1
		return true
	end
	LoadAction(RecordIndex)
	print(RecordIndex)
	return false
end

local function StepBackward()
	RecordIndex -= 1
	if RecordIndex < 0 then
		RecordIndex += 1
		return true
	end
	LoadAction(RecordIndex)
	print(RecordIndex)
	return false
end



-- Trim actions
local function TrimActions(ind)
	RecordIndex = ind
	if ind < #SavedActions then
		for i = #SavedActions, ind + 1, -1 do
			table.remove(SavedActions, i)
		end
	end

	-- Rebase timestamps so first frame starts at 0
	if #SavedActions > 0 then
		local baseTime = SavedActions[1].t
		for i, action in ipairs(SavedActions) do
			action.t = action.t - baseTime
		end
		recordStartTime = os.clock() -- reset so new saves start from 0
	end
end



-- Step 1 frame
local function Step()
	TrimActions(RecordIndex)
	task.spawn(function()
		Unfreeze()
		task.wait()
		Freeze()
		RecordIndex += 1	
		SaveActions()
		print(RecordIndex)
	end)
end



-- Unusual step?
local function UsusalStep()
	for _ = 1, 3 do
		Step()
		task.wait()
	end
end



-- Play/stop playback
local function StopPlayback()
	if playbackConnection then
		playbackConnection:Disconnect()
		playbackConnection = nil
	end
	humanoid.AutoRotate = true
	playing = false
	print("Playback stopped.")
end

local function StartPlayback()
	if #SavedActions == 0 then
		warn("No TAS to play!")
		return
	end
	if playing then return end

	print("Playback started.")
	playing = true
	PlaybackIndex = 1
	playbackStartTime = os.clock()

	humanoid.AutoRotate = false

	playbackConnection = RunService.Heartbeat:Connect(function()
		if not playing then return end

		local elapsed = (os.clock() - playbackStartTime) * playbackSpeed
		LoadAction(PlaybackIndex)
		while PlaybackIndex <= #SavedActions and SavedActions[PlaybackIndex].t <= elapsed do
			--LoadAction(PlaybackIndex)
			PlaybackIndex += 1
		end

		if PlaybackIndex > #SavedActions then
			humanoid.AutoRotate = false
			print("Playback finished.")
			StopPlayback()
		end
	end)
end



-- Input handler
UserInputService.InputBegan:Connect(function(inp, gp)
	if gp then return end
	inp = inp.KeyCode.Name:lower()

	if inp == "two" then
		recordingTAS = not recordingTAS
		if recordingTAS then
			print("Recording.")
			Freeze()

			if SavedActions then
				RecordIndex = #SavedActions
				LoadAction(#SavedActions)
			end
		else
			recording = false
			Unfreeze()
		end
	end

	if inp == "three" then
		if playing then
			StopPlayback()
		else
			recording = false
			Unfreeze()
			StartPlayback()
		end
	end

	if inp == "k" then
		Prompt()
	end

	if inp == "backspace" then
		RecordIndex = 0
		PlaybackIndex = 0
		SavedActions = {}
	end



	if not recordingTAS then return end


	if inp == "e" then
		recording = not recording
		if recording then
			TrimActions(RecordIndex)

			-- Reset recording clock
			recordStartTime = os.clock()
			for i, action in ipairs(SavedActions) do
				action.t = action.t - SavedActions[1].t
			end

			Unfreeze()
		else
			Freeze()
		end
	end

	if inp == "f" then
		StepBackward()
	end
	if inp == "g" then
		StepForward()
	end

	if inp == "r" then
		fbState["b"] = true
	end
	if inp == "t" then
		fbState["f"] = true
	end

	if inp == "v" then
		--TrimActions(RecordIndex)
		Step()
	end
	if inp == "c" then
		UsusalStep()
	end
end)
UserInputService.InputEnded:Connect(function(inp, gp)
	if gp then return end
	inp = inp.KeyCode.Name:lower()

	if inp == "r" then
		fbState["b"] = false
	end
	if inp == "t" then
		fbState["f"] = false
	end
end)



-- Loop
RunService.Heartbeat:Connect(function(dt)
	if recordingTAS then
		if recording then
			SaveActions()
			RecordIndex += 1
			print(RecordIndex)
		end

		if fbState["f"] then
			StepForward()
		elseif fbState["b"] then
			StepBackward()
		end
	end

	--print("Index:", Index)
end)