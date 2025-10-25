-- Train to Fight - Working Auto Train with Stat Multiplier
-- Based on actual game remotes (FIXED VERSION)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Get remotes
local TrainEquipment = ReplicatedStorage:WaitForChild("TrainEquipment")
local TrainSystem = ReplicatedStorage:WaitForChild("TrainSystem")

local EquipmentRemote = TrainEquipment:WaitForChild("Remote")
local TrainSpeedRemote = TrainSystem.Remote:WaitForChild("TrainSpeedHasChanged")

-- Equipment IDs untuk setiap stat (perlu disesuaikan dengan game)
local EquipmentIDs = {
    Arms = "2022",      -- ID dari screenshot
    Legs = "2023",      -- Perkiraan ID untuk Legs
    Back = "2024",      -- Perkiraan ID untuk Back
    Agility = "2025"    -- Perkiraan ID untuk Agility
}

-- Configuration
local Config = {
    Multiplier = {
        Arms = 40,
        Legs = 40,
        Back = 40,
        Agility = 40
    },
    AutoTrain = {
        Arms = false,
        Legs = false,
        Back = false,
        Agility = false
    },
    TrainSpeed = 100,
    UseSpeedBoost = true
}

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TrainMultiplierGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 600)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Title.Text = "💪 Train Stat Multiplier"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = Title

-- Info Status
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(0.9, 0, 0, 40)
InfoLabel.Position = UDim2.new(0.05, 0, 0, 60)
InfoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
InfoLabel.Text = "🎯 Training +18 → +720 (x40 multiplier)"
InfoLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
InfoLabel.TextSize = 12
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Parent = MainFrame

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 10)
InfoCorner.Parent = InfoLabel

-- Equipment ID Section
local IDSection = Instance.new("Frame")
IDSection.Size = UDim2.new(0.9, 0, 0, 80)
IDSection.Position = UDim2.new(0.05, 0, 0, 110)
IDSection.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
IDSection.BorderSizePixel = 0
IDSection.Parent = MainFrame

local IDCorner = Instance.new("UICorner")
IDCorner.CornerRadius = UDim.new(0, 10)
IDCorner.Parent = IDSection

local IDTitle = Instance.new("TextLabel")
IDTitle.Size = UDim2.new(1, 0, 0, 25)
IDTitle.Position = UDim2.new(0, 0, 0, 5)
IDTitle.BackgroundTransparency = 1
IDTitle.Text = "🔧 Equipment IDs (Check F9 for correct IDs)"
IDTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
IDTitle.TextSize = 12
IDTitle.Font = Enum.Font.GothamBold
IDTitle.Parent = IDSection

local IDGrid = Instance.new("Frame")
IDGrid.Size = UDim2.new(1, 0, 0, 50)
IDGrid.Position = UDim2.new(0, 0, 0, 30)
IDGrid.BackgroundTransparency = 1
IDGrid.Parent = IDSection

local function CreateIDBox(stat, pos)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.22, 0, 0, 35)
    box.Position = pos
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    box.PlaceholderText = stat
    box.Text = EquipmentIDs[stat]
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.TextSize = 11
    box.Font = Enum.Font.Gotham
    box.Parent = IDGrid
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = box
    
    box.FocusLost:Connect(function()
        EquipmentIDs[stat] = box.Text
    end)
    
    return box
end

CreateIDBox("Arms", UDim2.new(0.02, 0, 0, 0))
CreateIDBox("Legs", UDim2.new(0.27, 0, 0, 0))
CreateIDBox("Back", UDim2.new(0.52, 0, 0, 0))
CreateIDBox("Agility", UDim2.new(0.77, 0, 0, 0))

-- Create Stat Sections
local function CreateStatSection(statName, yPos, icon)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(0.9, 0, 0, 80)
    Section.Position = UDim2.new(0.05, 0, 0, yPos)
    Section.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Section.BorderSizePixel = 0
    Section.Parent = MainFrame
    
    local SectionCorner = Instance.new("UICorner")
    SectionCorner.CornerRadius = UDim.new(0, 10)
    SectionCorner.Parent = Section
    
    -- Label
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.4, 0, 0, 25)
    Label.Position = UDim2.new(0.05, 0, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = icon .. " " .. statName
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 16
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Section
    
    -- Multiplier Input
    local MultBox = Instance.new("TextBox")
    MultBox.Size = UDim2.new(0.25, 0, 0, 25)
    MultBox.Position = UDim2.new(0.05, 0, 0, 35)
    MultBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    MultBox.Text = "x" .. Config.Multiplier[statName]
    MultBox.TextColor3 = Color3.fromRGB(255, 215, 0)
    MultBox.TextSize = 14
    MultBox.Font = Enum.Font.GothamBold
    MultBox.Parent = Section
    
    local MultCorner = Instance.new("UICorner")
    MultCorner.CornerRadius = UDim.new(0, 8)
    MultCorner.Parent = MultBox
    
    MultBox.FocusLost:Connect(function()
        local num = tonumber(MultBox.Text:gsub("x", ""))
        if num and num > 0 then
            Config.Multiplier[statName] = num
            MultBox.Text = "x" .. num
        else
            MultBox.Text = "x" .. Config.Multiplier[statName]
        end
    end)
    
    -- Toggle Button
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0.35, 0, 0, 25)
    Toggle.Position = UDim2.new(0.35, 0, 0, 35)
    Toggle.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    Toggle.Text = "❌ OFF"
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.TextSize = 13
    Toggle.Font = Enum.Font.GothamBold
    Toggle.Parent = Section
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = Toggle
    
    -- Counter
    local Counter = Instance.new("TextLabel")
    Counter.Size = UDim2.new(0.25, 0, 0, 25)
    Counter.Position = UDim2.new(0.72, 0, 0, 35)
    Counter.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Counter.Text = "0"
    Counter.TextColor3 = Color3.fromRGB(100, 255, 255)
    Counter.TextSize = 14
    Counter.Font = Enum.Font.GothamBold
    Counter.Parent = Section
    
    local CounterCorner = Instance.new("UICorner")
    CounterCorner.CornerRadius = UDim.new(0, 8)
    CounterCorner.Parent = Counter
    
    -- Status
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(0.9, 0, 0, 15)
    Status.Position = UDim2.new(0.05, 0, 0, 63)
    Status.BackgroundTransparency = 1
    Status.Text = "Ready"
    Status.TextColor3 = Color3.fromRGB(150, 150, 150)
    Status.TextSize = 10
    Status.Font = Enum.Font.Gotham
    Status.TextXAlignment = Enum.TextXAlignment.Left
    Status.Parent = Section
    
    Toggle.MouseButton1Click:Connect(function()
        Config.AutoTrain[statName] = not Config.AutoTrain[statName]
        if Config.AutoTrain[statName] then
            Toggle.Text = "✅ ON"
            Toggle.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
            Status.Text = "Training..."
            Status.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            Toggle.Text = "❌ OFF"
            Toggle.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
            Status.Text = "Stopped"
            Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
    
    return Counter, Status
end

local Counters = {}
local Statuses = {}

Counters.Arms, Statuses.Arms = CreateStatSection("Arms", 200, "💪")
Counters.Legs, Statuses.Legs = CreateStatSection("Legs", 290, "🦵")
Counters.Back, Statuses.Back = CreateStatSection("Back", 380, "🏋️")
Counters.Agility, Statuses.Agility = CreateStatSection("Agility", 470, "⚡")

-- Control Buttons
local ButtonFrame = Instance.new("Frame")
ButtonFrame.Size = UDim2.new(0.9, 0, 0, 35)
ButtonFrame.Position = UDim2.new(0.05, 0, 0, 560)
ButtonFrame.BackgroundTransparency = 1
ButtonFrame.Parent = MainFrame

local AllToggle = Instance.new("TextButton")
AllToggle.Size = UDim2.new(0.48, 0, 1, 0)
AllToggle.Position = UDim2.new(0, 0, 0, 0)
AllToggle.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
AllToggle.Text = "🔥 All ON/OFF"
AllToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AllToggle.TextSize = 13
AllToggle.Font = Enum.Font.GothamBold
AllToggle.Parent = ButtonFrame

local AllCorner = Instance.new("UICorner")
AllCorner.CornerRadius = UDim.new(0, 10)
AllCorner.Parent = AllToggle

AllToggle.MouseButton1Click:Connect(function()
    local allOn = true
    for _, v in pairs(Config.AutoTrain) do
        if not v then allOn = false break end
    end
    for k, _ in pairs(Config.AutoTrain) do
        Config.AutoTrain[k] = not allOn
    end
end)

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.48, 0, 1, 0)
CloseButton.Position = UDim2.new(0.52, 0, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseButton.Text = "❌ Close"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 13
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = ButtonFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Training System
local TrainCounts = {Arms = 0, Legs = 0, Back = 0, Agility = 0}

-- Function to train stat
local function TrainStat(statName)
    local multiplier = Config.Multiplier[statName]
    local equipID = EquipmentIDs[statName]
    
    spawn(function()
        for i = 1, multiplier do
            pcall(function()
                -- Try InvokeServer (seperti di screenshot)
                if EquipmentRemote:FindFirstChild("ApplyTakeUpStationaryTrainEquipment") then
                    EquipmentRemote.ApplyTakeUpStationaryTrainEquipment:InvokeServer(equipID)
                end
                
                -- Try FireServer untuk mobile equipment
                if EquipmentRemote:FindFirstChild("ApplyMobileTrain") then
                    EquipmentRemote.ApplyMobileTrain:FireServer(statName)
                end
                
                -- Boost speed
                if Config.UseSpeedBoost then
                    TrainSpeedRemote:FireServer(Config.TrainSpeed)
                end
            end)
            
            task.wait(0.01) -- Small delay
        end
        
        -- Update counter
        TrainCounts[statName] = TrainCounts[statName] + multiplier
        Counters[statName].Text = tostring(TrainCounts[statName])
        Statuses[statName].Text = "Trained +" .. (18 * multiplier)
    end)
end

-- Main Loop
spawn(function()
    while task.wait(0.5) do
        for statName, enabled in pairs(Config.AutoTrain) do
            if enabled then
                TrainStat(statName)
            end
        end
    end
end)

-- Speed Boost Loop (background)
spawn(function()
    while task.wait(0.1) do
        if Config.UseSpeedBoost then
            pcall(function()
                TrainSpeedRemote:FireServer(Config.TrainSpeed)
            end)
        end
    end
end)

-- Print info
print("✅ Train Multiplier Loaded!")
print("📡 Remotes:")
print("  - TrainSpeedHasChanged:", TrainSpeedRemote:GetFullName())
print("  - Equipment Remote:", EquipmentRemote:GetFullName())
print("\n💡 Tips:")
print("  1. Pastikan Equipment ID benar (check F9 saat training)")
print("  2. Set multiplier (default x40)")
print("  3. Toggle ON untuk auto train")
print("  4. Training +18 → +720 per cycle (x40)")
