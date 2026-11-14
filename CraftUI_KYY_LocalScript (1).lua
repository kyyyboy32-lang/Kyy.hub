-- DIAGNOSTIK (LocalScript sementara di StarterPlayer > StarterPlayerScripts)
-- Menampilkan di layar komponen mana yang HILANG. Hapus skrip ini setelah masalah selesai.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "KyyDiag"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = playerGui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 330, 0, 300)
label.Position = UDim2.new(0.5, -165, 0, 10)
label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
label.BackgroundTransparency = 0.2
label.TextColor3 = Color3.new(1, 1, 1)
label.Font = Enum.Font.Code
label.TextSize = 14
label.TextXAlignment = Enum.TextXAlignment.Left
label.TextYAlignment = Enum.TextYAlignment.Top
label.Parent = gui

local function mark(ok)
	return ok and "OK     " or "HILANG "
end

local function check()
	local lines = {"DIAGNOSTIK KYY HUB", ""}
	local function add(name, ok)
		table.insert(lines, mark(ok) .. name)
	end

	-- dari server (MainScript)
	add("ReplicatedStorage.KyyHubAction", ReplicatedStorage:FindFirstChild("KyyHubAction") ~= nil)
	local stats = player:FindFirstChild("leaderstats")
	add("leaderstats (pemain)", stats ~= nil)
	for _, n in ipairs({"Ore", "Coins", "Pickaxe", "Bar", "PerfectBar", "Raid"}) do
		add("  leaderstats." .. n, stats ~= nil and stats:FindFirstChild(n) ~= nil)
	end
	add("Player.AutoBuy", player:FindFirstChild("AutoBuy") ~= nil)

	-- dari Workspace
	for _, n in ipairs({"Ores", "KillBricks", "SellPart", "AutoBuyPart", "RaidPart", "AutoRaidPart", "BossSpawn"}) do
		add("Workspace." .. n, workspace:FindFirstChild(n) ~= nil)
	end

	-- menu Hub
	add("Menu Hub (KyyHubGui)", playerGui:FindFirstChild("KyyHubGui") ~= nil)

	table.insert(lines, "")
	table.insert(lines, "Kalau ada HILANG: perbaiki yang paling atas dulu.")
	label.Text = table.concat(lines, "\n")
end

for _ = 1, 90 do
	check()
	task.wait(1)
end
gui:Destroy()
