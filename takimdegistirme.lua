-- Roblox Executor için Sürüklenebilir + Açılır Kapanır Team GUI Script
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeamsService = game:GetService("Teams")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- RemoteEvent bul veya oluştur
local changeTeam = ReplicatedStorage:FindFirstChild("ChangeTeam")
if not changeTeam then
    changeTeam = Instance.new("RemoteEvent", ReplicatedStorage)
    changeTeam.Name = "ChangeTeam"
end

-- GUI oluştur
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "TeamGuiExecutor"
screenGui.ResetOnSpawn = false

-- Ana Frame
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true -- Sürüklenebilir yap

-- Aç/Kapa Butonu
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, 100, 0, 40)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.Text = "Team GUI"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 22
toggleButton.BorderSizePixel = 0

-- Layout (Butonları düzgün dizmek için)
local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top

-- Tüm takımlar için buton oluştur
for _, team in ipairs(TeamsService:GetChildren()) do
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(0, 250, 0, 50)
    button.Text = team.Name
    button.TextColor3 = Color3.fromRGB(0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 24
    button.BorderSizePixel = 0

    button.MouseButton1Click:Connect(function()
        -- Local team değiştir
        player.Team = team
        player.TeamColor = team.TeamColor

        -- Server'a bildir
        if changeTeam then
            changeTeam:FireServer(team.Name)
        end

        -- Yeniden doğ
        if player.Character then
            player.Character:BreakJoints()
        end
    end)
end

-- Açılır kapanır sistemi
local isOpen = true
toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    frame.Visible = isOpen
end)
