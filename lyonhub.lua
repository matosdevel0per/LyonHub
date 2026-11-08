-- LYON HUB | Brookhaven | Delta Executor

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")

local LP = Players.LocalPlayer
local Character = LP.Character or LP.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

LP.CharacterAdded:Connect(function(c)
    Character = c
    RootPart = c:WaitForChild("HumanoidRootPart")
    Humanoid = c:WaitForChild("Humanoid")
end)

local C = {
    BG       = Color3.fromRGB(28, 28, 30),
    Panel    = Color3.fromRGB(38, 38, 42),
    Sidebar  = Color3.fromRGB(22, 22, 25),
    Accent   = Color3.fromRGB(130, 130, 145),
    AccentLt = Color3.fromRGB(180, 180, 195),
    AccentDk = Color3.fromRGB(55, 55, 62),
    Text     = Color3.fromRGB(220, 220, 225),
    TextDim  = Color3.fromRGB(120, 120, 130),
    Border   = Color3.fromRGB(55, 55, 62),
    TGL_ON   = Color3.fromRGB(160, 160, 175),
    TGL_OFF  = Color3.fromRGB(55, 55, 62),
    White    = Color3.fromRGB(255, 255, 255),
    Sep      = Color3.fromRGB(50, 50, 56),
}

local State = {
    Fly=false, Noclip=false, InfJump=false,
    Speed=false, SpeedVal=60, FlySpeed=50,
    GodMode=false, AntiVoid=false,
    ESP=false, FullBright=false,
    SpamMsg=false, SpamText="lyon hub",
}

local ESPObjects = {}
local FlyBV, FlyBG
local TabButtons = {}
local TabPanels = {}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LyonHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
pcall(function() ScreenGui.Parent = game.CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LP.PlayerGui end

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 580, 0, 400)
Main.Position = UDim2.new(0.5, -290, 0.5, -200)
Main.BackgroundColor3 = C.BG
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
local MS = Instance.new("UIStroke")
MS.Color = C.Border
MS.Thickness = 1.5
MS.Parent = Main

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 38)
Header.BackgroundColor3 = C.Sidebar
Header.BorderSizePixel = 0
Header.ZIndex = 5
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)

local HFix = Instance.new("Frame")
HFix.Size = UDim2.new(1, 0, 0, 8)
HFix.Position = UDim2.new(0, 0, 1, -8)
HFix.BackgroundColor3 = C.Sidebar
HFix.BorderSizePixel = 0
HFix.ZIndex = 5
HFix.Parent = Header

local HS = Instance.new("UIStroke")
HS.Color = C.Border
HS.Thickness = 1
HS.Parent = Header

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 160, 1, 0)
Logo.Position = UDim2.new(0, 12, 0, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "LYON HUB"
Logo.TextColor3 = C.AccentLt
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 14
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.ZIndex = 6
Logo.Parent = Header

local SubL = Instance.new("TextLabel")
SubL.Size = UDim2.new(0, 80, 1, 0)
SubL.Position = UDim2.new(0, 102, 0, 0)
SubL.BackgroundTransparency = 1
SubL.Text = "v1.0"
SubL.TextColor3 = C.TextDim
SubL.Font = Enum.Font.Gotham
SubL.TextSize = 10
SubL.TextXAlignment = Enum.TextXAlignment.Left
SubL.ZIndex = 6
SubL.Parent = Header

-- Bolinha flutuante
local Minimized = false
local Ball = Instance.new("TextButton")
Ball.Size = UDim2.new(0, 36, 0, 36)
Ball.Position = UDim2.new(0, 16, 0.5, -18)
Ball.BackgroundColor3 = C.AccentLt
Ball.Text = "L"
Ball.TextColor3 = C.White
Ball.Font = Enum.Font.GothamBold
Ball.TextSize = 14
Ball.BorderSizePixel = 0
Ball.ZIndex = 999
Ball.Visible = false
Ball.Parent = ScreenGui
Instance.new("UICorner", Ball).CornerRadius = UDim.new(1, 0)

-- Arrastar bolinha
local dragBall = false
local dragStart, ballStart

Ball.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragBall = true
        dragStart = input.Position
        ballStart = Ball.Position
    end
end)

Ball.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragBall = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragBall and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        Ball.Position = UDim2.new(
            ballStart.X.Scale,
            ballStart.X.Offset + delta.X,
            ballStart.Y.Scale,
            ballStart.Y.Offset + delta.Y
        )
    end
end)

-- Botoes header
local function HBtn(txt, ox, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 26, 0, 26)
    b.Position = UDim2.new(1, ox, 0.5, -13)
    b.BackgroundTransparency = 1
    b.Text = txt
    b.TextColor3 = C.TextDim
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.ZIndex = 7
    b.Parent = Header
    b.MouseButton1Click:Connect(cb)
end

HBtn("−", -56, function()
    Minimized = true
    TweenService:Create(Main, TweenInfo.new(0.2), {Size = UDim2.new(0,0,0,0)}):Play()
    task.wait(0.2)
    Main.Visible = false
    Ball.Visible = true
end)
HBtn("x", -28, function() ScreenGui:Destroy() end)

Ball.MouseButton1Click:Connect(function()
    if dragBall then return end
    Minimized = false
    Ball.Visible = false
    Main.Visible = true
    Main.Size = UDim2.new(0,0,0,0)
    TweenService:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 580, 0, 400)
    }):Play()
end)

-- Sidebar
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 130, 1, -38)
Sidebar.Position = UDim2.new(0, 0, 0, 38)
Sidebar.BackgroundColor3 = C.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 2
Sidebar.ScrollBarImageColor3 = C.Accent
Sidebar.CanvasSize = UDim2.new(0,0,0,0)
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
Sidebar.ZIndex = 3
Sidebar.Parent = Main

local SL = Instance.new("UIListLayout")
SL.Padding = UDim.new(0, 2)
SL.Parent = Sidebar

local SP = Instance.new("UIPadding")
SP.PaddingTop = UDim.new(0, 6)
SP.PaddingLeft = UDim.new(0, 5)
SP.PaddingRight = UDim.new(0, 5)
SP.Parent = Sidebar

local Div = Instance.new("Frame")
Div.Size = UDim2.new(0, 1, 1, -38)
Div.Position = UDim2.new(0, 130, 0, 38)
Div.BackgroundColor3 = C.Border
Div.BorderSizePixel = 0
Div.ZIndex = 3
Div.Parent = Main

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -132, 1, -38)
Content.Position = UDim2.new(0, 132, 0, 38)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ClipsDescendants = true
Content.ZIndex = 2
Content.Parent = Main

-- Helpers
local function NewPanel()
    local sf = Instance.new("ScrollingFrame")
    sf.Size = UDim2.new(1,0,1,0)
    sf.BackgroundTransparency = 1
    sf.BorderSizePixel = 0
    sf.ScrollBarThickness = 2
    sf.ScrollBarImageColor3 = C.Accent
    sf.CanvasSize = UDim2.new(0,0,0,0)
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sf.Visible = false
    sf.ZIndex = 3
    sf.Parent = Content
    local ul = Instance.new("UIListLayout")
    ul.Padding = UDim.new(0, 5)
    ul.Parent = sf
    local up = Instance.new("UIPadding")
    up.PaddingTop = UDim.new(0, 8)
    up.PaddingLeft = UDim.new(0, 8)
    up.PaddingRight = UDim.new(0, 8)
    up.PaddingBottom = UDim.new(0, 8)
    up.Parent = sf
    return sf
end

local function SideTab(icon, label, panel)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 32)
    Btn.BackgroundColor3 = C.Sidebar
    Btn.BorderSizePixel = 0
    Btn.Text = ""
    Btn.ZIndex = 4
    Btn.Parent = Sidebar
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    local IL = Instance.new("TextLabel")
    IL.Size = UDim2.new(0, 20, 1, 0)
    IL.Position = UDim2.new(0, 8, 0, 0)
    IL.BackgroundTransparency = 1
    IL.Text = icon
    IL.TextColor3 = C.TextDim
    IL.TextSize = 13
    IL.ZIndex = 5
    IL.Parent = Btn

    local NL = Instance.new("TextLabel")
    NL.Size = UDim2.new(1, -34, 1, 0)
    NL.Position = UDim2.new(0, 30, 0, 0)
    NL.BackgroundTransparency = 1
    NL.Text = label
    NL.TextColor3 = C.TextDim
    NL.Font = Enum.Font.Gotham
    NL.TextSize = 12
    NL.TextXAlignment = Enum.TextXAlignment.Left
    NL.ZIndex = 5
    NL.Parent = Btn

    local AB = Instance.new("Frame")
    AB.Size = UDim2.new(0, 2, 0.6, 0)
    AB.Position = UDim2.new(0, 0, 0.2, 0)
    AB.BackgroundColor3 = C.AccentLt
    AB.BorderSizePixel = 0
    AB.Visible = false
    AB.ZIndex = 6
    AB.Parent = Btn
    Instance.new("UICorner", AB).CornerRadius = UDim.new(0,2)

    table.insert(TabButtons, {btn=Btn, bar=AB, name=NL, icon=IL})
    table.insert(TabPanels, panel)

    Btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(TabPanels) do p.Visible = false end
        for _, t in ipairs(TabButtons) do
            t.btn.BackgroundColor3 = C.Sidebar
            t.bar.Visible = false
            t.name.TextColor3 = C.TextDim
            t.icon.TextColor3 = C.TextDim
        end
        panel.Visible = true
        Btn.BackgroundColor3 = C.AccentDk
        AB.Visible = true
        NL.TextColor3 = C.Text
        IL.TextColor3 = C.AccentLt
    end)
end

local function Sep(parent, text)
    local F = Instance.new("Frame")
    F.Size = UDim2.new(1, 0, 0, 20)
    F.BackgroundColor3 = C.Sep
    F.BorderSizePixel = 0
    F.ZIndex = 4
    F.Parent = parent
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 4)
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(1, -10, 1, 0)
    L.Position = UDim2.new(0, 8, 0, 0)
    L.BackgroundTransparency = 1
    L.Text = text:upper()
    L.TextColor3 = C.Accent
    L.Font = Enum.Font.GothamBold
    L.TextSize = 10
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.ZIndex = 5
    L.Parent = F
end

local function Container(parent)
    local F = Instance.new("Frame")
    F.Size = UDim2.new(1, 0, 0, 0)
    F.AutomaticSize = Enum.AutomaticSize.Y
    F.BackgroundColor3 = C.Panel
    F.BorderSizePixel = 0
    F.ZIndex = 4
    F.Parent = parent
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 6)
    local S = Instance.new("UIStroke")
    S.Color = C.Border
    S.Thickness = 1
    S.Parent = F
    local ul = Instance.new("UIListLayout")
    ul.Padding = UDim.new(0, 0)
    ul.Parent = F
    return F
end

local function MakeToggle(parent, label, desc, cb)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 44)
    Row.BackgroundTransparency = 1
    Row.BorderSizePixel = 0
    Row.ZIndex = 5
    Row.Parent = parent

    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, -16, 0, 1)
    Line.Position = UDim2.new(0, 8, 1, -1)
    Line.BackgroundColor3 = C.Sep
    Line.BorderSizePixel = 0
    Line.ZIndex = 6
    Line.Parent = Row

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(0.6, 0, 0, 20)
    Lbl.Position = UDim2.new(0, 10, 0, 6)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label
    Lbl.TextColor3 = C.Text
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextSize = 12
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 6
    Lbl.Parent = Row

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(0.65, 0, 0, 14)
    Desc.Position = UDim2.new(0, 10, 0, 26)
    Desc.BackgroundTransparency = 1
    Desc.Text = desc
    Desc.TextColor3 = C.TextDim
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 10
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.ZIndex = 6
    Desc.Parent = Row

    local enabled = false
    local Pill = Instance.new("Frame")
    Pill.Size = UDim2.new(0, 38, 0, 20)
    Pill.Position = UDim2.new(1, -46, 0.5, -10)
    Pill.BackgroundColor3 = C.TGL_OFF
    Pill.BorderSizePixel = 0
    Pill.ZIndex = 6
    Pill.Parent = Row
    Instance.new("UICorner", Pill).CornerRadius = UDim.new(1,0)

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.Position = UDim2.new(0, 3, 0.5, -7)
    Knob.BackgroundColor3 = C.White
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 7
    Knob.Parent = Pill
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1,0)

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.ZIndex = 8
    Btn.Parent = Row

    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        local ti = TweenInfo.new(0.18, Enum.EasingStyle.Quad)
        if enabled then
            TweenService:Create(Pill, ti, {BackgroundColor3 = C.TGL_ON}):Play()
            TweenService:Create(Knob, ti, {Position = UDim2.new(0, 21, 0.5, -7)}):Play()
        else
            TweenService:Create(Pill, ti, {BackgroundColor3 = C.TGL_OFF}):Play()
            TweenService:Create(Knob, ti, {Position = UDim2.new(0, 3, 0.5, -7)}):Play()
        end
        cb(enabled)
    end)
end

local function MakeButton(parent, label, desc, cb)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 44)
    Row.BackgroundTransparency = 1
    Row.BorderSizePixel = 0
    Row.ZIndex = 5
    Row.Parent = parent

    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, -16, 0, 1)
    Line.Position = UDim2.new(0, 8, 1, -1)
    Line.BackgroundColor3 = C.Sep
    Line.BorderSizePixel = 0
    Line.ZIndex = 6
    Line.Parent = Row

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(0.75, 0, 0, 20)
    Lbl.Position = UDim2.new(0, 10, 0, 6)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label
    Lbl.TextColor3 = C.Text
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextSize = 12
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 6
    Lbl.Parent = Row

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(0.75, 0, 0, 14)
    Desc.Position = UDim2.new(0, 10, 0, 26)
    Desc.BackgroundTransparency = 1
    Desc.Text = desc
    Desc.TextColor3 = C.TextDim
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 10
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.ZIndex = 6
    Desc.Parent = Row

    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.new(0, 16, 1, 0)
    Arrow.Position = UDim2.new(1, -22, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = ">"
    Arrow.TextColor3 = C.Accent
    Arrow.Font = Enum.Font.GothamBold
    Arrow.TextSize = 14
    Arrow.ZIndex = 6
    Arrow.Parent = Row

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1,0,1,0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.ZIndex = 8
    Btn.Parent = Row

    Btn.MouseButton1Click:Connect(function()
        Row.BackgroundColor3 = C.AccentDk
        Row.BackgroundTransparency = 0
        task.delay(0.12, function() Row.BackgroundTransparency = 1 end)
        cb()
    end)
end

local function MakeSlider(parent, label, min, max, default, cb)
    local value = default
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 52)
    Row.BackgroundTransparency = 1
    Row.BorderSizePixel = 0
    Row.ZIndex = 5
    Row.Parent = parent

    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, -16, 0, 1)
    Line.Position = UDim2.new(0, 8, 1, -1)
    Line.BackgroundColor3 = C.Sep
    Line.BorderSizePixel = 0
    Line.ZIndex = 6
    Line.Parent = Row

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, -10, 0, 18)
    Lbl.Position = UDim2.new(0, 10, 0, 6)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label .. ":  " .. tostring(default)
    Lbl.TextColor3 = C.Text
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextSize = 11
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 6
    Lbl.Parent = Row

    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, -20, 0, 5)
    Track.Position = UDim2.new(0, 10, 0, 34)
    Track.BackgroundColor3 = C.AccentDk
    Track.BorderSizePixel = 0
    Track.ZIndex = 6
    Track.Parent = Row
    Instance.new("UICorner", Track).CornerRadius = UDim.new(1,0)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    Fill.BackgroundColor3 = C.AccentLt
    Fill.BorderSizePixel = 0
    Fill.ZIndex = 7
    Fill.Parent = Track
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1,0)

    local Knob = Instance.new("TextButton")
    Knob.Size = UDim2.new(0, 12, 0, 12)
    Knob.Position = UDim2.new((default-min)/(max-min), -6, 0.5, -6)
    Knob.BackgroundColor3 = C.White
    Knob.Text = ""
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 8
    Knob.Parent = Track
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1,0)

    local drag = false
    Knob.MouseButton1Down:Connect(function() drag = true end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
            local p = math.clamp((i.Position.X - Track.AbsolutePosition.X)/Track.AbsoluteSize.X, 0, 1)
            value = math.floor(min + (max-min)*p)
            Fill.Size = UDim2.new(p,0,1,0)
            Knob.Position = UDim2.new(p,-6,0.5,-6)
            Lbl.Text = label .. ":  " .. tostring(value)
            cb(value)
        end
    end)
end

local function MakeInput(parent, placeholder, cb)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 38)
    Row.BackgroundTransparency = 1
    Row.ZIndex = 5
    Row.Parent = parent

    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, -16, 0, 1)
    Line.Position = UDim2.new(0, 8, 1, -1)
    Line.BackgroundColor3 = C.Sep
    Line.BorderSizePixel = 0
    Line.ZIndex = 6
    Line.Parent = Row

    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(0.7, 0, 1, -10)
    Box.Position = UDim2.new(0, 10, 0, 5)
    Box.BackgroundColor3 = C.AccentDk
    Box.PlaceholderText = placeholder
    Box.PlaceholderColor3 = C.TextDim
    Box.Text = ""
    Box.TextColor3 = C.Text
    Box.Font = Enum.Font.Gotham
    Box.TextSize = 11
    Box.BorderSizePixel = 0
    Box.ZIndex = 6
    Box.Parent = Row
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0,4)

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.24, 0, 1, -10)
    Btn.Position = UDim2.new(0.74, 0, 0, 5)
    Btn.BackgroundColor3 = C.Accent
    Btn.Text = "OK"
    Btn.TextColor3 = C.White
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 11
    Btn.BorderSizePixel = 0
    Btn.ZIndex = 6
    Btn.Parent = Row
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,4)
    Btn.MouseButton1Click:Connect(function() cb(Box.Text) end)
    return Box
end

-- ============================================================
-- PANELS
-- ============================================================

-- JOGADOR
local PJogador = NewPanel()
Sep(PJogador, "Movimento")
local CMove = Container(PJogador)
MakeToggle(CMove, "Speed Hack", "Aumenta velocidade", function(on)
    State.Speed = on
    if Humanoid then Humanoid.WalkSpeed = on and State.SpeedVal or 16 end
end)
MakeSlider(CMove, "Velocidade", 16, 250, 60, function(v)
    State.SpeedVal = v
    if State.Speed and Humanoid then Humanoid.WalkSpeed = v end
end)
MakeToggle(CMove, "Fly", "Voa com WASD + Espaco", function(on)
    State.Fly = on
    if on then
        RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        if not RootPart then return end
        FlyBV = Instance.new("BodyVelocity")
        FlyBV.MaxForce = Vector3.new(1e5,1e5,1e5)
        FlyBV.Velocity = Vector3.zero
        FlyBV.Parent = RootPart
        FlyBG = Instance.new("BodyGyro")
        FlyBG.MaxTorque = Vector3.new(1e5,1e5,1e5)
        FlyBG.P = 1e4
        FlyBG.Parent = RootPart
    else
        if FlyBV then FlyBV:Destroy() FlyBV = nil end
        if FlyBG then FlyBG:Destroy() FlyBG = nil end
    end
end)
MakeSlider(CMove, "Velocidade de voo", 10, 200, 50, function(v) State.FlySpeed = v end)
MakeToggle(CMove, "Noclip", "Atravessa paredes", function(on) State.Noclip = on end)
MakeToggle(CMove, "Infinite Jump", "Pula infinitamente", function(on) State.InfJump = on end)

Sep(PJogador, "Survival")
local CSurv = Container(PJogador)
MakeToggle(CSurv, "God Mode", "HP sempre no maximo", function(on) State.GodMode = on end)
MakeToggle(CSurv, "Anti-Void", "Teleporta de volta se cair", function(on) State.AntiVoid = on end)
MakeButton(CSurv, "Resetar personagem", "Mata e respawna", function()
    if Humanoid then Humanoid.Health = 0 end
end)

-- JOGADORES
local PJogadores = NewPanel()
Sep(PJogadores, "Visual")
local CVis = Container(PJogadores)
MakeToggle(CVis, "ESP Players", "Mostra players atraves das paredes", function(on)
    State.ESP = on
    if not on then
        for _, o in pairs(ESPObjects) do if o and o.Parent then o:Destroy() end end
        ESPObjects = {}
    end
end)

Sep(PJogadores, "Acoes")
local CAc = Container(PJogadores)
MakeButton(CAc, "Listar players", "Printa nomes no console", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then print("► " .. p.Name) end
    end
end)
MakeInput(CAc, "Teleport para player (nome)...", function(name)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Name:lower():find(name:lower()) then
            local c = p.Character
            if c then
                local r = c:FindFirstChild("HumanoidRootPart")
                if r and RootPart then RootPart.CFrame = r.CFrame + Vector3.new(2,0,0) end
            end
        end
    end
end)
MakeInput(CAc, "Head Sit (nome do player)...", function(name)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Name:lower():find(name:lower()) then
            local c = p.Character
            if c then
                local head = c:FindFirstChild("Head")
                if head and RootPart then
                    RootPart.CFrame = CFrame.new(head.Position + Vector3.new(0,2,0))
                    local w = Instance.new("WeldConstraint")
                    w.Part0 = RootPart w.Part1 = head w.Parent = RootPart
                end
            end
        end
    end
end)

-- TELEPORTES
local PTeleport = NewPanel()
Sep(PTeleport, "Pontos do mapa")
local CTp = Container(PTeleport)
local tpPoints = {
    {"Spawn", Vector3.new(0,5,0)},
    {"Escola", Vector3.new(120,5,80)},
    {"Hospital", Vector3.new(-120,5,60)},
    {"Policia", Vector3.new(80,5,-100)},
    {"Banco", Vector3.new(-80,5,-120)},
    {"Parque", Vector3.new(0,5,200)},
    {"Supermercado", Vector3.new(200,5,0)},
}
for _, tp in ipairs(tpPoints) do
    MakeButton(CTp, tp[1], "Teleporta para " .. tp[1], function()
        if RootPart then RootPart.CFrame = CFrame.new(tp[2]) end
    end)
end
Sep(PTeleport, "Por player")
local CTp2 = Container(PTeleport)
MakeInput(CTp2, "Nome do player...", function(name)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Name:lower():find(name:lower()) then
            local c = p.Character
            if c then
                local r = c:FindFirstChild("HumanoidRootPart")
                if r and RootPart then RootPart.CFrame = r.CFrame + Vector3.new(2,0,0) end
            end
        end
    end
end)

-- AVATAR
local PAvatar = NewPanel()
Sep(PAvatar, "Escala")
local CAv = Container(PAvatar)
MakeButton(CAv, "Gigante", "Escala para 5x", function()
    if Character then
        local h = Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=5 h.BodyHeightScale.Value=5 h.BodyWidthScale.Value=5 h.HeadScale.Value=5 end
    end
end)
MakeButton(CAv, "Normal", "Restaura escala", function()
    if Character then
        local h = Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=1 h.BodyHeightScale.Value=1 h.BodyWidthScale.Value=1 h.HeadScale.Value=1 end
    end
end)
MakeButton(CAv, "Minusculo", "Escala para 0.3x", function()
    if Character then
        local h = Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=.3 h.BodyHeightScale.Value=.3 h.BodyWidthScale.Value=.3 h.HeadScale.Value=.3 end
    end
end)
Sep(PAvatar, "Visual")
local CAv2 = Container(PAvatar)
MakeToggle(CAv2, "Invisible", "Torna personagem transparente", function(on)
    if Character then
        for _, p in ipairs(Character:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                p.Transparency = on and 1 or 0
            end
        end
    end
end)
MakeToggle(CAv2, "RGB Personagem", "Muda cor em loop", function(on)
    if on then
        task.spawn(function()
            local t = 0
            while on do
                t = t + 0.05
                local col = Color3.fromHSV(t%1, 1, 1)
                if Character then
                    for _, p in ipairs(Character:GetDescendants()) do
                        if p:IsA("BasePart") then p.Color = col end
                    end
                end
                task.wait(0.05)
            end
        end)
    end
end)

-- MUNDO
local PMundo = NewPanel()
Sep(PMundo, "Iluminacao")
local CIl = Container(PMundo)
MakeToggle(CIl, "Full Bright", "Remove escuridao do mapa", function(on)
    if on then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(255,255,255)
    else
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
        Lighting.Ambient = Color3.fromRGB(100,100,100)
    end
end)

-- TROLL
local PTroll = NewPanel()
Sep(PTroll, "Chat")
local CTr = Container(PTroll)
MakeToggle(CTr, "Spam chat", "Manda texto repetido", function(on) State.SpamMsg = on end)
MakeInput(CTr, "Texto do spam...", function(txt) State.SpamText = txt ~= "" and txt or "lyon hub" end)
Sep(PTroll, "Player")
local CTr2 = Container(PTroll)
MakeButton(CTr2, "Kill all", "Mata todos os players", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local h = p.Character:FindFirstChild("Humanoid")
            if h then h.Health = 0 end
        end
    end
end)
MakeButton(CTr2, "Bring all", "Traz todos para voce", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local r = p.Character:FindFirstChild("HumanoidRootPart")
            if r and RootPart then
                r.CFrame = RootPart.CFrame + Vector3.new(math.random(-3,3),0,math.random(-3,3))
            end
        end
    end
end)
MakeButton(CTr2, "Flood jump", "Pula rapidamente varias vezes", function()
    task.spawn(function()
        for i=1,20 do
            if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
            task.wait(0.1)
        end
    end)
end)

-- MISC
local PMisc = NewPanel()
Sep(PMisc, "Geral")
local CMisc = Container(PMisc)
MakeToggle(CMisc, "Anti-AFK", "Previne kick por inatividade", function(on)
    if on then
        local vrs = Instance.new("VirtualUser")
        vrs.Parent = LP
        LP.Idled:Connect(function()
            vrs:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vrs:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
end)
MakeButton(CMisc, "Rejoin", "Reconecta ao servidor", function()
    TeleportService:Teleport(game.PlaceId, LP)
end)
Sep(PMisc, "Musica")
local CMus = Container(PMisc)
MakeInput(CMus, "ID da musica (ex: 1234567)...", function(id)
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://" .. id
    s.Volume = 0.5
    s.Parent = workspace
    s:Play()
end)
MakeButton(CMus, "Parar musica", "Para todos os sons", function()
    for _, s in ipairs(workspace:GetDescendants()) do
        if s:IsA("Sound") then s:Stop() end
    end
end)

-- ============================================================
-- SIDEBAR
-- ============================================================
SideTab("*", "Jogador",    PJogador)
SideTab("+", "Jogadores",  PJogadores)
SideTab("@", "Teleportes", PTeleport)
SideTab("#", "Avatar",     PAvatar)
SideTab("~", "Mundo",      PMundo)
SideTab("!", "Troll",      PTroll)
SideTab("-", "Misc",       PMisc)

TabButtons[1].btn.MouseButton1Click:Fire()

-- ============================================================
-- LOOPS
-- ============================================================
RunService.Heartbeat:Connect(function()
    if State.Fly and FlyBV and FlyBG and RootPart then
        local cam = workspace.CurrentCamera
        local d = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then d=d+cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then d=d-cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then d=d-cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then d=d+cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then d=d+Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then d=d-Vector3.new(0,1,0) end
        FlyBV.Velocity = d.Magnitude>0 and d.Unit*State.FlySpeed or Vector3.zero
        FlyBG.CFrame = cam.CFrame
    end
    if State.GodMode and Humanoid then Humanoid.Health = Humanoid.MaxHealth end
    if State.AntiVoid and RootPart and RootPart.Position.Y < -100 then
        RootPart.CFrame = CFrame.new(0,10,0)
    end
end)

RunService.Stepped:Connect(function()
    if State.Noclip and Character then
        for _, p in ipairs(Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if State.InfJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local espT = 0
RunService.Heartbeat:Connect(function(dt)
    if not State.ESP then return end
    espT = espT + dt
    if espT < 1 then return end
    espT = 0
    for _, o in pairs(ESPObjects) do if o and o.Parent then o:Destroy() end end
    ESPObjects = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LP then continue end
        local c = p.Character
        if not c then continue end
        local r = c:FindFirstChild("HumanoidRootPart")
        if not r then continue end
        local box = Instance.new("SelectionBox")
        box.Adornee = c
        box.Color3 = C.AccentLt
        box.LineThickness = 0.04
        box.SurfaceTransparency = 0.9
        box.Parent = workspace
        local bb = Instance.new("BillboardGui")
        bb.Adornee = r
        bb.Size = UDim2.new(0,110,0,24)
        bb.StudsOffset = Vector3.new(0,3.2,0)
        bb.AlwaysOnTop = true
        bb.Parent = workspace
        local nl = Instance.new("TextLabel")
        nl.Size = UDim2.new(1,0,1,0)
        nl.BackgroundTransparency = 1
        nl.Text = p.Name
        nl.TextColor3 = C.Text
        nl.Font = Enum.Font.GothamBold
        nl.TextSize = 12
        nl.TextStrokeTransparency = 0.3
        nl.Parent = bb
        table.insert(ESPObjects, box)
        table.insert(ESPObjects, bb)
    end
end)

task.spawn(function()
    while true do
        task.wait(1.2)
        if State.SpamMsg then
            pcall(function()
                game:GetService("ReplicatedStorage")
                    .DefaultChatSystemChatEvents
                    .SayMessageRequest:FireServer(State.SpamText, "All")
            end)
        end
    end
end)

print("[LyonHub] Carregado v1.0")
