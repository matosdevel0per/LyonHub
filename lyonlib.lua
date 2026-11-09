-- LYON LIB | API compativel com redzlib | Lyon Hub v1.0
-- Feita do zero, sem dependencias externas

local LyonLib = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local C = {
    BG       = Color3.fromRGB(18,18,21),
    Header   = Color3.fromRGB(12,12,15),
    Sidebar  = Color3.fromRGB(14,14,17),
    Panel    = Color3.fromRGB(24,24,28),
    Accent   = Color3.fromRGB(148,148,162),
    AccentLt = Color3.fromRGB(188,188,202),
    AccentDk = Color3.fromRGB(46,46,54),
    Text     = Color3.fromRGB(212,212,218),
    TextDim  = Color3.fromRGB(105,105,115),
    Border   = Color3.fromRGB(42,42,50),
    Sep      = Color3.fromRGB(35,35,42),
    TGL_ON   = Color3.fromRGB(152,152,168),
    TGL_OFF  = Color3.fromRGB(44,44,52),
    White    = Color3.fromRGB(255,255,255),
    Green    = Color3.fromRGB(80,200,100),
    Notif    = Color3.fromRGB(20,20,24),
}

local LP = game:GetService("Players").LocalPlayer
local WIN_W, WIN_H = 700, 480
local TabButtons, TabPanels = {}, {}
local ActivePanel = nil

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LyonHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
pcall(function() ScreenGui.Parent = game.CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LP.PlayerGui end

-- Sombra
local Shadow = Instance.new("Frame")
Shadow.Size = UDim2.new(0,WIN_W+10,0,WIN_H+10)
Shadow.Position = UDim2.new(0.5,-(WIN_W+10)/2,0.5,-(WIN_H+10)/2)
Shadow.BackgroundColor3 = Color3.fromRGB(0,0,0)
Shadow.BackgroundTransparency = 0.55
Shadow.BorderSizePixel = 0 Shadow.ZIndex = 0 Shadow.Parent = ScreenGui
Instance.new("UICorner",Shadow).CornerRadius = UDim.new(0,13)

-- Main
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,0,0,0)
Main.Position = UDim2.new(0.5,-WIN_W/2,0.5,-WIN_H/2)
Main.BackgroundColor3 = C.BG Main.BorderSizePixel = 0
Main.Active = true Main.Draggable = true Main.ClipsDescendants = true Main.Parent = ScreenGui
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,10)
local MS = Instance.new("UIStroke") MS.Color = C.Border MS.Thickness = 1.5 MS.Parent = Main
TweenService:Create(Main,TweenInfo.new(0.35,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,WIN_W,0,WIN_H)}):Play()

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,48) Header.BackgroundColor3 = C.Header
Header.BorderSizePixel = 0 Header.ZIndex = 5 Header.Parent = Main
Instance.new("UICorner",Header).CornerRadius = UDim.new(0,10)
local HFix = Instance.new("Frame")
HFix.Size = UDim2.new(1,0,0,10) HFix.Position = UDim2.new(0,0,1,-10)
HFix.BackgroundColor3 = C.Header HFix.BorderSizePixel = 0 HFix.ZIndex = 5 HFix.Parent = Header
local HS = Instance.new("UIStroke") HS.Color = C.Border HS.Thickness = 1 HS.Parent = Header

local IconF = Instance.new("Frame")
IconF.Size = UDim2.new(0,32,0,32) IconF.Position = UDim2.new(0,10,0.5,-16)
IconF.BackgroundColor3 = C.AccentDk IconF.BorderSizePixel = 0 IconF.ZIndex = 6 IconF.Parent = Header
Instance.new("UICorner",IconF).CornerRadius = UDim.new(0,6)
local IconImg = Instance.new("ImageLabel")
IconImg.Size = UDim2.new(1,-4,1,-4) IconImg.Position = UDim2.new(0,2,0,2)
IconImg.BackgroundTransparency = 1 IconImg.Image = "rbxassetid://0" IconImg.ZIndex = 7 IconImg.Parent = IconF
Instance.new("UICorner",IconImg).CornerRadius = UDim.new(0,4)
local IconTxt = Instance.new("TextLabel")
IconTxt.Size = UDim2.new(1,0,1,0) IconTxt.BackgroundTransparency = 1
IconTxt.Text = "L" IconTxt.TextColor3 = C.White
IconTxt.Font = Enum.Font.GothamBold IconTxt.TextSize = 16 IconTxt.ZIndex = 8 IconTxt.Parent = IconF

local TitleLbl = Instance.new("TextLabel")
TitleLbl.Size = UDim2.new(0,250,1,0) TitleLbl.Position = UDim2.new(0,48,0,0)
TitleLbl.BackgroundTransparency = 1 TitleLbl.Text = "Lyon Hub"
TitleLbl.TextColor3 = C.AccentLt TitleLbl.Font = Enum.Font.GothamBold
TitleLbl.TextSize = 15 TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.ZIndex = 6 TitleLbl.Parent = Header

local CityDeco = Instance.new("TextLabel")
CityDeco.Size = UDim2.new(0,220,1,0) CityDeco.Position = UDim2.new(0.5,-110,0,0)
CityDeco.BackgroundTransparency = 1 CityDeco.Text = "▟▙▟▙▟▙▟▙▟"
CityDeco.TextColor3 = Color3.fromRGB(28,28,34) CityDeco.Font = Enum.Font.GothamBold
CityDeco.TextSize = 24 CityDeco.ZIndex = 5 CityDeco.Parent = Header

local SDot = Instance.new("Frame")
SDot.Size = UDim2.new(0,7,0,7) SDot.Position = UDim2.new(0,230,0.5,-3.5)
SDot.BackgroundColor3 = C.Green SDot.BorderSizePixel = 0 SDot.ZIndex = 6 SDot.Parent = Header
Instance.new("UICorner",SDot).CornerRadius = UDim.new(1,0)

-- Bolinha
local Minimized = false
local Ball = Instance.new("Frame")
Ball.Size = UDim2.new(0,46,0,46) Ball.Position = UDim2.new(0,20,0.5,-23)
Ball.BackgroundColor3 = C.AccentDk Ball.BorderSizePixel = 0
Ball.ZIndex = 999 Ball.Visible = false Ball.Active = true Ball.Parent = ScreenGui
Instance.new("UICorner",Ball).CornerRadius = UDim.new(1,0)
local BStroke = Instance.new("UIStroke") BStroke.Color = C.Accent BStroke.Thickness = 1.5 BStroke.Parent = Ball
local BallImg = Instance.new("ImageLabel")
BallImg.Size = UDim2.new(1,-6,1,-6) BallImg.Position = UDim2.new(0,3,0,3)
BallImg.BackgroundTransparency = 1 BallImg.Image = "rbxassetid://0" BallImg.ZIndex = 1000 BallImg.Parent = Ball
local BallTxt = Instance.new("TextLabel")
BallTxt.Size = UDim2.new(1,0,1,0) BallTxt.BackgroundTransparency = 1
BallTxt.Text = "L" BallTxt.TextColor3 = C.White
BallTxt.Font = Enum.Font.GothamBold BallTxt.TextSize = 20 BallTxt.ZIndex = 1001 BallTxt.Parent = Ball

local dragBall,dragStart,ballStart,didDrag=false,nil,nil,false
Ball.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        dragBall=true didDrag=false dragStart=i.Position ballStart=Ball.Position end
end)
Ball.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        if not didDrag then
            Minimized=false Ball.Visible=false Main.Visible=true Main.Size=UDim2.new(0,0,0,0)
            TweenService:Create(Main,TweenInfo.new(0.28,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,WIN_W,0,WIN_H)}):Play()
        end
        dragBall=false
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if dragBall and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-dragStart
        if d.Magnitude>5 then didDrag=true end
        if didDrag then Ball.Position=UDim2.new(ballStart.X.Scale,ballStart.X.Offset+d.X,ballStart.Y.Scale,ballStart.Y.Offset+d.Y) end
    end
end)

local function HBtn(txt,ox,cb)
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(0,28,0,28) b.Position=UDim2.new(1,ox,0.5,-14)
    b.BackgroundTransparency=1 b.Text=txt b.TextColor3=C.TextDim
    b.Font=Enum.Font.GothamBold b.TextSize=13 b.ZIndex=7 b.Parent=Header
    b.MouseEnter:Connect(function() b.TextColor3=C.Text end)
    b.MouseLeave:Connect(function() b.TextColor3=C.TextDim end)
    b.MouseButton1Click:Connect(cb)
end
HBtn("-",-62,function()
    Minimized=true
    TweenService:Create(Main,TweenInfo.new(0.2),{Size=UDim2.new(0,0,0,0)}):Play()
    task.wait(0.22) Main.Visible=false Ball.Visible=true
end)
HBtn("x",-30,function()
    TweenService:Create(Main,TweenInfo.new(0.2),{Size=UDim2.new(0,0,0,0)}):Play()
    task.wait(0.22) ScreenGui:Destroy()
end)

-- Sidebar
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0,170,1,-48) Sidebar.Position = UDim2.new(0,0,0,48)
Sidebar.BackgroundColor3 = C.Sidebar Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 2 Sidebar.ScrollBarImageColor3 = C.Accent
Sidebar.CanvasSize = UDim2.new(0,0,0,0) Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
Sidebar.ZIndex = 3 Sidebar.Parent = Main
local SL = Instance.new("UIListLayout") SL.Padding = UDim.new(0,2) SL.Parent = Sidebar
local SP = Instance.new("UIPadding")
SP.PaddingTop = UDim.new(0,8) SP.PaddingLeft = UDim.new(0,6) SP.PaddingRight = UDim.new(0,6) SP.Parent = Sidebar

local SideDiv = Instance.new("Frame")
SideDiv.Size = UDim2.new(0,1,1,-48) SideDiv.Position = UDim2.new(0,170,0,48)
SideDiv.BackgroundColor3 = C.Border SideDiv.BorderSizePixel = 0 SideDiv.ZIndex = 3 SideDiv.Parent = Main

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-172,1,-48) Content.Position = UDim2.new(0,172,0,48)
Content.BackgroundTransparency = 1 Content.BorderSizePixel = 0
Content.ClipsDescendants = true Content.ZIndex = 2 Content.Parent = Main

-- Dialog
local function Dialog(config)
    local DGui = Instance.new("ScreenGui")
    DGui.ResetOnSpawn = false DGui.DisplayOrder = 9998
    pcall(function() DGui.Parent = game.CoreGui end)
    if not DGui.Parent then DGui.Parent = LP.PlayerGui end

    local BG = Instance.new("Frame")
    BG.Size = UDim2.new(1,0,1,0) BG.BackgroundColor3 = Color3.fromRGB(0,0,0)
    BG.BackgroundTransparency = 0.5 BG.BorderSizePixel = 0 BG.ZIndex = 100 BG.Parent = DGui

    local DF = Instance.new("Frame")
    DF.Size = UDim2.new(0,0,0,0) DF.Position = UDim2.new(0.5,-180,0.5,-100)
    DF.BackgroundColor3 = C.Panel DF.BorderSizePixel = 0 DF.ZIndex = 101 DF.Parent = DGui
    Instance.new("UICorner",DF).CornerRadius = UDim.new(0,10)
    local DS = Instance.new("UIStroke") DS.Color = C.Border DS.Thickness = 1.5 DS.Parent = DF
    TweenService:Create(DF,TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
        Size=UDim2.new(0,360,0,0),
        Position=UDim2.new(0.5,-180,0.5,-120)
    }):Play()
    task.wait(0.05)
    TweenService:Create(DF,TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
        Size=UDim2.new(0,360,0,220)
    }):Play()

    local DT = Instance.new("TextLabel")
    DT.Size = UDim2.new(1,-20,0,30) DT.Position = UDim2.new(0,10,0,10)
    DT.BackgroundTransparency = 1 DT.Text = config.Title or ""
    DT.TextColor3 = C.AccentLt DT.Font = Enum.Font.GothamBold DT.TextSize = 15
    DT.TextXAlignment = Enum.TextXAlignment.Left DT.ZIndex = 102 DT.Parent = DF

    local DTxt = Instance.new("TextLabel")
    DTxt.Size = UDim2.new(1,-20,0,100) DTxt.Position = UDim2.new(0,10,0,46)
    DTxt.BackgroundTransparency = 1 DTxt.Text = config.Text or ""
    DTxt.TextColor3 = C.TextDim DTxt.Font = Enum.Font.Gotham DTxt.TextSize = 12
    DTxt.TextXAlignment = Enum.TextXAlignment.Left DTxt.TextWrapped = true
    DTxt.TextYAlignment = Enum.TextYAlignment.Top DTxt.ZIndex = 102 DTxt.Parent = DF

    local BtnRow = Instance.new("Frame")
    BtnRow.Size = UDim2.new(1,-20,0,36) BtnRow.Position = UDim2.new(0,10,1,-50)
    BtnRow.BackgroundTransparency = 1 BtnRow.ZIndex = 102 BtnRow.Parent = DF
    local BRL = Instance.new("UIListLayout")
    BRL.FillDirection = Enum.FillDirection.Horizontal
    BRL.Padding = UDim.new(0,8) BRL.Parent = BtnRow

    for _,opt in ipairs(config.Options or {}) do
        local OB = Instance.new("TextButton")
        OB.Size = UDim2.new(0,100,1,0) OB.BackgroundColor3 = C.AccentDk
        OB.Text = opt[1] OB.TextColor3 = C.Text OB.Font = Enum.Font.GothamBold
        OB.TextSize = 12 OB.BorderSizePixel = 0 OB.ZIndex = 103 OB.Parent = BtnRow
        Instance.new("UICorner",OB).CornerRadius = UDim.new(0,6)
        OB.MouseButton1Click:Connect(function()
            pcall(opt[2])
            DGui:Destroy()
        end)
    end

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0,24,0,24) CloseBtn.Position = UDim2.new(1,-30,0,8)
    CloseBtn.BackgroundTransparency = 1 CloseBtn.Text = "x"
    CloseBtn.TextColor3 = C.TextDim CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 13 CloseBtn.ZIndex = 103 CloseBtn.Parent = DF
    CloseBtn.MouseButton1Click:Connect(function() DGui:Destroy() end)
end

-- Notificacao
local function Notify(config)
    local NGui = Instance.new("ScreenGui")
    NGui.ResetOnSpawn = false NGui.DisplayOrder = 9999
    pcall(function() NGui.Parent = game.CoreGui end)
    if not NGui.Parent then NGui.Parent = LP.PlayerGui end

    local NF = Instance.new("Frame")
    NF.Size = UDim2.new(0,290,0,72) NF.Position = UDim2.new(1,10,1,-90)
    NF.BackgroundColor3 = C.Notif NF.BorderSizePixel = 0 NF.ZIndex = 100 NF.Parent = NGui
    Instance.new("UICorner",NF).CornerRadius = UDim.new(0,8)
    local NS = Instance.new("UIStroke") NS.Color = C.Border NS.Thickness = 1 NS.Parent = NF

    local NBar = Instance.new("Frame")
    NBar.Size = UDim2.new(0,3,0.65,0) NBar.Position = UDim2.new(0,0,0.175,0)
    NBar.BackgroundColor3 = C.AccentLt NBar.BorderSizePixel = 0 NBar.ZIndex = 101 NBar.Parent = NF
    Instance.new("UICorner",NBar).CornerRadius = UDim.new(0,2)

    local NT = Instance.new("TextLabel")
    NT.Size = UDim2.new(1,-16,0,22) NT.Position = UDim2.new(0,12,0,8)
    NT.BackgroundTransparency = 1 NT.Text = config.Title or ""
    NT.TextColor3 = C.AccentLt NT.Font = Enum.Font.GothamBold NT.TextSize = 13
    NT.TextXAlignment = Enum.TextXAlignment.Left NT.ZIndex = 101 NT.Parent = NF

    local NC = Instance.new("TextLabel")
    NC.Size = UDim2.new(1,-16,0,32) NC.Position = UDim2.new(0,12,0,30)
    NC.BackgroundTransparency = 1 NC.Text = config.Text or config.Content or ""
    NC.TextColor3 = C.TextDim NC.Font = Enum.Font.Gotham NC.TextSize = 11
    NC.TextXAlignment = Enum.TextXAlignment.Left NC.TextWrapped = true NC.ZIndex = 101 NC.Parent = NF

    local NProg = Instance.new("Frame")
    NProg.Size = UDim2.new(1,0,0,2) NProg.Position = UDim2.new(0,0,1,-2)
    NProg.BackgroundColor3 = C.Accent NProg.BorderSizePixel = 0 NProg.ZIndex = 102 NProg.Parent = NF
    Instance.new("UICorner",NProg).CornerRadius = UDim.new(0,2)

    local dur = config.Duration or 4
    TweenService:Create(NF,TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(1,-306,1,-90)}):Play()
    TweenService:Create(NProg,TweenInfo.new(dur,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,0,2)}):Play()
    task.delay(dur,function()
        TweenService:Create(NF,TweenInfo.new(0.25),{Position=UDim2.new(1,10,1,-90)}):Play()
        task.wait(0.3) NGui:Destroy()
    end)
end

-- Helper linha divisoria
local function AddLine(parent)
    local L=Instance.new("Frame")
    L.Size=UDim2.new(1,-16,0,1) L.Position=UDim2.new(0,8,1,-1)
    L.BackgroundColor3=C.Sep L.BorderSizePixel=0 L.ZIndex=6 L.Parent=parent
end

-- ============================================================
-- WINDOW OBJECT (API compativel com redzlib)
-- ============================================================
local Window = {}

function Window:Dialog(config)
    Dialog(config)
end

function Window:Notify(config)
    Notify(config)
end

function Window:AddMinimizeButton(config)
    if config and config.Button and config.Button.Image then
        BallImg.Image = config.Button.Image
        IconImg.Image = config.Button.Image
    end
end

function Window:MakeTab(args)
    -- args = {label, iconName} ou {Translator:traduzir("label"), "iconName"}
    local label = args[1] or "Tab"

    local Tab = {}
    local Panel = Instance.new("ScrollingFrame")
    Panel.Size = UDim2.new(1,0,1,0) Panel.BackgroundTransparency = 1
    Panel.BorderSizePixel = 0 Panel.ScrollBarThickness = 3
    Panel.ScrollBarImageColor3 = C.Accent Panel.CanvasSize = UDim2.new(0,0,0,0)
    Panel.AutomaticCanvasSize = Enum.AutomaticSize.Y Panel.Visible = false
    Panel.ZIndex = 3 Panel.Parent = Content
    local ul = Instance.new("UIListLayout") ul.Padding = UDim.new(0,6) ul.Parent = Panel
    local up = Instance.new("UIPadding")
    up.PaddingTop = UDim.new(0,10) up.PaddingLeft = UDim.new(0,10)
    up.PaddingRight = UDim.new(0,10) up.PaddingBottom = UDim.new(0,10) up.Parent = Panel

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1,0,0,36) Btn.BackgroundColor3 = C.Sidebar
    Btn.BorderSizePixel = 0 Btn.Text = "" Btn.ZIndex = 4 Btn.Parent = Sidebar
    Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,7)

    local NL = Instance.new("TextLabel")
    NL.Size = UDim2.new(1,-20,1,0) NL.Position = UDim2.new(0,12,0,0)
    NL.BackgroundTransparency = 1 NL.Text = label NL.TextColor3 = C.TextDim
    NL.Font = Enum.Font.Gotham NL.TextSize = 12
    NL.TextXAlignment = Enum.TextXAlignment.Left NL.ZIndex = 5 NL.Parent = Btn

    local AL = Instance.new("TextLabel")
    AL.Size = UDim2.new(0,14,1,0) AL.Position = UDim2.new(1,-18,0,0)
    AL.BackgroundTransparency = 1 AL.Text = ">" AL.TextColor3 = C.TextDim
    AL.Font = Enum.Font.GothamBold AL.TextSize = 12 AL.ZIndex = 5 AL.Parent = Btn

    local AB = Instance.new("Frame")
    AB.Size = UDim2.new(0,3,0.6,0) AB.Position = UDim2.new(0,0,0.2,0)
    AB.BackgroundColor3 = C.AccentLt AB.BorderSizePixel = 0 AB.Visible = false AB.ZIndex = 6 AB.Parent = Btn
    Instance.new("UICorner",AB).CornerRadius = UDim.new(0,2)

    table.insert(TabButtons,{btn=Btn,bar=AB,name=NL,arrow=AL})
    table.insert(TabPanels,Panel)

    Btn.MouseEnter:Connect(function() if not Panel.Visible then Btn.BackgroundColor3 = Color3.fromRGB(28,28,32) end end)
    Btn.MouseLeave:Connect(function() if not Panel.Visible then Btn.BackgroundColor3 = C.Sidebar end end)
    Btn.MouseButton1Click:Connect(function()
        for _,p in ipairs(TabPanels) do p.Visible=false end
        for _,t in ipairs(TabButtons) do
            t.btn.BackgroundColor3=C.Sidebar t.bar.Visible=false
            t.name.TextColor3=C.TextDim t.arrow.TextColor3=C.TextDim
        end
        Panel.Visible=true Btn.BackgroundColor3=C.AccentDk AB.Visible=true
        NL.TextColor3=C.Text AL.TextColor3=C.AccentLt
    end)

    -- Se for a primeira tab, abre automaticamente
    if #TabPanels == 1 then
        Panel.Visible = true Btn.BackgroundColor3 = C.AccentDk AB.Visible = true
        NL.TextColor3 = C.Text AL.TextColor3 = C.AccentLt
    end

    -- ============================================================
    -- ELEMENTOS DO TAB
    -- ============================================================

    function Tab:AddSection(args)
        local text = type(args)=="table" and args[1] or args

        local collapsed = false
        local sectionItems = {}

        local Header2 = Instance.new("TextButton")
        Header2.Size = UDim2.new(1,0,0,26) Header2.BackgroundColor3 = C.Sep
        Header2.BorderSizePixel = 0 Header2.Text = "" Header2.ZIndex = 4 Header2.Parent = Panel
        Instance.new("UICorner",Header2).CornerRadius = UDim.new(0,5)

        local HBar = Instance.new("Frame")
        HBar.Size = UDim2.new(0,3,0.6,0) HBar.Position = UDim2.new(0,0,0.2,0)
        HBar.BackgroundColor3 = C.Accent HBar.BorderSizePixel = 0 HBar.ZIndex = 5 HBar.Parent = Header2
        Instance.new("UICorner",HBar).CornerRadius = UDim.new(0,2)

        local HL = Instance.new("TextLabel")
        HL.Size = UDim2.new(1,-30,1,0) HL.Position = UDim2.new(0,10,0,0)
        HL.BackgroundTransparency = 1 HL.Text = type(text)=="string" and text:upper() or tostring(text):upper()
        HL.TextColor3 = C.Accent HL.Font = Enum.Font.GothamBold HL.TextSize = 10
        HL.TextXAlignment = Enum.TextXAlignment.Left HL.ZIndex = 5 HL.Parent = Header2

        local Chev = Instance.new("TextLabel")
        Chev.Size = UDim2.new(0,20,1,0) Chev.Position = UDim2.new(1,-24,0,0)
        Chev.BackgroundTransparency = 1 Chev.Text = "v"
        Chev.TextColor3 = C.TextDim Chev.Font = Enum.Font.GothamBold Chev.TextSize = 10
        Chev.ZIndex = 5 Chev.Parent = Header2

        Header2.MouseButton1Click:Connect(function()
            collapsed = not collapsed Chev.Text = collapsed and ">" or "v"
            for _,f in ipairs(sectionItems) do f.Visible = not collapsed end
        end)

        return self -- retorna self para permitir Tab:AddSection():noop()
    end

    function Tab:AddToggle(config)
        local name = config.Name or config[1] or ""
        local desc = config.Description or ""
        local default = config.Default or false

        local Row = Instance.new("Frame")
        Row.Size = UDim2.new(1,0,0,46) Row.BackgroundColor3 = C.Panel
        Row.BorderSizePixel = 0 Row.ZIndex = 4 Row.Parent = Panel
        Instance.new("UICorner",Row).CornerRadius = UDim.new(0,7)
        local RS = Instance.new("UIStroke") RS.Color = C.Border RS.Thickness = 1 RS.Parent = Row
        AddLine(Row)

        local Lbl = Instance.new("TextLabel")
        Lbl.Size = UDim2.new(0.6,0,0,20) Lbl.Position = UDim2.new(0,12,0,6)
        Lbl.BackgroundTransparency = 1 Lbl.Text = name Lbl.TextColor3 = C.Text
        Lbl.Font = Enum.Font.GothamBold Lbl.TextSize = 12
        Lbl.TextXAlignment = Enum.TextXAlignment.Left Lbl.ZIndex = 5 Lbl.Parent = Row

        if desc ~= "" then
            local D = Instance.new("TextLabel")
            D.Size = UDim2.new(0.65,0,0,14) D.Position = UDim2.new(0,12,0,26)
            D.BackgroundTransparency = 1 D.Text = desc D.TextColor3 = C.TextDim
            D.Font = Enum.Font.Gotham D.TextSize = 10
            D.TextXAlignment = Enum.TextXAlignment.Left D.ZIndex = 5 D.Parent = Row
        end

        local enabled = default
        local Pill = Instance.new("Frame")
        Pill.Size = UDim2.new(0,42,0,22) Pill.Position = UDim2.new(1,-52,0.5,-11)
        Pill.BackgroundColor3 = enabled and C.TGL_ON or C.TGL_OFF
        Pill.BorderSizePixel = 0 Pill.ZIndex = 5 Pill.Parent = Row
        Instance.new("UICorner",Pill).CornerRadius = UDim.new(1,0)

        local Knob = Instance.new("Frame")
        Knob.Size = UDim2.new(0,16,0,16)
        Knob.Position = enabled and UDim2.new(0,23,0.5,-8) or UDim2.new(0,3,0.5,-8)
        Knob.BackgroundColor3 = C.White Knob.BorderSizePixel = 0 Knob.ZIndex = 6 Knob.Parent = Pill
        Instance.new("UICorner",Knob).CornerRadius = UDim.new(1,0)

        local ClickBtn = Instance.new("TextButton")
        ClickBtn.Size = UDim2.new(1,0,1,0) ClickBtn.BackgroundTransparency = 1
        ClickBtn.Text = "" ClickBtn.ZIndex = 8 ClickBtn.Parent = Row

        local callbacks = {}
        local function fireCallbacks(val)
            for _,cb in ipairs(callbacks) do pcall(cb, val) end
        end

        if config.Callback then table.insert(callbacks, config.Callback) end

        ClickBtn.MouseButton1Click:Connect(function()
            enabled = not enabled
            local ti = TweenInfo.new(0.18,Enum.EasingStyle.Quad)
            if enabled then
                TweenService:Create(Pill,ti,{BackgroundColor3=C.TGL_ON}):Play()
                TweenService:Create(Knob,ti,{Position=UDim2.new(0,23,0.5,-8)}):Play()
            else
                TweenService:Create(Pill,ti,{BackgroundColor3=C.TGL_OFF}):Play()
                TweenService:Create(Knob,ti,{Position=UDim2.new(0,3,0.5,-8)}):Play()
            end
            fireCallbacks(enabled)
        end)

        -- Objeto toggle retornado (compativel com Toggle:Callback(fn))
        local ToggleObj = {}
        function ToggleObj:Callback(fn) table.insert(callbacks, fn) end
        function ToggleObj:Set(val)
            enabled = val
            local ti = TweenInfo.new(0.18,Enum.EasingStyle.Quad)
            if enabled then
                TweenService:Create(Pill,ti,{BackgroundColor3=C.TGL_ON}):Play()
                TweenService:Create(Knob,ti,{Position=UDim2.new(0,23,0.5,-8)}):Play()
            else
                TweenService:Create(Pill,ti,{BackgroundColor3=C.TGL_OFF}):Play()
                TweenService:Create(Knob,ti,{Position=UDim2.new(0,3,0.5,-8)}):Play()
            end
        end
        return ToggleObj
    end

    function Tab:AddButton(args)
        local name, cb
        if type(args) == "table" then
            if args.Name then name = args.Name cb = args.Callback
            else name = args[1] cb = args[2] end
        end
        name = name or "" cb = cb or function() end

        local Row = Instance.new("Frame")
        Row.Size = UDim2.new(1,0,0,46) Row.BackgroundColor3 = C.Panel
        Row.BorderSizePixel = 0 Row.ZIndex = 4 Row.Parent = Panel
        Instance.new("UICorner",Row).CornerRadius = UDim.new(0,7)
        local RS = Instance.new("UIStroke") RS.Color = C.Border RS.Thickness = 1 RS.Parent = Row
        AddLine(Row)

        local Lbl = Instance.new("TextLabel")
        Lbl.Size = UDim2.new(0.82,0,1,0) Lbl.Position = UDim2.new(0,12,0,0)
        Lbl.BackgroundTransparency = 1 Lbl.Text = name Lbl.TextColor3 = C.Text
        Lbl.Font = Enum.Font.GothamBold Lbl.TextSize = 12
        Lbl.TextXAlignment = Enum.TextXAlignment.Left Lbl.ZIndex = 5 Lbl.Parent = Row

        local Arr = Instance.new("TextLabel")
        Arr.Size = UDim2.new(0,16,1,0) Arr.Position = UDim2.new(1,-22,0,0)
        Arr.BackgroundTransparency = 1 Arr.Text = ">" Arr.TextColor3 = C.Accent
        Arr.Font = Enum.Font.GothamBold Arr.TextSize = 14 Arr.ZIndex = 5 Arr.Parent = Row

        local ClickBtn = Instance.new("TextButton")
        ClickBtn.Size = UDim2.new(1,0,1,0) ClickBtn.BackgroundTransparency = 1
        ClickBtn.Text = "" ClickBtn.ZIndex = 8 ClickBtn.Parent = Row

        ClickBtn.MouseButton1Click:Connect(function()
            Row.BackgroundColor3 = C.AccentDk Row.BackgroundTransparency = 0
            task.delay(0.14,function() Row.BackgroundTransparency=1 end)
            pcall(cb)
        end)

        local BtnObj = {}
        function BtnObj:Set(newName) Lbl.Text = newName end
        return BtnObj
    end

    function Tab:AddTextBox(config)
        local title = config.Title or config.Name or ""
        local desc = config.Description or ""
        local default = config.Default or ""
        local placeholder = config.PlaceholderText or ""
        local cb = config.Callback or function() end

        local Row = Instance.new("Frame")
        Row.Size = UDim2.new(1,0,0,desc~="" and 60 or 48) Row.BackgroundColor3 = C.Panel
        Row.BorderSizePixel = 0 Row.ZIndex = 4 Row.Parent = Panel
        Instance.new("UICorner",Row).CornerRadius = UDim.new(0,7)
        local RS = Instance.new("UIStroke") RS.Color = C.Border RS.Thickness = 1 RS.Parent = Row
        AddLine(Row)

        local Lbl = Instance.new("TextLabel")
        Lbl.Size = UDim2.new(1,-12,0,18) Lbl.Position = UDim2.new(0,12,0,6)
        Lbl.BackgroundTransparency = 1 Lbl.Text = title Lbl.TextColor3 = C.Text
        Lbl.Font = Enum.Font.GothamBold Lbl.TextSize = 12
        Lbl.TextXAlignment = Enum.TextXAlignment.Left Lbl.ZIndex = 5 Lbl.Parent = Row

        local Box = Instance.new("TextBox")
        Box.Size = UDim2.new(0.7,0,0,24) Box.Position = UDim2.new(0,12,0,desc~="" and 32 or 22)
        Box.BackgroundColor3 = C.AccentDk Box.PlaceholderText = placeholder
        Box.PlaceholderColor3 = C.TextDim Box.Text = default
        Box.TextColor3 = C.Text Box.Font = Enum.Font.Gotham Box.TextSize = 11
        Box.BorderSizePixel = 0 Box.ZIndex = 5 Box.Parent = Row
        Instance.new("UICorner",Box).CornerRadius = UDim.new(0,5)

        local OkBtn = Instance.new("TextButton")
        OkBtn.Size = UDim2.new(0.24,0,0,24) OkBtn.Position = UDim2.new(0.74,0,0,desc~="" and 32 or 22)
        OkBtn.BackgroundColor3 = C.Accent OkBtn.Text = "OK" OkBtn.TextColor3 = C.White
        OkBtn.Font = Enum.Font.GothamBold OkBtn.TextSize = 11
        OkBtn.BorderSizePixel = 0 OkBtn.ZIndex = 5 OkBtn.Parent = Row
        Instance.new("UICorner",OkBtn).CornerRadius = UDim.new(0,5)
        OkBtn.MouseButton1Click:Connect(function() pcall(cb, Box.Text) end)
        Box.FocusLost:Connect(function(enter) if enter then pcall(cb, Box.Text) end end)

        local TBObj = {}
        function TBObj:Set(val) Box.Text = val end
        function TBObj:Get() return Box.Text end
        return TBObj
    end

    function Tab:AddSlider(config)
        local name = config.Name or ""
        local min = config.Min or 0
        local max = config.Max or 100
        local default = config.Default or min
        local increment = config.Increase or config.Increment or 1
        local cb = config.Callback or function() end
        local value = default

        local Row = Instance.new("Frame")
        Row.Size = UDim2.new(1,0,0,52) Row.BackgroundColor3 = C.Panel
        Row.BorderSizePixel = 0 Row.ZIndex = 4 Row.Parent = Panel
        Instance.new("UICorner",Row).CornerRadius = UDim.new(0,7)
        local RS = Instance.new("UIStroke") RS.Color = C.Border RS.Thickness = 1 RS.Parent = Row
        AddLine(Row)

        local Lbl = Instance.new("TextLabel")
        Lbl.Size = UDim2.new(1,-12,0,18) Lbl.Position = UDim2.new(0,12,0,6)
        Lbl.BackgroundTransparency = 1 Lbl.Text = name..":  "..tostring(default)
        Lbl.TextColor3 = C.Text Lbl.Font = Enum.Font.Gotham Lbl.TextSize = 11
        Lbl.TextXAlignment = Enum.TextXAlignment.Left Lbl.ZIndex = 5 Lbl.Parent = Row

        local Track = Instance.new("Frame")
        Track.Size = UDim2.new(1,-24,0,5) Track.Position = UDim2.new(0,12,0,34)
        Track.BackgroundColor3 = C.AccentDk Track.BorderSizePixel = 0 Track.ZIndex = 5 Track.Parent = Row
        Instance.new("UICorner",Track).CornerRadius = UDim.new(1,0)

        local Fill = Instance.new("Frame")
        Fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
        Fill.BackgroundColor3 = C.AccentLt Fill.BorderSizePixel = 0 Fill.ZIndex = 6 Fill.Parent = Track
        Instance.new("UICorner",Fill).CornerRadius = UDim.new(1,0)

        local Knob = Instance.new("TextButton")
        Knob.Size = UDim2.new(0,12,0,12) Knob.Position = UDim2.new((default-min)/(max-min),-6,0.5,-6)
        Knob.BackgroundColor3 = C.White Knob.Text = "" Knob.BorderSizePixel = 0 Knob.ZIndex = 7 Knob.Parent = Track
        Instance.new("UICorner",Knob).CornerRadius = UDim.new(1,0)

        local drag = false
        Knob.MouseButton1Down:Connect(function() drag=true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
        UserInputService.InputChanged:Connect(function(i)
            if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
                local p=math.clamp((i.Position.X-Track.AbsolutePosition.X)/Track.AbsoluteSize.X,0,1)
                value=math.floor((min+(max-min)*p)/increment)*increment
                value=math.clamp(value,min,max)
                Fill.Size=UDim2.new(p,0,1,0) Knob.Position=UDim2.new(p,-6,0.5,-6)
                Lbl.Text=name..":  "..tostring(value) pcall(cb,value)
            end
        end)

        local SlObj = {}
        function SlObj:Set(val)
            value=val local p=(val-min)/(max-min)
            Fill.Size=UDim2.new(p,0,1,0) Knob.Position=UDim2.new(p,-6,0.5,-6)
            Lbl.Text=name..":  "..tostring(val)
        end
        return SlObj
    end

    function Tab:AddParagraph(args)
        local text = type(args)=="table" and args[1] or args

        local Row = Instance.new("Frame")
        Row.Size = UDim2.new(1,0,0,36) Row.BackgroundColor3 = C.Panel
        Row.BorderSizePixel = 0 Row.ZIndex = 4 Row.Parent = Panel
        Instance.new("UICorner",Row).CornerRadius = UDim.new(0,7)
        local RS = Instance.new("UIStroke") RS.Color = C.Border RS.Thickness = 1 RS.Parent = Row

        local Lbl = Instance.new("TextLabel")
        Lbl.Size = UDim2.new(1,-16,1,0) Lbl.Position = UDim2.new(0,12,0,0)
        Lbl.BackgroundTransparency = 1 Lbl.Text = type(text)=="string" and text or tostring(text)
        Lbl.TextColor3 = C.TextDim Lbl.Font = Enum.Font.Gotham Lbl.TextSize = 11
        Lbl.TextXAlignment = Enum.TextXAlignment.Left Lbl.TextWrapped = true Lbl.ZIndex = 5 Lbl.Parent = Row

        local PObj = {}
        function PObj:Set(val) Lbl.Text = tostring(val) end
        return PObj
    end

    function Tab:AddDiscordInvite(config)
        local Row = Instance.new("Frame")
        Row.Size = UDim2.new(1,0,0,52) Row.BackgroundColor3 = C.Panel
        Row.BorderSizePixel = 0 Row.ZIndex = 4 Row.Parent = Panel
        Instance.new("UICorner",Row).CornerRadius = UDim.new(0,7)
        local RS = Instance.new("UIStroke") RS.Color = C.Border RS.Thickness = 1 RS.Parent = Row

        local Lbl = Instance.new("TextLabel")
        Lbl.Size = UDim2.new(1,-12,0,22) Lbl.Position = UDim2.new(0,12,0,6)
        Lbl.BackgroundTransparency = 1 Lbl.Text = config.Name or "Discord"
        Lbl.TextColor3 = C.Text Lbl.Font = Enum.Font.GothamBold Lbl.TextSize = 12
        Lbl.TextXAlignment = Enum.TextXAlignment.Left Lbl.ZIndex = 5 Lbl.Parent = Row

        local Desc = Instance.new("TextLabel")
        Desc.Size = UDim2.new(1,-12,0,18) Desc.Position = UDim2.new(0,12,0,28)
        Desc.BackgroundTransparency = 1 Desc.Text = config.Description or ""
        Desc.TextColor3 = C.TextDim Desc.Font = Enum.Font.Gotham Desc.TextSize = 10
        Desc.TextXAlignment = Enum.TextXAlignment.Left Desc.TextWrapped = true Desc.ZIndex = 5 Desc.Parent = Row
    end

    function Tab:AddDropdown(config)
        local name = config.Name or ""
        local options = config.Options or {}
        local default = config.Default or (options[1] or "")
        local cb = config.Callback or function() end
        local selected = default
        local open = false

        local Row = Instance.new("Frame")
        Row.Size = UDim2.new(1,0,0,46) Row.BackgroundColor3 = C.Panel
        Row.BorderSizePixel = 0 Row.ZIndex = 4 Row.Parent = Panel
        Instance.new("UICorner",Row).CornerRadius = UDim.new(0,7)
        local RS = Instance.new("UIStroke") RS.Color = C.Border RS.Thickness = 1 RS.Parent = Row
        AddLine(Row)

        local Lbl = Instance.new("TextLabel")
        Lbl.Size = UDim2.new(0.4,0,0,20) Lbl.Position = UDim2.new(0,12,0.5,-10)
        Lbl.BackgroundTransparency = 1 Lbl.Text = name Lbl.TextColor3 = C.Text
        Lbl.Font = Enum.Font.GothamBold Lbl.TextSize = 12
        Lbl.TextXAlignment = Enum.TextXAlignment.Left Lbl.ZIndex = 5 Lbl.Parent = Row

        local DropBtn = Instance.new("TextButton")
        DropBtn.Size = UDim2.new(0.52,0,0,28) DropBtn.Position = UDim2.new(0.46,0,0.5,-14)
        DropBtn.BackgroundColor3 = C.AccentDk DropBtn.Text = selected.." v"
        DropBtn.TextColor3 = C.Text DropBtn.Font = Enum.Font.Gotham DropBtn.TextSize = 11
        DropBtn.BorderSizePixel = 0 DropBtn.ZIndex = 5 DropBtn.Parent = Row
        Instance.new("UICorner",DropBtn).CornerRadius = UDim.new(0,5)

        local DropMenu = Instance.new("Frame")
        DropMenu.Size = UDim2.new(0.52,0,0,#options*32) DropMenu.Position = UDim2.new(0.46,0,1,2)
        DropMenu.BackgroundColor3 = C.Panel DropMenu.BorderSizePixel = 0
        DropMenu.ZIndex = 20 DropMenu.Visible = false DropMenu.Parent = Row
        Instance.new("UICorner",DropMenu).CornerRadius = UDim.new(0,6)
        local DMS = Instance.new("UIStroke") DMS.Color = C.Border DMS.Thickness = 1 DMS.Parent = DropMenu
        local DML = Instance.new("UIListLayout") DML.Padding = UDim.new(0,0) DML.Parent = DropMenu

        for _,opt in ipairs(options) do
            local OB = Instance.new("TextButton")
            OB.Size = UDim2.new(1,0,0,32) OB.BackgroundTransparency = 1
            OB.Text = opt OB.TextColor3 = C.TextDim OB.Font = Enum.Font.Gotham
            OB.TextSize = 11 OB.ZIndex = 21 OB.Parent = DropMenu
            OB.MouseEnter:Connect(function() OB.TextColor3=C.Text OB.BackgroundColor3=C.AccentDk OB.BackgroundTransparency=0 end)
            OB.MouseLeave:Connect(function() OB.TextColor3=C.TextDim OB.BackgroundTransparency=1 end)
            OB.MouseButton1Click:Connect(function()
                selected=opt DropBtn.Text=opt.." v"
                open=false DropMenu.Visible=false pcall(cb,opt)
            end)
        end

        DropBtn.MouseButton1Click:Connect(function()
            open=not open DropMenu.Visible=open
            DropBtn.Text=selected..(open and " ^" or " v")
        end)

        local DDObj = {}
        function DDObj:Set(val) selected=val DropBtn.Text=val.." v" end
        return DDObj
    end

    return Tab
end

-- Wrapper Window
function LyonLib:MakeWindow(config)
    if config and config.Title then TitleLbl.Text = config.Title end
    return Window
end

-- Permite chamar Dialog diretamente no Window
Window.Dialog = function(self, config) Dialog(config) end
Window.Notify = function(self, config) Notify(config) end

return LyonLib
