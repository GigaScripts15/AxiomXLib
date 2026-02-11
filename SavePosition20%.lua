local a=game:GetService("Players")
local b=game:GetService("TweenService")
local c=game:GetService("UserInputService")
local d=a.LocalPlayer

local function e()
    local f=d.Character or d.CharacterAdded:Wait()
    return f:WaitForChild("HumanoidRootPart")
end

local function g()
    local h=e().CFrame.Position
    setclipboard(string.format("CFrame.new(%.3f, %.3f, %.3f)",h.X,h.Y,h.Z))
end

local i=Instance.new("ScreenGui",d:WaitForChild("PlayerGui"))
i.Name="x"..math.random(100,999)
i.ResetOnSpawn=false

local j=Instance.new("Frame",i)
j.Size=UDim2.new(0,220,0,120)
j.Position=UDim2.new(.5,-110,.5,-60)
j.BackgroundColor3=Color3.new(0,0,0)
j.BorderSizePixel=0
Instance.new("UICorner",j).CornerRadius=UDim.new(0,12)

local k=Instance.new("UIScale",j)
k.Scale=0

local l=Instance.new("TextButton",j)
l.Size=UDim2.new(.85,0,.45,0)
l.Position=UDim2.new(.075,0,.35,0)
l.BackgroundColor3=Color3.fromRGB(20,20,20)
l.Text="SAVE POSITION"
l.Font=Enum.Font.Code
l.TextSize=16
l.TextColor3=Color3.fromRGB(0,255,120)
l.BorderSizePixel=0
Instance.new("UICorner",l).CornerRadius=UDim.new(0,8)

local m=Instance.new("TextButton",j)
m.Size=UDim2.new(0,26,0,26)
m.Position=UDim2.new(1,-30,0,4)
m.BackgroundColor3=Color3.fromRGB(20,20,20)
m.Text="✕"
m.Font=Enum.Font.Code
m.TextSize=16
m.TextColor3=Color3.fromRGB(255,80,80)
m.BorderSizePixel=0
Instance.new("UICorner",m).CornerRadius=UDim.new(1,0)

b:Create(k,TweenInfo.new(.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play()

local function n()
    local o=b:Create(k,TweenInfo.new(.4,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Scale=0})
    o:Play()
    o.Completed:Connect(function() i:Destroy() end)
end

l.MouseButton1Click:Connect(function()
    g()
    local p=b:Create(l,TweenInfo.new(.08),{Size=UDim2.new(.80,0,.42,0)})
    local q=b:Create(l,TweenInfo.new(.08),{Size=UDim2.new(.85,0,.45,0)})
    p:Play() p.Completed:Wait() q:Play()
end)

m.MouseButton1Click:Connect(n)

local r=false
local s,t

j.InputBegan:Connect(function(u)
    if u.UserInputType==Enum.UserInputType.MouseButton1 or u.UserInputType==Enum.UserInputType.Touch then
        r=true s=u.Position t=j.Position
    end
end)

j.InputEnded:Connect(function(u)
    if u.UserInputType==Enum.UserInputType.MouseButton1 or u.UserInputType==Enum.UserInputType.Touch then
        r=false
    end
end)

c.InputChanged:Connect(function(u)
    if r and (u.UserInputType==Enum.UserInputType.MouseMovement or u.UserInputType==Enum.UserInputType.Touch) then
        local v=u.Position-s
        j.Position=UDim2.new(t.X.Scale,t.X.Offset+v.X,t.Y.Scale,t.Y.Offset+v.Y)
    end
end)
