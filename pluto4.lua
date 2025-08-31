-- Stealth mobility: fly(E), speed(Shift), high-jump(↑↑Space)
local UIS=game:GetService("UserInputService")local RS=game:GetService("RunService")local P=game:GetService("Players").LocalPlayer local C,R,H
local function g()C=P.Character or P.CharacterAdded:Wait()R=C:WaitForChild("HumanoidRootPart")H=C:WaitForChild("Humanoid")end P.CharacterAdded:Connect(g)g()
local flyBV,speedBV
local function setFly(s)if s then if flyBV then flyBV:Destroy()end flyBV=Instance.new("BodyVelocity")flyBV.MaxForce=Vector3.new(4e4,4e4,4e4)flyBV.Velocity=Vector3.new()flyBV.Parent=R else if flyBV then flyBV:Destroy()flyBV=nil end end end
UIS.InputBegan:Connect(function(k,g)if g then return end if k.KeyCode==Enum.KeyCode.E then setFly(not flyBV)end end)
RS.Heartbeat:Connect(function()if flyBV and flyBV.Parent then local v=workspace.CurrentCamera.CFrame:VectorToWorldSpace(Vector3.new((UIS:IsKeyDown(Enum.KeyCode.D)and 1 or 0)+(UIS:IsKeyDown(Enum.KeyCode.A)and-1 or 0),(UIS:IsKeyDown(Enum.KeyCode.Space)and 1 or 0)+(UIS:IsKeyDown(Enum.KeyCode.LeftShift)and-1 or 0),(UIS:IsKeyDown(Enum.KeyCode.W)and-1 or 0)+(UIS:IsKeyDown(Enum.KeyCode.S)and 1 or 0)))flyBV.Velocity=v*60 end end)
UIS.InputBegan:Connect(function(k,g)if g or k.KeyCode~=Enum.KeyCode.LeftShift then return end speedBV=Instance.new("BodyVelocity")speedBV.MaxForce=Vector3.new(3e4,0,3e4)speedBV.Velocity=R.CFrame.LookVector*50 speedBV.Parent=R end)
UIS.InputEnded:Connect(function(k)if k.KeyCode==Enum.KeyCode.LeftShift and speedBV then speedBV:Destroy()speedBV=nil end end)
local last=0 UIS.InputBegan:Connect(function(k,g)if g or k.KeyCode~=Enum.KeyCode.Space then return end local t=tick()if t-last<.3 then local v=Instance.new("BodyVelocity")v.MaxForce=Vector3.new(0,4e4,0)v.Velocity=Vector3.new(0,100,0)v.Parent=R game:GetService("Debris"):AddItem(v,.2)end last=t end)
P.CharacterAdded:Connect(function()if flyBV then flyBV:Destroy()flyBV=nil end if speedBV then speedBV:Destroy()speedBV=nil end end)
