-- Train to Fight - Speed Multiplier
-- Berdasarkan Sigma Spy remotes

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Get remotes dari game (berdasarkan Sigma Spy)
local AutoTrain = ReplicatedStorage:WaitForChild("AutoTrain")
local Bindable = AutoTrain:WaitForChild("Bindable")
local AutoTrainStateHasChanged = Bindable:WaitForChild("AutoTrainStateHasChanged")

-- Configuration
local Config = {
    SpeedMultiplier = 100,     -- Speed multiplier untuk training
    AutoTrain = {
        Arms = false,
        Legs = false,
        Back = false,
        Agility = false
    },
    SpamRate = 0.01,          -- Seberapa cepat spam (0.01 = sangat cepat)
    Enabled = false
}

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TrainSpeedMultiplier"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 580)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -290)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 55)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ Train Speed Multiplier"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Status Label
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(0.9, 0, 0, 45)
Status.Position = UDim2.new(0.05, 0, 0, 65)
Status.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
Status.Text = "🎯 Status: Idle | Multiplier: x" .. Config.SpeedMultiplier
Status.TextColor3 = Color3.fromRGB(100, 255, 100)
Status.TextSize = 14
Status.Font = Enum.Font.GothamBold
Status.Parent = MainFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 8)
StatusCorner.Parent = Status

-- Speed Control Section
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(0.9, 0, 0, 120)
SpeedFrame.Position = UDim2.new(0.05, 0, 0, 120)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
SpeedFrame.BorderSizePixel = 0
SpeedFrame.Parent = MainFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 10)
SpeedCorner.Parent = SpeedFrame

local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Size = UDim2.new(1, 0, 0, 30)
SpeedTitle.Position = UDim2.new(0, 0, 0, 8)
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Text = "🚀 Speed Multiplier"
SpeedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedTitle.TextSize = 16
SpeedTitle.Font = Enum.Font.GothamBold
SpeedTitle.Parent = SpeedFrame

local SpeedDisplay = Instance.new("TextLabel")
SpeedDisplay.Size = UDim2.new(0.35, 0, 0, 30)
SpeedDisplay.Position = UDim2.new(0.325, 0, 0, 45)
SpeedDisplay.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
SpeedDisplay.Text = "x" .. Config.SpeedMultiplier
SpeedDisplay.TextColor3 = Color3.fromRGB(255, 215, 0)
SpeedDisplay.TextSize = 18
SpeedDisplay.Font = Enum.Font.GothamBold
SpeedDisplay.Parent = SpeedFrame

local SpeedDisplayCorner = Instance.new("UICorner")
SpeedDisplayCorner.CornerRadius = UDim.new(0, 8)
SpeedDisplayCorner.Parent = SpeedDisplay

-- Speed Control Buttons
local function CreateSpeedBtn(text, position, change)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.18, 0, 0, 30)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.Parent = SpeedFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        Config.SpeedMultiplier = math.max(1, math.min(1000, Config.SpeedMultiplier + change))
        SpeedDisplay.Text = "x" .. Config.SpeedMultiplier
        Status.Text = "🎯 Status: " .. (Config.Enabled and "Active" or "Idle") .. " | Multiplier: x" .. Config.SpeedMultiplier
    end)
    
    return btn
end

CreateSpeedBtn("-10", UDim2.new(0.05, 0, 0, 45), -10)
CreateSpeedBtn("-1", UDim2.new(0.24, 0, 0, 45), -1)
CreateSpeedBtn("+1", UDim2.new(0.7, 0, 0, 45), 1)
CreateSpeedBtn("+10", UDim2.new(0.82, 0, 0, 45), 10)

-- Presets
local presets = {
    {text = "x50", speed = 50},
    {text = "x100", speed = 100},
    {text = "x200", speed = 200},
    {text = "x500", speed = 500}
}

for i, preset in ipairs(presets) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.21, 0, 0, 28)
    btn.Position = UDim2.new(0.05 + (i-1)*0.235, 0, 0, 85)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    btn.Text = preset.text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.Parent = SpeedFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        Config.SpeedMultiplier = preset.speed
        SpeedDisplay.Text = "x" .. Config.SpeedMultiplier
        Status.Text = "🎯 Status: " .. (Config.Enabled and "Active" or "Idle") .. " | Multiplier: x" .. Config.SpeedMultiplier
    end)
end

-- Training Sections
local trainTypes = {
    {name = "Arms", icon = "💪", yPos = 250},
    {name = "Legs", icon = "🦵", yPos = 325},
    {name = "Back", icon = "🏋️", yPos = 400},
    {name = "Agility", icon = "⚡", yPos = 475}
}

local Counters = {}

for _, train in ipairs(trainTypes) do
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(0.9, 0, 0, 65)
    Section.Position = UDim2.new(0.05, 0, 0, train.yPos)
    Section.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Section.BorderSizePixel = 0
    Section.Parent = MainFrame
    
    local SectionCorner = Instance.new("UICorner")
    SectionCorner.CornerRadius = UDim.new(0, 10)
    SectionCorner.Parent = Section
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.45, 0, 0, 30)
    Label.Position = UDim2.new(0.05, 0, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = train.icon .. " " .. train.name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 16
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Section
    
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0.4, 0, 0, 42)
    Toggle.Position = UDim2.new(0.55, 0, 0, 12)
    Toggle.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    Toggle.Text = "❌ OFF"
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.TextSize = 14
    Toggle.Font = Enum.Font.GothamBold
    Toggle.Parent = Section
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = Toggle
    
    local Counter = Instance.new("TextLabel")
    Counter.Size = UDim2.new(0.9, 0, 0, 18)
    Counter.Position = UDim2.new(0.05, 0, 0, 43)
    Counter.BackgroundTransparency = 1
    Counter.Text = "📊 Multiplied: 0"
    Counter.TextColor3 = Color3.fromRGB(100, 255, 255)
    Counter.TextSize = 11
    Counter.Font = Enum.Font.Gotham
    Counter.TextXAlignment = Enum.TextXAlignment.Left
    Counter.Parent = Section
    
    Counters[train.name] = Counter
    
    Toggle.MouseButton1Click:Connect(function()
        Config.AutoTrain[train.name] = not Config.AutoTrain[train.name]
        if Config.AutoTrain[train.name] then
            Toggle.Text = "✅ ON"
            Toggle.BackgroundColor3 = Color3.fromRGB(60, 220, 60)
        else
            Toggle.Text = "❌ OFF"
            Toggle.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
        end
    end)
end

-- Main Control Buttons
local StartBtn = Instance.new("TextButton")
StartBtn.Size = UDim2.new(0.43, 0, 0, 45)
StartBtn.Position = UDim2.new(0.05, 0, 0, 550)
StartBtn.BackgroundColor3 = Color3.fromRGB(60, 220, 60)
StartBtn.Text = "▶️ START"
StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StartBtn.TextSize = 16
StartBtn.Font = Enum.Font.GothamBold
StartBtn.Parent = MainFrame

local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(0, 10)
StartCorner.Parent = StartBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0.43, 0, 0, 45)
CloseBtn.Position = UDim2.new(0.52, 0, 0, 550)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
CloseBtn.Text = "❌ CLOSE"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseBtn

-- Counters
local TrainCounts = {Arms = 0, Legs = 0, Back = 0, Agility = 0}

-- Main Training Loop
StartBtn.MouseButton1Click:Connect(function()
    Config.Enabled = not Config.Enabled
    
    if Config.Enabled then
        StartBtn.Text = "⏸️ STOP"
        StartBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
        Status.Text = "🎯 Status: Active | Multiplier: x" .. Config.SpeedMultiplier
        Status.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        StartBtn.Text = "▶️ START"
        StartBtn.BackgroundColor3 = Color3.fromRGB(60, 220, 60)
        Status.Text = "🎯 Status: Idle | Multiplier: x" .. Config.SpeedMultiplier
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Speed Spam Loop
spawn(function()
    while task.wait(Config.SpamRate) do
        if Config.Enabled then
            for statName, enabled in pairs(Config.AutoTrain) do
                if enabled then
                    -- Spam remote dengan multiplier
                    for i = 1, Config.SpeedMultiplier do
                        pcall(function()
                            AutoTrainStateHasChanged:Fire(1)
                        end)
                    end
                    
                    -- Update counter
                    TrainCounts[statName] = TrainCounts[statName] + Config.SpeedMultiplier
                    Counters[statName].Text = "📊 Multiplied: " .. TrainCounts[statName]
                end
            end
        end
    end
end)

-- Info
print("✅ Train Speed Multiplier Loaded!")
print("📡 Remote:", AutoTrainStateHasChanged:GetFullName())
print("🚀 Multiplier:", Config.SpeedMultiplier)
print("⚡ Tekan tombol E untuk train, script akan multiply speed!")
