-- made by Volatile :)

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local ChangeButton = Instance.new("TextButton")
local ResetButton = Instance.new("TextButton")
local Title = Instance.new("TextLabel")

ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Increased frame size
Frame.Size = UDim2.new(0, 250, 0, 390)  -- Adjusted to fit more content
Frame.Position = UDim2.new(0.5, -150, 0.5, -225)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.1
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "WTRB PlayerNum Changer"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = Frame

TextBox.Size = UDim2.new(1, -20, 0, 30)
TextBox.Position = UDim2.new(0, 10, 0, 40)
TextBox.PlaceholderText = "Enter PlayerNum (1-9)"
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Parent = Frame

ChangeButton.Size = UDim2.new(1, -20, 0, 30)
ChangeButton.Position = UDim2.new(0, 10, 0, 80)
ChangeButton.Text = "Change PlayerNum"
ChangeButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ChangeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ChangeButton.Parent = Frame

ResetButton.Size = UDim2.new(1, -20, 0, 30)
ResetButton.Position = UDim2.new(0, 10, 0, 120)
ResetButton.Text = "Reset PlayerNum"
ResetButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
ResetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetButton.Parent = Frame

local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.BackgroundTransparency = 1
Credit.Text = "Made by Volatile"
Credit.TextColor3 = Color3.fromRGB(200, 200, 200)
Credit.TextSize = 14
Credit.Font = Enum.Font.SourceSansItalic
Credit.Parent = Frame

-- Player list display section
local PlayerListFrame = Instance.new("Frame")  -- Changed from ScrollingFrame to regular Frame
PlayerListFrame.Size = UDim2.new(1, -20, 0, 160)  -- Adjusted size for player list display
PlayerListFrame.Position = UDim2.new(0, 10, 0, 195)
PlayerListFrame.BackgroundTransparency = 1
PlayerListFrame.Parent = Frame

-- Store player labels in a table to avoid duplicates
local playerLabels = {}

-- Function to update the player list GUI
local function updatePlayerList()
    -- Clear previous labels
    for _, child in ipairs(PlayerListFrame:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    -- Iterate through all players and create text labels for each player, excluding the local player
    local yPos = 0  -- Start the vertical position for labels
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        -- Skip the local player
        if otherPlayer == Player then
            continue
        end

        local playerNum = "N/A"
        local playerNo = otherPlayer:FindFirstChild("playerNumber")
        if playerNo then
            playerNum = tostring(playerNo.Value)
        end

        -- Create a new label for each player
        local playerLabel = Instance.new("TextLabel")
        playerLabel.Size = UDim2.new(1, 0, 0, 30)
        playerLabel.Position = UDim2.new(0, 0, 0, yPos)  -- Position the labels vertically
        playerLabel.Text = otherPlayer.Name .. ": " .. playerNum
        playerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        playerLabel.TextSize = 14
        playerLabel.Font = Enum.Font.SourceSans
        playerLabel.BackgroundTransparency = 1
        playerLabel.Parent = PlayerListFrame

        -- Store reference to the player label in the table
        playerLabels[otherPlayer.UserId] = playerLabel

        yPos = yPos + 19  -- Increment yPos to stack the next player label
    end
end

-- Function to update the player number after a new player joins
local function updatePlayerNumberForNewPlayer(newPlayer)
    wait(3)  -- Wait for the new player to properly load
    local playerNum = "N/A"
    local playerNo = newPlayer:FindFirstChild("playerNumber")
    if playerNo then
        playerNum = tostring(playerNo.Value)
    end

    -- Find and update the player's label if it exists
    local playerLabel = playerLabels[newPlayer.UserId]
    if playerLabel then
        playerLabel.Text = newPlayer.Name .. ": " .. playerNum
    end
end

-- Update player list on player added or removed
Players.PlayerAdded:Connect(function(newPlayer)
    updatePlayerList()
    updatePlayerNumberForNewPlayer(newPlayer)  -- Update the player number for new players
end)

Players.PlayerRemoving:Connect(function()
    updatePlayerList()
end)

-- Initial player list update
updatePlayerList()

-- Player number update section (Moved below buttons)
local OriginalPlayerNumberLabel = Instance.new("TextLabel")
OriginalPlayerNumberLabel.Size = UDim2.new(1, -20, 0, 30)
OriginalPlayerNumberLabel.Position = UDim2.new(0, 10, 0, 164)
OriginalPlayerNumberLabel.BackgroundTransparency = 1
OriginalPlayerNumberLabel.Text = "Original PlayerNum N/A"
OriginalPlayerNumberLabel.TextColor3 = Color3.fromRGB(255, 210, 55)
OriginalPlayerNumberLabel.TextSize = 14
OriginalPlayerNumberLabel.Font = Enum.Font.SourceSans
OriginalPlayerNumberLabel.Parent = Frame

local CurrentPlayerNumberLabel = Instance.new("TextLabel")
CurrentPlayerNumberLabel.Size = UDim2.new(1, -20, 0, 30)
CurrentPlayerNumberLabel.Position = UDim2.new(0, 10, 0, 148)
CurrentPlayerNumberLabel.BackgroundTransparency = 1
CurrentPlayerNumberLabel.Text = "Current PlayerNum: N/A" -- Default text
CurrentPlayerNumberLabel.TextColor3 = Color3.fromRGB(0, 255, 55)
CurrentPlayerNumberLabel.TextSize = 14
CurrentPlayerNumberLabel.Font = Enum.Font.SourceSans
CurrentPlayerNumberLabel.Parent = Frame

local PlayersLabelB = Instance.new("TextLabel")
PlayersLabelB.Size = UDim2.new(1, -20, 0, 30)
PlayersLabelB.Position = UDim2.new(0, 10, 0, 179)
PlayersLabelB.TextColor3 = Color3.fromRGB(0, 255, 255)
PlayersLabelB.Text = "Player List:"
PlayersLabelB.TextSize = 14
PlayersLabelB.Font = Enum.Font.SourceSans
PlayersLabelB.Parent = Frame
PlayersLabelB.BackgroundTransparency = 1

local playerNo = Player:FindFirstChild("playerNumber")
local OrigPlayerNum = nil

if playerNo then
    OrigPlayerNum = playerNo.Value
    print("Original Player Number: " .. OrigPlayerNum)
    OriginalPlayerNumberLabel.Text = "Original PlayerNum: " .. OrigPlayerNum
    CurrentPlayerNumberLabel.Text = "Current PlayerNum: " .. playerNo.Value
else
    print("playerNumber not found.")
end

ChangeButton.MouseButton1Click:Connect(function()
    local newNum = tonumber(TextBox.Text)
    if newNum and newNum >= 1 and newNum <= 9 then
        playerNo.Value = newNum
        print("Player number changed to: " .. newNum)
        CurrentPlayerNumberLabel.Text = "Current PlayerNum: " .. newNum
    else
        print("Invalid player number. Enter a number between 1-9.")
    end
end)

ResetButton.MouseButton1Click:Connect(function()
    if OrigPlayerNum and playerNo then
        playerNo.Value = OrigPlayerNum
        print("Player number reset to: " .. OrigPlayerNum)
        CurrentPlayerNumberLabel.Text = "Current PlayerNum: " .. OrigPlayerNum
    else
        print("Cannot reset - original number unknown.")
    end
end)
