-- Blade Executor v1.9 - XENO OPTIMIZED (Force Open Fixed)
print("🔥 Blade Executor v1.9 for XENO starting...")

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local ti = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.Parent = game:GetService("CoreGui")

-- ==================== GLOWING EYE ====================
local eye = Instance.new("ImageLabel")
eye.Size = UDim2.new(0, 65, 0, 65)
eye.Position = UDim2.new(0.5, -32, 0, 15)
eye.BackgroundTransparency = 1
eye.Image = "rbxassetid://22887903"
eye.ImageColor3 = Color3.fromRGB(255, 60, 60)
eye.Parent = sg

Instance.new("UICorner", eye).CornerRadius = UDim.new(1, 0)

local stroke = Instance.new("UIStroke", eye)
stroke.Color = Color3.fromRGB(255, 40, 40)
stroke.Thickness = 5
stroke.Transparency = 0.2

eye.MouseEnter:Connect(function()
    TweenService:Create(stroke, TweenInfo.new(0.2), {Thickness = 9, Transparency = 0}):Play()
end)
eye.MouseLeave:Connect(function()
    TweenService:Create(stroke, TweenInfo.new(0.2), {Thickness = 5, Transparency = 0.2}):Play()
end)

-- ==================== MAIN FRAME ====================
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
mainStroke.Thickness = 3

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 55)
titleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
titleBar.Parent = main
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 14)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -160, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "BLADE EXECUTOR"
titleLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

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

closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- Simple Draggable
local dragging = false
local dragInput, dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ==================== TOGGLE FUNCTION ====================
local function openGUI()
    main.Visible = true
    main.BackgroundTransparency = 1
    mainStroke.Transparency = 1
    TweenService:Create(main, ti, {BackgroundTransparency = 0}):Play()
    TweenService:Create(mainStroke, ti, {Transparency = 0}):Play()
end

local function closeGUI()
    TweenService:Create(main, ti, {BackgroundTransparency = 1}):Play()
    TweenService:Create(mainStroke, ti, {Transparency = 1}):Play()
    task.wait(0.45)
    main.Visible = false
end

eye.MouseButton1Click:Connect(function()
    if main.Visible then
        closeGUI()
    else
        openGUI()
    end
end)

-- Left Ctrl toggle
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.LeftControl then
        if main.Visible then closeGUI() else openGUI() end
    end
end)

-- ==================== FORCE OPEN FOR XENO ====================
task.spawn(function()
    task.wait(1.2)   -- Longer delay because Xeno needs more time
    openGUI()
    print("✅ Blade Executor v1.9 opened for XENO! Click the glowing red eye to hide/show.")
end)

print("Blade Executor injected into Xeno - waiting for auto open...")