-- Blade Executor - Full Custom Script Executor GUI (v1.2 Fixed & Ready)
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

-- Hover effect
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
version.Text = "v1.2 • Fixed"
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

-- Close Button
closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- ==================== EYE CLICK TO TOGGLE GUI ====================
local guiOpen = false

eye.MouseButton1Click:Connect(function()
    guiOpen = not guiOpen
    
    if guiOpen then
        main.Visible = true
        main.BackgroundTransparency = 1
        mainStroke.Transparency = 1
        
        -- Fade in animation
        TweenService:Create(main, ti, {BackgroundTransparency = 0}):Play()
        TweenService:Create(mainStroke, ti, {Transparency = 0}):Play()
    else
        -- Fade out then hide
        TweenService:Create(main, ti, {BackgroundTransparency = 1}):Play()
        TweenService:Create(mainStroke, ti, {Transparency = 1}):Play()
        
        task.wait(0.4)
        main.Visible = false
    end
end)

-- Content Container
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -75)
content.Position =