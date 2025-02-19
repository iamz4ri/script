if game.PlaceId == 1417427737 then repeat task.wait(1) until game:IsLoaded()

    local SellTreshold = getgenv().SellTreshold or 30000
    local Depth = getgenv().Depth or 205

    local Players = game:GetService("Players")
    local Client = game.Players.LocalPlayer
    local Remote

    Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")
    while Players.LocalPlayer.PlayerGui.ScreenGui.LoadingFrame.BackgroundTransparency == 0 do
        for i, connection in pairs(getconnections(Players.LocalPlayer.PlayerGui.ScreenGui.LoadingFrame.Quality.LowQuality.MouseButton1Down)) do
            connection:Fire()
        end
        task.wait(1)
    end
    while true do
        if pcall(function() Client.leaderstats:WaitForChild("Blocks Mined") end) then
            if pcall(function() Client.PlayerGui.ScreenGui.StatsFrame.Coins:FindFirstChild("Amount") end) then
                if Client.PlayerGui.ScreenGui.StatsFrame.Tokens.Amount.Text ~= "Loading..." then
                    break
                end
            end
        end
        task.wait(1)
    end
    
    if Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("TeleporterFrame") then
        Players.LocalPlayer.PlayerGui.ScreenGui.TeleporterFrame:Destroy()
    end
    if Players.LocalPlayer.PlayerGui.ScreenGui.StatsFrame:FindFirstChild("Sell") then
        Players.LocalPlayer.PlayerGui.ScreenGui.StatsFrame.Sell:Destroy()
    end
    if Players.LocalPlayer.PlayerGui.ScreenGui.MainButtons:FindFirstChild("Surface") then
        Players.LocalPlayer.PlayerGui.ScreenGui.MainButtons.Surface:Destroy()
    end
    if Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("Collapse") then
        Players.LocalPlayer.PlayerGui.ScreenGui.Collapse.Visible = true
    end
--Rebirth GUI
    local ExampleFrame = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):WaitForChild("StatsFrame"):WaitForChild("Inventory")
    local Rebirths = game:GetService("Players").LocalPlayer.leaderstats.Rebirths
    local Rebirths2 = ExampleFrame:Clone()
    Rebirths2.Parent = ExampleFrame.Parent
    Rebirths2.Position = UDim2.new(0, 0, 1.5, 15)
    Rebirths2.Logo.Image = "rbxassetid://1440681030"
    Rebirths2.Amount.Text = tostring(Rebirths.Value)
    Rebirths:GetPropertyChangedSignal("Value"):Connect(function()
        Rebirths2.Amount.Text = tostring(Rebirths.Value)
    end)
--Reconnect
    local po = game.CoreGui.RobloxPromptGui.promptOverlay
    po.ChildAdded:connect(function(a)
        if a.Name == 'ErrorPrompt' then
            repeat
                game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer)
                task.wait(2)
            until false
        end
    end)
--Rejoin
    workspace.Collapsed.Changed:connect(function()
    if workspace.Collapsed.Value == true then
        game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer)
        end
    end)    

    local Data = getsenv(Players.LocalPlayer.PlayerGui.ScreenGui.ClientScript).displayCurrent
    local Values = getupvalue(Data,8)
    Remote = Values["RemoteEvent"]
    Data, Values = nil

    local HumanoidRootPart = Client.Character.HumanoidRootPart
    local humanoid = Client.Character.Humanoid
    humanoid.WalkSpeed = 0
    humanoid.JumpPower = 0
    HumanoidRootPart.Anchored = true
    Remote:FireServer("MoveTo", {{"LavaSpawn"}})
    local className = "Part"
    local parent = game.Workspace
    local part = Instance.new(className, parent)
    part.Anchored = true
    part.Size = Vector3.new(10, 1 , 100)
    part.Material = "ForceField"
    local pos = Vector3.new(21, 9.5, 26285)
    part.Position = pos
    task.wait(1)
    HumanoidRootPart.Anchored = false
    while HumanoidRootPart.Position.Z > 26220 do
        HumanoidRootPart.CFrame = CFrame.new(Vector3.new(HumanoidRootPart.Position.X, 13.05, HumanoidRootPart.Position.Z - 0.5))
        task.wait(0.01)
    end
    HumanoidRootPart.CFrame = CFrame.new(18, 10, 26220)

    local function Split(s, delimiter)
        result = {};
        for match in (s..delimiter):gmatch("(.-)"..delimiter) do
            table.insert(result, match);
        end
        return result;
    end

--Dig to depth
    local depth = Split(Client.PlayerGui.ScreenGui.TopInfoFrame.Depth.Text," ")
    while tonumber(depth[1]) < Depth do
        local min = HumanoidRootPart.CFrame + Vector3.new(-1,-10,-1)
        local max = HumanoidRootPart.CFrame + Vector3.new(1,0,1)
        local region = Region3.new(min.Position, max.Position)
        local parts = workspace:FindPartsInRegion3WithWhiteList(region, {game.Workspace.Blocks}, 10)
        for _, block in pairs(parts) do
            Remote:FireServer("MineBlock",{{block.Parent}})
            task.wait()
        end
        depth = Split(Client.PlayerGui.ScreenGui.TopInfoFrame.Depth.Text," ")
        task.wait()
    end

    local CoinsAmount = Client.leaderstats.Coins
    local function GetCoinsAmount()
        local Amount = CoinsAmount.Value
        Amount = Amount:gsub(',', '')
        return tonumber(Amount)
    end

--Recover
    local Character = Client.Character
    local recovering = false
    local DepthAmount = Client.PlayerGui.ScreenGui.TopInfoFrame.Depth
    DepthAmount.Changed:Connect(function()
        task.spawn(function()
            local depth = Split(DepthAmount.Text, " ")
            if tonumber(depth[1]) >= 1000 and not recovering then
                print("recovering true")
                HumanoidRootPart.CFrame = CFrame.new(18, Depth, 26220)
                print("teleported")
                task.wait()
                recovering = false
                print("recovering false")
            end
        end)
    end)

--Rebirth
    local RebirthsAmount = Client.leaderstats.Rebirths
    game:GetService("RunService"):BindToRenderStep("Rebirth", Enum.RenderPriority.Camera.Value, function()
        while GetCoinsAmount() >= (10000000 * (RebirthsAmount.Value + 1)) do
            Remote:FireServer("Rebirth",{{}})
            task.wait()
        end
    end)

    local InventoryAmount = Client.PlayerGui.ScreenGui.StatsFrame2.Inventory.Amount
    local function GetInventoryAmount()
        local Amount = InventoryAmount.Text
        Amount = Amount:gsub('%s+', '')
        Amount = Amount:gsub(',', '')
        local Inventory = Amount:split("/")
        return tonumber(Inventory[1])
    end

-- Mine Aura + Sell
    local SellArea = CFrame.new(42, 14, -1239)
    while task.wait() do
        local minp = HumanoidRootPart.CFrame.Position - Vector3.new(5, 5, 5)
        local maxp = HumanoidRootPart.CFrame.Position + Vector3.new(5, 5, 5)
        local region = Region3.new(minp, maxp)
        local parts = workspace:FindPartsInRegion3WithWhiteList(region, {game.Workspace.Blocks}, 50)
        for _, block in ipairs(parts) do    
            Remote:FireServer("MineBlock", {{block.Parent}})
            task.wait()
        end
        local SavedPosition = HumanoidRootPart.Position
        while GetInventoryAmount() >= SellTreshold and not recovering do
            Remote:FireServer("SellItems", {{}})
            HumanoidRootPart.CFrame = SellArea
            task.wait()
        end
        local starttime1 = os.time()
        while (HumanoidRootPart.Position - SavedPosition).Magnitude > 1 do
            HumanoidRootPart.CFrame = CFrame.new(18, SavedPosition.Y, 26220)
            task.wait()
            if os.time() - starttime1 > 2 then
                break
            end
        end
    end
end
