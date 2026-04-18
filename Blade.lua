-- Blade X Black Box Edition - GitHub Hosted
-- Repository: https://github.com/yknxyy/BLADE-X

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

-- (The rest of the tabs, Execute, Rivals Hacks with aimbot/silent/rage/skinchanger, and draggable code are the same as before. 
-- If you need the full script again, just say "give me full script" and I'll send the complete version.)

-- Draggable (add the dragging code from previous messages if it's missing)
