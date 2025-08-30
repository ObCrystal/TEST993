-- Ultimate Script Hub for Roblox Script Executors
-- Paste this into your executor and run

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove old hub if exists
local oldHub = playerGui:FindFirstChild("UltimateScriptHub")
if oldHub then oldHub:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltimateScriptHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 350)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0.3
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 15)
uiCorner.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Ultimate Script Hub"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 26
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Parent = mainFrame

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, 0, 0, 40)
tabContainer.Position = UDim2.new(0, 0, 0, 40)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 10)
tabLayout.Parent = tabContainer

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -110)
contentFrame.Position = UDim2.new(0, 10, 0, 90)
contentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
contentFrame.BackgroundTransparency = 0.4
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 10)
contentCorner.Parent = contentFrame

local consoleOutput = Instance.new("TextBox")
consoleOutput.Size = UDim2.new(1, -20, 1, -20)
consoleOutput.Position = UDim2.new(0, 10, 0, 10)
consoleOutput.BackgroundTransparency = 1
consoleOutput.TextColor3 = Color3.fromRGB(200, 200, 200)
consoleOutput.TextWrapped = true
consoleOutput.TextXAlignment = Enum.TextXAlignment.Left
consoleOutput.TextYAlignment = Enum.TextYAlignment.Top
consoleOutput.ClearTextOnFocus = false
consoleOutput.MultiLine = true
consoleOutput.Text = "Welcome to Ultimate Script Hub!\nSelect a tab to get started."
consoleOutput.Parent = contentFrame
consoleOutput.ReadOnly = true
consoleOutput.Font = Enum.Font.Code
consoleOutput.TextSize = 14

local function createButton(text)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 130, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundTransparency = 0.7
    button.BorderSizePixel = 0
    button.Text = text
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 16
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.AutoButtonColor = false
    button.Parent = tabContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    button.MouseEnter:Connect(function()
        button.BackgroundTransparency = 0.3
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundTransparency = 0.7
    end)

    return button
end

local tabs = {}

-- Helper function to safely run scripts and capture output/errors
local function runScript(code)
    local func, err = loadstring(code)
    if not func then
        return false, "Error compiling script: " .. err
    end
    local success, result = pcall(func)
    if not success then
        return false, "Error running script: " .. result
    end
    return true, result or "Script executed successfully."
end

-- Scripts Tab
tabs["Scripts"] = function()
    consoleOutput.Text = "Scripts tab selected.\nAvailable scripts:\n- Fly
- Speed
- ESP
Click buttons below to execute."

    -- Clear previous buttons if any
    for _, child in ipairs(contentFrame:GetChildren()) do
        if child ~= consoleOutput then
            child:Destroy()
        end
    end

    local scripts = {
        Fly = [[
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            local flying = true
            local speed = 50
            local bodyVelocity = Instance.new("BodyVelocity", character.HumanoidRootPart)
            bodyVelocity.Velocity = Vector3.new(0,0,0)
            bodyVelocity.MaxForce = Vector3.new(0,0,0)
            coroutine.wrap(function()
                while flying do
                    bodyVelocity.MaxForce = Vector3.new(400000,400000,400000)
                    bodyVelocity.Velocity = Vector3.new(0, speed, 0)
                    wait(0.1)
                end
            end)()
        ]],
        Speed = [[
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.WalkSpeed = 100
        ]],
        ESP = [[
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = player.Character
                    highlight.FillColor = Color3.new(1, 0, 0)
                    highlight.OutlineColor = Color3.new(1, 1, 1)
                    highlight.Parent = player.Character
                end
            end
        ]],
    }

    local yPos = 10
    for name, code in pairs(scripts) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 150, 0, 30)
        btn.Position = UDim2.new(0, 10, 0, yPos)
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundTransparency = 0.6
        btn.BorderSizePixel = 0
        btn.Text = "Run " .. name
        btn.Font = Enum.Font.GothamSemibold
        btn.TextSize = 16
        btn.TextColor3 = Color3.fromRGB(0, 0, 0)
        btn.Parent = contentFrame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn

        btn.MouseEnter:Connect(function()
            btn.BackgroundTransparency = 0.3
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundTransparency = 0.6
        end)

        btn.MouseButton1Click:Connect(function()
            consoleOutput.Text = "Running " .. name .. " script..."
            local success, result = runScript(code)
            if success then
                consoleOutput.Text = result
            else
                consoleOutput.Text = result
            end
        end)

        yPos = yPos + 40
    end
end

-- Executor Tab: Paste and run any script
tabs["Executor"] = function()
    consoleOutput.Text = "Paste any Lua script below and click Execute."

    -- Clear previous children except consoleOutput
    for _, child in ipairs(contentFrame:GetChildren()) do
        if child ~= consoleOutput then
            child:Destroy()
        end
    end

    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(1, -20, 0, 150)
    inputBox.Position = UDim2.new(0, 10, 0, 10)
    inputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.Font = Enum.Font.Code
    inputBox.TextSize = 14
    inputBox.ClearTextOnFocus = false
    inputBox.MultiLine = true
    inputBox.TextWrapped = true
    inputBox.PlaceholderText = "Paste your Lua script here..."
    inputBox.Parent = contentFrame

    local execButton = Instance.new("TextButton")
    execButton.Size = UDim2.new(0, 120, 0, 30)
    execButton.Position = UDim2.new(1, -130, 0, 170)
    execButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    execButton.BorderSizePixel = 0
    execButton.Text = "Execute"
    execButton.Font = Enum.Font.GothamBold
    execButton.TextSize = 18
    execButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    execButton.Parent = contentFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = execButton

    execButton.MouseEnter:Connect(function()
        execButton.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
    end)
    execButton.MouseLeave:Connect(function()
        execButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    end)

    execButton.MouseButton1Click:Connect(function()
        local code = inputBox.Text
        if code == "" then
            consoleOutput.Text = "Please paste a script to execute."
            return
        end
        consoleOutput.Text = "Executing script..."
        local success, result = runScript(code)
        if success then
            consoleOutput.Text = tostring(result)
        else
            consoleOutput.Text = tostring(result)
        end
    end)
end

-- Settings Tab for background color customization
tabs["Settings"] = function()
    consoleOutput.Text = "Settings tab selected.\nCustomize your script hub background color."

    for _, child in ipairs(contentFrame:GetChildren()) do
        if child ~= consoleOutput then
            child:Destroy()
        end
    end

    local colors = {"R", "G", "B"}
    local sliders = {}

    for i, color in ipairs(colors) do
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 20, 0, 20)
        label.Position = UDim2.new(0, 10, 0, 30 * (i - 1) + 10)
        label.BackgroundTransparency = 1
        label.Text = color
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 18
        label.Parent = contentFrame

        local slider = Instance.new("TextBox") -- Roblox doesn't have slider by default, so using TextBox for input 0-255
        slider.Size = UDim2.new(0, 200, 0, 25)
        slider.Position = UDim2.new(0, 40, 0, 30 * (i - 1) + 5)
        slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        slider.TextColor3 = Color3.fromRGB(255, 255, 255)
        slider.Font = Enum.Font.Gotham
        slider.TextSize = 18
        slider.Text = tostring(math.floor(mainFrame.BackgroundColor3[color == "R" and 1 or color == "G" and 2 or 3] * 255))
        slider.ClearTextOnFocus = false
        slider.Parent = contentFrame

        sliders[color] = slider
    end

    local function updateColor()
        local r = tonumber(sliders["R"].Text) or 20
        local g = tonumber(sliders["G"].Text) or 20
        local b = tonumber(sliders["B"].Text) or 20
        r = math.clamp(r, 0, 255)
        g = math.clamp(g, 0, 255)
        b = math.clamp(b, 0, 255)
        mainFrame.BackgroundColor3 = Color3.fromRGB(r, g, b)
    end

    for _, slider in pairs(sliders) do
        slider.FocusLost:Connect(function()
            updateColor()
        end)
    end
end

-- Create tab buttons and connect handlers
for tabName, handler in pairs(tabs) do
    local btn = createButton(tabName)
    btn.MouseButton1Click:Connect(function()
        -- Clear content except consoleOutput
        for _, child in ipairs(contentFrame:GetChildren()) do
            if child ~= consoleOutput then
                child:Destroy()
            end
        end
        handler()
    end)
end

-- Select default tab
tabs["Scripts"]()
