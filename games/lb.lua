-- Instances:

local Leaderboard = Instance.new("ScreenGui")
local Background = Instance.new("Frame")
local Title = Instance.new("Frame")
local Players = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")

--Properties:

Leaderboard.Name = "Leaderboard"
Leaderboard.Parent = game.CoreGui

Background.Name = "Background"
Background.Parent = Leaderboard
Background.Active = true
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 0.200
Background.Position = UDim2.new(0.28280261, 0, 0.1499386597, 0)
Background.Size = UDim2.new(0, 800, 0, 700)
Background.Draggable = true


Title.Name = "Title"
Title.Parent = Background
Title.Active = true
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BackgroundTransparency = 0.500
Title.Position = UDim2.new(0.000190973282, 0, -6.13480806e-05, 0)
Title.Size = UDim2.new(0, 800, 0, 100)

Players.Name = "Players"
Players.Parent = Background
Players.Active = true
Players.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Players.BackgroundTransparency = 1.000
Players.Position = UDim2.new(-0.000186622143, 0, 0.142585352, 0)
Players.Size = UDim2.new(0, 800, 0, 600)

TextLabel.Parent = Players
TextLabel.Active = true
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.246250033, 0, 0.420238137, 0)
TextLabel.Size = UDim2.new(0, 407, 0, 111)
TextLabel.Font = Enum.Font.ArialBold
TextLabel.Text = "Dit me Thanh Long?"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true
TextLabel.Visible = false
--Clone

local LeaderboardSurfaceGUI_Title = game.Workspace.TopMiners.Title.SurfaceGui:Clone()

for index,p in pairs(LeaderboardSurfaceGUI_Title:GetChildren()) do
    p.Parent = game.CoreGui.Leaderboard.Background.Title
end



local LeaderboardSurfaceGUI = game.Workspace.TopMiners.Part.SurfaceGui:Clone()

for index,p in pairs(LeaderboardSurfaceGUI:GetChildren()) do
    p.Parent = game.CoreGui.Leaderboard.Background.Players
end

game.CoreGui.Leaderboard.Background.Players.Up.ItemName.Text = "Blocks"
game.CoreGui.Leaderboard.Background.Players.Up.Name = "Blocks"
game.CoreGui.Leaderboard.Background.Players.Blocks.Rotation = 180
game.CoreGui.Leaderboard.Background.Players.Blocks.Parent = game.CoreGui.Leaderboard.Background.Title
game.CoreGui.Leaderboard.Background.Title.Blocks.Position = UDim2.new(0, 0, 0, 0)
game.CoreGui.Leaderboard.Background.Title.Blocks.Size = UDim2.new(0, 40, 40, 0)
game.CoreGui.Leaderboard.Background.Title.Blocks.AnchorPoint = Vector2.new(0, 0)
game.CoreGui.Leaderboard.Background.Title.Blocks.Shadow:Destroy()

local Rebirth = game.CoreGui.Leaderboard.Background.Title.Blocks:Clone()
Rebirth.Name = "Rebirth"
Rebirth.ItemName.Text = "Rebirth"
Rebirth.Parent = game.CoreGui.Leaderboard.Background.Title
game.CoreGui.Leaderboard.Background.Title.Rebirth.Position = UDim2.new(0, 45, 0, 0)

local DRebirth = game.CoreGui.Leaderboard.Background.Title.Blocks:Clone()
DRebirth.Name = "DRebirth"
DRebirth.ItemName.Text = "Daily Rebirths"
DRebirth.Parent = game.CoreGui.Leaderboard.Background.Title
game.CoreGui.Leaderboard.Background.Title.DRebirth.Position = UDim2.new(0, 0, 0, 45)

local DBlocks = game.CoreGui.Leaderboard.Background.Title.Blocks:Clone()
DBlocks.Name = "DBlocks"
DBlocks.ItemName.Text = "Daily Blocks"
DBlocks.Parent = game.CoreGui.Leaderboard.Background.Title
game.CoreGui.Leaderboard.Background.Title.DBlocks.Position = UDim2.new(0, 45, 0, 45)




game.CoreGui.Leaderboard.Background.Players.Down.Parent = game.CoreGui.Leaderboard.Background.Title
game.CoreGui.Leaderboard.Background.Title.Down.ItemName.Text = "X"
game.CoreGui.Leaderboard.Background.Title.Down.Name = "Close"
game.CoreGui.Leaderboard.Background.Title.Close.Position = UDim2.new(1, 0, 0, 0)
game.CoreGui.Leaderboard.Background.Title.Close.Size = UDim2.new(0, 30, 0, 30)
game.CoreGui.Leaderboard.Background.Title.Close.AnchorPoint = Vector2.new(1, 0)
game.CoreGui.Leaderboard.Background.Title.Close.Shadow:Destroy()

Title.Visible = true
Players.Visible = true
Background.Visible = true
local Alive = true


local CloseButton = game.CoreGui.Leaderboard.Background.Title.Close
local Blocks = game.CoreGui.Leaderboard.Background.Title.Blocks
local Rebirth = game.CoreGui.Leaderboard.Background.Title.Rebirth
local DRebirth = game.CoreGui.Leaderboard.Background.Title.DRebirth
local DBlocks = game.CoreGui.Leaderboard.Background.Title.DBlocks

CloseButton.MouseButton1Click:Connect(function()
    Alive = false
    game.CoreGui.Leaderboard:Destroy()
end)

Blocks.MouseButton1Click:Connect(function()
    game.CoreGui.Leaderboard.Background.Title.Names.Text = "Top Miners"
    game.CoreGui.Leaderboard.Background.Title.Names.Shadow.Text = "Top Miners"
    game.CoreGui.Leaderboard.Background.Players.Players:Destroy()
    game.CoreGui.Leaderboard.Background.Players.Value:Destroy()
    game.CoreGui.Leaderboard.Background.Players.Names:Destroy()
    game.CoreGui.Leaderboard.Background.Players.TextLabel.Visible = true
    wait(.5)
    local TitleGui = game.Workspace.TopMiners.Part.SurfaceGui:Clone()
    for index,p in pairs(TitleGui:GetChildren()) do
        p.Parent = game.CoreGui.Leaderboard.Background.Players
    end
    game.CoreGui.Leaderboard.Background.Players.TextLabel.Visible = false
    game.CoreGui.Leaderboard.Background.Players.Up:Destroy()
    game.CoreGui.Leaderboard.Background.Players.Down:Destroy()
end)

Rebirth.MouseButton1Click:Connect(function()
    game.CoreGui.Leaderboard.Background.Title.Names.Text = "Most Rebirths"
    game.CoreGui.Leaderboard.Background.Title.Names.Shadow.Text = "Most Rebirths"
    game.CoreGui.Leaderboard.Background.Players.Players:Destroy()
    game.CoreGui.Leaderboard.Background.Players.Value:Destroy()
    game.CoreGui.Leaderboard.Background.Players.Names:Destroy()
    game.CoreGui.Leaderboard.Background.Players.TextLabel.Visible = true
    wait(.5)
    local TitleGui = game.Workspace.MostRebirth.Part.SurfaceGui:Clone()
    for index,p in pairs(TitleGui:GetChildren()) do
        p.Parent = game.CoreGui.Leaderboard.Background.Players
    end
    game.CoreGui.Leaderboard.Background.Players.TextLabel.Visible = false
    game.CoreGui.Leaderboard.Background.Players.Up:Destroy()
    game.CoreGui.Leaderboard.Background.Players.Down:Destroy()
end)

DRebirth.MouseButton1Click:Connect(function()
    game.CoreGui.Leaderboard.Background.Title.Names.Text = "Daily Rebirths"
    game.CoreGui.Leaderboard.Background.Title.Names.Shadow.Text = "Daily Rebirths"
    game.CoreGui.Leaderboard.Background.Players.Players:Destroy()
    game.CoreGui.Leaderboard.Background.Players.Value:Destroy()
    game.CoreGui.Leaderboard.Background.Players.Names:Destroy()
    game.CoreGui.Leaderboard.Background.Players.TextLabel.Visible = true
    wait(.5)
    local TitleGui = game.Workspace.DailyRebirthBoard.Part.SurfaceGui:Clone()
    for index,p in pairs(TitleGui:GetChildren()) do
        p.Parent = game.CoreGui.Leaderboard.Background.Players
    end
    game.CoreGui.Leaderboard.Background.Players.TextLabel.Visible = false
    game.CoreGui.Leaderboard.Background.Players.Up:Destroy()
    game.CoreGui.Leaderboard.Background.Players.Down:Destroy()
end)

DBlocks.MouseButton1Click:Connect(function()
    game.CoreGui.Leaderboard.Background.Title.Names.Text = "Miners of the Day"
    game.CoreGui.Leaderboard.Background.Title.Names.Shadow.Text = "Miners of the Day"
    game.CoreGui.Leaderboard.Background.Players.Players:Destroy()
    game.CoreGui.Leaderboard.Background.Players.Value:Destroy()
    game.CoreGui.Leaderboard.Background.Players.Names:Destroy()
    game.CoreGui.Leaderboard.Background.Players.TextLabel.Visible = true
    wait(.5)
    local TitleGui = game.Workspace.DailyBoard.Part.SurfaceGui:Clone()
    for index,p in pairs(TitleGui:GetChildren()) do
        p.Parent = game.CoreGui.Leaderboard.Background.Players
    end
    game.CoreGui.Leaderboard.Background.Players.TextLabel.Visible = false
    game.CoreGui.Leaderboard.Background.Players.Up:Destroy()
    game.CoreGui.Leaderboard.Background.Players.Down:Destroy()
end)
