-- Plutonium | Professional Steal a Brainrot Script
-- Advanced GUI with premium features

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Script Variables
local scriptEnabled = {
    autoSteal = false,
    autoFarm = false,
    autoLockBase = false,
    instantSteal = false,
    noclip = false,
    speedHack = false,
    longJump = false,
    autoRebirth = false,
    esp = false,
    antiKick = false,
    godMode = false,
    infiniteJump = false,
    autoBuySell = false,
    antiRagdoll = false,
    teleportToBase = false
}

local originalValues = {
    walkSpeed = humanoid.WalkSpeed,
    jumpPower = humanoid.JumpPower
}

-- Create main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlutoniuGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 900, 0, 650)
mainFrame.Position = UDim2.new(0.5, -450, 0.5, -325)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Add gradient background
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 12, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 22))
}
gradient.Rotation = 45
gradient.Parent = mainFrame

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

-- Header Frame
local headerFrame = Instance.new("Frame")
headerFrame.Name = "Header"
headerFrame.Size = UDim2.new(1, 0, 0, 70)
headerFrame.Position = UDim2.new(0, 0, 0, 0)
headerFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
headerFrame.BorderSizePixel = 0
headerFrame.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 16)
headerCorner.Parent = headerFrame

-- Header gradient
local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 0, 130))
}
headerGradient.Rotation = 90
headerGradient.Parent = headerFrame

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0, 300, 1, 0)
title.Position = UDim2.new(0, 25, 0, 0)
title.BackgroundTransparency = 1
title.Text = "PLUTONIUM"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 28
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.Parent = headerFrame

-- Subtitle
local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.Size = UDim2.new(0, 300, 0, 20)
subtitle.Position = UDim2.new(0, 25, 0, 35)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Professional Steal a Brainrot Script"
subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
subtitle.TextSize = 12
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Font = Enum.Font.Gotham
subtitle.Parent = headerFrame

-- Status indicator
local statusFrame = Instance.new("Frame")
statusFrame.Size = UDim2.new(0, 120, 0, 30)
statusFrame.Position = UDim2.new(1, -140, 0, 20)
statusFrame.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
statusFrame.BorderSizePixel = 0
statusFrame.Parent = headerFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 15)
statusCorner.Parent = statusFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 1, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "● ACTIVE"
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.GothamBold
statusLabel.Parent = statusFrame

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 35, 0, 35)
closeButton.Position = UDim2.new(1, -50, 0, 17.5)
closeButton.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = headerFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 200, 1, -70)
sidebar.Position = UDim2.new(0, 0, 0, 70)
sidebar.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 0)
sidebarCorner.Parent = sidebar

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -200, 1, -70)
contentFrame.Position = UDim2.new(0, 200, 0, 70)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Tab system
local tabs = {"Farming", "Movement", "Combat", "Misc", "Settings"}
local currentTab = "Farming"

-- Create tab buttons
local tabButtons = {}
for i, tabName in pairs(tabs) do
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabName .. "Tab"
    tabButton.Size = UDim2.new(1, -20, 0, 45)
    tabButton.Position = UDim2.new(0, 10, 0, 10 + (i-1) * 55)
    tabButton.BackgroundColor3 = tabName == currentTab and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(25, 25, 30)
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.TextSize = 14
    tabButton.Font = Enum.Font.GothamBold
    tabButton.Parent = sidebar
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tabButton
    
    tabButtons[tabName] = tabButton
end

-- Create content pages
local contentPages = {}

-- Farming Tab Content
local farmingPage = Instance.new("ScrollingFrame")
farmingPage.Name = "FarmingPage"
farmingPage.Size = UDim2.new(1, -20, 1, -20)
farmingPage.Position = UDim2.new(0, 10, 0, 10)
farmingPage.BackgroundTransparency = 1
farmingPage.BorderSizePixel = 0
farmingPage.ScrollBarThickness = 6
farmingPage.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
farmingPage.Parent = contentFrame
farmingPage.Visible = true

local farmingLayout = Instance.new("UIListLayout")
farmingLayout.SortOrder = Enum.SortOrder.LayoutOrder
farmingLayout.Padding = UDim.new(0, 15)
farmingLayout.Parent = farmingPage

contentPages["Farming"] = farmingPage

-- Function to create feature cards
local function createFeatureCard(parent, title, description, toggleKey, layoutOrder)
    local card = Instance.new("Frame")
    card.Name = title .. "Card"
    card.Size = UDim2.new(1, 0, 0, 80)
    card.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    card.BorderSizePixel = 0
    card.LayoutOrder = layoutOrder
    card.Parent = parent
    
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 12)
    cardCorner.Parent = card
    
    local cardTitle = Instance.new("TextLabel")
    cardTitle.Size = UDim2.new(1, -100, 0, 25)
    cardTitle.Position = UDim2.new(0, 15, 0, 10)
    cardTitle.BackgroundTransparency = 1
    cardTitle.Text = title
    cardTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    cardTitle.TextSize = 16
    cardTitle.TextXAlignment = Enum.TextXAlignment.Left
    cardTitle.Font = Enum.Font.GothamBold
    cardTitle.Parent = card
    
    local cardDesc = Instance.new("TextLabel")
    cardDesc.Size = UDim2.new(1, -100, 0, 20)
    cardDesc.Position = UDim2.new(0, 15, 0, 35)
    cardDesc.BackgroundTransparency = 1
    cardDesc.Text = description
    cardDesc.TextColor3 = Color3.fromRGB(160, 160, 160)
    cardDesc.TextSize = 12
    cardDesc.TextXAlignment = Enum.TextXAlignment.Left
    cardDesc.Font = Enum.Font.Gotham
    cardDesc.Parent = card
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 70, 0, 30)
    toggleButton.Position = UDim2.new(1, -85, 0, 25)
    toggleButton.BackgroundColor3 = scriptEnabled[toggleKey] and Color3.fromRGB(34, 197, 94) or Color3.fromRGB(239, 68, 68)
    toggleButton.Text = scriptEnabled[toggleKey] and "ON" or "OFF"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextSize = 12
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.Parent = card
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleButton
    
    toggleButton.MouseButton1Click:Connect(function()
        scriptEnabled[toggleKey] = not scriptEnabled[toggleKey]
        toggleButton.BackgroundColor3 = scriptEnabled[toggleKey] and Color3.fromRGB(34, 197, 94) or Color3.fromRGB(239, 68, 68)
        toggleButton.Text = scriptEnabled[toggleKey] and "ON" or "OFF"
        
        -- Add toggle functionality here
        if toggleKey == "autoSteal" then
            -- Auto steal logic
        elseif toggleKey == "autoFarm" then
            -- Auto farm logic
        elseif toggleKey == "noclip" then
            -- Noclip logic
            if scriptEnabled[toggleKey] then
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            else
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = true
                    end
                end
            end
        elseif toggleKey == "speedHack" then
            humanoid.WalkSpeed = scriptEnabled[toggleKey] and 50 or originalValues.walkSpeed
        elseif toggleKey == "longJump" then
            humanoid.JumpPower = scriptEnabled[toggleKey] and 100 or originalValues.jumpPower
        end
    end)
    
    return card
end

-- Create farming features
createFeatureCard(farmingPage, "Auto Steal", "Automatically steal brainrots from other players", "autoSteal", 1)
createFeatureCard(farmingPage, "Auto Farm", "Automatically collect cash and items", "autoFarm", 2)
createFeatureCard(farmingPage, "Auto Lock Base", "Automatically secure your base", "autoLockBase", 3)
createFeatureCard(farmingPage, "Instant Steal", "Instantly steal brainrots without delay", "instantSteal", 4)
createFeatureCard(farmingPage, "Auto Rebirth", "Automatically rebirth when conditions are met", "autoRebirth", 5)
createFeatureCard(farmingPage, "Auto Buy/Sell", "Automatically buy and sell items", "autoBuySell", 6)

-- Movement Tab Content
local movementPage = Instance.new("ScrollingFrame")
movementPage.Name = "MovementPage"
movementPage.Size = UDim2.new(1, -20, 1, -20)
movementPage.Position = UDim2.new(0, 10, 0, 10)
movementPage.BackgroundTransparency = 1
movementPage.BorderSizePixel = 0
movementPage.ScrollBarThickness = 6
movementPage.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
movementPage.Parent = contentFrame
movementPage.Visible = false

local movementLayout = Instance.new("UIListLayout")
movementLayout.SortOrder = Enum.SortOrder.LayoutOrder
movementLayout.Padding = UDim.new(0, 15)
movementLayout.Parent = movementPage

contentPages["Movement"] = movementPage

createFeatureCard(movementPage, "Noclip", "Walk through walls and obstacles", "noclip", 1)
createFeatureCard(movementPage, "Speed Hack", "Move faster than normal", "speedHack", 2)
createFeatureCard(movementPage, "Long Jump", "Jump higher and farther", "longJump", 3)
createFeatureCard(movementPage, "Infinite Jump", "Jump unlimited times in the air", "infiniteJump", 4)
createFeatureCard(movementPage, "Teleport to Base", "Instantly teleport to your base", "teleportToBase", 5)

-- Combat Tab Content
local combatPage = Instance.new("ScrollingFrame")
combatPage.Name = "CombatPage"
combatPage.Size = UDim2.new(1, -20, 1, -20)
combatPage.Position = UDim2.new(0, 10, 0, 10)
combatPage.BackgroundTransparency = 1
combatPage.BorderSizePixel = 0
combatPage.ScrollBarThickness = 6
combatPage.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
combatPage.Parent = contentFrame
combatPage.Visible = false

local combatLayout = Instance.new("UIListLayout")
combatLayout.SortOrder = Enum.SortOrder.LayoutOrder
combatLayout.Padding = UDim.new(0, 15)
combatLayout.Parent = combatPage

contentPages["Combat"] = combatPage

createFeatureCard(combatPage, "God Mode", "Take no damage from other players", "godMode", 1)
createFeatureCard(combatPage, "ESP", "See players and brainrots through walls", "esp", 2)
createFeatureCard(combatPage, "Anti Ragdoll", "Prevent ragdoll effects", "antiRagdoll", 3)

-- Misc Tab Content
local miscPage = Instance.new("ScrollingFrame")
miscPage.Name = "MiscPage"
miscPage.Size = UDim2.new(1, -20, 1, -20)
miscPage.Position = UDim2.new(0, 10, 0, 10)
miscPage.BackgroundTransparency = 1
miscPage.BorderSizePixel = 0
miscPage.ScrollBarThickness = 6
miscPage.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
miscPage.Parent = contentFrame
miscPage.Visible = false

local miscLayout = Instance.new("UIListLayout")
miscLayout.SortOrder = Enum.SortOrder.LayoutOrder
miscLayout.Padding = UDim.new(0, 15)
miscLayout.Parent = miscPage

contentPages["Misc"] = miscPage

createFeatureCard(miscPage, "Anti Kick", "Prevent being kicked from the game", "antiKick", 1)

-- Settings Tab Content
local settingsPage = Instance.new("ScrollingFrame")
settingsPage.Name = "SettingsPage"
settingsPage.Size = UDim2.new(1, -20, 1, -20)
settingsPage.Position = UDim2.new(0, 10, 0, 10)
settingsPage.BackgroundTransparency = 1
settingsPage.BorderSizePixel = 0
settingsPage.ScrollBarThickness = 6
settingsPage.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
settingsPage.Parent = contentFrame
settingsPage.Visible = false

contentPages["Settings"] = settingsPage

-- Tab switching functionality
for tabName, tabButton in pairs(tabButtons) do
    tabButton.MouseButton1Click:Connect(function()
        -- Hide all pages
        for _, page in pairs(contentPages) do
            page.Visible = false
        end
        
        -- Show selected page
        if contentPages[tabName] then
            contentPages[tabName].Visible = true
        end
        
        -- Update button colors
        for name, button in pairs(tabButtons) do
            button.BackgroundColor3 = name == tabName and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(25, 25, 30)
        end
        
        currentTab = tabName
    end)
end

-- Update canvas sizes
for _, page in pairs(contentPages) do
    local layout = page:FindFirstChild("UIListLayout")
    if layout then
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
        end)
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end
end

-- Make draggable
local dragging = false
local dragStart = nil
local startPos = nil

local function updateInput(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

headerFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

headerFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if dragging then
            updateInput(input)
        end
    end
end)

-- Close button functionality
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Noclip loop
RunService.Stepped:Connect(function()
    if scriptEnabled.noclip and character then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

print("Plutonium loaded successfully! Professional Steal a Brainrot Script is ready.")
