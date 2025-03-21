-- made by Volatile :)

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false -- This makes the GUI persist after death
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local ChangeButton = Instance.new("TextButton")
local ResetButton = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local Credit = Instance.new("TextLabel")
local PlayerListFrame = Instance.new("Frame")
local OriginalPlayerNumberLabel = Instance.new("TextLabel")
local CurrentPlayerNumberLabel = Instance.new("TextLabel")
local PlayersLabelB = Instance.new("TextLabel")

ScreenGui.Parent = Player:WaitForChild("PlayerGui")

Frame.Size = UDim2.new(0, 210, 0, 390)
Frame.Position = UDim2.new(0.5, -150, 0.5, -225)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.1
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = Frame

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

local textBoxCorner = Instance.new("UICorner")
textBoxCorner.CornerRadius = UDim.new(0, 8)
textBoxCorner.Parent = TextBox

ChangeButton.Size = UDim2.new(1, -20, 0, 30)
ChangeButton.Position = UDim2.new(0, 10, 0, 80)
ChangeButton.Text = "Change PlayerNum"
ChangeButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ChangeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ChangeButton.Parent = Frame

local changeButtonCorner = Instance.new("UICorner")
changeButtonCorner.CornerRadius = UDim.new(0, 8)
changeButtonCorner.Parent = ChangeButton

ResetButton.Size = UDim2.new(1, -20, 0, 30)
ResetButton.Position = UDim2.new(0, 10, 0, 120)
ResetButton.Text = "Reset PlayerNum"
ResetButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
ResetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetButton.Parent = Frame

local resetButtonCorner = Instance.new("UICorner")
resetButtonCorner.CornerRadius = UDim.new(0, 8)
resetButtonCorner.Parent = ResetButton

Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.BackgroundTransparency = 1
Credit.Text = "Made by Volatile"
Credit.TextColor3 = Color3.fromRGB(200, 200, 200)
Credit.TextSize = 14
Credit.Font = Enum.Font.SourceSansItalic
Credit.Parent = Frame

PlayerListFrame.Size = UDim2.new(1, -20, 0, 160)
PlayerListFrame.Position = UDim2.new(0, 10, 0, 195)
PlayerListFrame.BackgroundTransparency = 1
PlayerListFrame.Parent = Frame

local playerListFrameCorner = Instance.new("UICorner")
playerListFrameCorner.CornerRadius = UDim.new(0, 8)
playerListFrameCorner.Parent = PlayerListFrame

local playerLabels = {}

local function updatePlayerList()
    for _, child in ipairs(PlayerListFrame:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    local yPos = 0
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer == Player then
            continue
        end

        local playerNum = "N/A"
        local playerNo = otherPlayer:FindFirstChild("playerNumber")
        if playerNo then
            playerNum = tostring(playerNo.Value)
        end

        local playerLabel = Instance.new("TextLabel")
        playerLabel.Size = UDim2.new(1, 0, 0, 30)
        playerLabel.Position = UDim2.new(0, 0, 0, yPos)
        playerLabel.Text = otherPlayer.Name .. ": " .. playerNum
        playerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        playerLabel.TextSize = 14
        playerLabel.Font = Enum.Font.SourceSans
        playerLabel.BackgroundTransparency = 1
        playerLabel.Parent = PlayerListFrame

        playerLabels[otherPlayer.UserId] = playerLabel

        yPos = yPos + 19
    end
end

local function updatePlayerNumberForNewPlayer(newPlayer)
    wait(3)
    local playerNum = "N/A"
    local playerNo = newPlayer:FindFirstChild("playerNumber")
    if playerNo then
        playerNum = tostring(playerNo.Value)
    end

    local playerLabel = playerLabels[newPlayer.UserId]
    if playerLabel then
        playerLabel.Text = newPlayer.Name .. ": " .. playerNum
    end
end

Players.PlayerAdded:Connect(function(newPlayer)
    updatePlayerList()
    updatePlayerNumberForNewPlayer(newPlayer)
end)

Players.PlayerRemoving:Connect(function()
    updatePlayerList()
end)

updatePlayerList()

OriginalPlayerNumberLabel.Size = UDim2.new(1, -20, 0, 30)
OriginalPlayerNumberLabel.Position = UDim2.new(0, 10, 0, 164)
OriginalPlayerNumberLabel.BackgroundTransparency = 1
OriginalPlayerNumberLabel.Text = "Original PlayerNum N/A"
OriginalPlayerNumberLabel.TextColor3 = Color3.fromRGB(255, 210, 55)
OriginalPlayerNumberLabel.TextSize = 14
OriginalPlayerNumberLabel.Font = Enum.Font.SourceSans
OriginalPlayerNumberLabel.Parent = Frame

CurrentPlayerNumberLabel.Size = UDim2.new(1, -20, 0, 30)
CurrentPlayerNumberLabel.Position = UDim2.new(0, 10, 0, 148)
CurrentPlayerNumberLabel.BackgroundTransparency = 1
CurrentPlayerNumberLabel.Text = "Current PlayerNum: N/A"
CurrentPlayerNumberLabel.TextColor3 = Color3.fromRGB(0, 255, 55)
CurrentPlayerNumberLabel.TextSize = 14
CurrentPlayerNumberLabel.Font = Enum.Font.SourceSans
CurrentPlayerNumberLabel.Parent = Frame

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
