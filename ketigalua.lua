-- Train to Fight - ULTRA AGGRESSIVE BOOSTER
-- Direct value manipulation untuk gain super tinggi

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Settings
local Settings = {
    GainMultiplier = 1000, -- Multiply setiap +180 jadi +180,000
    AutoTrain = false,
    Enabled = false
}

local Stats = {
    TotalGains = 0,
    TrainingSessions = 0
}

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltraBooster"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 380)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 50, 50)
MainStroke.Thickness = 3
MainStroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 55)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 15)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🔥 ULTRA AGGRESSIVE"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 35, 0, 35)
MinimizeBtn.Position = UDim2.new(1, -75, 0, 10)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeBtn.TextSize = 24
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinimizeBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -38, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -30, 1, -70)
Content.Position = UDim2.new(0, 15, 0, 60)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Status
local StatusFrame = Instance.new("Frame")
StatusFrame.Size = UDim2.new(1, 0, 0, 90)
StatusFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
StatusFrame.BorderSizePixel = 0
StatusFrame.Parent = Content

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 10)
StatusCorner.Parent = StatusFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 30)
StatusLabel.Position = UDim2.new(0, 10, 0, 10)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "⭕ INACTIVE"
StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
StatusLabel.TextSize = 18
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = StatusFrame

local StatsLabel = Instance.new("TextLabel")
StatsLabel.Size = UDim2.new(1, -20, 0, 22)
StatsLabel.Position = UDim2.new(0, 10, 0, 43)
StatsLabel.BackgroundTransparency = 1
StatsLabel.Text = "💎 Gain per Training: +180 → +180K"
StatsLabel.TextColor3 = Color3.fromRGB(100, 255, 255)
StatsLabel.TextSize = 14
StatsLabel.Font = Enum.Font.GothamMedium
StatsLabel.TextXAlignment = Enum.TextXAlignment.Left
StatsLabel.Parent = StatusFrame

local SessionLabel = Instance.new("TextLabel")
SessionLabel.Size = UDim2.new(1, -20, 0, 18)
SessionLabel.Position = UDim2.new(0, 10, 0, 68)
SessionLabel.BackgroundTransparency = 1
SessionLabel.Text = "🎯 Sessions: 0 | Total Boosted: +0"
SessionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SessionLabel.TextSize = 12
SessionLabel.Font = Enum.Font.Gotham
SessionLabel.TextXAlignment = Enum.TextXAlignment.Left
SessionLabel.Parent = StatusFrame

-- Multiplier Section
local MultFrame = Instance.new("Frame")
MultFrame.Size = UDim2.new(1, 0, 0, 115)
MultFrame.Position = UDim2.new(0, 0, 0, 100)
MultFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
MultFrame.BorderSizePixel = 0
MultFrame.Parent = Content

local MultCorner = Instance.new("UICorner")
MultCorner.CornerRadius = UDim.new(0, 10)
MultCorner.Parent = MultFrame

local MultTitle = Instance.new("TextLabel")
MultTitle.Size = UDim2.new(1, -20, 0, 35)
MultTitle.Position = UDim2.new(0, 10, 0, 8)
MultTitle.BackgroundTransparency = 1
MultTitle.Text = "⚡ GAIN MULTIPLIER: x1000"
MultTitle.TextColor3 = Color3.fromRGB(255, 255, 100)
MultTitle.TextSize = 18
MultTitle.Font = Enum.Font.GothamBold
MultTitle.TextXAlignment = Enum.TextXAlignment.Left
MultTitle.Parent = MultFrame

local MultInfo = Instance.new("TextLabel")
MultInfo.Size = UDim2.new(1, -20, 0, 22)
MultInfo.Position = UDim2.new(0, 10, 0, 40)
MultInfo.BackgroundTransparency = 1
MultInfo.Text = "Every +180 becomes +180,000 instantly!"
MultInfo.TextColor3 = Color3.fromRGB(255, 200, 100)
MultInfo.TextSize = 13
MultInfo.Font = Enum.Font.GothamMedium
MultInfo.TextXAlignment = Enum.TextXAlignment.Left
MultInfo.Parent = MultFrame

local MultSlider = Instance.new("Frame")
MultSlider.Size = UDim2.new(1, -20, 0, 38)
MultSlider.Position = UDim2.new(0, 10, 0, 68)
MultSlider.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
MultSlider.BorderSizePixel = 0
MultSlider.Parent = MultFrame

local MultSliderCorner = Instance.new("UICorner")
MultSliderCorner.CornerRadius = UDim.new(0, 8)
MultSliderCorner.Parent = MultSlider

local MultFill = Instance.new("Frame")
MultFill.Size = UDim2.new(0.5, 0, 1, 0)
MultFill.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
MultFill.BorderSizePixel = 0
MultFill.Parent = MultSlider

local MultFillCorner = Instance.new("UICorner")
MultFillCorner.CornerRadius = UDim.new(0, 8)
MultFillCorner.Parent = MultFill

local MultBtn = Instance.new("TextButton")
MultBtn.Size = UDim2.new(1, 0, 1, 0)
MultBtn.BackgroundTransparency = 1
MultBtn.Text = ""
MultBtn.Parent = MultSlider

-- Buttons
local EnableBtn = Instance.new("TextButton")
EnableBtn.Size = UDim2.new(1, 0, 0, 55)
EnableBtn.Position = UDim2.new(0, 0, 0, 225)
EnableBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
EnableBtn.Text = "🚀 ACTIVATE ULTRA MODE"
EnableBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnableBtn.TextSize = 20
EnableBtn.Font = Enum.Font.GothamBold
EnableBtn.BorderSizePixel = 0
EnableBtn.Parent = Content

local EnableCorner = Instance.new("UICorner")
EnableCorner.CornerRadius = UDim.new(0, 12)
EnableCorner.Parent = EnableBtn

local EnableStroke = Instance.new("UIStroke")
EnableStroke.Color = Color3.fromRGB(255, 100, 100)
EnableStroke.Thickness = 3
EnableStroke.Parent = EnableBtn

local AutoBtn = Instance.new("TextButton")
AutoBtn.Size = UDim2.new(1, 0, 0, 45)
AutoBtn.Position = UDim2.new(0, 0, 0, 290)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
AutoBtn.Text = "🤖 AUTO TRAIN: OFF"
AutoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoBtn.TextSize = 16
AutoBtn.Font = Enum.Font.GothamBold
AutoBtn.BorderSizePixel = 0
AutoBtn.Parent = Content

local AutoCorner = Instance.new("UICorner")
AutoCorner.CornerRadius = UDim.new(0, 10)
AutoCorner.Parent = AutoBtn

-- Minimized
local MinimizedFrame = Instance.new("Frame")
MinimizedFrame.Size = UDim2.new(0, 250, 0, 55)
MinimizedFrame.Position = UDim2.new(0.5, -125, 0, 10)
MinimizedFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
MinimizedFrame.BorderSizePixel = 0
MinimizedFrame.Visible = false
MinimizedFrame.Active = true
MinimizedFrame.Draggable = true
MinimizedFrame.Parent = ScreenGui

local MinFrameCorner = Instance.new("UICorner")
MinFrameCorner.CornerRadius = UDim.new(0, 12)
MinFrameCorner.Parent = MinimizedFrame

local MinStroke = Instance.new("UIStroke")
MinStroke.Color = Color3.fromRGB(255, 50, 50)
MinStroke.Thickness = 3
MinStroke.Parent = MinimizedFrame

local MinLabel = Instance.new("TextLabel")
MinLabel.Size = UDim2.new(1, -55, 1, 0)
MinLabel.Position = UDim2.new(0, 15, 0, 0)
MinLabel.BackgroundTransparency = 1
MinLabel.Text = "🔥 ULTRA BOOSTER"
MinLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
MinLabel.TextSize = 18
MinLabel.Font = Enum.Font.GothamBold
MinLabel.TextXAlignment = Enum.TextXAlignment.Left
MinLabel.Parent = MinimizedFrame

local RestoreBtn = Instance.new("TextButton")
RestoreBtn.Size = UDim2.new(0, 40, 0, 40)
RestoreBtn.Position = UDim2.new(1, -48, 0, 7)
RestoreBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
RestoreBtn.Text = "+"
RestoreBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RestoreBtn.TextSize = 26
RestoreBtn.Font = Enum.Font.GothamBold
RestoreBtn.BorderSizePixel = 0
RestoreBtn.Parent = MinimizedFrame

local RestoreCorner = Instance.new("UICorner")
RestoreCorner.CornerRadius = UDim.new(0, 10)
RestoreCorner.Parent = RestoreBtn

-- Functions
function FormatNumber(n)
    if n >= 1e9 then return string.format("%.2fB", n / 1e9)
    elseif n >= 1e6 then return string.format("%.2fM", n / 1e6)
    elseif n >= 1e3 then return string.format("%.1fK", n / 1e3)
    else return tostring(math.floor(n)) end
end

local function UpdateUI()
    MultTitle.Text = string.format("⚡ GAIN MULTIPLIER: x%d", Settings.GainMultiplier)
    
    local result = 180 * Settings.GainMultiplier
    MultInfo.Text = string.format("Every +180 becomes +%s instantly!", FormatNumber(result))
    
    MultFill.Size = UDim2.new((Settings.GainMultiplier - 100) / 4900, 0, 1, 0)
    
    StatsLabel.Text = string.format("💎 Gain per Training: +180 → +%s", FormatNumber(result))
    SessionLabel.Text = string.format("🎯 Sessions: %d | Total Boosted: +%s", 
        Stats.TrainingSessions, FormatNumber(Stats.TotalGains))
end

-- Slider
local dragging = false
MultBtn.MouseButton1Down:Connect(function() dragging = true end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local pos = (UserInputService:GetMouseLocation().X - MultSlider.AbsolutePosition.X) / MultSlider.AbsoluteSize.X
        Settings.GainMultiplier = math.clamp(math.floor(pos * 5000) + 100, 100, 5000)
        UpdateUI()
    end
end)

-- Buttons
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MinimizedFrame.Visible = true
end)

RestoreBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MinimizedFrame.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

EnableBtn.MouseButton1Click:Connect(function()
    Settings.Enabled = not Settings.Enabled
    if Settings.Enabled then
        EnableBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        EnableBtn.Text = "✅ ULTRA MODE ACTIVE"
        StatusLabel.Text = "🔥 ACTIVE - MULTIPLYING!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        EnableStroke.Color = Color3.fromRGB(100, 255, 100)
    else
        EnableBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        EnableBtn.Text = "🚀 ACTIVATE ULTRA MODE"
        StatusLabel.Text = "⭕ INACTIVE"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        EnableStroke.Color = Color3.fromRGB(255, 100, 100)
    end
end)

AutoBtn.MouseButton1Click:Connect(function()
    Settings.AutoTrain = not Settings.AutoTrain
    if Settings.AutoTrain then
        AutoBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
        AutoBtn.Text = "🤖 AUTO TRAIN: ON"
    else
        AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        AutoBtn.Text = "🤖 AUTO TRAIN: OFF"
    end
end)

-- ULTRA AGGRESSIVE HOOK - Intercept SEMUA numeric values
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if not Settings.Enabled then
        return oldNamecall(self, ...)
    end
    
    -- Hook InvokeServer - Multiply SEMUA hasil
    if method == "InvokeServer" then
        local results = {oldNamecall(self, ...)}
        
        -- Multiply setiap numeric value
        for i = 1, #results do
            if typeof(results[i]) == "number" and results[i] > 10 then
                results[i] = results[i] * Settings.GainMultiplier
                Stats.TotalGains = Stats.TotalGains + (results[i] * (Settings.GainMultiplier - 1))
            end
        end
        
        return unpack(results)
    end
    
    -- Hook FireServer - Training speed
    if method == "FireServer" then
        if self.Name == "TrainSpeedHasChanged" and args[1] then
            args[1] = args[1] * 20 -- Max speed
            Stats.TrainingSessions = Stats.TrainingSessions + 1
            task.spawn(UpdateUI)
        end
        return oldNamecall(self, unpack(args))
    end
    
    return oldNamecall(self, ...)
end)

-- Hook SEMUA BindableFunction
task.spawn(function()
    wait(2)
    for _, service in pairs({ReplicatedStorage, workspace}) do
        for _, descendant in pairs(service:GetDescendants()) do
            if descendant:IsA("BindableFunction") then
                pcall(function()
                    local oldInvoke = descendant.Invoke
                    descendant.Invoke = function(self, ...)
                        local result = oldInvoke(self, ...)
                        
                        if Settings.Enabled then
                            if typeof(result) == "number" and result > 10 then
                                return result * Settings.GainMultiplier
                            end
                        end
                        
                        return result
                    end
                end)
            end
        end
    end
end)

-- Hook OnClientEvent untuk multiply nilai yang diterima
task.spawn(function()
    wait(2)
    for _, descendant in pairs(ReplicatedStorage:GetDescendants()) do
        if descendant:IsA("RemoteEvent") then
            pcall(function()
                descendant.OnClientEvent:Connect(function(...)
                    if not Settings.Enabled then return end
                    
                    local args = {...}
                    
                    -- Multiply semua numeric values
                    for i = 1, #args do
                        if typeof(args[i]) == "number" and args[i] > 10 then
                            args[i] = args[i] * Settings.GainMultiplier
                        end
                    end
                end)
            end)
        end
    end
end)

-- DIRECT DATASTORE HOOK - Paling agresif
task.spawn(function()
    local TrainSystem = ReplicatedStorage:WaitForChild("TrainSystem", 10)
    if TrainSystem then
        -- Hook GetTrainValue
        local getTrainValue = TrainSystem.Bindable:FindFirstChild("GetTrainValue")
        if getTrainValue then
            local old = getTrainValue.Invoke
            getTrainValue.Invoke = function(self, ...)
                local val = old(self, ...)
                if Settings.Enabled and typeof(val) == "number" then
                    return val * Settings.GainMultiplier
                end
                return val
            end
        end
        
        -- Hook PlayerTrainValueHasChanged
        local trainChanged = TrainSystem.Remote:FindFirstChild("PlayerTrainValueHasChanged")
        if trainChanged then
            trainChanged.OnClientEvent:Connect(function(plr, trainType, newVal, oldVal)
                if Settings.Enabled and newVal and oldVal then
                    local boosted = (newVal - oldVal) * Settings.GainMultiplier
                    Stats.TotalGains = Stats.TotalGains + boosted
                    task.spawn(UpdateUI)
                    
                    print(string.format("[ULTRA BOOST] Type %d: +%s (Boosted from +%d)", 
                        trainType, FormatNumber(boosted), newVal - oldVal))
                end
            end)
        end
    end
end)

-- Auto Train - SUPER AGGRESSIVE
task.spawn(function()
    while task.wait(0.1) do
        if Settings.AutoTrain and Settings.Enabled then
            pcall(function()
                local TrainEquip = ReplicatedStorage:FindFirstChild("TrainEquipment")
                if TrainEquip and TrainEquip:FindFirstChild("Remote") then
                    -- Spam both train types
                    local stationary = TrainEquip.Remote:FindFirstChild("ApplyStationaryTrain")
                    if stationary then stationary:InvokeServer() end
                    
                    local mobile = TrainEquip.Remote:FindFirstChild("ApplyMobileTrain")
                    if mobile then mobile:InvokeServer() end
                end
            end)
        end
    end
end)

UpdateUI()
print("🔥 ============================================")
print("🔥 ULTRA AGGRESSIVE BOOSTER - LOADED!")
print("🔥 ============================================")
print("⚡ Gain Multiplier: x100 - x5000")
print("")
print("💎 With x1000 multiplier:")
print("   +180 → +180,000 PER TRAINING!")
print("")
print("💎 With x2000 multiplier:")
print("   +180 → +360,000 PER TRAINING!")
print("")
print("💎 With x5000 (MAX):")
print("   +180 → +900,000 PER TRAINING!")
print("")
print("🚀 Activate and watch gains EXPLODE!")
print("🔥 ============================================")
