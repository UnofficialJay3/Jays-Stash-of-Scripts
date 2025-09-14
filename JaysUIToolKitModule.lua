-- Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: @UnofficialJay3
local module = {}

-- Services
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")


-- Main lane


-- Properties for transparency
local fadeProps = {
	Frame = {"BackgroundTransparency"},
	TextLabel = {"BackgroundTransparency", "TextTransparency", "TextStrokeTransparency"},
	TextButton = {"BackgroundTransparency", "TextTransparency", "TextStrokeTransparency"},
	ImageLabel = {"BackgroundTransparency", "ImageTransparency"},
	ImageButton = {"BackgroundTransparency", "ImageTransparency"},
	UIStroke = {"Transparency"},
}

-- SoundById
function module.SoundById(id, speed, vol, RS)
	if not id then return end
	local s = Instance.new("Sound", SoundService)
	s.SoundId = "rbxassetid://" .. id
	s.PlaybackSpeed = speed or 1
	if RS then
		s.PlaybackSpeed = math.random(80,120)/100
	end
	s.Volume = vol or 1
	s.PlayOnRemove = true
	s:Destroy()
end


-- Initialize UI | Setting up original size + other sizes, etc.
function module.InitUi(ui, sizes) -- (ui, hoverSize, pressSize, fadeOutSize)
	-- Sizes
	local origSize = ui.Size
	local hoverSize = sizes.hover -- Has the offset
	local pressSize = sizes.press -- Will add original size and [Name] size to it.
	local fadeOutSize = sizes.fadeOut
	
	ui:SetAttribute("Orig_Size", ui.Size)
	ui:SetAttribute("HoverSize", hoverSize)
	ui:SetAttribute("PressSize", pressSize)
	ui:SetAttribute("FadeOutSize", fadeOutSize)
	
	-- Other
	ui:SetAttribute("PosSizeTweening", false)
	ui:SetAttribute("Position", ui.Position)
	ui:SetAttribute("TranspTweening", nil)
	ui:SetAttribute("IsHover", false)
	ui:SetAttribute("IsPress", false)
	
	-- Transparency
	-- helper to save properties as attributes
	local function saveProps(obj)
		local props = fadeProps[obj.ClassName]
		if props then
			for _, prop in ipairs(props) do
				if obj[prop] ~= nil then
					obj:SetAttribute("Orig_" .. prop, obj[prop])
				end
			end
		end
	end

	-- save main object
	saveProps(ui)
	-- save children too
	for _, child in ipairs(ui:GetChildren()) do
		saveProps(child)
	end
end



-- Hover effect
function module.HoverEffect(ui, sounds)
	-- Sizes
	local sizeA = ui:GetAttribute("Orig_Size")
	local sizeB = sizeA + ui:GetAttribute("HoverSize")
	
	ui:GetAttributeChangedSignal("Orig_Size"):Connect(function()
		sizeA = ui:GetAttribute("Orig_Size")
		sizeB = sizeA + ui:GetAttribute("HoverSize")
	end)
	
	-- Functionality
	ui.MouseEnter:Connect(function()
		if ui:GetAttribute("PosSizeTweening") then return end
		ui:TweenSize(sizeB, "Out", "Quad", 0.15, true)
		ui:SetAttribute("IsHover", true)
		
		if sounds.a then
			local id, vol, RS = sounds.a[1], sounds.a[2], sounds.a[3]
			module.SoundById(id, 1, vol, RS)
		end
	end)
	
	ui.MouseLeave:Connect(function()
		if ui:GetAttribute("PosSizeTweening") then return end
		ui:TweenSize(sizeA, "In", "Quad", 0.15, true)
		ui:SetAttribute("IsHover", false)
		
		if sounds.b then
			local id, vol, RS = sounds.b[1], sounds.b[2], sounds.b[3]
			module.SoundById(id, 1, vol, RS)
		end
	end)
end



-- Button press effect
function module.BPressEffect(ui, sounds)
	-- Sizes
	local sizeA = ui:GetAttribute("Orig_Size")
	local sizeB = ui:GetAttribute("HoverSize")
	local sizeC = sizeA + ui:GetAttribute("PressSize")
	
	ui:GetAttributeChangedSignal("Orig_Size"):Connect(function()
		sizeA = ui:GetAttribute("Orig_Size")
		sizeC = sizeA + ui:GetAttribute("PressSize")
	end)

	-- Functionality
	ui.MouseButton1Down:Connect(function()
		if ui:GetAttribute("PosSizeTweening") then return end
		if ui:GetAttribute("IsHover") then
			ui:TweenSize(sizeC + sizeB, "Out", "Quad", 0.15, true)
		else
			ui:TweenSize(sizeC, "Out", "Quad", 0.15, true)
		end
		ui:SetAttribute("IsPress", true)

		if sounds.a then
			local id, vol, RS = sounds.a[1], sounds.a[2], sounds.a[3]
			module.SoundById(id, 1, vol, RS)
		end
	end)

	ui.MouseButton1Up:Connect(function()
		if ui:GetAttribute("PosSizeTweening") then return end
		if ui:GetAttribute("IsHover") then
			ui:TweenSize(sizeB + sizeA, "In", "Quad", 0.15, true)
		else
			ui:TweenSize(sizeA, "In", "Quad", 0.15, true)
		end
		ui:SetAttribute("IsPress", false)

		if sounds.b then
			local id, vol, RS = sounds.b[1], sounds.b[2], sounds.b[3]
			module.SoundById(id, 1, vol, RS)
		end
	end)
end



-- Tween position
function module.TweenPosition(ui, newP, easeData)
	ui:SetAttribute("PosSizeTweening", true)
	local dur = easeData[1] or 1
	local easeStyle = easeData[2] or "Linear"
	local easeDirection = easeData[3] or "InOut"
	--ui.Position = ui:GetAttribute("Position") or ui.Position
	ui:SetAttribute("Position", newP)
	
	ui:TweenPosition(newP, easeDirection, easeStyle, dur, true)
	
	task.delay(dur, function()
		ui:SetAttribute("PosSizeTweening", false)
	end)
end



-- Tween Size
function module.TweenSize(ui, newSize, easeData)
	ui:SetAttribute("PosSizeTweening", true)
	local dur = easeData[1] or 1
	local easeStyle = easeData[2] or "Linear"
	local easeDirection = easeData[3] or "InOut"
	--ui.Size = ui:GetAttribute("Orig_Size") or ui.Size
	ui:SetAttribute("Orig_Size", newSize)

	ui:TweenSize(newSize, easeDirection, easeStyle, dur, true)
	
	task.delay(dur, function()
		ui:SetAttribute("PosSizeTweening", false)
	end)
end



-- Tween Position + Size
function module.TweenPosSize(ui, newP, newSize, easeData)
	module.TweenPosition(ui, newP, easeData)
	module.TweenSize(ui, newSize, easeData)
end



-- Tween UI transparency
function module.FadeOut(ui, dur, sizeAnim)
	ui:SetAttribute("TranspTweening", "Out")
	if sizeAnim then
		local a = ui:GetAttribute("Orig_Size")
		ui:SetAttribute("Orig_Size", a + sizeAnim)
		ui:TweenSize(a + sizeAnim, "Out", "Quad", dur, true)
	end
	
	local props = fadeProps[ui.ClassName]
	if props then
		local goal = {}
		for _, prop in ipairs(props) do
			if ui[prop] ~= nil then
				goal[prop] = 1 -- invisible
			end
		end
		local tween = TweenService:Create(ui, TweenInfo.new(dur or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), goal)
		tween:Play()
	end

	-- fade children too
	for _, child in ipairs(ui:GetChildren()) do
		module.FadeOut(child, dur)
	end
	
	task.delay(dur, function()
		if ui:GetAttribute("TranspTweening") == "Out" then
			pcall(function()
				ui.Visible = false
			end)
		end
		ui:SetAttribute("TranspTweening", nil)
	end)
end

function module.FadeIn(ui, dur, sizeAnim)
	ui:SetAttribute("TranspTweening", "In")
	pcall(function()
		ui.Visible = true
	end)
	if sizeAnim then
		local a = ui:GetAttribute("Orig_Size")
		ui:SetAttribute("Orig_Size", a + sizeAnim)
		ui:TweenSize(a + sizeAnim, "Out", "Quad", dur, true)
	end
	
	local props = fadeProps[ui.ClassName]
	if props then
		local goal = {}
		for _, prop in ipairs(props) do
			local orig = ui:GetAttribute("Orig_" .. prop)
			if orig ~= nil then
				goal[prop] = orig
			end
		end
		local tween = TweenService:Create(ui, TweenInfo.new(dur or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal)
		tween:Play()
	end

	-- fade children too
	for _, child in ipairs(ui:GetChildren()) do
		module.FadeIn(child, dur)
	end
	
	task.delay(dur, function()
		ui:SetAttribute("TranspTweening", nil)
	end)
end



-- Apply modern? Style
function module.Unused1(ui) -- I dare you to use this >:)
	ui.BackgroundColor3 = Color3.fromRGB(0,0,0)
	ui.BackgroundTransparency = 0.75
	
	local a = Instance.new("UICorner", ui)
	a.CornerRadius = UDim.new(0.075, 0)
	
	a = Instance.new("UIStroke", ui)
	a.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	a.Color = Color3.fromRGB(0,0,0)
	a.Thickness = 5
	
	a = Instance.new("UIStroke", ui)
	a.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	a.Color = Color3.fromRGB(0,0,0)
	a.Thickness = 3
	
	pcall(function()
		ui.TextColor3 = Color3.fromRGB(255,255,255)
	end)
end



-- Reclass function
function module.Reclass(ui, newClassName)
	if not ui or not newClassName then return end

	-- Create new instance
	local newUI = Instance.new(newClassName)
	newUI.Name = ui.Name

	-- Copy properties
	for _, prop in ipairs({
		"AnchorPoint","AutomaticSize","BackgroundColor3","BackgroundTransparency",
		"BorderColor3","BorderSizePixel","ClipsDescendants","LayoutOrder",
		"Position","Rotation","Size","SizeConstraint","Visible","ZIndex"
		}) do
		pcall(function()
			newUI[prop] = ui[prop]
		end)
	end

	-- Try to copy class-specific properties
	for _, prop in ipairs({
		"Text","Font","TextColor3","TextSize","TextStrokeTransparency",
		"TextTransparency","TextWrapped","TextScaled","PlaceholderText",
		"Image","ImageTransparency","ScaleType","TileSize"
		}) do
		pcall(function()
			newUI[prop] = ui[prop]
		end)
	end

	-- Copy attributes
	for _, attr in ipairs(ui:GetAttributes()) do
		local val = ui:GetAttribute(attr)
		newUI:SetAttribute(attr, val)
	end

	-- Copy children (like UIStroke, UICorner, etc.)
	for _, child in ipairs(ui:GetChildren()) do
		child:Clone().Parent = newUI
	end

	-- Parent to original parent, same spot
	newUI.Parent = ui.Parent

	-- Destroy the old one
	ui:Destroy()

	return newUI
end


-- Real Apply Jays Style Automatic
function module.ApplyJaysStyleAuto(ui) -- Has the transp, corner radiuses, and other stuff to a fixed value. For the regular ApplyJaysStyle you can manually set these values.
	-- Usual stuff
	ui.BackgroundColor3 = Color3.fromRGB(0,0,0)
	ui.BackgroundTransparency = 0.75
	
	local corner = Instance.new("UICorner", ui)
	corner.CornerRadius = UDim.new(0.075, 0)
	
	local border = Instance.new("UIStroke", ui)
	border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	border.Color = Color3.fromRGB(0,0,0)
	border.Thickness = 5
	
	-- Text label/box
	if ui:IsA("TextLabel") or ui:IsA("TextBox") then
		ui.TextColor3 = Color3.fromRGB(255,255,255)
		ui.TextScaled = true
		
		local contextual = Instance.new("UIStroke", ui)
		contextual.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
		contextual.Color = Color3.fromRGB(0,0,0)
		contextual.Thickness = 3
	end
	
	return corner, border
end




return module
