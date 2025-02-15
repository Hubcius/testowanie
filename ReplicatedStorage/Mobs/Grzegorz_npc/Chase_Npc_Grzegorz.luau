--constants
local MAX_DISTANCE = math.huge  -- Set the maximum distance to infinity

--variables
local NPC = script.Parent  -- Reference to the NPC
local HumanoidRootPart = NPC.HumanoidRootPart  -- Reference to the NPC's HumanoidRootPart
local Players = game:GetService("Players")  -- Get the Players service
local isWaiting = false  -- Flag to prevent multiple damage instances

--functions
-- Connect a function to the NPC's Humanoid Touched event
NPC.Humanoid.Touched:Connect(function(hit)
	-- Check if the hit object has a Humanoid and if the NPC is not waiting
	if hit.Parent:FindFirstChild("Humanoid") and not isWaiting then
		isWaiting = true  -- Set the waiting flag to true
		hit.Parent.Humanoid.Health -= 10  -- Reduce the player's health by 10
		task.wait(1)  -- Wait for 1 second
		isWaiting = false  -- Reset the waiting flag
	end
end)

--main code
-- Main loop that runs every 0.1 seconds
while task.wait(0.1) do
	local closestPlayerHumanoidRootPart  -- Variable to store the closest player's HumanoidRootPart
	local closestDistance = MAX_DISTANCE  -- Initialize the closest distance to the maximum distance
	
	-- Iterate through all players
	for _, plr in pairs(Players:GetPlayers()) do
		-- Check if the player has a character with a Humanoid and if the player is alive
		if plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
			local PlayerHumanoidRootPart = plr.Character.HumanoidRootPart  -- Get the player's HumanoidRootPart
			local Distance = (HumanoidRootPart.Position - PlayerHumanoidRootPart.Position).Magnitude  -- Calculate the distance to the player
			
			-- Check if this player is closer than the previous closest player
			if Distance < closestDistance then
				closestPlayerHumanoidRootPart = PlayerHumanoidRootPart  -- Update the closest player's HumanoidRootPart
				closestDistance = Distance  -- Update the closest distance
			end
		end
	end
	
	-- If a closest player was found, move the NPC towards the player
	if closestPlayerHumanoidRootPart then
		NPC.Humanoid:MoveTo(closestPlayerHumanoidRootPart.Position)
	end
end