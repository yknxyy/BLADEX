-- Blade X Black Box - Kicia Edition (Rivals Focused)
-- Loads KiciaHook V2 - Features: Aimbot, Silent Aim, Rage, ESP, Anti-Katana, etc.

print("🔥 Blade X Kicia Edition loaded for Rivals!")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BladeX_Kicia"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 920, 0, 620)
Main.Position = UDim2.new(0.5, -460, 0.5, -310)
Main.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Main

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(60, 60, 60)
UIStroke.Thickness = 1.5
UIStroke.Parent = Main

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 55)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

-- Icon
local IconFrame = Instance.new("Frame")
IconFrame.Size = UDim2.new(0, 46, 0, 46)
IconFrame.Position = UDim2.new(0, 14, 0, 5)
IconFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IconFrame.Parent = TopBar

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(0, 10)
IconCorner.Parent = IconFrame

local IconLabel = Instance.new("TextLabel")
IconLabel.Size = UDim2.new(1, 0, 1, 0)
IconLabel.BackgroundTransparency = 1
IconLabel.Text = "⚔️"
IconLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
IconLabel.TextScaled = true
IconLabel.Font = Enum.Font.GothamBlack
IconLabel.Parent = IconFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 340, 1, 0)
Title.Position = UDim2.new(0, 72, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "BLADE X - KICIA EDITION"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local Version = Instance.new("TextLabel")
Version.Size = UDim2.new(0, 150, 1, 0)
Version.Position = UDim2.new(0, 410, 0, 0)
Version.BackgroundTransparency = 1
Version.Text = "Rivals • KiciaHook V2"
Version.TextColor3 = Color3.fromRGB(0, 200, 100)
Version.TextScaled = true
Version.Font = Enum.Font.Gotham
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.Parent = TopBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0.5, -20)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Tabs
local Tabs = {"Execute", "Rivals Hacks"}
local TabButtons = {}
local TabFrames = {}

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, 0, 0, 50)
TabContainer.Position = UDim2.new(0, 0, 0, 55)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = Main

for i, tabName in ipairs(Tabs) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0, 140, 0, 40)
    TabBtn.Position = UDim2.new(0, 20 + (i-1)*150, 0, 5)
    TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabBtn.Text = tabName
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.Parent = TabContainer
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = TabBtn
    
    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(1, 0, 1, -105)
    TabFrame.Position = UDim2.new(0, 0, 0, 105)
    TabFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    TabFrame.Visible = (i == 1)
    TabFrame.Parent = Main
    
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 10)
    FrameCorner.Parent = TabFrame
    
    TabButtons[tabName] = TabBtn
    TabFrames[tabName] = TabFrame
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, f in pairs(TabFrames) do f.Visible = false end
        TabFrame.Visible = true
        for _, btn in pairs(TabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        TabBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        TabBtn.TextColor3 = Color3.new(1, 1, 1)
    end)
end

-- Execute Tab (for running any extra Lua)
local ExecuteTab = TabFrames["Execute"]

local Editor = Instance.new("TextBox")
Editor.Size = UDim2.new(0.58, -15, 1, -70)
Editor.Position = UDim2.new(0, 10, 0, 10)
Editor.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Editor.Text = "-- Paste extra Lua here if needed"
Editor.TextColor3 = Color3.fromRGB(220, 220, 220)
Editor.TextXAlignment = Enum.TextXAlignment.Left
Editor.TextYAlignment = Enum.TextYAlignment.Top
Editor.ClearTextOnFocus = false
Editor.MultiLine = true
Editor.Font = Enum.Font.Code
Editor.TextSize = 15
Editor.Parent = ExecuteTab

local EditorCorner = Instance.new("UICorner")
EditorCorner.CornerRadius = UDim.new(0, 8)
EditorCorner.Parent = Editor

local Console = Instance.new("TextLabel")
Console.Size = UDim2.new(0.42, -15, 1, -70)
Console.Position = UDim2.new(0.58, 10, 0, 10)
Console.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Console.Text = ">> Blade X Console\nKiciaHook Ready...\n"
Console.TextColor3 = Color3.fromRGB(100, 255, 100)
Console.TextXAlignment = Enum.TextXAlignment.Left
Console.TextYAlignment = Enum.TextYAlignment.Top
Console.TextWrapped = true
Console.Font = Enum.Font.Code
Console.TextSize = 14
Console.Parent = ExecuteTab

local ConsoleCorner = Instance.new("UICorner")
ConsoleCorner.CornerRadius = UDim.new(0, 8)
ConsoleCorner.Parent = Console

local ExecBtn = Instance.new("TextButton")
ExecBtn.Size = UDim2.new(0.3, 0, 0, 45)
ExecBtn.Position = UDim2.new(0.35, 0, 1, -55)
ExecBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
ExecBtn.Text = "EXECUTE"
ExecBtn.TextColor3 = Color3.new(1, 1, 1)
ExecBtn.TextScaled = true
ExecBtn.Font = Enum.Font.GothamBold
ExecBtn.Parent = ExecuteTab

local ExecCorner = Instance.new("UICorner")
ExecCorner.CornerRadius = UDim.new(0, 10)
ExecCorner.Parent = ExecBtn

ExecBtn.MouseButton1Click:Connect(function()
    local code = Editor.Text
    if code:match("^%s*$") then return end
    local success, err = pcall(loadstring(code))
    if success then
        Console.Text = Console.Text .. "\n[✓] Executed successfully."
    else
        Console.Text = Console.Text .. "\n[✘] ERROR: " .. tostring(err)
    end
end)

-- ==================== KICIA RIVALS HACKS TAB ====================
local HacksTab = TabFrames["Rivals Hacks"]

local function CreateToggle(parent, name, yOffset, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0.9, 0, 0, 50)
    Toggle.Position = UDim2.new(0.05, 0, 0, yOffset)
    Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Toggle.Text = "   " .. name
    Toggle.TextColor3 = Color3.new(1, 1, 1)
    Toggle.TextXAlignment = Enum.TextXAlignment.Left
    Toggle.TextScaled = true
    Toggle.Font = Enum.Font.GothamSemibold
    Toggle.Parent = parent
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = Toggle
    
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(0, 80, 1, 0)
    Status.Position = UDim2.new(1, -90, 0, 0)
    Status.BackgroundTransparency = 1
    Status.Text = "OFF"
    Status.TextColor3 = Color3.fromRGB(255, 80, 80)
    Status.TextScaled = true
    Status.Font = Enum.Font.GothamBold
    Status.Parent = Toggle
    
    local enabled = false
    Toggle.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            Toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
            Status.Text = "ON 🔥"
            Status.TextColor3 = Color3.fromRGB(0, 255, 100)
        else
            Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Status.Text = "OFF"
            Status.TextColor3 = Color3.fromRGB(255, 80, 80)
        end
        if callback then callback(enabled) end
    end)
end

-- Main KiciaHook Loader
CreateToggle(HacksTab, "Load KiciaHook V2 (Full)", 20, function(state)
    if state then
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/kiciahook/kiciahook/refs/heads/main/loader.luau"))()
            print("✅ KiciaHook V2 Loader started - Follow any on-screen instructions")
        end)
    end
end)

-- Common feature toggles (most users enable these inside the Kicia menu after loading)
CreateToggle(HacksTab, "Silent Aim + Aimbot", 80, function(state)
    print("Silent Aim / Aimbot → Enable inside KiciaHook menu after loading")
end)

CreateToggle(HacksTab, "Ragebot + Wallbang", 140, function(state)
    print("Ragebot → Best with KiciaHook loaded (high detection risk)")
end)

CreateToggle(HacksTab, "ESP + Magic Bullet", 200, function(state)
    print("ESP features → Toggle in KiciaHook GUI")
end)

CreateToggle(HacksTab, "Anti-Katana / No Spread / Recoil", 260, function(state)
    print("Anti-Katana & weapon mods → Available after loading KiciaHook")
end)

-- ==================== FIXED DRAGGING ====================
local dragging = false
local dragInput, dragStart, startPos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

local UserInputService = game:GetService("UserInputService")

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        dragInput = nil
    end
end)

print("✅ Blade X Kicia Edition is ready!")
print("Go to Rivals Hacks tab → Toggle 'Load KiciaHook V2' first.")
