-- LYON HUB | Brookhaven | Rayfield UI | Delta Executor

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
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

local Window = Rayfield:CreateWindow({
    Name = "Lyon Hub",
    LoadingTitle = "Lyon Hub",
    LoadingSubtitle = "Brookhaven RP",
    Theme = "Default",
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,
    ConfigurationSaving = {
        Enabled = false,
    },
    KeySystem = false,
})

-- ============================================================
-- TABS
-- ============================================================
local TabInicio     = Window:CreateTab("Inicio",         "home")
local TabProtecao   = Window:CreateTab("Protecao",       "shield")
local TabPersonagem = Window:CreateTab("Personagem",     "user")
local TabJogadores  = Window:CreateTab("Jogadores",      "users")
local TabTroll      = Window:CreateTab("Troll",          "flame")
local TabEsp        = Window:CreateTab("ESP",            "eye")
local TabAudio      = Window:CreateTab("Audio",          "music")
local TabRoupas     = Window:CreateTab("Roupas",         "shirt")
local TabCasa       = Window:CreateTab("Casa",           "house")
local TabCarro      = Window:CreateTab("Carro",          "car")
local TabTeleporte  = Window:CreateTab("Teleporte",      "map-pin")
local TabConfig     = Window:CreateTab("Config",         "settings")

-- ============================================================
-- INICIO
-- ============================================================

TabInicio:CreateSection("Super Poderes")

local speedVal = 16
TabInicio:CreateInput({
    Name = "Velocidade",
    PlaceholderText = "16",
    RemoveTextAfterFocusLost = false,
    Callback = function(v)
        local n = tonumber(v)
        if n then
            speedVal = n
            if Character and Character:FindFirstChild("Humanoid") then
                Character.Humanoid.WalkSpeed = n
            end
        end
    end
})

local jumpVal = 50
TabInicio:CreateInput({
    Name = "Pulo",
    PlaceholderText = "50",
    RemoveTextAfterFocusLost = false,
    Callback = function(v)
        local n = tonumber(v)
        if n then
            jumpVal = n
            if Character and Character:FindFirstChild("Humanoid") then
                Character.Humanoid.JumpPower = n
            end
        end
    end
})

local gravVal = 196.2
TabInicio:CreateInput({
    Name = "Gravidade",
    PlaceholderText = "196.2",
    RemoveTextAfterFocusLost = false,
    Callback = function(v)
        local n = tonumber(v)
        if n then
            gravVal = n
            workspace.Gravity = n
        end
    end
})

TabInicio:CreateButton({
    Name = "Resetar Velocidade/Pulo/Gravidade",
    Callback = function()
        if Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid.WalkSpeed = 16
            Character.Humanoid.JumpPower = 50
        end
        workspace.Gravity = 196.2
    end
})

TabInicio:CreateSection("Status")

local fpsLabel = TabInicio:CreateLabel("FPS: --")
local frameCount, lastUpdate = 0, 0
RunService.RenderStepped:Connect(function(dt)
    frameCount += 1
    lastUpdate += dt
    if lastUpdate >= 1 then
        fpsLabel:Set("FPS: " .. frameCount)
        frameCount = 0
        lastUpdate = 0
    end
end)

local playerCountLabel = TabInicio:CreateLabel("Players: " .. #Players:GetPlayers())
Players.PlayerAdded:Connect(function() playerCountLabel:Set("Players: " .. #Players:GetPlayers()) end)
Players.PlayerRemoving:Connect(function() playerCountLabel:Set("Players: " .. #Players:GetPlayers()) end)

TabInicio:CreateSection("RGB")

local isHairActive, isNameActive, isBioActive, rgbBody = false, false, false, false
local hairColors = {
    Color3.fromRGB(255,0,0), Color3.fromRGB(0,255,0), Color3.fromRGB(0,0,255),
    Color3.fromRGB(255,255,0), Color3.fromRGB(255,0,255), Color3.fromRGB(0,255,255)
}
local vibrantColors = hairColors
local bodyColors = {"Bright red","Lime green","Bright blue","Bright yellow","Bright cyan","Hot pink","Royal purple"}

TabInicio:CreateToggle({Name="Cabelo RGB", CurrentValue=false, Callback=function(v) isHairActive=v end})
TabInicio:CreateToggle({Name="Nome RGB",   CurrentValue=false, Callback=function(v) isNameActive=v end})
TabInicio:CreateToggle({Name="Bio RGB",    CurrentValue=false, Callback=function(v) isBioActive=v end})
TabInicio:CreateToggle({Name="Personagem RGB", CurrentValue=false, Callback=function(v) rgbBody=v end})

task.spawn(function()
    local iH, iN, iB, iC = 1,1,1,1
    while true do
        task.wait(0.1)
        pcall(function()
            local RE = ReplicatedStorage:FindFirstChild("RE")
            if not RE then return end
            if isHairActive then
                RE:FindFirstChild("1Max1y"):FireServer("ChangeHairColor2", hairColors[iH])
                iH = iH % #hairColors + 1
            end
            if isNameActive then
                RE:FindFirstChild("1RPNam1eColo1r"):FireServer("PickingRPNameColor", vibrantColors[iN])
                iN = iN % #vibrantColors + 1
            end
            if isBioActive then
                RE:FindFirstChild("1RPNam1eColo1r"):FireServer("PickingRPBioColor", vibrantColors[iB])
                iB = iB % #vibrantColors + 1
            end
            if rgbBody then
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ChangeBodyColor"):FireServer(bodyColors[iC])
                iC = iC % #bodyColors + 1
            end
        end)
    end
end)

TabInicio:CreateSection("Repeticao de Nomes")
local name1, name2, name3, repeatNames = "","","",false
TabInicio:CreateInput({Name="Nome 1", PlaceholderText="Nick aqui", RemoveTextAfterFocusLost=false, Callback=function(v) name1=v end})
TabInicio:CreateInput({Name="Nome 2", PlaceholderText="Nick aqui", RemoveTextAfterFocusLost=false, Callback=function(v) name2=v end})
TabInicio:CreateInput({Name="Nome 3", PlaceholderText="Nick aqui", RemoveTextAfterFocusLost=false, Callback=function(v) name3=v end})
TabInicio:CreateToggle({
    Name="Repetir Nomes",
    CurrentValue=false,
    Callback=function(v)
        repeatNames=v
        if v then
            task.spawn(function()
                while repeatNames do
                    pcall(function()
                        local r = ReplicatedStorage.RE:FindFirstChild("1RPNam1eTex1t")
                        if r then
                            r:FireServer("RolePlayName", name1) task.wait(1)
                            r:FireServer("RolePlayName", name2) task.wait(1)
                            r:FireServer("RolePlayName", name3) task.wait(1)
                        end
                    end)
                end
            end)
        end
    end
})

local presetNames = {"TINTALEY","HACKED","Tralalero","VIGOR VIGOR VIGOR","ERESGAY"}
for _, n in ipairs(presetNames) do
    TabInicio:CreateButton({
        Name = "Nome: " .. n,
        Callback = function()
            pcall(function()
                ReplicatedStorage.RE["1RPNam1eTex1t"]:FireServer("RolePlayName", " "..n.." ")
            end)
        end
    })
end

-- ============================================================
-- PROTECAO
-- ============================================================
TabProtecao:CreateSection("Protecoes")

local antiToolSit, antiCarSit, antiVehicleCollision = false, false, false
local conns = {}
local dripsActive = false
local keywords = {"bomb","soccer","boat"}

local function containsKW(name, list)
    if typeof(name)~="string" then return false end
    local lower = name:lower()
    for _,w in ipairs(list) do if lower:find(w) then return true end end
    return false
end

local function applyCollision(obj)
    if not obj:IsA("BasePart") then return end
    local name = obj.Name:lower()
    if name:find("wheel") then return end
    local isCar = false
    local p = obj
    while p do
        if p.Name:lower():find("wheel") then return end
        if p.Name:lower():find("car") then isCar=true break end
        p = p.Parent
    end
    if isCar then obj.CanCollide = not antiCarSit
    elseif containsKW(name, keywords) then obj.CanCollide = not antiVehicleCollision end
end

local function fullScan()
    for _,obj in ipairs(workspace:GetDescendants()) do applyCollision(obj) end
end

local function updateSitState()
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:SetStateEnabled(Enum.HumanoidStateType.Seated, not(antiToolSit or antiCarSit)) end
end

LP.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    updateSitState()
    hum.StateChanged:Connect(function(_,new)
        if (antiToolSit or antiCarSit) and new==Enum.HumanoidStateType.Seated then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end)
end)

local function handleToggle()
    if not dripsActive then
        dripsActive = true
        fullScan()
        workspace.DescendantAdded:Connect(applyCollision)
    end
    updateSitState()
    fullScan()
end

TabProtecao:CreateToggle({Name="Anti Tool", CurrentValue=false, Callback=function(v) antiToolSit=v handleToggle() end})
TabProtecao:CreateToggle({Name="Anti Car",  CurrentValue=false, Callback=function(v) antiCarSit=v handleToggle() end})
TabProtecao:CreateToggle({Name="Anti Script", CurrentValue=false, Callback=function(v) antiVehicleCollision=v handleToggle() end})

local antiBugConn
TabProtecao:CreateToggle({
    Name="Anti Bug",
    CurrentValue=false,
    Callback=function(v)
        if antiBugConn then antiBugConn:Disconnect() antiBugConn=nil end
        if v then
            antiBugConn = RunService.Stepped:Connect(function()
                local cam = workspace.CurrentCamera
                if not cam then return end
                for _,obj in ipairs(cam:GetChildren()) do
                    if obj:IsA("BasePart") and obj.Name=="water" then pcall(function() obj:Destroy() end) end
                end
            end)
        end
    end
})

TabProtecao:CreateToggle({
    Name="Anti ChatSpy",
    CurrentValue=false,
    Callback=function(v)
        local cs = LP.PlayerScripts:FindFirstChild("ChatSpy")
        if cs then cs.Disabled = v end
    end
})

TabProtecao:CreateSection("Anti Lag")
TabProtecao:CreateButton({
    Name="Anti Lag (Remove items pesados)",
    Callback=function()
        local items = {
            "Burger Tray","Bomb","Laptop","Paper Bag","Chips","Ice Cream","Taser",
            "Basketball","FireX","Ladder","Ghost Meter","Clipboard","Stretcher","Glock",
            "Electric Guitar","Guitar","Book","Box","Frap Strawberry","Bank Keycard",
            "White Keycard","Mop","Iphone","Ipad"
        }
        local lookup = {}
        for _,n in ipairs(items) do lookup[n]=true end
        for _,obj in ipairs(workspace:GetDescendants()) do
            if lookup[obj.Name] then pcall(function() obj:Destroy() end) end
        end
    end
})

TabProtecao:CreateToggle({
    Name="God Mode",
    CurrentValue=false,
    Callback=function(v)
        task.spawn(function()
            while v do
                if Humanoid then Humanoid.Health = Humanoid.MaxHealth end
                task.wait(0.1)
            end
        end)
    end
})

TabProtecao:CreateToggle({
    Name="Anti Void",
    CurrentValue=false,
    Callback=function(v)
        task.spawn(function()
            while v do
                if RootPart and RootPart.Position.Y < -100 then
                    RootPart.CFrame = CFrame.new(0,10,0)
                end
                task.wait(0.1)
            end
        end)
    end
})

TabProtecao:CreateToggle({
    Name="Anti AFK",
    CurrentValue=false,
    Callback=function(v)
        if v then
            local vrs = Instance.new("VirtualUser")
            vrs.Parent = LP
            LP.Idled:Connect(function()
                vrs:Button2Down(Vector2.new(0,0), Camera.CFrame)
                task.wait(1)
                vrs:Button2Up(Vector2.new(0,0), Camera.CFrame)
            end)
        end
    end
})

-- ============================================================
-- PERSONAGEM
-- ============================================================
TabPersonagem:CreateSection("Movimento")

TabPersonagem:CreateToggle({
    Name="Fly",
    CurrentValue=false,
    Callback=function(v)
        if v then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e5,1e5,1e5)
            bv.Velocity = Vector3.zero
            bv.Parent = RootPart
            local bg = Instance.new("BodyGyro")
            bg.MaxTorque = Vector3.new(1e5,1e5,1e5)
            bg.P = 1e4
            bg.Parent = RootPart
            task.spawn(function()
                while v do
                    local d = Vector3.zero
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then d=d+Camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then d=d-Camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then d=d-Camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then d=d+Camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then d=d+Vector3.new(0,1,0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then d=d-Vector3.new(0,1,0) end
                    bv.Velocity = d.Magnitude>0 and d.Unit*80 or Vector3.zero
                    bg.CFrame = Camera.CFrame
                    task.wait()
                end
                bv:Destroy() bg:Destroy()
            end)
        end
    end
})

TabPersonagem:CreateToggle({
    Name="Noclip",
    CurrentValue=false,
    Callback=function(v)
        task.spawn(function()
            while v do
                if Character then
                    for _,p in ipairs(Character:GetDescendants()) do
                        if p:IsA("BasePart") then p.CanCollide=false end
                    end
                end
                task.wait()
            end
        end)
    end
})

TabPersonagem:CreateToggle({
    Name="Infinite Jump",
    CurrentValue=false,
    Callback=function(v)
        UserInputService.JumpRequest:Connect(function()
            if v and Humanoid then
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
})

TabPersonagem:CreateSection("Avatar")

TabPersonagem:CreateToggle({
    Name="Invisible",
    CurrentValue=false,
    Callback=function(v)
        if Character then
            for _,p in ipairs(Character:GetDescendants()) do
                if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then
                    p.Transparency = v and 1 or 0
                end
            end
        end
    end
})

TabPersonagem:CreateButton({Name="Gigante (5x)", Callback=function()
    if Character then
        local h = Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=5 h.BodyHeightScale.Value=5 h.BodyWidthScale.Value=5 h.HeadScale.Value=5 end
    end
end})
TabPersonagem:CreateButton({Name="Normal (1x)", Callback=function()
    if Character then
        local h = Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=1 h.BodyHeightScale.Value=1 h.BodyWidthScale.Value=1 h.HeadScale.Value=1 end
    end
end})
TabPersonagem:CreateButton({Name="Minusculo (0.3x)", Callback=function()
    if Character then
        local h = Character:FindFirstChildOfClass("Humanoid")
        if h then h.BodyDepthScale.Value=.3 h.BodyHeightScale.Value=.3 h.BodyWidthScale.Value=.3 h.HeadScale.Value=.3 end
    end
end})
TabPersonagem:CreateButton({Name="Resetar Personagem", Callback=function()
    if Humanoid then Humanoid.Health=0 end
end})

-- ============================================================
-- JOGADORES
-- ============================================================
TabJogadores:CreateSection("Acoes")

TabJogadores:CreateButton({
    Name="Listar Players (console)",
    Callback=function()
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP then print("► "..p.Name) end
        end
    end
})

local tpInput = ""
TabJogadores:CreateInput({Name="Teleport para player", PlaceholderText="Nome do player", RemoveTextAfterFocusLost=false, Callback=function(v) tpInput=v end})
TabJogadores:CreateButton({
    Name="Ir",
    Callback=function()
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP and p.Name:lower():find(tpInput:lower()) then
                local c=p.Character
                if c then
                    local r=c:FindFirstChild("HumanoidRootPart")
                    if r and RootPart then RootPart.CFrame=r.CFrame+Vector3.new(2,0,0) end
                end
            end
        end
    end
})

local hsInput = ""
TabJogadores:CreateInput({Name="Head Sit", PlaceholderText="Nome do player", RemoveTextAfterFocusLost=false, Callback=function(v) hsInput=v end})
TabJogadores:CreateButton({
    Name="Sentar na cabeca",
    Callback=function()
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP and p.Name:lower():find(hsInput:lower()) then
                local c=p.Character
                if c then
                    local head=c:FindFirstChild("Head")
                    if head and RootPart then
                        RootPart.CFrame=CFrame.new(head.Position+Vector3.new(0,2,0))
                        local w=Instance.new("WeldConstraint")
                        w.Part0=RootPart w.Part1=head w.Parent=RootPart
                    end
                end
            end
        end
    end
})

-- ============================================================
-- TROLL
-- ============================================================
TabTroll:CreateSection("Chat")

local spamActive, spamText = false, "lyon hub"
TabTroll:CreateInput({Name="Texto do Spam", PlaceholderText="lyon hub", RemoveTextAfterFocusLost=false, Callback=function(v) spamText=v~="" and v or "lyon hub" end})
TabTroll:CreateToggle({
    Name="Spam Chat",
    CurrentValue=false,
    Callback=function(v)
        spamActive=v
        if v then
            task.spawn(function()
                while spamActive do
                    pcall(function()
                        if TextChatService.ChatVersion==Enum.ChatVersion.TextChatService then
                            TextChatService.TextChannels.RBXGeneral:SendAsync(spamText)
                        else
                            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(spamText,"All")
                        end
                    end)
                    task.wait(1.2)
                end
            end)
        end
    end
})

TabTroll:CreateSection("Players")
TabTroll:CreateButton({
    Name="Kill All",
    Callback=function()
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP and p.Character then
                local h=p.Character:FindFirstChild("Humanoid")
                if h then h.Health=0 end
            end
        end
    end
})
TabTroll:CreateButton({
    Name="Bring All",
    Callback=function()
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP and p.Character then
                local r=p.Character:FindFirstChild("HumanoidRootPart")
                if r and RootPart then
                    r.CFrame=RootPart.CFrame+Vector3.new(math.random(-3,3),0,math.random(-3,3))
                end
            end
        end
    end
})
TabTroll:CreateButton({
    Name="Flood Jump",
    Callback=function()
        task.spawn(function()
            for i=1,20 do
                if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
                task.wait(0.1)
            end
        end)
    end
})

TabTroll:CreateSection("Mensagens Prontas")
local msgs = {
    "c00lkidd invaded",
    "Tubers93 invaded",
    "Server Hacked",
    "Vou trava geral",
    "Lyon Hub e o melhor"
}
for _,msg in ipairs(msgs) do
    TabTroll:CreateButton({
        Name=msg,
        Callback=function()
            pcall(function()
                if TextChatService.ChatVersion==Enum.ChatVersion.TextChatService then
                    TextChatService.TextChannels.RBXGeneral:SendAsync("hi"..string.rep("\r",100)..msg)
                end
            end)
        end
    })
end

-- ============================================================
-- ESP (Drawing API)
-- ============================================================
TabEsp:CreateSection("ESP Players")

local ESPSystem = {
    showLine=false, showName=false, showDistance=false, showHealth=false,
    drawings={}
}

local function clearESP()
    for _,d in pairs(ESPSystem.drawings) do if d and d.Remove then d:Remove() end end
    ESPSystem.drawings={}
end

local function createESP(player)
    if player==LP then return end
    local c=player.Character
    if not c then return end
    local head=c:FindFirstChild("Head")
    if not head then return end
    local pos,onScreen=Camera:WorldToViewportPoint(head.Position)
    if not onScreen then return end
    local center=Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)

    if ESPSystem.showLine then
        local l=Drawing.new("Line")
        l.From=center l.To=Vector2.new(pos.X,pos.Y)
        l.Color=Color3.new(1,1,1) l.Thickness=2 l.Transparency=1 l.Visible=true
        table.insert(ESPSystem.drawings,l)
    end
    if ESPSystem.showName then
        local t=Drawing.new("Text")
        t.Text=player.DisplayName t.Position=Vector2.new(pos.X,pos.Y-25)
        t.Color=Color3.fromRGB(255,255,255) t.Center=true t.Size=18 t.Outline=true t.Visible=true
        table.insert(ESPSystem.drawings,t)
    end
    if ESPSystem.showDistance then
        local dist=math.floor((Camera.CFrame.Position-head.Position).Magnitude)
        local d=Drawing.new("Text")
        d.Text=dist.."m" d.Position=Vector2.new(pos.X,pos.Y+25)
        d.Color=Color3.fromRGB(0,255,255) d.Center=true d.Size=16 d.Outline=true d.Visible=true
        table.insert(ESPSystem.drawings,d)
    end
end

RunService.RenderStepped:Connect(function()
    clearESP()
    for _,p in ipairs(Players:GetPlayers()) do
        if p.Character then createESP(p) end
    end
end)

TabEsp:CreateToggle({Name="Linhas ESP",    CurrentValue=false, Callback=function(v) ESPSystem.showLine=v end})
TabEsp:CreateToggle({Name="Nomes ESP",     CurrentValue=false, Callback=function(v) ESPSystem.showName=v end})
TabEsp:CreateToggle({Name="Distancia ESP", CurrentValue=false, Callback=function(v) ESPSystem.showDistance=v end})

-- ============================================================
-- AUDIO
-- ============================================================
TabAudio:CreateSection("Musica")

local musicInput = ""
TabAudio:CreateInput({Name="ID da Musica", PlaceholderText="ex: 1234567", RemoveTextAfterFocusLost=false, Callback=function(v) musicInput=v end})
TabAudio:CreateButton({
    Name="Tocar Musica",
    Callback=function()
        if musicInput~="" then
            local s=Instance.new("Sound")
            s.SoundId="rbxassetid://"..musicInput
            s.Volume=0.5
            s.Parent=workspace
            s:Play()
        end
    end
})
TabAudio:CreateButton({
    Name="Parar Todas as Musicas",
    Callback=function()
        for _,s in ipairs(workspace:GetDescendants()) do
            if s:IsA("Sound") then s:Stop() end
        end
    end
})

TabAudio:CreateSection("Musicas Prontas")
local musicas = {
    {name="Phonk",     id="1845288678"},
    {name="Funk BR",   id="1374269869"},
    {name="Trap",      id="1843671350"},
    {name="Lo-fi",     id="1372719710"},
    {name="Pagode",    id="142376088"},
}
for _,m in ipairs(musicas) do
    TabAudio:CreateButton({
        Name=m.name,
        Callback=function()
            for _,s in ipairs(workspace:GetDescendants()) do if s:IsA("Sound") then s:Stop() end end
            local s=Instance.new("Sound")
            s.SoundId="rbxassetid://"..m.id
            s.Volume=0.5 s.Parent=workspace s:Play()
        end
    })
end

-- ============================================================
-- ROUPAS
-- ============================================================
TabRoupas:CreateSection("Trocar Roupa")

local shirtInput, pantsInput = "", ""
TabRoupas:CreateInput({Name="ID Camisa", PlaceholderText="ex: 123456789", RemoveTextAfterFocusLost=false, Callback=function(v) shirtInput=v end})
TabRoupas:CreateInput({Name="ID Calca",  PlaceholderText="ex: 123456789", RemoveTextAfterFocusLost=false, Callback=function(v) pantsInput=v end})
TabRoupas:CreateButton({
    Name="Aplicar Roupa",
    Callback=function()
        if Character then
            local shirt=Character:FindFirstChildOfClass("Shirt") or Instance.new("Shirt", Character)
            local pants=Character:FindFirstChildOfClass("Pants") or Instance.new("Pants", Character)
            if shirtInput~="" then shirt.ShirtTemplate="rbxassetid://"..shirtInput end
            if pantsInput~="" then pants.PantsTemplate="rbxassetid://"..pantsInput end
        end
    end
})

-- ============================================================
-- CASA
-- ============================================================
TabCasa:CreateSection("Casa")

TabCasa:CreateButton({
    Name="Teleport: Minha Casa",
    Callback=function()
        for _,obj in ipairs(workspace:GetDescendants()) do
            if obj.Name==LP.Name and obj:IsA("Model") then
                local r=obj.PrimaryPart
                if r and RootPart then
                    RootPart.CFrame=CFrame.new(r.Position+Vector3.new(0,3,5))
                    return
                end
            end
        end
    end
})

-- ============================================================
-- CARRO
-- ============================================================
TabCarro:CreateSection("Carro")
TabCarro:CreateToggle({
    Name="Speed Carro",
    CurrentValue=false,
    Callback=function(v)
        task.spawn(function()
            while v do
                for _,obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("VehicleSeat") then
                        obj.MaxSpeed = v and 200 or 60
                    end
                end
                task.wait(1)
            end
        end)
    end
})
TabCarro:CreateButton({
    Name="Sair do Carro",
    Callback=function()
        if Character then
            local hum=Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.Sit=false end
        end
    end
})

-- ============================================================
-- TELEPORTE
-- ============================================================
TabTeleporte:CreateSection("Pontos do Mapa")

local tpPoints = {
    {"Spawn",        Vector3.new(0,5,0)},
    {"Escola",       Vector3.new(120,5,80)},
    {"Hospital",     Vector3.new(-120,5,60)},
    {"Policia",      Vector3.new(80,5,-100)},
    {"Banco",        Vector3.new(-80,5,-120)},
    {"Parque",       Vector3.new(0,5,200)},
    {"Supermercado", Vector3.new(200,5,0)},
    {"Posto",        Vector3.new(-200,5,0)},
    {"Aeroporto",    Vector3.new(300,5,300)},
}
for _,tp in ipairs(tpPoints) do
    TabTeleporte:CreateButton({
        Name=tp[1],
        Callback=function()
            if RootPart then RootPart.CFrame=CFrame.new(tp[2]) end
        end
    })
end

TabTeleporte:CreateSection("Por Player")
local tp2Input = ""
TabTeleporte:CreateInput({Name="Nome do player", PlaceholderText="Nome", RemoveTextAfterFocusLost=false, Callback=function(v) tp2Input=v end})
TabTeleporte:CreateButton({
    Name="Teleportar",
    Callback=function()
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP and p.Name:lower():find(tp2Input:lower()) then
                local c=p.Character
                if c then
                    local r=c:FindFirstChild("HumanoidRootPart")
                    if r and RootPart then RootPart.CFrame=r.CFrame+Vector3.new(2,0,0) end
                end
            end
        end
    end
})

-- ============================================================
-- CONFIG
-- ============================================================
TabConfig:CreateSection("Geral")

TabConfig:CreateToggle({
    Name="Full Bright",
    CurrentValue=false,
    Callback=function(v)
        if v then
            Lighting.Brightness=2 Lighting.ClockTime=14
            Lighting.GlobalShadows=false Lighting.Ambient=Color3.fromRGB(255,255,255)
        else
            Lighting.Brightness=1 Lighting.GlobalShadows=true
            Lighting.Ambient=Color3.fromRGB(100,100,100)
        end
    end
})

TabConfig:CreateButton({
    Name="Rejoin",
    Callback=function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
    end
})

TabConfig:CreateSection("Resolucao")
TabConfig:CreateButton({Name="Resolucao Normal (1.0)", Callback=function()
    getgenv().Resolution={[".gg/scripters"]=1.0}
    if getgenv().gg_scripters==nil then
        RunService.RenderStepped:Connect(function()
            Camera.CFrame=Camera.CFrame*CFrame.new(0,0,0,1,0,0,0,getgenv().Resolution[".gg/scripters"],0,0,0,1)
        end)
        getgenv().gg_scripters="set"
    end
end})
TabConfig:CreateButton({Name="Resolucao 0.80", Callback=function()
    getgenv().Resolution={[".gg/scripters"]=0.80}
    if getgenv().gg_scripters==nil then
        RunService.RenderStepped:Connect(function()
            Camera.CFrame=Camera.CFrame*CFrame.new(0,0,0,1,0,0,0,getgenv().Resolution[".gg/scripters"],0,0,0,1)
        end)
        getgenv().gg_scripters="set"
    end
end})
TabConfig:CreateButton({Name="Resolucao 0.70", Callback=function()
    getgenv().Resolution={[".gg/scripters"]=0.70}
    if getgenv().gg_scripters==nil then
        RunService.RenderStepped:Connect(function()
            Camera.CFrame=Camera.CFrame*CFrame.new(0,0,0,1,0,0,0,getgenv().Resolution[".gg/scripters"],0,0,0,1)
        end)
        getgenv().gg_scripters="set"
    end
end})

Rayfield:Notify({
    Title = "Lyon Hub",
    Content = "Carregado com sucesso!",
    Duration = 4,
    Image = "check",
})

print("[LyonHub] Carregado v1.0")
