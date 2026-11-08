-- LYON HUB | Brookhaven | Custom UI | Delta Executor
-- UI propria, sem dependencias externas

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Character = LP.Character or LP.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

LP.CharacterAdded:Connect(function(c)
    Character = c
    RootPart = c:WaitForChild("HumanoidRootPart")
    Humanoid = c:WaitForChild("Humanoid")
end)

-- ============================================================
-- PALETA CINZA
-- ============================================================
local C = {
    BG        = Color3.fromRGB(20, 20, 23),
    Header    = Color3.fromRGB(14, 14, 16),
    Sidebar   = Color3.fromRGB(16, 16, 19),
    Panel     = Color3.fromRGB(26, 26, 30),
    Item      = Color3.fromRGB(32, 32, 37),
    Accent    = Color3.fromRGB(150, 150, 165),
    AccentLt  = Color3.fromRGB(190, 190, 205),
    AccentDk  = Color3.fromRGB(50, 50, 58),
    Text      = Color3.fromRGB(215, 215, 220),
    TextDim   = Color3.fromRGB(110, 110, 120),
    Border    = Color3.fromRGB(45, 45, 52),
    Sep       = Color3.fromRGB(38, 38, 44),
    TGL_ON    = Color3.fromRGB(155, 155, 170),
    TGL_OFF   = Color3.fromRGB(48, 48, 55),
    White     = Color3.fromRGB(255, 255, 255),
    Green     = Color3.fromRGB(80, 200, 100),
    Red       = Color3.fromRGB(200, 70, 70),
}

-- ============================================================
-- LOADING SCREEN
-- ============================================================
local LoadGui = Instance.new("ScreenGui")
LoadGui.Name = "LyonLoad"
LoadGui.ResetOnSpawn = false
LoadGui.DisplayOrder = 9999
pcall(function() LoadGui.Parent = game.CoreGui end)
if not LoadGui.Parent then LoadGui.Parent = LP.PlayerGui end

local LoadFrame = Instance.new("Frame")
LoadFrame.Size = UDim2.new(1,0,1,0)
LoadFrame.BackgroundColor3 = C.BG
LoadFrame.BorderSizePixel = 0
LoadFrame.Parent = LoadGui

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(1,0,0,40)
LoadTitle.Position = UDim2.new(0,0,0.5,-50)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "LYON HUB"
LoadTitle.TextColor3 = C.AccentLt
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.TextSize = 30
LoadTitle.Parent = LoadFrame

local LoadSub = Instance.new("TextLabel")
LoadSub.Size = UDim2.new(1,0,0,22)
LoadSub.Position = UDim2.new(0,0,0.5,10)
LoadSub.BackgroundTransparency = 1
LoadSub.Text = "Carregando 1."
LoadSub.TextColor3 = C.TextDim
LoadSub.Font = Enum.Font.Gotham
LoadSub.TextSize = 13
LoadSub.Parent = LoadFrame

local LoadVer = Instance.new("TextLabel")
LoadVer.Size = UDim2.new(1,0,0,18)
LoadVer.Position = UDim2.new(0,0,1,-26)
LoadVer.BackgroundTransparency = 1
LoadVer.Text = "v1.0 | Brookhaven RP"
LoadVer.TextColor3 = Color3.fromRGB(50,50,58)
LoadVer.Font = Enum.Font.Gotham
LoadVer.TextSize = 11
LoadVer.Parent = LoadFrame

local loadRunning = true
task.spawn(function()
    local dots = {"Carregando 1.","Carregando 1.. 2.","Carregando 1.. 2.. 3.","Carregando 1.. 2.. 3.. 4."}
    local i = 1
    while loadRunning do
        LoadSub.Text = dots[i]
        i = i % #dots + 1
        task.wait(0.5)
    end
end)
task.wait(2)
loadRunning = false
LoadGui:Destroy()

-- ============================================================
-- GUI ROOT
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LyonHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
pcall(function() ScreenGui.Parent = game.CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LP.PlayerGui end

local WIN_W, WIN_H = 680, 460
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,WIN_W,0,WIN_H)
Main.Position = UDim2.new(0.5,-WIN_W/2,0.5,-WIN_H/2)
Main.BackgroundColor3 = C.BG
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Main.Parent = ScreenGui
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,10)
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = C.Border
MainStroke.Thickness = 1.5
MainStroke.Parent = Main

-- ============================================================
-- HEADER
-- ============================================================
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,46)
Header.BackgroundColor3 = C.Header
Header.BorderSizePixel = 0
Header.ZIndex = 5
Header.Parent = Main
Instance.new("UICorner",Header).CornerRadius = UDim.new(0,10)
local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1,0,0,10)
HeaderFix.Position = UDim2.new(0,0,1,-10)
HeaderFix.BackgroundColor3 = C.Header
HeaderFix.BorderSizePixel = 0
HeaderFix.ZIndex = 5
HeaderFix.Parent = Header
local HeaderStroke = Instance.new("UIStroke")
HeaderStroke.Color = C.Border
HeaderStroke.Thickness = 1
HeaderStroke.Parent = Header

-- Logo
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0,180,1,0)
Logo.Position = UDim2.new(0,14,0,0)
Logo.BackgroundTransparency = 1
Logo.Text = "LYON HUB"
Logo.TextColor3 = C.AccentLt
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 15
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.ZIndex = 6
Logo.Parent = Header

local SubVer = Instance.new("TextLabel")
SubVer.Size = UDim2.new(0,60,1,0)
SubVer.Position = UDim2.new(0,112,0,0)
SubVer.BackgroundTransparency = 1
SubVer.Text = "v1.0"
SubVer.TextColor3 = C.TextDim
SubVer.Font = Enum.Font.Gotham
SubVer.TextSize = 10
SubVer.TextXAlignment = Enum.TextXAlignment.Left
SubVer.ZIndex = 6
SubVer.Parent = Header

-- Status dot
local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.new(0,7,0,7)
StatusDot.Position = UDim2.new(0,160,0.5,-3.5)
StatusDot.BackgroundColor3 = C.Green
StatusDot.BorderSizePixel = 0
StatusDot.ZIndex = 6
StatusDot.Parent = Header
Instance.new("UICorner",StatusDot).CornerRadius = UDim.new(1,0)

-- Header buttons
local function HBtn(txt, ox, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0,26,0,26)
    b.Position = UDim2.new(1,ox,0.5,-13)
    b.BackgroundTransparency = 1
    b.Text = txt
    b.TextColor3 = C.TextDim
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.ZIndex = 7
    b.Parent = Header
    b.MouseButton1Click:Connect(cb)
    b.MouseEnter:Connect(function() b.TextColor3 = C.Text end)
    b.MouseLeave:Connect(function() b.TextColor3 = C.TextDim end)
    return b
end

-- Bolinha flutuante
local Minimized = false
local Ball = Instance.new("Frame")
Ball.Size = UDim2.new(0,44,0,44)
Ball.Position = UDim2.new(0,20,0.5,-22)
Ball.BackgroundColor3 = C.AccentDk
Ball.BorderSizePixel = 0
Ball.ZIndex = 999
Ball.Visible = false
Ball.Active = true
Ball.Parent = ScreenGui
Instance.new("UICorner",Ball).CornerRadius = UDim.new(1,0)
local BallStroke = Instance.new("UIStroke")
BallStroke.Color = C.Accent
BallStroke.Thickness = 1.5
BallStroke.Parent = Ball

local BallImg = Instance.new("ImageLabel")
BallImg.Size = UDim2.new(1,-6,1,-6)
BallImg.Position = UDim2.new(0,3,0,3)
BallImg.BackgroundTransparency = 1
BallImg.Image = "rbxassetid://0" -- TROCA PELO SEU ID
BallImg.ZIndex = 1000
BallImg.Parent = Ball

local BallTxt = Instance.new("TextLabel")
BallTxt.Size = UDim2.new(1,0,1,0)
BallTxt.BackgroundTransparency = 1
BallTxt.Text = "L"
BallTxt.TextColor3 = C.White
BallTxt.Font = Enum.Font.GothamBold
BallTxt.TextSize = 18
BallTxt.ZIndex = 1001
BallTxt.Parent = Ball

-- Arrastar bolinha
local dragBall,dragStart,ballStart,didDrag = false,nil,nil,false
Ball.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        dragBall=true didDrag=false dragStart=input.Position ballStart=Ball.Position
    end
end)
Ball.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        if not didDrag then
            Minimized=false Ball.Visible=false Main.Visible=true Main.Size=UDim2.new(0,0,0,0)
            TweenService:Create(Main,TweenInfo.new(0.25,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,WIN_W,0,WIN_H)}):Play()
        end
        dragBall=false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragBall and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
        local delta=input.Position-dragStart
        if delta.Magnitude>4 then didDrag=true end
        if didDrag then Ball.Position=UDim2.new(ballStart.X.Scale,ballStart.X.Offset+delta.X,ballStart.Y.Scale,ballStart.Y.Offset+delta.Y) end
    end
end)

HBtn("-",-58,function()
    Minimized=true
    TweenService:Create(Main,TweenInfo.new(0.2),{Size=UDim2.new(0,0,0,0)}):Play()
    task.wait(0.22) Main.Visible=false Ball.Visible=true
end)
HBtn("x",-30,function() ScreenGui:Destroy() end)

-- ============================================================
-- SIDEBAR
-- ============================================================
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0,160,1,-46)
Sidebar.Position = UDim2.new(0,0,0,46)
Sidebar.BackgroundColor3 = C.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 2
Sidebar.ScrollBarImageColor3 = C.Accent
Sidebar.CanvasSize = UDim2.new(0,0,0,0)
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
Sidebar.ZIndex = 3
Sidebar.Parent = Main

local SideList = Instance.new("UIListLayout")
SideList.Padding = UDim.new(0,2)
SideList.Parent = Sidebar

local SidePad = Instance.new("UIPadding")
SidePad.PaddingTop = UDim.new(0,8)
SidePad.PaddingLeft = UDim.new(0,6)
SidePad.PaddingRight = UDim.new(0,6)
SidePad.Parent = Sidebar

local SideDiv = Instance.new("Frame")
SideDiv.Size = UDim2.new(0,1,1,-46)
SideDiv.Position = UDim2.new(0,160,0,46)
SideDiv.BackgroundColor3 = C.Border
SideDiv.BorderSizePixel = 0
SideDiv.ZIndex = 3
SideDiv.Parent = Main

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-162,1,-46)
Content.Position = UDim2.new(0,162,0,46)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ClipsDescendants = true
Content.ZIndex = 2
Content.Parent = Main

-- ============================================================
-- LIB PROPRIA
-- ============================================================
local TabButtons = {}
local TabPanels = {}
local ActiveTab = nil

local function NewPanel()
    local sf = Instance.new("ScrollingFrame")
    sf.Size = UDim2.new(1,0,1,0)
    sf.BackgroundTransparency = 1
    sf.BorderSizePixel = 0
    sf.ScrollBarThickness = 3
    sf.ScrollBarImageColor3 = C.Accent
    sf.CanvasSize = UDim2.new(0,0,0,0)
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sf.Visible = false
    sf.ZIndex = 3
    sf.Parent = Content
    local ul = Instance.new("UIListLayout")
    ul.Padding = UDim.new(0,6)
    ul.Parent = sf
    local up = Instance.new("UIPadding")
    up.PaddingTop = UDim.new(0,10)
    up.PaddingLeft = UDim.new(0,10)
    up.PaddingRight = UDim.new(0,10)
    up.PaddingBottom = UDim.new(0,10)
    up.Parent = sf
    return sf
end

local function AddTab(icon, label, panel)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1,0,0,36)
    Btn.BackgroundColor3 = C.Sidebar
    Btn.BorderSizePixel = 0
    Btn.Text = ""
    Btn.ZIndex = 4
    Btn.Parent = Sidebar
    Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,6)

    local IL = Instance.new("TextLabel")
    IL.Size = UDim2.new(0,22,1,0)
    IL.Position = UDim2.new(0,8,0,0)
    IL.BackgroundTransparency = 1
    IL.Text = icon
    IL.TextColor3 = C.TextDim
    IL.TextSize = 14
    IL.ZIndex = 5
    IL.Parent = Btn

    local NL = Instance.new("TextLabel")
    NL.Size = UDim2.new(1,-38,1,0)
    NL.Position = UDim2.new(0,32,0,0)
    NL.BackgroundTransparency = 1
    NL.Text = label
    NL.TextColor3 = C.TextDim
    NL.Font = Enum.Font.Gotham
    NL.TextSize = 12
    NL.TextXAlignment = Enum.TextXAlignment.Left
    NL.ZIndex = 5
    NL.Parent = Btn

    local AL = Instance.new("TextLabel")
    AL.Size = UDim2.new(0,14,1,0)
    AL.Position = UDim2.new(1,-18,0,0)
    AL.BackgroundTransparency = 1
    AL.Text = ">"
    AL.TextColor3 = C.TextDim
    AL.Font = Enum.Font.GothamBold
    AL.TextSize = 12
    AL.ZIndex = 5
    AL.Parent = Btn

    local AB = Instance.new("Frame")
    AB.Size = UDim2.new(0,3,0.6,0)
    AB.Position = UDim2.new(0,0,0.2,0)
    AB.BackgroundColor3 = C.AccentLt
    AB.BorderSizePixel = 0
    AB.Visible = false
    AB.ZIndex = 6
    AB.Parent = Btn
    Instance.new("UICorner",AB).CornerRadius = UDim.new(0,2)

    table.insert(TabButtons,{btn=Btn,bar=AB,name=NL,icon=IL,arrow=AL})
    table.insert(TabPanels,panel)

    Btn.MouseButton1Click:Connect(function()
        for _,p in ipairs(TabPanels) do p.Visible=false end
        for _,t in ipairs(TabButtons) do
            t.btn.BackgroundColor3=C.Sidebar
            t.bar.Visible=false
            t.name.TextColor3=C.TextDim
            t.icon.TextColor3=C.TextDim
            t.arrow.TextColor3=C.TextDim
        end
        panel.Visible=true
        Btn.BackgroundColor3=C.AccentDk
        AB.Visible=true
        NL.TextColor3=C.Text
        IL.TextColor3=C.AccentLt
        AL.TextColor3=C.AccentLt
        ActiveTab=panel
    end)

    return Btn
end

-- Separador de secao
local function AddSep(parent, text)
    local F = Instance.new("Frame")
    F.Size = UDim2.new(1,0,0,22)
    F.BackgroundColor3 = C.Sep
    F.BorderSizePixel = 0
    F.ZIndex = 4
    F.Parent = parent
    Instance.new("UICorner",F).CornerRadius = UDim.new(0,5)
    local BL = Instance.new("Frame")
    BL.Size = UDim2.new(0,3,0.6,0)
    BL.Position = UDim2.new(0,0,0.2,0)
    BL.BackgroundColor3 = C.Accent
    BL.BorderSizePixel = 0
    BL.ZIndex = 5
    BL.Parent = F
    Instance.new("UICorner",BL).CornerRadius = UDim.new(0,2)
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(1,-16,1,0)
    L.Position = UDim2.new(0,10,0,0)
    L.BackgroundTransparency = 1
    L.Text = text:upper()
    L.TextColor3 = C.Accent
    L.Font = Enum.Font.GothamBold
    L.TextSize = 10
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.ZIndex = 5
    L.Parent = F
end

-- Container agrupador
local function AddContainer(parent)
    local F = Instance.new("Frame")
    F.Size = UDim2.new(1,0,0,0)
    F.AutomaticSize = Enum.AutomaticSize.Y
    F.BackgroundColor3 = C.Panel
    F.BorderSizePixel = 0
    F.ZIndex = 4
    F.Parent = parent
    Instance.new("UICorner",F).CornerRadius = UDim.new(0,8)
    local S = Instance.new("UIStroke")
    S.Color = C.Border S.Thickness = 1 S.Parent = F
    local ul = Instance.new("UIListLayout")
    ul.Padding = UDim.new(0,0)
    ul.Parent = F
    return F
end

-- Linha divisoria entre items
local function AddLine(parent)
    local L = Instance.new("Frame")
    L.Size = UDim2.new(1,-16,0,1)
    L.Position = UDim2.new(0,8,1,-1)
    L.BackgroundColor3 = C.Sep
    L.BorderSizePixel = 0
    L.ZIndex = 6
    L.Parent = parent
end

-- Toggle
local function AddToggle(parent, label, desc, cb)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1,0,0,46)
    Row.BackgroundTransparency = 1
    Row.BorderSizePixel = 0
    Row.ZIndex = 5
    Row.Parent = parent
    AddLine(Row)

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(0.6,0,0,20)
    Lbl.Position = UDim2.new(0,12,0,6)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label
    Lbl.TextColor3 = C.Text
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextSize = 12
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 6
    Lbl.Parent = Row

    if desc and desc~="" then
        local Desc = Instance.new("TextLabel")
        Desc.Size = UDim2.new(0.65,0,0,14)
        Desc.Position = UDim2.new(0,12,0,26)
        Desc.BackgroundTransparency = 1
        Desc.Text = desc
        Desc.TextColor3 = C.TextDim
        Desc.Font = Enum.Font.Gotham
        Desc.TextSize = 10
        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.ZIndex = 6
        Desc.Parent = Row
    end

    local enabled = false
    local Pill = Instance.new("Frame")
    Pill.Size = UDim2.new(0,40,0,20)
    Pill.Position = UDim2.new(1,-50,0.5,-10)
    Pill.BackgroundColor3 = C.TGL_OFF
    Pill.BorderSizePixel = 0
    Pill.ZIndex = 6
    Pill.Parent = Row
    Instance.new("UICorner",Pill).CornerRadius = UDim.new(1,0)

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0,14,0,14)
    Knob.Position = UDim2.new(0,3,0.5,-7)
    Knob.BackgroundColor3 = C.White
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 7
    Knob.Parent = Pill
    Instance.new("UICorner",Knob).CornerRadius = UDim.new(1,0)

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1,0,1,0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.ZIndex = 8
    Btn.Parent = Row

    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        local ti = TweenInfo.new(0.18,Enum.EasingStyle.Quad)
        if enabled then
            TweenService:Create(Pill,ti,{BackgroundColor3=C.TGL_ON}):Play()
            TweenService:Create(Knob,ti,{Position=UDim2.new(0,23,0.5,-7)}):Play()
        else
            TweenService:Create(Pill,ti,{BackgroundColor3=C.TGL_OFF}):Play()
            TweenService:Create(Knob,ti,{Position=UDim2.new(0,3,0.5,-7)}):Play()
        end
        cb(enabled)
    end)
end

-- Button
local function AddButton(parent, label, desc, cb)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1,0,0,46)
    Row.BackgroundTransparency = 1
    Row.BorderSizePixel = 0
    Row.ZIndex = 5
    Row.Parent = parent
    AddLine(Row)

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(0.78,0,0,20)
    Lbl.Position = UDim2.new(0,12,0,6)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label
    Lbl.TextColor3 = C.Text
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextSize = 12
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 6
    Lbl.Parent = Row

    if desc and desc~="" then
        local Desc = Instance.new("TextLabel")
        Desc.Size = UDim2.new(0.78,0,0,14)
        Desc.Position = UDim2.new(0,12,0,26)
        Desc.BackgroundTransparency = 1
        Desc.Text = desc
        Desc.TextColor3 = C.TextDim
        Desc.Font = Enum.Font.Gotham
        Desc.TextSize = 10
        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.ZIndex = 6
        Desc.Parent = Row
    end

    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.new(0,16,1,0)
    Arrow.Position = UDim2.new(1,-22,0,0)
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
        task.delay(0.14,function() Row.BackgroundTransparency=1 end)
        cb()
    end)
end

-- Slider
local function AddSlider(parent, label, min, max, default, cb)
    local value = default
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1,0,0,52)
    Row.BackgroundTransparency = 1
    Row.BorderSizePixel = 0
    Row.ZIndex = 5
    Row.Parent = parent
    AddLine(Row)

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1,-12,0,18)
    Lbl.Position = UDim2.new(0,12,0,6)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label..":  "..tostring(default)
    Lbl.TextColor3 = C.Text
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextSize = 11
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 6
    Lbl.Parent = Row

    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1,-24,0,5)
    Track.Position = UDim2.new(0,12,0,34)
    Track.BackgroundColor3 = C.AccentDk
    Track.BorderSizePixel = 0
    Track.ZIndex = 6
    Track.Parent = Row
    Instance.new("UICorner",Track).CornerRadius = UDim.new(1,0)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
    Fill.BackgroundColor3 = C.AccentLt
    Fill.BorderSizePixel = 0
    Fill.ZIndex = 7
    Fill.Parent = Track
    Instance.new("UICorner",Fill).CornerRadius = UDim.new(1,0)

    local Knob = Instance.new("TextButton")
    Knob.Size = UDim2.new(0,12,0,12)
    Knob.Position = UDim2.new((default-min)/(max-min),-6,0.5,-6)
    Knob.BackgroundColor3 = C.White
    Knob.Text = ""
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 8
    Knob.Parent = Track
    Instance.new("UICorner",Knob).CornerRadius = UDim.new(1,0)

    local drag = false
    Knob.MouseButton1Down:Connect(function() drag=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
            local p=math.clamp((i.Position.X-Track.AbsolutePosition.X)/Track.AbsoluteSize.X,0,1)
            value=math.floor(min+(max-min)*p)
            Fill.Size=UDim2.new(p,0,1,0)
            Knob.Position=UDim2.new(p,-6,0.5,-6)
            Lbl.Text=label..":  "..tostring(value)
            cb(value)
        end
    end)
end

-- Input
local function AddInput(parent, placeholder, cb)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1,0,0,40)
    Row.BackgroundTransparency = 1
    Row.ZIndex = 5
    Row.Parent = parent
    AddLine(Row)

    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(0.7,0,1,-10)
    Box.Position = UDim2.new(0,12,0,5)
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
    Instance.new("UICorner",Box).CornerRadius = UDim.new(0,5)

    local OkBtn = Instance.new("TextButton")
    OkBtn.Size = UDim2.new(0.24,0,1,-10)
    OkBtn.Position = UDim2.new(0.74,0,0,5)
    OkBtn.BackgroundColor3 = C.Accent
    OkBtn.Text = "OK"
    OkBtn.TextColor3 = C.White
    OkBtn.Font = Enum.Font.GothamBold
    OkBtn.TextSize = 11
    OkBtn.BorderSizePixel = 0
    OkBtn.ZIndex = 6
    OkBtn.Parent = Row
    Instance.new("UICorner",OkBtn).CornerRadius = UDim.new(0,5)
    OkBtn.MouseButton1Click:Connect(function() cb(Box.Text) end)
    return Box
end

-- Label
local function AddLabel(parent, text)
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(1,0,0,30)
    L.BackgroundTransparency = 1
    L.Text = text
    L.TextColor3 = C.TextDim
    L.Font = Enum.Font.Gotham
    L.TextSize = 11
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.ZIndex = 5
    L.Parent = parent
    return L
end

local function sendChat(msg)
    pcall(function()
        if TextChatService.ChatVersion==Enum.ChatVersion.TextChatService then
            TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
        else
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg,"All")
        end
    end)
end

-- ============================================================
-- PANELS + FEATURES
-- ============================================================

-- INICIO
local PInicio = NewPanel()
AddSep(PInicio,"Super Poderes")
local CSuper = AddContainer(PInicio)
AddSlider(CSuper,"Velocidade",16,300,16,function(v) if Humanoid then Humanoid.WalkSpeed=v end end)
AddSlider(CSuper,"Pulo",50,300,50,function(v) if Humanoid then Humanoid.JumpPower=v end end)
AddSlider(CSuper,"Gravidade",0,400,196,function(v) workspace.Gravity=v end)
AddButton(CSuper,"Resetar","Volta ao normal",function()
    if Humanoid then Humanoid.WalkSpeed=16 Humanoid.JumpPower=50 end
    workspace.Gravity=196.2
end)

AddSep(PInicio,"RGB")
local CRGB = AddContainer(PInicio)
local isHairRGB,isNameRGB,isBioRGB,isBodyRGB=false,false,false,false
local hairColors={Color3.fromRGB(255,0,0),Color3.fromRGB(0,255,0),Color3.fromRGB(0,0,255),Color3.fromRGB(255,255,0),Color3.fromRGB(255,0,255),Color3.fromRGB(0,255,255)}
local bodyColors={"Bright red","Lime green","Bright blue","Bright yellow","Bright cyan","Hot pink","Royal purple"}
AddToggle(CRGB,"Cabelo RGB","",function(v) isHairRGB=v end)
AddToggle(CRGB,"Nome RGB","",function(v) isNameRGB=v end)
AddToggle(CRGB,"Bio RGB","",function(v) isBioRGB=v end)
AddToggle(CRGB,"Personagem RGB","",function(v) isBodyRGB=v end)
task.spawn(function()
    local iH,iN,iB,iC=1,1,1,1
    while true do
        task.wait(0.1)
        pcall(function()
            local RE=ReplicatedStorage:FindFirstChild("RE") if not RE then return end
            if isHairRGB then RE:FindFirstChild("1Max1y"):FireServer("ChangeHairColor2",hairColors[iH]) iH=iH%#hairColors+1 end
            if isNameRGB then RE:FindFirstChild("1RPNam1eColo1r"):FireServer("PickingRPNameColor",hairColors[iN]) iN=iN%#hairColors+1 end
            if isBioRGB then RE:FindFirstChild("1RPNam1eColo1r"):FireServer("PickingRPBioColor",hairColors[iB]) iB=iB%#hairColors+1 end
            if isBodyRGB then
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ChangeBodyColor"):FireServer(bodyColors[iC])
                iC=iC%#bodyColors+1
            end
        end)
    end
end)

AddSep(PInicio,"Repeticao de Nomes")
local CNames = AddContainer(PInicio)
local name1,name2,name3,repeatNames="","","",false
AddInput(CNames,"Nome 1...",function(v) name1=v end)
AddInput(CNames,"Nome 2...",function(v) name2=v end)
AddInput(CNames,"Nome 3...",function(v) name3=v end)
AddToggle(CNames,"Repetir Nomes","",function(v)
    repeatNames=v
    if v then task.spawn(function()
        while repeatNames do pcall(function()
            local r=ReplicatedStorage.RE:FindFirstChild("1RPNam1eTex1t")
            if r then r:FireServer("RolePlayName",name1) task.wait(1) r:FireServer("RolePlayName",name2) task.wait(1) r:FireServer("RolePlayName",name3) task.wait(1) end
        end) end
    end) end
end)

-- PROTECAO
local PProtecao = NewPanel()
AddSep(PProtecao,"Protecoes")
local CProt = AddContainer(PProtecao)
local antiToolSit,antiCarSit,dripsActive=false,false,false
local function applyCollision(obj)
    if not obj:IsA("BasePart") then return end
    local n=obj.Name:lower()
    if n:find("wheel") then return end
    local isCar=false local p=obj
    while p do if p.Name:lower():find("car") then isCar=true break end p=p.Parent end
    if isCar then obj.CanCollide=not antiCarSit end
end
local function handleProt()
    if not dripsActive then dripsActive=true workspace.DescendantAdded:Connect(applyCollision) end
    for _,o in ipairs(workspace:GetDescendants()) do applyCollision(o) end
    local h=Character and Character:FindFirstChildOfClass("Humanoid")
    if h then h:SetStateEnabled(Enum.HumanoidStateType.Seated,not(antiToolSit or antiCarSit)) end
end
AddToggle(CProt,"Anti Tool","Nao senta em tools",function(v) antiToolSit=v handleProt() end)
AddToggle(CProt,"Anti Car","Nao entra em carros",function(v) antiCarSit=v handleProt() end)
AddToggle(CProt,"God Mode","HP sempre no maximo",function(v)
    task.spawn(function() while v do if Humanoid then Humanoid.Health=Humanoid.MaxHealth end task.wait(0.1) end end)
end)
AddToggle(CProt,"Anti Void","Teleporta de volta se cair",function(v)
    task.spawn(function() while v do if RootPart and RootPart.Position.Y<-100 then RootPart.CFrame=CFrame.new(0,10,0) end task.wait(0.1) end end)
end)
AddToggle(CProt,"Anti AFK","Previne kick por inatividade",function(v)
    if v then
        local vrs=Instance.new("VirtualUser") vrs.Parent=LP
        LP.Idled:Connect(function() vrs:Button2Down(Vector2.new(0,0),Camera.CFrame) task.wait(1) vrs:Button2Up(Vector2.new(0,0),Camera.CFrame) end)
    end
end)
AddButton(CProt,"Anti Lag","Remove items pesados do mapa",function()
    local items={"Burger Tray","Bomb","Laptop","Paper Bag","Chips","Ice Cream","Taser","Basketball","FireX","Ladder","Ghost Meter","Clipboard","Stretcher","Glock","Electric Guitar","Guitar","Book","Box","Frap Strawberry","Bank Keycard","White Keycard","Mop","Iphone","Ipad"}
    local lk={} for _,n in ipairs(items) do lk[n]=true end
    for _,o in ipairs(workspace:GetDescendants()) do if lk[o.Name] then pcall(function() o:Destroy() end) end end
end)

-- PERSONAGEM
local PPersonagem = NewPanel()
AddSep(PPersonagem,"Movimento")
local CMove = AddContainer(PPersonagem)
local flyActive,noclipActive,infJump=false,false,false
AddToggle(CMove,"Fly","Voa com WASD + Espaco",function(v)
    flyActive=v
    if v then
        local bv=Instance.new("BodyVelocity") bv.MaxForce=Vector3.new(1e5,1e5,1e5) bv.Velocity=Vector3.zero bv.Parent=RootPart
        local bg=Instance.new("BodyGyro") bg.MaxTorque=Vector3.new(1e5,1e5,1e5) bg.P=1e4 bg.Parent=RootPart
        task.spawn(function()
            while flyActive do
                local d=Vector3.zero
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then d=d+Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then d=d-Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then d=d-Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then d=d+Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then d=d+Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then d=d-Vector3.new(0,1,0) end
                bv.Velocity=d.Magnitude>0 and d.Unit*80 or Vector3.zero
                bg.CFrame=Camera.CFrame
                task.wait()
            end
            bv:Destroy() bg:Destroy()
        end)
    end
end)
AddSlider(CMove,"Velocidade de Voo",10,300,80,function(v) end)
AddToggle(CMove,"Noclip","Atravessa paredes",function(v)
    noclipActive=v
    task.spawn(function()
        while noclipActive do
            if Character then for _,p in ipairs(Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end
            task.wait()
        end
    end)
end)
AddToggle(CMove,"Infinite Jump","Pula infinitamente",function(v) infJump=v end)
UserInputService.JumpRequest:Connect(function() if infJump and Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end end)

AddSep(PPersonagem,"Avatar")
local CAvatar = AddContainer(PPersonagem)
AddToggle(CAvatar,"Invisible","Torna personagem transparente",function(v)
    if Character then for _,p in ipairs(Character:GetDescendants()) do
        if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then p.Transparency=v and 1 or 0 end
    end end
end)
AddToggle(CAvatar,"RGB Personagem","Muda cor em loop",function(v)
    if v then task.spawn(function()
        local t=0
        while v do t=t+0.05 local col=Color3.fromHSV(t%1,1,1)
            if Character then for _,p in ipairs(Character:GetDescendants()) do if p:IsA("BasePart") then p.Color=col end end end
            task.wait(0.05)
        end
    end) end
end)
AddButton(CAvatar,"Gigante (5x)","",function()
    if Character then local h=Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=5 h.BodyHeightScale.Value=5 h.BodyWidthScale.Value=5 h.HeadScale.Value=5 end end
end)
AddButton(CAvatar,"Normal (1x)","",function()
    if Character then local h=Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=1 h.BodyHeightScale.Value=1 h.BodyWidthScale.Value=1 h.HeadScale.Value=1 end end
end)
AddButton(CAvatar,"Minusculo (0.3x)","",function()
    if Character then local h=Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=.3 h.BodyHeightScale.Value=.3 h.BodyWidthScale.Value=.3 h.HeadScale.Value=.3 end end
end)
AddButton(CAvatar,"Resetar Personagem","",function() if Humanoid then Humanoid.Health=0 end end)

AddSep(PPersonagem,"Roupas")
local CRoupas = AddContainer(PPersonagem)
local shirtID,pantsID="",""
AddInput(CRoupas,"ID Camisa...",function(v) shirtID=v end)
AddInput(CRoupas,"ID Calca...",function(v) pantsID=v end)
AddButton(CRoupas,"Aplicar Roupa","",function()
    if Character then
        local sh=Character:FindFirstChildOfClass("Shirt") or Instance.new("Shirt",Character)
        local pa=Character:FindFirstChildOfClass("Pants") or Instance.new("Pants",Character)
        if shirtID~="" then sh.ShirtTemplate="rbxassetid://"..shirtID end
        if pantsID~="" then pa.PantsTemplate="rbxassetid://"..pantsID end
    end
end)

-- JOGADORES
local PJogadores = NewPanel()
AddSep(PJogadores,"ESP")
local CESP = AddContainer(PJogadores)
local espLine,espName,espDist,espHP=false,false,false,false
local ESPDrawings={}
local function clearESP() for _,d in pairs(ESPDrawings) do if d and d.Remove then d:Remove() end end ESPDrawings={} end
RunService.RenderStepped:Connect(function()
    clearESP()
    if not (espLine or espName or espDist or espHP) then return end
    local center=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y)
    for _,p in ipairs(Players:GetPlayers()) do
        if p==LP or not p.Character then continue end
        local head=p.Character:FindFirstChild("Head") if not head then continue end
        local pos,on=Camera:WorldToViewportPoint(head.Position) if not on then continue end
        local vp=Vector2.new(pos.X,pos.Y)
        if espLine then local l=Drawing.new("Line") l.From=center l.To=vp l.Color=Color3.new(1,1,1) l.Thickness=1.5 l.Transparency=1 l.Visible=true table.insert(ESPDrawings,l) end
        if espName then local t=Drawing.new("Text") t.Text=p.DisplayName t.Position=Vector2.new(pos.X,pos.Y-22) t.Color=Color3.new(1,1,1) t.Center=true t.Size=16 t.Outline=true t.Visible=true table.insert(ESPDrawings,t) end
        if espDist then local d=math.floor((Camera.CFrame.Position-head.Position).Magnitude) local dt=Drawing.new("Text") dt.Text=d.."m" dt.Position=Vector2.new(pos.X,pos.Y+22) dt.Color=Color3.fromRGB(0,255,255) dt.Center=true dt.Size=14 dt.Outline=true dt.Visible=true table.insert(ESPDrawings,dt) end
        if espHP then
            local hum=p.Character:FindFirstChild("Humanoid")
            local hp=hum and (hum.Health/hum.MaxHealth) or 1
            local hb=Drawing.new("Square") hb.Size=Vector2.new(4,32) hb.Position=Vector2.new(pos.X-28,pos.Y-16) hb.Color=Color3.fromRGB(math.floor((1-hp)*255),math.floor(hp*255),0) hb.Filled=true hb.Transparency=1 hb.Visible=true table.insert(ESPDrawings,hb)
        end
    end
end)
AddToggle(CESP,"Linhas ESP","",function(v) espLine=v end)
AddToggle(CESP,"Nomes ESP","",function(v) espName=v end)
AddToggle(CESP,"Distancia ESP","",function(v) espDist=v end)
AddToggle(CESP,"Vida ESP","",function(v) espHP=v end)

AddSep(PJogadores,"Acoes")
local CJAc = AddContainer(PJogadores)
AddButton(CJAc,"Listar Players","Console do executor",function()
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP then print("► "..p.Name) end end
end)
local tpName=""
AddInput(CJAc,"Teleport para player...",function(v) tpName=v end)
AddButton(CJAc,"Ir","",function()
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Name:lower():find(tpName:lower()) then
            local c=p.Character if c then local r=c:FindFirstChild("HumanoidRootPart") if r and RootPart then RootPart.CFrame=r.CFrame+Vector3.new(2,0,0) end end
        end
    end
end)
local hsName=""
AddInput(CJAc,"Head Sit (nome)...",function(v) hsName=v end)
AddButton(CJAc,"Sentar na Cabeca","",function()
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Name:lower():find(hsName:lower()) then
            local c=p.Character if c then
                local head=c:FindFirstChild("Head")
                if head and RootPart then
                    RootPart.CFrame=CFrame.new(head.Position+Vector3.new(0,2,0))
                    local w=Instance.new("WeldConstraint") w.Part0=RootPart w.Part1=head w.Parent=RootPart
                end
            end
        end
    end
end)

AddSep(PJogadores,"Visualizar")
local CJVis = AddContainer(PJogadores)
local viewName=""
AddInput(CJVis,"Ver jogador (nome)...",function(v) viewName=v end)
AddToggle(CJVis,"Visualizar Jogador","",function(v)
    task.spawn(function()
        while v do
            for _,p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Name:lower():find(viewName:lower()) and p.Character then
                    local hum=p.Character:FindFirstChild("Humanoid")
                    if hum then Camera.CameraSubject=hum end
                end
            end
            task.wait(0.5)
        end
        if Character then local hum=Character:FindFirstChild("Humanoid") if hum then Camera.CameraSubject=hum end end
    end)
end)

-- TROLL
local PTroll = NewPanel()
AddSep(PTroll,"Chat")
local CTChat = AddContainer(PTroll)
local spamActive,spamText=false,"lyon hub"
AddInput(CTChat,"Texto do spam...",function(v) spamText=v~="" and v or "lyon hub" end)
AddToggle(CTChat,"Spam Chat","",function(v)
    spamActive=v
    if v then task.spawn(function() while spamActive do sendChat(spamText) task.wait(1.2) end end) end
end)

AddSep(PTroll,"Mensagens Prontas")
local CTMsg = AddContainer(PTroll)
for _,msg in ipairs({"c00lkidd invaded","Tubers93 invaded","Server Hacked","Vou trava geral","Lyon Hub e o melhor"}) do
    AddButton(CTMsg,msg,"",function() sendChat(msg) end)
end

AddSep(PTroll,"Players")
local CTPlay = AddContainer(PTroll)
AddButton(CTPlay,"Kill All","",function()
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then local h=p.Character:FindFirstChild("Humanoid") if h then h.Health=0 end end end
end)
AddButton(CTPlay,"Bring All","",function()
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then
        local r=p.Character:FindFirstChild("HumanoidRootPart")
        if r and RootPart then r.CFrame=RootPart.CFrame+Vector3.new(math.random(-3,3),0,math.random(-3,3)) end
    end end
end)
AddButton(CTPlay,"Flood Jump","",function()
    task.spawn(function() for i=1,20 do if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end task.wait(0.1) end end)
end)

-- LAG
local PLag = NewPanel()
AddSep(PLag,"Spam de Jatos")
local CLag = AddContainer(PLag)
local jetActive,jetOrigPos=false,nil
local function getJetCD()
    local ws=workspace:FindFirstChild("WorkspaceCom") if not ws then return nil end
    local ap=ws:FindFirstChild("001_Airport") if not ap then return nil end
    local hg=ap:FindFirstChild("AirportHanger") if not hg then return nil end
    local btn=hg:FindFirstChild("001_JetCloneButton") if not btn then return nil end
    local b=btn:FindFirstChild("Button") if not b then return nil end
    return b:FindFirstChild("ClickDetector"),hg:FindFirstChild("001_JetStorage")
end
AddButton(CLag,"Iniciar Spam Jatos","",function()
    if jetActive then return end
    local hrp=Character and Character:FindFirstChild("HumanoidRootPart") if not hrp then return end
    local cd,storage=getJetCD() if not cd or not storage then return end
    jetOrigPos=hrp.CFrame
    hrp.CFrame=CFrame.new(488,-20,234)
    jetActive=true
    task.spawn(function()
        local used={} local h=0
        while jetActive do
            pcall(function() fireclickdetector(cd) end) task.wait(0.5)
            for _,jet in ipairs(storage:GetChildren()) do
                if jet:IsA("Model") and jet:FindFirstChild("NoUse") and not table.find(used,jet) then
                    h=h+6 local pp=jet:FindFirstChild("NoUse") or jet:FindFirstChildWhichIsA("BasePart")
                    if pp then jet.PrimaryPart=pp jet:SetPrimaryPartCFrame(CFrame.new(0,h,0)) table.insert(used,jet) end
                    break
                end
            end
            task.wait(0.5)
        end
    end)
end)
AddButton(CLag,"Parar Spam Jatos","",function()
    jetActive=false
    local hrp=Character and Character:FindFirstChild("HumanoidRootPart")
    if hrp and jetOrigPos then hrp.CFrame=jetOrigPos end
end)

AddSep(PLag,"Jatos em Player")
local CLag2 = AddContainer(PLag)
local jetTargetName,jetTargetActive="",false
AddInput(CLag2,"Player alvo...",function(v) jetTargetName=v end)
AddToggle(CLag2,"Auto Jatos no Player","",function(v)
    jetTargetActive=v
    if v then task.spawn(function()
        local hrp=Character and Character:FindFirstChild("HumanoidRootPart") if not hrp then return end
        local cd,storage=getJetCD() if not cd or not storage then return end
        hrp.CFrame=CFrame.new(488,-20,234)
        local used={}
        while jetTargetActive do
            pcall(function() fireclickdetector(cd) end) task.wait(0.5)
            local tp=Players:FindFirstChild(jetTargetName)
            for _,jet in ipairs(storage:GetChildren()) do
                if jet:IsA("Model") and jet:FindFirstChild("NoUse") and not table.find(used,jet) then
                    if tp and tp.Character then
                        local thr=tp.Character:FindFirstChild("HumanoidRootPart")
                        if thr then
                            local pp=jet:FindFirstChild("NoUse") or jet:FindFirstChildWhichIsA("BasePart")
                            if pp then jet.PrimaryPart=pp jet:SetPrimaryPartCFrame(CFrame.new(thr.Position+Vector3.new(math.random(-3,3),math.random(4,8),math.random(-3,3)))) table.insert(used,jet) end
                        end
                    end
                    break
                end
            end
            task.wait(0.5)
        end
    end) end
end)

-- TELEPORTE
local PTeleporte = NewPanel()
AddSep(PTeleporte,"Pontos do Mapa")
local CTp = AddContainer(PTeleporte)
for _,tp in ipairs({{"Spawn",Vector3.new(0,5,0)},{"Escola",Vector3.new(120,5,80)},{"Hospital",Vector3.new(-120,5,60)},{"Policia",Vector3.new(80,5,-100)},{"Banco",Vector3.new(-80,5,-120)},{"Parque",Vector3.new(0,5,200)},{"Supermercado",Vector3.new(200,5,0)},{"Posto",Vector3.new(-200,5,0)},{"Aeroporto",Vector3.new(300,5,300)}}) do
    AddButton(CTp,tp[1],"",function() if RootPart then RootPart.CFrame=CFrame.new(tp[2]) end end)
end
AddSep(PTeleporte,"Por Player")
local CTp2 = AddContainer(PTeleporte)
local tp2Name=""
AddInput(CTp2,"Nome do player...",function(v) tp2Name=v end)
AddButton(CTp2,"Teleportar","",function()
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Name:lower():find(tp2Name:lower()) then
            local c=p.Character if c then local r=c:FindFirstChild("HumanoidRootPart") if r and RootPart then RootPart.CFrame=r.CFrame+Vector3.new(2,0,0) end end
        end
    end
end)

-- AUDIO
local PAudio = NewPanel()
AddSep(PAudio,"Musica")
local CAud = AddContainer(PAudio)
local musicID=""
AddInput(CAud,"ID da musica...",function(v) musicID=v end)
AddButton(CAud,"Tocar","",function()
    if musicID~="" then local s=Instance.new("Sound") s.SoundId="rbxassetid://"..musicID s.Volume=0.5 s.Parent=workspace s:Play() end
end)
AddButton(CAud,"Parar Tudo","",function()
    for _,s in ipairs(workspace:GetDescendants()) do if s:IsA("Sound") then s:Stop() end end
end)
AddSep(PAudio,"Prontas")
local CAud2 = AddContainer(PAudio)
for _,m in ipairs({{"Phonk","1845288678"},{"Funk BR","1374269869"},{"Trap","1843671350"},{"Lo-fi","1372719710"},{"Pagode","142376088"}}) do
    AddButton(CAud2,m[1],"",function()
        for _,s in ipairs(workspace:GetDescendants()) do if s:IsA("Sound") then s:Stop() end end
        local s=Instance.new("Sound") s.SoundId="rbxassetid://"..m[2] s.Volume=0.5 s.Parent=workspace s:Play()
    end)
end

-- ADMIN
local PAdmin = NewPanel()
AddSep(PAdmin,"Comandos por Chat")
AddLabel(PAdmin,"Use: /fly /noclip /speed 100 /godmode /bring nome /tp nome /killall")
local CAdmin = AddContainer(PAdmin)
AddButton(CAdmin,"Kill Eu","",function() if Humanoid then Humanoid.Health=0 end end)
AddButton(CAdmin,"Kill All","",function()
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then local h=p.Character:FindFirstChild("Humanoid") if h then h.Health=0 end end end
end)
AddButton(CAdmin,"Bring All","",function()
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then
        local r=p.Character:FindFirstChild("HumanoidRootPart")
        if r and RootPart then r.CFrame=RootPart.CFrame+Vector3.new(math.random(-3,3),0,math.random(-3,3)) end
    end end
end)

pcall(function()
    if TextChatService.ChatVersion==Enum.ChatVersion.TextChatService then
        local ch=TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
        ch.OnIncomingMessage=function(msg)
            local sender=msg.TextSource and Players:GetPlayerByUserId(msg.TextSource.UserId)
            if sender~=LP then return end
            local text=msg.Text:lower()
            if text:sub(1,1)~="/" then return end
            local args={} for w in text:gmatch("%S+") do table.insert(args,w) end
            local cmd=args[1]
            if cmd=="/fly" then flyActive=not flyActive
            elseif cmd=="/noclip" then noclipActive=not noclipActive
            elseif cmd=="/speed" then local n=tonumber(args[2]) if n and Humanoid then Humanoid.WalkSpeed=n end
            elseif cmd=="/godmode" then task.spawn(function() while true do if Humanoid then Humanoid.Health=Humanoid.MaxHealth end task.wait(0.1) end end)
            elseif cmd=="/bring" then local name=args[2] if name then
                for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Name:lower():find(name) then
                    local r=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                    if r and RootPart then r.CFrame=RootPart.CFrame+Vector3.new(2,0,0) end
                end end
            end
            elseif cmd=="/tp" then local name=args[2] if name then
                for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Name:lower():find(name) then
                    local r=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                    if r and RootPart then RootPart.CFrame=r.CFrame+Vector3.new(2,0,0) end
                end end
            end
            elseif cmd=="/killall" then
                for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then local h=p.Character:FindFirstChild("Humanoid") if h then h.Health=0 end end end
            end
        end
    end
end)

-- CONFIG
local PConfig = NewPanel()
AddSep(PConfig,"Iluminacao")
local CCfg = AddContainer(PConfig)
AddToggle(CCfg,"Full Bright","Remove escuridao",function(v)
    if v then Lighting.Brightness=2 Lighting.ClockTime=14 Lighting.GlobalShadows=false Lighting.Ambient=Color3.fromRGB(255,255,255)
    else Lighting.Brightness=1 Lighting.GlobalShadows=true Lighting.Ambient=Color3.fromRGB(100,100,100) end
end)
AddSep(PConfig,"Geral")
local CCfg2 = AddContainer(PConfig)
AddButton(CCfg2,"Rejoin","",function() game:GetService("TeleportService"):Teleport(game.PlaceId,LP) end)
AddSep(PConfig,"Resolucao de Camera")
local CCfg3 = AddContainer(PConfig)
local function setRes(v)
    getgenv().Resolution={[".res"]=v}
    if not getgenv().resSet then
        RunService.RenderStepped:Connect(function()
            Camera.CFrame=Camera.CFrame*CFrame.new(0,0,0,1,0,0,0,getgenv().Resolution[".res"],0,0,0,1)
        end)
        getgenv().resSet=true
    end
end
AddButton(CCfg3,"Normal (1.0)","",function() setRes(1.0) end)
AddButton(CCfg3,"0.80","",function() setRes(0.80) end)
AddButton(CCfg3,"0.70","",function() setRes(0.70) end)

-- ============================================================
-- MONTAR SIDEBAR
-- ============================================================
AddTab("*","Inicio",    PInicio)
AddTab("+","Protecao",  PProtecao)
AddTab("@","Personagem",PPersonagem)
AddTab("#","Jogadores", PJogadores)
AddTab("!","Troll",     PTroll)
AddTab("~","Lag",       PLag)
AddTab(">","Teleporte", PTeleporte)
AddTab("$","Audio",     PAudio)
AddTab("^","Admin",     PAdmin)
AddTab("-","Config",    PConfig)

-- Abre primeira tab
TabButtons[1].btn.MouseButton1Click:Fire()

print("[LyonHub] Carregado v1.0")
