-- Train to Fight - Simple Auto Train with Multiplier
-- Versi simpel yang pasti work

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Wait untuk remotes
local TrainSystem = ReplicatedStorage:WaitForChild("TrainSystem", 10)
if not TrainSystem then
    warn("TrainSystem not found!")
    return
end

local Remote = TrainSystem:WaitForChild("Remote", 10)
if not Remote then
    warn("Remote not found!")
    return
end

-- Config
local Config = {
    Enabled = false,
    Multiplier = 20,  -- Default 20x (seperti +180 di screenshot)
    Speed = 100,
    AutoSpeed = true,
    Delay = 0.1
}

-- Simple GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SimpleTrainGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Title.Text = "⚡ Auto Train"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Multiplier Label
local MultLabel = Instance.new("TextLabel")
MultLabel.Size = UDim2.new(0.8, 0, 0, 30)
MultLabel.Position = UDim2.new(0.1, 0, 0, 50)
MultLabel.BackgroundTransparency = 1
MultLabel.Text = "Multiplier: x" .. Config.Multiplier
MultLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
MultLabel.TextSize = 14
MultLabel.Font = Enum.Font.Gotham
MultLabel.Parent = MainFrame

-- Multiplier Slider
local SliderBG = Instance.new("Frame")
SliderBG.Size = UDim2.new(0.8, 0, 0, 8)
SliderBG.Position = UDim2.new(0.1, 0, 0, 85)
SliderBG.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
SliderBG.BorderSizePixel = 0
SliderBG.Parent = MainFrame

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(1, 0)
SliderCorner.Parent = SliderBG

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(Config.Multiplier / 100, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBG

local SliderFillCorner = Instance.new("UICorner")
SliderFillCorner.CornerRadius = UDim.new(1, 0)
SliderFillCorner.Parent = SliderFill

local SliderButton = Instance.new("TextButton")
SliderButton.Size = UDim2.new(1, 0, 1, 0)
SliderButton.BackgroundTransparency = 1
SliderButton.Text = ""
SliderButton.Parent = SliderBG

local dragging = false
SliderButton.MouseButton1Down:Connect(function()
    dragging = true
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouse = LocalPlayer:GetMouse()
        local pos = math.clamp((mouse.X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
        Config.Multiplier = math.floor(pos * 100) + 1
        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
        MultLabel.Text = "Multiplier: x" .. Config.Multiplier
    end
end)

-- Toggle Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.8, 0, 0, 40)
ToggleButton.Position = UDim2.new(0.1, 0, 0, 110)
ToggleButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
ToggleButton.Text = "❌ OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    Config.Enabled = not Config.Enabled
    if Config.Enabled then
        ToggleButton.Text = "✅ ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
    else
        ToggleButton.Text = "❌ OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    end
end)

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.8, 0, 0, 30)
CloseButton.Position = UDim2.new(0.1, 0, 0, 160)
CloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
CloseButton.Text = "Close"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12
CloseButton.Font = Enum.Font.Gotham
CloseButton.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Main Training Loop
spawn(function()
    while task.wait(Config.Delay) do
        if Config.Enabled then
            -- Cari semua remote di TrainSystem
            for _, remote in pairs(Remote:GetChildren()) do
                if remote:IsA("RemoteEvent") then
                    -- Spam remote sebanyak multiplier
                    for i = 1, Config.Multiplier do
                        pcall(function()
                            -- Try berbagai cara
                            remote:FireServer()
                            remote:FireServer(Config.Speed)
                            
                            -- Khusus untuk TrainSpeedHasChanged
                            if remote.Name:find("Speed") then
                                remote:FireServer(Config.Speed)
                            end
                        end)
                        task.wait(0.01)
                    end
                end
            end
        end
    end
end)

-- Speed Boost Loop
spawn(function()
    while task.wait(0.1) do
        if Config.AutoSpeed and Config.Enabled then
            pcall(function()
                -- Cari TrainSpeedHasChanged
                for _, remote in pairs(Remote:GetChildren()) do
                    if remote.Name:find("Speed") and remote:IsA("RemoteEvent") then
                        remote:FireServer(Config.Speed)
                    end
                end
            end)
        end
    end
end)

print("✅ Simple Auto Train Loaded!")
print("📊 Current Multiplier: x" .. Config.Multiplier)
print("💡 Stand near training equipment and toggle ON")
print("🎯 Training +9 akan jadi +" .. (9 * Config.Multiplier) .. " (example)")
