--constants
local MAX_DISTANCE = math.huge

--variables
local NPC = script.Parent
local HumanoidRootPart = NPC.HumanoidRootPart
local Players = game:GetService("Players")
local isWaiting = false

--functions
NPC.Humanoid.Touched:Connect(function(hit)
    if hit.Parent:FindFirstChild("Humanoid") and not isWaiting then
        isWaiting = true
        hit.Parent.Humanoid.Health -= 10
        task.wait(1)
        isWaiting = false
    end
end)

--main code
while task.wait(0.1) do
    local closestPlayerHumanoidRootPart
    local closestDistance = MAX_DISTANCE
    
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