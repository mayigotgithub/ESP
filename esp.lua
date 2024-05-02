local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Function to create a BillboardGui for a player
local function CreateBillboard(player)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlayerInfoBillboard"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 100, 0, 70) -- Increased size to accommodate both name and HP
    billboard.StudsOffset = Vector3.new(0, 3, 0) -- Adjust offset as needed
    billboard.Parent = player.Character:FindFirstChild("Head") or player.Character:WaitForChild("Head")

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Text = player.Name
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextSize = 14
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Parent = billboard

    local hpLabel = Instance.new("TextLabel")
    hpLabel.Name = "HPLabel"
    hpLabel.Text = "HP: " .. tostring(player.Character.Humanoid.Health)
    hpLabel.Font = Enum.Font.SourceSans
    hpLabel.TextSize = 12
    hpLabel.TextColor3 = Color3.new(1, 0, 0) -- Red color for HP
    hpLabel.BackgroundTransparency = 1
    hpLabel.Position = UDim2.new(0, 0, 0.5, 0)
    hpLabel.Size = UDim2.new(1, 0, 0.5, 0)
    hpLabel.Parent = billboard

    -- Update HP label continuously
    player.Character.Humanoid.HealthChanged:Connect(function(newHealth)
        hpLabel.Text = "HP: " .. tostring(newHealth)
    end)
end

-- Function to remove BillboardGui for a player
local function RemoveBillboard(player)
    local billboard = player.Character:FindFirstChild("Head"):FindFirstChild("PlayerInfoBillboard")
    if billboard then
        billboard:Destroy()
    end
end

-- Main loop to continuously check for players and create Billboards for their names and HP
while true do
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            CreateBillboard(player)
        end
    end

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            CreateBillboard(player)
        end)
    end)

    Players.PlayerRemoving:Connect(function(player)
        RemoveBillboard(player)
    end)

    wait(1) -- Adjust the delay as needed
end
