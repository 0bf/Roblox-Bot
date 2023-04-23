_G.thingtosay = "FREE | BoogetFling | .gg/GC34hCkpcM" end
if not _G.shoption then _G.shoption = "largest" end
wait(5) if not game:IsLoaded() then game.Loaded:Wait() end

local lp = game.Players.LocalPlayer
repeat wait() until lp and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
local rservice = game:GetService("RunService")

coroutine.resume(coroutine.create(function() while wait(1) do pcall(function() for _,z in next, game.Players:GetPlayers() do if z ~= lp then for _,v in next, z.Backpack:GetDescendants() do if v:IsA'Sound' then v.TimePosition = nil end end end end end) end end)) 
coroutine.resume(coroutine.create(function() while wait(1) do pcall(function() for _,z in next, game.Players:GetPlayers() do if z ~= lp then if z.Character and z.Character:FindFirstChildOfClass("Tool") then for _,v in next, z.Character:GetDescendants() do if v:IsA'Sound' then v.TimePosition = nil end end end end end end) end end))

for _, z in next, game:GetDescendants() do if z:IsA "Seat" then z.Disabled = true end end

function addFling()
    for _, child in pairs(lp.Character:GetDescendants()) do if child:IsA'BasePart' then child.CustomPhysicalProperties = PhysicalProperties.new(1, 1, 1, 1, 1) end end
    local BG = Instance.new('BodyGyro', lp.Character.HumanoidRootPart)
    local BV = Instance.new('BodyVelocity', lp.Character.HumanoidRootPart)
    BG.P = 9e4
    BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    BG.cframe = lp.Character.HumanoidRootPart.CFrame
    BV.velocity = Vector3.new(0, 0, 0)
    BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
    spawn(function()
        while wait() do
            pcall(function()BG.cframe = lp.Character.HumanoidRootPart.CFrame end)
        end
    end)
    local BT = Instance.new("BodyThrust")
    BT.Parent = lp.Character.HumanoidRootPart
    BT.Force = Vector3.new(9e5, 9e5, 9e5)
    BT.Location = lp.Character.HumanoidRootPart.Position
end; addFling()

lp.CharacterAdded:Connect(function(model)
    repeat wait() until model and model:FindFirstChildOfClass("Humanoid")
    if model:FindFirstChild("HumanoidRootPart") then
        addFling()
    end
end)
rservice.Stepped:Connect(function()
    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
        if lp.Character:FindFirstChildOfClass("Humanoid").Sit == true then
            lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
        for _,z in next, lp.Character:GetChildren() do if z:IsA'BasePart' then z.CanCollide = false end end
    end
end)
coroutine.resume(coroutine.create(function()
    while wait(1) do
        pcall(function()
            for _,z in pairs(game.Players:GetPlayers()) do
                if z ~= lp then
                    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and z and z.Character and z.Character:FindFirstChildOfClass("Humanoid").Sit == false and z.Character:FindFirstChildOfClass("Humanoid").FloorMaterial ~= Enum.Material.Air then
                        spawn(function() pcall(function()
                        lp.Character:FindFirstChild("HumanoidRootPart").CFrame = z.Character:FindFirstChild("HumanoidRootPart").CFrame; wait(0.5); lp.Character:FindFirstChild("HumanoidRootPart").CFrame = z.Character:FindFirstChild("HumanoidRootPart").CFrame
                        end) end)
                        wait(1.5)
                    end
                end
            end
        end)
    end
end))
coroutine.resume(coroutine.create(function()
    while wait(3.8) do
        for _,z in next, game.Players:GetPlayers() do
            if z~=lp then
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(_G.thingtosay,"All")
                wait(3.8)
            end
        end
    end
end))
wait(65)
local GUIDs = {}
local maxPlayers = 0
local pagesToSearch = 100
local Http =
    game:GetService("HttpService"):JSONDecode(
    game:HttpGet(
        "https://games.roblox.com/v1/games/" ..
            game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100&cursor="
    )
)
for i = 1, pagesToSearch do
    for i, v in next, Http.data do
        if v.playing ~= v.maxPlayers and v.id ~= game.JobId then
            maxPlayers = v.maxPlayers
            table.insert(GUIDs, {id = v.id, users = v.playing})
        end
    end
    if Http.nextPageCursor ~= null then
        Http =
            game:GetService("HttpService"):JSONDecode(
            game:HttpGet(
                "https://games.roblox.com/v1/games/"
                ..
                game.PlaceId
                ..
                "/servers/Public?sortOrder=Asc&limit=100&cursor="
                ..
                Http.nextPageCursor
            )
        )
    else
        break
    end
end
if _G.shoption == "fastest" then
    wait() repeat wait() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, GUIDs[math.random(1, #GUIDs)].id, lp) until not lp
elseif _G.shoption == "smallest" then
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, GUIDs[#GUIDs].id, lp)
elseif _G.shoption == "largest" then
    wait() repeat wait() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, GUIDs[math.random(1, 3)].id, lp) until not lp
end
