-- Blade Executor - Full Custom Script Executor GUI (v1.4 - Script Hub + 50+ Rivals)
print("welcome to Blade Executor")

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local ti = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local fastTi = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.Parent = game:GetService("CoreGui")

-- ==================== GLOWING EYE (Visual Only) ====================
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
version.Text = "v1.4 • Script Hub"
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

-- Draggable
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

closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- ==================== LEFT CTRL TOGGLE ====================
local guiOpen = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftControl then
        guiOpen = not guiOpen
        if guiOpen then
            main.Visible = true
            main.BackgroundTransparency = 1
            mainStroke.Transparency = 1
            TweenService:Create(main, ti, {BackgroundTransparency = 0}):Play()
            TweenService:Create(mainStroke, ti, {Transparency = 0}):Play()
        else
            TweenService:Create(main, ti, {BackgroundTransparency = 1}):Play()
            TweenService:Create(mainStroke, ti, {Transparency = 1}):Play()
            task.wait(0.4)
            main.Visible = false
        end
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
    btn.Text = " " .. icon .. " " .. name
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

-- Sidebar Buttons
createSidebarButton("Executor", "📝")
createSidebarButton("Script Hub", "📚")
createSidebarButton("Console", "📟")
createSidebarButton("Settings", "⚙️")

-- ==================== EXECUTOR TAB ====================
local editorFrame = Instance.new("ScrollingFrame")
editorFrame.Size = UDim2.new(1, 0, 1, -60)
editorFrame.Position = UDim2.new(0, 0, 0, 0)
editorFrame.BackgroundTransparency = 1
editorFrame.ScrollBarThickness = 6
editorFrame.Parent = executorTab

local codeBox = Instance.new("TextBox")
codeBox.Size = UDim2.new(1, -12, 1, -12)
codeBox.Position = UDim2.new(0, 6, 0, 6)
codeBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
codeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
codeBox.Text = "-- Paste your script here...\n-- or load from Script Hub"
codeBox.TextWrapped = true
codeBox.TextXAlignment = Enum.TextXAlignment.Left
codeBox.TextYAlignment = Enum.TextYAlignment.Top
codeBox.ClearTextOnFocus = false
codeBox.MultiLine = true
codeBox.Font = Enum.Font.Code
codeBox.TextSize = 16
codeBox.Parent = editorFrame
Instance.new("UICorner", codeBox).CornerRadius = UDim.new(0, 8)

-- Bottom bar
local bottomBar = Instance.new("Frame")
bottomBar.Size = UDim2.new(1, 0, 0, 50)
bottomBar.Position = UDim2.new(0, 0, 1, -50)
bottomBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
bottomBar.Parent = executorTab
Instance.new("UICorner", bottomBar).CornerRadius = UDim.new(0, 12)

local executeBtn = Instance.new("TextButton")
executeBtn.Size = UDim2.new(0.5, -10, 1, -10)
executeBtn.Position = UDim2.new(0, 5, 0, 5)
executeBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
executeBtn.Text = "▶ Execute"
executeBtn.TextColor3 = Color3.new(1,1,1)
executeBtn.TextScaled = true
executeBtn.Font = Enum.Font.GothamBold
executeBtn.Parent = bottomBar
Instance.new("UICorner", executeBtn).CornerRadius = UDim.new(0, 8)

local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0.5, -10, 1, -10)
clearBtn.Position = UDim2.new(0.5, 5, 0, 5)
clearBtn.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
clearBtn.Text = "Clear"
clearBtn.TextColor3 = Color3.new(1,1,1)
clearBtn.TextScaled = true
clearBtn.Font = Enum.Font.GothamBold
clearBtn.Parent = bottomBar
Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0, 8)

executeBtn.MouseButton1Click:Connect(function()
    local code = codeBox.Text
    local success, err = pcall(function()
        loadstring(code)()
    end)
    if success then
        print("✅ Blade Executor: Script executed successfully!")
    else
        warn("❌ Execution error: " .. err)
    end
end)

clearBtn.MouseButton1Click:Connect(function()
    codeBox.Text = ""
end)

-- ==================== SCRIPT HUB TAB (ScriptBlox + 50+ Rivals) ====================
local hubHeader = Instance.new("Frame")
hubHeader.Size = UDim2.new(1, 0, 0, 60)
hubHeader.BackgroundTransparency = 1
hubHeader.Parent = hubTab

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(0.65, -10, 0, 40)
searchBox.Position = UDim2.new(0, 5, 0, 10)
searchBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
searchBox.PlaceholderText = "Search any script..."
searchBox.Text = ""
searchBox.TextColor3 = Color3.fromRGB(255,255,255)
searchBox.TextScaled = true
searchBox.Font = Enum.Font.Gotham
searchBox.Parent = hubHeader
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 8)

local searchBtn = Instance.new("TextButton")
searchBtn.Size = UDim2.new(0.2, -5, 0, 40)
searchBtn.Position = UDim2.new(0.65, 5, 0, 10)
searchBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
searchBtn.Text = "🔎 Search"
searchBtn.TextColor3 = Color3.new(1,1,1)
searchBtn.TextScaled = true
searchBtn.Font = Enum.Font.GothamBold
searchBtn.Parent = hubHeader
Instance.new("UICorner", searchBtn).CornerRadius = UDim.new(0, 8)

local rivalsBtn = Instance.new("TextButton")
rivalsBtn.Size = UDim2.new(0.15, -5, 0, 40)
rivalsBtn.Position = UDim2.new(0.85, 5, 0, 10)
rivalsBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
rivalsBtn.Text = "Rivals (50+)"
rivalsBtn.TextColor3 = Color3.new(1,1,1)
rivalsBtn.TextScaled = true
rivalsBtn.Font = Enum.Font.GothamBold
rivalsBtn.Parent = hubHeader
Instance.new("UICorner", rivalsBtn).CornerRadius = UDim.new(0, 8)

-- Results list
local resultsList = Instance.new("ScrollingFrame")
resultsList.Size = UDim2.new(1, 0, 1, -70)
resultsList.Position = UDim2.new(0, 0, 0, 70)
resultsList.BackgroundTransparency = 1
resultsList.ScrollBarThickness = 6
resultsList.Parent = hubTab

local listLayout = Instance.new("UIListLayout", resultsList)
listLayout.Padding = UDim.new(0, 6)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function updateCanvas()
    resultsList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
end
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)

local function addScriptToList(scriptData)
    if not scriptData.title or not scriptData.script then return end

    local item = Instance.new("Frame")
    item.Size = UDim2.new(1, 0, 0, 70)
    item.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    item.Parent = resultsList
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 10)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -160, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = scriptData.title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
    titleLabel.Font = Enum.Font.GothamSemibold
    titleLabel.TextSize = 16
    titleLabel.Parent = item

    local loadBtn = Instance.new("TextButton")
    loadBtn.Size = UDim2.new(0, 70, 0, 35)
    loadBtn.Position = UDim2.new(1, -150, 0.5, -17.5)
    loadBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    loadBtn.Text = "Load"
    loadBtn.TextColor3 = Color3.new(1,1,1)
    loadBtn.Font = Enum.Font.GothamBold
    loadBtn.TextSize = 14
    loadBtn.Parent = item
    Instance.new("UICorner", loadBtn).CornerRadius = UDim.new(0, 8)

    local execBtn = Instance.new("TextButton")
    execBtn.Size = UDim2.new(0, 70, 0, 35)
    execBtn.Position = UDim2.new(1, -75, 0.5, -17.5)
    execBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    execBtn.Text = "Execute"
    execBtn.TextColor3 = Color3.new(1,1,1)
    execBtn.Font = Enum.Font.GothamBold
    execBtn.TextSize = 14
    execBtn.Parent = item
    Instance.new("UICorner", execBtn).CornerRadius = UDim.new(0, 8)

    loadBtn.MouseButton1Click:Connect(function()
        codeBox.Text = scriptData.script
        if currentTab then currentTab.Visible = false end
        executorTab.Visible = true
        currentTab = executorTab
        -- Highlight sidebar Executor button
        for _, b in pairs(sidebar:GetChildren()) do
            if b:IsA("TextButton") and b.Text:find("Executor") then
                b.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            elseif b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            end
        end
        print("✅ Loaded \"" .. scriptData.title .. "\" to editor")
    end)

    execBtn.MouseButton1Click:Connect(function()
        local success, err = pcall(function()
            loadstring(scriptData.script)()
        end)
        if success then
            print("✅ Executed \"" .. scriptData.title .. "\" directly!")
        else
            warn("❌ Execute failed: " .. err)
        end
    end)
end

local function fetchScripts(query, maxResults, multiPage)
    resultsList:ClearAllChildren()
    local allScripts = {}
    local pages = multiPage and 3 or 1

    for page = 1, pages do
        local url = "https://scriptblox.com/api/script/search?q=" .. HttpService:UrlEncode(query) .. "&max=20&page=" .. page
        local success, response = pcall(function()
            return game:HttpGet(url)
        end)

        if success then
            local data = HttpService:JSONDecode(response)
            if data and data.result and data.result.scripts then
                for _, v in ipairs(data.result.scripts) do
                    table.insert(allScripts, v)
                end
            end
        else
            warn("ScriptBlox request failed (page " .. page .. ")")
        end
        task.wait(0.15) -- Be nice to the API
    end

    for _, scriptData in ipairs(allScripts) do
        addScriptToList(scriptData)
    end

    if #allScripts == 0 then
        local noResults = Instance.new("TextLabel")
        noResults.Size = UDim2.new(1, 0, 0, 50)
        noResults.BackgroundTransparency = 1
        noResults.Text = "No scripts found for \"" .. query .. "\""
        noResults.TextColor3 = Color3.fromRGB(150, 150, 150)
        noResults.Font = Enum.Font.Gotham
        noResults.TextSize = 18
        noResults.Parent = resultsList
    end

    updateCanvas()
end

-- Search button
searchBtn.MouseButton1Click:Connect(function()
    local query = searchBox.Text ~= "" and searchBox.Text or "universal"
    fetchScripts(query, 20, false)
end)

-- Rivals button (50+ scripts)
rivalsBtn.MouseButton1Click:Connect(function()
    fetchScripts("rivals", 60, true)  -- 3 pages × 20 = up to 60 Rivals scripts
end)

-- ==================== FINAL SETUP ====================
print("Blade Executor v1.4 loaded!")
print("✅ Press LEFT CTRL to open")
print("✅ Script Hub with ScriptBlox + 50+ Rivals scripts ready")
print("Click the glowing eye or press Left Ctrl to start!")