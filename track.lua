local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local tracking = false
local tags = {}

function createBillboard(player)
	if tags[player] then return end

	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 200, 0, 60)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.Name = "TrackTag"
	billboard.Adornee = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, 0, 0.33, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.TextColor3 = Color3.new(1, 1, 1)
	nameLabel.TextScaled = true
	nameLabel.Text = player.Name
	nameLabel.Font = Enum.Font.SourceSansBold
	nameLabel.Parent = billboard

	local stateLabel = nameLabel:Clone()
	stateLabel.Position = UDim2.new(0, 0, 0.33, 0)
	stateLabel.Text = ""
	stateLabel.Parent = billboard

	local distLabel = nameLabel:Clone()
	distLabel.Position = UDim2.new(0, 0, 0.66, 0)
	distLabel.Text = ""
	distLabel.Parent = billboard

	tags[player] = {
		billboard = billboard,
		stateLabel = stateLabel,
		distLabel = distLabel
	}

	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		billboard.Adornee = player.Character.HumanoidRootPart
		billboard.Parent = player.Character
	end

	player.CharacterAdded:Connect(function(char)
		local hrp = char:WaitForChild("HumanoidRootPart", 5)
		if hrp then
			billboard.Adornee = hrp
			billboard.Parent = char
		end
	end)
end

function removeBillboard(player)
	if tags[player] then
		tags[player].billboard:Destroy()
		tags[player] = nil
	end
end

function startTracking()
	tracking = true
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			createBillboard(player)
		end
	end
end

function stopTracking()
	tracking = false
	for _, data in pairs(tags) do
		if data.billboard then
			data.billboard:Destroy()
		end
	end
	tags = {}
end

Players.PlayerAdded:Connect(function(player)
	if tracking and player ~= LocalPlayer then
		createBillboard(player)
	end
end)

Players.PlayerRemoving:Connect(function(player)
	removeBillboard(player)
end)

RunService.RenderStepped:Connect(function()
	if tracking then
		for player, data in pairs(tags) do
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				local pos1 = LocalPlayer.Character.HumanoidRootPart.Position
				local pos2 = player.Character.HumanoidRootPart.Position
				local distance = (pos1 - pos2).Magnitude
				data.distLabel.Text = math.floor(distance).." Metre uzaklıkta"
				local vel = player.Character.HumanoidRootPart.Velocity.Y
				if math.abs(vel) > 2 then
					data.stateLabel.Text = "Havada"
				else
					data.stateLabel.Text = "Yerde"
				end
			end
		end
	end
end)

LocalPlayer.Chatted:Connect(function(msg)
	msg = msg:lower()
	if msg == ":track" then
		startTracking()
	elseif msg == ":untrack" then
		stopTracking()
	end
end)