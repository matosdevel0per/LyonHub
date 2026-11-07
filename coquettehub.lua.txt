-- COQUETTE HUB | Halloween Theme | Brookhaven | Delta Executor

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

local H = {
    BG        = Color3.fromRGB(12, 4, 6),
    Panel     = Color3.fromRGB(22, 8, 10),
    Sidebar   = Color3.fromRGB(16, 5, 7),
    Accent    = Color3.fromRGB(180, 20, 30),
    AccentHov = Color3.fromRGB(220, 30, 40),
    AccentDim = Color3.fromRGB(90, 10, 15),
    Text      = Color3.fromRGB(220, 200, 205),
    TextDim   = Color3.fromRGB(140, 110, 115),
    Border    = Color3.fromRGB(100, 15, 20),
    Toggle_ON = Color3.fromRGB(200, 25, 35),
    Toggle_OFF= Color3.fromRGB(50, 20, 22),
    White     = Color3.fromRGB(255, 255, 255),
    Header    = Color3.fromRGB(8, 2, 4),
    SubBG     = Color3.fromRGB(30, 8, 10),
}

local State = {
    Fly=false, Noclip=false, InfJump=false,
    Speed=false, SpeedVal=60, FlySpeed=50,
    GodMode=false, AntiVoid=false,
    ESP=false, FullBright=false,
    SpamMsg=false, SpamText="oi",
    HeadSit=false,
}

local ESPObjects = {}
local FlyBV, FlyBG
local TabButtons = {}
local TabPanels = {}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CoquetteHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
pcall(function() ScreenGui.Parent = game.CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LP.PlayerGui end

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 820, 0, 500)
Main.Position = UDim2.new(0.5, -410, 0.5, -250)
Main.BackgroundColor3 = H.BG
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

local Border = Instance.new("UIStroke")
Border.Color = H.Accent
Border.Thickness = 1.5
Border.Parent = Main

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 44)
Header.BackgroundColor3 = H.Header
Header.BorderSizePixel = 0
Header.ZIndex = 5
Header.Parent = Main

local UIStrokeH = Instance.new("UIStroke")
UIStrokeH.Color = H.Border
UIStrokeH.Thickness = 1
UIStrokeH.Parent = Header

local AvatarFrame = Instance.new("Frame")
AvatarFrame.Size = UDim2.new(0, 34, 0, 34)
AvatarFrame.Position = UDim2.new(0, 6, 0.5, -17)
AvatarFrame.BackgroundColor3 = H.AccentDim
AvatarFrame.ZIndex = 6
AvatarFrame.Parent = Header
Instance.new("UICorner", AvatarFrame).CornerRadius = UDim.new(0, 4)

local AvatarLabel = Instance.new("TextLabel")
AvatarLabel.Size = UDim2.new(1,0,1,0)
AvatarLabel.BackgroundTransparency = 1
AvatarLabel.Text = "👻"
AvatarLabel.TextSize = 18
AvatarLabel.ZIndex = 7
AvatarLabel.Parent = AvatarFrame

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 260, 1, 0)
Logo.Position = UDim2.new(0, 46, 0, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "COQUETTE - HUB"
Logo.TextColor3 = H.Accent
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 17
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.ZIndex = 6
Logo.Parent = Header

local SubVer = Instance.new("TextLabel")
SubVer.Size = UDim2.new(0, 100, 1, 0)
SubVer.Position = UDim2.new(0, 212, 0, 0)
SubVer.BackgroundTransparency = 1
SubVer.Text = "V5 by Lolytadev"
SubVer.TextColor3 = H.TextDim
SubVer.Font = Enum.Font.Gotham
SubVer.TextSize = 10
SubVer.TextXAlignment = Enum.TextXAlignment.Left
SubVer.ZIndex = 6
SubVer.Parent = Header

local Dot = Instance.new("Frame")
Dot.Size = UDim2.new(0, 8, 0, 8)
Dot.Position = UDim2.new(0, 316, 0.5, -4)
Dot.BackgroundColor3 = H.Accent
Dot.ZIndex = 6
Dot.Parent = Header
Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

local Badge = Instance.new("TextButton")
Badge.Size = UDim2.new(0, 110, 0, 28)
Badge.Position = UDim2.new(1, -190, 0.5, -14)
Badge.BackgroundColor3 = H.Accent
Badge.Text = "HALLOWEEN"
Badge.TextColor3 = H.White
Badge.Font = Enum.Font.GothamBold
Badge.TextSize = 12
Badge.ZIndex = 6
Badge.Parent = Header
Instance.new("UICorner", Badge).CornerRadius = UDim.new(0, 4)

-- Bolinha flutuante
local Minimized = false
local Ball = Instance.new("TextButton")
Ball.Size = UDim2.new(0, 40, 0, 40)
Ball.Position = UDim2.new(0, 20, 0.5, -20)
Ball.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Ball.Text = "👻"
Ball.TextSize = 16
Ball.BorderSizePixel = 0
Ball.ZIndex = 999
Ball.Visible = false
Ball.Parent = ScreenGui
Instance.new("UICorner", Ball).CornerRadius = UDim.new(1, 0)

local function HeaderBtn(icon, xOffset, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 28, 0, 28)
    b.Position = UDim2.new(1, xOffset, 0.5, -14)
    b.BackgroundTransparency = 1
    b.Text = icon
    b.TextColor3 = H.TextDim
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.ZIndex = 6
    b.Parent = Header
    b.MouseButton1Click:Connect(cb)
    return b
end

HeaderBtn("⚙", -86, function() end)
HeaderBtn("−", -58, function()
    Minimized = true
    TweenService:Create(Main, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 0, 0, 0),
    }):Play()
    task.wait(0.2)
    Main.Visible = false
    Ball.Visible = true
end)
HeaderBtn("✕", -30, function() ScreenGui:Destroy() end)

Ball.MouseButton1Click:Connect(function()
    Minimized = false
    Ball.Visible = false
    Main.Visible = true
    Main.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 820, 0, 500),
    }):Play()
end)

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 170, 1, -44)
Sidebar.Position = UDim2.new(0, 0, 0, 44)
Sidebar.BackgroundColor3 = H.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 2
Sidebar.ScrollBarImageColor3 = H.Accent
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
Sidebar.ZIndex = 3
Sidebar.Parent = Main

local SideList = Instance.new("UIListLayout")
SideList.Padding = UDim.new(0, 2)
SideList.Parent = Sidebar

local SidePad = Instance.new("UIPadding")
SidePad.PaddingTop = UDim.new(0, 6)
SidePad.PaddingLeft = UDim.new(0, 6)
SidePad.PaddingRight = UDim.new(0, 6)
SidePad.Parent = Sidebar

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0, 1, 1, -44)
Divider.Position = UDim2.new(0, 170, 0, 44)
Divider.BackgroundColor3 = H.Border
Divider.BorderSizePixel = 0
Divider.ZIndex = 3
Divider.Parent = Main

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -172, 1, -44)
Content.Position = UDim2.new(0, 172, 0, 44)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ClipsDescendants = true
Content.ZIndex = 2
Content.Parent = Main

local function NewPanel()
    local sf = Instance.new("ScrollingFrame")
    sf.Size = UDim2.new(1, 0, 1, 0)
    sf.BackgroundTransparency = 1
    sf.BorderSizePixel = 0
    sf.ScrollBarThickness = 3
    sf.ScrollBarImageColor3 = H.Accent
    sf.CanvasSize = UDim2.new(0,0,0,0)
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sf.Visible = false
    sf.ZIndex = 3
    sf.Parent = Content
    local ul = Instance.new("UIListLayout")
    ul.Padding = UDim.new(0, 6)
    ul.Parent = sf
    local up = Instance.new("UIPadding")
    up.PaddingTop = UDim.new(0, 10)
    up.PaddingLeft = UDim.new(0, 10)
    up.PaddingRight = UDim.new(0, 10)
    up.PaddingBottom = UDim.new(0, 10)
    up.Parent = sf
    return sf
end

local function SideTab(icon, label, panel)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 36)
    Btn.BackgroundColor3 = H.Sidebar
    Btn.BorderSizePixel = 0
    Btn.Text = ""
    Btn.ZIndex = 4
    Btn.Parent = Sidebar
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    local IconL = Instance.new("TextLabel")
    IconL.Size = UDim2.new(0, 24, 1, 0)
    IconL.Position = UDim2.new(0, 8, 0, 0)
    IconL.BackgroundTransparency = 1
    IconL.Text = icon
    IconL.TextColor3 = H.TextDim
    IconL.Font = Enum.Font.GothamBold
    IconL.TextSize = 14
    IconL.ZIndex = 5
    IconL.Parent = Btn

    local NameL = Instance.new("TextLabel")
    NameL.Size = UDim2.new(1, -50, 1, 0)
    NameL.Position = UDim2.new(0, 36, 0, 0)
    NameL.BackgroundTransparency = 1
    NameL.Text = label
    NameL.TextColor3 = H.TextDim
    NameL.Font = Enum.Font.Gotham
    NameL.TextSize = 13
    NameL.TextXAlignment = Enum.TextXAlignment.Left
    NameL.ZIndex = 5
    NameL.Parent = Btn

    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.new(0, 14, 1, 0)
    Arrow.Position = UDim2.new(1, -18, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "›"
    Arrow.TextColor3 = H.TextDim
    Arrow.Font = Enum.Font.GothamBold
    Arrow.TextSize = 16
    Arrow.ZIndex = 5
    Arrow.Parent = Btn

    local ActiveBar = Instance.new("Frame")
    ActiveBar.Size = UDim2.new(0, 3, 0.6, 0)
    ActiveBar.Position = UDim2.new(0, 0, 0.2, 0)
    ActiveBar.BackgroundColor3 = H.Accent
    ActiveBar.BorderSizePixel = 0
    ActiveBar.Visible = false
    ActiveBar.ZIndex = 6
    ActiveBar.Parent = Btn
    Instance.new("UICorner", ActiveBar).CornerRadius = UDim.new(0, 2)

    table.insert(TabButtons, {btn=Btn, bar=ActiveBar, icon=IconL, name=NameL, arrow=Arrow})
    table.insert(TabPanels, panel)

    Btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(TabPanels) do p.Visible = false end
        for _, t in ipairs(TabButtons) do
            t.btn.BackgroundColor3 = H.Sidebar
            t.bar.Visible = false
            t.name.TextColor3 = H.TextDim
            t.icon.TextColor3 = H.TextDim
            t.arrow.TextColor3 = H.TextDim
        end
        panel.Visible = true
        Btn.BackgroundColor3 = H.AccentDim
        ActiveBar.Visible = true
        NameL.TextColor3 = H.White
        IconL.TextColor3 = H.Accent
        Arrow.TextColor3 = H.Accent
    end)
end

local function PanelHeader(parent, text)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 28)
    Row.BackgroundTransparency = 1
    Row.ZIndex = 4
    Row.Parent = parent
    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(0, 3, 0.7, 0)
    Bar.Position = UDim2.new(0, 0, 0.15, 0)
    Bar.BackgroundColor3 = H.Accent
    Bar.BorderSizePixel = 0
    Bar.ZIndex = 5
    Bar.Parent = Row
    Instance.new("UICorner", Bar).CornerRadius = UDim.new(0,2)
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, -10, 1, 0)
    Lbl.Position = UDim2.new(0, 10, 0, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = text
    Lbl.TextColor3 = H.Text
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextSize = 14
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 5
    Lbl.Parent = Row
end

local function MakeToggle(parent, label, desc, cb)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 52)
    Row.BackgroundColor3 = H.Panel
    Row.BorderSizePixel = 0
    Row.ZIndex = 4
    Row.Parent = parent
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)
    local S = Instance.new("UIStroke")
    S.Color = H.Border S.Thickness = 1 S.Parent = Row
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(0.65, 0, 0, 22)
    Lbl.Position = UDim2.new(0, 14, 0, 8)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label
    Lbl.TextColor3 = H.Text
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextSize = 13
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 5
    Lbl.Parent = Row
    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(0.7, 0, 0, 16)
    Desc.Position = UDim2.new(0, 14, 0, 30)
    Desc.BackgroundTransparency = 1
    Desc.Text = desc
    Desc.TextColor3 = H.TextDim
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 11
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.ZIndex = 5
    Desc.Parent = Row
    local enabled = false
    local Pill = Instance.new("Frame")
    Pill.Size = UDim2.new(0, 46, 0, 24)
    Pill.Position = UDim2.new(1, -58, 0.5, -12)
    Pill.BackgroundColor3 = H.Toggle_OFF
    Pill.BorderSizePixel = 0
    Pill.ZIndex = 5
    Pill.Parent = Row
    Instance.new("UICorner", Pill).CornerRadius = UDim.new(1, 0)
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 18, 0, 18)
    Knob.Position = UDim2.new(0, 3, 0.5, -9)
    Knob.BackgroundColor3 = H.White
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 6
    Knob.Parent = Pill
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.ZIndex = 7
    Btn.Parent = Row
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        local ti = TweenInfo.new(0.2, Enum.EasingStyle.Quad)
        if enabled then
            TweenService:Create(Pill, ti, {BackgroundColor3 = H.Toggle_ON}):Play()
            TweenService:Create(Knob, ti, {Position = UDim2.new(0, 25, 0.5, -9)}):Play()
        else
            TweenService:Create(Pill, ti, {BackgroundColor3 = H.Toggle_OFF}):Play()
            TweenService:Create(Knob, ti, {Position = UDim2.new(0, 3, 0.5, -9)}):Play()
        end
        cb(enabled)
    end)
end

local function MakeButton(parent, label, desc, cb)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 52)
    Row.BackgroundColor3 = H.Panel
    Row.BorderSizePixel = 0
    Row.ZIndex = 4
    Row.Parent = parent
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)
    local S = Instance.new("UIStroke")
    S.Color = H.Border S.Thickness = 1 S.Parent = Row
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(0.8, 0, 0, 22)
    Lbl.Position = UDim2.new(0, 14, 0, 8)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label
    Lbl.TextColor3 = H.Text
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextSize = 13
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 5
    Lbl.Parent = Row
    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(0.8, 0, 0, 16)
    Desc.Position = UDim2.new(0, 14, 0, 30)
    Desc.BackgroundTransparency = 1
    Desc.Text = desc
    Desc.TextColor3 = H.TextDim
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 11
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.ZIndex = 5
    Desc.Parent = Row
    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.new(0, 20, 1, 0)
    Arrow.Position = UDim2.new(1, -28, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "›"
    Arrow.TextColor3 = H.Accent
    Arrow.Font = Enum.Font.GothamBold
    Arrow.TextSize = 20
    Arrow.ZIndex = 5
    Arrow.Parent = Row
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1,0,1,0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.ZIndex = 7
    Btn.Parent = Row
    Btn.MouseButton1Click:Connect(function()
        TweenService:Create(Row, TweenInfo.new(0.1), {BackgroundColor3 = H.AccentDim}):Play()
        task.delay(0.15, function()
            TweenService:Create(Row, TweenInfo.new(0.1), {BackgroundColor3 = H.Panel}):Play()
        end)
        cb()
    end)
end

local function MakeSlider(parent, label, min, max, default, cb)
    local value = default
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 60)
    Container.BackgroundColor3 = H.Panel
    Container.BorderSizePixel = 0
    Container.ZIndex = 4
    Container.Parent = parent
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6)
    local S = Instance.new("UIStroke")
    S.Color = H.Border S.Thickness = 1 S.Parent = Container
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, -10, 0, 22)
    Lbl.Position = UDim2.new(0, 14, 0, 8)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label .. ":  " .. tostring(default)
    Lbl.TextColor3 = H.Text
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextSize = 12
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 5
    Lbl.Parent = Container
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, -28, 0, 6)
    Track.Position = UDim2.new(0, 14, 0, 40)
    Track.BackgroundColor3 = H.AccentDim
    Track.BorderSizePixel = 0
    Track.ZIndex = 5
    Track.Parent = Container
    Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    Fill.BackgroundColor3 = H.Accent
    Fill.BorderSizePixel = 0
    Fill.ZIndex = 6
    Fill.Parent = Track
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
    local Knob = Instance.new("TextButton")
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.Position = UDim2.new((default-min)/(max-min), -7, 0.5, -7)
    Knob.BackgroundColor3 = H.White
    Knob.Text = ""
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 7
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
            Fill.Size = UDim2.new(p, 0, 1, 0)
            Knob.Position = UDim2.new(p, -7, 0.5, -7)
            Lbl.Text = label .. ":  " .. tostring(value)
            cb(value)
        end
    end)
end

local function MakeInput(parent, placeholder, cb)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 40)
    Row.BackgroundColor3 = H.Panel
    Row.BorderSizePixel = 0
    Row.ZIndex = 4
    Row.Parent = parent
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)
    local S = Instance.new("UIStroke")
    S.Color = H.Border S.Thickness = 1 S.Parent = Row
    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(0.72, 0, 1, -10)
    Box.Position = UDim2.new(0, 10, 0, 5)
    Box.BackgroundColor3 = H.SubBG
    Box.PlaceholderText = placeholder
    Box.PlaceholderColor3 = H.TextDim
    Box.Text = ""
    Box.TextColor3 = H.Text
    Box.Font = Enum.Font.Gotham
    Box.TextSize = 12
    Box.BorderSizePixel = 0
    Box.ZIndex = 5
    Box.Parent = Row
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)
    local Confirm = Instance.new("TextButton")
    Confirm.Size = UDim2.new(0.22, 0, 1, -10)
    Confirm.Position = UDim2.new(0.76, 0, 0, 5)
    Confirm.BackgroundColor3 = H.Accent
    Confirm.Text = "OK"
    Confirm.TextColor3 = H.White
    Confirm.Font = Enum.Font.GothamBold
    Confirm.TextSize = 12
    Confirm.BorderSizePixel = 0
    Confirm.ZIndex = 5
    Confirm.Parent = Row
    Instance.new("UICorner", Confirm).CornerRadius = UDim.new(0, 4)
    Confirm.MouseButton1Click:Connect(function() cb(Box.Text) end)
    return Box
end

-- PANELS
local PCredits = NewPanel()
PanelHeader(PCredits, "Créditos")
MakeButton(PCredits, "Desenvolvedor", "Lolytadev", function() end)
MakeButton(PCredits, "Versão", "V5 Halloween Edition", function() end)

local PUpdate = NewPanel()
PanelHeader(PUpdate, "Update")
MakeButton(PUpdate, "Verificar atualização", "Checa por uma nova versão", function()
    print("[CoquetteHub] V5 - atualizado")
end)

local PEvento = NewPanel()
PanelHeader(PEvento, "Halloween")
local farmActive = false
MakeToggle(PEvento, "Auto farm milho doce", "Coleta os 60 milhos da semana", function(on)
    farmActive = on
    if on then
        task.spawn(function()
            while farmActive do
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and obj.Name:lower():find("milho") then
                        if RootPart then
                            RootPart.CFrame = CFrame.new(obj.Position + Vector3.new(0, 3, 0))
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    end
end)
MakeToggle(PEvento, "Resetar caça automaticamente", "Respawna os milhos quando acabam", function(on) end)
MakeButton(PEvento, "Resetar caça agora", "Precisa de 40+ coletados", function()
    pcall(function()
        game:GetService("ReplicatedStorage"):FindFirstChild("ResetHunt"):FireServer()
    end)
end)

local PAdmin = NewPanel()
PanelHeader(PAdmin, "Admin")
MakeButton(PAdmin, "Bring all", "Traz todos os players pra você", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local r = p.Character:FindFirstChild("HumanoidRootPart")
            if r and RootPart then
                r.CFrame = RootPart.CFrame + Vector3.new(math.random(-3,3), 0, math.random(-3,3))
            end
        end
    end
end)
MakeButton(PAdmin, "Kill all", "Mata todos os players", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local h = p.Character:FindFirstChild("Humanoid")
            if h then h.Health = 0 end
        end
    end
end)

local PConfig = NewPanel()
PanelHeader(PConfig, "Configuração")
MakeToggle(PConfig, "Full Bright", "Remove escuridão do mapa", function(on)
    State.FullBright = on
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
MakeToggle(PConfig, "Anti-AFK", "Previne kick por inatividade", function(on)
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
MakeButton(PConfig, "Rejoin", "Reconecta ao servidor", function()
    TeleportService:Teleport(game.PlaceId, LP)
end)

local PJogador = NewPanel()
PanelHeader(PJogador, "Jogador")
MakeToggle(PJogador, "Speed Hack", "Aumenta velocidade de movimento", function(on)
    State.Speed = on
    if Humanoid then Humanoid.WalkSpeed = on and State.SpeedVal or 16 end
end)
MakeSlider(PJogador, "Velocidade", 16, 250, 60, function(v)
    State.SpeedVal = v
    if State.Speed and Humanoid then Humanoid.WalkSpeed = v end
end)
MakeToggle(PJogador, "Fly", "Voa pelo mapa com WASD + Espaço", function(on)
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
MakeSlider(PJogador, "Velocidade de voo", 10, 200, 50, function(v) State.FlySpeed = v end)
MakeToggle(PJogador, "Noclip", "Atravessa paredes", function(on) State.Noclip = on end)
MakeToggle(PJogador, "Infinite Jump", "Pula infinitamente", function(on) State.InfJump = on end)
MakeToggle(PJogador, "God Mode", "HP sempre no máximo", function(on) State.GodMode = on end)
MakeToggle(PJogador, "Anti-Void", "Teleporta de volta se cair", function(on) State.AntiVoid = on end)
MakeButton(PJogador, "Teleport: Spawn", "Vai ao ponto inicial", function()
    if RootPart then RootPart.CFrame = CFrame.new(0, 5, 0) end
end)

local PJogadores = NewPanel()
PanelHeader(PJogadores, "Jogadores")
MakeToggle(PJogadores, "ESP Players", "Mostra players através das paredes", function(on)
    State.ESP = on
    if not on then
        for _, o in pairs(ESPObjects) do if o and o.Parent then o:Destroy() end end
        ESPObjects = {}
    end
end)
MakeToggle(PJogadores, "Head Sit", "Senta na cabeça do player", function(on) State.HeadSit = on end)
MakeInput(PJogadores, "Nome do player para Head Sit...", function(name)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Name:lower():find(name:lower()) then
            local c = p.Character
            if c then
                local head = c:FindFirstChild("Head")
                if head and RootPart then
                    RootPart.CFrame = CFrame.new(head.Position + Vector3.new(0, 2, 0))
                    local weld = Instance.new("WeldConstraint")
                    weld.Part0 = RootPart
                    weld.Part1 = head
                    weld.Parent = RootPart
                end
            end
        end
    end
end)
MakeButton(PJogadores, "Listar players", "Printa nomes no console", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then print("► " .. p.Name) end
    end
end)
MakeInput(PJogadores, "Teleport para player (nome)...", function(name)
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

local PExtra = NewPanel()
PanelHeader(PExtra, "Extra")
MakeButton(PExtra, "Resetar personagem", "Mata e respawna", function()
    if Humanoid then Humanoid.Health = 0 end
end)
MakeToggle(PExtra, "Invisible", "Torna personagem transparente", function(on)
    if Character then
        for _, p in ipairs(Character:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                p.Transparency = on and 1 or 0
            end
        end
    end
end)

local PAvatar = NewPanel()
PanelHeader(PAvatar, "Avatar")
MakeButton(PAvatar, "Tamanho gigante", "Escala para 5x", function()
    if Character then
        local h = Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=5 h.BodyHeightScale.Value=5 h.BodyWidthScale.Value=5 h.HeadScale.Value=5 end
    end
end)
MakeButton(PAvatar, "Tamanho normal", "Restaura escala", function()
    if Character then
        local h = Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=1 h.BodyHeightScale.Value=1 h.BodyWidthScale.Value=1 h.HeadScale.Value=1 end
    end
end)
MakeButton(PAvatar, "Tamanho minúsculo", "Escala para 0.3x", function()
    if Character then
        local h = Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=.3 h.BodyHeightScale.Value=.3 h.BodyWidthScale.Value=.3 h.HeadScale.Value=.3 end
    end
end)

local PHouse = NewPanel()
PanelHeader(PHouse, "House")
MakeButton(PHouse, "Teleport: Minha casa", "Vai para sua casa", function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == LP.Name and obj:IsA("Model") then
            local r = obj.PrimaryPart
            if r and RootPart then
                RootPart.CFrame = CFrame.new(r.Position + Vector3.new(0, 3, 5))
                return
            end
        end
    end
end)

local PTroll = NewPanel()
PanelHeader(PTroll, "Troll")
MakeToggle(PTroll, "Spam chat", "Manda mensagem repetida", function(on) State.SpamMsg = on end)
MakeInput(PTroll, "Texto do spam...", function(txt) State.SpamText = txt ~= "" and txt or "oi" end)
MakeButton(PTroll, "Flood jump", "Pula rapidamente várias vezes", function()
    task.spawn(function()
        for i = 1, 20 do
            if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
            task.wait(0.1)
        end
    end)
end)

local PProtection = NewPanel()
PanelHeader(PProtection, "Protection")
MakeToggle(PProtection, "God Mode", "HP sempre cheio", function(on) State.GodMode = on end)
MakeToggle(PProtection, "Anti-Void", "Teleporta de volta se cair", function(on) State.AntiVoid = on end)

local PScripts = NewPanel()
PanelHeader(PScripts, "Scripts")
MakeButton(PScripts, "Info", "Use o console do Delta para scripts customizados", function()
    print("[CoquetteHub] Cole scripts customizados direto no Delta")
end)

local PSpam = NewPanel()
PanelHeader(PSpam, "Spam")
MakeToggle(PSpam, "Spam chat ativo", "Manda texto repetido no chat", function(on) State.SpamMsg = on end)
MakeInput(PSpam, "Texto para spammar...", function(txt) State.SpamText = txt ~= "" and txt or "coquette hub" end)

local PRGB = NewPanel()
PanelHeader(PRGB, "RGB")
MakeToggle(PRGB, "RGB Personagem", "Muda cor do personagem em loop", function(on)
    if on then
        task.spawn(function()
            local t = 0
            while on do
                t = t + 0.05
                local c = Color3.fromHSV(t % 1, 1, 1)
                if Character then
                    for _, p in ipairs(Character:GetDescendants()) do
                        if p:IsA("BasePart") then p.Color = c end
                    end
                end
                task.wait(0.05)
            end
        end)
    end
end)

local PMusic = NewPanel()
PanelHeader(PMusic, "Music")
MakeInput(PMusic, "ID da música (ex: 1234567)...", function(id)
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://" .. id
    s.Volume = 0.5
    s.Parent = workspace
    s:Play()
end)
MakeButton(PMusic, "Parar música", "Para todos os sons", function()
    for _, s in ipairs(workspace:GetDescendants()) do
        if s:IsA("Sound") then s:Stop() end
    end
end)

local PProps = NewPanel()
PanelHeader(PProps, "Props")
MakeButton(PProps, "Deletar props próximos", "Remove props num raio de 15 studs", function()
    if not RootPart then return end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("prop") then
            if (obj.Position - RootPart.Position).Magnitude < 15 then obj:Destroy() end
        end
    end
end)

local PTeleport = NewPanel()
PanelHeader(PTeleport, "Teleportes")
local tpPoints = {
    {"Spawn", Vector3.new(0,5,0)}, {"Escola", Vector3.new(120,5,80)},
    {"Hospital", Vector3.new(-120,5,60)}, {"Policia", Vector3.new(80,5,-100)},
    {"Banco", Vector3.new(-80,5,-120)}, {"Parque", Vector3.new(0,5,200)},
}
for _, tp in ipairs(tpPoints) do
    MakeButton(PTeleport, tp[1], "Teleporta para " .. tp[1], function()
        if RootPart then RootPart.CFrame = CFrame.new(tp[2]) end
    end)
end
MakeInput(PTeleport, "Nome do player para teleporte...", function(name)
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

-- SIDEBAR
SideTab("ⓘ", "Credits",      PCredits)
SideTab("📢", "Update",       PUpdate)
SideTab("👻", "Evento Brook", PEvento)
SideTab("👑", "Admin",        PAdmin)
SideTab("⚙",  "Configuração", PConfig)
SideTab("👤", "Jogador",      PJogador)
SideTab("👥", "Jogadores",    PJogadores)
SideTab("✦",  "Extra",        PExtra)
SideTab("👕", "Avatar",       PAvatar)
SideTab("🏠", "House",        PHouse)
SideTab("↩",  "Spam",         PSpam)
SideTab("🎨", "RGB",          PRGB)
SideTab("🎵", "Music",        PMusic)
SideTab("📦", "Props",        PProps)
SideTab("💀", "Troll",        PTroll)
SideTab("🛡",  "Protection",  PProtection)
SideTab("📋", "Scripts",      PScripts)
SideTab("📍", "Teleportes",   PTeleport)

-- abre primeira tab
TabButtons[1].btn.MouseButton1Click:Fire()

-- LOOPS
RunService.Heartbeat:Connect(function()
    if State.Fly and FlyBV and FlyBG and RootPart then
        local cam = workspace.CurrentCamera
        local d = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then d = d + cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then d = d - cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then d = d - cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then d = d + cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then d = d + Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then d = d - Vector3.new(0,1,0) end
        FlyBV.Velocity = d.Magnitude > 0 and d.Unit * State.FlySpeed or Vector3.zero
        FlyBG.CFrame = cam.CFrame
    end
    if State.GodMode and Humanoid then Humanoid.Health = Humanoid.MaxHealth end
    if State.AntiVoid and RootPart and RootPart.Position.Y < -100 then
        RootPart.CFrame = CFrame.new(0, 10, 0)
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
        box.Color3 = H.Accent
        box.LineThickness = 0.04
        box.SurfaceTransparency = 0.88
        box.Parent = workspace
        local bb = Instance.new("BillboardGui")
        bb.Adornee = r
        bb.Size = UDim2.new(0, 120, 0, 28)
        bb.StudsOffset = Vector3.new(0, 3.5, 0)
        bb.AlwaysOnTop = true
        bb.Parent = workspace
        local nl = Instance.new("TextLabel")
        nl.Size = UDim2.new(1,0,1,0)
        nl.BackgroundTransparency = 1
        nl.Text = "👻 " .. p.Name
        nl.TextColor3 = H.Text
        nl.Font = Enum.Font.GothamBold
        nl.TextSize = 13
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

print("[CoquetteHub] Carregado ✓")
