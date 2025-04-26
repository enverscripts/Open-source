-- Önce bir ScreenGui ve Frame oluşturalım
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local player = Players.LocalPlayer

-- ScreenGui oluştur
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeamSelectorGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Ana Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.new(0, 0, 0) -- Siyah
frame.Parent = screenGui

-- X butonu
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100) -- Kırmızımsı beyaz karışımı
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- Takım butonları
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = frame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

-- X butonunun önüne boşluk eklemesin diye frame'in içine görünmez bir boş Frame koyalım
local spacer = Instance.new("Frame")
spacer.Size = UDim2.new(1, 0, 0, 40)
spacer.BackgroundTransparency = 1
spacer.Parent = frame

-- Teams'lerden butonları oluştur
for _, team in pairs(Teams:GetChildren()) do
    if team:IsA("Team") then
        local teamButton = Instance.new("TextButton")
        teamButton.Size = UDim2.new(0.8, 0, 0, 40)
        teamButton.BackgroundColor3 = Color3.new(1, 1, 1) -- Beyaz arka plan istersen bunu değiştirebiliriz
        teamButton.BackgroundTransparency = 1 -- Buton arkası şeffaf (isteğe göre değiştirebiliriz)
        teamButton.Text = team.Name
        teamButton.TextColor3 = Color3.new(1, 1, 1) -- Beyaz yazı
        teamButton.Parent = frame

        -- Takıma geçme
        teamButton.MouseButton1Click:Connect(function()
            player.Team = team
        end)
    end
end