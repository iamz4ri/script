
--#region var1

getgenv().autoOrb = false
getgenv().autoLaunch = false
getgenv().autoView = false
-- hatching
getgenv().triple = false
getgenv().octuple = false
getgenv().hatch = false
getgenv().EggName = nil
getgenv().tpToEgg = false
local newName
--#endregion

for i,v in pairs(game.CoreGui:GetChildren()) do
    if v:FindFirstChild("Main") and v.Main:FindFirstChild("MainHeader") and v.Main:FindFirstChild("pages") then
        v:Destroy()
    end
end

task.spawn(function()
    local VirtualUser = game:service 'VirtualUser'
    game.Players.LocalPlayer.Idled:connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

--#region var2

local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
local Fire, Invoke = Network.Fire, Network.Invoke
local InvokeHook = hookfunction(debug.getupvalue(Invoke, 1), function(...) return true end)
local FireHook = hookfunction(debug.getupvalue(Fire, 1), function(...) return true end)
local orbs
task.spawn(function() orbs = workspace:WaitForChild("__MAP"):WaitForChild("Interactive"):WaitForChild("Orbs") end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Yeet a Pet by Zewi", "Ocean")
local News = Window:NewTab("News")
local Tab = Window:NewTab("Main")
local Eggs = Window:NewTab("Eggs")
local Section = Tab:NewSection("Farming")
--#endregion

Section:NewToggle("Auto Orb", "Auto collects orbs", function(v)
    getgenv().autoOrb = v

end)
Section:NewToggle("Auto Launch", "Automatically launches for you", function(v)
    getgenv().autoLaunch = v
end)

--#region trackers
local orbAmt,curAmt ="0","0"
task.spawn(function()
orbAmt = game.Players.LocalPlayer.PlayerGui.Main.Right:WaitForChild("Yeet Orbs").Amount.Text
curAmt = game.Players.LocalPlayer.PlayerGui.Main.Right:WaitForChild("Yeet Coins").Amount.Text
end)
local orblab = Section:NewLabel("Orb amount: "..orbAmt)
local curlab = Section:NewLabel("Currency amount: "..curAmt)
local Section = Tab:NewSection("Visual")

--#endregion

Section:NewToggle("View character", "Views character when on", function(v)
    getgenv().autoView = v
end)
--#region labels
local NewsSection = News:NewSection("Contact")
NewsSection:NewLabel("Discord: _adwnq")
NewsSection:NewLabel("Facebook: /nguyndungg")
--#endregion

local EggSec = Eggs:NewSection("Hatching")

EggSec:NewToggle("Start Hatching", "Auto hatches", function(v)
    getgenv().hatch = v
end)
for i,v in pairs(getgc(true)) do
   if (typeof(v) == 'table' and rawget(v, 'OpenEgg')) then
       v.OpenEgg = function()
           return
       end
   end
end

EggSec:NewToggle("Tp to egg", "Teleports to egg", function(v)
    getgenv().tpToEgg = v
end)

EggSec:NewDropdown("Eggs", "Eggs", {"Jetpack Egg", "Fireball Egg", "Wild Egg"}, function(v)
    getgenv().EggName = v
end)

EggSec:NewDropdown("Gold Eggs", "Gold Eggs", {"Golden Jetpack Egg", "Golden Fireball Egg", "Golden Wild Egg"}, function(v)
    getgenv().EggName = v
end)

EggSec:NewDropdown("Hatch Mode", "select hatch mode", {"Single", "Triple", "Octuple"}, function(v)
    if v == "Single" then
        getgenv().triple,getgenv().octuple = false,false
    elseif v == "Triple" then
        getgenv().triple = true
        getgenv().octuple = false
    elseif v == "Octuple" then
        getgenv().octuple = true
        getgenv().triple = false
    end
end)

task.spawn(function()
    while task.wait() do -- loop
        if getgenv().autoOrb then
            if #orbs:GetChildren() ~= 0 then -- not do the whole thing unless thingy spawned
                for _,v in pairs(orbs:GetChildren()) do -- could make this more potato pc friendly but was too lazy
                    task.spawn(function() v.Orb.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame end) -- collect all orbs (this works because you are network owner LOL)
                    Fire("Yeet: Claim Orbs",v.Name) -- not even needed lmfao
            end
            end
    end
    end
end)
task.spawn(function()
    while task.wait() do -- loop
        if getgenv().autoLaunch then
            local plr = game.Players.LocalPlayer
            local chr = plr.Character
            local hum = chr:WaitForChild("HumanoidRootPart")
            hum.CFrame = CFrame.new(6727.01953, -16.339798, -869.642334, -0.0522250049, -1.02990164e-07, 0.998635352, 3.01589438e-08, 1, 1.04708107e-07, -0.998635352, 3.55861687e-08, -0.0522250049)
            task.wait(0.3)
            Invoke("Yeet a Pet: Throw")
    end
    end
end)

task.spawn(function()
    while task.wait() do -- loop
        if getgenv().autoView then
            local camera = workspace.CurrentCamera
            local plr = game.Players.LocalPlayer
            local chr = plr.Character
            local hum = chr:WaitForChild("Humanoid")
            if camera.CameraSubject ~= hum then
                camera.CameraSubject = hum
            end
    else
        if workspace:WaitForChild("__THINGS"):WaitForChild("Yeet"):FindFirstChild(game.Players.LocalPlayer.Name .."_CLIENT") then
            workspace.CurrentCamera.CameraSubject = workspace:WaitForChild("__THINGS"):WaitForChild("Yeet"):FindFirstChild(game.Players.LocalPlayer.Name .."_CLIENT")
        end
    end
    end
end)

task.spawn(function()
    while task.wait() do -- loop
        if getgenv().hatch and getgenv().EggName ~= nil then
       
            if getgenv().tpToEgg then
                local EggsFolder = workspace:WaitForChild("__MAP"):FindFirstChild("Eggs")
                newName = getgenv().EggName
                if string.find(getgenv().EggName,"Golden ") then
                    newName = string.gsub(getgenv().EggName,"Golden ","")
                end
                for i,v in pairs(EggsFolder:GetChildren()) do
                    for i,v in pairs(v:GetChildren()) do
                        if v.Name == "PLATFORM" and v:FindFirstChild("SectionName") and v.SectionName:FindFirstChild("SurfaceGui") and v.SectionName.SurfaceGui:FindFirstChild("TextLabel") and string.find(v.SectionName.SurfaceGui.TextLabel.Text,newName) then
                            game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = v.SectionName.CFrame * CFrame.new(0,3,0)
                        end
                    end
                end
            
            end
            Invoke("Buy Egg",getgenv().EggName,getgenv().triple,getgenv().octuple)
    end
    end
end)

task.spawn(function()
    while task.wait() do
        if orbAmt ~= game.Players.LocalPlayer.PlayerGui.Main.Right:WaitForChild("Yeet Orbs").Amount.Text then
            orbAmt = game.Players.LocalPlayer.PlayerGui.Main.Right:WaitForChild("Yeet Orbs").Amount.Text
            orblab:UpdateLabel("Orb amount: "..orbAmt)
        elseif curAmt ~= game.Players.LocalPlayer.PlayerGui.Main.Right:WaitForChild("Yeet Coins").Amount.Text then
            curAmt = game.Players.LocalPlayer.PlayerGui.Main.Right:WaitForChild("Yeet Coins").Amount.Text
            curlab:UpdateLabel("Currency amount: "..curAmt)
        end
    end
    end)