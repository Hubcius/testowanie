--constants
local MAX_DISTANCE = math.huge

--variables
local NPC = script.Parent
local HumanoidRootPart = NPC:WaitForChild("HumanoidRootPart")
local Players = game:GetService("Players")
local isWaiting = false
local boxSize = Vector3.new(10, 10, 10) 
local boxCenter = NPC.PrimaryPart.Position 

--functions
function ShowCloudMessage(message)
	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(10, 0, 2, 0)
	billboard.StudsOffset = Vector3.new(0,4, 0)
	billboard.Parent = NPC:WaitForChild("Head")

	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.Text = message
	textLabel.TextColor3=Color3.fromRGB(0, 0, 0)
	textLabel.TextScaled = true
	textLabel.BackgroundTransparency = 1
	textLabel.Parent = billboard
	task.wait(1)
end

function CollisionCheck()
	local HitBox=NPC:WaitForChild("HitBox")
	local partsInHitBox = workspace:GetPartBoundsInBox(HitBox.CFrame, HitBox.Size)
	for _, part in pairs(partsInHitBox) do
        local character = part.Parent
        if character:FindFirstChild("Humanoid") then
            local humanoid = character:FindFirstChild("Humanoid")
            print(character.Name .. " is inside the hitbox!")
        end
    end
end

--main code
while task.wait(0.1) do
	local closestPlayerHumanoidRootPart
	local closestDistance = MAX_DISTANCE
	CollisionCheck()
	for _, plr in pairs(Players:GetPlayers()) do
		if plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
			local PlayerHumanoidRootPart = plr.Character.HumanoidRootPart
			local Distance = (HumanoidRootPart.Position - PlayerHumanoidRootPart.Position).Magnitude

			if Distance < closestDistance then
				closestPlayerHumanoidRootPart = PlayerHumanoidRootPart
				closestDistance = Distance
			end
		end
	end

	if closestPlayerHumanoidRootPart then
		NPC.Humanoid:MoveTo(closestPlayerHumanoidRootPart.Position)
	end
end