-- ==========================================================
--  STEALTH MOBILITY PACK  |  Executor-ready single file
--  • Fly (E toggle)     • High Jump (Space double-tap)
--  • Speed (Shift hold) • Auto-disconnect on respawn
-- ==========================================================
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Char, Root, Hum
local flyOn, flyBV, speedOn, speedBV
local lastJumpTime = 0

----------------------------------------------------------------
-- Utility
----------------------------------------------------------------
local function getChar()
    Char = Player.Character or Player.CharacterAdded:Wait()
    Root = Char:WaitForChild("HumanoidRootPart")
    Hum = Char:WaitForChild("Humanoid")
end

Player.CharacterAdded:Connect(getChar)
getChar()

----------------------------------------------------------------
-- 1.  FLY  (hold E to ascend, let go to descend)
----------------------------------------------------------------
local function setFly(state)
    if state then
        if flyBV then flyBV:Destroy() end
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(40000, 40000, 40000)
        flyBV.Velocity = Vector3.new()
        flyBV.Parent = Root
    else
        if flyBV then flyBV:Destroy() flyBV = nil end
    end
end

UIS.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.KeyCode == Enum.KeyCode.E then
        flyOn = not flyOn
        setFly(flyOn)
    end
end)

RunService.Heartbeat:Connect(function()
    if flyOn and flyBV then
        local dir = Camera.CFrame:VectorToWorldSpace(
            Vector3.new(
                (UIS:IsKeyDown(Enum.KeyCode.D) and 1 or 0) + (UIS:IsKeyDown(Enum.KeyCode.A) and -1 or 0),
                (UIS:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) + (UIS:IsKeyDown(Enum.KeyCode.LeftShift) and -1 or 0),
                (UIS:IsKeyDown(Enum.KeyCode.W) and -1 or 0) + (UIS:IsKeyDown(Enum.KeyCode.S) and 1 or 0)
            )
        )
        flyBV.Velocity = dir * 60
    end
end)

----------------------------------------------------------------
-- 2.  SPEED  (hold LeftShift forward)
----------------------------------------------------------------
UIS.InputBegan:Connect(function(inp, gp)
    if gp or inp.KeyCode ~= Enum.KeyCode.LeftShift then return end
    if speedBV then speedBV:Destroy() end
    speedBV = Instance.new("BodyVelocity")
    speedBV.MaxForce = Vector3.new(30000, 0, 30000)
    speedBV.Velocity = Root.CFrame.LookVector * 50
    speedBV.Parent = Root
    speedOn = true
end)

UIS.InputEnded:Connect(function(inp)
    if inp.KeyCode == Enum.KeyCode.LeftShift then
        speedOn = false
        if speedBV then speedBV:Destroy() speedBV = nil end
    end
end)

----------------------------------------------------------------
-- 3.  HIGH JUMP  (double-tap Space)
----------------------------------------------------------------
UIS.InputBegan:Connect(function(inp, gp)
    if gp or inp.KeyCode ~= Enum.KeyCode.Space then return end
    local now = tick()
    if now - lastJumpTime < 0.3 then
        -- Double-tap detected
        local vel = Instance.new("BodyVelocity")
        vel.MaxForce = Vector3.new(0, 40000, 0)
        vel.Velocity = Vector3.new(0, 100, 0)
        vel.Parent = Root
        game:GetService("Debris"):AddItem(vel, 0.2)
    end
    lastJumpTime = now
end)

----------------------------------------------------------------
-- 4.  AUTO-CLEANUP ON RESPAWN
----------------------------------------------------------------
Player.CharacterAdded:Connect(function()
    if flyBV then flyBV:Destroy() flyBV = nil end
    if speedBV then speedBV:Destroy() speedBV = nil end
    flyOn, speedOn = false, false
end)

----------------------------------------------------------------
-- 5.  OPTIONAL GUI INDICATOR
----------------------------------------------------------------
local Notification = Instance.new("ScreenGui")
local Text = Instance.new("TextLabel")
Notification.Name = "StealthMobility"
Text.Parent = Notification
Text.BackgroundTransparency = 1
Text.TextColor3 = Color3.new(1,1,1)
Text.TextStrokeTransparency = 0
Text.Size = UDim2.new(0, 200, 0, 30)
Text.Position = UDim2.new(0, 10, 0.9, 0)
Text.Text = "[E] Fly  [Shift] Speed  [↑↑Space] Jump"
Text.Font = Enum.Font.SourceSans
Text.TextSize = 14
Notification.Parent = game:GetService("CoreGui")

-- Remove old gui if script reruns
if _G.oldStealthGui then _G.oldStealthGui:Destroy() end
_G.oldStealthGui = Notification
