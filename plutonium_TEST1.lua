-- Roblox Game Hub Script
-- Professional dark-themed game hub

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RobloxGameHub"
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 800, 0, 600)
mainFrame.Position = UDim2.new(0.5, -400, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Add corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 60)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🎮 Roblox Game Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.Parent = header

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 15)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 18
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

-- Search Frame
local searchFrame = Instance.new("Frame")
searchFrame.Name = "SearchFrame"
searchFrame.Size = UDim2.new(1, -40, 0, 40)
searchFrame.Position = UDim2.new(0, 20, 0, 80)
searchFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
searchFrame.BorderSizePixel = 0
searchFrame.Parent = mainFrame

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 8)
searchCorner.Parent = searchFrame

-- Search TextBox
local searchBox = Instance.new("TextBox")
searchBox.Name = "SearchBox"
searchBox.Size = UDim2.new(1, -20, 1, 0)
searchBox.Position = UDim2.new(0, 10, 0, 0)
searchBox.BackgroundTransparency = 1
searchBox.PlaceholderText = "🔍 Search games..."
searchBox.Text = ""
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
searchBox.TextSize = 14
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.Font = Enum.Font.Gotham
searchBox.Parent = searchFrame

-- Games ScrollFrame
local gamesFrame = Instance.new("ScrollingFrame")
gamesFrame.Name = "GamesFrame"
gamesFrame.Size = UDim2.new(1, -40, 1, -160)
gamesFrame.Position = UDim2.new(0, 20, 0, 140)
gamesFrame.BackgroundTransparency = 1
gamesFrame.BorderSizePixel = 0
gamesFrame.ScrollBarThickness = 6
gamesFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
gamesFrame.Parent = mainFrame

-- Grid Layout
local gridLayout = Instance.new("UIGridLayout")
gridLayout.CellSize = UDim2.new(0, 180, 0, 220)
gridLayout.CellPadding = UDim2.new(0, 15, 0, 15)
gridLayout.SortOrder = Enum.SortOrder.Name
gridLayout.Parent = gamesFrame

-- Game data
local games = {
    {name = "Adopt Me!", players = "200K+", rating = "4.8", category = "Simulation"},
    {name = "Brookhaven RP", players = "150K+", rating = "4.6", category = "Roleplay"},
    {name = "Tower of Hell", players = "80K+", rating = "4.5", category = "Obby"},
    {name = "Arsenal", players = "120K+", rating = "4.7", category = "FPS"},
    {name = "Blox Fruits", players = "300K+", rating = "4.9", category = "Fighting"},
    {name = "Jailbreak", players = "90K+", rating = "4.4", category = "Action"}
}

-- Create game cards
for i, game in pairs(games) do
    local gameCard = Instance.new("Frame")
    gameCard.Name = "GameCard" .. i
    gameCard.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    gameCard.BorderSizePixel = 0
    gameCard.Parent = gamesFrame
    
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 8)
    cardCorner.Parent = gameCard
    
    -- Game Image
    local gameImage = Instance.new("Frame")
    gameImage.Size = UDim2.new(1, 0, 0, 120)
    gameImage.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    gameImage.BorderSizePixel = 0
    gameImage.Parent = gameCard
    
    local imageCorner = Instance.new("UICorner")
    imageCorner.CornerRadius = UDim.new(0, 8)
    imageCorner.Parent = gameImage
    
    -- Game Title
    local gameTitle = Instance.new("TextLabel")
    gameTitle.Size = UDim2.new(1, -10, 0, 25)
    gameTitle.Position = UDim2.new(0, 5, 0, 125)
    gameTitle.BackgroundTransparency = 1
    gameTitle.Text = game.name
    gameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    gameTitle.TextSize = 14
    gameTitle.TextXAlignment = Enum.TextXAlignment.Left
    gameTitle.Font = Enum.Font.GothamBold
    gameTitle.Parent = gameCard
    
    -- Stats
    local statsLabel = Instance.new("TextLabel")
    statsLabel.Size = UDim2.new(1, -10, 0, 20)
    statsLabel.Position = UDim2.new(0, 5, 0, 150)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Text = "👥 " .. game.players .. " | ⭐ " .. game.rating
    statsLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    statsLabel.TextSize = 12
    statsLabel.TextXAlignment = Enum.TextXAlignment.Left
    statsLabel.Font = Enum.Font.Gotham
    statsLabel.Parent = gameCard
    
    -- Get Script Button
    local scriptButton = Instance.new("TextButton")
    scriptButton.Size = UDim2.new(1, -10, 0, 30)
    scriptButton.Position = UDim2.new(0, 5, 1, -35)
    scriptButton.BackgroundColor3 = Color3.fromRGB(0, 123, 255)
    scriptButton.Text = "📥 Get Script"
    scriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    scriptButton.TextSize = 12
    scriptButton.Font = Enum.Font.GothamBold
    scriptButton.Parent = gameCard
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = scriptButton
    
    -- Button click effect
    scriptButton.MouseButton1Click:Connect(function()
        -- Copy loadstring to clipboard (example)
        local scriptCode = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/ObCrystal/TEST993/main/' .. game.name:gsub("%s+", "") .. '.lua"))()'
        setclipboard(scriptCode)
        
        -- Visual feedback
        scriptButton.Text = "✅ Copied!"
        wait(1)
        scriptButton.Text = "📥 Get Script"
    end)
end

-- Make draggable
local dragging = false
local dragStart = nil
local startPos = nil

local function updateInput(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

header.InputBegan:Connect(function(input)
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

header.InputChanged:Connect(function(input)
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

-- Update canvas size
gamesFrame.CanvasSize = UDim2.new(0, 0, 0, gridLayout.AbsoluteContentSize.Y + 20)
gridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    gamesFrame.CanvasSize = UDim2.new(0, 0, 0, gridLayout.AbsoluteContentSize.Y + 20)
end)

print("Roblox Game Hub loaded successfully!")
