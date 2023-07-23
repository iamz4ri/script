local Depth
local SellTreshold

if not getgenv().SellTreshold then
SellTreshold = 60000
else
SellTreshold = getgenv().SellTreshold
end

if not getgenv().Depth then
Depth = 240
else
Depth = getgenv().Depth
end

do
repeat wait() until game:IsLoaded()
game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("ScreenGui")
while game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.LoadingFrame.BackgroundTransparency == 0 do
    for i, connection in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.LoadingFrame.Quality.LowQuality.MouseButton1Down)) do
        connection:Fire()
    end
    wait()
end
while true do
    if pcall(function() game.Players.LocalPlayer.leaderstats:WaitForChild("Blocks Mined") end) then
        if pcall(function() game.Players.LocalPlayer.PlayerGui.ScreenGui.StatsFrame.Coins:FindFirstChild("Amount") end) then
            if game.Players.LocalPlayer.PlayerGui.ScreenGui.StatsFrame.Tokens.Amount.Text ~= "Loading..." then
                break
            end
        end
    end
    wait(1)
end
game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.TeleporterFrame:Destroy()
game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.StatsFrame.Sell:Destroy()
end

local vuAF = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
vuAF:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
wait(1)
vuAF:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

local Remote

do
local Data = getsenv(game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.ClientScript).displayCurrent
local Values = getupvalue(Data,8)
Remote = Values["RemoteEvent"]
Data, Values = nil
end

do
local HumanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 25
game.Players.LocalPlayer.Character.Humanoid.JumpPower = 46
HumanoidRootPart.Anchored = true
Remote:FireServer("MoveTo", {{"LavaSpawn"}})
local className = "Part"
local parent = game.Workspace
local part = Instance.new(className, parent)
part.Anchored = true
part.Size = Vector3.new(10, 0.5 , 100)
part.Material = "ForceField"
local pos = Vector3.new(21, 9.5, 26285)
part.Position = pos
wait(1)
HumanoidRootPart.Anchored = false
while HumanoidRootPart.Position.Z > 26220 do
    HumanoidRootPart.CFrame = CFrame.new(Vector3.new(HumanoidRootPart.Position.X,13.05,HumanoidRootPart.Position.Z-0.5))
    wait()
end
HumanoidRootPart.CFrame = CFrame.new(18, 10, 26220)
end

do
local function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
local RunService = game:GetService("RunService").Stepped
local HumanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
local depth = Split(game.Players.LocalPlayer.PlayerGui.ScreenGui.TopInfoFrame.Depth.Text," ")
while tonumber(depth[1]) < Depth do
    local min = HumanoidRootPart.CFrame + Vector3.new(-1,-10,-1)
    local max = HumanoidRootPart.CFrame + Vector3.new(1,0,1)
    local region = Region3.new(min.Position, max.Position)
    local parts = workspace:FindPartsInRegion3WithWhiteList(region, {game.Workspace.Blocks}, 5)
    for each, block in pairs(parts) do
        Remote:FireServer("MineBlock",{{block.Parent}})
        RunService:Wait()
    end
    depth = Split(game.Players.LocalPlayer.PlayerGui.ScreenGui.TopInfoFrame.Depth.Text," ")
    wait()
end
end

do
local CoinsAmount = game.Players.LocalPlayer.leaderstats.Coins
local function GetCoinsAmount()
    local Amount = CoinsAmount.Value
    Amount = Amount:gsub(',', '')
    
    return tonumber(Amount)
end

local function comma_value(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end

local function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
local recovering = false
local DepthAmount = game.Players.LocalPlayer.PlayerGui.ScreenGui.TopInfoFrame.Depth
DepthAmount.Changed:connect(function()
    local depth = Split(DepthAmount.Text," ")
    if tonumber(depth[1]) >= 1400 then
        recovering = true
        local HumanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 25
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 46
        HumanoidRootPart.Anchored = true
        Remote:FireServer("MoveTo", {{"LavaSpawn"}})
        local className = "Part"
        local parent = game.Workspace
        local part = Instance.new(className, parent)
        part.Anchored = true
        part.Size = Vector3.new(10, 0.5 , 100)
        part.Material = "ForceField"
        local pos = Vector3.new(21, 9.5, 26285)
        part.Position = pos
        wait(1)
        HumanoidRootPart.Anchored = false
        while HumanoidRootPart.Position.Z > 26220 do
            HumanoidRootPart.CFrame = CFrame.new(Vector3.new(HumanoidRootPart.Position.X,13.05,HumanoidRootPart.Position.Z-0.5))
            wait()
        end
        HumanoidRootPart.CFrame = CFrame.new(18, 10, 26220)
        wait(5)
        recovering = false
    end
end)


local RebirthsAmount = game.Players.LocalPlayer.leaderstats.Rebirths
game:GetService("RunService"):BindToRenderStep("Rebirth", Enum.RenderPriority.Camera.Value, function()
    while GetCoinsAmount() >= (10000000 * (RebirthsAmount.Value + 1)) do
        Remote:FireServer("Rebirth",{{}})
        wait()
    end
end)

local InventoryAmount = game.Players.LocalPlayer.PlayerGui.ScreenGui.StatsFrame2.Inventory.Amount
local function GetInventoryAmount()
    local Amount = InventoryAmount.Text
    Amount = Amount:gsub('%s+', '')
    Amount = Amount:gsub(',', '')
    local Inventory = Amount:split("/")
    return tonumber(Inventory[1])
end

local RunService = game:GetService("RunService").Stepped
local HumanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
local Character = game.Players.LocalPlayer.Character
local SellArea = CFrame.new(41, 14,-1239)
while true do
    if HumanoidRootPart then
        local minp = HumanoidRootPart.CFrame + Vector3.new(-5,-5,-5)
        local maxp = HumanoidRootPart.CFrame + Vector3.new(5,5,5)
        local region = Region3.new(minp.Position, maxp.Position)
        local parts = workspace:FindPartsInRegion3WithWhiteList(region, {game.Workspace.Blocks}, 100) --  ignore part
        for each, block in pairs(parts) do
            if block:IsA("BasePart") then
                Remote:FireServer("MineBlock",{{block.Parent}})
                repeat
                    RunService:Wait()
                until not recovering

            end
            if GetInventoryAmount() >= SellTreshold then
                if Character then
                    if HumanoidRootPart then
                        local SavedPosition = HumanoidRootPart.Position
                        while GetInventoryAmount() >= SellTreshold do
                            HumanoidRootPart.CFrame = SellArea
                            Remote:FireServer("SellItems",{{               }})
                            RunService:Wait()
                        end
                        HumanoidRootPart.Anchored = true
                        local starttime1 = os.time()
                        while (HumanoidRootPart.Position - SavedPosition).Magnitude > 1 do
                            HumanoidRootPart.CFrame = CFrame.new(18, SavedPosition.Y, 26220)
                            RunService:Wait()
                            if os.time() - starttime1 > 3.5 then
                                break
                            end
                        end
                        HumanoidRootPart.Anchored = false
                    end
                end
            end
        end
    end
    RunService:Wait()
end
end