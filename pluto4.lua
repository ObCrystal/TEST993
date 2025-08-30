-- ==========================================================
--  ULTIMATE PREMIUM ROBLOX SCRIPT HUB  |  FIXED VERSION
--  Executor-ready (Synapse, KRNL, Wave, Delta, Solara…)
-- ==========================================================
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

-- Ensure Drawing API exists
if not Drawing then
    warn("❌ Drawing API not supported in this game")
    return
end

-- Drawing helpers
local function new(class, props)
    local obj = Drawing.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    return obj
end

local function tween(obj, time, props)
    return TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props)
end

-- Window setup
local win = {
    w = 420,
    h = 300,
    x = (workspace.CurrentCamera.ViewportSize.X - 420) / 2,
    y = (workspace.CurrentCamera.ViewportSize.Y - 300) / 2
}

-- Background
local bg = new("Square", {
    Visible = true,
    Transparency = 0.3,
    Color = Color3.fromRGB(25, 25, 25),
    Size = Vector2.new(win.w, win.h),
    Position = Vector2.new(win.x, win.y),
    Filled = true
})

-- Border
local border = new("Square", {
    Visible = true,
    Transparency = 0.5,
    Color = Color3.fromRGB(255, 255, 255),
    Size = bg.Size + Vector2.new(2, 2),
    Position = bg.Position - Vector2.new(1, 1),
    Filled = false,
    Thickness = 2
})

-- Title
local title = new("Text", {
    Visible = true,
    Text = "Ultimate Hub",
    Size = 20,
    Center = true,
    Outline = true,
    Color = Color3.fromRGB(255, 255, 255),
    Position = bg.Position + Vector2.new(win.w / 2, 15)
})

-- Draggable
local dragging, dragInput, dragStart, startPos
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local pos = input.Position
        if (Vector2.new(pos.X, pos.Y) - bg.Position - bg.Size/2).Magnitude < 100 then
            dragging = true
            dragStart = pos
            startPos = bg.Position
        end
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        local newPos = startPos + delta
        bg.Position = newPos
        border.Position = newPos - Vector2.new(1, 1)
        title.Position = newPos + Vector2.new(win.w/2, 15)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Theme manager
local themes = {
    ["Default"] = Color3.fromRGB(25, 25, 25),
    ["Neon"] = Color3.fromRGB(10, 10, 40),
    ["Red"] = Color3.fromRGB(40, 10, 10)
}
local currentTheme = "Default"

local function setTheme(name)
    if themes[name] then
        currentTheme = name
        tween(bg, 0.3, {Color = themes[name]}):Play()
    end
end

-- Widget controls
local createdWidgets = {}
local widgetStartY = 55
local widgetSpacing = 35

local function addToggle(name, default, callback)
    local y = widgetStartY + #createdWidgets * widgetSpacing
    local btn = new("Square", {
        Visible = true,
        Color = Color3.fromRGB(40, 40, 40),
        Size = Vector2.new(140, 25),
        Position = bg.Position + Vector2.new(20, y),
        Filled = true
    })

    local lbl = new("Text", {
        Visible = true,
        Text = name,
        Size = 16,
        Center = false,
        Outline = true,
        Color = Color3.fromRGB(255, 255, 255),
        Position = btn.Position + Vector2.new(8, 2)
    })

    local state = default
    local knob = new("Square", {
        Visible = true,
        Color = state and Color3.fromRGB(0, 255, 140) or Color3.fromRGB(255, 50, 50),
        Size = Vector2.new(12, 12),
        Position = btn.Position + Vector2.new(btn.Size.X - 20, 6),
        Filled = true
    })

    local function toggle()
        state = not state
        tween(knob, 0.2, {Color = state and Color3.fromRGB(0, 255, 140) or Color3.fromRGB(255, 50, 50)}):Play()
        callback(state)
    end

    UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local m = Vector2.new(input.Position.X, input.Position.Y)
            local pos = btn.Position
            local size = btn.Size
            if m.X >= pos.X and m.X <= pos.X + size.X and m.Y >= pos.Y and m.Y <= pos.Y + size.Y then
                toggle()
            end
        end
    end)

    table.insert(createdWidgets, {btn = btn, lbl = lbl, knob = knob})
end

local function addButton(name, callback)
    local y = widgetStartY + #createdWidgets * widgetSpacing
    local btn = new("Square", {
        Visible = true,
        Color = Color3.fromRGB(60, 60, 60),
        Size = Vector2.new(140, 25),
        Position = bg.Position + Vector2.new(20, y),
        Filled = true
    })

    local lbl = new("Text", {
        Visible = true,
        Text = name,
        Size = 16,
        Center = true,
        Outline = true,
        Color = Color3.fromRGB(255, 255, 255),
        Position = btn.Position + Vector2.new(btn.Size.X / 2, 2)
    })

    local hovering = false
    UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            local m = Vector2.new(input.Position.X, input.Position.Y)
            local pos = btn.Position
            local size = btn.Size
            local isOver = m.X >= pos.X and m.X <= pos.X + size.X and m.Y >= pos.Y and m.Y <= pos.Y + size.Y
            if isOver and not hovering then
                hovering = true
                tween(btn, 0.2, {Color = Color3.fromRGB(90, 90, 90)}):Play()
            elseif not isOver and hovering then
                hovering = false
                tween(btn, 0.2, {Color = Color3.fromRGB(60, 60, 60)}):Play()
            end
        end
    end)

    UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 and hovering then
            callback()
        end
    end)

    table.insert(createdWidgets, {btn = btn, lbl = lbl})
end

-- Modules
local modules = {
    {Name = "Silent Aimbot", Callback = function(state)
        if state then
            local RunService = game:GetService("RunService")
            local Camera = workspace.CurrentCamera
            local Player = Players.LocalPlayer
            local function getClosest()
                local closest, dist = nil, math.huge
                local myPos = Camera.CFrame.Position
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= Player and v.Character and v.Character:FindFirstChild("Head") then
                        local d = (v.Character.Head.Position - myPos).Magnitude
                        if d < dist then closest, dist = v, d end
                    end
                end
                return closest
            end
            _G.aimbotCon = RunService.RenderStepped:Connect(function()
                local target = getClosest()
                if target and target.Character:FindFirstChild("Head") then
                    local pos = Camera:WorldToViewportPoint(target.Character.Head.Position)
                    mousemoverel((pos.X - UserInputService:GetMouseLocation().X) * 0.1, (pos.Y - UserInputService:GetMouseLocation().Y) * 0.1)
                end
            end)
        else
            if _G.aimbotCon then _G.aimbotCon:Disconnect() end
        end
    end},

    {Name = "Player ESP", Callback = function(state)
        if state then
            local function addEsp(v)
                if v == Players.LocalPlayer then return end
                local b = Instance.new("BillboardGui")
                b.Name = "esp"
                b.AlwaysOnTop = true
                b.Size = UDim2.new(0, 200, 0, 50)
                b.Adornee = v.Character:WaitForChild("Head")
                local t = Instance.new("TextLabel", b)
                t.Text = v.Name
                t.BackgroundTransparency = 1
                t.TextColor3 = Color3.new(1, 1, 1)
                t.Size = UDim2.new(1, 0, 1, 0)
                b.Parent = v.Character
            end
            for _, v in pairs(Players:GetPlayers()) do
                if v.Character then addEsp(v) end
                v.CharacterAdded:Connect(function() addEsp(v) end)
            end
            Players.PlayerAdded:Connect(function(plr)
                plr.CharacterAdded:Connect(function() addEsp(plr) end)
            end)
        else
            for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                if v.Name == "esp" then v:Destroy() end
            end
        end
    end},

    {Name = "Fly", Callback = function(state)
        if state then
            local Player = Players.LocalPlayer
            local Char = Player.Character or Player.CharacterAdded:Wait()
            local Root = Char:WaitForChild("HumanoidRootPart")
            local BV = Instance.new("BodyVelocity")
            BV.MaxForce = Vector3.new(100000, 100000, 100000)
            BV.Velocity = Vector3.new(0, 0, 0)
            local flying = false
            UIS.InputBegan:Connect(function(inp, gp)
                if gp then return end
                if inp.KeyCode == Enum.KeyCode.E then
                    flying = true
                    BV.Parent = Root
                end
            end)
            UIS.InputEnded:Connect(function(inp)
                if inp.KeyCode == Enum.KeyCode.E then
                    flying = false
                    BV.Parent = nil
                end
            end)
            _G.flyLoop = game:GetService("RunService").Heartbeat:Connect(function()
                if flying then
                    BV.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
                end
            end)
        else
            if _G.flyLoop then _G.flyLoop:Disconnect() end
            for _, v in pairs(Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BodyVelocity") then v:Destroy() end
            end
        end
    end}
}

-- Populate UI
for _, mod in pairs(modules) do
    addToggle(mod.Name, false, mod.Callback)
end

addButton("Theme: Default", function()
    local keys = {}
    for k in pairs(themes) do table.insert(keys, k) end
    table.sort(keys)
    for i, k in ipairs(keys) do
        if k == currentTheme then
            local nextTheme = keys[i % #keys + 1]
            setTheme(nextTheme)
            for _, w in pairs(createdWidgets) do
                if w.lbl.Text:match("Theme") then
                    w.lbl.Text = "Theme: " .. nextTheme
                    break
                end
            end
            break
        end
    end
end)
