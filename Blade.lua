-- Blade Executor - Full Custom Script Executor GUI (v1.0 Release Ready)
-- Made for you to release! Fully polished, draggable, animated, with real code editor + console + script hub.

print("welcome to Blade Executor")

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local ti = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local fastTi = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.Parent = game:GetService("CoreGui")

-- Eye Toggle (kept from original Blade X)
local eye = Instance.new("ImageLabel")
eye.Size = UDim2.new(0, 65, 0, 65)
eye.Position = UDim2.new(0.5, -32, 0, 15)
eye.BackgroundTransparency = 1
eye.Image = "rbxassetid://22887903"
eye.ImageColor3 = Color3.fromRGB(255, 60, 60)
eye.Parent = sg

local corner = Instance.new("UICorner", eye)
corner.CornerRadius = UDim.new(1, 0)

local stroke = Instance.new("UIStroke", eye)
stroke.Color = Color3.fromRGB(255, 40, 40)
stroke.Thickness = 4
stroke.Transparency = 0.3

eye.MouseEnter:Connect(function() TweenService:Create(stroke, fastTi, {Thickness = 7, Transparency = 0}):Play() end)
eye.MouseLeave:Connect(function() TweenService:Create(stroke, fastTi, {Thickness = 4, Transparency = 0.3}):Play() end)

-- Main Executor Frame
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 920, 0, 620)
main.Position = UDim2.new(0.5, -460, 0.5, -310)
main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
main.BackgroundTransparency = 1
main.Visible = false
main.Parent = sg

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(255, 40, 40)
mainStroke.Thickness = 2.5

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 55)
titleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
titleBar.Parent = main
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -160, 1, 0)
title.BackgroundTransparency = 1
title.Text = "BLADE EXECUTOR"
title.TextColor3 = Color3.fromRGB(255, 60, 60)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = titleBar

local version = Instance.new("TextLabel")
version.Size = UDim2.new(0, 120, 1, 0)
version.Position = UDim2.new(1, -150, 0, 0)
version.BackgroundTransparency = 1
version.Text = "v1.0 • Ready to Release"
version.TextColor3 = Color3.fromRGB(120, 120, 120)
version.TextXAlignment = Enum.TextXAlignment.Right
version.Font = Enum.Font.Gotham
version.TextSize = 14
version.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

-- Draggable Title Bar
local dragging, dragInput, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)
titleBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Content Container
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -75)
content.Position = UDim2.new(0, 10, 0, 65)
content.BackgroundTransparency = 1
content.Parent = main

-- Sidebar Tabs
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 180, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
sidebar.Parent = content
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

local tabList = Instance.new("UIListLayout", sidebar)
tabList.Padding = UDim.new(0, 6)
tabList.SortOrder = Enum.SortOrder.LayoutOrder
Instance.new("UIPadding", sidebar).PaddingAll = UDim.new(0, 8)

local tabs = {}
local currentTab = nil

local function createSidebarButton(name, icon)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 55)
	btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	btn.Text = "  " .. icon .. "  " .. name
	btn.TextColor3 = Color3.fromRGB(220, 220, 220)
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.Font = Enum.Font.GothamSemibold
	btn.TextSize = 16
	btn.Parent = sidebar
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	
	btn.MouseButton1Click:Connect(function()
		if currentTab then currentTab.Visible = false end
		tabs[name].Visible = true
		currentTab = tabs[name]
		
		for _, b in pairs(sidebar:GetChildren()) do
			if b:IsA("TextButton") then
				b.BackgroundColor3 = (b == btn) and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(25, 25, 25)
			end
		end
	end)
	return btn
end

-- Tab Frames
local executorTab = Instance.new("Frame")
executorTab.Size = UDim2.new(1, -190, 1, 0)
executorTab.Position = UDim2.new(0, 190, 0, 0)
executorTab.BackgroundTransparency = 1
executorTab.Visible = true
executorTab.Parent = content
tabs.Executor = executorTab

local hubTab = Instance.new("Frame")
hubTab.Size = UDim2.new(1, -190, 1, 0)
hubTab.Position = UDim2.new(0, 190, 0, 0)
hubTab.BackgroundTransparency = 1
hubTab.Visible = false
hubTab.Parent = content
tabs.Hub = hubTab

local consoleTab = Instance.new("Frame")
consoleTab.Size = UDim2.new(1, -190, 1, 0)
consoleTab.Position = UDim2.new(0, 190, 0, 0)
consoleTab.BackgroundTransparency = 1
consoleTab.Visible = false
consoleTab.Parent = content
tabs.Console = consoleTab

local settingsTab = Instance.new("Frame")
settingsTab.Size = UDim2.new(1, -190, 1, 0)
settingsTab.Position = UDim2.new(0, 190, 0, 0)
settingsTab.BackgroundTransparency = 1
settingsTab.Visible = false
settingsTab.Parent = content
tabs.Settings = settingsTab

-- Create Sidebar Buttons
createSidebarButton("Executor", "📝")
createSidebarButton("Script Hub", "📚")
createSidebarButton("Console", "📟")
createSidebarButton("Settings", "⚙️")

-- EXECUTOR TAB - Real Code Editor
local editorFrame = Instance.new("ScrollingFrame")
editorFrame.Size = UDim2.new(1, 0, 1, -70)
editorFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
editorFrame.ScrollBarThickness = 8
editorFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 60, 60)
editorFrame.Parent = executorTab
Instance.new("UICorner", editorFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIPadding", editorFrame).PaddingAll = UDim.new(0, 12)

local codeBox = Instance.new("TextBox")
codeBox.Size = UDim2.new(1, 0, 0, 2000) -- large for scrolling
codeBox.BackgroundTransparency = 1
codeBox.Text = "-- Welcome to Blade Executor!\n-- Paste or write your script here\nprint(\"Blade Executor loaded!\")"
codeBox.TextColor3 = Color3.fromRGB(240, 240, 240)
codeBox.TextXAlignment = Enum.TextXAlignment.Left
codeBox.TextYAlignment = Enum.TextYAlignment.Top
codeBox.TextWrapped = false
codeBox.MultiLine = true
codeBox.ClearTextOnFocus = false
codeBox.Font = Enum.Font.Code
codeBox.TextSize = 17
codeBox.Parent = editorFrame

-- Bottom Bar for Executor
local execBar = Instance.new("Frame")
execBar.Size = UDim2.new(1, 0, 0, 60)
execBar.Position = UDim2.new(0, 0, 1, -60)
execBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
execBar.Parent = executorTab
Instance.new("UICorner", execBar).CornerRadius = UDim.new(0, 10)

local executeBtn = Instance.new("TextButton")
executeBtn.Size = UDim2.new(0, 140, 0, 45)
executeBtn.Position = UDim2.new(0, 20, 0, 8)
executeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
executeBtn.Text = "EXECUTE"
executeBtn.TextColor3 = Color3.new(1,1,1)
executeBtn.Font = Enum.Font.GothamBold
executeBtn.TextSize = 18
executeBtn.Parent = execBar
Instance.new("UICorner", executeBtn).CornerRadius = UDim.new(0, 8)

local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0, 100, 0, 45)
clearBtn.Position = UDim2.new(0, 180, 0, 8)
clearBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
clearBtn.Text = "CLEAR"
clearBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
clearBtn.Font = Enum.Font.GothamSemibold
clearBtn.TextSize = 16
clearBtn.Parent = execBar
Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0, 8)

-- EXECUTE LOGIC
local consoleLog
local function logConsole(text, color)
	color = color or Color3.fromRGB(200, 200, 200)
	local logLine = Instance.new("TextLabel")
	logLine.Size = UDim2.new(1, -20, 0, 22)
	logLine.BackgroundTransparency = 1
	logLine.Text = " > " .. text
	logLine.TextColor3 = color
	logLine.TextXAlignment = Enum.TextXAlignment.Left
	logLine.Font = Enum.Font.Code
	logLine.TextSize = 15
	logLine.Parent = consoleScroll
	consoleScroll.CanvasSize = UDim2.new(0, 0, 0, consoleScroll.UIListLayout.AbsoluteContentSize.Y + 20)
end

consoleLog = logConsole -- global for easy use in scripts

executeBtn.MouseButton1Click:Connect(function()
	local code = codeBox.Text
	logConsole("Executing script...", Color3.fromRGB(255, 200, 60))
	
	local success, err = pcall(function()
		loadstring(code)()
	end)
	
	if success then
		logConsole("Script executed successfully ✓", Color3.fromRGB(80, 255, 80))
	else
		logConsole("ERROR: " .. tostring(err), Color3.fromRGB(255, 80, 80))
	end
end)

clearBtn.MouseButton1Click:Connect(function()
	codeBox.Text = ""
end)

-- SCRIPT HUB TAB
local hubScroll = Instance.new("ScrollingFrame")
hubScroll.Size = UDim2.new(1, 0, 1, 0)
hubScroll.BackgroundTransparency = 1
hubScroll.ScrollBarThickness = 6
hubScroll.Parent = hubTab
local hubLayout = Instance.new("UIListLayout", hubScroll)
hubLayout.Padding = UDim.new(0, 10)
Instance.new("UIPadding", hubScroll).PaddingAll = UDim.new(0, 15)

local function addHubScript(name, description, code)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, -10, 0, 90)
	card.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	card.Parent = hubScroll
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
	
	local titleLbl = Instance.new("TextLabel")
	titleLbl.Size = UDim2.new(1, -140, 0, 40)
	titleLbl.Position = UDim2.new(0, 15, 0, 8)
	titleLbl.BackgroundTransparency = 1
	titleLbl.Text = name
	titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLbl.Font = Enum.Font.GothamBold
	titleLbl.TextSize = 18
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.Parent = card
	
	local descLbl = Instance.new("TextLabel")
	descLbl.Size = UDim2.new(1, -140, 0, 30)
	descLbl.Position = UDim2.new(0, 15, 0, 45)
	descLbl.BackgroundTransparency = 1
	descLbl.Text = description
	descLbl.TextColor3 = Color3.fromRGB(160, 160, 160)
	descLbl.Font = Enum.Font.Gotham
	descLbl.TextSize = 14
	descLbl.TextXAlignment = Enum.TextXAlignment.Left
	descLbl.Parent = card
	
	local loadBtn = Instance.new("TextButton")
	loadBtn.Size = UDim2.new(0, 110, 0, 35)
	loadBtn.Position = UDim2.new(1, -130, 0, 28)
	loadBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
	loadBtn.Text = "LOAD"
	loadBtn.TextColor3 = Color3.new(1,1,1)
	loadBtn.Font = Enum.Font.GothamBold
	loadBtn.TextSize = 16
	loadBtn.Parent = card
	Instance.new("UICorner", loadBtn).CornerRadius = UDim.new(0, 8)
	
	loadBtn.MouseButton1Click:Connect(function()
		codeBox.Text = code
		logConsole("Loaded \"" .. name .. "\" into editor", Color3.fromRGB(100, 200, 255))
		-- Auto-switch to Executor tab
		if currentTab then currentTab.Visible = false end
		executorTab.Visible = true
		currentTab = executorTab
	end)
end

-- Example scripts for your release (you can add hundreds more)
addHubScript("Infinite Yield Admin", "Popular admin commands", "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()")
addHubScript("Fly Script", "Simple fly with N key", "loadstring(game:HttpGet('https://pastebin.com/raw/4v4v4v4v'))() -- replace with real link")
addHubScript("ESP + Tracers", "Player ESP with red boxes", "local esp = loadstring(game:HttpGet('https://raw.githubusercontent.com/whatever/esp'))() esp:Toggle(true)")
addHubScript("Hello Blade!", "Test script", "print(\"🔥 Blade Executor is the best!\")\nprint(\"Made with love by you <3\")")

-- CONSOLE TAB
local consoleScroll = Instance.new("ScrollingFrame")
consoleScroll.Size = UDim2.new(1, 0, 1, 0)
consoleScroll.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
consoleScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 60, 60)
consoleScroll.Parent = consoleTab
Instance.new("UICorner", consoleScroll).CornerRadius = UDim.new(0, 10)
local consoleLayout = Instance.new("UIListLayout", consoleScroll)
consoleLayout.SortOrder = Enum.SortOrder.LayoutOrder
consoleLayout.Padding = UDim.new(0, 2)
Instance.new("UIPadding", consoleScroll).PaddingAll = UDim.new(0, 12)

logConsole("Blade Executor Console Initialized", Color3.fromRGB(80, 255, 80))
logConsole("Ready for scripts • Click the eye or press RightShift", Color3.fromRGB(255, 200, 60))

-- SETTINGS TAB (basic but expandable)
local settingsList = Instance.new("Frame")
settingsList.Size = UDim2.new(1, 0, 1, 0)
settingsList.BackgroundTransparency = 1
settingsList.Parent = settingsTab

local autoExec = Instance.new("TextLabel")
autoExec.Size = UDim2.new(1, 0, 0, 40)
autoExec.Text = "Auto-Execute on Join: OFF"
autoExec.TextColor3 = Color3.fromRGB(255,255,255)
autoExec.BackgroundTransparency = 1
autoExec.Parent = settingsList

local keybindLabel = Instance.new("TextLabel")
keybindLabel.Size = UDim2.new(1, 0, 0, 40)
keybindLabel.Position = UDim2.new(0, 0, 0, 50)
keybindLabel.Text = "Toggle Keybind: RightShift"
keybindLabel.TextColor3 = Color3.fromRGB(255,255,255)
keybindLabel.BackgroundTransparency = 1
keybindLabel.Parent = settingsList

-- Toggle GUI Function with nice scale animation
local open = false
local function toggleGUI(state)
	open = state
	if open then
		main.Visible = true
		main.Size = UDim2.new(0, 920 * 0.85, 0, 620 * 0.85)
		main.BackgroundTransparency = 1
		TweenService:Create(main, ti, {
			Size = UDim2.new(0, 920, 0, 620),
			BackgroundTransparency = 0
		}):Play()
	else
		local tween = TweenService:Create(main, ti, {
			Size = UDim2.new(0, 920 * 0.85, 0, 620 * 0.85),
			BackgroundTransparency = 1
		})
		tween:Play()
		tween.Completed:Connect(function() if not open then main.Visible = false end end)
	end
end

-- Eye + Keybind
eye.InputBegan:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1 then
		toggleGUI(not open)
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	toggleGUI(false)
end)

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		toggleGUI(not open)
	end
end)

-- Set default tab
currentTab = executorTab

print("blade executor loaded - click the glowing eye or press RightShift")
print("Ready for release! Add your own scripts to the hub and customize colors if you want.")
