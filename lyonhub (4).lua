-- LYON HUB | Brookhaven | Rayfield UI | Delta Executor
-- Baseado no Drip Client Open Source

local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- TELA DE LOADING
local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.DisplayOrder = 9999
pcall(function() sg.Parent = game.CoreGui end)
if not sg.Parent then sg.Parent = LP.PlayerGui end

local frame = Instance.new("Frame")
frame.Size = UDim2.new(1,0,1,0)
frame.BackgroundColor3 = Color3.fromRGB(18,18,20)
frame.BorderSizePixel = 0
frame.Parent = sg

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1,0,0,40)
logo.Position = UDim2.new(0,0,0.5,-50)
logo.BackgroundTransparency = 1
logo.Text = "LYON HUB"
logo.TextColor3 = Color3.fromRGB(180,180,195)
logo.Font = Enum.Font.GothamBold
logo.TextSize = 28
logo.Parent = frame

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1,0,0,24)
sub.Position = UDim2.new(0,0,0.5,10)
sub.BackgroundTransparency = 1
sub.Text = "Carregando 1."
sub.TextColor3 = Color3.fromRGB(100,100,115)
sub.Font = Enum.Font.Gotham
sub.TextSize = 14
sub.Parent = frame

local ver = Instance.new("TextLabel")
ver.Size = UDim2.new(1,0,0,20)
ver.Position = UDim2.new(0,0,1,-30)
ver.BackgroundTransparency = 1
ver.Text = "v1.0 | Brookhaven RP"
ver.TextColor3 = Color3.fromRGB(60,60,70)
ver.Font = Enum.Font.Gotham
ver.TextSize = 11
ver.Parent = frame

local running = true
task.spawn(function()
    local dots = {
        "Carregando 1.",
        "Carregando 1.. 2.",
        "Carregando 1.. 2.. 3.",
        "Carregando 1.. 2.. 3.. 4.",
    }
    local i = 1
    while running do
        sub.Text = dots[i]
        i = i % #dots + 1
        task.wait(0.5)
    end
end)

-- carrega Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- fecha loading
running = false
sg:Destroy()

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera

local Character = LP.Character or LP.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

LP.CharacterAdded:Connect(function(c)
    Character = c
    RootPart = c:WaitForChild("HumanoidRootPart")
    Humanoid = c:WaitForChild("Humanoid")
end)

local function getPlayers()
    local t = {}
    for _,p in ipairs(Players:GetPlayers()) do
        if p ~= LP then table.insert(t, p.Name) end
    end
    return t
end

local function sendChat(msg)
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
        else
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
        end
    end)
end

local Window = Rayfield:CreateWindow({
    Name = "Lyon Hub",
    LoadingTitle = "Lyon Hub",
    LoadingSubtitle = "Brookhaven RP",
    Theme = "Default",
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,
    ConfigurationSaving = { Enabled = false },
    KeySystem = false,
})

-- TABS
local TabInicio     = Window:CreateTab("Inicio",      "home")
local TabProtecao   = Window:CreateTab("Protecao",    "shield")
local TabPersonagem = Window:CreateTab("Personagem",  "user")
local TabJogadores  = Window:CreateTab("Jogadores",   "users")
local TabTroll      = Window:CreateTab("Troll",       "flame")
local TabLag        = Window:CreateTab("Lag",         "zap")
local TabEsp        = Window:CreateTab("ESP",         "eye")
local TabAudio      = Window:CreateTab("Audio",       "music")
local TabRoupas     = Window:CreateTab("Roupas",      "shirt")
local TabCasa       = Window:CreateTab("Casa",        "house")
local TabCarro      = Window:CreateTab("Carro",       "car")
local TabTeleporte  = Window:CreateTab("Teleporte",   "map-pin")
local TabAdmin      = Window:CreateTab("Admin",       "terminal")
local TabConfig     = Window:CreateTab("Config",      "settings")

-- ============================================================
-- INICIO
-- ============================================================
TabInicio:CreateSection("Super Poderes")

TabInicio:CreateInput({Name="Velocidade", PlaceholderText="16", RemoveTextAfterFocusLost=false, Callback=function(v)
    local n=tonumber(v) if n and Humanoid then Humanoid.WalkSpeed=n end
end})
TabInicio:CreateInput({Name="Pulo", PlaceholderText="50", RemoveTextAfterFocusLost=false, Callback=function(v)
    local n=tonumber(v) if n and Humanoid then Humanoid.JumpPower=n end
end})
TabInicio:CreateInput({Name="Gravidade", PlaceholderText="196.2", RemoveTextAfterFocusLost=false, Callback=function(v)
    local n=tonumber(v) if n then workspace.Gravity=n end
end})
TabInicio:CreateButton({Name="Resetar Velocidade/Pulo/Gravidade", Callback=function()
    if Humanoid then Humanoid.WalkSpeed=16 Humanoid.JumpPower=50 end
    workspace.Gravity=196.2
end})

TabInicio:CreateSection("Status")
local fpsLabel = TabInicio:CreateLabel("FPS: --")
local frameCount, lastUpdate = 0, 0
RunService.RenderStepped:Connect(function(dt)
    frameCount+=1 lastUpdate+=dt
    if lastUpdate>=1 then fpsLabel:Set("FPS: "..frameCount) frameCount=0 lastUpdate=0 end
end)
local pcLabel = TabInicio:CreateLabel("Players: "..(#Players:GetPlayers()))
Players.PlayerAdded:Connect(function() pcLabel:Set("Players: "..(#Players:GetPlayers())) end)
Players.PlayerRemoving:Connect(function() pcLabel:Set("Players: "..(#Players:GetPlayers())) end)

TabInicio:CreateSection("RGB")
local isHairActive,isNameActive,isBioActive,rgbBody = false,false,false,false
local hairColors = {Color3.fromRGB(255,0,0),Color3.fromRGB(0,255,0),Color3.fromRGB(0,0,255),Color3.fromRGB(255,255,0),Color3.fromRGB(255,0,255),Color3.fromRGB(0,255,255)}
local bodyColors = {"Bright red","Lime green","Bright blue","Bright yellow","Bright cyan","Hot pink","Royal purple"}
TabInicio:CreateToggle({Name="Cabelo RGB", CurrentValue=false, Callback=function(v) isHairActive=v end})
TabInicio:CreateToggle({Name="Nome RGB",   CurrentValue=false, Callback=function(v) isNameActive=v end})
TabInicio:CreateToggle({Name="Bio RGB",    CurrentValue=false, Callback=function(v) isBioActive=v end})
TabInicio:CreateToggle({Name="Personagem RGB", CurrentValue=false, Callback=function(v) rgbBody=v end})
task.spawn(function()
    local iH,iN,iB,iC=1,1,1,1
    while true do
        task.wait(0.1)
        pcall(function()
            local RE=ReplicatedStorage:FindFirstChild("RE") if not RE then return end
            if isHairActive then RE:FindFirstChild("1Max1y"):FireServer("ChangeHairColor2",hairColors[iH]) iH=iH%#hairColors+1 end
            if isNameActive then RE:FindFirstChild("1RPNam1eColo1r"):FireServer("PickingRPNameColor",hairColors[iN]) iN=iN%#hairColors+1 end
            if isBioActive then RE:FindFirstChild("1RPNam1eColo1r"):FireServer("PickingRPBioColor",hairColors[iB]) iB=iB%#hairColors+1 end
            if rgbBody then ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ChangeBodyColor"):FireServer(bodyColors[iC]) iC=iC%#bodyColors+1 end
        end)
    end
end)

TabInicio:CreateSection("Repeticao de Nomes")
local name1,name2,name3,repeatNames="","","",false
TabInicio:CreateInput({Name="Nome 1", PlaceholderText="Nick aqui", RemoveTextAfterFocusLost=false, Callback=function(v) name1=v end})
TabInicio:CreateInput({Name="Nome 2", PlaceholderText="Nick aqui", RemoveTextAfterFocusLost=false, Callback=function(v) name2=v end})
TabInicio:CreateInput({Name="Nome 3", PlaceholderText="Nick aqui", RemoveTextAfterFocusLost=false, Callback=function(v) name3=v end})
TabInicio:CreateToggle({Name="Repetir Nomes", CurrentValue=false, Callback=function(v)
    repeatNames=v
    if v then task.spawn(function()
        while repeatNames do pcall(function()
            local r=ReplicatedStorage.RE:FindFirstChild("1RPNam1eTex1t")
            if r then r:FireServer("RolePlayName",name1) task.wait(1) r:FireServer("RolePlayName",name2) task.wait(1) r:FireServer("RolePlayName",name3) task.wait(1) end
        end) end
    end) end
end})
for _,n in ipairs({"TINTALEY","HACKED","Tralalero","VIGOR VIGOR VIGOR","ERESGAY"}) do
    TabInicio:CreateButton({Name="Nome: "..n, Callback=function()
        pcall(function() ReplicatedStorage.RE["1RPNam1eTex1t"]:FireServer("RolePlayName"," "..n.." ") end)
    end})
end

-- ============================================================
-- PROTECAO
-- ============================================================
TabProtecao:CreateSection("Protecoes")

local antiToolSit,antiCarSit,antiVehicleCollision=false,false,false
local dripsActive=false
local keywords={"bomb","soccer","boat"}

local function containsKW(name,list)
    if typeof(name)~="string" then return false end
    local lower=name:lower()
    for _,w in ipairs(list) do if lower:find(w) then return true end end
    return false
end

local function applyCollision(obj)
    if not obj:IsA("BasePart") then return end
    local name=obj.Name:lower()
    if name:find("wheel") then return end
    local isCar=false
    local p=obj
    while p do
        if p.Name:lower():find("wheel") then return end
        if p.Name:lower():find("car") then isCar=true break end
        p=p.Parent
    end
    if isCar then obj.CanCollide=not antiCarSit
    elseif containsKW(name,keywords) then obj.CanCollide=not antiVehicleCollision end
end

local function fullScan() for _,obj in ipairs(workspace:GetDescendants()) do applyCollision(obj) end end
local function updateSitState()
    local hum=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:SetStateEnabled(Enum.HumanoidStateType.Seated,not(antiToolSit or antiCarSit)) end
end
local function handleToggle()
    if not dripsActive then dripsActive=true fullScan() workspace.DescendantAdded:Connect(applyCollision) end
    updateSitState() fullScan()
end

TabProtecao:CreateToggle({Name="Anti Tool",   CurrentValue=false, Callback=function(v) antiToolSit=v handleToggle() end})
TabProtecao:CreateToggle({Name="Anti Car",    CurrentValue=false, Callback=function(v) antiCarSit=v handleToggle() end})
TabProtecao:CreateToggle({Name="Anti Script", CurrentValue=false, Callback=function(v) antiVehicleCollision=v handleToggle() end})

local antiBugConn
TabProtecao:CreateToggle({Name="Anti Bug", CurrentValue=false, Callback=function(v)
    if antiBugConn then antiBugConn:Disconnect() antiBugConn=nil end
    if v then antiBugConn=RunService.Stepped:Connect(function()
        local cam=workspace.CurrentCamera if not cam then return end
        for _,obj in ipairs(cam:GetChildren()) do
            if obj:IsA("BasePart") and obj.Name=="water" then pcall(function() obj:Destroy() end) end
        end
    end) end
end})

TabProtecao:CreateToggle({Name="Anti ChatSpy", CurrentValue=false, Callback=function(v)
    local cs=LP.PlayerScripts:FindFirstChild("ChatSpy") if cs then cs.Disabled=v end
end})

TabProtecao:CreateSection("Anti Lag")
TabProtecao:CreateButton({Name="Anti Lag (Remove items pesados)", Callback=function()
    local items={"Burger Tray","Bomb","Laptop","Paper Bag","Chips","Ice Cream","Taser","Basketball","FireX","Ladder","Ghost Meter","Clipboard","Stretcher","Glock","Electric Guitar","Guitar","Book","Box","Frap Strawberry","Bank Keycard","White Keycard","Mop","Iphone","Ipad"}
    local lookup={} for _,n in ipairs(items) do lookup[n]=true end
    for _,obj in ipairs(workspace:GetDescendants()) do if lookup[obj.Name] then pcall(function() obj:Destroy() end) end end
end})

TabProtecao:CreateToggle({Name="God Mode", CurrentValue=false, Callback=function(v)
    task.spawn(function() while v do if Humanoid then Humanoid.Health=Humanoid.MaxHealth end task.wait(0.1) end end)
end})
TabProtecao:CreateToggle({Name="Anti Void", CurrentValue=false, Callback=function(v)
    task.spawn(function() while v do if RootPart and RootPart.Position.Y<-100 then RootPart.CFrame=CFrame.new(0,10,0) end task.wait(0.1) end end)
end})
TabProtecao:CreateToggle({Name="Anti AFK", CurrentValue=false, Callback=function(v)
    if v then
        local vrs=Instance.new("VirtualUser") vrs.Parent=LP
        LP.Idled:Connect(function() vrs:Button2Down(Vector2.new(0,0),Camera.CFrame) task.wait(1) vrs:Button2Up(Vector2.new(0,0),Camera.CFrame) end)
    end
end})

-- ============================================================
-- PERSONAGEM
-- ============================================================
TabPersonagem:CreateSection("Movimento")

local flyActive=false
TabPersonagem:CreateToggle({Name="Fly", CurrentValue=false, Callback=function(v)
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
end})

local noclipActive=false
TabPersonagem:CreateToggle({Name="Noclip", CurrentValue=false, Callback=function(v)
    noclipActive=v
    task.spawn(function()
        while noclipActive do
            if Character then for _,p in ipairs(Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end
            task.wait()
        end
    end)
end})

local infJump=false
TabPersonagem:CreateToggle({Name="Infinite Jump", CurrentValue=false, Callback=function(v) infJump=v end})
UserInputService.JumpRequest:Connect(function() if infJump and Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end end)

TabPersonagem:CreateSection("Avatar")
TabPersonagem:CreateToggle({Name="Invisible", CurrentValue=false, Callback=function(v)
    if Character then for _,p in ipairs(Character:GetDescendants()) do
        if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then p.Transparency=v and 1 or 0 end
    end end
end})
TabPersonagem:CreateButton({Name="Gigante (5x)", Callback=function()
    if Character then local h=Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=5 h.BodyHeightScale.Value=5 h.BodyWidthScale.Value=5 h.HeadScale.Value=5 end end
end})
TabPersonagem:CreateButton({Name="Normal (1x)", Callback=function()
    if Character then local h=Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=1 h.BodyHeightScale.Value=1 h.BodyWidthScale.Value=1 h.HeadScale.Value=1 end end
end})
TabPersonagem:CreateButton({Name="Minusculo (0.3x)", Callback=function()
    if Character then local h=Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=.3 h.BodyHeightScale.Value=.3 h.BodyWidthScale.Value=.3 h.HeadScale.Value=.3 end end
end})
TabPersonagem:CreateButton({Name="Resetar Personagem", Callback=function() if Humanoid then Humanoid.Health=0 end end})

TabPersonagem:CreateSection("Basquete")
TabPersonagem:CreateToggle({Name="Arremesso de Bolas V2", CurrentValue=false, Callback=function(v)
    if v then task.spawn(function()
        local char=LP.Character if not char then return end
        local hrp=char:FindFirstChild("HumanoidRootPart") if not hrp then return end
        local clone=workspace:FindFirstChild("WorkspaceCom") and workspace.WorkspaceCom:FindFirstChild("001_GiveTools") and workspace.WorkspaceCom["001_GiveTools"]:FindFirstChild("Basketball")
        if not clone then return end
        local oldPos=hrp.CFrame
        for i=1,100 do
            task.wait()
            hrp.CFrame=clone.CFrame
            local cd=clone:FindFirstChildOfClass("ClickDetector")
            if cd then fireclickdetector(cd) end
        end
        hrp.CFrame=oldPos
    end) end
end})

TabPersonagem:CreateSection("Muro de Tools")
local wallSize=100
TabPersonagem:CreateDropdown({Name="Tamanho do Muro", Options={"100","200","300","400"}, CurrentOption="100", Callback=function(v) wallSize=tonumber(v) end})
TabPersonagem:CreateButton({Name="Criar Muro de Tools", Callback=function()
    if getgenv()._Running then return end
    getgenv()._Running=true
    task.spawn(function()
        pcall(function() ReplicatedStorage.RE:FindFirstChild("1Clea1rTool1s"):FireServer("ClearAllTools") end)
        local char=LP.Character or LP.CharacterAdded:Wait()
        local hrp=char:WaitForChild("HumanoidRootPart")
        local origPos=hrp.Position
        hrp.CFrame=CFrame.new(430,-108,100)
        task.wait(0.5)
        local cd=workspace:WaitForChild("WorkspaceCom"):WaitForChild("001_DayCare").Tools:WaitForChild("FireX"):WaitForChild("ClickDetector")
        local function countTools()
            local t=0
            for _,c in ipairs({LP.Backpack,char}) do for _,tool in ipairs(c:GetChildren()) do if tool:IsA("Tool") then t+=1 end end end
            return t
        end
        repeat fireclickdetector(cd) task.wait() until countTools()>=wallSize
        task.wait(1)
        local tools={}
        for _,c in ipairs({LP.Backpack,char}) do for _,tool in ipairs(c:GetChildren()) do if tool:IsA("Tool") then table.insert(tools,tool) end end end
        for _,tool in ipairs(char:GetChildren()) do if tool:IsA("Tool") then tool.Parent=LP.Backpack end end
        task.wait(0.2)
        local startPos=Vector3.new(0,-10,0)
        local px=Vector3.new(1.5,1.5,0)
        local w=math.floor(math.sqrt(wallSize))
        local h=math.ceil(wallSize/w)
        local idx=1
        local gripMap={}
        for y=1,h do for x=1,w do
            local tool=tools[idx] if tool then
                gripMap[tool]=CFrame.new(startPos.X+(x-1)*px.X,startPos.Y+(y-1)*px.Y,startPos.Z)
                idx+=1
            end
        end end
        hrp.CFrame=CFrame.new(origPos)
        task.wait(3)
        for tool,grip in pairs(gripMap) do tool.Grip=grip end
        task.wait(3)
        for i=1,wallSize do if tools[i] then tools[i].Parent=char end end
        getgenv()._Running=false
    end)
end})

TabPersonagem:CreateSection("Tornado de Tools")
local tornadoSize=50
TabPersonagem:CreateDropdown({Name="Tamanho do Tornado", Options={"25","50","75","100","150","200"}, CurrentOption="50", Callback=function(v) tornadoSize=tonumber(v) end})
TabPersonagem:CreateButton({Name="Criar Tornado de Tools", Callback=function()
    if getgenv()._Running then return end
    getgenv()._Running=true
    task.spawn(function()
        pcall(function() ReplicatedStorage.RE:FindFirstChild("1Clea1rTool1s"):FireServer("ClearAllTools") end)
        local char=LP.Character or LP.CharacterAdded:Wait()
        local hrp=char:WaitForChild("HumanoidRootPart")
        local origPos=hrp.Position
        hrp.CFrame=CFrame.new(430,-108,100)
        task.wait(0.5)
        local cd=workspace:WaitForChild("WorkspaceCom"):WaitForChild("001_DayCare").Tools:WaitForChild("FireX"):WaitForChild("ClickDetector")
        local function countTools()
            local t=0
            for _,c in ipairs({LP.Backpack,char}) do for _,tool in ipairs(c:GetChildren()) do if tool:IsA("Tool") then t+=1 end end end
            return t
        end
        repeat fireclickdetector(cd) task.wait() until countTools()>=tornadoSize
        task.wait(1)
        local tools={}
        for _,c in ipairs({LP.Backpack,char}) do for _,tool in ipairs(c:GetChildren()) do if tool:IsA("Tool") then table.insert(tools,tool) end end end
        for _,tool in ipairs(char:GetChildren()) do if tool:IsA("Tool") then tool.Parent=LP.Backpack end end
        task.wait(0.2)
        hrp.CFrame=CFrame.new(origPos)
        task.wait(3)
        local t=0
        for i,tool in ipairs(tools) do
            local angle=(i-1)*(2*math.pi/tornadoSize)
            local radius=5+math.floor(i/10)*2
            local height=(i-1)*0.5
            tool.Grip=CFrame.new(math.cos(angle)*radius,height,math.sin(angle)*radius)
        end
        task.wait(3)
        for _,tool in ipairs(tools) do tool.Parent=char end
        getgenv()._Running=false
    end)
end})

-- ============================================================
-- JOGADORES
-- ============================================================
TabJogadores:CreateSection("Acoes")

TabJogadores:CreateButton({Name="Listar Players", Callback=function()
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP then print("► "..p.Name) end end
end})

local tpInput=""
TabJogadores:CreateInput({Name="Teleport para player", PlaceholderText="Nome", RemoveTextAfterFocusLost=false, Callback=function(v) tpInput=v end})
TabJogadores:CreateButton({Name="Teleportar", Callback=function()
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Name:lower():find(tpInput:lower()) then
            local c=p.Character if c then
                local r=c:FindFirstChild("HumanoidRootPart")
                if r and RootPart then RootPart.CFrame=r.CFrame+Vector3.new(2,0,0) end
            end
        end
    end
end})

local hsInput=""
TabJogadores:CreateInput({Name="Head Sit (nome)", PlaceholderText="Nome", RemoveTextAfterFocusLost=false, Callback=function(v) hsInput=v end})
TabJogadores:CreateButton({Name="Sentar na cabeca", Callback=function()
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Name:lower():find(hsInput:lower()) then
            local c=p.Character if c then
                local head=c:FindFirstChild("Head")
                if head and RootPart then
                    RootPart.CFrame=CFrame.new(head.Position+Vector3.new(0,2,0))
                    local w=Instance.new("WeldConstraint") w.Part0=RootPart w.Part1=head w.Parent=RootPart
                end
            end
        end
    end
end})

TabJogadores:CreateSection("Visualizar")
local viewTarget=""
TabJogadores:CreateInput({Name="Ver jogador (nome)", PlaceholderText="Nome", RemoveTextAfterFocusLost=false, Callback=function(v) viewTarget=v end})
TabJogadores:CreateToggle({Name="Visualizar Jogador", CurrentValue=false, Callback=function(v)
    task.spawn(function()
        while v do
            for _,p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Name:lower():find(viewTarget:lower()) and p.Character then
                    local hum=p.Character:FindFirstChild("Humanoid")
                    if hum then Camera.CameraSubject=hum end
                end
            end
            task.wait(0.5)
        end
        if LP.Character then
            local hum=LP.Character:FindFirstChild("Humanoid")
            if hum then Camera.CameraSubject=hum end
        end
    end)
end})

-- ============================================================
-- TROLL
-- ============================================================
TabTroll:CreateSection("Chat")

local spamActive,spamText=false,"lyon hub"
TabTroll:CreateInput({Name="Texto do Spam", PlaceholderText="lyon hub", RemoveTextAfterFocusLost=false, Callback=function(v) spamText=v~="" and v or "lyon hub" end})
TabTroll:CreateToggle({Name="Spam Chat", CurrentValue=false, Callback=function(v)
    spamActive=v
    if v then task.spawn(function()
        while spamActive do sendChat(spamText) task.wait(1.2) end
    end) end
end})

TabTroll:CreateSection("Mensagens Prontas")
for _,msg in ipairs({"c00lkidd invaded","Tubers93 invaded","Server Hacked","Vou trava geral","Lyon Hub e o melhor"}) do
    TabTroll:CreateButton({Name=msg, Callback=function()
        sendChat("hi"..string.rep("\r",100)..msg)
    end})
end

TabTroll:CreateSection("Players")
TabTroll:CreateButton({Name="Kill All", Callback=function()
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then
        local h=p.Character:FindFirstChild("Humanoid") if h then h.Health=0 end
    end end
end})
TabTroll:CreateButton({Name="Bring All", Callback=function()
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then
        local r=p.Character:FindFirstChild("HumanoidRootPart")
        if r and RootPart then r.CFrame=RootPart.CFrame+Vector3.new(math.random(-3,3),0,math.random(-3,3)) end
    end end
end})
TabTroll:CreateButton({Name="Flood Jump", Callback=function()
    task.spawn(function() for i=1,20 do if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end task.wait(0.1) end end)
end})

TabTroll:CreateSection("Estruturas")
TabTroll:CreateButton({Name="Criar Factory na praca", Callback=function()
    pcall(function()
        if RootPart then RootPart.CFrame=CFrame.new(-37,19,-145) end
        task.wait(0.5)
        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Lot:Claim"):InvokeServer(6)
        task.wait(0.3)
        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Lot:BuildProperty"):FireServer(6,"001_Landmark")
    end)
end})

TabTroll:CreateSection("Bug Players")
local fireLoopActive=false
TabTroll:CreateToggle({Name="Bug Players (Shinra Tensei)", CurrentValue=false, Callback=function(v)
    fireLoopActive=v
    if v then task.spawn(function()
        pcall(function()
            local toolArgs={"PickingTools","Assault"}
            ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer(unpack(toolArgs))
            repeat task.wait(0.1) until LP.Backpack:FindFirstChild("Assault") and LP.Backpack.Assault:FindFirstChild("GunScript_Local")
            local gs=LP.Backpack.Assault.GunScript_Local
            local muzzle=gs:FindFirstChild("MuzzleEffect")
            local hit=gs:FindFirstChild("HitEffect")
            while fireLoopActive do
                for _,alvo in ipairs(Players:GetPlayers()) do
                    if alvo~=LP and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp=alvo.Character.HumanoidRootPart
                        local args={hrp,hrp,Vector3.new(1e8,1e8,1e8),hrp.Position,muzzle,hit,0,0,{false},{25,Vector3.new(100,100,100),BrickColor.new(29),0.25,Enum.Material.SmoothPlastic,0.25},true,false}
                        pcall(function() ReplicatedStorage.RE:FindFirstChild("1Gu1n"):FireServer(unpack(args)) end)
                        task.wait(0.001)
                    end
                end
            end
        end)
    end) end
end})

TabTroll:CreateSection("Pirralho")
local chasingPlayer=""
TabTroll:CreateInput({Name="Player alvo (pirralho)", PlaceholderText="Nome", RemoveTextAfterFocusLost=false, Callback=function(v) chasingPlayer=v end})
TabTroll:CreateButton({Name="Enviar Pirralho", Callback=function()
    pcall(function()
        local targetChar=workspace:FindFirstChild(chasingPlayer) if not targetChar then return end
        ReplicatedStorage.RE:FindFirstChild("1Bab1yFollo1w"):FireServer("CharacterFollowSpawnPlayer","BabyBoy")
        task.wait(0.3)
        local pirralho=workspace[LP.Name] and workspace[LP.Name]:FindFirstChild("FollowCharacter")
        local parteAlvo=targetChar:FindFirstChild("HumanoidRootPart")
        if pirralho and parteAlvo then
            pirralho.Parent=targetChar
            RunService.Heartbeat:Connect(function()
                if pirralho and pirralho:FindFirstChild("Torso") then
                    pirralho.Torso.BodyPosition.Position=parteAlvo.Position
                    pirralho.Torso.BodyGyro.CFrame=parteAlvo.CFrame
                end
            end)
        end
    end)
end})

-- ============================================================
-- LAG
-- ============================================================
TabLag:CreateSection("Spam de Jatos")

local JetSystem={spawnActive=false,originalPosition=nil,teleportPosition=CFrame.new(488,–20,234),destinations={CFrame.new(-29,3,-9),CFrame.new(14,3,2),CFrame.new(16,3,38),CFrame.new(-23,3,60),CFrame.new(-46,3,36)}}

local function getJetComponents()
    local airport=workspace:FindFirstChild("WorkspaceCom") if not airport then return nil,nil end
    airport=airport:FindFirstChild("001_Airport") if not airport then return nil,nil end
    local hanger=airport:FindFirstChild("AirportHanger") if not hanger then return nil,nil end
    local buttonPart=hanger:FindFirstChild("001_JetCloneButton")
    local storage=hanger:FindFirstChild("001_JetStorage")
    if not buttonPart or not storage then return nil,nil end
    local button=buttonPart:FindFirstChild("Button") if not button then return nil,nil end
    local detector=button:FindFirstChild("ClickDetector")
    return detector,storage
end

local function findNewJet(usedJets,storage)
    for _,jet in ipairs(storage:GetChildren()) do
        if jet:IsA("Model") and jet:FindFirstChild("NoUse") and not table.find(usedJets,jet) then return jet end
    end
    return nil
end

TabLag:CreateButton({Name="Iniciar Spam de Jatos", Callback=function()
    if JetSystem.spawnActive then return end
    local hrp=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") if not hrp then return end
    local detector,storage=getJetComponents() if not detector or not storage then return end
    JetSystem.originalPosition=hrp.CFrame
    hrp.CFrame=JetSystem.teleportPosition
    JetSystem.spawnActive=true
    task.spawn(function()
        local usedJets={} local destIdx=1
        while JetSystem.spawnActive do
            pcall(function() fireclickdetector(detector) end)
            task.wait(0.5)
            local jet=findNewJet(usedJets,storage)
            if jet then
                local height=(#usedJets+1)*6
                local base=JetSystem.destinations[destIdx] or JetSystem.destinations[1]
                local target=base+Vector3.new(0,height,0)
                local pp=jet:FindFirstChild("NoUse") or jet:FindFirstChildWhichIsA("BasePart")
                if pp then jet.PrimaryPart=pp jet:SetPrimaryPartCFrame(CFrame.new(target)) table.insert(usedJets,jet) end
            end
            destIdx=destIdx%#JetSystem.destinations+1
            task.wait(0.5)
        end
    end)
end})

TabLag:CreateButton({Name="Parar Spam de Jatos", Callback=function()
    JetSystem.spawnActive=false
    local hrp=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp and JetSystem.originalPosition then hrp.CFrame=JetSystem.originalPosition end
end})

TabLag:CreateSection("Spam Jatos em Jogador")
local jetTarget=""
TabLag:CreateInput({Name="Player alvo (jatos)", PlaceholderText="Nome", RemoveTextAfterFocusLost=false, Callback=function(v) jetTarget=v end})
local targetJetActive=false
TabLag:CreateToggle({Name="Auto Spam Jatos no Player", CurrentValue=false, Callback=function(v)
    targetJetActive=v
    if v then task.spawn(function()
        local hrp=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") if not hrp then return end
        local detector,storage=getJetComponents() if not detector or not storage then return end
        hrp.CFrame=JetSystem.teleportPosition
        local usedJets={}
        while targetJetActive do
            pcall(function() fireclickdetector(detector) end)
            task.wait(0.5)
            local jet=findNewJet(usedJets,storage)
            local tp=Players:FindFirstChild(jetTarget)
            if jet and tp and tp.Character then
                local tHrp=tp.Character:FindFirstChild("HumanoidRootPart")
                if tHrp then
                    local pp=jet:FindFirstChild("NoUse") or jet:FindFirstChildWhichIsA("BasePart")
                    if pp then
                        jet.PrimaryPart=pp
                        local offset=Vector3.new(math.random(-3,3),math.random(4,8),math.random(-3,3))
                        jet:SetPrimaryPartCFrame(CFrame.new(tHrp.Position+offset))
                        table.insert(usedJets,jet)
                    end
                end
            end
            task.wait(0.5)
        end
    end) end
end})

TabLag:CreateSection("Navio Pirata")
TabLag:CreateButton({Name="Invocar Navio Pirata", Callback=function()
    pcall(function()
        if RootPart then RootPart.CFrame=CFrame.new(1754,-2,58) end
        task.wait(0.5)
        local re=ReplicatedStorage:WaitForChild("RE")
        re:FindFirstChild("1Ca1r"):FireServer("PickingBoat","PirateFree")
        task.wait(1)
        local sound=Instance.new("Sound")
        sound.SoundId="rbxassetid://9068077052"
        sound.Volume=1
        if RootPart then sound.Parent=RootPart sound:Play() end
    end)
end})

-- ============================================================
-- ESP
-- ============================================================
TabEsp:CreateSection("ESP Players")

local ESPSystem={showLine=false,showName=false,showDistance=false,showHealth=false,drawings={}}

local function clearESP()
    for _,d in pairs(ESPSystem.drawings) do if d and d.Remove then d:Remove() end end
    ESPSystem.drawings={}
end

local function createESP(player)
    if player==LP then return end
    local c=player.Character if not c then return end
    local head=c:FindFirstChild("Head") if not head then return end
    local pos,onScreen=Camera:WorldToViewportPoint(head.Position)
    if not onScreen then return end
    local center=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y)
    if ESPSystem.showLine then
        local l=Drawing.new("Line") l.From=center l.To=Vector2.new(pos.X,pos.Y)
        l.Color=Color3.new(1,1,1) l.Thickness=2 l.Transparency=1 l.Visible=true
        table.insert(ESPSystem.drawings,l)
    end
    if ESPSystem.showName then
        local t=Drawing.new("Text") t.Text=player.DisplayName t.Position=Vector2.new(pos.X,pos.Y-25)
        t.Color=Color3.fromRGB(255,255,255) t.Center=true t.Size=18 t.Outline=true t.Visible=true
        table.insert(ESPSystem.drawings,t)
    end
    if ESPSystem.showDistance then
        local dist=math.floor((Camera.CFrame.Position-head.Position).Magnitude)
        local d=Drawing.new("Text") d.Text=dist.."m" d.Position=Vector2.new(pos.X,pos.Y+25)
        d.Color=Color3.fromRGB(0,255,255) d.Center=true d.Size=16 d.Outline=true d.Visible=true
        table.insert(ESPSystem.drawings,d)
    end
    if ESPSystem.showHealth then
        local hum=c:FindFirstChild("Humanoid")
        local hp=hum and (hum.Health/hum.MaxHealth) or 1
        local hb=Drawing.new("Square") hb.Size=Vector2.new(4,35) hb.Position=Vector2.new(pos.X-30,pos.Y-17.5)
        hb.Color=Color3.fromRGB(math.floor((1-hp)*255),math.floor(hp*255),0) hb.Filled=true hb.Transparency=1 hb.Visible=true
        table.insert(ESPSystem.drawings,hb)
    end
end

RunService.RenderStepped:Connect(function()
    clearESP()
    for _,p in ipairs(Players:GetPlayers()) do if p.Character then createESP(p) end end
end)

TabEsp:CreateToggle({Name="Linhas ESP",    CurrentValue=false, Callback=function(v) ESPSystem.showLine=v end})
TabEsp:CreateToggle({Name="Nomes ESP",     CurrentValue=false, Callback=function(v) ESPSystem.showName=v end})
TabEsp:CreateToggle({Name="Distancia ESP", CurrentValue=false, Callback=function(v) ESPSystem.showDistance=v end})
TabEsp:CreateToggle({Name="Vida ESP",      CurrentValue=false, Callback=function(v) ESPSystem.showHealth=v end})

-- ============================================================
-- AUDIO
-- ============================================================
TabAudio:CreateSection("Musica")
local musicInput=""
TabAudio:CreateInput({Name="ID da Musica", PlaceholderText="ex: 1234567", RemoveTextAfterFocusLost=false, Callback=function(v) musicInput=v end})
TabAudio:CreateButton({Name="Tocar", Callback=function()
    if musicInput~="" then
        local s=Instance.new("Sound") s.SoundId="rbxassetid://"..musicInput s.Volume=0.5 s.Parent=workspace s:Play()
    end
end})
TabAudio:CreateButton({Name="Parar Todas", Callback=function()
    for _,s in ipairs(workspace:GetDescendants()) do if s:IsA("Sound") then s:Stop() end end
end})
TabAudio:CreateSection("Musicas Prontas")
for _,m in ipairs({{n="Phonk",id="1845288678"},{n="Funk BR",id="1374269869"},{n="Trap",id="1843671350"},{n="Lo-fi",id="1372719710"},{n="Pagode",id="142376088"}}) do
    TabAudio:CreateButton({Name=m.n, Callback=function()
        for _,s in ipairs(workspace:GetDescendants()) do if s:IsA("Sound") then s:Stop() end end
        local s=Instance.new("Sound") s.SoundId="rbxassetid://"..m.id s.Volume=0.5 s.Parent=workspace s:Play()
    end})
end

-- ============================================================
-- ROUPAS
-- ============================================================
TabRoupas:CreateSection("Trocar Roupa")
local shirtInput,pantsInput="",""
TabRoupas:CreateInput({Name="ID Camisa", PlaceholderText="ex: 123456789", RemoveTextAfterFocusLost=false, Callback=function(v) shirtInput=v end})
TabRoupas:CreateInput({Name="ID Calca",  PlaceholderText="ex: 123456789", RemoveTextAfterFocusLost=false, Callback=function(v) pantsInput=v end})
TabRoupas:CreateButton({Name="Aplicar Roupa", Callback=function()
    if Character then
        local shirt=Character:FindFirstChildOfClass("Shirt") or Instance.new("Shirt",Character)
        local pants=Character:FindFirstChildOfClass("Pants") or Instance.new("Pants",Character)
        if shirtInput~="" then shirt.ShirtTemplate="rbxassetid://"..shirtInput end
        if pantsInput~="" then pants.PantsTemplate="rbxassetid://"..pantsInput end
    end
end})

-- ============================================================
-- CASA
-- ============================================================
TabCasa:CreateSection("Casa")
TabCasa:CreateButton({Name="Teleport: Minha Casa", Callback=function()
    for _,obj in ipairs(workspace:GetDescendants()) do
        if obj.Name==LP.Name and obj:IsA("Model") then
            local r=obj.PrimaryPart
            if r and RootPart then RootPart.CFrame=CFrame.new(r.Position+Vector3.new(0,3,5)) return end
        end
    end
end})

-- ============================================================
-- CARRO
-- ============================================================
TabCarro:CreateSection("Carro")
TabCarro:CreateToggle({Name="Speed Carro", CurrentValue=false, Callback=function(v)
    task.spawn(function() while v do
        for _,obj in ipairs(workspace:GetDescendants()) do if obj:IsA("VehicleSeat") then obj.MaxSpeed=200 end end
        task.wait(1)
    end end)
end})
TabCarro:CreateButton({Name="Sair do Carro", Callback=function()
    if Character then local hum=Character:FindFirstChildOfClass("Humanoid") if hum then hum.Sit=false end end
end})

-- ============================================================
-- TELEPORTE
-- ============================================================
TabTeleporte:CreateSection("Pontos do Mapa")
local tpPoints={{"Spawn",Vector3.new(0,5,0)},{"Escola",Vector3.new(120,5,80)},{"Hospital",Vector3.new(-120,5,60)},{"Policia",Vector3.new(80,5,-100)},{"Banco",Vector3.new(-80,5,-120)},{"Parque",Vector3.new(0,5,200)},{"Supermercado",Vector3.new(200,5,0)},{"Posto",Vector3.new(-200,5,0)},{"Aeroporto",Vector3.new(300,5,300)}}
for _,tp in ipairs(tpPoints) do
    TabTeleporte:CreateButton({Name=tp[1], Callback=function() if RootPart then RootPart.CFrame=CFrame.new(tp[2]) end end})
end
TabTeleporte:CreateSection("Por Player")
local tp2Input=""
TabTeleporte:CreateInput({Name="Nome do player", PlaceholderText="Nome", RemoveTextAfterFocusLost=false, Callback=function(v) tp2Input=v end})
TabTeleporte:CreateButton({Name="Teleportar", Callback=function()
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Name:lower():find(tp2Input:lower()) then
            local c=p.Character if c then
                local r=c:FindFirstChild("HumanoidRootPart")
                if r and RootPart then RootPart.CFrame=r.CFrame+Vector3.new(2,0,0) end
            end
        end
    end
end})

-- ============================================================
-- ADMIN (comandos de chat)
-- ============================================================
TabAdmin:CreateSection("Comandos por Chat")
TabAdmin:CreateLabel("Use: /kill eu | /speed 100 | /fly | /noclip | /godmode | /bring nome | /tp nome")

local function setupAdminChat()
    if TextChatService.ChatVersion==Enum.ChatVersion.TextChatService then
        local ch=TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
        ch.OnIncomingMessage=function(msg)
            local sender=msg.TextSource and Players:GetPlayerByUserId(msg.TextSource.UserId)
            if sender~=LP then return end
            local text=msg.Text:lower()
            if text:sub(1,1)~="/" then return end
            local args={}
            for w in text:gmatch("%S+") do table.insert(args,w) end
            local cmd=args[1]
            if cmd=="/kill" then if Humanoid then Humanoid.Health=0 end
            elseif cmd=="/fly" then flyActive=not flyActive
            elseif cmd=="/noclip" then noclipActive=not noclipActive
            elseif cmd=="/godmode" then
                task.spawn(function() while true do if Humanoid then Humanoid.Health=Humanoid.MaxHealth end task.wait(0.1) end end)
            elseif cmd=="/speed" then
                local n=tonumber(args[2]) if n and Humanoid then Humanoid.WalkSpeed=n end
            elseif cmd=="/bring" then
                local name=args[2] if name then
                    for _,p in ipairs(Players:GetPlayers()) do
                        if p~=LP and p.Name:lower():find(name) then
                            local r=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                            if r and RootPart then r.CFrame=RootPart.CFrame+Vector3.new(2,0,0) end
                        end
                    end
                end
            elseif cmd=="/tp" then
                local name=args[2] if name then
                    for _,p in ipairs(Players:GetPlayers()) do
                        if p~=LP and p.Name:lower():find(name) then
                            local r=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                            if r and RootPart then RootPart.CFrame=r.CFrame+Vector3.new(2,0,0) end
                        end
                    end
                end
            elseif cmd=="/killall" then
                for _,p in ipairs(Players:GetPlayers()) do
                    if p~=LP and p.Character then local h=p.Character:FindFirstChild("Humanoid") if h then h.Health=0 end end
                end
            end
        end
    end
end

pcall(setupAdminChat)

TabAdmin:CreateSection("Acoes Rapidas")
TabAdmin:CreateButton({Name="/kill eu", Callback=function() if Humanoid then Humanoid.Health=0 end end})
TabAdmin:CreateButton({Name="/killall", Callback=function()
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then local h=p.Character:FindFirstChild("Humanoid") if h then h.Health=0 end end end
end})
TabAdmin:CreateButton({Name="/bringall", Callback=function()
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then
        local r=p.Character:FindFirstChild("HumanoidRootPart")
        if r and RootPart then r.CFrame=RootPart.CFrame+Vector3.new(math.random(-3,3),0,math.random(-3,3)) end
    end end
end})

-- ============================================================
-- CONFIG
-- ============================================================
TabConfig:CreateSection("Geral")
TabConfig:CreateToggle({Name="Full Bright", CurrentValue=false, Callback=function(v)
    if v then Lighting.Brightness=2 Lighting.ClockTime=14 Lighting.GlobalShadows=false Lighting.Ambient=Color3.fromRGB(255,255,255)
    else Lighting.Brightness=1 Lighting.GlobalShadows=true Lighting.Ambient=Color3.fromRGB(100,100,100) end
end})
TabConfig:CreateButton({Name="Rejoin", Callback=function()
    game:GetService("TeleportService"):Teleport(game.PlaceId,LP)
end})
TabConfig:CreateSection("Resolucao")
local function setRes(v)
    getgenv().Resolution={[".gg/scripters"]=v}
    if not getgenv().gg_scripters then
        RunService.RenderStepped:Connect(function()
            Camera.CFrame=Camera.CFrame*CFrame.new(0,0,0,1,0,0,0,getgenv().Resolution[".gg/scripters"],0,0,0,1)
        end)
        getgenv().gg_scripters="set"
    end
end
TabConfig:CreateButton({Name="Resolucao Normal (1.0)", Callback=function() setRes(1.0) end})
TabConfig:CreateButton({Name="Resolucao 0.80", Callback=function() setRes(0.80) end})
TabConfig:CreateButton({Name="Resolucao 0.70", Callback=function() setRes(0.70) end})

Rayfield:Notify({Title="Lyon Hub",Content="Carregado com sucesso!",Duration=4,Image="check"})
print("[LyonHub] Carregado v1.0")
