local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "FlingGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 420, 0, 320)
frame.Position = UDim2.new(0.5, -210, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local uiCorner = Instance.new("UICorner", frame)
uiCorner.CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(0, 120, 255)
stroke.Thickness = 3

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Fling All Menü"
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextColor3 = Color3.new(0, 0, 0)

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.Gotham
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.ZIndex = 2
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(1, 0)
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local flingBtn = Instance.new("TextButton", frame)
flingBtn.Size = UDim2.new(0.7, 0, 0, 50)
flingBtn.Position = UDim2.new(0.15, 0, 0.4, 0)
flingBtn.Text = "Herkesi Flingle"
flingBtn.Font = Enum.Font.Gotham
flingBtn.TextSize = 20
flingBtn.TextColor3 = Color3.new(1, 1, 1)
flingBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
local flingCorner = Instance.new("UICorner", flingBtn)
flingCorner.CornerRadius = UDim.new(0, 10)

local signature = Instance.new("TextLabel", frame)
signature.Size = UDim2.new(1, 0, 0, 25)
signature.Position = UDim2.new(0, 0, 1, -25)
signature.BackgroundTransparency = 1
signature.Text = "Sydearr Sunar"
signature.Font = Enum.Font.Gotham
signature.TextSize = 14
signature.TextColor3 = Color3.new(0, 0, 0)

local flingActive = false
local connection

flingBtn.MouseButton1Click:Connect(function()
	if not flingActive then
		flingActive = true
		flingBtn.Text = "Durdur"
		flingBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

		connection = RunService.Heartbeat:Connect(function()
			local char = LocalPlayer.Character
			if not char or not char:FindFirstChild("HumanoidRootPart") then return end
			local root = char.HumanoidRootPart
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					local target = plr.Character.HumanoidRootPart
					root.CFrame = target.CFrame * CFrame.new(0, 0, 0)
					root.AssemblyLinearVelocity = Vector3.new(999999, 999999, 999999)
					for _, part in pairs(char:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end
		end)
	else
		flingActive = false
		if connection then connection:Disconnect() end
		flingBtn.Text = "Herkesi Flingle"
		flingBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
	end
end)

task.spawn(function()
	while task.wait(0.1) do
		local character = LocalPlayer.Character
		if character then
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
			local model = character:FindFirstAncestorWhichIsA("Model")
			if model and model:FindFirstChildOfClass("VehicleSeat") then
				for _, p in pairs(model:GetDescendants()) do
					if p:IsA("BasePart") then
						p.CanCollide = false
						p.Anchored = false
						local spin = p:FindFirstChild("Spin")
						if not spin then
							spin = Instance.new("BodyAngularVelocity")
							spin.Name = "Spin"
							spin.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
							spin.AngularVelocity = Vector3.new(0, 100, 0)
							spin.Parent = p
						end
					end
				end
			end
		end
	end
end)