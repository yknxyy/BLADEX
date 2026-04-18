-- Blade X Black Box Edition - GitHub Hosted
-- Repo: https://github.com/yknxyy/BLADEX

print("🔥 Blade X Black Box loaded from GitHub!")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BladeX"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 900, 0, 600)
Main.Position = UDim2.new(0.5, -450, 0.5, -300)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

-- Black Box Icon
local IconFrame = Instance.new("Frame")
IconFrame.Size = UDim2.new(0, 50, 0, 50)
IconFrame.Position = UDim2.new(0, 10, 0, 0)
IconFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
IconFrame.BorderSizePixel = 0
IconFrame.Parent = TopBar

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(0, 12)
IconCorner.Parent = IconFrame

local IconStroke = Instance.new("UIStroke")
IconStroke.Color = Color3.fromRGB(80, 80, 80)
IconStroke.Thickness = 2
IconStroke.Parent = IconFrame

local IconLabel = Instance.new("TextLabel")
IconLabel.Size = UDim2.new(1, 0, 1, 0)
IconLabel.BackgroundTransparency = 1
IconLabel.Text = "BLADE"
IconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
IconLabel.TextScaled = true
IconLabel.Font = Enum.Font.GothamBlack
IconLabel.Parent = IconFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 70, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "BLADE X"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = TopBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextScaled = true
CloseBtn.Parent = TopBar
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Tab Buttons
local Tabs = {"Execute", "Script Hub", "Rivals Hacks", "Settings"}
local TabFrames = {}

for i, tabName in ipairs(Tabs) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0, 120, 0, 40)
    TabBtn.Position = UDim2.new(0, 280 + (i-1)*130, 0, 5)
    TabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabBtn.Text = tabName
    TabBtn.TextColor3 = Color3.new(1,1,1)
    TabBtn.Parent = TopBar
    
    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(1, 0, 1, -50)
    TabFrame.Position = UDim2.new(0, 0, 0, 50)
    TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabFrame.Visible = (i == 1)
    TabFrame.Parent = Main
    TabFrames[tabName] = TabFrame
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, f in pairs(TabFrames) do f.Visible = false end
        TabFrame.Visible = true
    end)
end

-- Execute Tab
local ExecuteTab = TabFrames["Execute"]

local Console = Instance.new("TextLabel")
Console.Size = UDim2.new(0.45, -10, 1, -10)
Console.Position = UDim2.new(0, 10, 0, 10)
Console.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Console.Text = "OUTPUT CONSOLE\nReady for scripts..."
Console.TextXAlignment = Enum.TextXAlignment.Left
Console.TextYAlignment = Enum.TextYAlignment.Top
Console.TextColor3 = Color3.new(0.8, 0.8, 0.8)
Console.TextWrapped = true
Console.Parent = ExecuteTab

local Editor = Instance.new("TextBox")
Editor.Size = UDim2.new(0.55, -10, 1, -60)
Editor.Position = UDim2.new(0.45, 10, 0, 10)
Editor.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Editor.Text = "-- Paste your Lua here\nprint('Blade X Loaded')"
Editor.TextXAlignment = Enum.TextXAlignment.Left
Editor.TextYAlignment = Enum.TextYAlignment.Top
Editor.TextColor3 = Color3.new(1,1,1)
Editor.ClearTextOnFocus = false
Editor.MultiLine = true
Editor.Parent = ExecuteTab

local ExecBtn = Instance.new("TextButton")
ExecBtn.Size = UDim2.new(0.2, 0, 0, 40)
ExecBtn.Position = UDim2.new(0.45, 10, 1, -50)
ExecBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ExecBtn.Text = "Execute"
ExecBtn.TextColor3 = Color3.new(1,1,1)
ExecBtn.Parent = ExecuteTab
ExecBtn.MouseButton1Click:Connect(function()
    local success, err = pcall(loadstring(Editor.Text))
    if not success then
        Console.Text = Console.Text .. "\nERROR: " .. tostring(err)
    else
        Console.Text = Console.Text .. "\nExecuted successfully."
    end
end)

-- Rivals Hacks Tab
local HacksTab = TabFrames["Rivals Hacks"]

local function AddToggle(parent, text, yPos, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0.8, 0, 0, 40)
    Toggle.Position = UDim2.new(0.1, 0, 0, yPos)
    Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Toggle.Text = text .. " : OFF"
    Toggle.TextColor3 = Color3.new(1,1,1)
    Toggle.Parent = parent
    
    local enabled = false
    Toggle.MouseButton1Click:Connect(function()
        enabled = not enabled
        Toggle.Text = text .. " : " .. (enabled and "ON 🔥" or "OFF")
        Toggle.BackgroundColor3 = enabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
        if callback then callback
