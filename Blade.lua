-- Blade Executor - Full Custom Script Executor GUI (v1.1 Fixed & Ready)
-- The glowing eye at the top now reliably opens the GUI

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

-- ==================== EYE TOGGLE (Top Button) ====================
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

eye.MouseEnter:Connect(function()
    TweenService:Create(stroke, fastTi, {Thickness = 7, Transparency = 0}):Play()
end)

eye.MouseLeave:Connect(function()
    TweenService:Create(stroke, fastTi, {Thickness = 4, Transparency = 0.3}):Play()
end)

-- ==================== MAIN EXECUTOR FRAME ====================
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
version.Text = "v1.1 • Fixed"
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
    if input.UserInputType == Enum.UserInputType.MouseMovement then 
        dragInput = input 
    end
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

-- Sidebar
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

-- EXECUTOR TAB - Code Editor
local editorFrame = Instance.new("ScrollingFrame")
editorFrame.Size = UDim