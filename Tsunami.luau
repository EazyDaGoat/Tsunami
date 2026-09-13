


if not game:IsLoaded() then
	game.Loaded:Wait()
end
task.wait(1.00)
do
	local startupPlayers = game:GetService("Players")
	local startupPlayer = startupPlayers.LocalPlayer
	while not startupPlayer do
		startupPlayers:GetPropertyChangedSignal("LocalPlayer"):Wait()
		startupPlayer = startupPlayers.LocalPlayer
	end
	while true do
		local character = startupPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if humanoid and root and root.Parent then
			break
		end
		task.wait(0.10)
	end


	task.wait(1.00)
end

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local CoreGui = game:GetService("CoreGui")
local New = Instance.new
local U2,U2O,U2S=UDim2.new,UDim2.fromOffset,UDim2.fromScale
local V2=Vector2.new
local RGB=Color3.fromRGB
local TI=TweenInfo.new
local guiParent = (gethui and gethui()) or CoreGui
local camera = workspace.CurrentCamera
if not camera then
	workspace:GetPropertyChangedSignal(
		"CurrentCamera"
	):Wait()
	camera = workspace.CurrentCamera
end
local viewportSize = camera
	and camera.ViewportSize
	or V2(
		1920,
		1080
	)





local DEFAULT_WIDTH_SCALE = 0.50
local DEFAULT_HEIGHT_SCALE = 0.60
local FONT_SIZE_SCALE = 1.17188
local function isPhonePanelLayout()
	local currentCamera = workspace.CurrentCamera or camera
	local currentViewport = currentCamera and currentCamera.ViewportSize or viewportSize
	return UserInputService.TouchEnabled
		and math.min(currentViewport.X, currentViewport.Y) < 700
end

local px = (function()
	local startupPhoneLayout = UserInputService.TouchEnabled
		and math.min(viewportSize.X, viewportSize.Y) < 700
	local scale = startupPhoneLayout
		and (0.72 * (math.min(viewportSize.X, viewportSize.Y) / 390))
		or (viewportSize.Y / 768)
	return function(value)
		if value == 0 then return 0 end
		local scaled = math.floor((value * scale) + 0.5)
		if value > 0 then return math.max(1, scaled) end
		return math.min(-1, scaled)
	end
end)()

local responsiveTextSize = (function()
	local startupPhoneLayout = UserInputService.TouchEnabled
		and math.min(viewportSize.X, viewportSize.Y) < 700
	local referenceHeight = startupPhoneLayout and 844 or 768
	local scale = FONT_SIZE_SCALE * (viewportSize.Y / referenceHeight)
	return function(baseSize)
		return math.max(
			1,
			math.floor((baseSize * scale) + 0.5)
		)
	end
end)()

local function setResponsiveTextSize(object, baseSize)
	object.TextSize = responsiveTextSize(baseSize)
end
local BLACK = RGB(7, 7, 8)
local PINK = RGB(255, 0, 98)
local LOGO_FONT = Enum.Font.GothamBlack
local MENU_FONT = Enum.Font.Nunito
local MENU_FONT_FACE = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
local PANEL_FONT_FACE = MENU_FONT_FACE
local LOGO_FONT_FACE = (function()
	local fallback = Font.fromEnum(LOGO_FONT)
	local ok, face = pcall(function()
		local customAsset = getcustomasset or getsynasset
		if type(writefile) ~= "function" or type(customAsset) ~= "function" then
			return fallback
		end

		local ttfPath = "TuffHub_InsaniburgerRegular_v1.ttf"
		local familyPath = "TuffHub_InsaniburgerRegular_v1.font"
		local raw = game:HttpGet("https://www.1001fonts.com/download/font/insaniburger.regular.ttf")
		if type(raw) ~= "string" or #raw < 10000 then
			error("Insaniburger Regular download failed")
		end
		writefile(ttfPath, raw)

		writefile(
			familyPath,
			game:GetService("HttpService"):JSONEncode({
				name = "Insaniburger",
				faces = {{
					name = "Regular",
					weight = 400,
					style = "normal",
					assetId = customAsset(ttfPath),
				}},
			})
		)

		return Font.new(customAsset(familyPath))
	end)

	if not ok then
		warn("TuffHub: Insaniburger failed to load; using GothamBlack fallback: " .. tostring(face))
		return fallback
	end
	return face
end)()
local CORNER_RADIUS = px(12)
local LINE_THICKNESS = px(1)
local LINE_TRANSPARENCY = 0.28
local LINE_COLOR = RGB(44, 46, 51)
local TOGGLE_KEY = Enum.KeyCode.LeftControl
local SIDEBAR_PADDING = px(10)
local SIDEBAR_WIDTH_SCALE = 0.25
local COLLAPSED_SIDEBAR_WIDTH = px(64)
local LOGO_WIDTH = px(110)
local LOGO_HEIGHT = px(36)
local LOGO_TEXT_SIZE = 33.8
local LOGO_SEARCH_GAP = px(12)
local SEARCH_TOP_GAP = LOGO_SEARCH_GAP
local SEARCH_HEIGHT = px(36 * 0.85)
local SEARCH_CORNER_RADIUS = px(7)
local SEARCH_BACKGROUND = RGB(
		30,
		30,
		35
	)
local SEARCH_BACKGROUND_TRANSPARENCY = 0.34
local SEARCH_FOCUSED_TRANSPARENCY = 0.22
local SEARCH_TEXT_SIZE = 15
local MUTED_TEXT_COLOR = RGB(
		66,
		69,
		75
	)
local SEARCH_TEXT_COLOR = MUTED_TEXT_COLOR
local SEARCH_PLACEHOLDER_COLOR = MUTED_TEXT_COLOR
local SEARCH_ICON_SIZE = px(15)
local MENU_TOP_GAP = px(12)
local MENU_ITEM_HEIGHT = px(36)
local MENU_ITEM_GAP = px(8)
local MENU_TEXT_SIZE = 14
local MENU_CORNER_RADIUS = px(7)
local MENU_NORMAL_TRANSPARENCY = 1
local MENU_HOVER_TRANSPARENCY = 0.72
local MENU_SELECTED_TRANSPARENCY = SEARCH_BACKGROUND_TRANSPARENCY
local MENU_TEXT_IDLE = MUTED_TEXT_COLOR
local MENU_TEXT_SELECTED = RGB(228, 231, 236)
local MENU_TEXT_HOVER = RGB(172, 176, 184)
local MENU_ACTIVE_LINE_WIDTH = px(4)
local MENU_ACTIVE_LINE_HEIGHT = px(20)
local MENU_ICON_SIZE = px(17)
local MENU_ICON_X = px(11)
local MENU_TEXT_X = px(37)
local CONTENT_SIDE_PADDING = px(12)
local CONTENT_TOP_PADDING = px(56)
local CONTENT_COLUMN_GAP = px(10)
local CONTENT_ROW_GAP = px(10)
local PANEL_SCROLL_EDGE_INSET = px(2)
local PANEL_HEADER_HEIGHT = px(40)
local PANEL_EXPANDED_HEIGHT = px(128)
local PANEL_COLLAPSED_HEIGHT = PANEL_HEADER_HEIGHT
local PANEL_CORNER_RADIUS = px(10)
local PANEL_BACKGROUND = RGB(
		15,
		15,
		18
	)
local PANEL_CHEVRON_COLOR = MUTED_TEXT_COLOR
local FEATURE_OFF_COLOR=RGB(24,25,29)
local IS_MINIGAME_PLACE = game.PlaceId == 111917342868480
    or game.PlaceId == 131623223084840
local MINIGAME_AUTOPLAY_KEY = "__TUFFHUB_MINIGAME_AUTOPLAY"
local AUTO_OFFER_KEY = "__TUFFHUB_AUTO_OFFER"
local AUTO_ACCEPT_KEY = "__TUFFHUB_AUTO_ACCEPT"
local AUTO_SIT_KEY = "__TUFFHUB_AUTO_SIT"
local AUTO_CANCEL_KEY = "__TUFFHUB_AUTO_CANCEL"
local AUTO_SERVER_HOP_KEY = "__TUFFHUB_AUTO_SERVER_HOP"
local RARITY_OPTIONS = {
	"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythical",
	"Cosmic", "Secret", "Celestial", "Divine", "Infinity", "Meta", "Paradox",
	"Eternal", "Tokens",
}
local BRAINROT_RARITY_OPTIONS = {
	"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythical",
	"Cosmic", "Secret", "Celestial", "Divine", "Infinity", "Meta", "Paradox",
	"Eternal",
}
local minigameAutoplayState
local autoOfferState
local autoAcceptState
local autoSitState
local autoCancelState
local autoServerHopState
if IS_MINIGAME_PLACE then

	minigameAutoplayState = {}
	rawset(_G, MINIGAME_AUTOPLAY_KEY, minigameAutoplayState)
	for _, id in ipairs({
		"ConnectFour",
		"PopcornBurst",
		"FootballDraft",
		"CandyBomb",
		"Battleship",
		"NumberGuess",
		"Knockout",
	}) do
		minigameAutoplayState[id] = false
	end

	autoOfferState = {}
	rawset(_G, AUTO_OFFER_KEY, autoOfferState)
	for _, rarity in ipairs({
		"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythical",
		"Cosmic", "Secret", "Celestial", "Divine", "Infinity", "Meta", "Paradox",
		"Eternal",
	}) do
		autoOfferState[rarity] = {
			Enabled = false,
			Targets = {},
			Amounts = {},
			Tokens = 0,
		}
	end

	autoAcceptState = {}
	rawset(_G, AUTO_ACCEPT_KEY, autoAcceptState)
	for _, rarity in ipairs({
		"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythical",
		"Cosmic", "Secret", "Celestial", "Divine", "Infinity", "Meta", "Paradox",
		"Eternal",
	}) do
		autoAcceptState[rarity] = {
			Enabled = false,
			Amount = 1,
		}
	end
	autoAcceptState.Tokens = {
		Enabled = false,
		Amount = 1,
	}

	autoSitState = {
		EmptyTables = {
			Enabled = false,
		},
		OneOfTwo = {
			Enabled = false,
			Targets = {},
			Amounts = {},
			Tokens = 1,
		},
	}
	rawset(_G, AUTO_SIT_KEY, autoSitState)

	autoCancelState = {
		Enabled = false,
		Targets = {},
		Amounts = {},
	}
	rawset(_G, AUTO_CANCEL_KEY, autoCancelState)

	autoServerHopState = {
		Enabled = false,
		ServerTimeEnabled = false,
		ServerTime = 10,
		TimeSinceLastGameEnabled = false,
		TimeSinceLastGame = 3,
		WinWagerTimeAdded = 3,
		BoothPurchaseTimeAdded = 1,
		LeaveIfScriptUserInServer = true,


		RuntimeStartedAt = os.clock(),


		RuntimeBoothScriptRemoveUntil = {},
		RuntimeTempBlacklistedUserIds = {},
		RuntimeCanceledTradeCounts = {},
		RuntimeCanceledTradeLastCountAt = {},
		RuntimeUtilityToggleRows = {},



		RuntimeServerHopPending = false,
		RuntimeScriptUserHopRequested = false,
		RuntimeScriptUserIds = {},
		RuntimePresenceStartedAt = os.clock(),
		RuntimePresencePlayerSeenAt = {},
		RuntimeCheckServerHopRequested = false,
		RuntimeManualServerHopRequested = false,
		RuntimePlayedMinigameUserIds = {},
		RuntimeOwnedBrainrotOptionLabels = {},


		RuntimeAutoSitBusy = false,
		RuntimeBoothMutationBusy = false,
		RuntimeBoothMaxSlots = 3,
		RuntimeSettingsResetEpoch = 0,
		RecentServerIds = {},
	}
	rawset(_G, AUTO_SERVER_HOP_KEY, autoServerHopState)

	autoServerHopState.Utility = {

		AutoPlayMaster = false,
		AutoOfferMaster = false,
		AutoAcceptMaster = false,
		CustomDelays = false,



		AutoCancelMaster = false,
		AutoCancelCheckOpponentsBrainrots = false,
		AutoCancelTradeTimeoutEnabled = false,
		AutoCancelTradeTimeout = 60,
		AutoCancelNoValueTimeoutEnabled = false,
		AutoCancelNoValueTimeout = 15,
		AutoCancelBrainrotConditionDelay = 0,


		AutoOfferTokensEnabled = false,
		AutoOfferMatchTokensWithTokens = false,
		AutoOfferTokenAddRatio = 1,
		AutoOfferLowestTokensToMatch = 1,
		AutoOfferMatchTokensWithBrainrots = false,
		AutoOfferTokenAmount = 0,
		AutoOfferTokenRarity = nil,



		FallbackOffers = false,
		FallbackToTokens = false,
		FallbackToNextLowerRarityBrainrot = false,
		FallbackNextLowerRarityAmount = 1,
		FallbackTokensCommon = 0,
		FallbackTokensUncommon = 0,
		FallbackTokensRare = 0,
		FallbackTokensEpic = 0,
		FallbackTokensLegendary = 0,
		FallbackTokensMythical = 0,
		FallbackTokensCosmic = 0,
		FallbackTokensSecret = 0,
		FallbackTokensCelestial = 0,
		FallbackTokensDivine = 0,
		FallbackTokensInfinity = 0,
		FallbackTokensMeta = 0,
		FallbackTokensParadox = 0,
		FallbackTokensEternal = 0,

		AutoChat = false,
		AutoChatMessage = "",
		AutoChatMessageRevision = 0,
		AutoChatEditing = false,
		ChatInterval = 60,
		ChatIntervalMinutes = 1,
		AutoChatDoNotSendDuringActiveTrade = false,
		AutoChatExecutionDelay = 0,

		AutoTradeChat = false,
		AutoTradeMessage = "",
		AutoTradeMessageRevision = 0,
		AutoTradeChatEditing = false,
		AutoTradeMessageStartDelay = 1.125,
		AutoTradeRepeatMessage = false,
		AutoTradeRepeatInterval = 10,
		AutoTradeSendIfValueNotOffered = false,
		AutoTradeNoValueMessage = "",
		AutoTradeNoValueMessageRevision = 0,
		AutoTradeNoValueMessageEditing = false,
		AutoTradeNoValueDelay = 10,
		AutoTradeCustomRepliesEnabled = false,
		AutoTradeCustomReplies = {
			{LookFor = "", Reply = ""},
		},
		AutoDeleteWorstInventory = false,
		DeleteNonBrainrotsFirst = false,
		DeleteWorstBrainrotsFirst = false,
		DeleteInventoryThreshold = 95,
		NeverDeleteEnabled = false,
		NeverDeleteItems = {},


		AutoEquipBestBrainrot = false,
		EquipBestBrainrot = false,
		EquipBestMountableBrainrot = false,
		EquipSpecificBrainrot = false,
		SpecificBrainrotId = nil,
		MountBrainrotIfPossible = false,


		AutoshowBestBrainrots = false,
		AutoshowAllTokens = false,
		CustomOpeningOffer = false,
		OpeningOfferBrainrot1 = nil,
		OpeningOfferBrainrot2 = nil,
		OpeningOfferBrainrot3 = nil,
		OpeningOfferBrainrot4 = nil,
		OpeningOfferBrainrot5 = nil,
		OpeningOfferBrainrot6 = nil,


		InitialJoinDelay = 1.125,
		DelayAfterTradeMessage = 0.75,
		ReactionDelay = 1.6875,
		AddBrainrotDelay = 0.234375,
		RemoveBrainrotDelay = 0.1125,
		AddTokenDelay = 0,
		RemoveTokenDelay = 0,
		AcceptOfferDelay = 0.1875,


		AutoChooseGame = false,
		GameToChoose = "Popcorn Burst",
		MatchOpponentGame = false,
		FallbackGameChoices = {},
		AutoChooseRound1Delay = 0,
		AutoChooseRound2Delay = 2.5,
		AutoChooseRound3Delay = 5,
		AutoChooseRounds = false,
		RoundsToChoose = "1",
		MatchOpponentRounds = false,
		FallbackRoundChoices = {},


		LeaveWhenAboutToLose = false,
		PrintWinsLossesToTerminal = false,
		PrintKicksToTerminal = false,
		AutoReconnect = false,


		PauseMinigameFeatures = false,
		MoveDelayConnectFour = 0,
		MoveDelayFootballDraft = 0,
		MoveDelayCandyBomb = 0,
		MoveDelayBattleship = 0,
		MoveDelayNumberGuess = 0,
		MoveDelayKnockout = 0,


		TempBlacklistPlayersAfterCanceledTrade = false,
		TempBlacklistAfterCanceledTrades = 1,
		PermanentBlacklistPlayersAfterCanceledTrade = false,
		PermanentBlacklistAfterCanceledTrades = 3,
		PermanentBlacklistedUserIds = {},


		CheckServerHopNobodyServer = false,
		CheckServerHopPlayedEveryoneServer = false,
		CheckServerHopNobodyMinigamesArea = false,
		CheckServerHopPlayedEveryoneMinigamesArea = false,
		CheckServerBrainrotRarities = {},



		PauseScript = false,
		UndoAllSettings = false,
		GuiMinimized = false,
		PanelExpanded = {},


		AutoBooth = false,
		AutoBoothName = "",
		AutoBoothListBestFirst = false,
		AutoBoothListWorstFirst = true,
		AutoBoothAvoidTraits = {},
		AutoBoothAvoidMutations = {},
		AutoBoothAvoidBrainrots = {},
		AutoBoothSpecificOnly = false,
		AutoBoothSpecificBrainrots = {},
		AutoBoothMessageAllListingsCompleted = false,
		AutoBoothAllListingsCompletedMessage = "",
		AutoBoothAllListingsCompletedMessageDelay = 0,
		AutoBoothMessageAllPossibleCompleted = false,
		AutoBoothAllPossibleCompletedMessage = "",
		AutoBoothAllPossibleCompletedMessageDelay = 0,
		AutoBoothListing1Enabled = false,
		AutoBoothListing1Rarity = nil,
		AutoBoothListing1Tokens = 100,
		AutoBoothListing1InventoryThreshold = 95,
		AutoBoothListing1MessageWhenListed = false,
		AutoBoothListing1ListedMessage = "",
		AutoBoothListing2Enabled = false,
		AutoBoothListing2Rarity = nil,
		AutoBoothListing2Tokens = 100,
		AutoBoothListing2InventoryThreshold = 95,
		AutoBoothListing2MessageWhenListed = false,
		AutoBoothListing2ListedMessage = "",
		AutoBoothListing3Enabled = false,
		AutoBoothListing3Rarity = nil,
		AutoBoothListing3Tokens = 100,
		AutoBoothListing3InventoryThreshold = 95,
		AutoBoothListing3MessageWhenListed = false,
		AutoBoothListing3ListedMessage = "",
	}
	rawset(_G, "__TUFFHUB_UTILITY_FEATURES", autoServerHopState.Utility)

	do
		for index = 1, 14 do
			local prefix = "AutoBoothListing" .. tostring(index)
			if index >= 4 then
				autoServerHopState.Utility[prefix .. "Enabled"] = false
				autoServerHopState.Utility[prefix .. "Rarity"] = nil
				autoServerHopState.Utility[prefix .. "Tokens"] = 100
				autoServerHopState.Utility[prefix .. "InventoryThreshold"] = 95
				autoServerHopState.Utility[prefix .. "MessageWhenListed"] = false
				autoServerHopState.Utility[prefix .. "ListedMessage"] = ""
			end
			autoServerHopState.Utility[prefix .. "ListByRarity"] = true
			autoServerHopState.Utility[prefix .. "ListByBrainrot"] = false
			autoServerHopState.Utility[prefix .. "Brainrot"] = nil
			autoServerHopState.Utility[prefix .. "MinimumCopies"] = 1
			autoServerHopState.Utility[prefix .. "MessageDelay"] = 0
		end
	end


	autoServerHopState.BoothBrainrotOptions = function()
		local cached = autoServerHopState.RuntimeBoothBrainrotOptions
		if type(cached) == "table" then return cached end
		local options = {}
		pcall(function()
			local config = require(
				game:GetService("ReplicatedStorage")
					:WaitForChild("Shared")
					:WaitForChild("Config")
					:WaitForChild("Brainrots")
			)
			for _, name in ipairs(config.BrainrotNames or {}) do
				options[#options + 1] = tostring(name)
			end
		end)
		table.sort(options, function(a, b)
			return string.lower(a) < string.lower(b)
		end)
		autoServerHopState.RuntimeBoothBrainrotOptions = options
		return options
	end

	autoServerHopState.BoothTraitOptions = function()
		local cached = autoServerHopState.RuntimeBoothTraitOptions
		if type(cached) == "table" then return cached end
		local options = {}
		pcall(function()
			local traits = require(
				game:GetService("ReplicatedStorage")
					:WaitForChild("Shared")
					:WaitForChild("Traits")
			)
			for name in pairs(traits.Registry or {}) do
				options[#options + 1] = tostring(name)
			end
		end)
		table.sort(options, function(a, b)
			return string.lower(a) < string.lower(b)
		end)
		autoServerHopState.RuntimeBoothTraitOptions = options
		return options
	end

	autoServerHopState.BoothMutationOptions = function()
		local cached = autoServerHopState.RuntimeBoothMutationOptions
		if type(cached) == "table" then return cached end
		local options = {}
		pcall(function()
			local mutations = require(
				game:GetService("ReplicatedStorage")
					:WaitForChild("Shared")
					:WaitForChild("Mutations")
			)
			for name in pairs(mutations or {}) do
				if tostring(name) ~= "None" then
					options[#options + 1] = tostring(name)
				end
			end
		end)
		table.sort(options, function(a, b)
			return string.lower(a) < string.lower(b)
		end)
		autoServerHopState.RuntimeBoothMutationOptions = options
		return options
	end

	autoServerHopState.RefreshBoothMaxSlots = function()
		local maximum = tonumber(autoServerHopState.RuntimeBoothMaxSlots) or 3
		pcall(function()
			if not autoServerHopState.RuntimeBoothReplicator
				or not autoServerHopState.RuntimeGetMaxBoothSlots
			then
				local RS = game:GetService("ReplicatedStorage")
				autoServerHopState.RuntimeBoothReplicator = require(
					RS:WaitForChild("Client")
						:WaitForChild("Modules")
						:WaitForChild("ReplicatorClient")
				)
				autoServerHopState.RuntimeGetMaxBoothSlots = require(
					RS:WaitForChild("Shared")
						:WaitForChild("utils")
						:WaitForChild("GetMaxBoothSlots")
				)
			end
			local playerData =
				autoServerHopState.RuntimeBoothReplicator.get("PlayerData")
			local root = playerData and playerData:TryIndex({})
			if type(root) == "table" then
				maximum = math.clamp(
					math.floor(tonumber(
						autoServerHopState.RuntimeGetMaxBoothSlots(root)
					) or maximum),
					3,
					14
				)
			end
		end)
		autoServerHopState.RuntimeBoothMaxSlots = maximum
		return maximum
	end

	if IS_MINIGAME_PLACE then
		autoServerHopState.RefreshBoothMaxSlots()
	end

	autoServerHopState.RefreshOwnedBrainrotOptions = function()
		local labels = {}
		local options = {}
		local ok = pcall(function()
			local RS = game:GetService("ReplicatedStorage")
			local Replicator = require(
				RS:WaitForChild("Client")
					:WaitForChild("Modules")
					:WaitForChild("ReplicatorClient")
			)
			local GetItemType = require(
				RS:WaitForChild("Shared")
					:WaitForChild("utils")
					:WaitForChild("GetItemType")
			)
			local playerData = Replicator.get("PlayerData")
			local inventory = playerData and playerData:TryIndex({"Inventory"})
			if type(inventory) ~= "table" then return end

			local duplicateCounts = {}
			for _, item in pairs(inventory) do
				if type(item) == "table" then
					local itemType
					pcall(function() itemType = GetItemType(item) end)
					if itemType == "Brainrot" then
						local name = tostring(
							item.name
							or (item.sub and item.sub.name)
							or "Brainrot"
						)
						duplicateCounts[name] = (duplicateCounts[name] or 0) + 1
					end
				end
			end

			local seenNameIndex = {}
			for id, item in pairs(inventory) do
				if type(item) == "table" then
					local itemType
					pcall(function() itemType = GetItemType(item) end)
					if itemType == "Brainrot" then
						local sid = tostring(id)
						local name = tostring(
							item.name
							or (item.sub and item.sub.name)
							or sid
						)
						seenNameIndex[name] = (seenNameIndex[name] or 0) + 1
						labels[sid] = duplicateCounts[name] > 1
							and (name .. " #" .. tostring(seenNameIndex[name]))
							or name
						options[#options + 1] = sid
					end
				end
			end
		end)

		if not ok then
			table.clear(options)
			table.clear(labels)
		end
		table.sort(options, function(a, b)
			return string.lower(tostring(labels[a] or a))
				< string.lower(tostring(labels[b] or b))
		end)
		autoServerHopState.RuntimeOwnedBrainrotOptionLabels = labels
		return options
	end

	autoServerHopState.OwnedBrainrotOptionLabel = function(id)
		if id == nil then return "None" end
		local labels = autoServerHopState.RuntimeOwnedBrainrotOptionLabels
		return type(labels) == "table"
			and labels[tostring(id)]
			or tostring(id)
	end

	autoServerHopState.AllDeletableItemOptions = function()
		local names = {}
		local function addName(value)
			value = tostring(value or "")
			if value ~= "" and value ~= "RANDOM" then
				names[value] = true
			end
		end

		pcall(function()
			local RS = game:GetService("ReplicatedStorage")
			local shared = RS:WaitForChild("Shared")
			local config = shared:WaitForChild("Config")

			local brainrots = require(config:WaitForChild("Brainrots"))
			for _, name in ipairs(brainrots.BrainrotNames or {}) do
				addName(name)
			end

			local luckyBlocks = require(config:WaitForChild("LuckyBlocks"))
			for key, entry in pairs(luckyBlocks or {}) do
				if type(entry) == "table" then
					addName(
						entry.DisplayName
							or entry.displayName
							or (
								key == "Default"
									and "Lucky Block"
									or (tostring(key) .. " Lucky Block")
							)
					)
				end
			end

			local utilityItems = require(config:WaitForChild("UtilityItems"))
			for key, entry in pairs(utilityItems or {}) do
				addName(
					type(entry) == "table"
						and (entry.DisplayName or entry.displayName or key)
						or key
				)
			end

			local consumables = require(config:WaitForChild("Consumables"))
			for key, entry in pairs(consumables or {}) do
				addName(
					type(entry) == "table"
						and (entry.DisplayName or entry.displayName or key)
						or key
				)
			end

			local dice = require(config:WaitForChild("Dice"))
			for key, entry in pairs(dice or {}) do
				addName(
					type(entry) == "table"
						and (entry.DisplayName or entry.displayName or key)
						or key
				)
			end

			local baseSkins = require(config:WaitForChild("BaseSkins"))
			for key, entry in pairs(baseSkins.Skins or baseSkins or {}) do
				if type(entry) == "table" then
					addName(
						tostring(entry.displayName or entry.DisplayName or key)
							.. " Base Skin"
					)
				end
			end

			local boothSkins = require(config:WaitForChild("BoothSkins"))
			for key, entry in pairs(boothSkins.Skins or boothSkins or {}) do
				if type(entry) == "table" then
					addName(
						tostring(entry.displayName or entry.DisplayName or key)
							.. " Booth Skin"
					)
				end
			end

			pcall(function()
				local gearModule = require(
					RS:WaitForChild("SharedModules"):WaitForChild("GearModule")
				)
				for _, name in ipairs(gearModule.GearNames or {}) do
					addName(name)
				end
			end)


			local ItemToString = require(
				shared:WaitForChild("utils"):WaitForChild("ItemToString")
			)
			local Replicator = require(
				RS:WaitForChild("Client")
					:WaitForChild("Modules")
					:WaitForChild("ReplicatorClient")
			)
			local playerData = Replicator.get("PlayerData")
			local inventory = playerData and playerData:TryIndex({"Inventory"})
			for _, item in pairs(type(inventory) == "table" and inventory or {}) do
				if type(item) == "table" then
					local displayName
					pcall(function()
						displayName = ItemToString(item, {
							rich = false,
							displayLevel = false,
							displayMutation = false,
						})
					end)
					addName(
						displayName
							or item.name
							or (item.sub and item.sub.name)
							or item.displayName
							or item.DisplayName
					)
				end
			end
		end)

		local options = {}
		for name in pairs(names) do
			options[#options + 1] = name
		end
		table.sort(options, function(a, b)
			return string.lower(a) < string.lower(b)
		end)
		return options
	end

	autoServerHopState.RecordCanceledTrade = function(userId)
		userId = tonumber(userId)
		local localPlayer = game:GetService("Players").LocalPlayer
		if not userId
			or userId <= 0
			or (localPlayer and userId == localPlayer.UserId)
		then
			return false
		end

		local utility = autoServerHopState.Utility
		if utility.TempBlacklistPlayersAfterCanceledTrade ~= true
			and utility.PermanentBlacklistPlayersAfterCanceledTrade ~= true
		then
			return false
		end

		local key = tostring(userId)
		local now = os.clock()
		autoServerHopState.RuntimeCanceledTradeLastCountAt =
			autoServerHopState.RuntimeCanceledTradeLastCountAt or {}
		local lastCountedAt =
			tonumber(autoServerHopState.RuntimeCanceledTradeLastCountAt[key]) or -math.huge



		if now - lastCountedAt < 2.0 then
			return false
		end
		autoServerHopState.RuntimeCanceledTradeLastCountAt[key] = now

		autoServerHopState.RuntimeCanceledTradeCounts =
			autoServerHopState.RuntimeCanceledTradeCounts or {}
		local count =
			(math.floor(tonumber(autoServerHopState.RuntimeCanceledTradeCounts[key]) or 0) + 1)
		autoServerHopState.RuntimeCanceledTradeCounts[key] = count

		if utility.TempBlacklistPlayersAfterCanceledTrade == true then
			local threshold = math.clamp(
				math.floor(tonumber(utility.TempBlacklistAfterCanceledTrades) or 1),
				1,
				10
			)
			if count >= threshold then
				autoServerHopState.RuntimeTempBlacklistedUserIds =
					autoServerHopState.RuntimeTempBlacklistedUserIds or {}
				autoServerHopState.RuntimeTempBlacklistedUserIds[key] = true
			end
		end

		if utility.PermanentBlacklistPlayersAfterCanceledTrade == true then
			local threshold = math.clamp(
				math.floor(tonumber(utility.PermanentBlacklistAfterCanceledTrades) or 3),
				1,
				10
			)
			if count >= threshold then
				utility.PermanentBlacklistedUserIds =
					type(utility.PermanentBlacklistedUserIds) == "table"
						and utility.PermanentBlacklistedUserIds
						or {}
				utility.PermanentBlacklistedUserIds[key] = true
			end
		end
		return true
	end

	;(function()
		local HttpService = game:GetService("HttpService")
		local SETTINGS_FILE = "TuffHub_Settings_v1.json"
		local MEMORY_KEY = "__TUFFHUB_PERSISTED_SETTINGS_V1"
		local SAVE_KEY = "__TUFFHUB_SAVE_SETTINGS_NOW"
		local GENERATION_KEY = "__TUFFHUB_SETTINGS_SAVE_GENERATION_V1"
		local generation = {}
		local lastEncoded
		local lastDiskWriteAt = 0

		rawset(_G, GENERATION_KEY, generation)

		local function environmentFunction(name)
			local environments = {_G}
			pcall(function()
				if getgenv then environments[#environments + 1] = getgenv() end
			end)
			pcall(function()
				if getrenv then environments[#environments + 1] = getrenv() end
			end)
			pcall(function()
				if getfenv then environments[#environments + 1] = getfenv(0) end
			end)
			for _, environment in ipairs(environments) do
				if type(environment) == "table" then
					local ok, value = pcall(function()
						return environment[name]
					end)
					if ok and type(value) == "function" then
						return value
					end
				end
			end
		end

		local readFile = environmentFunction("readfile")
		local writeFile = environmentFunction("writefile")

		local function copyJsonSafe(value, seen)
			local valueType = type(value)
			if valueType == "boolean"
				or valueType == "number"
				or valueType == "string"
				or value == nil
			then
				return value
			end
			if valueType ~= "table" then return nil end

			seen = seen or {}
			if seen[value] then return nil end
			seen[value] = true

			local copy = {}
			for key, child in pairs(value) do
				local keyType = type(key)
				if keyType == "string" or keyType == "number" then
					local safeChild = copyJsonSafe(child, seen)
					if safeChild ~= nil then copy[key] = safeChild end
				end
			end
			seen[value] = nil
			return copy
		end

		local utilityKeys = {
			"AutoPlayMaster",
			"AutoOfferMaster",
			"AutoAcceptMaster",
			"CustomDelays",
			"AutoCancelMaster",
			"AutoCancelCheckOpponentsBrainrots",
			"AutoCancelTradeTimeoutEnabled",
			"AutoCancelTradeTimeout",
			"AutoCancelNoValueTimeoutEnabled",
			"AutoCancelNoValueTimeout",
			"AutoCancelBrainrotConditionDelay",
			"AutoOfferTokensEnabled",
			"AutoOfferMatchTokensWithTokens",
			"AutoOfferTokenAddRatio",
			"AutoOfferLowestTokensToMatch",
			"AutoOfferMatchTokensWithBrainrots",
			"AutoOfferTokenAmount",
			"AutoOfferTokenRarity",
			"FallbackOffers",
			"FallbackToTokens",
			"FallbackToNextLowerRarityBrainrot",
			"FallbackNextLowerRarityAmount",
			"FallbackTokensCommon",
			"FallbackTokensUncommon",
			"FallbackTokensRare",
			"FallbackTokensEpic",
			"FallbackTokensLegendary",
			"FallbackTokensMythical",
			"FallbackTokensCosmic",
			"FallbackTokensSecret",
			"FallbackTokensCelestial",
			"FallbackTokensDivine",
			"FallbackTokensInfinity",
			"FallbackTokensMeta",
			"FallbackTokensParadox",
			"FallbackTokensEternal",
			"AutoChat",
			"AutoChatMessage",
			"ChatInterval",
			"ChatIntervalMinutes",
			"AutoChatDoNotSendDuringActiveTrade",
			"AutoChatExecutionDelay",
			"AutoTradeChat",
			"AutoTradeMessage",
			"AutoTradeMessageStartDelay",
			"AutoTradeRepeatMessage",
			"AutoTradeRepeatInterval",
			"AutoTradeSendIfValueNotOffered",
			"AutoTradeNoValueMessage",
			"AutoTradeNoValueDelay",
			"AutoTradeCustomRepliesEnabled",
			"AutoTradeCustomReplies",
			"AutoDeleteWorstInventory",
			"DeleteNonBrainrotsFirst",
			"DeleteWorstBrainrotsFirst",
			"DeleteInventoryThreshold",
			"NeverDeleteEnabled",
			"NeverDeleteItems",
			"AutoEquipBestBrainrot",
			"EquipBestBrainrot",
			"EquipBestMountableBrainrot",
			"EquipSpecificBrainrot",
			"SpecificBrainrotId",
			"MountBrainrotIfPossible",
			"AutoshowBestBrainrots",
			"AutoshowAllTokens",
			"CustomOpeningOffer",
			"OpeningOfferBrainrot1",
			"OpeningOfferBrainrot2",
			"OpeningOfferBrainrot3",
			"OpeningOfferBrainrot4",
			"OpeningOfferBrainrot5",
			"OpeningOfferBrainrot6",
			"InitialJoinDelay",
			"DelayAfterTradeMessage",
			"ReactionDelay",
			"AddBrainrotDelay",
			"RemoveBrainrotDelay",
			"AddTokenDelay",
			"RemoveTokenDelay",
			"AcceptOfferDelay",
			"AutoChooseGame",
			"GameToChoose",
			"MatchOpponentGame",
			"FallbackGameChoices",
			"AutoChooseRound1Delay",
			"AutoChooseRound2Delay",
			"AutoChooseRound3Delay",
			"AutoChooseRounds",
			"RoundsToChoose",
			"MatchOpponentRounds",
			"FallbackRoundChoices",
			"LeaveWhenAboutToLose",
			"PrintWinsLossesToTerminal",
			"PrintKicksToTerminal",
			"AutoReconnect",
			"PauseMinigameFeatures",
			"MoveDelayConnectFour",
			"MoveDelayFootballDraft",
			"MoveDelayCandyBomb",
			"MoveDelayBattleship",
			"MoveDelayNumberGuess",
			"MoveDelayKnockout",
			"TempBlacklistPlayersAfterCanceledTrade",
			"TempBlacklistAfterCanceledTrades",
			"PermanentBlacklistPlayersAfterCanceledTrade",
			"PermanentBlacklistAfterCanceledTrades",
			"PermanentBlacklistedUserIds",
			"CheckServerHopNobodyServer",
			"CheckServerHopPlayedEveryoneServer",
			"CheckServerHopNobodyMinigamesArea",
			"CheckServerHopPlayedEveryoneMinigamesArea",
			"CheckServerBrainrotRarities",
			"PauseScript",
			"GuiMinimized",
			"PanelExpanded",
			"AutoBooth",
			"AutoBoothName",
			"AutoBoothListBestFirst",
			"AutoBoothListWorstFirst",
			"AutoBoothAvoidTraits",
			"AutoBoothAvoidMutations",
			"AutoBoothAvoidBrainrots",
			"AutoBoothSpecificOnly",
			"AutoBoothSpecificBrainrots",
			"AutoBoothMessageAllListingsCompleted",
			"AutoBoothAllListingsCompletedMessage",
			"AutoBoothAllListingsCompletedMessageDelay",
			"AutoBoothMessageAllPossibleCompleted",
			"AutoBoothAllPossibleCompletedMessage",
			"AutoBoothAllPossibleCompletedMessageDelay",
			"AutoBoothListing1Enabled",
			"AutoBoothListing1Rarity",
			"AutoBoothListing1Tokens",
			"AutoBoothListing1InventoryThreshold",
			"AutoBoothListing1MessageWhenListed",
			"AutoBoothListing1ListedMessage",
			"AutoBoothListing2Enabled",
			"AutoBoothListing2Rarity",
			"AutoBoothListing2Tokens",
			"AutoBoothListing2InventoryThreshold",
			"AutoBoothListing2MessageWhenListed",
			"AutoBoothListing2ListedMessage",
			"AutoBoothListing3Enabled",
			"AutoBoothListing3Rarity",
			"AutoBoothListing3Tokens",
			"AutoBoothListing3InventoryThreshold",
			"AutoBoothListing3MessageWhenListed",
			"AutoBoothListing3ListedMessage",
		}
		for index = 4, 14 do
			local prefix = "AutoBoothListing" .. tostring(index)
			utilityKeys[#utilityKeys + 1] = prefix .. "Enabled"
			utilityKeys[#utilityKeys + 1] = prefix .. "Rarity"
			utilityKeys[#utilityKeys + 1] = prefix .. "Tokens"
			utilityKeys[#utilityKeys + 1] = prefix .. "InventoryThreshold"
			utilityKeys[#utilityKeys + 1] = prefix .. "MessageWhenListed"
			utilityKeys[#utilityKeys + 1] = prefix .. "ListedMessage"
		end
		for index = 1, 14 do
			local prefix = "AutoBoothListing" .. tostring(index)
			utilityKeys[#utilityKeys + 1] = prefix .. "ListByRarity"
			utilityKeys[#utilityKeys + 1] = prefix .. "ListByBrainrot"
			utilityKeys[#utilityKeys + 1] = prefix .. "Brainrot"
			utilityKeys[#utilityKeys + 1] = prefix .. "MinimumCopies"
			utilityKeys[#utilityKeys + 1] = prefix .. "MessageDelay"
		end

		local function snapshotSettings()
			local utility = {}
			for _, key in ipairs(utilityKeys) do
				utility[key] = copyJsonSafe(autoServerHopState.Utility[key])
			end
			return {
				Version = 2,
				MinigameAutoplay = copyJsonSafe(minigameAutoplayState),
				AutoOffer = copyJsonSafe(autoOfferState),
				AutoAccept = copyJsonSafe(autoAcceptState),
				AutoSit = copyJsonSafe(autoSitState),
				AutoCancel = copyJsonSafe(autoCancelState),
				ServerHop = {
					Enabled = autoServerHopState.Enabled == true,
					ServerTimeEnabled = autoServerHopState.ServerTimeEnabled == true,
					ServerTime = tonumber(autoServerHopState.ServerTime) or 10,
					TimeSinceLastGameEnabled =
						autoServerHopState.TimeSinceLastGameEnabled == true,
					TimeSinceLastGame =
						tonumber(autoServerHopState.TimeSinceLastGame) or 3,
					WinWagerTimeAdded =
						tonumber(autoServerHopState.WinWagerTimeAdded) or 3,
					BoothPurchaseTimeAdded =
						tonumber(autoServerHopState.BoothPurchaseTimeAdded) or 1,
					LeaveIfScriptUserInServer = autoServerHopState.LeaveIfScriptUserInServer == true,
					RecentServerIds = copyJsonSafe(autoServerHopState.RecentServerIds),
					Utility = utility,
				},
			}
		end

		local defaultSnapshot = snapshotSettings()

		local function mergeInto(target, saved)
			if type(target) ~= "table" or type(saved) ~= "table" then return end
			for key, value in pairs(saved) do
				local valueType = type(value)
				if valueType == "table" then
					if type(target[key]) ~= "table" then target[key] = {} end
					mergeInto(target[key], value)
				elseif valueType == "boolean"
					or valueType == "number"
					or valueType == "string"
				then
					target[key] = value
				end
			end
		end

		local function applySnapshot(saved)
			if type(saved) ~= "table" then return false end
			mergeInto(minigameAutoplayState, saved.MinigameAutoplay)
			mergeInto(autoOfferState, saved.AutoOffer)
			mergeInto(autoAcceptState, saved.AutoAccept)
			mergeInto(autoSitState, saved.AutoSit)
			mergeInto(autoCancelState, saved.AutoCancel)

			local serverHop = saved.ServerHop
			if type(serverHop) == "table" then
				if type(serverHop.Enabled) == "boolean" then
					autoServerHopState.Enabled = serverHop.Enabled
				end
				if type(serverHop.ServerTimeEnabled) == "boolean" then
					autoServerHopState.ServerTimeEnabled = serverHop.ServerTimeEnabled
				end
				if type(serverHop.ServerTime) == "number" then
					autoServerHopState.ServerTime = serverHop.ServerTime
				end
				if type(serverHop.TimeSinceLastGameEnabled) == "boolean" then
					autoServerHopState.TimeSinceLastGameEnabled =
						serverHop.TimeSinceLastGameEnabled
				end
				if type(serverHop.TimeSinceLastGame) == "number" then
					autoServerHopState.TimeSinceLastGame =
						serverHop.TimeSinceLastGame
				end
				if type(serverHop.WinWagerTimeAdded) == "number" then
					autoServerHopState.WinWagerTimeAdded = serverHop.WinWagerTimeAdded
				end
				if type(serverHop.BoothPurchaseTimeAdded) == "number" then
					local boothAdded = serverHop.BoothPurchaseTimeAdded
					if (tonumber(saved.Version) or 1) < 2 then
						boothAdded = math.max(1, math.floor((boothAdded / 60) + 0.5))
					end
					autoServerHopState.BoothPurchaseTimeAdded = math.clamp(
						math.floor(tonumber(boothAdded) or 1),
						1,
						60
					)
				end
				if type(serverHop.LeaveIfScriptUserInServer) == "boolean" then
					autoServerHopState.LeaveIfScriptUserInServer = serverHop.LeaveIfScriptUserInServer
				end
				if type(serverHop.RecentServerIds) == "table" then
					autoServerHopState.RecentServerIds = {}
					for _, id in ipairs(serverHop.RecentServerIds) do
						if type(id) == "string" and id ~= "" then
							autoServerHopState.RecentServerIds[#autoServerHopState.RecentServerIds + 1] = id
						end
					end
				end
				local savedUtility = serverHop.Utility
				if type(savedUtility) == "table" then
					local filteredUtility = {}
					for _, key in ipairs(utilityKeys) do
						filteredUtility[key] = savedUtility[key]
					end
					mergeInto(autoServerHopState.Utility, filteredUtility)
				end

				if type(savedUtility) == "table" then



					if savedUtility.ChatIntervalMinutes == nil then
						local oldSeconds = tonumber(savedUtility.ChatInterval) or 60
						autoServerHopState.Utility.ChatIntervalMinutes = math.clamp(
							math.floor((oldSeconds / 60) + 0.5),
							1,
							5
						)
					end




					if savedUtility.AutoOfferTokenAmount == 1000
						and savedUtility.AutoOfferTokenRarity == nil
					then
						autoServerHopState.Utility.AutoOfferTokenAmount = 0
					end



					if savedUtility.AutoPlayMaster == nil then
						for _, enabled in pairs(minigameAutoplayState) do
							if enabled == true then
								autoServerHopState.Utility.AutoPlayMaster = true
								break
							end
						end
					end
					if savedUtility.AutoOfferMaster == nil then
						for _, config in pairs(autoOfferState) do
							if type(config) == "table" and config.Enabled == true then
								autoServerHopState.Utility.AutoOfferMaster = true
								break
							end
						end
					end
					if savedUtility.AutoAcceptMaster == nil then
						for _, config in pairs(autoAcceptState) do
							if type(config) == "table" and config.Enabled == true then
								autoServerHopState.Utility.AutoAcceptMaster = true
								break
							end
						end
					end
					if savedUtility.CustomDelays == nil then
						autoServerHopState.Utility.CustomDelays = true
					end




					if savedUtility.AutoCancelMaster == nil then
						autoServerHopState.Utility.AutoCancelMaster =
							autoCancelState.Enabled == true
					end
					if savedUtility.AutoCancelCheckOpponentsBrainrots == nil then
						autoServerHopState.Utility.AutoCancelCheckOpponentsBrainrots =
							autoCancelState.Enabled == true
					end
				end



				if type(savedUtility) == "table" then
					for index = 1, 14 do
						local prefix = "AutoBoothListing" .. tostring(index)
						local rarity = autoServerHopState.Utility[prefix .. "Rarity"]
						if savedUtility[prefix .. "Enabled"] == nil then
							autoServerHopState.Utility[prefix .. "Enabled"] =
								type(rarity) == "string" and rarity ~= ""
						end
						if savedUtility[prefix .. "InventoryThreshold"] == nil
							and type(savedUtility.AutoBoothInventoryThreshold) == "number"
						then
							autoServerHopState.Utility[prefix .. "InventoryThreshold"] =
								savedUtility.AutoBoothInventoryThreshold
						end
						if savedUtility[prefix .. "MessageWhenListed"] == nil
							and type(savedUtility.AutoBoothMessageWhenListed) == "boolean"
						then
							autoServerHopState.Utility[prefix .. "MessageWhenListed"] =
								savedUtility.AutoBoothMessageWhenListed
						end
						if savedUtility[prefix .. "ListedMessage"] == nil
							and type(savedUtility.AutoBoothListedMessage) == "string"
						then
							autoServerHopState.Utility[prefix .. "ListedMessage"] =
								savedUtility.AutoBoothListedMessage
						end
						if savedUtility[prefix .. "ListByRarity"] == nil
							and savedUtility[prefix .. "ListByBrainrot"] == nil
						then
							autoServerHopState.Utility[prefix .. "ListByRarity"] = true
							autoServerHopState.Utility[prefix .. "ListByBrainrot"] = false
						end
						if savedUtility[prefix .. "MinimumCopies"] == nil then
							autoServerHopState.Utility[prefix .. "MinimumCopies"] = 1
						end
						if savedUtility[prefix .. "MessageDelay"] == nil then
							autoServerHopState.Utility[prefix .. "MessageDelay"] =
								math.clamp(
									tonumber(savedUtility.AutoBoothMessageDelay) or 0,
									0,
									30
								)
						end
					end
					if savedUtility.AutoBoothAllListingsCompletedMessageDelay == nil then
						autoServerHopState.Utility.AutoBoothAllListingsCompletedMessageDelay =
							math.clamp(
								tonumber(savedUtility.AutoBoothMessageDelay) or 0,
								0,
								30
							)
					end
					if savedUtility.AutoBoothAllPossibleCompletedMessageDelay == nil then
						autoServerHopState.Utility.AutoBoothAllPossibleCompletedMessageDelay =
							math.clamp(
								tonumber(savedUtility.AutoBoothMessageDelay) or 0,
								0,
								30
							)
					end
				end
			end


			autoServerHopState.RuntimeStartedAt = os.clock()
			autoServerHopState.Utility.AutoChatEditing = false
			autoServerHopState.Utility.AutoTradeChatEditing = false
			autoServerHopState.Utility.AutoChatMessageRevision = 0
			autoServerHopState.Utility.AutoTradeMessageRevision = 0
			autoServerHopState.Utility._LastTradeMessageGuid = nil
			autoServerHopState.Utility._LastTradeMessageSentAt = nil
			autoServerHopState.Utility.UndoAllSettings = false
			autoServerHopState.RuntimeTempBlacklistedUserIds = {}
			autoServerHopState.RuntimeCanceledTradeCounts = {}
			autoServerHopState.RuntimeCanceledTradeLastCountAt = {}
			autoServerHopState.RuntimeUtilityToggleRows = {}
			autoServerHopState.RuntimeServerHopPending = false
			autoServerHopState.RuntimeScriptUserHopRequested = false
			autoServerHopState.RuntimeScriptUserIds = {}
			autoServerHopState.RuntimePresenceStartedAt = os.clock()
			autoServerHopState.RuntimeCheckServerHopRequested = false
			autoServerHopState.RuntimeManualServerHopRequested = false
			autoServerHopState.RuntimePlayedMinigameUserIds = {}



			if autoServerHopState.Utility.EquipBestBrainrot == true
				and autoServerHopState.Utility.EquipBestMountableBrainrot == true
			then
				autoServerHopState.Utility.EquipBestMountableBrainrot = false
			end
			if autoServerHopState.Utility.DeleteNonBrainrotsFirst == true
				and autoServerHopState.Utility.DeleteWorstBrainrotsFirst == true
			then
				autoServerHopState.Utility.DeleteWorstBrainrotsFirst = false
			end

			local gameFallbacks = autoServerHopState.Utility.FallbackGameChoices
			if type(gameFallbacks) == "table" then
				gameFallbacks[autoServerHopState.Utility.GameToChoose] = nil
			end
			local roundFallbacks = autoServerHopState.Utility.FallbackRoundChoices
			if type(roundFallbacks) == "table" then
				roundFallbacks[tostring(
					autoServerHopState.Utility.RoundsToChoose
				)] = nil
			end
			return true
		end



		if readFile then
			pcall(function()
				local encoded = readFile(SETTINGS_FILE)
				if type(encoded) == "string" and encoded ~= "" then
					applySnapshot(HttpService:JSONDecode(encoded))
				end
			end)
		end
		local memorySnapshot = rawget(_G, MEMORY_KEY)
		if type(memorySnapshot) == "table" then
			applySnapshot(memorySnapshot)
		end


		local function saveSettings(forceDisk)
			local snapshot = snapshotSettings()
			rawset(_G, MEMORY_KEY, snapshot)

			local ok, encoded = pcall(function()
				return HttpService:JSONEncode(snapshot)
			end)
			if not ok or type(encoded) ~= "string" then return false end
			if encoded == lastEncoded and not forceDisk then return true end

			if not writeFile then
				lastEncoded = encoded
				return true
			end

			local now = os.clock()
			if forceDisk or now - lastDiskWriteAt >= 0.20 then
				local wrote = pcall(writeFile, SETTINGS_FILE, encoded)
				if wrote then
					lastDiskWriteAt = now
					lastEncoded = encoded
					return true
				end
			end
			return false
		end

		local function resetAllSettingsState()
			local defaults = defaultSnapshot
			if type(defaults) ~= "table" then return false end

			table.clear(minigameAutoplayState)
			table.clear(autoOfferState)
			table.clear(autoAcceptState)
			table.clear(autoSitState)
			table.clear(autoCancelState)
			mergeInto(minigameAutoplayState, defaults.MinigameAutoplay)
			mergeInto(autoOfferState, defaults.AutoOffer)
			mergeInto(autoAcceptState, defaults.AutoAccept)
			mergeInto(autoSitState, defaults.AutoSit)
			mergeInto(autoCancelState, defaults.AutoCancel)

			local defaultServerHop = defaults.ServerHop or {}
			autoServerHopState.Enabled = defaultServerHop.Enabled == true
			autoServerHopState.ServerTimeEnabled = defaultServerHop.ServerTimeEnabled == true
			autoServerHopState.ServerTime = tonumber(defaultServerHop.ServerTime) or 10
			autoServerHopState.TimeSinceLastGameEnabled = defaultServerHop.TimeSinceLastGameEnabled == true
			autoServerHopState.TimeSinceLastGame = tonumber(defaultServerHop.TimeSinceLastGame) or 3
			autoServerHopState.WinWagerTimeAdded = tonumber(defaultServerHop.WinWagerTimeAdded) or 3
			autoServerHopState.BoothPurchaseTimeAdded = tonumber(defaultServerHop.BoothPurchaseTimeAdded) or 1
			autoServerHopState.LeaveIfScriptUserInServer = defaultServerHop.LeaveIfScriptUserInServer == true
			autoServerHopState.RecentServerIds = {}
			autoServerHopState.RuntimeTempBlacklistedUserIds = {}
			autoServerHopState.RuntimeCanceledTradeCounts = {}
			autoServerHopState.RuntimeCanceledTradeLastCountAt = {}
			autoServerHopState.RuntimeServerHopPending = false

			local defaultUtility = defaultServerHop.Utility or {}
			for _, key in ipairs(utilityKeys) do
				local value = copyJsonSafe(defaultUtility[key])
				if type(value) == "table" then
					autoServerHopState.Utility[key] = value
				else
					autoServerHopState.Utility[key] = value
				end
			end
			autoServerHopState.Utility.UndoAllSettings = false
			autoServerHopState.Utility.AutoChatEditing = false
			autoServerHopState.Utility.AutoTradeChatEditing = false
			autoServerHopState.Utility.AutoChatMessageRevision = 0
			autoServerHopState.Utility.AutoTradeMessageRevision = 0
			autoServerHopState.Utility._LastTradeMessageGuid = nil
			autoServerHopState.Utility._LastTradeMessageSentAt = nil
			autoServerHopState.RuntimeStartedAt = os.clock()
			autoServerHopState.RuntimeSettingsResetEpoch =
				(tonumber(autoServerHopState.RuntimeSettingsResetEpoch) or 0) + 1
			rawset(_G, MEMORY_KEY, nil)
			return saveSettings(true)
		end

		rawset(_G, "__TUFFHUB_RESET_ALL_SETTINGS_STATE", resetAllSettingsState)
		rawset(_G, SAVE_KEY, saveSettings)
		saveSettings(false)


		task.spawn(function()
			while rawget(_G, GENERATION_KEY) == generation do
				task.wait(0.25)
				saveSettings(false)
			end
		end)
	end)()
end
local PANEL_TWEEN_INFO = TI(
		0.16,
		Enum.EasingStyle.Quart,
		Enum.EasingDirection.Out
	)
local CONTROL_BUTTON_SIZE = px(34)
local CONTROL_BUTTON_GAP = px(6)
local CONTROL_TOP_MARGIN = px(10)
local CONTROL_RIGHT_MARGIN = CONTENT_SIDE_PADDING + PANEL_SCROLL_EDGE_INSET
local CONTROL_CORNER_RADIUS = px(8)
local CONTROL_BACKGROUND = RGB(
		18,
		19,
		23
	)
local CONTROL_HOVER_BACKGROUND = RGB(
		24,
		25,
		30
	)
local CONTROL_ICON_COLOR = RGB(
		92,
		96,
		105
	)
local CONTROL_ICON_HOVER_COLOR = RGB(
		140,
		144,
		152
	)
local oldGui = guiParent:FindFirstChild(
		"TuffHubGUI"
	)
if oldGui then
	oldGui:Destroy()
end
local screenGui = New("ScreenGui")
screenGui.Name = "TuffHubGUI"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 1000000
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = guiParent

;(function()
	local function saveAppliedSettings()
		local saver = rawget(_G, "__TUFFHUB_SAVE_SETTINGS_NOW")
		if type(saver) == "function" then pcall(saver, true) end
	end

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			task.defer(saveAppliedSettings)
		elseif input.KeyCode == Enum.KeyCode.Return
			or input.KeyCode == Enum.KeyCode.KeypadEnter
		then

			task.defer(saveAppliedSettings)
		end
	end)
end)()




if IS_MINIGAME_PLACE then
	do
		local oldUniversalKeys = {
			"__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V11",
			"__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V10",
			"__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V9",
			"__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V8",
			"__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V7",
			"__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V6",
			"__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V5",
			"__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V4",
			"__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V3",
			"__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V2",
			"__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V1",
		}
		for _, key in ipairs(oldUniversalKeys) do
			local controller = rawget(_G, key)
			if controller and type(controller.Destroy) == "function" then
				pcall(function() controller:Destroy() end)
			end
			rawset(_G, key, nil)
		end
	end
	do
		for _, key in ipairs({"__TSUNAMI_POPCORN_PERFECT_V14", "__TSUNAMI_POPCORN_PERFECT_V15", "__TSUNAMI_POPCORN_PERFECT_V16", "__TSUNAMI_POPCORN_PERFECT_V17"}) do
			local controller = rawget(_G, key)
			if controller and type(controller.Destroy) == "function" then
				pcall(function() controller:Destroy() end)
			end
			rawset(_G, key, nil)
		end
	end
	do
		for version = 1, 40 do
			local key = "__TSUNAMI_CLINCH_LOSS_HOP_V" .. tostring(version)
			local controller = rawget(_G, key)
			if controller and type(controller.Destroy) == "function" then
				pcall(function() controller:Destroy() end)
			end
			rawset(_G, key, nil)
		end
	end
end

local window = New("Frame")
window.Name = "Window"
window.AnchorPoint = V2(
		0.5,
		0.5
	)
window.BackgroundColor3 = BLACK
window.BackgroundTransparency = 0
window.BorderSizePixel = 0
window.ClipsDescendants = true
window.Active = true
window.Visible = autoServerHopState.Utility.GuiMinimized ~= true
window.Parent = screenGui
New("UIScale", window).Name = "ResponsiveWindowScale"
local function roundPixel(value)
	return math.floor(
		value + 0.5
	)
end
local function roundEvenPixel(value)
	local rounded = roundPixel(value)
	if rounded % 2 ~= 0 then
		rounded += 1
	end
	return rounded
end
local function currentWindowRenderScale()
	local responsiveWindowScale = window:FindFirstChild("ResponsiveWindowScale")
	return math.max(
		0.05,
		responsiveWindowScale and responsiveWindowScale.Scale or 1
	)
end

local function logicalPixelsForRenderedMinimum(renderedPixels)
	return math.max(
		1,
		math.ceil(renderedPixels / currentWindowRenderScale())
	)
end
local MIN_WIDTH = roundEvenPixel(
		viewportSize.X
			* DEFAULT_WIDTH_SCALE
	)
local MIN_HEIGHT = roundEvenPixel(
		viewportSize.Y
			* DEFAULT_HEIGHT_SCALE
	)
local FIXED_SIDEBAR_WIDTH = roundPixel(
		MIN_WIDTH
			* SIDEBAR_WIDTH_SCALE
	)
local sidebarCollapsed = false
local function getSidebarWidth()
	if sidebarCollapsed then
		return COLLAPSED_SIDEBAR_WIDTH
	end
	local currentWidth = window.Size.X.Offset
	return roundPixel(
		((currentWidth > 1) and currentWidth or MIN_WIDTH)
			* SIDEBAR_WIDTH_SCALE
	)
end
local FIXED_SIDEBAR_CONTENT_WIDTH = roundEvenPixel(
		FIXED_SIDEBAR_WIDTH
			* 0.90
	)
local FIXED_TAB_HIGHLIGHT_WIDTH = roundPixel(
	FIXED_SIDEBAR_WIDTH * 0.95
)
local FIXED_TAB_HIGHLIGHT_LEFT = roundPixel(
		(
			FIXED_SIDEBAR_WIDTH
				- FIXED_TAB_HIGHLIGHT_WIDTH
		)
			* 0.5
	)
local FIXED_ACTIVE_LINE_X = math.max(
		0,
		roundPixel(
			(
				FIXED_TAB_HIGHLIGHT_LEFT
					- MENU_ACTIVE_LINE_WIDTH
			)
				* 0.5
		)
	)
local FIXED_CONTROL_HOLDER_WIDTH = (CONTROL_BUTTON_SIZE * 2)
	+ CONTROL_BUTTON_GAP
window.Size = U2O(
		MIN_WIDTH,
		MIN_HEIGHT
	)
window.Position = U2S(0.5, 0.5)
local function applyDeviceWindowSize(
	recenter
)
	local currentCamera = workspace.CurrentCamera or camera
	local currentViewport = currentCamera and currentCamera.ViewportSize or viewportSize
	local responsiveWindowScale = window:FindFirstChild("ResponsiveWindowScale")
	local scale = math.max(
			0.05,
			math.min(
				currentViewport.X / math.max(1, viewportSize.X),
				currentViewport.Y / math.max(1, viewportSize.Y)
			)
		)
	if responsiveWindowScale then
		responsiveWindowScale.Scale = scale
	end
	window.Size = U2O(
			roundEvenPixel(
				(currentViewport.X * DEFAULT_WIDTH_SCALE) / scale
			),
			roundEvenPixel(
				(currentViewport.Y * DEFAULT_HEIGHT_SCALE) / scale
			)
		)
	if recenter then
		window.Position = U2S(0.5, 0.5)
	end
end
applyDeviceWindowSize(true)
camera:GetPropertyChangedSignal(
	"ViewportSize"
):Connect(function()
	applyDeviceWindowSize(
		true
	)
end)
local function ensureCorner(
	object,
	radius
)
	if not object:IsA("GuiObject") then
		return
	end
	local corner = object:FindFirstChildOfClass(
			"UICorner"
		)
	if not corner then
		corner = New("UICorner")
		corner.Parent = object
	end
	corner.CornerRadius = UDim.new(
			0,
			radius
		)
	return corner
end
rawset(_G, "__TUFFHUB_ENSURE_INPUT_BORDER", function(object)
	if not object:IsA("GuiObject") then
		return
	end
	local stroke = object:FindFirstChild("InputBorder")
	if not stroke then
		stroke = New("UIStroke")
		stroke.Name = "InputBorder"
		stroke.Parent = object
	end
	stroke.Color = RGB(58, 60, 66)
	stroke.Thickness = px(1)
	stroke.Transparency = 0.22
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.LineJoinMode = Enum.LineJoinMode.Round
	return stroke
end)
ensureCorner(
	window,
	CORNER_RADIUS
)
local outerBorderOverlay = New("Frame")
outerBorderOverlay.Name = "OuterBorderOverlay"
outerBorderOverlay.Position = U2O(
		px(1),
		px(1)
	)
outerBorderOverlay.Size = U2(
		1,
		-px(2),
		1,
		-px(2)
	)
outerBorderOverlay.BackgroundTransparency = 1
outerBorderOverlay.BorderSizePixel = 0
outerBorderOverlay.Active = false
outerBorderOverlay.ZIndex = 49999
outerBorderOverlay.Parent = window
ensureCorner(
	outerBorderOverlay,
	math.max(
		0,
		CORNER_RADIUS - 1
	)
)
local outerBorder = New("UIStroke")
outerBorder.Name = "OuterBorder"
outerBorder.Color = RGB(58, 60, 66)
outerBorder.Thickness = LINE_THICKNESS
outerBorder.Transparency = 0
outerBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
outerBorder.LineJoinMode = Enum.LineJoinMode.Round
outerBorder.Parent = outerBorderOverlay
local panelOpen = window.Visible
local guiDestroyed = false
local function setPanelOpen(open)
	if guiDestroyed then
		return
	end
	panelOpen = open
	window.Visible = open
	autoServerHopState.Utility.GuiMinimized = not open
	local saver = rawget(_G, "__TUFFHUB_SAVE_SETTINGS_NOW")
	if type(saver) == "function" then
		pcall(saver, true)
	end

	local restoreButton = screenGui:FindFirstChild("MinimizedTHButton")
	if restoreButton then
		restoreButton.Visible = not open
	end
end
local sidebar = New("Frame")
sidebar.Name = "LeftSidebar"
sidebar.Position = U2O(
		SIDEBAR_PADDING,
		SIDEBAR_PADDING
	)
sidebar.Size = U2(
		0,
		math.max(
			1,
			FIXED_SIDEBAR_WIDTH
				- (SIDEBAR_PADDING * 2)
		),
		1,
		-(SIDEBAR_PADDING * 2)
	)
sidebar.BackgroundTransparency = 1
sidebar.BorderSizePixel = 0
sidebar.ClipsDescendants = true
sidebar.ZIndex = 35000
sidebar.Parent = window
local sidebarSeparator = New("Frame")
sidebarSeparator.Name = "RightSeparator"
sidebarSeparator.AnchorPoint = V2(
		0,
		0
	)
sidebarSeparator.Position = U2O(
		FIXED_SIDEBAR_WIDTH,
		0
	)
sidebarSeparator.Size = U2(
		0,
		LINE_THICKNESS,
		1,
		0
	)
sidebarSeparator.BackgroundColor3 = LINE_COLOR
sidebarSeparator.BackgroundTransparency = LINE_TRANSPARENCY
sidebarSeparator.BorderSizePixel = 0
sidebarSeparator.ZIndex = 45010
sidebarSeparator.Parent = window
local sidebarLogoHolder = New("Frame")
sidebarLogoHolder.Name = "TuffHubLogo"
sidebarLogoHolder.AnchorPoint = V2(
		0.5,
		0.5
	)
sidebarLogoHolder.Size = U2O(
		LOGO_WIDTH,
		LOGO_HEIGHT
	)
sidebarLogoHolder.BackgroundTransparency = 1
sidebarLogoHolder.BorderSizePixel = 0
sidebarLogoHolder.ZIndex = 45000
sidebarLogoHolder.Parent = sidebar
New("UIScale", sidebarLogoHolder).Name = "AreaLogoScale"
local tuffLabel = New("TextLabel")
tuffLabel.Name = "Tuff"
tuffLabel.AnchorPoint = V2(
		1,
		0.5
	)
tuffLabel.Position = U2(
		0.5,
		0,
		0.5,
		0
	)
tuffLabel.Size = U2O(
		px(57),
		px(34)
	)
tuffLabel.BackgroundTransparency = 1
tuffLabel.BorderSizePixel = 0
tuffLabel.Text = "Tuff"
tuffLabel.TextColor3 = BLACK
tuffLabel.TextStrokeColor3 = PINK
tuffLabel.TextStrokeTransparency = 0
tuffLabel.FontFace = LOGO_FONT_FACE
setResponsiveTextSize(tuffLabel, LOGO_TEXT_SIZE)
tuffLabel.TextXAlignment = Enum.TextXAlignment.Right
tuffLabel.TextYAlignment = Enum.TextYAlignment.Center
tuffLabel.ZIndex = 45001
tuffLabel.Parent = sidebarLogoHolder
local hubLabel = New("TextLabel")
hubLabel.Name = "Hub"
hubLabel.AnchorPoint = V2(
		0,
		0.5
	)
hubLabel.Position = U2(
		0.5,
		0,
		0.5,
		0
	)
hubLabel.Size = U2O(
		px(48),
		px(34)
	)
hubLabel.BackgroundTransparency = 1
hubLabel.BorderSizePixel = 0
hubLabel.Text = "Hub"
hubLabel.TextColor3 = PINK
hubLabel.FontFace = LOGO_FONT_FACE
setResponsiveTextSize(hubLabel, LOGO_TEXT_SIZE)
hubLabel.TextXAlignment = Enum.TextXAlignment.Left
hubLabel.TextYAlignment = Enum.TextYAlignment.Center
hubLabel.ZIndex = 45001
hubLabel.Parent = sidebarLogoHolder
local compactTLabel = New("TextLabel")
compactTLabel.Name = "CompactT"
compactTLabel.AnchorPoint = V2(
		1,
		0.5
	)
compactTLabel.Position = U2(
		0.5,
		0,
		0.5,
		0
	)
compactTLabel.Size = U2O(
		px(18),
		px(30)
	)
compactTLabel.BackgroundTransparency = 1
compactTLabel.BorderSizePixel = 0
compactTLabel.Text = "T"
compactTLabel.TextColor3 = BLACK
compactTLabel.TextStrokeColor3 = PINK
compactTLabel.TextStrokeTransparency = 0
compactTLabel.FontFace = LOGO_FONT_FACE
setResponsiveTextSize(compactTLabel, 27.3)
compactTLabel.TextXAlignment = Enum.TextXAlignment.Right
compactTLabel.TextYAlignment = Enum.TextYAlignment.Center
compactTLabel.Visible = false
compactTLabel.ZIndex = 45002
compactTLabel.Parent = sidebarLogoHolder
local compactHLabel = New("TextLabel")
compactHLabel.Name = "CompactH"
compactHLabel.AnchorPoint = V2(
		0,
		0.5
	)
compactHLabel.Position = U2(
		0.5,
		0,
		0.5,
		0
	)
compactHLabel.Size = U2O(
		px(18),
		px(30)
	)
compactHLabel.BackgroundTransparency = 1
compactHLabel.BorderSizePixel = 0
compactHLabel.Text = "H"
compactHLabel.TextColor3 = PINK
compactHLabel.FontFace = LOGO_FONT_FACE
setResponsiveTextSize(compactHLabel, 27.3)
compactHLabel.TextXAlignment = Enum.TextXAlignment.Left
compactHLabel.TextYAlignment = Enum.TextYAlignment.Center
compactHLabel.Visible = false
compactHLabel.ZIndex = 45002
compactHLabel.Parent = sidebarLogoHolder
local logoToggleButton = New("TextButton")
logoToggleButton.Name = "LogoToggleButton"
logoToggleButton.Size = U2S(
		1,
		1
	)
logoToggleButton.BackgroundTransparency = 1
logoToggleButton.BorderSizePixel = 0
logoToggleButton.AutoButtonColor = false
logoToggleButton.Text = ""
logoToggleButton.ZIndex = 45003
logoToggleButton.Parent = sidebarLogoHolder
local LOGO_TOP_PADDING = px(12)
local logoDividerY = SIDEBAR_PADDING
	+ LOGO_TOP_PADDING
	+ LOGO_HEIGHT
	+ LOGO_SEARCH_GAP
sidebarLogoHolder.Position = U2O(
		roundPixel(((FIXED_SIDEBAR_WIDTH + LINE_THICKNESS) * 0.5) - SIDEBAR_PADDING),
		roundPixel((logoDividerY * 0.5) - SIDEBAR_PADDING)
	)
local searchY = logoDividerY
	+ LINE_THICKNESS
	+ SEARCH_TOP_GAP
	- SIDEBAR_PADDING
local logoDivider = New("Frame")
logoDivider.Name = "LogoDivider"
logoDivider.AnchorPoint = V2(
		0,
		0
	)
logoDivider.Position = U2O(
		0,
		logoDividerY
	)
logoDivider.Size = U2O(
		FIXED_SIDEBAR_WIDTH,
		LINE_THICKNESS
	)
logoDivider.BackgroundColor3 = LINE_COLOR
logoDivider.BackgroundTransparency = LINE_TRANSPARENCY
logoDivider.BorderSizePixel = 0
logoDivider.ZIndex = 45001
logoDivider.Parent = window
local searchHolder = New("Frame")
searchHolder.Name = "SearchBar"
searchHolder.AnchorPoint = V2(
		0.5,
		0
	)
searchHolder.Position = U2O(
		roundPixel((FIXED_SIDEBAR_WIDTH + LINE_THICKNESS) * 0.5),
		SIDEBAR_PADDING + searchY
	)
searchHolder.Size = U2O(
		FIXED_SIDEBAR_CONTENT_WIDTH,
		SEARCH_HEIGHT
	)
searchHolder.BackgroundColor3 = SEARCH_BACKGROUND
searchHolder.BackgroundTransparency = SEARCH_BACKGROUND_TRANSPARENCY
searchHolder.BorderSizePixel = 0
searchHolder.ClipsDescendants = true
searchHolder.ZIndex = 45001
searchHolder.Parent = window
ensureCorner(
	searchHolder,
	SEARCH_CORNER_RADIUS
)
rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(searchHolder)
local EMBEDDED_ICONS={
	Home=[[iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAABmJLR0QA/wD/AP+gvaeTAAADSElEQVR4nO2bvWsUQRjGnzGaBILR1mASPxBRE4KKWNhFUIhYBKzERlQICfFvsLQL2lmIgoWVaEATtQhYiIWViGmSEOMR0E4TLPLB/SxuI+Gcud3b27m5mP2VczvPPO+7s+/szu5JOdsbE2JQ4IikfkndkpC0IGnKGDMbwk/dAM4A73AzBZwO7dMLwDCwViH4DVaB4dB+MwNoAu4mCLycB8DO0P5rAmgDxlMEv8E40BY6jlQA+4CPNQS/wSegM3Q8VQH0AYWYwCaBfuA88Drm2ALQFzquRAAXgF8xAd0Dmjb1McCdmD7LwOWQscUC3KJypV8HRn31DwbJKn2iM0hpBv2M0WqcFYJSpX8RY3gROFWFZi+wEKM5CbT7jC2J0SSVPlUV96mdCfU4S3iYXZlAikpfw1iNtUIQqFKHGnezgcwqfQ0ewqwQNNC1SL1XCBqwGtfNE9BD/D19kCc2kj1pFoCetAN0AT9iBhgjg0qfFkp1aSzG4/dUMwF4W0F0HRjxEFMqgJHIk4uJagXPVRBbAgY8xZIaYCDy5uJsNWL3HSIN/VxO5X2IsWqEPlgEikCvR/+ZAJx0JOB9NSKzFoFvHn1nimMWzNiO3eHQsL0wWcvOondWLW3WWF0J2DZ43VUBWiXdkDQo6YCSv4pD0ryk55IeGmNWvBh0jg5zlmtorkqNbmDaUZCq4TPQ5cu/l0sAaJE0IelYBnI9kl5FmpnjqwbclHQ8Q70eSdcz1PuLrwQMbhFNb0Ww29K2JqmQsH+npF1lbQdrcuTAVwJsM6tgjDmcpHNUsA6VNXt56tz29wF5AkIbCE2egNAGQpMnILSB0OQJCG0gNHkCQhsITZ6A0AZCkycgtAFPJP4fhCsBvy1tHcCedH7qB7BXUoflpyXb8a4EfLG0tUp6FA3QkETeHkuybaBO2/pYpwpwTdITxzgrkhZjvNi2tGrdEkvSf7+kZsdvV40xT8sbXQlokTQTGfkf+CrpqDHmn1dm1ksgehMzJKno11ddKEoasgUvVVgFjDETkm5rayehKGnUGPMmtQKlLy/iPktrROaBi3HxJVovgWZJVyRdknRC0u4E3do3HbcsxzKUcf9llVawl5KeuaZ9Tk5OTk7EH99GZ0d1FvDFAAAAAElFTkSuQmCC]],
	Main=[[iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAABmJLR0QA/wD/AP+gvaeTAAAD70lEQVR4nO2bT6gVVRzHv0eflVmEoqYkRAVvo0/QdeHVQpC3yKXmQqKVL6i2uc3auHBn4EIIKqhFK99Cwv4Ltmhh/nmRUNGrCHkUZfog431azBm4XeY3c2bmzMy70/vu7r2/f59zzj3nzm/mSiv6f8t1XcCogJ2S9kh6RNKfkr6S9JFz7m6nhTUtYDvwKdn6CXiu6xobEzAAbhnww3qj61qjy8PfDoBPdajrmqOpAjzAj8BE17XXVkX4VM/EqmNVrEBlBAwkzUq63zD5WslJ8Jbx+e4GympHATN/GdjobfcaNq/FqqfVFRA480875xb86wOG3S+RS2teZWbe268C5g3bHV2ylBbwFPnn/H/gvc/AsL3eFUclVYH3fmcM+1e74KikGvD3AAsZ9kvAY12wlFZVeO970PD5om2OSqoD7/3fM/xm2uSopAjwD5J9WtwFNrfJUlp14X2Mo4bvbFsclRQD3sc5b/gfaYOjkiLCbyZZ6qO6DTzQBktpxYL3sV4yYrzTNEclxYT38S4ZcaabYqjcFKX8hU1RvCck3cioaVHSPklFTdGfnXO/huSqLUpe2ATGfCUnXqjmgBma7Bg1Ae/jnogwAKk+B9aPDbyPfTjiAAB8RsyV0CS8j38f8F3kQTgWC35Pk/BDebYD30ccgGtFOQtPAWCrpKuSNhgmpXb7gHxrJR2UtEPS6kC3dZJekLQ247OHnXM36xR0uumZjyHgTaPGnXWCrgZ+HwP4jcC3Rp2P1wk8aQSdW2bwl406F4DczndRW9y6ALkQ6ztfR34SLkiylvnbzrmlvBi5myDJBpjVg1+UdFbSXwF1StKSpOuSPnDO3Qn0yVUA/E1JU7U2QJ9ozlheVfQDMFWrIBUue0iO7Cfr5kmTzUQcgHQQso6rmPCDKPA+4QTJz8qYqvS0R+vwQ4k3RB6EE2MDP1TABHAMuBZhAF4umbsx+EoNEZL29LYC/zVKdumshsmkc+5GYK6i3f6OpGnn3Cch8VoTMG3M1pclYmwKmPl9TXJUFvBuneU/7vDryG6W/gNsCfAfX3hJAo4YhZ8P8B1veEkCZo3ijxb49QJ+E/B3RvGLwEMFfuMNL0nAiwbA+zk+/YCXJOCiAfGsYd8r+EdJHmMZ1W/AvRn2/YGXJOC4AXImw7Zf8JIEXDFgBiN2vYSfMmDmGerL0fVVXVPCvrd/cshm2cHHfFbY+ol7Tlq+V3UxbyPfMt5/nuQm5SlJVj9weV7SlhGwP2dp52k8v/OjAtZgP93db/hUlLvH3y/4VMDrAfB/9BI+FXCI5N9dWfoQmOy6xlSN/XWWZOcfSNolab2keUkfO+e+aSrnilZUXv8C6X11gNREwPYAAAAASUVORK5CYII=]],
	Settings=[[iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAABmJLR0QA/wD/AP+gvaeTAAAGx0lEQVR4nO2ba6hVRRTH/5Nve/qgUjOzfKQ91AxCNEGyNPIVaiWRldlLKEUL/RBUSKFm9LCo0B6EaAoFKpmv0jAzRIp836TCzFKuaamV18f59WH2pcO5M3P23mcfj5F/OF9mr1nrv2bP7FlrzRzpDP7fMJUwCnSQ1EtS66hpj6T1xpjvK8HnlAEYDGzAj6+A2yrNM3MAjYG5AccL8T7QuNK8MwHQAFiewPlaLAXqV5p/yQCmpXC+Fs9Vmn9JADoAx0sYgGPA5eXkeFY5lUsaJ8k1jXOSZksaJGmwpDlRWyEaSHq0bOzKDWCn580+4JB9yCNbVQnuJQNoCuQcDn0b6LPFIZ8DmpSLZzmXQE+5A62NgT4bHG1GUvdMGDmQeJsBWkvqIKmhpCOSthpjDhfINJD0rEfFpoD6rZ72qcBAY8yJAjvnSrpK0jmSjknaaYz5tbgXCYENZMYDmx1T9DiwDLgD6IKN9r7wrGeAjgE7XQL91gKDIpk7sbGFa4fZBDxOVoEUcB3+j1lSLIthb2VGtqqAHqU63xc4khGho8DVMWx2A2oysnkY6JPW+TbA/oyI5ID7Etgei3sHSYNq7Hcr8QDMy4jAX8DoFPbvB/7OiMO8pMbbAyc9yqqBl4DJwHzs1HbhBPAh0Cmp83k8OgMfRbpcOIp9UZOBl/HP2BPApS4bzoIIMEnSTMej7ZL6GWP25ck2l3STpGsktZR0QFKVpFVZbUlAK0k3S+ooqbmk/ZK2RDYO5sldLGm1pCsdaiYYY16Ja3C+ZyT7l+pMuQHc4uE+1yXvC4QucrSdlLSmRHL1JPWWNERSF0lto0e7JW2TtFjSl8aYkyWYWS0J1Z3dFyYhuswxgjmgWVpW2ADpO8/byUcVMBJIVa8EWnj0fuyS9+UCPzjajKQxKQg1jqbfYtk1XAydJC2UtABomtSepDqZZgSXT25gQ00XaoB7Euhpii10psV6EmSCwGj8QdTwJAPQFPgtQOyZGDoMsLAE52sxPybnqQEd1SRNqYGJRYgFlwMwIoZze6NfMdxexNaDRfqPT+R8pLQesCqg9BB2f/b19X3wjgPTgbZ58m2BGfgDnh3YHcRlqzXhfGU5kK7uAZwHfB5QPs3Tr2/Aee/BBzAkMAjOpAaYGeC3GlszSA9sXX+2x8CuhKSmx7Dn6zvDI7/HI/8WtjBTOoD62GnowiUO+U8ccjnypn3AVjvcmWCdfTySdWErniVTiFhrIypFLfI8djnlSj+rjTG7Y9jaJRvrF6KNo63O4EdYEjeaTPJxSBKZUWJ/Fy+XTldbqD2Wobra7BndUM9j11t1ZYEt8aSkBbbaSWrhePSLo22PR81QYp4rFh0AoKHsKY4rr99ljPnZ0b7F0WYkPRaDk2/PrqMzWi6uQegi6c2Ie3oAFxCu8D7v6XejR/4EMDhgbxj+bbC3p8+MAL+1wPlpna8PrAko/wNwpc21gVBVYBBmYqd6rXw74MWA89vxBDNAK2xQ5sOnxNwRChU/GVAKcG+R/sOL9AfYF/2KYVgRW2OK9J+Y1PmzgQMBhU/F0GHwV5aSwFnJcdh7OqBjP0mSIWCUR9FRYFQCPU2wKW1arEtCHLgbf5F2ZJIBeMOjZEJsJf/qaoy985MUH5CiIAJM8uh7PYmSFQ4FOdJ+Ua3O/thzu2LYQWklseYevc6SmC9YcCUROUl/piElScaYVdizul6yRdGuqlsUXSR7X9B1WyQuDnva4ydG/LfL4gM83BOVxTdKusvRPgvoZ4zZm2ewhaQBkq6V1EzS77IHIyvjJD9xgM0i+0vqHNnYL2mzpBXGmAN5cq0lvepR47p84TUYOho7AMwCpgAL8BchTwKLga4lON410uHjUhNxmAK8Bhz0yHmPxkLGs9jDwW5LY1M4Pxb/lpYUsWKJQgJZH48/nMD2I2R3PL4PT+0yDpE+2EsGWaAGKHrZCeiOvSCZBQ4BvVI5n0eoBzYZyQIrY9j7LCNbW4FuJTmfR6ohMA74xmGoBnuxeQT2auxAwllk54CdroF+a4BbIxsjsXVH10z5GruEsimIOki2xC6N/kBPHOEqNpV2RZMQCKeBJzx9luNIabFJ2/URlz7YLfn0ANDb48zbgT7vevrccCq5ZwL8V2U3e+QNsM0hX9arsmUF/uOxOlsi9hvjwo5KcM8E2DKXCzngHexR2FDgPc9sgRinSactgCsobU+vAdqXk2NZ/zAR/Q3uhRJUTDfG/JgVn4oAuyUuTfH2l5Cmmns6AmiEXfNxMQdoVGnemQMbJa4LOL4WuOVUcqrUX2cvky2N1ZbEfpIthTnvG5zBGZQP/wDjdMAWBVCAjgAAAABJRU5ErkJggg==]],
	Search=[[iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAABmJLR0QA/wD/AP+gvaeTAAAE00lEQVR4nO2bzW9VRRjGnyHYVsGIFi1sbZFQm+iG1GiVIm4a0pBoCMbAxn8AV25Uov8AC4O6cKU2TdzUj6CJMaFFF7AwYgohROPGBtoSiOWjl7Zc/bmYg1zKmTlzeuacW/H+km7uPed9nveduWfmzEylFi1a/J8xVYgAbZIel9QlaV3y96ekmqQpY8xUFT7SKKUAQKekIUk7JQ3IJr/Wc8t1SWckjUs6JmnCGFMvw1tpAAYYAr4AFinGNHAY6G52XkEAe4CfCyadRh0YAXqanWMqQDfwbQmJL+cG8C7Q0eyc/wV4BZirIPlGzgBPNjvxNcD7FSfeyFVgKFY+uUYB7HD2qaR9OW5bkHRS0mlJv0m6Kjv8bZDUKWmrpO2S8rTsTUmvG2NGctxTjKTlPw9spTowhn04Bv1ugc3AQWAyUOMvYG/ZeTcaDO32o8CWAjoGGAbOBmgtAIMR03Saei3AzBSwK6LmfcAh4GaG7gywKZZumpFu7IPHxwSwsST9HcDlDP3vgXKm9WSP819T8vgM9AIXMnwcKEN4T0DLVzI5AZ4Grni8zAAPxhb9ySM4RUnd3uNnGPjb4+nNmGJDGa0f7YGX09fHGb3g/lhCYx6h0SgiK/PVCVzyeMszSXOKPIIdY9OoA09EyKWIv7c9BTgaQ2C/R2AsQg5F/W0Aag5/i8ADobHWOD7f6bnnk3x242OMmZP0lePrNknPhcZyFWDA8fmCpO9Cg5fMl57vng8NclcBuL2AmcZJY8xCaPCSmfB8ty00SFoP6JZ7AfN0aOCyMcbMSpp1fL01NE5aAR71XP97aOCKcPnx5XAHaQXwTSfnQgNXhMtP8JQ4rQBtnusXQwNXhOt51B4aIK0ANc/160IDV4SrpedDA6QV4Jrn+sdCA1eEy8/V0ABpBfjDc31Tp8CNYBdAXBsmwXuNaQU4L7tXl8b20MAV0Cf3T/JcaJC7CmCMQe7xvhfYHBq8ZHyv48HzFddUeMLxuVG+PYEy8fkYLxQZ2OV5G5ykrAXIcH99uFeGZgFXwwYLrMVuUbsYjpTLSv2NerwdiSVy2CNyFvvSVDlAP3ZXyEV/LKEe7OqPi0NRhPJ5agd+8Xg6EVtwxCNWB3ZEFcz284HHD8Du2II92MMJLi4DvVFF3V4+zEj+OGU8nIH3MoQvAE9FF77Tw0cZHpaAvrLEO4BTGQauAC+XoN1OdrcHeCe29nIjW8jeIAW7adEZSbMf/wPvFnXAt4gbB+xO0VKAoUvAW8BDK9Tpw47zvqFuOfNUdE5gfw5jtSSRV4EuT0yTJP0GcCJH0lGKkPupiT2W8plyrLokXJT0q+y7+rykhyVtlH3FDt7IyKAmadgYcyxSvHSwhxZmCrRWEXyTM7A94cVSC5AUYRP2ZEZVLGGPzLwAXMu4trIiGOAA5feG4zSM88AAq6UIiaH12CNu5yMnfgrYS8oMb9UVITHVAewDjrLyE+MXgSPAMwF6hYtQ2sIGdot6IPnbJvu075K0Xrf/YeK67ALmOdllrHFJk8myXKjOoKRv5B9JapKGjDE/5E7kvwAwmLS0j2liHZ9ZjQQW4aXl9xVbO1tFGGMmJO2Wf2fr3sfTE+7tn0AjyegwvSz5Z9OuberydpkkrX3rqMyPxpgbzfTTokWL1ck/FJbYJ0STWJAAAAAASUVORK5CYII=]],
	ChevronRight=[[iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAABmJLR0QA/wD/AP+gvaeTAAAA8ElEQVR4nO3aMU7DMACF4d8MnKfHAKmiQ+/AkTpwB7YehNsQWF6HRkIqEV1qx9T/t2WJ/Z7sDI5BkiRJkgZUar04yQZ4nR/fSikftcbqTpJNks/8mJJs155XM0kO+e2rxxIeGo71CLz3WMLNzVtgWlgF3a6Em0vydPEduCxht/Ycq7MELAGwBMASAEsALAGwBMASAEsALAGwBACSbOewS6acD1ju25USDjXGbHkeoL8MvQWSPF/5CL6sPcdqDG94wxve8IY3vOHvkuEHDj/2z9Es3w/oMnzL84BvYF9KOTYccx35R1dkvCQlSZIkSSM6AfHCWA0+H77KAAAAAElFTkSuQmCC]],
	Chevron=[[iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAABmJLR0QA/wD/AP+gvaeTAAABFElEQVR4nO3Yyw3CMBBFUYcF9VAGSAi6oKQs6CG90A1k9dh4RBQgP2yDzT07hMjMPNsI7BwAAAAAAAAA/JFq6QclbZxzJ//yXFXVJUxLGdSXtJF01cNN0j5h/b2vaa4+kGQN1HrWpgjBD9++qF8ved4qYG9r51wTMwT/7MbX+h5/BG4vViHaThhYeTuC6Y6Ab2jb+x7oh3AMWGs3UusQqtbcxqKH8LPDdxqMFsLPD29ihJDN8CZkCNkNb0KEkO3w5pMQsh/eLAmhmOHNnBCKG95MCaHY4Y2Gf8K2I+8l+4cZ1chOKHPl+0Z2Qpkr3zchhHKHNwPHobxt/46er7SSXql1Lb4U/ZS+fKkKAAAAAAAAAH/pDieCbEdaAWghAAAAAElFTkSuQmCC]],
}
local BASE64_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local BASE64_MAP = table.create(256)
for index = 1, #BASE64_ALPHABET do
	BASE64_MAP[
		string.byte(
			BASE64_ALPHABET,
			index
		)
	] = index - 1
end
local function decodeBase64(data)
	local output = table.create(
			math.floor(
				#data * 0.75
			)
		)
	local outputIndex = 0
	for index = 1, #data, 4 do
		local c = string.byte(
				data,
				index + 2
			)
		local d = string.byte(
				data,
				index + 3
			)
		local value = (BASE64_MAP[string.byte(data, index)] or 0) * 262144
			+ (BASE64_MAP[string.byte(data, index + 1)] or 0) * 4096
			+ (BASE64_MAP[c] or 0) * 64
			+ (BASE64_MAP[d] or 0)
		outputIndex += 1
		output[outputIndex] = string.char(
				math.floor(
					value / 65536
				) % 256
			)
		if c ~= 61 then
			outputIndex += 1
			output[outputIndex] = string.char(
					math.floor(
						value / 256
					) % 256
				)
		end
		if d ~= 61 then
			outputIndex += 1
			output[outputIndex] = string.char(
					value % 256
				)
		end
	end
	return table.concat(
		output,
		"",
		1,
		outputIndex
	)
end
local customAssetFunction = getcustomasset
	or getsynasset
local embeddedIconAssets = {}
local function getEmbeddedIconAsset(
	name
)
	if embeddedIconAssets[name] then
		return embeddedIconAssets[name]
	end
	local encoded = EMBEDDED_ICONS[name]
	if not encoded
		or type(writefile) ~= "function"
		or type(customAssetFunction) ~= "function" then
		return nil
	end
	local fileName = "TuffHub_"
		.. string.lower(name)
		.. "_icon.png"
	local decoded = decodeBase64(
			encoded
		)
	local wrote = pcall(
			writefile,
			fileName,
			decoded
		)
	if not wrote then
		return nil
	end
	local ok,
		asset = pcall(
			customAssetFunction,
			fileName
		)
	if ok and asset then
		embeddedIconAssets[name] = asset
		return asset
	end
	return nil
end
local performSearch
local SEARCH_TWEEN=TI(0.12,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
local searchIconAsset = getEmbeddedIconAsset(
		"Search"
	)
local searchIcon
if searchIconAsset then
	searchIcon = New("ImageLabel")
	searchIcon.Name = "SearchIcon"
	searchIcon.AnchorPoint = V2(
			0,
			0.5
		)
	searchIcon.Position = U2(
			0,
			px(10),
			0.5,
			0
		)
	searchIcon.Size = U2O(
			SEARCH_ICON_SIZE,
			SEARCH_ICON_SIZE
		)
	searchIcon.BackgroundTransparency = 1
	searchIcon.BorderSizePixel = 0
	searchIcon.Image = searchIconAsset
	searchIcon.ImageColor3 = MUTED_TEXT_COLOR
	searchIcon.ImageTransparency = 0
	searchIcon.ScaleType = Enum.ScaleType.Fit
	searchIcon.ZIndex = 45004
	searchIcon.Parent = searchHolder
else
	local searchIconHolder = New("Frame")
	searchIconHolder.Name = "SearchIcon"
	searchIconHolder.AnchorPoint = V2(
			0,
			0
		)
	searchIconHolder.Position = U2O(
			px(10),
			roundPixel(
				(SEARCH_HEIGHT - SEARCH_ICON_SIZE) * 0.5
			)
		)
	searchIconHolder.Size = U2O(
			SEARCH_ICON_SIZE,
			SEARCH_ICON_SIZE
		)
	searchIconHolder.BackgroundTransparency = 1
	searchIconHolder.BorderSizePixel = 0
	searchIconHolder.ZIndex = 45003
	searchIconHolder.Parent = searchHolder
	local searchCircle = New("Frame")
	searchCircle.Name = "Circle"
	searchCircle.Position = U2O(
			0,
			0
		)
	searchCircle.Size = U2O(
			px(7),
			px(7)
		)
	searchCircle.BackgroundTransparency = 1
	searchCircle.BorderSizePixel = 0
	searchCircle.ZIndex = 45004
	searchCircle.Parent = searchIconHolder
	ensureCorner(
		searchCircle,
		px(7)
	)
	local searchCircleStroke = New("UIStroke")
	searchCircleStroke.Color = MUTED_TEXT_COLOR
	searchCircleStroke.Thickness = LINE_THICKNESS
	searchCircleStroke.Transparency = 0
	searchCircleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	searchCircleStroke.Parent = searchCircle
	local searchHandle = New("Frame")
	searchHandle.Name = "Handle"
	searchHandle.AnchorPoint = V2(
			0.5,
			0.5
		)
	searchHandle.Position = U2O(
			px(8),
			px(8)
		)
	searchHandle.Size = U2O(
			px(5),
			px(2)
		)
	searchHandle.Rotation = 45
	searchHandle.BackgroundColor3 = MUTED_TEXT_COLOR
	searchHandle.BackgroundTransparency = 0
	searchHandle.BorderSizePixel = 0
	searchHandle.ZIndex = 45004
	searchHandle.Parent = searchIconHolder
end
local searchIconButton = New("TextButton")
searchIconButton.Name = "SearchButton"
searchIconButton.Position = U2O(
	px(4),
	0
)
searchIconButton.Size = U2O(
	px(28),
	SEARCH_HEIGHT
)
searchIconButton.BackgroundTransparency = 1
searchIconButton.BorderSizePixel = 0
searchIconButton.AutoButtonColor = false
searchIconButton.Text = ""
searchIconButton.ZIndex = 45005
searchIconButton.Parent = searchHolder
local searchBox = New("TextBox")
searchBox.Name = "SearchInput"
searchBox.Position = U2O(
	px(34),
	0
)
searchBox.Size = UDim2.new(
	1,
	-px(68),
	1,
	0
)
searchBox.BackgroundTransparency = 1
searchBox.BorderSizePixel = 0
searchBox.ClipsDescendants = true
searchBox.TextWrapped = false
searchBox.TextTruncate = Enum.TextTruncate.None
searchBox.ClearTextOnFocus = false
searchBox.Text = ""
searchBox.PlaceholderText = ""
searchBox.TextColor3 = SEARCH_TEXT_COLOR
searchBox.PlaceholderColor3 = SEARCH_PLACEHOLDER_COLOR
searchBox.FontFace = MENU_FONT_FACE
setResponsiveTextSize(searchBox, SEARCH_TEXT_SIZE)
searchBox.TextXAlignment = Enum.TextXAlignment.Center
searchBox.TextYAlignment = Enum.TextYAlignment.Center
searchBox.ZIndex = 45003
searchBox.Parent = searchHolder
local searchTextPadding = New("UIPadding")
searchTextPadding.PaddingLeft = UDim.new(
	0,
	0
)
searchTextPadding.PaddingRight = UDim.new(
	0,
	0
)
searchTextPadding.Parent = searchBox
local centeredSearchPlaceholder = New("TextLabel")
centeredSearchPlaceholder.Name = "CenteredPlaceholder"
centeredSearchPlaceholder.Position = U2S(
	0,
	0
)
centeredSearchPlaceholder.Size = U2S(
	1,
	1
)
centeredSearchPlaceholder.BackgroundTransparency = 1
centeredSearchPlaceholder.BorderSizePixel = 0
centeredSearchPlaceholder.Text = "Search"
centeredSearchPlaceholder.TextColor3 = SEARCH_PLACEHOLDER_COLOR
centeredSearchPlaceholder.FontFace = MENU_FONT_FACE
setResponsiveTextSize(centeredSearchPlaceholder, SEARCH_TEXT_SIZE)
centeredSearchPlaceholder.TextXAlignment = Enum.TextXAlignment.Center
centeredSearchPlaceholder.TextYAlignment = Enum.TextYAlignment.Center
centeredSearchPlaceholder.ZIndex = 45003
centeredSearchPlaceholder.Parent = searchHolder
local function syncSearchPlaceholder()
	centeredSearchPlaceholder.Visible =
		searchBox.Text == ""
		and not searchBox:IsFocused()
	searchBox.TextXAlignment =
		searchBox:IsFocused()
		and searchBox.TextBounds.X > math.max(1, searchBox.AbsoluteSize.X - px(2))
		and Enum.TextXAlignment.Right
		or Enum.TextXAlignment.Center
end
searchBox:GetPropertyChangedSignal(
	"Text"
):Connect(
	syncSearchPlaceholder
)
searchBox:GetPropertyChangedSignal(
	"TextBounds"
):Connect(
	syncSearchPlaceholder
)
searchBox.Focused:Connect(function()
	syncSearchPlaceholder()
	TweenService:Create(
		searchHolder,
		SEARCH_TWEEN,
		{
			BackgroundTransparency = SEARCH_FOCUSED_TRANSPARENCY
		}
	):Play()
end)
searchBox.FocusLost:Connect(function(enterPressed)
	syncSearchPlaceholder()
	TweenService:Create(
		searchHolder,
		SEARCH_TWEEN,
		{
			BackgroundTransparency = SEARCH_BACKGROUND_TRANSPARENCY
		}
	):Play()
	if enterPressed
		and performSearch then
		performSearch(
			true
		)
	end
end)
syncSearchPlaceholder()
searchIconButton.MouseButton1Click:Connect(function()
	if performSearch then
		performSearch(
			true
		)
	end
	if searchBox:IsFocused() then
		searchBox:ReleaseFocus()
	end
end)
local menuStartY = searchY
	+ SEARCH_HEIGHT
	+ MENU_TOP_GAP
local menuHolder = New("ScrollingFrame")
menuHolder.Name = "SidebarMenu"
menuHolder.AnchorPoint = V2(
		0.5,
		0
	)
menuHolder.Position = U2O(
		roundPixel(
			(FIXED_SIDEBAR_WIDTH + LINE_THICKNESS) * 0.5
		),
		SIDEBAR_PADDING + menuStartY
	)
menuHolder.Size = U2O(
		FIXED_SIDEBAR_WIDTH,
		(MENU_ITEM_HEIGHT * 3)
			+ (MENU_ITEM_GAP * 2)
	)
menuHolder.BackgroundTransparency = 1
menuHolder.BorderSizePixel = 0
menuHolder.ClipsDescendants = true
menuHolder.Active = true
menuHolder.ScrollingDirection = Enum.ScrollingDirection.Y
menuHolder.ScrollBarThickness = 0
menuHolder.ScrollBarImageTransparency = 1
menuHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
menuHolder.CanvasSize = U2O(
		0,
		0
	)
menuHolder.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
menuHolder.ZIndex = 45000
menuHolder.Parent = window
local menuLayout = New("UIListLayout")
menuLayout.FillDirection = Enum.FillDirection.Vertical
menuLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
menuLayout.VerticalAlignment = Enum.VerticalAlignment.Top
menuLayout.Padding = UDim.new(
		0,
		MENU_ITEM_GAP
	)
menuLayout.SortOrder = Enum.SortOrder.LayoutOrder
menuLayout.Parent = menuHolder
local menuItems = {}
local TRACKED_TAB_NAME={Home="H O M E",Main=IS_MINIGAME_PLACE and "M I N I G A M E S" or "M A I N",Settings="S E T T I N G S"}
local TRACKED_FEATURE="F E A T U R E"
local function formatPanelTitle(title)
	if type(title) ~= "string" or title == "" then
		return TRACKED_FEATURE
	end
	local words = {}
	for word in string.gmatch(string.upper(title), "%S+") do
		local letters = {}
		for i = 1, #word do
			letters[#letters + 1] = string.sub(word, i, i)
		end
		words[#words + 1] = table.concat(letters, " ")
	end
	return table.concat(words, "    ")
end
local selectedTabTitle = New("TextLabel")
selectedTabTitle.Name = "SelectedTabTitle"
selectedTabTitle.BackgroundTransparency = 1
selectedTabTitle.BorderSizePixel = 0
selectedTabTitle.Text = TRACKED_TAB_NAME.Home
selectedTabTitle.TextColor3 = MUTED_TEXT_COLOR
selectedTabTitle.FontFace = MENU_FONT_FACE
setResponsiveTextSize(selectedTabTitle, 17)
selectedTabTitle.TextScaled = false
selectedTabTitle.TextXAlignment = Enum.TextXAlignment.Left
selectedTabTitle.TextYAlignment = Enum.TextYAlignment.Center
selectedTabTitle.TextTruncate = Enum.TextTruncate.AtEnd
selectedTabTitle.ZIndex = 54000
selectedTabTitle.Parent = nil
local function syncPixelSnappedGeometry()
	local panelHeight = roundPixel(
			window.Size.Y.Offset
		)
	local dividerX = getSidebarWidth()
	local visibleDividerThickness = math.max(
		LINE_THICKNESS,
		logicalPixelsForRenderedMinimum(1)
	)
	local sidebarVisualCenterX = roundPixel(
			(dividerX + visibleDividerThickness) * 0.5
		)
	sidebarSeparator.Position = U2O(
			dividerX,
			0
		)
	sidebarSeparator.Size = U2O(
			visibleDividerThickness,
			panelHeight
		)
	logoDivider.Position = U2O(
			0,
			roundPixel(
				logoDividerY
			)
		)
	logoDivider.Size = U2O(
			dividerX,
			visibleDividerThickness
		)
	sidebar.Position = U2O(
			SIDEBAR_PADDING,
			SIDEBAR_PADDING
		)
	sidebar.Size = U2O(
			math.max(
				1,
				dividerX
					- (SIDEBAR_PADDING * 2)
			),
			math.max(
				1,
				panelHeight
					- (SIDEBAR_PADDING * 2)
			)
		)
	local logoAreaWidth = math.max(1, dividerX)
	local logoAreaHeight = math.max(1, logoDividerY)
	local logoBaseWidth = sidebarCollapsed and px(36) or LOGO_WIDTH
	local logoBaseHeight = sidebarCollapsed and px(30) or LOGO_HEIGHT
	sidebarLogoHolder.Position = U2O(
			sidebarVisualCenterX - SIDEBAR_PADDING,
			roundPixel((logoAreaHeight * 0.5) - SIDEBAR_PADDING)
		)
	sidebarLogoHolder.Size = U2O(
			logoBaseWidth,
			logoBaseHeight
		)
	do
		local areaLogoScale = sidebarLogoHolder:FindFirstChild("AreaLogoScale")
		if areaLogoScale then
			areaLogoScale.Scale = math.max(
				0.01,
				math.min(
					(logoAreaWidth * 0.60) / logoBaseWidth,
					(logoAreaHeight * 0.60) / logoBaseHeight
				)
			)
		end
		local expandedSplit = roundPixel(
			(tuffLabel.TextBounds.X - hubLabel.TextBounds.X) * 0.5
		)
		local compactSplit = roundPixel(
			(compactTLabel.TextBounds.X - compactHLabel.TextBounds.X) * 0.5
		)
		tuffLabel.Position = U2(0.5, expandedSplit, 0.5, 0)
		hubLabel.Position = U2(0.5, expandedSplit, 0.5, 0)
		compactTLabel.Position = U2(0.5, compactSplit, 0.5, 0)
		compactHLabel.Position = U2(0.5, compactSplit, 0.5, 0)
	end
	tuffLabel.Visible = not sidebarCollapsed
	hubLabel.Visible = not sidebarCollapsed
	compactTLabel.Visible = sidebarCollapsed
	compactHLabel.Visible = sidebarCollapsed
	searchHolder.Visible = not sidebarCollapsed
	searchHolder.Position = U2O(
			sidebarVisualCenterX,
			roundPixel(
				SIDEBAR_PADDING
					+ searchY
			)
		)
	searchHolder.Size = U2O(
			roundEvenPixel(dividerX * 0.90),
			SEARCH_HEIGHT
		)
	do
		local searchSafeInset = math.min(
				px(34),
				math.max(
					1,
					roundPixel(
						(searchHolder.Size.X.Offset - px(4)) * 0.5
					)
				)
			)
		searchBox.Position = U2O(
				searchSafeInset,
				0
			)
		searchBox.Size = UDim2.new(
				1,
				-(searchSafeInset * 2),
				1,
				0
			)
		centeredSearchPlaceholder.Position = U2S(
				0,
				0
			)
		centeredSearchPlaceholder.Size = U2S(
				1,
				1
			)
		syncSearchPlaceholder()
	end
	local menuTop = roundPixel(
			sidebarCollapsed
				and (
					logoDividerY
						+ LINE_THICKNESS
						+ MENU_TOP_GAP
				)
				or (
					SIDEBAR_PADDING
						+ menuStartY
				)
		)
	local menuAvailableHeight = math.max(
			MENU_ITEM_HEIGHT,
			panelHeight
				- SIDEBAR_PADDING
				- menuTop
		)
	menuHolder.Position = U2O(
			sidebarVisualCenterX,
			menuTop
		)
	menuHolder.Size = U2O(
			dividerX,
			menuAvailableHeight
		)
	local tabHighlightWidth = roundPixel(
			dividerX
				* (
					sidebarCollapsed
						and 0.70
						or 0.90
				)
		)
	local tabHighlightLeft = roundPixel(
			(
				dividerX
					- tabHighlightWidth
			)
				* 0.5
		)
	local tabReferenceWidth = math.max(
			1,
			FIXED_SIDEBAR_WIDTH * 0.90
		)
	local tabIconXScale = MENU_ICON_X / tabReferenceWidth
	local tabIconWidthScale = MENU_ICON_SIZE / tabReferenceWidth
	local tabIconHeightScale = MENU_ICON_SIZE / MENU_ITEM_HEIGHT
	local tabIconTextGapScale = math.max(
			0,
			(MENU_TEXT_X - MENU_ICON_X - MENU_ICON_SIZE) / tabReferenceWidth
		)
	local tabIconPixelSize = math.max(
			15,
			math.min(
				roundPixel(tabHighlightWidth * tabIconWidthScale),
				roundPixel(MENU_ITEM_HEIGHT * tabIconHeightScale)
			)
		)
	local minimumExpandedIconPixels = logicalPixelsForRenderedMinimum(17)
	local minimumCollapsedIconPixels = logicalPixelsForRenderedMinimum(19)
	tabIconPixelSize = math.max(
		tabIconPixelSize,
		minimumExpandedIconPixels
	)
	local collapsedIconPixelSize = math.max(
			18,
			responsiveTextSize(18),
			minimumCollapsedIconPixels
		)
	local tabIconTextGap = math.max(
			2,
			roundPixel(tabHighlightWidth * tabIconTextGapScale)
		)
	local tabTextRightScale = px(10) / tabReferenceWidth
	for _, item in ipairs(
		menuItems
	) do
		item.Button.AnchorPoint = V2(
				0.5,
				0.5
			)
		item.Button.Position = U2S(
				0.5,
				0.5
			)
		item.Button.Size = U2O(
				tabHighlightWidth,
				MENU_ITEM_HEIGHT
			)
		item.Label.Visible = not sidebarCollapsed
		do
			local responsiveMenuTextSize = responsiveTextSize(MENU_TEXT_SIZE)
			local normalMenuTextSize = responsiveMenuTextSize < 16
				and (responsiveMenuTextSize + 1)
				or responsiveMenuTextSize
			item.Label.TextSize = math.max(
				normalMenuTextSize,
				logicalPixelsForRenderedMinimum(15)
			)
		end
		if not sidebarCollapsed then
			item.Label.Position = UDim2.new(
					tabIconXScale,
					tabIconPixelSize + tabIconTextGap,
					0.5,
					0
				)
			item.Label.Size = UDim2.new(
					math.max(
						0.01,
						1 - tabIconXScale - tabTextRightScale
					),
					-(tabIconPixelSize + tabIconTextGap),
					1,
					0
				)
		end
		if item.Icon then
			local currentIconPixelSize = sidebarCollapsed
				and collapsedIconPixelSize
				or tabIconPixelSize
			item.Icon.Size = U2O(
					currentIconPixelSize,
					currentIconPixelSize
				)
			if not item.IconIsImage then
				item.Icon.TextSize = sidebarCollapsed
					and math.max(
						16,
						responsiveTextSize(16),
						logicalPixelsForRenderedMinimum(17)
					)
					or math.max(
						14,
						responsiveTextSize(14),
						logicalPixelsForRenderedMinimum(15)
					)
			end
		end
		item.ActiveLine.AnchorPoint = V2(
				0.5,
				0.5
			)
		local menuHolderLeftX =
			sidebarVisualCenterX
			- (dividerX * 0.5)
		item.ActiveLine.Position = U2(
				0,
				(
					tabHighlightLeft
					- menuHolderLeftX
				) * 0.5,
				0.5,
				0
			)
		if item.Icon then
			if sidebarCollapsed then
				item.Icon.AnchorPoint = V2(
						0.5,
						0.5
					)
				item.Icon.Position = U2S(
						0.5,
						0.5
					)
			else
				item.Icon.AnchorPoint = V2(
						0,
						0.5
					)
				item.Icon.Position = U2(
						tabIconXScale,
						0,
						0.5,
						0
					)
			end
		end
	end
end
syncPixelSnappedGeometry()
window:GetPropertyChangedSignal(
	"AbsoluteSize"
):Connect(
	syncPixelSnappedGeometry
)
tuffLabel:GetPropertyChangedSignal("TextBounds"):Connect(syncPixelSnappedGeometry)
hubLabel:GetPropertyChangedSignal("TextBounds"):Connect(syncPixelSnappedGeometry)
compactTLabel:GetPropertyChangedSignal("TextBounds"):Connect(syncPixelSnappedGeometry)
compactHLabel:GetPropertyChangedSignal("TextBounds"):Connect(syncPixelSnappedGeometry)
local selectedMenuItem = nil
local refreshUnsupportedPanels
local menuTweenInfo = TI(
		0.14,
		Enum.EasingStyle.Quart,
		Enum.EasingDirection.Out
	)
local function updateMenuItemVisual(item,instant)
	local transparency,lineTransparency,textColor,iconTransparency
	if selectedMenuItem==item then
		transparency,lineTransparency,textColor,iconTransparency=MENU_SELECTED_TRANSPARENCY,0,MENU_TEXT_SELECTED,0
	elseif item.Hovered then
		transparency,lineTransparency,textColor,iconTransparency=MENU_HOVER_TRANSPARENCY,1,MENU_TEXT_HOVER,0.22
	else
		transparency,lineTransparency,textColor,iconTransparency=MENU_NORMAL_TRANSPARENCY,1,MENU_TEXT_IDLE,0.58
	end
	if instant then
		item.Button.BackgroundTransparency=transparency
		item.Label.TextColor3=textColor
		if item.IconIsImage then
			item.Icon.ImageColor3=PINK
			item.Icon.ImageTransparency=iconTransparency
		else
			item.Icon.TextColor3=PINK
			item.Icon.TextTransparency=iconTransparency
		end
		item.ActiveLine.BackgroundTransparency=lineTransparency
		return
	end
	TweenService:Create(item.Button,menuTweenInfo,{BackgroundTransparency=transparency}):Play()
	TweenService:Create(item.Label,menuTweenInfo,{TextColor3=textColor}):Play()
	if item.IconIsImage then
		TweenService:Create(item.Icon,menuTweenInfo,{ImageColor3=PINK,ImageTransparency=iconTransparency}):Play()
	else
		TweenService:Create(item.Icon,menuTweenInfo,{TextColor3=PINK,TextTransparency=iconTransparency}):Play()
	end
	TweenService:Create(item.ActiveLine,menuTweenInfo,{BackgroundTransparency=lineTransparency}):Play()
end
local function selectMenuItem(item)
	if selectedMenuItem == item then
		return
	end
	local previous = selectedMenuItem
	selectedMenuItem = item
	selectedTabTitle.Text = TRACKED_TAB_NAME[item.Name] or item.Name
	if previous then
		updateMenuItemVisual(
			previous,
			true
		)
	end
	updateMenuItemVisual(
		item,
		true
	)
	if refreshUnsupportedPanels then
		refreshUnsupportedPanels()
	end
end
local function createSidebarItem(
	name,
	order,
	fallbackGlyph
)
	local row = New("Frame")
	row.Name = name .. "Row"
	row.LayoutOrder = order
	row.Size = U2(
			1,
			0,
			0,
			MENU_ITEM_HEIGHT
		)
	row.BackgroundTransparency = 1
	row.BorderSizePixel = 0
	row.ZIndex = 45000
	row.Parent = menuHolder
	local button = New("TextButton")
	button.Name = name .. "Button"
	button.AnchorPoint = V2(
			0.5,
			0.5
		)
	button.Position = U2(
			0.5,
			0,
			0.5,
			0
		)
	button.Size = U2O(
			FIXED_TAB_HIGHLIGHT_WIDTH,
			MENU_ITEM_HEIGHT
		)
	button.BackgroundColor3 = SEARCH_BACKGROUND
	button.BackgroundTransparency = MENU_NORMAL_TRANSPARENCY
	button.BorderSizePixel = 0
	button.AutoButtonColor = false
	button.Text = ""
	button.ClipsDescendants = true
	button.ZIndex = 45001
	button.Parent = row
	ensureCorner(
		button,
		MENU_CORNER_RADIUS
	)
	local activeLine = New("Frame")
	activeLine.Name = "ActiveLine"
	activeLine.AnchorPoint = V2(
			0,
			0.5
		)
	activeLine.Position = U2(
			0,
			FIXED_ACTIVE_LINE_X,
			0.5,
			0
		)
	activeLine.Size = U2O(
			MENU_ACTIVE_LINE_WIDTH,
			MENU_ACTIVE_LINE_HEIGHT
		)
	activeLine.BackgroundColor3 = PINK
	activeLine.BackgroundTransparency = 1
	activeLine.BorderSizePixel = 0
	activeLine.ZIndex = 45003
	activeLine.Parent = row
	ensureCorner(
		activeLine,
		math.max(
			1,
			math.floor(
				MENU_ACTIVE_LINE_HEIGHT * 0.5
			)
		)
	)
	local iconAsset = getEmbeddedIconAsset(
			name
		)
	local icon
	if iconAsset then
		icon = New("ImageLabel")
		icon.Name = name .. "Icon"
		icon.AnchorPoint = V2(
				0,
				0.5
			)
		icon.Position = U2(
				0,
				MENU_ICON_X,
				0.5,
				0
			)
		icon.Size = U2O(
				MENU_ICON_SIZE,
				MENU_ICON_SIZE
			)
		icon.BackgroundTransparency = 1
		icon.BorderSizePixel = 0
		icon.Image = iconAsset
		icon.ImageColor3 = PINK
		icon.ImageTransparency = 0.58
		icon.ScaleType = Enum.ScaleType.Fit
		icon.ZIndex = 45003
		icon.Parent = button
	else
		icon = New("TextLabel")
		icon.Name = name .. "IconFallback"
		icon.AnchorPoint = V2(
				0,
				0.5
			)
		icon.Position = U2(
				0,
				MENU_ICON_X,
				0.5,
				0
			)
		icon.Size = U2O(
				MENU_ICON_SIZE,
				MENU_ICON_SIZE
			)
		icon.BackgroundTransparency = 1
		icon.BorderSizePixel = 0
		icon.Text = fallbackGlyph
			or ""
		icon.TextColor3 = PINK
		icon.TextTransparency = 0.58
		setResponsiveTextSize(icon, 14)
		icon.FontFace = MENU_FONT_FACE
		icon.TextXAlignment = Enum.TextXAlignment.Center
		icon.TextYAlignment = Enum.TextYAlignment.Center
		icon.ZIndex = 45003
		icon.Parent = button
	end
	local label = New("TextLabel")
	label.Name = name .. "Label"
	label.AnchorPoint = V2(
			0,
			0.5
		)
	label.Position = U2(
			0,
			MENU_TEXT_X,
			0.5,
			0
		)
	label.Size = U2(
			1,
			-(MENU_TEXT_X + 10),
			1,
			0
		)
	label.BackgroundTransparency = 1
	label.BorderSizePixel = 0
	label.Text = name
	label.TextColor3 = MENU_TEXT_IDLE
	label.FontFace = MENU_FONT_FACE
	setResponsiveTextSize(label, MENU_TEXT_SIZE)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.ZIndex = 45002
	label.Parent = button
	local item = {
		Name = name,
		Row = row,
		Button = button,
		Label = label,
		Icon = icon,
		IconIsImage = iconAsset ~= nil,
		ActiveLine = activeLine,
		Hovered = false,
	}
	table.insert(
		menuItems,
		item
	)
	button.MouseEnter:Connect(function()
		item.Hovered = true
		updateMenuItemVisual(
			item,
			false
		)
	end)
	button.MouseLeave:Connect(function()
		item.Hovered = false
		updateMenuItemVisual(
			item,
			false
		)
	end)
	button.MouseButton1Up:Connect(function()
		selectMenuItem(item)
	end)
	return item
end
local homeItem = createSidebarItem(
		"Home",
		1,
		"⌂"
	)
homeItem.Label.Text = "Home"
local mainItem = createSidebarItem(
		"Main",
		2,
		"ϟ"
	)
mainItem.Label.Text = IS_MINIGAME_PLACE
	and "Minigames"
	or "Main"
local settingsItem = createSidebarItem(
		"Settings",
		3,
		"⚙"
	)
settingsItem.Label.Text = "Settings"
selectedMenuItem = homeItem
for _, item in ipairs(
	menuItems
) do
	updateMenuItemVisual(
		item,
		true
	)
end
selectedTabTitle.Text = TRACKED_TAB_NAME[selectedMenuItem.Name] or selectedMenuItem.Name
syncPixelSnappedGeometry()
local rightContent = New("ScrollingFrame")
rightContent.Name = "UnsupportedGameContent"
rightContent.BackgroundTransparency = 1
rightContent.BorderSizePixel = 0
rightContent.ClipsDescendants = true
rightContent.Active = true
rightContent.ScrollingDirection = Enum.ScrollingDirection.Y
rightContent.ScrollBarThickness = 0
rightContent.ScrollBarImageTransparency = 1
rightContent.AutomaticCanvasSize = Enum.AutomaticSize.None
rightContent.CanvasSize = U2O(
		0,
		0
	)
rightContent.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
rightContent.ZIndex = 45000
rightContent.Parent = window
selectedTabTitle.Parent = rightContent
local unsupportedPanelGroups = {
}
local allUnsupportedPanels = {
}
local CHEVRON_TWEEN=TI(0.12,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
local function tweenChevronColor(
	chevron,
	color
)
	if chevron:IsA("ImageLabel") then
		TweenService:Create(
			chevron,
			CHEVRON_TWEEN,
			{
				ImageColor3 = color
			}
		):Play()
	else
		TweenService:Create(
			chevron,
			CHEVRON_TWEEN,
			{
				TextColor3 = color
			}
		):Play()
	end
end
local panelChevronAsset=getEmbeddedIconAsset("Chevron")
local activePanelDropdown

local function pointInsideGui(gui, point)
	if not gui or not gui.Parent or not gui.Visible then return false end
	local pos, size = gui.AbsolutePosition, gui.AbsoluteSize
	return point.X >= pos.X and point.X <= pos.X + size.X
		and point.Y >= pos.Y and point.Y <= pos.Y + size.Y
end

local function closeActivePanelDropdown()
	if activePanelDropdown then
		local popup = activePanelDropdown.Popup
		local blocker = activePanelDropdown.Blocker
		local overlay = activePanelDropdown.Overlay
		local followConnection = activePanelDropdown.FollowConnection
		local outsideConnection = activePanelDropdown.OutsideConnection
		if followConnection then followConnection:Disconnect() end
		if outsideConnection then outsideConnection:Disconnect() end
		if overlay then
			overlay:Destroy()
		else
			if popup then popup:Destroy() end
			if blocker then blocker:Destroy() end
		end
		activePanelDropdown = nil
	end
end

local function createEmptyCollapsiblePanel(
	tabItem,
	panelIndex,
	column,
	order,
	panelTitle,
	featureDefinitions
)
	local panelPersistenceKey = tostring(tabItem.Name)
		.. "|" .. tostring(panelTitle or ("Panel " .. tostring(panelIndex)))
		.. "|" .. tostring(column) .. "|" .. tostring(order)
	local persistedPanelExpanded = autoServerHopState
		and autoServerHopState.Utility
		and type(autoServerHopState.Utility.PanelExpanded) == "table"
		and autoServerHopState.Utility.PanelExpanded[panelPersistenceKey]
	local initialPanelExpanded = persistedPanelExpanded ~= false
	local panel = New("Frame")
	panel.Name = tabItem.Name
		.. "EmptyPanel"
		.. tostring(
			panelIndex
		)
	panel.BackgroundColor3 = PANEL_BACKGROUND
	panel.BackgroundTransparency = 0
	panel.BorderSizePixel = 0
	panel.ClipsDescendants = true
	panel.Active = true
	panel.Visible = false
	panel.ZIndex = 45010
	panel.Parent = rightContent
	ensureCorner(
		panel,
		PANEL_CORNER_RADIUS
	)
	local panelStroke = New("UIStroke")
	panelStroke.Name = "PanelBorder"
	panelStroke.Color = LINE_COLOR
	panelStroke.Thickness = LINE_THICKNESS
	panelStroke.Transparency = LINE_TRANSPARENCY
	panelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	panelStroke.LineJoinMode = Enum.LineJoinMode.Round
	panelStroke.Parent = panel
	local header = New("TextButton")
	header.Name = "Header"
	header.Size = U2(
			1,
			0,
			0,
			PANEL_HEADER_HEIGHT
		)
	header.BackgroundTransparency = 1
	header.BorderSizePixel = 0
	header.AutoButtonColor = false
	header.Text = ""
	header.ZIndex = 45012
	header.Parent = panel
	local headerTitle = New("TextLabel")
	headerTitle.Name = "Title"
	headerTitle.AnchorPoint = V2(
			0,
			0.5
		)
	headerTitle.Position = U2(
			0,
			px(14),
			0,
			PANEL_HEADER_HEIGHT * 0.5
		)
	headerTitle.Size = U2(
			1,
			px(-48),
			1,
			0
		)
	headerTitle.BackgroundTransparency = 1
	headerTitle.BorderSizePixel = 0
	headerTitle.Text = formatPanelTitle(panelTitle)
	headerTitle.TextColor3 = MENU_TEXT_SELECTED
	headerTitle.FontFace = PANEL_FONT_FACE
	setResponsiveTextSize(headerTitle, 15)
	headerTitle.TextScaled = false
	headerTitle.TextXAlignment = Enum.TextXAlignment.Left
	headerTitle.TextYAlignment = Enum.TextYAlignment.Center
	headerTitle.ZIndex = 45013
	headerTitle.Parent = panel
	local chevron
	if panelChevronAsset then
		chevron = New("ImageLabel")
		chevron.Name = "Chevron"
		chevron.AnchorPoint = V2(
				0.5,
				0.5
			)
		chevron.Position = U2(
				1,
				px(-18),
				0,
				PANEL_HEADER_HEIGHT * 0.5
			)
		chevron.Size = U2O(
				px(18),
				px(18)
			)
		chevron.BackgroundTransparency = 1
		chevron.BorderSizePixel = 0
		chevron.Image = panelChevronAsset
		chevron.ImageColor3 = PANEL_CHEVRON_COLOR
		chevron.ImageTransparency = 0
		chevron.ScaleType = Enum.ScaleType.Fit
		chevron.Rotation = 0
		chevron.ZIndex = 45013
		chevron.Parent = panel
	else
		chevron = New("TextLabel")
		chevron.Name = "Chevron"
		chevron.AnchorPoint = V2(
				0.5,
				0.5
			)
		chevron.Position = U2(
				1,
				px(-18),
				0,
				PANEL_HEADER_HEIGHT * 0.5
			)
		chevron.Size = U2O(
				px(18),
				px(18)
			)
		chevron.BackgroundTransparency = 1
		chevron.BorderSizePixel = 0
		chevron.Text = "⌄"
		chevron.TextColor3 = PANEL_CHEVRON_COLOR
		setResponsiveTextSize(chevron, 14)
		chevron.FontFace = MENU_FONT_FACE
		chevron.TextXAlignment = Enum.TextXAlignment.Center
		chevron.TextYAlignment = Enum.TextYAlignment.Center
		chevron.Rotation = 0
		chevron.ZIndex = 45013
		chevron.Parent = panel
	end
	local headerDivider = New("Frame")
	headerDivider.Name = "HeaderDivider"
	headerDivider.Position = U2O(
			0,
			PANEL_HEADER_HEIGHT
		)
	headerDivider.Size = U2(
			1,
			0,
			0,
			LINE_THICKNESS
		)
	headerDivider.BackgroundColor3 = LINE_COLOR
	headerDivider.BackgroundTransparency = LINE_TRANSPARENCY
	headerDivider.BorderSizePixel = 0
	headerDivider.ZIndex = 45011
	headerDivider.Parent = panel
	local body = New("Frame")
	body.Name = "Body"
	body.Position = U2O(
			0,
			PANEL_HEADER_HEIGHT
				+ LINE_THICKNESS
		)
	body.Size = U2(
			1,
			0,
			1,
			-(PANEL_HEADER_HEIGHT + LINE_THICKNESS)
		)
	body.BackgroundTransparency = 1
	body.BorderSizePixel = 0
	body.ZIndex = 45011
	body.Parent = panel
	local featureRowHeight = px(32)
	local featureRowGap = px(2)
	local featureTopPadding = px(8)
	local featureBottomPadding = px(8)
	local amountControlsHeight = px(40)
	local secondaryControlHeight = px(32)
	local toggleWidth = px(34)
	local toggleHeight = px(18)
	local knobInset = px(2)
	local dropdownWidth = px(118)
	local amountValueWidth = px(58)
	local featureRows = {}
	local dropdownTextWidthCache = {}
	local panelData
	local activeSliderUpdate
	local activeSliderTouch
	local sliderChangedConnection
	local sliderEndedConnection

	local function stopSliderDrag()
		activeSliderUpdate = nil
		activeSliderTouch = nil
		if sliderChangedConnection then
			sliderChangedConnection:Disconnect()
			sliderChangedConnection = nil
		end
		if sliderEndedConnection then
			sliderEndedConnection:Disconnect()
			sliderEndedConnection = nil
		end
	end

	local function beginSliderDrag(input, updateSlider)
		stopSliderDrag()
		activeSliderUpdate = updateSlider
		activeSliderTouch = input.UserInputType == Enum.UserInputType.Touch
			and input
			or nil
		updateSlider(input.Position.X)

		sliderChangedConnection = UserInputService.InputChanged:Connect(function(changed)
			if not activeSliderUpdate then return end
			if activeSliderTouch then
				if changed == activeSliderTouch then
					activeSliderUpdate(changed.Position.X)
				end
			elseif changed.UserInputType == Enum.UserInputType.MouseMovement then
				activeSliderUpdate(changed.Position.X)
			end
		end)

		sliderEndedConnection = UserInputService.InputEnded:Connect(function(ended)
			if activeSliderTouch then
				if ended == activeSliderTouch then stopSliderDrag() end
			elseif ended.UserInputType == Enum.UserInputType.MouseButton1 then
				stopSliderDrag()
			end
		end)
	end

	panel.Destroying:Connect(stopSliderDrag)

	local function setToggleVisual(toggleTrack, toggleKnob, featureLabel, enabled)
		toggleTrack.BackgroundColor3 = enabled and PINK or FEATURE_OFF_COLOR
		featureLabel.TextColor3 = enabled and MENU_TEXT_SELECTED or MUTED_TEXT_COLOR
		toggleKnob.Position = enabled
			and U2(0, toggleWidth - toggleHeight + knobInset, 0, knobInset)
			or U2O(knobInset, knobInset)
	end

	local function selectedTargetList(stateEntry, options)
		local selected = {}
		if stateEntry and type(stateEntry.Targets) == "table" then
			for _, option in ipairs(options or RARITY_OPTIONS) do
				if stateEntry.Targets[option] then selected[#selected + 1] = option end
			end
		end
		return selected
	end

	local function fitWholeDropdownNames(button, names, placeholder)
		local hasSelection = type(names) == "table" and #names > 0
		button.TextColor3 = hasSelection and MENU_TEXT_SELECTED or MUTED_TEXT_COLOR
		if not hasSelection then
			button.Text = placeholder or "Select"
			return
		end

		local normalized = {}
		for _, name in ipairs(names) do
			normalized[#normalized + 1] = tostring(name)
		end

		local rawWidth = button.AbsoluteSize.X
		if rawWidth <= 1 then
			local parentWidth = button.Parent and button.Parent.AbsoluteSize.X or 0
			rawWidth = (button.Size.X.Scale * parentWidth) + button.Size.X.Offset
		end
		if rawWidth <= 1 then
			rawWidth = button.Size.X.Offset > 1 and button.Size.X.Offset or dropdownWidth
		end
		local availableWidth = math.max(1, rawWidth - px(12))
		local function textWidth(value)
			local key = tostring(button.TextSize) .. "\0" .. value
			local cached = dropdownTextWidthCache[key]
			if cached ~= nil then return cached end
			local width = TextService:GetTextSize(
				value,
				button.TextSize,
				MENU_FONT,
				Vector2.new(10000, button.TextSize + px(8))
			).X
			dropdownTextWidthCache[key] = width
			return width
		end

		local fullText = table.concat(normalized, ", ")
		if #normalized == 1 or textWidth(fullText) <= availableWidth then
			button.Text = fullText
			return
		end

		local suffix = ", ..."
		for count = #normalized - 1, 1, -1 do
			local candidate = table.concat(normalized, ", ", 1, count) .. suffix
			if textWidth(candidate) <= availableWidth then
				button.Text = candidate
				return
			end
		end

		button.Text = normalized[1]
	end

	local function updateDropdownText(button, stateEntry, placeholder, options)
		fitWholeDropdownNames(button, selectedTargetList(stateEntry, options), placeholder)
	end

	local function brainrotAmountTotal(stateEntry, exceptRarity)
		local total = 0
		if not stateEntry then return total end
		stateEntry.Amounts = stateEntry.Amounts or {}
		for _, rarity in ipairs(RARITY_OPTIONS) do
			if rarity ~= "Tokens" and rarity ~= exceptRarity and stateEntry.Targets[rarity] then
				total += math.clamp(math.floor(tonumber(stateEntry.Amounts[rarity]) or 1), 1, 6)
			end
		end
		return total
	end

	local function relayoutRows(skipPanelRefresh)
		local y = featureTopPadding
		for _, rowData in ipairs(featureRows) do
			if not rowData.Row.Visible then
				local rowIndent = 0
				rowData.Row.Size = U2(1, -(px(28) + rowIndent), 0, 0)
				continue
			end
			local rowIndent = 0
			rowData.Row.Position = U2O(px(14) + rowIndent, y)
			local baseHeight = rowData.DynamicBaseHeight
				and rowData.DynamicBaseHeight()
				or rowData.BaseHeight
			if baseHeight == nil then baseHeight = featureRowHeight end
			if rowData.SyncPrimaryLayout then
				rowData.SyncPrimaryLayout(baseHeight)
			end
			local secondaryHeight = 0
			if rowData.SecondaryContainer and rowData.SecondaryContainer.Visible then
				secondaryHeight = rowData.DynamicSecondaryHeight
					and rowData.DynamicSecondaryHeight()
					or rowData.SecondaryHeight
					or secondaryControlHeight
			end
			local visibleControls = 0
			if rowData.AmountContainer then
				rowData.AmountContainer.Position = U2O(
					rowData.AmountContainer.Position.X.Offset,
					baseHeight + secondaryHeight
				)
				for _, control in ipairs(rowData.AmountControls or {}) do
					if rowData.AmountContainer.Visible and control.Frame.Visible then
						control.Frame.Position = U2O(0, visibleControls * amountControlsHeight)
						visibleControls += 1
					end
				end
				rowData.AmountContainer.Size = U2(
					1,
					rowData.AmountContainer.Size.X.Offset,
					0,
					visibleControls * amountControlsHeight
				)
			end
			local extra = secondaryHeight + visibleControls * amountControlsHeight
			rowData.Row.Size = U2(1, -(px(28) + rowIndent), 0, baseHeight + extra)
			y += baseHeight + extra + featureRowGap
		end
		local expandedHeight = PANEL_HEADER_HEIGHT + LINE_THICKNESS
			+ featureTopPadding + featureBottomPadding
			+ math.max(0, y - featureTopPadding - featureRowGap)
		if panelData then panelData.ExpandedHeight = expandedHeight end
		if panelData then
			panel.Size = U2O(
				panel.Size.X.Offset,
				panelData.Expanded and expandedHeight or PANEL_HEADER_HEIGHT
			)
		else
			panel.Size = U2O(panel.Size.X.Offset, expandedHeight)
		end





		if not skipPanelRefresh and refreshUnsupportedPanels then
			task.defer(refreshUnsupportedPanels)
		end
	end

	local function utilityParentKeys(definition)
		if definition and type(definition.UtilityParentKeys) == "table" then
			return definition.UtilityParentKeys
		end
		if definition and definition.UtilityParentKey ~= nil then
			return {definition.UtilityParentKey}
		end
	end

	local function visibilityUtilityParentKeys(definition)
		if definition and type(definition.VisibilityUtilityParentKeys) == "table" then
			return definition.VisibilityUtilityParentKeys
		end
		if definition and definition.VisibilityUtilityParentKey ~= nil then
			return {definition.VisibilityUtilityParentKey}
		end
	end

	local function utilityParentsEnabled(stateEntry, parentKeys)
		if type(parentKeys) ~= "table" then return true end
		for _, key in ipairs(parentKeys) do
			if not stateEntry or stateEntry[key] ~= true then return false end
		end
		return true
	end

	local function refreshUtilityChildVisibility()
		for _, rowData in ipairs(featureRows) do
			local utilityVisible = true
			if type(rowData.UtilityParentKeys) == "table" then
				utilityVisible = utilityParentsEnabled(
					autoServerHopState.Utility,
					rowData.UtilityParentKeys
				)
				rowData.Row.Visible = utilityVisible
				if rowData.SecondaryContainer then
					rowData.SecondaryContainer.Visible = utilityVisible
				end
				if rowData.AmountContainer then
					rowData.AmountContainer.Visible = utilityVisible
					for _, control in ipairs(rowData.AmountControls or {}) do
						control.Frame.Visible = utilityVisible
					end
				end
			end

			if type(rowData.VisibilityUtilityParentKeys) == "table" then
				local masterVisible = utilityParentsEnabled(
					autoServerHopState.Utility,
					rowData.VisibilityUtilityParentKeys
				)
				rowData.Row.Visible = utilityVisible and masterVisible
			end

			if rowData.MinigameParentId ~= nil then
				local minigameVisible =
					type(minigameAutoplayState) == "table"
					and minigameAutoplayState[rowData.MinigameParentId] == true
				rowData.Row.Visible = rowData.Row.Visible and minigameVisible
				if rowData.AmountContainer then
					rowData.AmountContainer.Visible = rowData.Row.Visible
				end
			end

			if rowData.BoothSlotIndex ~= nil then
				local slotVisible = rowData.BoothSlotIndex
					<= (tonumber(autoServerHopState.RuntimeBoothMaxSlots) or 3)
				rowData.Row.Visible = rowData.Row.Visible and slotVisible
				if rowData.SecondaryContainer then
					rowData.SecondaryContainer.Visible =
						rowData.SecondaryContainer.Visible and slotVisible
				end
				if rowData.AmountContainer then
					rowData.AmountContainer.Visible =
						rowData.AmountContainer.Visible and slotVisible
				end
			end
		end
	end

	local function createFeatureRow(featureIndex, definition)
		local featureRow = New("Frame")
		featureRow.Name = "Feature" .. tostring(featureIndex) .. "Row"
		featureRow.Size = U2(1, -(px(28)), 0, featureRowHeight)
		featureRow.BackgroundTransparency = 1
		featureRow.BorderSizePixel = 0
		featureRow.ZIndex = 45012
		featureRow.Parent = body

		local function resolvedDefinitionOptions()
			if definition and type(definition.OptionsProvider) == "function" then
				local ok, options = pcall(definition.OptionsProvider)
				if ok and type(options) == "table" then
					return options
				end
			end
			return definition and definition.Options or {}
		end
		local function definitionOptionLabel(option)
			if definition and type(definition.OptionLabelProvider) == "function" then
				local ok, label = pcall(definition.OptionLabelProvider, option)
				if ok and label ~= nil then return tostring(label) end
			end
			return tostring(option)
		end
		local hasDropdown = definition
			and (definition.Options ~= nil or definition.OptionsProvider ~= nil)
		local isAutoAccept = definition and definition.AcceptKey ~= nil
		local isAutoSit = definition and definition.SitKey ~= nil
		local isDropdownOnly = definition and definition.DropdownOnly == true
		local isAutoCancel = definition and definition.AutoCancel == true
		local isAutoCancelFilterOnly = isAutoCancel
			and definition.AutoCancelFilterOnly == true
		local isOfferSubrow = definition and definition.OfferSubrow == true
		local isServerHopSliderOnly = definition and definition.ServerHopSliderKey ~= nil
		local isServerHop = definition and (definition.ServerHopKey ~= nil or isServerHopSliderOnly)
		local isServerHopMaster = isServerHop and definition.ServerHopKey == "Enabled"
		local isServerHopChild = isServerHop and not isServerHopMaster
		local isUtilityToggle = definition and definition.UtilityToggleKey ~= nil
		local isUtilityText = definition and definition.UtilityTextKey ~= nil
		local isUtilitySlider = definition and definition.UtilitySliderKey ~= nil
		local isUtilityDropdown = definition and definition.UtilityDropdownKey ~= nil
		local isUtilityMultiDropdown = definition and definition.UtilityMultiDropdownKey ~= nil
		local isCustomReplyManager = definition and definition.CustomReplyManager == true
		local componentLabelGap = px(18)
		local utilityParents = utilityParentKeys(definition)
		local visibilityUtilityParents = visibilityUtilityParentKeys(definition)
		local childIndentLevel = 0
		if type(utilityParents) == "table" then
			childIndentLevel = math.max(childIndentLevel, #utilityParents)
		end
		if type(visibilityUtilityParents) == "table" then
			childIndentLevel = math.max(childIndentLevel, #visibilityUtilityParents)
		end
		if isServerHopChild then
			childIndentLevel = math.max(childIndentLevel, 1)
		end
		local isUtilityChild = (
			isUtilityToggle
			or isUtilityText
			or isUtilitySlider
			or isUtilityDropdown
			or isUtilityMultiDropdown
		)
			and type(utilityParents) == "table"
		local utilityExclusiveGroup = definition and definition.UtilityExclusiveGroup or nil
		local utilityExclusiveRequired =
			definition and definition.UtilityExclusiveRequired == true
		featureRow.Visible = (
			not isServerHopChild
			or (autoServerHopState and autoServerHopState.Enabled == true)
		) and (
			not isUtilityChild
			or utilityParentsEnabled(autoServerHopState.Utility, utilityParents)
		) and (
			type(visibilityUtilityParents) ~= "table"
			or utilityParentsEnabled(autoServerHopState.Utility, visibilityUtilityParents)
		) and (
			(definition and definition.MinigameParentId) == nil
			or (
				type(minigameAutoplayState) == "table"
				and minigameAutoplayState[definition.MinigameParentId] == true
			)
		) and (
			(definition and definition.BoothSlotIndex) == nil
			or definition.BoothSlotIndex
				<= (tonumber(autoServerHopState.RuntimeBoothMaxSlots) or 3)
		)
		local stateEntry
		if isAutoSit then
			stateEntry = autoSitState and autoSitState[definition.SitKey] or nil
		elseif isAutoCancel or isDropdownOnly then
			stateEntry = autoCancelState
		elseif isUtilityDropdown or isUtilityMultiDropdown then
			stateEntry = autoServerHopState.Utility
		elseif hasDropdown then
			stateEntry = autoOfferState and autoOfferState[definition.Source] or nil
		elseif isAutoAccept then
			stateEntry = autoAcceptState and autoAcceptState[definition.AcceptKey] or nil
		elseif isServerHop then
			stateEntry = autoServerHopState
		elseif isUtilityToggle
			or isUtilityText
			or isUtilitySlider
			or isUtilityDropdown
			or isUtilityMultiDropdown
		then
			stateEntry = autoServerHopState.Utility
		end

		local isDependentText = isServerHopChild
			or isUtilityChild
			or type(visibilityUtilityParents) == "table"
			or (definition and definition.MinigameParentId) ~= nil
		local compactUtilitySlider = isUtilitySlider
			and (definition.Label == nil or definition.Label == "")
		local defaultFeatureBaseHeight =
			(isAutoCancelFilterOnly or compactUtilitySlider)
				and 0
				or featureRowHeight
		local childTextIndent = 0
		local dynamicBaseHeight

		local featureLabel = New("TextLabel")
		featureLabel.Name = "Label"
		featureLabel.AnchorPoint = V2(0, 0.5)
		featureLabel.Position = U2(0, childTextIndent, 0, featureRowHeight * 0.5)
		featureLabel.Size = U2(
			1,
			((isUtilityDropdown or isUtilityMultiDropdown)
				and -(dropdownWidth + componentLabelGap + childTextIndent))
				or ((hasDropdown and not isAutoSit and not isOfferSubrow and not isDropdownOnly and not isAutoCancel)
					and -(toggleWidth + dropdownWidth + componentLabelGap + px(14) + childTextIndent)
					or -(toggleWidth + componentLabelGap + childTextIndent)),
			0,
			px(16)
		)
		featureLabel.BackgroundTransparency = 1
		featureLabel.BorderSizePixel = 0
		featureLabel.Text = (isDropdownOnly or isAutoCancelFilterOnly)
			and "" or (definition and definition.Label or "Feature")
		featureLabel.FontFace = MENU_FONT_FACE
		setResponsiveTextSize(featureLabel, (utilityExclusiveGroup or isDependentText) and 14 or 15)
		featureLabel.TextXAlignment = Enum.TextXAlignment.Left
		featureLabel.TextYAlignment = Enum.TextYAlignment.Center
		featureLabel.TextWrapped = true
		featureLabel.TextTruncate = Enum.TextTruncate.None
		featureLabel.ZIndex = 45013
		featureLabel.Parent = featureRow

		local wrappedMeasureWidth
		local wrappedMeasureText
		local wrappedMeasureTextSize
		local wrappedMeasureHeight = px(16)
		local function wrappedFeatureLabelHeight()
			if featureLabel.Text == "" or defaultFeatureBaseHeight <= 0 then
				return px(16)
			end

			-- Never estimate wrapping from a not-yet-laid-out 0px panel. The
			-- panel geometry pass supplies LayoutWidth before final measurement.
			local panelWidth = panelData
				and tonumber(panelData.LayoutWidth)
				or nil
			if panelWidth == nil or panelWidth <= 1 then
				return px(16)
			end

			local featureRowWidth = math.max(
				1,
				panelWidth - px(28)
			)
			local width = math.max(
				1,
				math.floor(
					(
						featureLabel.Size.X.Scale * featureRowWidth
							+ featureLabel.Size.X.Offset
					) + 0.5
				)
			)

			local currentText = featureLabel.Text
			local currentTextSize = featureLabel.TextSize
			if wrappedMeasureWidth == width
				and wrappedMeasureText == currentText
				and wrappedMeasureTextSize == currentTextSize
			then
				return wrappedMeasureHeight
			end

			wrappedMeasureWidth = width
			wrappedMeasureText = currentText
			wrappedMeasureTextSize = currentTextSize

			-- Preserve the original compact 32px row exactly whenever the text
			-- fits on one line. Extra height is added only after a real wrap.
			local oneLineWidth = TextService:GetTextSize(
				currentText,
				currentTextSize,
				MENU_FONT,
				Vector2.new(10000, currentTextSize + px(8))
			).X
			if oneLineWidth <= width then
				wrappedMeasureHeight = px(16)
				return wrappedMeasureHeight
			end

			wrappedMeasureHeight = math.max(
				px(16),
				math.ceil(
					TextService:GetTextSize(
						currentText,
						currentTextSize,
						MENU_FONT,
						Vector2.new(width, 10000)
					).Y
				)
			)
			return wrappedMeasureHeight
		end

		dynamicBaseHeight = function()
			if defaultFeatureBaseHeight <= 0 then
				return defaultFeatureBaseHeight
			end
			return defaultFeatureBaseHeight
				+ math.max(0, wrappedFeatureLabelHeight() - px(16))
		end

		local toggleTrack = New("TextButton")
		toggleTrack.Name = "ToggleTrack"
		toggleTrack.AnchorPoint = V2(1, 0.5)
		toggleTrack.Position = U2(1, 0, 0, featureRowHeight * 0.5)
		toggleTrack.Size = U2O(toggleWidth, toggleHeight)
		toggleTrack.BorderSizePixel = 0
		toggleTrack.AutoButtonColor = false
		toggleTrack.Text = ""
		toggleTrack.ZIndex = 45013
		toggleTrack.Parent = featureRow
		toggleTrack.Visible = not isDropdownOnly
			and not isAutoCancelFilterOnly
			and not isServerHopSliderOnly
			and not isUtilityText
			and not isUtilitySlider
			and not isUtilityDropdown
			and not isUtilityMultiDropdown
		ensureCorner(toggleTrack, toggleHeight * 0.5)
		rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(toggleTrack)

		local toggleKnob = New("Frame")
		toggleKnob.Name = "ToggleKnob"
		toggleKnob.Size = U2O(toggleHeight - knobInset * 2, toggleHeight - knobInset * 2)
		toggleKnob.BackgroundColor3 = MENU_TEXT_SELECTED
		toggleKnob.BorderSizePixel = 0
		toggleKnob.ZIndex = 45014
		toggleKnob.Parent = toggleTrack
		ensureCorner(toggleKnob, (toggleHeight - knobInset * 2) * 0.5)

		local featureEnabled
		if isDropdownOnly then
			featureEnabled = true
		elseif isUtilityToggle then
			featureEnabled = stateEntry and stateEntry[definition.UtilityToggleKey] == true or false
		elseif isUtilityText or isUtilitySlider or isUtilityDropdown or isUtilityMultiDropdown then
			featureEnabled = stateEntry
				and utilityParentsEnabled(stateEntry, utilityParents)
				or false
		elseif isAutoCancel then
			featureEnabled = isAutoCancelFilterOnly
				or (stateEntry and stateEntry.Enabled == true or false)
		elseif isServerHopSliderOnly then
			featureEnabled = autoServerHopState and autoServerHopState.Enabled == true or false
		elseif isServerHop then
			featureEnabled = stateEntry and stateEntry[definition.ServerHopKey] == true or false
		elseif hasDropdown or isAutoAccept or isAutoSit then
			featureEnabled = stateEntry and stateEntry.Enabled == true or false
		else
			featureEnabled = definition
				and minigameAutoplayState
				and minigameAutoplayState[definition.Id] == true
				or false
		end
		setToggleVisual(toggleTrack, toggleKnob, featureLabel, featureEnabled)

		local amountContainer
		local secondaryContainer
		local secondaryLabel
		local amountControls = {}
		local utilityDropdownRefresh
		local utilityDropdownButton
		local utilityTextBox
		local standardDropdownButton
		local dynamicSecondaryHeight


		if isCustomReplyManager and stateEntry then
			secondaryContainer = New("Frame")
			secondaryContainer.Name = "CustomReplyManager"
			secondaryContainer.Position = U2O(0, featureRowHeight)
			secondaryContainer.Size = U2(1, 0, 0, 0)
			secondaryContainer.BackgroundTransparency = 1
			secondaryContainer.BorderSizePixel = 0
			secondaryContainer.Visible = featureEnabled
			secondaryContainer.ZIndex = 45013
			secondaryContainer.Parent = featureRow

			local entriesKey = definition.CustomReplyTableKey or "AutoTradeCustomReplies"
			if type(stateEntry[entriesKey]) ~= "table" then
				stateEntry[entriesKey] = {}
			end

			local dynamicHeightValue = px(1)
			local customAddRow
			local customAddLabel
			local customContentBeforeAdd = 0
			dynamicSecondaryHeight = function()
				if customAddRow and customAddLabel then
					local addLabelWidth = customAddLabel.AbsoluteSize.X
					if addLabelWidth <= 1 then
						local logicalRowWidth = panelData
							and tonumber(panelData.LayoutWidth)
							and math.max(
								1,
								panelData.LayoutWidth - px(28)
							)
							or nil
						if logicalRowWidth then
							addLabelWidth = math.max(
								1,
								logicalRowWidth
									- toggleWidth
									- componentLabelGap
							)
						else
							-- No valid width yet: keep the original one-line row
							-- until the geometry pass supplies the real width.
							return dynamicHeightValue
						end
					end
					local addLabelHeight = math.max(
						px(16),
						math.ceil(
							TextService:GetTextSize(
								customAddLabel.Text,
								customAddLabel.TextSize,
								MENU_FONT,
								Vector2.new(math.max(1, addLabelWidth), 10000)
							).Y
						)
					)
					local addRowHeight = math.max(
						featureRowHeight,
						addLabelHeight + px(8)
					)
					customAddRow.Size = U2(1, 0, 0, addRowHeight)
					customAddLabel.Size = U2(
						1,
						-(toggleWidth + componentLabelGap),
						0,
						addLabelHeight
					)
					dynamicHeightValue =
						customContentBeforeAdd + addRowHeight + px(5)
					secondaryContainer.Size = U2(
						1,
						0,
						0,
						dynamicHeightValue
					)
				end
				return dynamicHeightValue
			end

			local function saveCustomReplies()
				local saver = rawget(_G, "__TUFFHUB_SAVE_SETTINGS_NOW")
				if type(saver) == "function" then
					task.defer(saver, true)
				end
			end

			local function makeReplyInput(y, placeholder, initialValue, onCommit)
				local inputBox = New("TextBox")
				inputBox.Position = U2O(0, y)
				inputBox.Size = U2(1, 0, 0, px(26))
				inputBox.BackgroundColor3 = FEATURE_OFF_COLOR
				inputBox.BorderSizePixel = 0
				inputBox.Active = true
				inputBox.Selectable = true
				inputBox.ClearTextOnFocus = false
				inputBox.ClipsDescendants = true
				inputBox.TextWrapped = false
				inputBox.TextTruncate = Enum.TextTruncate.AtEnd
				inputBox.MultiLine = false
				inputBox.TextEditable = true
				inputBox.Text = tostring(initialValue or "")
				inputBox.PlaceholderText = placeholder
				inputBox.PlaceholderColor3 = MUTED_TEXT_COLOR
				inputBox.TextColor3 = inputBox.Text ~= ""
					and MENU_TEXT_SELECTED
					or MUTED_TEXT_COLOR
				inputBox.FontFace = MENU_FONT_FACE
				setResponsiveTextSize(inputBox, 14)
				inputBox.TextXAlignment = Enum.TextXAlignment.Left
				inputBox.ZIndex = 45015
				inputBox.Parent = secondaryContainer
				ensureCorner(inputBox, px(6))
				rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(inputBox)

				local padding = New("UIPadding")
				padding.PaddingLeft = UDim.new(0, px(9))
				padding.PaddingRight = UDim.new(0, px(9))
				padding.Parent = inputBox

				inputBox:GetPropertyChangedSignal("Text"):Connect(function()
					inputBox.TextColor3 = inputBox.Text ~= ""
						and MENU_TEXT_SELECTED
						or MUTED_TEXT_COLOR
				end)
				inputBox.FocusLost:Connect(function()
					onCommit(inputBox.Text)
					saveCustomReplies()
				end)
			end

			local rebuildCustomReplies
			rebuildCustomReplies = function()
				for _, child in ipairs(secondaryContainer:GetChildren()) do
					child:Destroy()
				end

				local entries = stateEntry[entriesKey]
				if type(entries) ~= "table" then
					entries = {}
					stateEntry[entriesKey] = entries
				end
				local y = px(5)
				for entryIndex, entry in ipairs(entries) do
					if type(entry) ~= "table" then
						entry = {LookFor = "", Reply = ""}
						entries[entryIndex] = entry
					end

					makeReplyInput(
						y,
						"Message to look for",
						entry.LookFor,
						function(value)
							entry.LookFor = value
						end
					)
					y += px(31)

					makeReplyInput(
						y,
						"Reply to message",
						entry.Reply,
						function(value)
							entry.Reply = value
						end
					)
					y += px(31)

					local removeButton = New("TextButton")
					removeButton.Name = "RemoveCustomMessage"
					removeButton.Position = U2O(0, y)
					removeButton.Size = U2(1, 0, 0, px(24))
					removeButton.BackgroundColor3 = FEATURE_OFF_COLOR
					removeButton.BorderSizePixel = 0
					removeButton.AutoButtonColor = false
					removeButton.Text = "Remove Custom Message"
					removeButton.TextColor3 = MUTED_TEXT_COLOR
					removeButton.FontFace = MENU_FONT_FACE
					setResponsiveTextSize(removeButton, 13)
					removeButton.ZIndex = 45015
					removeButton.Parent = secondaryContainer
					ensureCorner(removeButton, px(5))
					rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(removeButton)
					removeButton.MouseButton1Click:Connect(function()
						table.remove(entries, entryIndex)
						saveCustomReplies()
						task.defer(rebuildCustomReplies)
					end)
					y += px(31)
				end

				local addRow = New("Frame")
				customAddRow = addRow
				customContentBeforeAdd = y
				addRow.Name = "AddAnotherCustomMessage"
				addRow.Position = U2O(0, y)
				addRow.Size = U2(1, 0, 0, featureRowHeight)
				addRow.BackgroundTransparency = 1
				addRow.BorderSizePixel = 0
				addRow.ZIndex = 45013
				addRow.Parent = secondaryContainer

				local addLabel = New("TextLabel")
				customAddLabel = addLabel
				addLabel.AnchorPoint = V2(0, 0.5)
				addLabel.Position = U2(0, 0, 0.5, 0)
				addLabel.Size = U2(1, -(toggleWidth + componentLabelGap), 0, px(16))
				addLabel.BackgroundTransparency = 1
				addLabel.Text = "Add Another Custom Message"
				addLabel.TextColor3 = MENU_TEXT_SELECTED
				addLabel.FontFace = MENU_FONT_FACE
				setResponsiveTextSize(addLabel, 14)
				addLabel.TextXAlignment = Enum.TextXAlignment.Left
				addLabel.TextYAlignment = Enum.TextYAlignment.Center
				addLabel.TextWrapped = true
				addLabel.TextTruncate = Enum.TextTruncate.None
				addLabel.ZIndex = 45014
				addLabel.Parent = addRow

				local addToggle = New("TextButton")
				addToggle.AnchorPoint = V2(1, 0.5)
				addToggle.Position = U2(1, 0, 0.5, 0)
				addToggle.Size = U2O(toggleWidth, toggleHeight)
				addToggle.BackgroundColor3 = FEATURE_OFF_COLOR
				addToggle.BorderSizePixel = 0
				addToggle.AutoButtonColor = false
				addToggle.Text = ""
				addToggle.ZIndex = 45014
				addToggle.Parent = addRow
				ensureCorner(addToggle, toggleHeight * 0.5)
				rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(addToggle)

				local addKnob = New("Frame")
				addKnob.Size = U2O(
					toggleHeight - knobInset * 2,
					toggleHeight - knobInset * 2
				)
				addKnob.Position = U2O(knobInset, knobInset)
				addKnob.BackgroundColor3 = MENU_TEXT_SELECTED
				addKnob.BorderSizePixel = 0
				addKnob.ZIndex = 45015
				addKnob.Parent = addToggle
				ensureCorner(addKnob, (toggleHeight - knobInset * 2) * 0.5)

				addToggle.MouseButton1Click:Connect(function()
					TweenService:Create(
						addToggle,
						TI(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = PINK}
					):Play()
					TweenService:Create(
						addKnob,
						TI(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Position = U2(0, toggleWidth - toggleHeight + knobInset, 0, knobInset)}
					):Play()

					entries[#entries + 1] = {LookFor = "", Reply = ""}
					saveCustomReplies()
					task.defer(rebuildCustomReplies)
				end)

				addToggle.Position = U2(1, 0, 0.5, 0)
				dynamicHeightValue = dynamicSecondaryHeight()
				task.defer(relayoutRows)
			end

			rebuildCustomReplies()
		end

		if isUtilityText and stateEntry then
			secondaryContainer = New("Frame")
			secondaryContainer.Name = "TextInputRow"
			local nestedIndent = 0
			secondaryContainer.Position = U2O(nestedIndent, featureRowHeight)
			secondaryContainer.Size = U2(1, -nestedIndent, 0, px(32))
			secondaryContainer.BackgroundTransparency = 1
			secondaryContainer.BorderSizePixel = 0
			secondaryContainer.Visible = featureEnabled
			secondaryContainer.ZIndex = 45013
			secondaryContainer.Parent = featureRow

			local inputBox = New("TextBox")
			utilityTextBox = inputBox
			inputBox.Name = "MessageInput"
			inputBox.Position = U2O(0, 0)
			inputBox.Size = U2(1, 0, 0, px(26))
			inputBox.BackgroundColor3 = FEATURE_OFF_COLOR
			inputBox.BorderSizePixel = 0
			inputBox.Active = true
			inputBox.Selectable = true
			inputBox.ClearTextOnFocus = false
			inputBox.ClipsDescendants = true
			inputBox.TextWrapped = false
			inputBox.TextTruncate = Enum.TextTruncate.AtEnd
			inputBox.MultiLine = false
			inputBox.TextEditable = true
			inputBox.Text = tostring(stateEntry[definition.UtilityTextKey] or "")
			inputBox.PlaceholderText = definition.Placeholder or "Type a message..."
			inputBox.PlaceholderColor3 = MUTED_TEXT_COLOR
			inputBox.TextColor3 = inputBox.Text ~= ""
				and MENU_TEXT_SELECTED
				or MUTED_TEXT_COLOR
			inputBox.FontFace = MENU_FONT_FACE
			setResponsiveTextSize(inputBox, 14)
			inputBox.TextXAlignment = Enum.TextXAlignment.Left
			inputBox.ZIndex = 45015
			inputBox.Parent = secondaryContainer
			ensureCorner(inputBox, px(6))
			rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(inputBox)

			local inputPadding = New("UIPadding")
			inputPadding.PaddingLeft = UDim.new(0, px(9))
			inputPadding.PaddingRight = UDim.new(0, px(9))
			inputPadding.Parent = inputBox

			local editingKey = definition.EditingKey
				or (
					definition.UtilityTextKey == "AutoChatMessage"
						and "AutoChatEditing"
						or "AutoTradeChatEditing"
				)
			local revisionKey = definition.RevisionKey
				or (
					definition.UtilityTextKey == "AutoChatMessage"
						and "AutoChatMessageRevision"
						or "AutoTradeMessageRevision"
				)



			featureLabel.TextColor3 = tostring(
				stateEntry[definition.UtilityTextKey] or ""
			) ~= ""
				and MENU_TEXT_SELECTED
				or MUTED_TEXT_COLOR

			inputBox.Focused:Connect(function()
				stateEntry[editingKey] = true
				inputBox.TextColor3 = inputBox.Text ~= ""
					and MENU_TEXT_SELECTED
					or MUTED_TEXT_COLOR

				featureLabel.TextColor3 = tostring(
					stateEntry[definition.UtilityTextKey] or ""
				) ~= ""
					and MENU_TEXT_SELECTED
					or MUTED_TEXT_COLOR
			end)

			inputBox:GetPropertyChangedSignal("Text"):Connect(function()
				inputBox.TextColor3 = inputBox.Text ~= ""
					and MENU_TEXT_SELECTED
					or MUTED_TEXT_COLOR
			end)

			inputBox.FocusLost:Connect(function()
				stateEntry[definition.UtilityTextKey] = inputBox.Text
				stateEntry[editingKey] = false
				stateEntry[revisionKey] =
					(math.floor(tonumber(stateEntry[revisionKey]) or 0) + 1)
				local committedColor = inputBox.Text ~= ""
					and MENU_TEXT_SELECTED
					or MUTED_TEXT_COLOR
				inputBox.TextColor3 = committedColor
				featureLabel.TextColor3 = committedColor
			end)
		end

		if (isUtilityDropdown or isUtilityMultiDropdown) and stateEntry then
			local dropdownButton = New("TextButton")
			utilityDropdownButton = dropdownButton
			dropdownButton.Name = "Dropdown"
			dropdownButton.AnchorPoint = V2(1, 0.5)
			dropdownButton.Position = U2(1, 0, 0, featureRowHeight * 0.5)
			dropdownButton.Size = U2O(dropdownWidth, px(24))
			dropdownButton.BackgroundColor3 = FEATURE_OFF_COLOR
			dropdownButton.BorderSizePixel = 0
			dropdownButton.AutoButtonColor = false
			dropdownButton.FontFace = MENU_FONT_FACE
			setResponsiveTextSize(dropdownButton, 14)
			dropdownButton.TextColor3 = MENU_TEXT_SELECTED
			dropdownButton.TextTruncate = Enum.TextTruncate.None
			dropdownButton.ZIndex = 45014
			dropdownButton.Parent = featureRow
			ensureCorner(dropdownButton, px(6))
			rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(dropdownButton)

			local function utilitySelectionTable()
				if not isUtilityMultiDropdown then return nil end
				local key = definition.UtilityMultiDropdownKey
				if type(stateEntry[key]) ~= "table" then
					stateEntry[key] = {}
				end
				return stateEntry[key]
			end

			local function sanitizeUtilityMultiSelection()
				local selected = utilitySelectionTable()
				if not selected then return end
				local excluded = definition.ExcludeUtilityDropdownKey
					and stateEntry[definition.ExcludeUtilityDropdownKey]
					or nil
				if excluded ~= nil then
					selected[excluded] = nil
				end
				local allowed = {}
				for _, option in ipairs(resolvedDefinitionOptions()) do
					if option ~= excluded then allowed[option] = true end
				end
				for option in pairs(selected) do
					if not allowed[option] then selected[option] = nil end
				end
			end

			local function syncUtilityDropdownText()
				if isUtilityMultiDropdown then
					sanitizeUtilityMultiSelection()
					local selected = utilitySelectionTable()
					local names = {}
					for _, option in ipairs(resolvedDefinitionOptions()) do
						if selected[option] then names[#names + 1] = definitionOptionLabel(option) end
					end
					local hasValue = #names > 0
					fitWholeDropdownNames(
						dropdownButton,
						names,
						tostring(definition.Placeholder or "Select")
					)
					featureLabel.TextColor3 = hasValue
						and MENU_TEXT_SELECTED
						or MUTED_TEXT_COLOR
				else
					local value = stateEntry[definition.UtilityDropdownKey]
					if value ~= nil
						and definition.OptionsProvider
						and definition.ClearIfMissing == true
					then
						local found = false
						for _, option in ipairs(resolvedDefinitionOptions()) do
							if tostring(option) == tostring(value) then
								found = true
								break
							end
						end
						if not found then
							stateEntry[definition.UtilityDropdownKey] = nil
							value = nil
						end
					end
					local hasValue = value ~= nil and tostring(value) ~= ""
					fitWholeDropdownNames(
						dropdownButton,
						hasValue and {definitionOptionLabel(value)} or {},
						tostring(definition.Placeholder or "Select")
					)
					featureLabel.TextColor3 = dropdownButton.TextColor3
				end
			end
			utilityDropdownRefresh = syncUtilityDropdownText
			syncUtilityDropdownText()
			task.defer(syncUtilityDropdownText)
			dropdownButton:GetPropertyChangedSignal("AbsoluteSize"):Connect(syncUtilityDropdownText)
			dropdownButton:GetPropertyChangedSignal("TextSize"):Connect(syncUtilityDropdownText)

			dropdownButton.MouseButton1Click:Connect(function()
				if activePanelDropdown and activePanelDropdown.Button == dropdownButton then
					closeActivePanelDropdown()
					return
				end
				closeActivePanelDropdown()
				sanitizeUtilityMultiSelection()

				local popupOptions = {}
				local excluded = definition.ExcludeUtilityDropdownKey
					and stateEntry[definition.ExcludeUtilityDropdownKey]
					or nil
				for _, option in ipairs(resolvedDefinitionOptions()) do
					if option ~= excluded then
						popupOptions[#popupOptions + 1] = option
					end
				end

				local overlay = New("Frame")
				overlay.Name = "DropdownOverlay"
				overlay.Position = U2S(0, 0)
				overlay.Size = U2S(1, 1)
				overlay.BackgroundTransparency = 1
				overlay.BorderSizePixel = 0
				overlay.Active = false
				overlay.ZIndex = 59998
				overlay.Parent = screenGui

				local blocker = New("Frame")
				blocker.Name = "DropdownInputPassThrough"
				blocker.Size = U2S(1, 1)
				blocker.BackgroundTransparency = 1
				blocker.BorderSizePixel = 0
				blocker.Active = false
				blocker.ZIndex = 59999
				blocker.Parent = overlay

				local dropdownSearchHeight = px(29)
				local popupContentHeight = dropdownSearchHeight + px(6) + (#popupOptions * px(25))



				local desiredVisibleHeight = math.min(
					popupContentHeight,
					math.floor(window.AbsoluteSize.Y * 0.42)
				)
				if dropdownButton:IsDescendantOf(rightContent) then
					local buttonBottom = dropdownButton.AbsolutePosition.Y
						+ dropdownButton.AbsoluteSize.Y
					local windowBottom = window.AbsolutePosition.Y
						+ window.AbsoluteSize.Y
					local roomBelow = windowBottom - buttonBottom - px(6)
					if roomBelow < desiredVisibleHeight then
						local needed = desiredVisibleHeight - roomBelow
						local maxCanvasY = math.max(
							0,
							rightContent.AbsoluteCanvasSize.Y
								- rightContent.AbsoluteSize.Y
						)
						rightContent.CanvasPosition = V2(
							rightContent.CanvasPosition.X,
							math.clamp(
								rightContent.CanvasPosition.Y + needed,
								0,
								maxCanvasY
							)
						)
					end
				end

				local popup = New("ScrollingFrame")
				popup.Name = "PanelDropdown"
				popup.BackgroundColor3 = PANEL_BACKGROUND
				popup.BorderSizePixel = 0
				popup.ClipsDescendants = true
				popup.Active = true
				popup.ScrollBarThickness = px(3)
				popup.ScrollingDirection = Enum.ScrollingDirection.Y
				popup.CanvasSize = U2O(0, popupContentHeight)
				popup.AutomaticCanvasSize = Enum.AutomaticSize.None
				popup.ZIndex = 60000
				popup.Parent = overlay
				ensureCorner(popup, px(7))

				local stroke = New("UIStroke")
				stroke.Color = LINE_COLOR
				stroke.Thickness = LINE_THICKNESS
				stroke.Transparency = LINE_TRANSPARENCY
				stroke.Parent = popup

				local function syncPopupPosition()
					if not popup.Parent or not dropdownButton.Parent or not window.Parent then return end
					local buttonAbs = dropdownButton.AbsolutePosition
					local buttonSize = dropdownButton.AbsoluteSize
					local overlayAbs = overlay.AbsolutePosition
					local windowAbs = window.AbsolutePosition
					local windowSize = window.AbsoluteSize
					local edgeInset = px(6)
					local popupWidth = math.floor(buttonSize.X + 0.5)
					local minAbsX = windowAbs.X + edgeInset
					local maxAbsX = windowAbs.X + windowSize.X - popupWidth - edgeInset
					local popupAbsX = math.clamp(buttonAbs.X, minAbsX, math.max(minAbsX, maxAbsX))
					local popupAbsY = buttonAbs.Y + buttonSize.Y
					local availableBelow = math.max(
						0,
						windowAbs.Y + windowSize.Y - edgeInset - popupAbsY
					)
					popup.Position = U2O(
						popupAbsX - overlayAbs.X,
						popupAbsY - overlayAbs.Y
					)
					popup.Size = U2O(
						popupWidth,
						math.min(popupContentHeight, availableBelow)
					)
				end
				syncPopupPosition()
				task.defer(syncPopupPosition)

				local followConnection =
					game:GetService("RunService").RenderStepped:Connect(syncPopupPosition)
				activePanelDropdown = {
					Popup = popup,
					Button = dropdownButton,
					Blocker = blocker,
					Overlay = overlay,
					FollowConnection = followConnection,
				}

				local openedAt = os.clock()
				local outsideConnection
				outsideConnection = UserInputService.InputBegan:Connect(function(input)
					if not activePanelDropdown or activePanelDropdown.Popup ~= popup then return end
					if input.UserInputType ~= Enum.UserInputType.MouseButton1
						and input.UserInputType ~= Enum.UserInputType.Touch
					then
						return
					end
					if os.clock() - openedAt < 0.05 then return end
					if pointInsideGui(popup, input.Position)
						or pointInsideGui(dropdownButton, input.Position)
					then
						return
					end
					task.defer(function()
						if activePanelDropdown and activePanelDropdown.Popup == popup then
							closeActivePanelDropdown()
						end
					end)
				end)
				activePanelDropdown.OutsideConnection = outsideConnection

				local dropdownSearch = New("TextBox")
				dropdownSearch.Name = "Search"
				dropdownSearch.Position = U2O(px(4), px(4))
				dropdownSearch.Size = U2(1, -px(8), 0, px(22))
				dropdownSearch.BackgroundColor3 = FEATURE_OFF_COLOR
				dropdownSearch.BorderSizePixel = 0
				dropdownSearch.ClearTextOnFocus = false
				dropdownSearch.PlaceholderText = "Search"
				dropdownSearch.PlaceholderColor3 = MUTED_TEXT_COLOR
				dropdownSearch.Text = ""
				dropdownSearch.TextColor3 = MENU_TEXT_SELECTED
				dropdownSearch.FontFace = MENU_FONT_FACE
				setResponsiveTextSize(dropdownSearch, 13)
				dropdownSearch.TextXAlignment = Enum.TextXAlignment.Left
				dropdownSearch.ZIndex = 60002
				dropdownSearch.Parent = popup
				ensureCorner(dropdownSearch, px(5))
				rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(dropdownSearch)
				local dropdownSearchPadding = New("UIPadding")
				dropdownSearchPadding.PaddingLeft = UDim.new(0, px(7))
				dropdownSearchPadding.PaddingRight = UDim.new(0, px(7))
				dropdownSearchPadding.Parent = dropdownSearch

				local optionButtons = {}
				local optionSearchLabels = {}
				local function filterUtilityOptions()
					local query = string.lower(tostring(dropdownSearch.Text or ""))
					local visibleIndex = 0
					for _, option in ipairs(popupOptions) do
						local optionButton = optionButtons[option]
						if optionButton then
							local visible = query == ""
								or string.find(
									optionSearchLabels[option] or "",
									query,
									1,
									true
								) ~= nil
							optionButton.Visible = visible
							if visible then
								optionButton.Position = U2O(
									px(4),
									dropdownSearchHeight + px(3) + visibleIndex * px(25)
								)
								visibleIndex += 1
							end
						end
					end
					popupContentHeight =
						dropdownSearchHeight + px(6) + visibleIndex * px(25)
					popup.CanvasSize = U2O(0, popupContentHeight)
					syncPopupPosition()
				end
				local function refreshUtilityOptionVisuals()
					for option, optionButton in pairs(optionButtons) do
						local selected = isUtilityMultiDropdown
							and utilitySelectionTable()[option] == true
							or stateEntry[definition.UtilityDropdownKey] == option
						optionButton.BackgroundTransparency = selected and 0 or 1
						optionButton.TextColor3 = selected
							and MENU_TEXT_SELECTED
							or MUTED_TEXT_COLOR
					end
				end

				for optionIndex, option in ipairs(popupOptions) do
					local optionButton = New("TextButton")
					optionButton.Name = tostring(option)
					optionButton.Position = U2O(
						px(4),
						dropdownSearchHeight + px(3) + (optionIndex - 1) * px(25)
					)
					optionButton.Size = U2(1, -px(8), 0, px(23))
					optionButton.BackgroundColor3 = FEATURE_OFF_COLOR
					optionButton.BorderSizePixel = 0
					optionButton.AutoButtonColor = false
					optionButton.Text = definitionOptionLabel(option)
					optionSearchLabels[option] = string.lower(optionButton.Text)
					optionButton.FontFace = MENU_FONT_FACE
					setResponsiveTextSize(optionButton, 14)
					optionButton.ZIndex = 60001
					optionButton.Parent = popup
					optionButtons[option] = optionButton
					ensureCorner(optionButton, px(5))

					optionButton.MouseButton1Click:Connect(function()
						if isUtilityMultiDropdown then
							local selected = utilitySelectionTable()
							selected[option] = selected[option] ~= true and true or nil
							syncUtilityDropdownText()
							refreshUtilityOptionVisuals()

							return
						end

						stateEntry[definition.UtilityDropdownKey] = option
						if definition.ClearsUtilityDropdownKey
							and stateEntry[definition.ClearsUtilityDropdownKey] == option
						then
							stateEntry[definition.ClearsUtilityDropdownKey] = nil
						end
						if definition.ClearsUtilityMultiDropdownKey then
							local selected = stateEntry[definition.ClearsUtilityMultiDropdownKey]
							if type(selected) == "table" then
								selected[option] = nil
							end
						end
						for _, rowData in ipairs(featureRows) do
							if rowData.RefreshUtilityDropdown then
								rowData.RefreshUtilityDropdown()
							end
						end
						syncUtilityDropdownText()
						closeActivePanelDropdown()
					end)
				end
				refreshUtilityOptionVisuals()
				dropdownSearch:GetPropertyChangedSignal("Text"):Connect(filterUtilityOptions)
				filterUtilityOptions()
				task.defer(function()
					if dropdownSearch.Parent then
						pcall(dropdownSearch.CaptureFocus, dropdownSearch)
					end
				end)
			end)
		end

		if hasDropdown and not isUtilityDropdown and not isUtilityMultiDropdown then
			stateEntry.Amounts = stateEntry.Amounts or {}
			stateEntry.Targets = stateEntry.Targets or {}
			local dropdownParent = featureRow
			if isAutoSit or isOfferSubrow or isDropdownOnly or isAutoCancel then
				secondaryContainer = New("Frame")
				secondaryContainer.Name = isAutoSit
					and "OpponentMustOwnRow"
					or (isOfferSubrow and "OfferRow" or (isAutoCancel and "AutoCancelFilterRow" or "DropdownRow"))
				local nestedIndent = 0
				secondaryContainer.Position = U2O(
					nestedIndent,
					isAutoCancelFilterOnly and 0 or featureRowHeight
				)
				local secondaryRowHeight = isAutoCancel and px(58) or secondaryControlHeight
				secondaryContainer.Size = U2(1, -nestedIndent, 0, secondaryRowHeight)
				secondaryContainer.BackgroundTransparency = 1
				secondaryContainer.BorderSizePixel = 0
				secondaryContainer.Visible = isDropdownOnly or featureEnabled
				secondaryContainer.ZIndex = 45013
				secondaryContainer.Parent = featureRow
				dropdownParent = secondaryContainer

				secondaryLabel = New("TextLabel")
				secondaryLabel.Name = isAutoSit
					and "OpponentMustOwnLabel"
					or (isOfferSubrow and "OfferLabel" or (isAutoCancel and "AutoCancelConditionLabel" or "DropdownLabel"))
				secondaryLabel.AnchorPoint = V2(0, isAutoCancel and 0 or 0.5)
				secondaryLabel.Position = isAutoCancel and U2O(0, 0) or U2(0, 0, 0.5, 0)
				secondaryLabel.Size = isAutoCancel
					and U2(1, 0, 0, px(15))
					or U2(1, -(dropdownWidth + componentLabelGap), 0, px(16))
				secondaryLabel.BackgroundTransparency = 1
				secondaryLabel.BorderSizePixel = 0
				secondaryLabel.Text = isAutoSit
					and "Opponent Must Own"
					or (isOfferSubrow and "Offer" or (isAutoCancel and "Cancel If Player Does Not Own" or (definition.DropdownLabel or definition.Label)))
				secondaryLabel.TextColor3 = isAutoCancel
					and ((stateEntry and next(stateEntry.Targets) ~= nil) and MENU_TEXT_SELECTED or MUTED_TEXT_COLOR)
					or ((isDropdownOnly or featureEnabled) and MENU_TEXT_SELECTED or MUTED_TEXT_COLOR)
				secondaryLabel.FontFace = MENU_FONT_FACE
				setResponsiveTextSize(secondaryLabel, 14)
				secondaryLabel.TextXAlignment = Enum.TextXAlignment.Left
				secondaryLabel.TextYAlignment = isAutoCancel and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center
				secondaryLabel.TextWrapped = true
				secondaryLabel.TextTruncate = Enum.TextTruncate.None
				secondaryLabel.ZIndex = 45014
				secondaryLabel.Parent = secondaryContainer
			end

			local dropdownButton = New("TextButton")
			standardDropdownButton = dropdownButton
			dropdownButton.Name = "Dropdown"
			dropdownButton.AnchorPoint = V2(1, 0.5)
			dropdownButton.Position = isAutoCancel
				and U2(1, 0, 0, px(29))
				or ((isAutoSit or isOfferSubrow or isDropdownOnly)
					and U2(1, 0, 0.5, 0)
					or U2(1, -(toggleWidth + px(10)), 0, featureRowHeight * 0.5))
			dropdownButton.Size = isAutoCancel and U2(1, 0, 0, px(26)) or U2O(dropdownWidth, px(24))
			dropdownButton.BackgroundColor3 = FEATURE_OFF_COLOR
			dropdownButton.BorderSizePixel = 0
			dropdownButton.AutoButtonColor = false
			dropdownButton.TextColor3 = MENU_TEXT_SELECTED
			dropdownButton.FontFace = MENU_FONT_FACE
			setResponsiveTextSize(dropdownButton, 14)
			dropdownButton.TextTruncate = Enum.TextTruncate.None
			dropdownButton.ZIndex = 45014
			dropdownButton.Parent = dropdownParent
			ensureCorner(dropdownButton, px(6))
			rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(dropdownButton)
			local function syncStandardDropdownText()
				updateDropdownText(
					dropdownButton,
					stateEntry,
					isAutoSit and "Any" or definition.Placeholder,
					definition.Options
				)
			end
			syncStandardDropdownText()
			task.defer(syncStandardDropdownText)
			dropdownButton:GetPropertyChangedSignal("AbsoluteSize"):Connect(syncStandardDropdownText)
			dropdownButton:GetPropertyChangedSignal("TextSize"):Connect(syncStandardDropdownText)

			amountContainer = New("Frame")
			amountContainer.Name = "AmountControls"
			local amountNestedIndent = 0
			amountContainer.Position = U2O(
				amountNestedIndent,
				featureRowHeight + ((isAutoSit and featureEnabled) and secondaryControlHeight or 0)
			)
			amountContainer.Size = U2(1, -amountNestedIndent, 0, 0)
			amountContainer.BackgroundTransparency = 1
			amountContainer.BorderSizePixel = 0
			amountContainer.Visible = featureEnabled
			amountContainer.ZIndex = 45013
			amountContainer.Parent = featureRow

			local function makeAmountControl(option)
				local isToken = option == "Tokens"
				local minAmount = isToken and isOfferSubrow and 0 or 1
				local maxAmount = isToken and 100000
					or ((isAutoSit or isAutoCancel) and 100 or 6)
				local frame = New("Frame")
				frame.Name = option .. "AmountControl"
				frame.Size = U2(1, 0, 0, amountControlsHeight)
				frame.BackgroundTransparency = 1
				frame.BorderSizePixel = 0
				frame.Visible = featureEnabled
					and ((isOfferSubrow and isToken) or stateEntry.Targets[option] == true)
				frame.ZIndex = 45013
				frame.Parent = amountContainer

				local label = New("TextLabel")
				label.Name = "AmountLabel"
				label.Position = U2O(0, 0)
				label.Size = U2(1, -amountValueWidth - componentLabelGap, 0, px(15))
				label.BackgroundTransparency = 1
				label.Text = isToken and "Token Amount" or (option .. " Amount")
				local initialAmount = isToken
					and math.floor(tonumber(stateEntry.Tokens) or minAmount)
					or math.floor(tonumber(stateEntry.Amounts[option]) or minAmount)
				label.TextColor3 = initialAmount > 0
					and MENU_TEXT_SELECTED
					or MUTED_TEXT_COLOR
				label.FontFace = MENU_FONT_FACE
				setResponsiveTextSize(label, 14)
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.ZIndex = 45014
				label.Parent = frame

				local valueBox = New("TextBox")
				valueBox.Name = "AmountValue"
				valueBox.AnchorPoint = V2(1, 0)
				valueBox.Position = U2(1, 0, 0, 0)
				valueBox.Size = U2O(amountValueWidth, px(20))
				valueBox.BackgroundColor3 = FEATURE_OFF_COLOR
				valueBox.BorderSizePixel = 0
				valueBox.ClearTextOnFocus = false
				valueBox.ClipsDescendants = true
				valueBox.TextWrapped = false
				valueBox.TextTruncate = Enum.TextTruncate.AtEnd
				valueBox.TextColor3 = initialAmount > 0
					and MENU_TEXT_SELECTED
					or MUTED_TEXT_COLOR
				valueBox.FontFace = MENU_FONT_FACE
				setResponsiveTextSize(valueBox, 14)
				valueBox.ZIndex = 45014
				valueBox.Parent = frame
				ensureCorner(valueBox, px(5))
				rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(valueBox)

				local sliderTrack = New("Frame")
				sliderTrack.Name = "SliderTrack"
				sliderTrack.Position = U2O(0, px(27))
				sliderTrack.Size = U2(1, 0, 0, px(5))
				sliderTrack.BackgroundColor3 = FEATURE_OFF_COLOR
				sliderTrack.BorderSizePixel = 0
				sliderTrack.Active = true
				sliderTrack.ZIndex = 45014
				sliderTrack.Parent = frame
				ensureCorner(sliderTrack, px(3))
				rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(sliderTrack)

				local sliderFill = New("Frame")
				sliderFill.Name = "Fill"
				sliderFill.BackgroundColor3 = PINK
				sliderFill.BorderSizePixel = 0
				sliderFill.ZIndex = 45015
				sliderFill.Parent = sliderTrack
				ensureCorner(sliderFill, px(3))

				local sliderKnob = New("Frame")
				sliderKnob.Name = "Knob"
				sliderKnob.AnchorPoint = V2(0.5, 0.5)
				sliderKnob.Size = U2O(px(11), px(11))
				sliderKnob.BackgroundColor3 = MENU_TEXT_SELECTED
				sliderKnob.BorderSizePixel = 0
				sliderKnob.ZIndex = 45016
				sliderKnob.Parent = sliderTrack
				ensureCorner(sliderKnob, px(6))

				local function currentValue()
					if isToken then
						return math.clamp(
							math.floor(tonumber(stateEntry.Tokens) or minAmount),
							minAmount,
							100000
						)
					end
					return math.clamp(
						math.floor(tonumber(stateEntry.Amounts[option]) or 1),
						1,
						(isAutoSit or isAutoCancel) and 100 or 6
					)
				end

				local function setAmount(amount, updateBox)
					amount = math.clamp(
						math.floor(tonumber(amount) or minAmount),
						minAmount,
						maxAmount
					)
					if not isToken then
						if isAutoSit then
							local otherTotal = 0
							for _, rarityName in ipairs(RARITY_OPTIONS) do
								if rarityName ~= "Tokens"
									and rarityName ~= option
									and stateEntry.Targets
									and stateEntry.Targets[rarityName]
								then
									otherTotal += math.clamp(
										math.floor(tonumber(stateEntry.Amounts[rarityName]) or 1),
										1,
										100
									)
								end
							end
							amount = math.min(amount, math.max(1, 100 - otherTotal))
						elseif not isAutoCancel then
							local remaining = math.max(1, 6 - brainrotAmountTotal(stateEntry, option))
							amount = math.min(amount, remaining)
						end
						stateEntry.Amounts[option] = amount
					else
						stateEntry.Tokens = amount
					end
					if updateBox then valueBox.Text = tostring(amount) end
					local amountTextColor = featureEnabled and amount > 0
						and MENU_TEXT_SELECTED
						or MUTED_TEXT_COLOR
					label.TextColor3 = amountTextColor
					valueBox.TextColor3 = amountTextColor
					local alpha = maxAmount == minAmount
						and 0
						or ((amount - minAmount) / (maxAmount - minAmount))
					sliderFill.Size = U2S(alpha, 1)
					sliderKnob.Position = U2(alpha, 0, 0.5, 0)
				end

				setAmount(currentValue(), true)
				valueBox.FocusLost:Connect(function() setAmount(valueBox.Text, true) end)

				local function updateSlider(pointX)
					local width = math.max(1, sliderTrack.AbsoluteSize.X)
					local alpha = math.clamp((pointX - sliderTrack.AbsolutePosition.X) / width, 0, 1)
					setAmount(
						minAmount + math.floor(alpha * (maxAmount - minAmount) + 0.5),
						true
					)
				end
				sliderTrack.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1
						or input.UserInputType == Enum.UserInputType.Touch
					then
						beginSliderDrag(input, updateSlider)
					end
				end)

				local control = {Frame = frame, Option = option, SetAmount = setAmount, ValueBox = valueBox}
				amountControls[#amountControls + 1] = control
				return control
			end

			local controlsByOption = {}
			if not isDropdownOnly then
				for _, option in ipairs(definition.Options) do
					controlsByOption[option] = makeAmountControl(option)
				end
				if isOfferSubrow then
					controlsByOption.Tokens = makeAmountControl("Tokens")
					controlsByOption.Tokens.Frame.Visible = featureEnabled
				end
			end

			dropdownButton.MouseButton1Click:Connect(function()
				if activePanelDropdown and activePanelDropdown.Button == dropdownButton then
					closeActivePanelDropdown()
					return
				end
				closeActivePanelDropdown()




				local overlay = New("Frame")
				overlay.Name = "DropdownOverlay"
				overlay.AnchorPoint = V2(0, 0)
				overlay.Position = U2S(0, 0)
				overlay.Size = U2S(1, 1)
				overlay.BackgroundTransparency = 1
				overlay.BorderSizePixel = 0
				overlay.ClipsDescendants = false
				overlay.Active = false
				overlay.ZIndex = 59998
				overlay.Parent = screenGui




				local blocker = New("Frame")
				blocker.Name = "DropdownInputPassThrough"
				blocker.AnchorPoint = V2(0, 0)
				blocker.Position = U2S(0, 0)
				blocker.Size = U2S(1, 1)
				blocker.BackgroundTransparency = 1
				blocker.BorderSizePixel = 0
				blocker.Active = false
				blocker.ZIndex = 59999
				blocker.Parent = overlay

				local popupOptions = {}
				if isAutoSit then popupOptions[#popupOptions + 1] = "Any" end
				for _, option in ipairs(definition.Options) do
					popupOptions[#popupOptions + 1] = option
				end
				local dropdownSearchHeight = px(29)
				local popupContentHeight = dropdownSearchHeight + px(6) + (#popupOptions * px(25))




				local desiredVisibleHeight = math.min(
					popupContentHeight,
					math.floor(window.AbsoluteSize.Y * 0.42)
				)
				if dropdownButton:IsDescendantOf(rightContent) then
					local buttonBottom = dropdownButton.AbsolutePosition.Y
						+ dropdownButton.AbsoluteSize.Y
					local windowBottom = window.AbsolutePosition.Y
						+ window.AbsoluteSize.Y
					local roomBelow = windowBottom - buttonBottom - px(6)
					if roomBelow < desiredVisibleHeight then
						local needed = desiredVisibleHeight - roomBelow
						local maxCanvasY = math.max(
							0,
							rightContent.AbsoluteCanvasSize.Y - rightContent.AbsoluteSize.Y
						)
						rightContent.CanvasPosition = V2(
							rightContent.CanvasPosition.X,
							math.clamp(
								rightContent.CanvasPosition.Y + needed,
								0,
								maxCanvasY
							)
						)
					end
				end

				local popup = New("ScrollingFrame")
				popup.Name = "PanelDropdown"
				popup.AnchorPoint = V2(0, 0)
				popup.BackgroundColor3 = PANEL_BACKGROUND
				popup.BorderSizePixel = 0
				popup.ClipsDescendants = true
				popup.Active = true
				popup.ScrollBarThickness = px(3)
				popup.ScrollingDirection = Enum.ScrollingDirection.Y
				popup.CanvasPosition = V2(0, 0)
				popup.CanvasSize = U2O(0, popupContentHeight)
				popup.AutomaticCanvasSize = Enum.AutomaticSize.None
				popup.ZIndex = 60000

				popup.Parent = overlay

				local function syncPopupPosition()
					if not popup.Parent
						or not overlay.Parent
						or not dropdownButton.Parent
						or not window.Parent
					then
						return
					end

					local buttonAbs = dropdownButton.AbsolutePosition
					local buttonSize = dropdownButton.AbsoluteSize
					local overlayAbs = overlay.AbsolutePosition
					local windowAbs = window.AbsolutePosition
					local windowSize = window.AbsoluteSize
					local edgeInset = px(6)



					local localX = buttonAbs.X - overlayAbs.X
					local localY = buttonAbs.Y - overlayAbs.Y + buttonSize.Y
					local popupWidth = math.floor(buttonSize.X + 0.5)


					local minAbsX = windowAbs.X + edgeInset
					local maxAbsX = windowAbs.X + windowSize.X - popupWidth - edgeInset
					local popupAbsX = math.clamp(
						buttonAbs.X,
						minAbsX,
						math.max(minAbsX, maxAbsX)
					)
					localX = popupAbsX - overlayAbs.X



					local popupAbsY = buttonAbs.Y + buttonSize.Y
					local maxBottom = windowAbs.Y + windowSize.Y - edgeInset
					local availableBelow = math.max(0, maxBottom - popupAbsY)
					local visibleHeight = math.min(popupContentHeight, availableBelow)

					popup.Position = U2O(localX, localY)
					popup.Size = U2O(popupWidth, visibleHeight)
					popup.CanvasSize = U2O(0, popupContentHeight)
				end

				syncPopupPosition()
				task.defer(syncPopupPosition)
				ensureCorner(popup, px(7))
				local stroke = New("UIStroke")
				stroke.Color = LINE_COLOR
				stroke.Thickness = LINE_THICKNESS
				stroke.Transparency = LINE_TRANSPARENCY
				stroke.Parent = popup
				local followConnection = game:GetService("RunService").RenderStepped:Connect(syncPopupPosition)
				activePanelDropdown = {
					Popup = popup,
					Button = dropdownButton,
					Blocker = blocker,
					Overlay = overlay,
					FollowConnection = followConnection,
				}

				local openedAt = os.clock()
				local outsideConnection
				outsideConnection = UserInputService.InputBegan:Connect(
					function(input)
						if not activePanelDropdown
							or activePanelDropdown.Popup ~= popup
						then
							return
						end
						if input.UserInputType ~= Enum.UserInputType.MouseButton1
							and input.UserInputType ~= Enum.UserInputType.Touch
						then
							return
						end


						if os.clock() - openedAt < 0.05 then
							return
						end

						local point = input.Position
						if pointInsideGui(popup, point)
							or pointInsideGui(dropdownButton, point)
						then
							return
						end


						task.defer(function()
							if activePanelDropdown
								and activePanelDropdown.Popup == popup
							then
								closeActivePanelDropdown()
							end
						end)
					end
				)
				activePanelDropdown.OutsideConnection = outsideConnection

				local dropdownSearch = New("TextBox")
				dropdownSearch.Name = "Search"
				dropdownSearch.Position = U2O(px(4), px(4))
				dropdownSearch.Size = U2(1, -px(8), 0, px(22))
				dropdownSearch.BackgroundColor3 = FEATURE_OFF_COLOR
				dropdownSearch.BorderSizePixel = 0
				dropdownSearch.ClearTextOnFocus = false
				dropdownSearch.PlaceholderText = "Search"
				dropdownSearch.PlaceholderColor3 = MUTED_TEXT_COLOR
				dropdownSearch.Text = ""
				dropdownSearch.TextColor3 = MENU_TEXT_SELECTED
				dropdownSearch.FontFace = MENU_FONT_FACE
				setResponsiveTextSize(dropdownSearch, 13)
				dropdownSearch.TextXAlignment = Enum.TextXAlignment.Left
				dropdownSearch.ZIndex = 60002
				dropdownSearch.Parent = popup
				ensureCorner(dropdownSearch, px(5))
				rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(dropdownSearch)
				local dropdownSearchPadding = New("UIPadding")
				dropdownSearchPadding.PaddingLeft = UDim.new(0, px(7))
				dropdownSearchPadding.PaddingRight = UDim.new(0, px(7))
				dropdownSearchPadding.Parent = dropdownSearch

				local optionButtons = {}
				local optionSearchLabels = {}
				local function filterStandardOptions()
					local query = string.lower(tostring(dropdownSearch.Text or ""))
					local visibleIndex = 0
					for _, option in ipairs(popupOptions) do
						local optionButton = optionButtons[option]
						if optionButton then
							local visible = query == ""
								or string.find(
									optionSearchLabels[option] or "",
									query,
									1,
									true
								) ~= nil
							optionButton.Visible = visible
							if visible then
								optionButton.Position = U2O(
									px(4),
									dropdownSearchHeight + px(3) + visibleIndex * px(25)
								)
								visibleIndex += 1
							end
						end
					end
					popupContentHeight =
						dropdownSearchHeight + px(6) + visibleIndex * px(25)
					popup.CanvasSize = U2O(0, popupContentHeight)
					syncPopupPosition()
				end
				local function refreshOptionVisuals()
					local noneSelected = next(stateEntry.Targets) == nil
					for optionName, optionButton in pairs(optionButtons) do
						local selected = optionName == "Any"
							and isAutoSit
							and noneSelected
							or stateEntry.Targets[optionName] == true
						optionButton.BackgroundTransparency = selected and 0 or 1
						optionButton.TextColor3 = selected and MENU_TEXT_SELECTED or MUTED_TEXT_COLOR
					end
				end

				for optionIndex, option in ipairs(popupOptions) do
					local optionButton = New("TextButton")
					optionButton.Name = option
					optionButton.Position = U2O(
						px(4),
						dropdownSearchHeight + px(3) + (optionIndex - 1) * px(25)
					)
					optionButton.Size = U2(1, -px(8), 0, px(23))
					local selected = option == "Any"
						and next(stateEntry.Targets) == nil
						or stateEntry.Targets[option] == true
					optionButton.BackgroundColor3 = FEATURE_OFF_COLOR
					optionButton.BackgroundTransparency = selected and 0 or 1
					optionButton.BorderSizePixel = 0
					optionButton.AutoButtonColor = false
					optionButton.Text = option
					optionSearchLabels[option] = string.lower(tostring(option))
					optionButton.TextColor3 = selected and MENU_TEXT_SELECTED or MUTED_TEXT_COLOR
					optionButton.FontFace = MENU_FONT_FACE
					setResponsiveTextSize(optionButton, 14)
					optionButton.ZIndex = 60001
					optionButton.Parent = popup
					optionButtons[option] = optionButton
					ensureCorner(optionButton, px(5))
					optionButton.MouseButton1Click:Connect(function()
						if option == "Any" and isAutoSit then
							for targetName in pairs(stateEntry.Targets) do
								stateEntry.Targets[targetName] = nil
							end
							for _, control in pairs(controlsByOption) do
								control.Frame.Visible = false
							end
							updateDropdownText(dropdownButton, stateEntry, "Any", definition.Options)
							refreshOptionVisuals()
							closeActivePanelDropdown()
							relayoutRows()
							return
						end

						local nowSelected = stateEntry.Targets[option] ~= true
						if nowSelected
							and not isAutoSit
							and not isAutoCancel
							and not isDropdownOnly
							and option ~= "Tokens"
							and brainrotAmountTotal(stateEntry) >= 6
						then
							return
						end
						stateEntry.Targets[option] = nowSelected or nil
						if nowSelected and not isDropdownOnly then
							if option == "Tokens" then
								stateEntry.Tokens = math.clamp(math.floor(tonumber(stateEntry.Tokens) or 1), 1, 100000)
							else
								local upper = (isAutoSit or isAutoCancel) and 100 or 6
								stateEntry.Amounts[option] = math.clamp(
									math.floor(tonumber(stateEntry.Amounts[option]) or 1),
									1,
									upper
								)
							end
						end
						refreshOptionVisuals()
						if isAutoCancel and secondaryLabel then
							secondaryLabel.TextColor3 = next(stateEntry.Targets) ~= nil
								and MENU_TEXT_SELECTED
								or MUTED_TEXT_COLOR
						end
						updateDropdownText(
							dropdownButton,
							stateEntry,
							isAutoSit and "Any" or definition.Placeholder,
							definition.Options
						)
						local control = controlsByOption[option]
						if control then
							control.Frame.Visible = featureEnabled and nowSelected
							if nowSelected then
								control.SetAmount(
									option == "Tokens" and stateEntry.Tokens or stateEntry.Amounts[option],
									true
								)
							end
						end
						relayoutRows()
					end)
				end
				dropdownSearch:GetPropertyChangedSignal("Text"):Connect(filterStandardOptions)
				filterStandardOptions()
				task.defer(function()
					if dropdownSearch.Parent then
						pcall(dropdownSearch.CaptureFocus, dropdownSearch)
					end
				end)
			end)
		end


		if (isServerHop or isUtilitySlider)
			and stateEntry
			and (definition.SliderKey or definition.ServerHopSliderKey or definition.UtilitySliderKey)
		then
			local resolvedSliderKey = definition.SliderKey
				or definition.ServerHopSliderKey
				or definition.UtilitySliderKey
			amountContainer = New("Frame")
			amountContainer.Name = isUtilitySlider and "UtilitySlider" or "ServerHopSlider"
			local amountNestedIndent = 0
			amountContainer.Position = U2O(amountNestedIndent, featureRowHeight)
			amountContainer.Size = U2(1, -amountNestedIndent, 0, amountControlsHeight)
			amountContainer.BackgroundTransparency = 1
			amountContainer.Visible = featureEnabled
			amountContainer.ZIndex = 45013
			amountContainer.Parent = featureRow

			local sliderFrame = New("Frame")
			sliderFrame.Name = "Slider"
			sliderFrame.Size = U2(1, 0, 0, amountControlsHeight)
			sliderFrame.BackgroundTransparency = 1
			sliderFrame.Visible = featureEnabled
			sliderFrame.ZIndex = 45013
			sliderFrame.Parent = amountContainer

			local valueBox = New("TextBox")
			valueBox.Name = "Minutes"
			valueBox.AnchorPoint = V2(1, 0)
			valueBox.Position = U2(1, 0, 0, 0)
			valueBox.Size = U2O(amountValueWidth, px(20))
			valueBox.BackgroundColor3 = FEATURE_OFF_COLOR
			valueBox.BorderSizePixel = 0
			valueBox.ClearTextOnFocus = false
			valueBox.ClipsDescendants = true
			valueBox.TextWrapped = false
			valueBox.TextTruncate = Enum.TextTruncate.AtEnd
			valueBox.TextColor3 = MENU_TEXT_SELECTED
			valueBox.FontFace = MENU_FONT_FACE
			setResponsiveTextSize(valueBox, 14)
			valueBox.ZIndex = 45014
			valueBox.Parent = sliderFrame
			ensureCorner(valueBox, px(5))
			rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(valueBox)

			local unitLabel = New("TextLabel")
			unitLabel.BackgroundTransparency = 1
			unitLabel.Size = U2(1, -amountValueWidth - componentLabelGap, 0, px(15))
			unitLabel.Text = definition.UnitLabel
				or (isServerHop and "Minutes" or "")
			unitLabel.TextColor3 = MUTED_TEXT_COLOR
			unitLabel.FontFace = MENU_FONT_FACE
			setResponsiveTextSize(unitLabel, 14)
			unitLabel.TextXAlignment = Enum.TextXAlignment.Left
			unitLabel.ZIndex = 45014
			unitLabel.Parent = sliderFrame

			local sliderTrack = New("Frame")
			sliderTrack.Name = "SliderTrack"
			sliderTrack.Position = U2O(0, px(27))
			sliderTrack.Size = U2(1, 0, 0, px(5))
			sliderTrack.BackgroundColor3 = FEATURE_OFF_COLOR
			sliderTrack.BorderSizePixel = 0
			sliderTrack.Active = true
			sliderTrack.ZIndex = 45014
			sliderTrack.Parent = sliderFrame
			ensureCorner(sliderTrack, px(3))
			rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(sliderTrack)

			local sliderFill = New("Frame")
			sliderFill.BackgroundColor3 = PINK
			sliderFill.BorderSizePixel = 0
			sliderFill.ZIndex = 45015
			sliderFill.Parent = sliderTrack
			ensureCorner(sliderFill, px(3))

			local sliderKnob = New("Frame")
			sliderKnob.AnchorPoint = V2(0.5, 0.5)
			sliderKnob.Size = U2O(px(11), px(11))
			sliderKnob.BackgroundColor3 = MENU_TEXT_SELECTED
			sliderKnob.BorderSizePixel = 0
			sliderKnob.ZIndex = 45016
			sliderKnob.Parent = sliderTrack
			ensureCorner(sliderKnob, px(6))

			local minValue = definition.MinValue or 1
			local maxValue = definition.MaxValue or 60
			local stepValue = tonumber(definition.Step) or 1
			local decimals = math.max(0, math.floor(tonumber(definition.Decimals) or 0))
			local function normalizeSliderValue(value)
				value = math.clamp(tonumber(value) or minValue, minValue, maxValue)
				if stepValue > 0 then
					value = minValue + math.floor(((value - minValue) / stepValue) + 0.5) * stepValue
				end
				return math.clamp(value, minValue, maxValue)
			end
			local function sliderValueText(value)
				if decimals <= 0 then return tostring(math.floor(value + 0.5)) end
				local formatted = string.format("%." .. tostring(decimals) .. "f", value)
				formatted = string.gsub(formatted, "0+$", "")
				formatted = string.gsub(formatted, "%.$", "")
				return formatted
			end
			local function setValue(value, updateText)
				value = normalizeSliderValue(value)
				stateEntry[resolvedSliderKey] = value
				if updateText then valueBox.Text = sliderValueText(value) end

				local sliderTextColor = value > 0
					and MENU_TEXT_SELECTED
					or MUTED_TEXT_COLOR
				featureLabel.TextColor3 = sliderTextColor
				unitLabel.TextColor3 = MUTED_TEXT_COLOR
				valueBox.TextColor3 = sliderTextColor

				local alpha = maxValue == minValue and 0 or ((value - minValue) / (maxValue - minValue))
				sliderFill.Size = U2S(alpha, 1)
				sliderKnob.Position = U2(alpha, 0, 0.5, 0)
			end
			setValue(stateEntry[resolvedSliderKey], true)
			valueBox.FocusLost:Connect(function()
				setValue(valueBox.Text, true)
			end)

			local function updateSlider(pointX)
				local width = math.max(1, sliderTrack.AbsoluteSize.X)
				local alpha = math.clamp((pointX - sliderTrack.AbsolutePosition.X) / width, 0, 1)
				setValue(minValue + alpha * (maxValue - minValue), true)
			end
			sliderTrack.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch
				then
					beginSliderDrag(input, updateSlider)
				end
			end)

			amountControls[#amountControls + 1] = {
				Frame = sliderFrame,
				Option = resolvedSliderKey,
				SetAmount = setValue,
				ValueBox = valueBox,
			}
		end

		if isAutoAccept and stateEntry then
			local acceptKey = definition.AcceptKey
			local isToken = acceptKey == "Tokens"
			local maxAmount = isToken and 100000 or 6

			amountContainer = New("Frame")
			amountContainer.Name = "AmountControls"
			local amountNestedIndent = 0
			amountContainer.Position = U2O(amountNestedIndent, featureRowHeight)
			amountContainer.Size = U2(1, -amountNestedIndent, 0, featureEnabled and amountControlsHeight or 0)
			amountContainer.BackgroundTransparency = 1
			amountContainer.BorderSizePixel = 0
			amountContainer.ZIndex = 45013
			amountContainer.Parent = featureRow

			local amountFrame = New("Frame")
			amountFrame.Name = acceptKey .. "AmountControl"
			amountFrame.Size = U2(1, 0, 0, amountControlsHeight)
			amountFrame.BackgroundTransparency = 1
			amountFrame.BorderSizePixel = 0
			amountFrame.Visible = featureEnabled
			amountFrame.ZIndex = 45013
			amountFrame.Parent = amountContainer

			local amountLabel = New("TextLabel")
			amountLabel.Name = "AmountLabel"
			amountLabel.Position = U2O(0, 0)
			amountLabel.Size = U2(1, -amountValueWidth - px(10), 0, px(15))
			amountLabel.BackgroundTransparency = 1
			amountLabel.BorderSizePixel = 0
			amountLabel.Text = isToken and "Token Amount" or (acceptKey .. " Amount")
			amountLabel.TextColor3 = featureEnabled and MENU_TEXT_SELECTED or MUTED_TEXT_COLOR
			amountLabel.FontFace = MENU_FONT_FACE
			setResponsiveTextSize(amountLabel, 14)
			amountLabel.TextXAlignment = Enum.TextXAlignment.Left
			amountLabel.ZIndex = 45014
			amountLabel.Parent = amountFrame

			local amountValue = New("TextBox")
			amountValue.Name = "AmountValue"
			amountValue.AnchorPoint = V2(1, 0)
			amountValue.Position = U2(1, 0, 0, 0)
			amountValue.Size = U2O(amountValueWidth, px(20))
			amountValue.BackgroundColor3 = FEATURE_OFF_COLOR
			amountValue.BorderSizePixel = 0
			amountValue.ClearTextOnFocus = false
			amountValue.ClipsDescendants = true
			amountValue.TextWrapped = false
			amountValue.TextTruncate = Enum.TextTruncate.AtEnd
			amountValue.TextColor3 = MENU_TEXT_SELECTED
			amountValue.FontFace = MENU_FONT_FACE
			setResponsiveTextSize(amountValue, 14)
			amountValue.ZIndex = 45014
			amountValue.Parent = amountFrame
			ensureCorner(amountValue, px(5))
			rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(amountValue)

			local sliderTrack = New("Frame")
			sliderTrack.Name = "SliderTrack"
			sliderTrack.Position = U2O(0, px(27))
			sliderTrack.Size = U2(1, 0, 0, px(5))
			sliderTrack.BackgroundColor3 = FEATURE_OFF_COLOR
			sliderTrack.BorderSizePixel = 0
			sliderTrack.Active = true
			sliderTrack.ZIndex = 45014
			sliderTrack.Parent = amountFrame
			ensureCorner(sliderTrack, px(3))
			rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(sliderTrack)

			local sliderFill = New("Frame")
			sliderFill.Name = "Fill"
			sliderFill.BackgroundColor3 = PINK
			sliderFill.BorderSizePixel = 0
			sliderFill.ZIndex = 45015
			sliderFill.Parent = sliderTrack
			ensureCorner(sliderFill, px(3))

			local sliderKnob = New("Frame")
			sliderKnob.Name = "Knob"
			sliderKnob.AnchorPoint = V2(0.5, 0.5)
			sliderKnob.Size = U2O(px(11), px(11))
			sliderKnob.BackgroundColor3 = MENU_TEXT_SELECTED
			sliderKnob.BorderSizePixel = 0
			sliderKnob.ZIndex = 45016
			sliderKnob.Parent = sliderTrack
			ensureCorner(sliderKnob, px(6))



			local amountDropdown = nil

			local function setAcceptAmount(value, updateText)
				value = math.clamp(math.floor(tonumber(value) or 1), 1, maxAmount)
				stateEntry.Amount = value
				if updateText then amountValue.Text = tostring(value) end
				if amountDropdown then amountDropdown.Text = tostring(value) end

				local sliderTextColor = value > 0
					and MENU_TEXT_SELECTED
					or MUTED_TEXT_COLOR
				amountLabel.TextColor3 = sliderTextColor
				amountValue.TextColor3 = sliderTextColor

				local alpha = maxAmount == 1 and 0 or ((value - 1) / (maxAmount - 1))
				sliderFill.Size = U2S(alpha, 1)
				sliderKnob.Position = U2(alpha, 0, 0.5, 0)
			end

			setAcceptAmount(stateEntry.Amount, true)
			amountValue.FocusLost:Connect(function()
				setAcceptAmount(amountValue.Text, true)
			end)

			local function updateSlider(pointX)
				local width = math.max(1, sliderTrack.AbsoluteSize.X)
				local alpha = math.clamp((pointX - sliderTrack.AbsolutePosition.X) / width, 0, 1)
				setAcceptAmount(1 + math.floor(alpha * (maxAmount - 1) + 0.5), true)
			end
			sliderTrack.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch
				then
					beginSliderDrag(input, updateSlider)
				end
			end)

			amountControls[#amountControls + 1] = {
				Frame = amountFrame,
				Option = acceptKey,
				SetAmount = setAcceptAmount,
				ValueBox = amountValue,
			}
		end

		toggleTrack.MouseButton1Click:Connect(function()
			if isDropdownOnly
				or isServerHopSliderOnly
				or isUtilityText
				or isUtilitySlider
				or isUtilityDropdown
				or isUtilityMultiDropdown
			then
				return
			end

			if definition and definition.MomentaryAction then
				if definition.MomentaryAction == "ManualServerHop" then
					autoServerHopState.RuntimeManualServerHopRequested = true
					autoServerHopState.RuntimeServerHopPending = true
				elseif definition.MomentaryAction == "ManualKickMinigame" then
					pcall(function()
						local RS = game:GetService("ReplicatedStorage")
						local Replicator = require(
							RS:WaitForChild("Client")
								:WaitForChild("Modules")
								:WaitForChild("ReplicatorClient")
						)
						local active = Replicator.get("ActiveMinigame")
						local phase = active and active:TryIndex({"phase"})
						local gameId = active and active:TryIndex({"session", "gameId"})
						if phase ~= nil or gameId ~= nil then
							game:GetService("Players").LocalPlayer:Kick("Manual Minigame Kick")
						end
					end)
				end
				featureEnabled = false
				if stateEntry and definition.UtilityToggleKey then
					stateEntry[definition.UtilityToggleKey] = false
				end
				setToggleVisual(toggleTrack, toggleKnob, featureLabel, false)
				return
			end
			if isUtilityToggle and stateEntry then
				featureEnabled = stateEntry[definition.UtilityToggleKey] ~= true
			else
				featureEnabled = not featureEnabled
			end
			if isUtilityToggle then
				if stateEntry then
					if definition.UtilityToggleKey == "PauseScript" and featureEnabled then


						autoServerHopState.RuntimeServerHopPending = false
						autoServerHopState.RuntimeScriptUserHopRequested = false
					end
					if utilityExclusiveGroup then


						local desiredSelected =
							utilityExclusiveRequired
								and true
								or stateEntry[definition.UtilityToggleKey] ~= true
						featureEnabled = desiredSelected
						for _, rowData in ipairs(featureRows) do
							if rowData.UtilityExclusiveGroup == utilityExclusiveGroup
								and rowData.UtilityToggleKey
							then
								local selected = desiredSelected
									and rowData.UtilityToggleKey
										== definition.UtilityToggleKey
								stateEntry[rowData.UtilityToggleKey] = selected
								setToggleVisual(
									rowData.ToggleTrack,
									rowData.ToggleKnob,
									rowData.FeatureLabel,
									selected
								)
							end
						end
					else
						stateEntry[definition.UtilityToggleKey] = featureEnabled
					end
					if utilityExclusiveGroup then
						if activePanelDropdown then closeActivePanelDropdown() end
						refreshUtilityChildVisibility()
					end
				end

				if not utilityExclusiveGroup then
					local registry = autoServerHopState.RuntimeUtilityToggleRows
					local mirroredRows = type(registry) == "table"
						and registry[definition.UtilityToggleKey] or nil
					if type(mirroredRows) == "table" then
						for _, rowData in ipairs(mirroredRows) do
							setToggleVisual(
								rowData.ToggleTrack,
								rowData.ToggleKnob,
								rowData.FeatureLabel,
								stateEntry[definition.UtilityToggleKey] == true
							)
						end
					end
					if activePanelDropdown then closeActivePanelDropdown() end
					refreshUtilityChildVisibility()
				end
				relayoutRows()

				if definition.UtilityToggleKey == "UndoAllSettings" and featureEnabled then
					task.defer(function()
						local reset = rawget(_G, "__TUFFHUB_RESET_ALL_SETTINGS_STATE")
						if type(reset) == "function" then pcall(reset) end
						local refresh = rawget(_G, "__TUFFHUB_REFRESH_ALL_SETTINGS_UI")
						if type(refresh) == "function" then pcall(refresh) end
					end)
				end
			elseif isServerHop then
				if stateEntry then stateEntry[definition.ServerHopKey] = featureEnabled end
				if isServerHopMaster then
					if activePanelDropdown then closeActivePanelDropdown() end
					for _, rowData in ipairs(featureRows) do
						if rowData.ServerHopChild then
							rowData.Row.Visible = featureEnabled
							if rowData.ServerHopSliderOnly and rowData.AmountContainer then
								rowData.AmountContainer.Visible = featureEnabled
								for _, control in ipairs(rowData.AmountControls or {}) do
									control.Frame.Visible = featureEnabled
								end
							end
						end
					end
					relayoutRows()
				end
			elseif isAutoCancel then
				if stateEntry then stateEntry.Enabled = featureEnabled end
			elseif hasDropdown or isAutoAccept or isAutoSit then
				if stateEntry then stateEntry.Enabled = featureEnabled end
			elseif definition and minigameAutoplayState then
				minigameAutoplayState[definition.Id] = featureEnabled
				if activePanelDropdown then closeActivePanelDropdown() end
				refreshUtilityChildVisibility()
				relayoutRows()
			end
			if hasDropdown and not isDropdownOnly and amountContainer then
				amountContainer.Visible = featureEnabled
				for _, control in ipairs(amountControls) do
					control.Frame.Visible = featureEnabled
						and (
							(isOfferSubrow and control.Option == "Tokens")
							or (
								stateEntry
								and stateEntry.Targets
								and stateEntry.Targets[control.Option] == true
							)
						)
						or false
					if control.Frame.Visible and control.SetAmount then
						control.SetAmount(
							control.Option == "Tokens"
								and stateEntry.Tokens
								or stateEntry.Amounts[control.Option],
							true
						)
					end
				end
				relayoutRows()
			end
			if isAutoAccept and amountControls[1] then
				amountControls[1].Frame.Visible = featureEnabled
				relayoutRows()
			end
			if isServerHop and definition.SliderKey and amountControls[1] then
				amountControls[1].Frame.Visible = featureEnabled
				if amountContainer then amountContainer.Visible = featureEnabled end
				relayoutRows()
			end
			if (isAutoSit or isOfferSubrow or isAutoCancel or isCustomReplyManager)
				and secondaryContainer
			then
				secondaryContainer.Visible = featureEnabled
				if secondaryLabel then
					local secondaryColor = isAutoCancel
						and ((stateEntry and next(stateEntry.Targets) ~= nil) and MENU_TEXT_SELECTED or MUTED_TEXT_COLOR)
						or (featureEnabled and MENU_TEXT_SELECTED or MUTED_TEXT_COLOR)
					TweenService:Create(
						secondaryLabel,
						TI(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = secondaryColor}
					):Play()
				end
				relayoutRows()
			end
			TweenService:Create(toggleTrack, TI(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = featureEnabled and PINK or FEATURE_OFF_COLOR}):Play()
			TweenService:Create(featureLabel, TI(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = featureEnabled and MENU_TEXT_SELECTED or MUTED_TEXT_COLOR}):Play()
			TweenService:Create(toggleKnob, TI(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = featureEnabled and U2(0, toggleWidth - toggleHeight + knobInset, 0, knobInset) or U2O(knobInset, knobInset)
			}):Play()
		end)

		local function refreshFeatureRowFromState()
			if isDropdownOnly then
				featureEnabled = true
			elseif isUtilityToggle then
				featureEnabled = stateEntry and stateEntry[definition.UtilityToggleKey] == true or false
			elseif isUtilityText or isUtilitySlider or isUtilityDropdown or isUtilityMultiDropdown then
				featureEnabled = stateEntry and utilityParentsEnabled(stateEntry, utilityParents) or false
			elseif isAutoCancel then
				featureEnabled = isAutoCancelFilterOnly or (stateEntry and stateEntry.Enabled == true or false)
			elseif isServerHopSliderOnly then
				featureEnabled = autoServerHopState and autoServerHopState.Enabled == true or false
			elseif isServerHop then
				featureEnabled = stateEntry and stateEntry[definition.ServerHopKey] == true or false
			elseif hasDropdown or isAutoAccept or isAutoSit then
				featureEnabled = stateEntry and stateEntry.Enabled == true or false
			else
				featureEnabled = definition and minigameAutoplayState and minigameAutoplayState[definition.Id] == true or false
			end

			local utilityVisible = not isUtilityChild
				or utilityParentsEnabled(autoServerHopState.Utility, utilityParents)
			local visibilityVisible = type(visibilityUtilityParents) ~= "table"
				or utilityParentsEnabled(autoServerHopState.Utility, visibilityUtilityParents)
			featureRow.Visible = (not isServerHopChild or autoServerHopState.Enabled == true)
				and utilityVisible
				and visibilityVisible
				and (
					(definition and definition.MinigameParentId) == nil
					or (
						type(minigameAutoplayState) == "table"
						and minigameAutoplayState[definition.MinigameParentId] == true
					)
				)
				and (
					(definition and definition.BoothSlotIndex) == nil
					or definition.BoothSlotIndex
						<= (tonumber(autoServerHopState.RuntimeBoothMaxSlots) or 3)
				)

			setToggleVisual(toggleTrack, toggleKnob, featureLabel, featureEnabled)
			if secondaryContainer then
				secondaryContainer.Visible = (isDropdownOnly or featureEnabled) and featureRow.Visible
			end
			if amountContainer then amountContainer.Visible = featureEnabled and featureRow.Visible end
			if utilityDropdownRefresh then utilityDropdownRefresh() end
			if utilityTextBox and stateEntry then
				utilityTextBox.Text = tostring(stateEntry[definition.UtilityTextKey] or "")
				utilityTextBox.TextColor3 = utilityTextBox.Text ~= "" and MENU_TEXT_SELECTED or MUTED_TEXT_COLOR
			end
			if standardDropdownButton and stateEntry then
				updateDropdownText(standardDropdownButton, stateEntry, isAutoSit and "Any" or definition.Placeholder, definition.Options)
			end

			if isUtilitySlider or isServerHopSliderOnly or (isServerHop and definition.SliderKey) then
				for _, control in ipairs(amountControls) do
					if control.SetAmount then
						local key = control.Option
						control.SetAmount(stateEntry and stateEntry[key], true)
					end
				end
			elseif isAutoAccept then
				for _, control in ipairs(amountControls) do
					control.Frame.Visible = featureEnabled
					if control.SetAmount then control.SetAmount(stateEntry and stateEntry.Amount, true) end
				end
			elseif hasDropdown and stateEntry then
				for _, control in ipairs(amountControls) do
					local visible = featureEnabled and (
						(isOfferSubrow and control.Option == "Tokens")
						or (stateEntry.Targets and stateEntry.Targets[control.Option] == true)
					) or false
					control.Frame.Visible = visible
					if visible and control.SetAmount then
						control.SetAmount(control.Option == "Tokens" and stateEntry.Tokens or stateEntry.Amounts[control.Option], true)
					end
				end
			end
		end

		local function syncPrimaryRowLayout(baseHeight)
			baseHeight = math.max(0, tonumber(baseHeight) or featureRowHeight)
			local labelHeight = wrappedFeatureLabelHeight()
			featureLabel.Position = U2(
				0,
				childTextIndent,
				0,
				baseHeight * 0.5
			)
			featureLabel.Size = U2(
				featureLabel.Size.X.Scale,
				featureLabel.Size.X.Offset,
				0,
				labelHeight
			)
			toggleTrack.Position = U2(1, 0, 0, baseHeight * 0.5)

			if utilityDropdownButton then
				utilityDropdownButton.Position = U2(
					1,
					0,
					0,
					baseHeight * 0.5
				)
			end

			if standardDropdownButton
				and standardDropdownButton.Parent == featureRow
			then
				standardDropdownButton.Position = U2(
					1,
					-(toggleWidth + px(10)),
					0,
					baseHeight * 0.5
				)
			end

			if secondaryContainer and not isAutoCancelFilterOnly then
				secondaryContainer.Position = U2O(
					secondaryContainer.Position.X.Offset,
					baseHeight
				)
			end
		end

		featureRows[#featureRows + 1] = {
			Row = featureRow,
			IndentLevel = 0,
			BaseHeight = defaultFeatureBaseHeight,
			DynamicBaseHeight = dynamicBaseHeight,
			SyncPrimaryLayout = syncPrimaryRowLayout,
			SecondaryContainer = secondaryContainer,
			SecondaryHeight = isUtilityText
				and px(32)
				or (isAutoCancel and px(58) or secondaryControlHeight),
			DynamicSecondaryHeight = dynamicSecondaryHeight,
			AmountContainer = amountContainer,
			AmountControls = amountControls,
			ServerHopChild = isServerHopChild,
			ServerHopSliderOnly = isServerHopSliderOnly,
			UtilityParentKey = isUtilityChild and definition.UtilityParentKey or nil,
			UtilityParentKeys = isUtilityChild and utilityParents or nil,
			VisibilityUtilityParentKeys = visibilityUtilityParents,
			MinigameParentId = definition and definition.MinigameParentId or nil,
			BoothSlotIndex = definition and definition.BoothSlotIndex or nil,
			UtilityToggleKey = isUtilityToggle and definition.UtilityToggleKey or nil,
			UtilityExclusiveGroup = utilityExclusiveGroup,
			RefreshUtilityDropdown = utilityDropdownRefresh,
			ToggleTrack = toggleTrack,
			ToggleKnob = toggleKnob,
			FeatureLabel = featureLabel,
			RefreshFromState = refreshFeatureRowFromState,
		}
		if isUtilityToggle then
			autoServerHopState.RuntimeUtilityToggleRows = autoServerHopState.RuntimeUtilityToggleRows or {}
			local registry = autoServerHopState.RuntimeUtilityToggleRows
			registry[definition.UtilityToggleKey] = registry[definition.UtilityToggleKey] or {}
			registry[definition.UtilityToggleKey][#registry[definition.UtilityToggleKey] + 1] = featureRows[#featureRows]
		end
	end
	local featureCount = featureDefinitions and #featureDefinitions or 3
	local deferredBoothRows = {}
	for featureIndex = 1, featureCount do
		local definition = featureDefinitions and featureDefinitions[featureIndex] or nil
		if definition
			and definition.BoothSlotIndex
			and definition.BoothSlotIndex
				> (tonumber(autoServerHopState.RuntimeBoothMaxSlots) or 3)
		then
			deferredBoothRows[#deferredBoothRows + 1] = {
				Index = featureIndex,
				Definition = definition,
			}
		else
			createFeatureRow(featureIndex, definition)
		end
	end
	local function ensureBoothSlots(maximum)
		maximum = tonumber(maximum)
			or tonumber(autoServerHopState.RuntimeBoothMaxSlots)
			or 3
		local index = 1
		local created = false
		while index <= #deferredBoothRows do
			local pending = deferredBoothRows[index]
			if pending.Definition.BoothSlotIndex <= maximum then
				createFeatureRow(pending.Index, pending.Definition)
				table.remove(deferredBoothRows, index)
				created = true
			else
				index += 1
			end
		end
		if created then relayoutRows() end
	end
	relayoutRows()
	local searchTerms = panel.Name .. " " .. tostring(panelTitle or TRACKED_FEATURE)
	if featureDefinitions then
		for _, definition in ipairs(featureDefinitions) do
			searchTerms ..= " " .. tostring(definition.Label)
		end
	end
	panelData = {
		Frame = panel,
		Header = header,
		Chevron = chevron,
		Divider = headerDivider,
		Body = body,
		TabItem = tabItem,
		Column = column,
		Order = order,
		PersistenceKey = panelPersistenceKey,
		Expanded = initialPanelExpanded,
		ExpandedHeight = PANEL_HEADER_HEIGHT + LINE_THICKNESS + featureTopPadding + featureBottomPadding
			+ (#featureRows * featureRowHeight) + (math.max(0, #featureRows - 1) * featureRowGap),
		SearchText = string.lower(searchTerms),
		FeatureRows = featureRows,
		RelayoutRows = relayoutRows,
		EnsureBoothSlots = #deferredBoothRows > 0 and ensureBoothSlots or nil,
	}
	body.Visible = initialPanelExpanded
	headerDivider.Visible = initialPanelExpanded
	chevron.Rotation = initialPanelExpanded and 0 or 180
	relayoutRows()
	unsupportedPanelGroups[
		tabItem
	] = unsupportedPanelGroups[
			tabItem
		]
		or {
		}
	table.insert(
		unsupportedPanelGroups[
			tabItem
		],
		panelData
	)
	table.insert(
		allUnsupportedPanels,
		panelData
	)
	header.MouseEnter:Connect(function()
		tweenChevronColor(
			chevron,
			MENU_TEXT_HOVER
		)
	end)
	header.MouseLeave:Connect(function()
		tweenChevronColor(
			chevron,
			PANEL_CHEVRON_COLOR
		)
	end)
end
local function createSixPanelsForTab(
	tabItem
)
	for panelIndex = 1, 6 do
		local column = (
				(panelIndex - 1)
				% 2
			)
			+ 1
		local order = math.ceil(
				panelIndex
					/ 2
			)
		createEmptyCollapsiblePanel(
			tabItem,
			panelIndex,
			column,
			order
		)
	end
end
if IS_MINIGAME_PLACE then
	createEmptyCollapsiblePanel(
		mainItem,
		18,
		1,
		1,
		"Pause Minigames",
		{
			{Label = "Pause All Minigame Features", UtilityToggleKey = "PauseMinigameFeatures"},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		1,
		1,
		1,
		"Auto Play",
		{
			{Label = "Auto Play", UtilityToggleKey = "AutoPlayMaster"},
			{Label = "Connect 4", Id = "ConnectFour", VisibilityUtilityParentKey = "AutoPlayMaster"},
			{Label = "Move Delay", UtilitySliderKey = "MoveDelayConnectFour", MinigameParentId = "ConnectFour", VisibilityUtilityParentKey = "AutoPlayMaster", MinValue = 0, MaxValue = 5, Step = 0.05, Decimals = 2, UnitLabel = "Seconds"},
			{Label = "Popcorn", Id = "PopcornBurst", VisibilityUtilityParentKey = "AutoPlayMaster"},
			{Label = "Football Draft", Id = "FootballDraft", VisibilityUtilityParentKey = "AutoPlayMaster"},
			{Label = "Move Delay", UtilitySliderKey = "MoveDelayFootballDraft", MinigameParentId = "FootballDraft", VisibilityUtilityParentKey = "AutoPlayMaster", MinValue = 0, MaxValue = 5, Step = 0.05, Decimals = 2, UnitLabel = "Seconds"},
			{Label = "Candy Bomb", Id = "CandyBomb", VisibilityUtilityParentKey = "AutoPlayMaster"},
			{Label = "Move Delay", UtilitySliderKey = "MoveDelayCandyBomb", MinigameParentId = "CandyBomb", VisibilityUtilityParentKey = "AutoPlayMaster", MinValue = 0, MaxValue = 5, Step = 0.05, Decimals = 2, UnitLabel = "Seconds"},
			{Label = "Battle Ship", Id = "Battleship", VisibilityUtilityParentKey = "AutoPlayMaster"},
			{Label = "Move Delay", UtilitySliderKey = "MoveDelayBattleship", MinigameParentId = "Battleship", VisibilityUtilityParentKey = "AutoPlayMaster", MinValue = 0, MaxValue = 5, Step = 0.05, Decimals = 2, UnitLabel = "Seconds"},
			{Label = "Higher Or Lower", Id = "NumberGuess", VisibilityUtilityParentKey = "AutoPlayMaster"},
			{Label = "Move Delay", UtilitySliderKey = "MoveDelayNumberGuess", MinigameParentId = "NumberGuess", VisibilityUtilityParentKey = "AutoPlayMaster", MinValue = 0, MaxValue = 5, Step = 0.05, Decimals = 2, UnitLabel = "Seconds"},
			{Label = "Knockout", Id = "Knockout", VisibilityUtilityParentKey = "AutoPlayMaster"},
			{Label = "Move Delay", UtilitySliderKey = "MoveDelayKnockout", MinigameParentId = "Knockout", VisibilityUtilityParentKey = "AutoPlayMaster", MinValue = 0, MaxValue = 5, Step = 0.05, Decimals = 2, UnitLabel = "Seconds"},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		2,
		1,
		2,
		"Auto Offer",
		{
			{Label = "Auto Offer", UtilityToggleKey = "AutoOfferMaster"},
			{Label = "Common", Source = "Common", Options = BRAINROT_RARITY_OPTIONS, OfferSubrow = true, VisibilityUtilityParentKey = "AutoOfferMaster"},
			{Label = "Uncommon", Source = "Uncommon", Options = BRAINROT_RARITY_OPTIONS, OfferSubrow = true, VisibilityUtilityParentKey = "AutoOfferMaster"},
			{Label = "Rare", Source = "Rare", Options = BRAINROT_RARITY_OPTIONS, OfferSubrow = true, VisibilityUtilityParentKey = "AutoOfferMaster"},
			{Label = "Epic", Source = "Epic", Options = BRAINROT_RARITY_OPTIONS, OfferSubrow = true, VisibilityUtilityParentKey = "AutoOfferMaster"},
			{Label = "Legendary", Source = "Legendary", Options = BRAINROT_RARITY_OPTIONS, OfferSubrow = true, VisibilityUtilityParentKey = "AutoOfferMaster"},
			{Label = "Mythical", Source = "Mythical", Options = BRAINROT_RARITY_OPTIONS, OfferSubrow = true, VisibilityUtilityParentKey = "AutoOfferMaster"},
			{Label = "Cosmic", Source = "Cosmic", Options = BRAINROT_RARITY_OPTIONS, OfferSubrow = true, VisibilityUtilityParentKey = "AutoOfferMaster"},
			{Label = "Secret", Source = "Secret", Options = BRAINROT_RARITY_OPTIONS, OfferSubrow = true, VisibilityUtilityParentKey = "AutoOfferMaster"},
			{Label = "Celestial", Source = "Celestial", Options = BRAINROT_RARITY_OPTIONS, OfferSubrow = true, VisibilityUtilityParentKey = "AutoOfferMaster"},
			{Label = "Divine", Source = "Divine", Options = BRAINROT_RARITY_OPTIONS, OfferSubrow = true, VisibilityUtilityParentKey = "AutoOfferMaster"},
			{Label = "Infinity", Source = "Infinity", Options = BRAINROT_RARITY_OPTIONS, OfferSubrow = true, VisibilityUtilityParentKey = "AutoOfferMaster"},
			{Label = "Meta", Source = "Meta", Options = BRAINROT_RARITY_OPTIONS, OfferSubrow = true, VisibilityUtilityParentKey = "AutoOfferMaster"},
			{Label = "Paradox", Source = "Paradox", Options = BRAINROT_RARITY_OPTIONS, OfferSubrow = true, VisibilityUtilityParentKey = "AutoOfferMaster"},
			{Label = "Eternal", Source = "Eternal", Options = BRAINROT_RARITY_OPTIONS, OfferSubrow = true, VisibilityUtilityParentKey = "AutoOfferMaster"},
			{Label = "Tokens", UtilityToggleKey = "AutoOfferTokensEnabled", UtilityParentKey = "AutoOfferMaster"},
			{Label = "Match Tokens With Tokens", UtilityToggleKey = "AutoOfferMatchTokensWithTokens", UtilityParentKeys = {"AutoOfferMaster", "AutoOfferTokensEnabled"}},
			{Label = "Token Add Ratio", UtilitySliderKey = "AutoOfferTokenAddRatio", UtilityParentKeys = {"AutoOfferMaster", "AutoOfferTokensEnabled", "AutoOfferMatchTokensWithTokens"}, MinValue = 1, MaxValue = 10, UnitLabel = "Multiplier"},
			{Label = "Lowest Tokens To Match", UtilitySliderKey = "AutoOfferLowestTokensToMatch", UtilityParentKeys = {"AutoOfferMaster", "AutoOfferTokensEnabled", "AutoOfferMatchTokensWithTokens"}, MinValue = 1, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Match Tokens With Brainrots", UtilityToggleKey = "AutoOfferMatchTokensWithBrainrots", UtilityParentKeys = {"AutoOfferMaster", "AutoOfferTokensEnabled"}},
			{Label = "Token Amount", UtilitySliderKey = "AutoOfferTokenAmount", UtilityParentKeys = {"AutoOfferMaster", "AutoOfferTokensEnabled", "AutoOfferMatchTokensWithBrainrots"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Offer", UtilityDropdownKey = "AutoOfferTokenRarity", UtilityParentKeys = {"AutoOfferMaster", "AutoOfferTokensEnabled", "AutoOfferMatchTokensWithBrainrots"}, Placeholder = "Select", Options = BRAINROT_RARITY_OPTIONS},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		3,
		2,
		2,
		"Auto Sit",
		{
			{Label = "Auto Sit At Empty Tables", SitKey = "EmptyTables"},
			{
				Label = "Auto Sit At 1/2 Tables",
				SitKey = "OneOfTwo",
				Source = "OneOfTwo",
				Options = RARITY_OPTIONS,
				Placeholder = "Any",
			},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		4,
		2,
		1,
		"Auto Accept",
		{
			{Label = "Auto Accept", UtilityToggleKey = "AutoAcceptMaster"},
			{Label = "Common", AcceptKey = "Common", VisibilityUtilityParentKey = "AutoAcceptMaster"},
			{Label = "Uncommon", AcceptKey = "Uncommon", VisibilityUtilityParentKey = "AutoAcceptMaster"},
			{Label = "Rare", AcceptKey = "Rare", VisibilityUtilityParentKey = "AutoAcceptMaster"},
			{Label = "Epic", AcceptKey = "Epic", VisibilityUtilityParentKey = "AutoAcceptMaster"},
			{Label = "Legendary", AcceptKey = "Legendary", VisibilityUtilityParentKey = "AutoAcceptMaster"},
			{Label = "Mythical", AcceptKey = "Mythical", VisibilityUtilityParentKey = "AutoAcceptMaster"},
			{Label = "Cosmic", AcceptKey = "Cosmic", VisibilityUtilityParentKey = "AutoAcceptMaster"},
			{Label = "Secret", AcceptKey = "Secret", VisibilityUtilityParentKey = "AutoAcceptMaster"},
			{Label = "Celestial", AcceptKey = "Celestial", VisibilityUtilityParentKey = "AutoAcceptMaster"},
			{Label = "Divine", AcceptKey = "Divine", VisibilityUtilityParentKey = "AutoAcceptMaster"},
			{Label = "Infinity", AcceptKey = "Infinity", VisibilityUtilityParentKey = "AutoAcceptMaster"},
			{Label = "Meta", AcceptKey = "Meta", VisibilityUtilityParentKey = "AutoAcceptMaster"},
			{Label = "Paradox", AcceptKey = "Paradox", VisibilityUtilityParentKey = "AutoAcceptMaster"},
			{Label = "Eternal", AcceptKey = "Eternal", VisibilityUtilityParentKey = "AutoAcceptMaster"},
			{Label = "Tokens", AcceptKey = "Tokens", VisibilityUtilityParentKey = "AutoAcceptMaster"},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		5,
		1,
		3,
		"Auto Cancel",
		{
			{Label = "Auto Cancel", UtilityToggleKey = "AutoCancelMaster"},
			{
				Label = "Check Opponents Brainrots",
				UtilityToggleKey = "AutoCancelCheckOpponentsBrainrots",
				UtilityParentKey = "AutoCancelMaster",
			},
			{
				Label = "Cancel If Player Does Not Own",
				AutoCancel = true,
				AutoCancelFilterOnly = true,
				Options = RARITY_OPTIONS,
				Placeholder = "Select",
				VisibilityUtilityParentKeys = {
					"AutoCancelMaster",
					"AutoCancelCheckOpponentsBrainrots",
				},
			},
			{
				Label = "Time Before Auto Cancel",
				UtilitySliderKey = "AutoCancelBrainrotConditionDelay",
				UtilityParentKeys = {
					"AutoCancelMaster",
					"AutoCancelCheckOpponentsBrainrots",
				},
				MinValue = 0,
				MaxValue = 30,
				Step = 0.25,
				Decimals = 2,
				UnitLabel = "Seconds",
			},
			{
				Label = "Cancel If Trade Lasts Longer Than",
				UtilityToggleKey = "AutoCancelTradeTimeoutEnabled",
				UtilityParentKey = "AutoCancelMaster",
			},
			{
				Label = "",
				UtilitySliderKey = "AutoCancelTradeTimeout",
				UtilityParentKeys = {
					"AutoCancelMaster",
					"AutoCancelTradeTimeoutEnabled",
				},
				MinValue = 1,
				MaxValue = 60,
				UnitLabel = "Seconds",
			},
			{
				Label = "Cancel If Value Not Offered After",
				UtilityToggleKey = "AutoCancelNoValueTimeoutEnabled",
				UtilityParentKey = "AutoCancelMaster",
			},
			{
				Label = "",
				UtilitySliderKey = "AutoCancelNoValueTimeout",
				UtilityParentKeys = {
					"AutoCancelMaster",
					"AutoCancelNoValueTimeoutEnabled",
				},
				MinValue = 1,
				MaxValue = 30,
				UnitLabel = "Seconds",
			},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		6,
		2,
		3,
		"Auto Server Hop",
		{
			{Label = "Auto Server Hop", ServerHopKey = "Enabled"},
			{
				Label = "Time In Server",
				ServerHopKey = "ServerTimeEnabled",
				SliderKey = "ServerTime",
				MinValue = 1,
				MaxValue = 60,
			},
			{
				Label = "Time Since Last Game",
				ServerHopKey = "TimeSinceLastGameEnabled",
				SliderKey = "TimeSinceLastGame",
				MinValue = 1,
				MaxValue = 60,
			},
			{Label = "Time Added After Winning Wager", ServerHopSliderKey = "WinWagerTimeAdded", MinValue = 0, MaxValue = 60, UnitLabel = "Minutes"},
			{Label = "Time Added After Booth Purchase", ServerHopSliderKey = "BoothPurchaseTimeAdded", MinValue = 1, MaxValue = 60, UnitLabel = "Minutes"},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		20,
		2,
		4,
		"Check Server",
		{
			{Label = "Server Hop If Nobody In Server Has These Brainrots", UtilityToggleKey = "CheckServerHopNobodyServer"},
			{Label = "Server Hop If You Played Everyone In Server With These Brainrots", UtilityToggleKey = "CheckServerHopPlayedEveryoneServer"},
			{Label = "Server Hop If Nobody In Minigames Area Has These Brainrots", UtilityToggleKey = "CheckServerHopNobodyMinigamesArea"},
			{Label = "Server Hop If You Played Everyone In Minigames Area With These Brainrots", UtilityToggleKey = "CheckServerHopPlayedEveryoneMinigamesArea"},
			{
				Label = "Brainrots To Check For",
				UtilityMultiDropdownKey = "CheckServerBrainrotRarities",
				Placeholder = "Select",
				Options = BRAINROT_RARITY_OPTIONS,
			},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		7,
		1,
		4,
		"Auto Chat",
		{
			{Label = "Auto Chat", UtilityToggleKey = "AutoChat"},
			{
				Label = "Message",
				UtilityTextKey = "AutoChatMessage",
				UtilityParentKey = "AutoChat",
				Placeholder = "Type your chat message...",
			},
			{
				Label = "Chat Interval",
				UtilitySliderKey = "ChatIntervalMinutes",
				UtilityParentKey = "AutoChat",
				MinValue = 1,
				MaxValue = 5,
				Step = 1,
				UnitLabel = "Minutes",
			},
			{
				Label = "Do Not Send During Active Trade Feature",
				UtilityToggleKey = "AutoChatDoNotSendDuringActiveTrade",
				UtilityParentKey = "AutoChat",
			},
			{
				Label = "Wait This Long After Execution",
				UtilitySliderKey = "AutoChatExecutionDelay",
				UtilityParentKey = "AutoChat",
				MinValue = 0,
				MaxValue = 60,
				Step = 0.5,
				Decimals = 1,
				UnitLabel = "Seconds",
			},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		8,
		2,
		4,
		"Auto Trade Message",
		{
			{Label = "Auto Trade Chat", UtilityToggleKey = "AutoTradeChat"},
			{
				Label = "Message",
				UtilityTextKey = "AutoTradeMessage",
				UtilityParentKey = "AutoTradeChat",
				Placeholder = "Type your trade message...",
			},
			{
				Label = "Send This Long After Trade Starts",
				UtilitySliderKey = "AutoTradeMessageStartDelay",
				UtilityParentKey = "AutoTradeChat",
				MinValue = 0,
				MaxValue = 10,
				Step = 0.125,
				Decimals = 3,
				UnitLabel = "Seconds",
			},
			{
				Label = "Send Message Every Fixed Amount Of Time",
				UtilityToggleKey = "AutoTradeRepeatMessage",
				UtilityParentKey = "AutoTradeChat",
			},
			{
				Label = "Send Every",
				UtilitySliderKey = "AutoTradeRepeatInterval",
				UtilityParentKeys = {"AutoTradeChat", "AutoTradeRepeatMessage"},
				MinValue = 1,
				MaxValue = 60,
				Step = 1,
				UnitLabel = "Seconds",
			},
			{
				Label = "Send Message If Value Not Offered",
				UtilityToggleKey = "AutoTradeSendIfValueNotOffered",
				UtilityParentKey = "AutoTradeChat",
			},
			{
				Label = "Message To Send",
				UtilityTextKey = "AutoTradeNoValueMessage",
				UtilityParentKeys = {"AutoTradeChat", "AutoTradeSendIfValueNotOffered"},
				Placeholder = "Message to send if value is not offered...",
				EditingKey = "AutoTradeNoValueMessageEditing",
				RevisionKey = "AutoTradeNoValueMessageRevision",
			},
			{
				Label = "Time Before Send",
				UtilitySliderKey = "AutoTradeNoValueDelay",
				UtilityParentKeys = {"AutoTradeChat", "AutoTradeSendIfValueNotOffered"},
				MinValue = 0,
				MaxValue = 60,
				Step = 0.5,
				Decimals = 1,
				UnitLabel = "Seconds",
			},
			{
				Label = "Add Custom Message",
				UtilityToggleKey = "AutoTradeCustomRepliesEnabled",
				UtilityParentKey = "AutoTradeChat",
				CustomReplyManager = true,
				CustomReplyTableKey = "AutoTradeCustomReplies",
			},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		9,
		2,
		5,
		"Auto Delete Inventory",
		{
			{
				Label = "Auto Delete Worst Inventory",
				UtilityToggleKey = "AutoDeleteWorstInventory",
			},
			{
				Label = "Delete Non Brainrots First",
				UtilityToggleKey = "DeleteNonBrainrotsFirst",
				UtilityParentKey = "AutoDeleteWorstInventory",
				UtilityExclusiveGroup = "DeletePriority",
			},
			{
				Label = "Delete Worst Brainrots First",
				UtilityToggleKey = "DeleteWorstBrainrotsFirst",
				UtilityParentKey = "AutoDeleteWorstInventory",
				UtilityExclusiveGroup = "DeletePriority",
			},
			{
				Label = "At This Inventory Or Higher",
				UtilitySliderKey = "DeleteInventoryThreshold",
				UtilityParentKey = "AutoDeleteWorstInventory",
				MinValue = 1,
				MaxValue = 100,
				UnitLabel = "Inventory",
			},
			{
				Label = "Never Delete",
				UtilityToggleKey = "NeverDeleteEnabled",
				UtilityParentKey = "AutoDeleteWorstInventory",
			},
			{
				Label = "Brainrots / Items",
				UtilityMultiDropdownKey = "NeverDeleteItems",
				UtilityParentKeys = {"AutoDeleteWorstInventory", "NeverDeleteEnabled"},
				Placeholder = "Select",
				OptionsProvider = function()
					return autoServerHopState.AllDeletableItemOptions()
				end,
			},
		}
	)

	createEmptyCollapsiblePanel(
		mainItem,
		10,
		1,
		6,
		"Auto Equip",
		{
			{Label = "Auto Equip", UtilityToggleKey = "AutoEquipBestBrainrot"},
			{
				Label = "Best Brainrot",
				UtilityToggleKey = "EquipBestBrainrot",
				UtilityParentKey = "AutoEquipBestBrainrot",
				UtilityExclusiveGroup = "EquipPriority",
			},
			{
				Label = "Best Mountable Brainrot",
				UtilityToggleKey = "EquipBestMountableBrainrot",
				UtilityParentKey = "AutoEquipBestBrainrot",
				UtilityExclusiveGroup = "EquipPriority",
			},
			{
				Label = "Specific Brainrot",
				UtilityToggleKey = "EquipSpecificBrainrot",
				UtilityParentKey = "AutoEquipBestBrainrot",
			},
			{
				Label = "Brainrot",
				UtilityDropdownKey = "SpecificBrainrotId",
				UtilityParentKeys = {"AutoEquipBestBrainrot", "EquipSpecificBrainrot"},
				Placeholder = "None",
				OptionsProvider = function()
					return autoServerHopState.RefreshOwnedBrainrotOptions()
				end,
				OptionLabelProvider = function(id)
					return autoServerHopState.OwnedBrainrotOptionLabel(id)
				end,
				ClearIfMissing = true,
			},
			{
				Label = "Mount Brainrot If Possible",
				UtilityToggleKey = "MountBrainrotIfPossible",
				UtilityParentKey = "AutoEquipBestBrainrot",
			},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		11,
		2,
		6,
		"Auto Opening Offer",
		{
			{Label = "Autoshow Best Brainrots", UtilityToggleKey = "AutoshowBestBrainrots"},
			{Label = "Autoshow All Tokens", UtilityToggleKey = "AutoshowAllTokens"},
			{Label = "Custom Opening Offer", UtilityToggleKey = "CustomOpeningOffer"},
			{
				Label = "Brainrot 1",
				UtilityDropdownKey = "OpeningOfferBrainrot1",
				UtilityParentKey = "CustomOpeningOffer",
				Placeholder = "None",
				OptionsProvider = function() return autoServerHopState.RefreshOwnedBrainrotOptions() end,
				OptionLabelProvider = function(id) return autoServerHopState.OwnedBrainrotOptionLabel(id) end,
				ClearIfMissing = true,
			},
			{
				Label = "Brainrot 2",
				UtilityDropdownKey = "OpeningOfferBrainrot2",
				UtilityParentKey = "CustomOpeningOffer",
				Placeholder = "None",
				OptionsProvider = function() return autoServerHopState.RefreshOwnedBrainrotOptions() end,
				OptionLabelProvider = function(id) return autoServerHopState.OwnedBrainrotOptionLabel(id) end,
				ClearIfMissing = true,
			},
			{
				Label = "Brainrot 3",
				UtilityDropdownKey = "OpeningOfferBrainrot3",
				UtilityParentKey = "CustomOpeningOffer",
				Placeholder = "None",
				OptionsProvider = function() return autoServerHopState.RefreshOwnedBrainrotOptions() end,
				OptionLabelProvider = function(id) return autoServerHopState.OwnedBrainrotOptionLabel(id) end,
				ClearIfMissing = true,
			},
			{
				Label = "Brainrot 4",
				UtilityDropdownKey = "OpeningOfferBrainrot4",
				UtilityParentKey = "CustomOpeningOffer",
				Placeholder = "None",
				OptionsProvider = function() return autoServerHopState.RefreshOwnedBrainrotOptions() end,
				OptionLabelProvider = function(id) return autoServerHopState.OwnedBrainrotOptionLabel(id) end,
				ClearIfMissing = true,
			},
			{
				Label = "Brainrot 5",
				UtilityDropdownKey = "OpeningOfferBrainrot5",
				UtilityParentKey = "CustomOpeningOffer",
				Placeholder = "None",
				OptionsProvider = function() return autoServerHopState.RefreshOwnedBrainrotOptions() end,
				OptionLabelProvider = function(id) return autoServerHopState.OwnedBrainrotOptionLabel(id) end,
				ClearIfMissing = true,
			},
			{
				Label = "Brainrot 6",
				UtilityDropdownKey = "OpeningOfferBrainrot6",
				UtilityParentKey = "CustomOpeningOffer",
				Placeholder = "None",
				OptionsProvider = function() return autoServerHopState.RefreshOwnedBrainrotOptions() end,
				OptionLabelProvider = function(id) return autoServerHopState.OwnedBrainrotOptionLabel(id) end,
				ClearIfMissing = true,
			},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		12,
		1,
		7,
		"Offer Delay Adjustment",
		{
			{Label = "Custom Delays", UtilityToggleKey = "CustomDelays"},
			{Label = "Initial Join Delay", UtilitySliderKey = "InitialJoinDelay", UtilityParentKey = "CustomDelays", MinValue = 0, MaxValue = 5, Step = 0.0005, Decimals = 4, UnitLabel = "Seconds"},
			{Label = "Delay After Trade Message", UtilitySliderKey = "DelayAfterTradeMessage", UtilityParentKey = "CustomDelays", MinValue = 0, MaxValue = 5, Step = 0.0005, Decimals = 4, UnitLabel = "Seconds"},
			{Label = "Reaction Delay", UtilitySliderKey = "ReactionDelay", UtilityParentKey = "CustomDelays", MinValue = 0, MaxValue = 5, Step = 0.0005, Decimals = 4, UnitLabel = "Seconds"},
			{Label = "Add Brainrot Delay", UtilitySliderKey = "AddBrainrotDelay", UtilityParentKey = "CustomDelays", MinValue = 0, MaxValue = 5, Step = 0.0005, Decimals = 4, UnitLabel = "Seconds"},
			{Label = "Remove Brainrot Delay", UtilitySliderKey = "RemoveBrainrotDelay", UtilityParentKey = "CustomDelays", MinValue = 0, MaxValue = 5, Step = 0.0005, Decimals = 4, UnitLabel = "Seconds"},
			{Label = "Add Token Delay", UtilitySliderKey = "AddTokenDelay", UtilityParentKey = "CustomDelays", MinValue = 0, MaxValue = 5, Step = 0.0005, Decimals = 4, UnitLabel = "Seconds"},
			{Label = "Remove Token Delay", UtilitySliderKey = "RemoveTokenDelay", UtilityParentKey = "CustomDelays", MinValue = 0, MaxValue = 5, Step = 0.0005, Decimals = 4, UnitLabel = "Seconds"},
			{Label = "Accept Offer Delay", UtilitySliderKey = "AcceptOfferDelay", UtilityParentKey = "CustomDelays", MinValue = 0, MaxValue = 5, Step = 0.0005, Decimals = 4, UnitLabel = "Seconds"},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		13,
		2,
		7,
		"Auto Choose",
		{
			{Label = "Auto Choose Game", UtilityToggleKey = "AutoChooseGame"},
			{
				Label = "Game To Choose",
				UtilityDropdownKey = "GameToChoose",
				UtilityParentKey = "AutoChooseGame",
				ClearsUtilityMultiDropdownKey = "FallbackGameChoices",
				Options = {"Candy Bomb", "Popcorn Burst", "Higher Or Lower", "Connect 4", "Battle Ship", "Knockout", "Football Draft"},
			},
			{
				Label = "Round 1 Time Before Choice",
				UtilitySliderKey = "AutoChooseRound1Delay",
				UtilityParentKey = "AutoChooseGame",
				MinValue = 0, MaxValue = 10, Step = 0.1, Decimals = 1, UnitLabel = "Seconds",
			},
			{
				Label = "Round 2 Time Before Choice",
				UtilitySliderKey = "AutoChooseRound2Delay",
				UtilityParentKey = "AutoChooseGame",
				MinValue = 0, MaxValue = 10, Step = 0.1, Decimals = 1, UnitLabel = "Seconds",
			},
			{
				Label = "Round 3 Time Before Choice",
				UtilitySliderKey = "AutoChooseRound3Delay",
				UtilityParentKey = "AutoChooseGame",
				MinValue = 0, MaxValue = 10, Step = 0.1, Decimals = 1, UnitLabel = "Seconds",
			},
			{
				Label = "Match Opponent",
				UtilityToggleKey = "MatchOpponentGame",
				UtilityParentKey = "AutoChooseGame",
			},
			{
				Label = "Choices To Match",
				UtilityMultiDropdownKey = "FallbackGameChoices",
				UtilityParentKeys = {"AutoChooseGame", "MatchOpponentGame"},
				ExcludeUtilityDropdownKey = "GameToChoose",
				Options = {"Candy Bomb", "Popcorn Burst", "Higher Or Lower", "Connect 4", "Battle Ship", "Knockout", "Football Draft"},
			},
			{Label = "Auto Choose Rounds", UtilityToggleKey = "AutoChooseRounds"},
			{
				Label = "Rounds To Choose",
				UtilityDropdownKey = "RoundsToChoose",
				UtilityParentKey = "AutoChooseRounds",
				ClearsUtilityMultiDropdownKey = "FallbackRoundChoices",
				Options = {"1", "3", "5"},
			},
			{
				Label = "Match Opponent",
				UtilityToggleKey = "MatchOpponentRounds",
				UtilityParentKey = "AutoChooseRounds",
			},
			{
				Label = "Choices To Match",
				UtilityMultiDropdownKey = "FallbackRoundChoices",
				UtilityParentKeys = {"AutoChooseRounds", "MatchOpponentRounds"},
				ExcludeUtilityDropdownKey = "RoundsToChoose",
				Options = {"1", "3", "5"},
			},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		14,
		1,
		8,
		"Auto Leave On Loss",
		{
			{Label = "Leave When About To Lose", UtilityToggleKey = "LeaveWhenAboutToLose"},
		}
	)
	createEmptyCollapsiblePanel(
		mainItem,
		15,
		2,
		8,
		"Logging",
		{
			{Label = "Print Wins/Losses To Terminal", UtilityToggleKey = "PrintWinsLossesToTerminal"},
			{Label = "Print Kicks To Terminal", UtilityToggleKey = "PrintKicksToTerminal"},
		}
	)
	do
		local autoBoothFeatures = {
			{Label = "Auto Booth", UtilityToggleKey = "AutoBooth"},
			{Label = "Booth Name", UtilityTextKey = "AutoBoothName", UtilityParentKey = "AutoBooth", Placeholder = "Booth name..."},
			{Label = "List Best Brainrot First", UtilityToggleKey = "AutoBoothListBestFirst", UtilityParentKey = "AutoBooth", UtilityExclusiveGroup = "AutoBoothSortOrder"},
			{Label = "List Worst Brainrot First", UtilityToggleKey = "AutoBoothListWorstFirst", UtilityParentKey = "AutoBooth", UtilityExclusiveGroup = "AutoBoothSortOrder"},
			{
				Label = "Avoid Brainrots With Traits",
				UtilityMultiDropdownKey = "AutoBoothAvoidTraits",
				UtilityParentKey = "AutoBooth",
				Placeholder = "Select",
				OptionsProvider = function()
					return autoServerHopState.BoothTraitOptions()
				end,
			},
			{
				Label = "Avoid Specific Mutations",
				UtilityMultiDropdownKey = "AutoBoothAvoidMutations",
				UtilityParentKey = "AutoBooth",
				Placeholder = "Select",
				OptionsProvider = function()
					return autoServerHopState.BoothMutationOptions()
				end,
			},
			{
				Label = "Avoid Specific Brainrots",
				UtilityMultiDropdownKey = "AutoBoothAvoidBrainrots",
				UtilityParentKey = "AutoBooth",
				Placeholder = "Select",
				OptionsProvider = function()
					return autoServerHopState.BoothBrainrotOptions()
				end,
			},
			{Label = "List Specific Brainrots Only", UtilityToggleKey = "AutoBoothSpecificOnly", UtilityParentKey = "AutoBooth"},
			{
				Label = "Specific Brainrots",
				UtilityMultiDropdownKey = "AutoBoothSpecificBrainrots",
				UtilityParentKeys = {"AutoBooth", "AutoBoothSpecificOnly"},
				Placeholder = "Select",
				OptionsProvider = function()
					return autoServerHopState.BoothBrainrotOptions()
				end,
			},
			{
				Label = "Message When All Listings Are Completed",
				UtilityToggleKey = "AutoBoothMessageAllListingsCompleted",
				UtilityParentKey = "AutoBooth",
			},
			{
				Label = "Message",
				UtilityTextKey = "AutoBoothAllListingsCompletedMessage",
				UtilityParentKeys = {"AutoBooth", "AutoBoothMessageAllListingsCompleted"},
				Placeholder = "Message when configured listings are completed...",
			},
			{
				Label = "Delay Before Sending Message",
				UtilitySliderKey = "AutoBoothAllListingsCompletedMessageDelay",
				UtilityParentKeys = {"AutoBooth", "AutoBoothMessageAllListingsCompleted"},
				MinValue = 0,
				MaxValue = 30,
				Step = 0.25,
				Decimals = 2,
				UnitLabel = "Seconds",
			},
			{
				Label = "Message When All Possible Listings Are Completed",
				UtilityToggleKey = "AutoBoothMessageAllPossibleCompleted",
				UtilityParentKey = "AutoBooth",
			},
			{
				Label = "Message",
				UtilityTextKey = "AutoBoothAllPossibleCompletedMessage",
				UtilityParentKeys = {"AutoBooth", "AutoBoothMessageAllPossibleCompleted"},
				Placeholder = "Message when no more eligible listings can be added...",
			},
			{
				Label = "Delay Before Sending Message",
				UtilitySliderKey = "AutoBoothAllPossibleCompletedMessageDelay",
				UtilityParentKeys = {"AutoBooth", "AutoBoothMessageAllPossibleCompleted"},
				MinValue = 0,
				MaxValue = 30,
				Step = 0.25,
				Decimals = 2,
				UnitLabel = "Seconds",
			},
		}

		for index = 1, 14 do
			local prefix = "AutoBoothListing" .. tostring(index)
			local listingParents = {"AutoBooth", prefix .. "Enabled"}
			local modeGroup = prefix .. "SelectionMode"

			autoBoothFeatures[#autoBoothFeatures + 1] = {
				Label = "Listing " .. tostring(index),
				UtilityToggleKey = prefix .. "Enabled",
				UtilityParentKey = "AutoBooth",
				BoothSlotIndex = index,
			}
			autoBoothFeatures[#autoBoothFeatures + 1] = {
				Label = "List By Rarity",
				UtilityToggleKey = prefix .. "ListByRarity",
				UtilityParentKeys = listingParents,
				UtilityExclusiveGroup = modeGroup,
				UtilityExclusiveRequired = true,
				BoothSlotIndex = index,
			}
			autoBoothFeatures[#autoBoothFeatures + 1] = {
				Label = "Rarity",
				UtilityDropdownKey = prefix .. "Rarity",
				UtilityParentKeys = {"AutoBooth", prefix .. "Enabled", prefix .. "ListByRarity"},
				Placeholder = "Select",
				Options = BRAINROT_RARITY_OPTIONS,
				BoothSlotIndex = index,
			}
			autoBoothFeatures[#autoBoothFeatures + 1] = {
				Label = "List By Brainrot",
				UtilityToggleKey = prefix .. "ListByBrainrot",
				UtilityParentKeys = listingParents,
				UtilityExclusiveGroup = modeGroup,
				UtilityExclusiveRequired = true,
				BoothSlotIndex = index,
			}
			autoBoothFeatures[#autoBoothFeatures + 1] = {
				Label = "Brainrot",
				UtilityDropdownKey = prefix .. "Brainrot",
				UtilityParentKeys = {"AutoBooth", prefix .. "Enabled", prefix .. "ListByBrainrot"},
				Placeholder = "Select",
				OptionsProvider = function()
					return autoServerHopState.BoothBrainrotOptions()
				end,
				BoothSlotIndex = index,
			}
			autoBoothFeatures[#autoBoothFeatures + 1] = {
				Label = "List When You Have Atleast",
				UtilitySliderKey = prefix .. "MinimumCopies",
				UtilityParentKeys = listingParents,
				MinValue = 1,
				MaxValue = 100,
				UnitLabel = "Owned",
				BoothSlotIndex = index,
			}
			autoBoothFeatures[#autoBoothFeatures + 1] = {
				Label = "Listing " .. tostring(index) .. " Tokens",
				UtilitySliderKey = prefix .. "Tokens",
				UtilityParentKeys = listingParents,
				MinValue = 1,
				MaxValue = 1000000,
				UnitLabel = "Tokens",
				BoothSlotIndex = index,
			}
			autoBoothFeatures[#autoBoothFeatures + 1] = {
				Label = "List Above This Inventory Or Higher",
				UtilitySliderKey = prefix .. "InventoryThreshold",
				UtilityParentKeys = listingParents,
				MinValue = 1,
				MaxValue = 100,
				UnitLabel = "Inventory",
				BoothSlotIndex = index,
			}
			autoBoothFeatures[#autoBoothFeatures + 1] = {
				Label = "Message When Listed",
				UtilityToggleKey = prefix .. "MessageWhenListed",
				UtilityParentKeys = listingParents,
				BoothSlotIndex = index,
			}
			autoBoothFeatures[#autoBoothFeatures + 1] = {
				Label = "Message",
				UtilityTextKey = prefix .. "ListedMessage",
				UtilityParentKeys = {"AutoBooth", prefix .. "Enabled", prefix .. "MessageWhenListed"},
				Placeholder = "Message to send when listed...",
				BoothSlotIndex = index,
			}
			autoBoothFeatures[#autoBoothFeatures + 1] = {
				Label = "Delay Before Sending Message",
				UtilitySliderKey = prefix .. "MessageDelay",
				UtilityParentKeys = {"AutoBooth", prefix .. "Enabled", prefix .. "MessageWhenListed"},
				MinValue = 0,
				MaxValue = 30,
				Step = 0.25,
				Decimals = 2,
				UnitLabel = "Seconds",
				BoothSlotIndex = index,
			}
		end

		createEmptyCollapsiblePanel(
			mainItem,
			16,
			1,
			9,
			"Auto Booth",
			autoBoothFeatures
		)
	end
	createEmptyCollapsiblePanel(
		mainItem,
		17,
		2,
		9,
		"Fallback Offer",
		{
			{Label = "Fall Back Offers", UtilityToggleKey = "FallbackOffers"},
			{Label = "Fallback To Next Lower Rarity Brainrot", UtilityToggleKey = "FallbackToNextLowerRarityBrainrot", UtilityParentKey = "FallbackOffers"},
			{Label = "Next Lower Rarity Brainrots", UtilitySliderKey = "FallbackNextLowerRarityAmount", UtilityParentKeys = {"FallbackOffers", "FallbackToNextLowerRarityBrainrot"}, MinValue = 1, MaxValue = 6, UnitLabel = "Brainrots"},
			{Label = "Fallback To Tokens", UtilityToggleKey = "FallbackToTokens", UtilityParentKey = "FallbackOffers"},
			{Label = "Common", UtilitySliderKey = "FallbackTokensCommon", UtilityParentKeys = {"FallbackOffers", "FallbackToTokens"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Uncommon", UtilitySliderKey = "FallbackTokensUncommon", UtilityParentKeys = {"FallbackOffers", "FallbackToTokens"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Rare", UtilitySliderKey = "FallbackTokensRare", UtilityParentKeys = {"FallbackOffers", "FallbackToTokens"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Epic", UtilitySliderKey = "FallbackTokensEpic", UtilityParentKeys = {"FallbackOffers", "FallbackToTokens"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Legendary", UtilitySliderKey = "FallbackTokensLegendary", UtilityParentKeys = {"FallbackOffers", "FallbackToTokens"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Mythical", UtilitySliderKey = "FallbackTokensMythical", UtilityParentKeys = {"FallbackOffers", "FallbackToTokens"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Cosmic", UtilitySliderKey = "FallbackTokensCosmic", UtilityParentKeys = {"FallbackOffers", "FallbackToTokens"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Secret", UtilitySliderKey = "FallbackTokensSecret", UtilityParentKeys = {"FallbackOffers", "FallbackToTokens"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Celestial", UtilitySliderKey = "FallbackTokensCelestial", UtilityParentKeys = {"FallbackOffers", "FallbackToTokens"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Divine", UtilitySliderKey = "FallbackTokensDivine", UtilityParentKeys = {"FallbackOffers", "FallbackToTokens"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Infinity", UtilitySliderKey = "FallbackTokensInfinity", UtilityParentKeys = {"FallbackOffers", "FallbackToTokens"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Meta", UtilitySliderKey = "FallbackTokensMeta", UtilityParentKeys = {"FallbackOffers", "FallbackToTokens"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Paradox", UtilitySliderKey = "FallbackTokensParadox", UtilityParentKeys = {"FallbackOffers", "FallbackToTokens"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
			{Label = "Eternal", UtilitySliderKey = "FallbackTokensEternal", UtilityParentKeys = {"FallbackOffers", "FallbackToTokens"}, MinValue = 0, MaxValue = 100000, UnitLabel = "Tokens"},
		}
	)

	createEmptyCollapsiblePanel(
		mainItem,
		19,
		1,
		10,
		"Blacklist Players",
		{
			{Label = "Temp Blacklist", UtilityToggleKey = "TempBlacklistPlayersAfterCanceledTrade"},
			{Label = "After This Many Canceled Trades", UtilitySliderKey = "TempBlacklistAfterCanceledTrades", UtilityParentKey = "TempBlacklistPlayersAfterCanceledTrade", MinValue = 1, MaxValue = 10, UnitLabel = "Trades"},
			{Label = "Perm Blacklist", UtilityToggleKey = "PermanentBlacklistPlayersAfterCanceledTrade"},
			{Label = "After This Many Canceled Trades", UtilitySliderKey = "PermanentBlacklistAfterCanceledTrades", UtilityParentKey = "PermanentBlacklistPlayersAfterCanceledTrade", MinValue = 1, MaxValue = 10, UnitLabel = "Trades"},
		}
	)

	createEmptyCollapsiblePanel(
		mainItem,
		21,
		2,
		10,
		"Manual",
		{
			{
				Label = "Manual Server Hop",
				UtilityToggleKey = "ManualServerHopAction",
				MomentaryAction = "ManualServerHop",
			},
			{
				Label = "Manual Kick During Minigame",
				UtilityToggleKey = "ManualKickMinigameAction",
				MomentaryAction = "ManualKickMinigame",
			},
		}
	)

	createEmptyCollapsiblePanel(
		settingsItem,
		1,
		1,
		1,
		"Pause Script",
		{
			{Label = "Pause Script", UtilityToggleKey = "PauseScript"},
		}
	)
	createEmptyCollapsiblePanel(
		settingsItem,
		2,
		2,
		1,
		"Undo Settings",
		{
			{Label = "Undo All Settings", UtilityToggleKey = "UndoAllSettings"},
		}
	)
	createEmptyCollapsiblePanel(
		settingsItem,
		3,
		1,
		2,
		"Auto Reconnect",
		{
			{Label = "Auto Reconnect", UtilityToggleKey = "AutoReconnect"},
		}
	)

else
	createSixPanelsForTab(
		homeItem
	)
	createSixPanelsForTab(
		mainItem
	)
	createSixPanelsForTab(
		settingsItem
	)
end
local controlHolder
local function syncRightPanelGeometry(
	instant
)
	local panelWidth = roundPixel(
		window.Size.X.Offset
		)
	local panelHeight = roundPixel(
		window.Size.Y.Offset
		)
	local dividerX = getSidebarWidth()
	local contentLeft = dividerX
	local contentTop = 0
	local contentWidth = math.max(
		px(2),
		panelWidth
			- dividerX
		)
	local contentHeight = math.max(
		px(2),
		panelHeight
		)
	rightContent.Position = U2O(
		contentLeft,
		contentTop
		)
	rightContent.Size = U2O(
		contentWidth,
		contentHeight
		)
	local titleLeft = px(14)
	local titleTextLeft = titleLeft
	selectedTabTitle.Position = U2O(
		titleTextLeft,
		CONTROL_TOP_MARGIN - px(1)
		)
	selectedTabTitle.Size = U2O(
		math.max(
			1,
			contentWidth
				- titleTextLeft
				- FIXED_CONTROL_HOLDER_WIDTH
				- CONTROL_RIGHT_MARGIN
				- px(14)
			),
		CONTROL_BUTTON_SIZE
		)
	if controlHolder then
		controlHolder.Position = U2(
				1,
				-CONTROL_RIGHT_MARGIN,
				0,
				CONTROL_TOP_MARGIN
			)
		controlHolder.Size = U2O(
				FIXED_CONTROL_HOLDER_WIDTH,
				CONTROL_BUTTON_SIZE
			)
		local controlStrokeThickness = math.max(
			LINE_THICKNESS,
			logicalPixelsForRenderedMinimum(1)
		)
		local minimizeGlyphWidth = math.max(
			px(9),
			logicalPixelsForRenderedMinimum(8)
		)
		local closeGlyphWidth = math.max(
			px(10),
			logicalPixelsForRenderedMinimum(9)
		)
		for _, controlButton in ipairs(controlHolder:GetChildren()) do
			if controlButton:IsA("TextButton") then
				controlButton.Size = U2O(
						CONTROL_BUTTON_SIZE,
						CONTROL_BUTTON_SIZE
					)
				for _, glyph in ipairs(controlButton:GetChildren()) do
					if glyph:IsA("Frame") then
						if glyph.Name == "MinimizeIcon" then
							glyph.Size = U2O(
								minimizeGlyphWidth,
								controlStrokeThickness
							)
						elseif string.find(glyph.Name, "CloseIconLine", 1, true) == 1 then
							glyph.Size = U2O(
								closeGlyphWidth,
								controlStrokeThickness
							)
						end
					end
				end
			end
		end
	end
	local usablePanelWidth = math.max(
		px(2),
		contentWidth
			- (CONTENT_SIDE_PADDING * 2)
			- (PANEL_SCROLL_EDGE_INSET * 2)
		)
	local responsiveWindowScale = window:FindFirstChild("ResponsiveWindowScale")
	local renderedPanelScale = responsiveWindowScale and responsiveWindowScale.Scale or 1
	local singleColumn = isPhonePanelLayout()
		or (usablePanelWidth * renderedPanelScale) < 460
	local cardWidth = singleColumn
		and usablePanelWidth
		or math.max(
			1,
			math.floor(
				(
					usablePanelWidth
						- CONTENT_COLUMN_GAP
					)
					* 0.5
				)
			)
	local leftX = CONTENT_SIDE_PADDING
			+ PANEL_SCROLL_EDGE_INSET
	local rightX = leftX
			+ cardWidth
			+ CONTENT_COLUMN_GAP
	local activePanels = unsupportedPanelGroups[
			selectedMenuItem
			]
		or {
		}
	local columnBottom = {
		[1] = CONTENT_TOP_PADDING
			+ PANEL_SCROLL_EDGE_INSET,
		[2] = CONTENT_TOP_PADDING
			+ PANEL_SCROLL_EDGE_INSET
	}
	local maxPanelOrder = 0
	for _, data in ipairs(activePanels) do
		if data.Frame.Visible then
			maxPanelOrder = math.max(maxPanelOrder, tonumber(data.Order) or 0)
		end
	end

	local function placePanel(data, layoutColumn)
		data.LayoutWidth = cardWidth
		if type(data.RelayoutRows) == "function" then
			data.RelayoutRows(true)
		end

		local targetHeight = data.Expanded
			and (data.ExpandedHeight or PANEL_EXPANDED_HEIGHT)
			or PANEL_COLLAPSED_HEIGHT
		local x = layoutColumn == 1 and leftX or rightX
		local y = columnBottom[layoutColumn]
		data.Frame.Position = U2O(x, y)
		if instant then
			data.Frame.Size = U2O(cardWidth, targetHeight)
		else
			TweenService:Create(
				data.Frame,
				PANEL_TWEEN_INFO,
				{Size = U2O(cardWidth, targetHeight)}
			):Play()
		end
		columnBottom[layoutColumn] = y
			+ targetHeight
			+ CONTENT_ROW_GAP
	end

	for order = 1, maxPanelOrder do
		for sourceColumn = 1, 2 do
			for _, data in ipairs(activePanels) do
				if data.Order == order
					and data.Column == sourceColumn
					and data.Frame.Visible then
					placePanel(data, singleColumn and 1 or sourceColumn)
				end
			end
		end
	end

	local panelContentBottom = singleColumn
		and columnBottom[1]
		or math.max(columnBottom[1], columnBottom[2])
	if panelContentBottom
		> (
		CONTENT_TOP_PADDING
			+ PANEL_SCROLL_EDGE_INSET
		) then
		panelContentBottom -= CONTENT_ROW_GAP
	end
	local contentEdgeSpacing = CONTENT_SIDE_PADDING + PANEL_SCROLL_EDGE_INSET
	local canvasHeight = math.max(
		contentHeight,
		panelContentBottom
			+ contentEdgeSpacing
		)
	rightContent.CanvasSize = U2O(
		0,
		roundPixel(
			canvasHeight
			)
		)
end

performSearch = function(resetScroll)
	local query=string.lower(searchBox.Text:match("^%s*(.-)%s*$"))
	for _,data in ipairs(allUnsupportedPanels) do
		data.Frame.Visible=data.TabItem==selectedMenuItem and (query=="" or string.find(data.SearchText,query,1,true)~=nil)
	end
	syncRightPanelGeometry(true)
	if resetScroll then rightContent.CanvasPosition=V2(0,0) end
end
refreshUnsupportedPanels = function()
	performSearch(false)
	local maxScrollY=math.max(0,rightContent.AbsoluteCanvasSize.Y-rightContent.AbsoluteWindowSize.Y)
	if rightContent.CanvasPosition.Y>maxScrollY then rightContent.CanvasPosition=V2(0,maxScrollY) end
end
local function setPanelExpanded(
	data,
	expanded
)
	data.Expanded = expanded
	if autoServerHopState and autoServerHopState.Utility then
		autoServerHopState.Utility.PanelExpanded = autoServerHopState.Utility.PanelExpanded or {}
		if data.PersistenceKey then
			autoServerHopState.Utility.PanelExpanded[data.PersistenceKey] = expanded
			local saver = rawget(_G, "__TUFFHUB_SAVE_SETTINGS_NOW")
			if type(saver) == "function" then task.defer(saver, true) end
		end
	end
	data.Body.Visible = expanded
	data.Divider.Visible = expanded
	TweenService:Create(
		data.Chevron,
		PANEL_TWEEN_INFO,
		{
			Rotation = expanded
				and 0
				or 180
		}
	):Play()
	syncRightPanelGeometry(
		false
	)
end
for _, data in ipairs(
	allUnsupportedPanels
) do
	data.Header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			data.HeaderPressInput = input
			data.HeaderPressPosition = input.Position
		end
	end)
	data.Header.InputEnded:Connect(function(input)
		if input ~= data.HeaderPressInput then return end
		local startPosition = data.HeaderPressPosition
		data.HeaderPressInput = nil
		data.HeaderPressPosition = nil
		if not startPosition then return end
		local delta = input.Position - startPosition
		if math.abs(delta.X) < 3 and math.abs(delta.Y) < 3 then
			setPanelExpanded(data, not data.Expanded)
		end
	end)
end
refreshUnsupportedPanels()
rawset(_G, "__TUFFHUB_REFRESH_ALL_SETTINGS_UI", function()
	for _, data in ipairs(allUnsupportedPanels) do
		for _, rowData in ipairs(data.FeatureRows or {}) do
			if type(rowData.RefreshFromState) == "function" then
				pcall(rowData.RefreshFromState)
			end
		end
		if type(data.RelayoutRows) == "function" then
			pcall(data.RelayoutRows)
		end
		local saved = autoServerHopState.Utility.PanelExpanded
		local desired = type(saved) ~= "table" or saved[data.PersistenceKey] ~= false
		if data.Expanded ~= desired then setPanelExpanded(data, desired) end
	end
	refreshUnsupportedPanels()
end)
rawset(_G, "__TUFFHUB_REFRESH_DYNAMIC_DROPDOWNS", function()
	for _, data in ipairs(allUnsupportedPanels) do
		for _, rowData in ipairs(data.FeatureRows or {}) do
			if type(rowData.RefreshUtilityDropdown) == "function" then
				pcall(rowData.RefreshUtilityDropdown)
			end
		end
	end
end)
if IS_MINIGAME_PLACE then
	task.spawn(function()
		while screenGui.Parent do
			local previous = tonumber(autoServerHopState.RuntimeBoothMaxSlots) or 3
			local current = autoServerHopState.RefreshBoothMaxSlots()
			if current ~= previous then
				for _, data in ipairs(allUnsupportedPanels) do
					if type(data.EnsureBoothSlots) == "function" then
						pcall(data.EnsureBoothSlots, current)
					end
				end
				local refresh = rawget(_G, "__TUFFHUB_REFRESH_ALL_SETTINGS_UI")
				if type(refresh) == "function" then pcall(refresh) end
			end
			task.wait(2)
		end
	end)
end
window:GetPropertyChangedSignal(
	"AbsoluteSize"
):Connect(function()
	if autoServerHopState.RuntimeResponsiveRelayoutQueued then return end
	autoServerHopState.RuntimeResponsiveRelayoutQueued = true
	task.defer(function()
		autoServerHopState.RuntimeResponsiveRelayoutQueued = false
		if not screenGui.Parent then return end
		syncPixelSnappedGeometry()
		syncRightPanelGeometry(true)
		for _, data in ipairs(allUnsupportedPanels) do
			if type(data.RelayoutRows) == "function" then
				pcall(data.RelayoutRows)
			end
		end
		syncRightPanelGeometry(true)
	end)
end)
camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	if autoServerHopState.RuntimeResponsiveRelayoutQueued then return end
	autoServerHopState.RuntimeResponsiveRelayoutQueued = true
	task.defer(function()
		autoServerHopState.RuntimeResponsiveRelayoutQueued = false
		if not screenGui.Parent then return end
		syncPixelSnappedGeometry()
		syncRightPanelGeometry(true)
		for _, data in ipairs(allUnsupportedPanels) do
			if type(data.RelayoutRows) == "function" then
				pcall(data.RelayoutRows)
			end
		end
		syncRightPanelGeometry(true)
	end)
end)
local function setSidebarCollapsed(
	collapsed
)
	sidebarCollapsed = collapsed
	if sidebarCollapsed
		and searchBox:IsFocused() then
		searchBox:ReleaseFocus()
	end
	syncPixelSnappedGeometry()
	syncRightPanelGeometry(
		true
	)
	for _, data in ipairs(allUnsupportedPanels) do
		if type(data.RelayoutRows) == "function" then
			pcall(data.RelayoutRows)
		end
	end
	syncRightPanelGeometry(true)
end
logoToggleButton.MouseButton1Click:Connect(function()
	setSidebarCollapsed(
		not sidebarCollapsed
	)
end)
controlHolder = New("Frame")
controlHolder.Name = "WindowControls"
controlHolder.AnchorPoint = V2(
		1,
		0
	)
controlHolder.Position = U2(
		1,
		-CONTROL_RIGHT_MARGIN,
		0,
		CONTROL_TOP_MARGIN
	)
controlHolder.Size = U2O(
		FIXED_CONTROL_HOLDER_WIDTH,
		CONTROL_BUTTON_SIZE
	)
controlHolder.BackgroundTransparency = 1
controlHolder.BorderSizePixel = 0
controlHolder.ZIndex = 55000
controlHolder.Parent = rightContent
local controlLayout = New("UIListLayout")
controlLayout.FillDirection = Enum.FillDirection.Horizontal
controlLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
controlLayout.VerticalAlignment = Enum.VerticalAlignment.Center
controlLayout.Padding = UDim.new(
		0,
		CONTROL_BUTTON_GAP
	)
controlLayout.SortOrder = Enum.SortOrder.LayoutOrder
controlLayout.Parent = controlHolder
local function createControlButton(
	name,
	order
)
	local button = New("TextButton")
	button.Name = name
	button.LayoutOrder = order
	button.Size = U2O(
			CONTROL_BUTTON_SIZE,
			CONTROL_BUTTON_SIZE
		)
	button.BackgroundColor3 = CONTROL_BACKGROUND
	button.BackgroundTransparency = 0
	button.BorderSizePixel = 0
	button.AutoButtonColor = false
	button.Text = ""
	button.ClipsDescendants = true
	button.ZIndex = 55001
	button.Parent = controlHolder
	ensureCorner(
		button,
		CONTROL_CORNER_RADIUS
	)
	rawget(_G, "__TUFFHUB_ENSURE_INPUT_BORDER")(button)
	local iconObjects = {}
	local function setIconColor(
		color
	)
		for _, iconObject in ipairs(
			iconObjects
		) do
			if iconObject:IsA("ImageLabel") then
				iconObject.ImageColor3 = color
			else
				iconObject.BackgroundColor3 = color
			end
		end
	end
	button.MouseEnter:Connect(function()
		TweenService:Create(
			button,
			menuTweenInfo,
			{
				BackgroundColor3 = CONTROL_HOVER_BACKGROUND
			}
		):Play()
		setIconColor(
			CONTROL_ICON_HOVER_COLOR
		)
	end)
	button.MouseLeave:Connect(function()
		TweenService:Create(
			button,
			menuTweenInfo,
			{
				BackgroundColor3 = CONTROL_BACKGROUND
			}
		):Play()
		setIconColor(
			CONTROL_ICON_COLOR
		)
	end)
	return button,iconObjects
end
;(function()
	local minimizeButton,
		minimizeIconObjects = createControlButton(
		"MinimizeButton",
		1
	)
local minimizeLine = New("Frame")
minimizeLine.Name = "MinimizeIcon"
minimizeLine.AnchorPoint = V2(
		0.5,
		0.5
	)
minimizeLine.Position = U2S(
		0.5,
		0.5
	)
minimizeLine.Size = U2O(
		math.max(px(9), logicalPixelsForRenderedMinimum(8)),
		math.max(LINE_THICKNESS, logicalPixelsForRenderedMinimum(1))
	)
minimizeLine.BackgroundColor3 = CONTROL_ICON_COLOR
minimizeLine.BorderSizePixel = 0
minimizeLine.ZIndex = 55003
minimizeLine.Parent = minimizeButton
table.insert(
	minimizeIconObjects,
	minimizeLine
)
local closeButton,
	closeIconObjects = createControlButton(
		"CloseButton",
		2
	)
for index,
	rotation in ipairs(
		{
			45,
			-45
		}
	) do
	local closeLine = New("Frame")
	closeLine.Name = "CloseIconLine"
		.. tostring(
			index
		)
	closeLine.AnchorPoint = V2(
			0.5,
			0.5
		)
	closeLine.Position = U2S(
			0.5,
			0.5
		)
	closeLine.Size = U2O(
			math.max(px(10), logicalPixelsForRenderedMinimum(9)),
			math.max(LINE_THICKNESS, logicalPixelsForRenderedMinimum(1))
		)
	closeLine.Rotation = rotation
	closeLine.BackgroundColor3 = CONTROL_ICON_COLOR
	closeLine.BorderSizePixel = 0
	closeLine.ZIndex = 55003
	closeLine.Parent = closeButton
	table.insert(
		closeIconObjects,
		closeLine
	)
end
;(function()
	local restoreButton = New("TextButton")
	restoreButton.Name = "MinimizedTHButton"
	restoreButton.AnchorPoint = V2(0.5, 0)
	restoreButton.Position = U2(0.5, 0, 0, px(10))

	local function syncRestoreButtonSize()
		local squarePixels = math.max(
			1,
			roundPixel(((workspace.CurrentCamera or camera) and (workspace.CurrentCamera or camera).ViewportSize.Y or viewportSize.Y) * 0.10)
		)
		restoreButton.Size = U2O(squarePixels, squarePixels)
	end
	syncRestoreButtonSize()
	camera:GetPropertyChangedSignal("ViewportSize"):Connect(syncRestoreButtonSize)

	restoreButton.BackgroundColor3 = BLACK
	restoreButton.BackgroundTransparency = 0
	restoreButton.BorderSizePixel = 0
	restoreButton.AutoButtonColor = false
	restoreButton.Text = ""
	restoreButton.Visible = not panelOpen
	restoreButton.ZIndex = 65000
	restoreButton.Parent = screenGui
	ensureCorner(restoreButton, px(9))

	local restoreStroke = New("UIStroke")
	restoreStroke.Name = "GrayOutline"
	restoreStroke.Color = RGB(92, 95, 102)
	restoreStroke.Thickness = px(1)
	restoreStroke.Transparency = 0.08
	restoreStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	restoreStroke.LineJoinMode = Enum.LineJoinMode.Round
	restoreStroke.Parent = restoreButton



	local restoreLogoHolder = New("Frame")
	restoreLogoHolder.Name = "CompactTHHolder"
	restoreLogoHolder.AnchorPoint = V2(0.5, 0.5)
	restoreLogoHolder.Position = U2S(0.5, 0.5)
	restoreLogoHolder.Size = U2S(0.58, 0.58)
	restoreLogoHolder.BackgroundTransparency = 1
	restoreLogoHolder.BorderSizePixel = 0
	restoreLogoHolder.ZIndex = 65001
	restoreLogoHolder.Parent = restoreButton

	local restoreT = New("TextLabel")
	restoreT.Name = "CompactT"
	restoreT.AnchorPoint = V2(0, 0.5)
	restoreT.Position = U2S(0.5, 0.5)
	restoreT.Size = U2(0, px(1), 1, 0)
	restoreT.BackgroundTransparency = 1
	restoreT.BorderSizePixel = 0
	restoreT.Text = "T"
	restoreT.TextColor3 = BLACK
	restoreT.TextStrokeColor3 = PINK
	restoreT.TextStrokeTransparency = 0
	restoreT.FontFace = LOGO_FONT_FACE
	restoreT.TextScaled = false
	restoreT.TextXAlignment = Enum.TextXAlignment.Center
	restoreT.TextYAlignment = Enum.TextYAlignment.Center
	restoreT.ZIndex = 65002
	restoreT.Parent = restoreLogoHolder

	local restoreH = New("TextLabel")
	restoreH.Name = "CompactH"
	restoreH.AnchorPoint = V2(0, 0.5)
	restoreH.Position = U2S(0.5, 0.5)
	restoreH.Size = U2(0, px(1), 1, 0)
	restoreH.BackgroundTransparency = 1
	restoreH.BorderSizePixel = 0
	restoreH.Text = "H"
	restoreH.TextColor3 = PINK
	restoreH.TextStrokeColor3 = PINK
	restoreH.TextStrokeTransparency = 0
	restoreH.FontFace = LOGO_FONT_FACE
	restoreH.TextScaled = false
	restoreH.TextXAlignment = Enum.TextXAlignment.Center
	restoreH.TextYAlignment = Enum.TextYAlignment.Center
	restoreH.ZIndex = 65002
	restoreH.Parent = restoreLogoHolder

	local function syncRestoreLogoTextSize()
		local textPixels = math.max(
			1,
			roundPixel(restoreLogoHolder.AbsoluteSize.Y * 1.235 * FONT_SIZE_SCALE)
		)
		restoreT.TextSize = textPixels
		restoreH.TextSize = textPixels



		local tWidth = math.max(1, restoreT.TextBounds.X)
		local hWidth = math.max(1, restoreH.TextBounds.X)
		local strokeRoom = px(2)
		local tBoxWidth = tWidth + strokeRoom
		local hBoxWidth = hWidth + strokeRoom
		local totalWidth = tBoxWidth + hBoxWidth
		local startX = roundPixel(-totalWidth * 0.5)

		restoreT.Position = U2(0.5, startX, 0.5, 0)
		restoreT.Size = U2O(tBoxWidth, restoreLogoHolder.AbsoluteSize.Y)
		restoreH.Position = U2(0.5, startX + tBoxWidth, 0.5, 0)
		restoreH.Size = U2O(hBoxWidth, restoreLogoHolder.AbsoluteSize.Y)
	end
	syncRestoreLogoTextSize()
	restoreLogoHolder:GetPropertyChangedSignal(
		"AbsoluteSize"
	):Connect(syncRestoreLogoTextSize)

	restoreButton.MouseEnter:Connect(function()
		TweenService:Create(
			restoreButton,
			menuTweenInfo,
			{BackgroundColor3 = CONTROL_HOVER_BACKGROUND}
		):Play()
	end)

	restoreButton.MouseLeave:Connect(function()
		TweenService:Create(
			restoreButton,
			menuTweenInfo,
			{BackgroundColor3 = BLACK}
		):Play()
	end)

	local iconDragging = false
	local iconMoved = false
	local iconStart
	local iconStartPosition
	local iconTouchInput
	local ICON_DRAG_THRESHOLD = px(3)

	local function beginIconDrag(input)
		if not restoreButton.Visible then
			return
		end
		iconDragging = true
		iconMoved = false
		iconStart = input.Position
		iconStartPosition = restoreButton.Position
		iconTouchInput = input.UserInputType == Enum.UserInputType.Touch
			and input
			or nil
	end

	local function updateIconDrag(position)
		if not iconDragging or not iconStart or not iconStartPosition then
			return
		end

		local delta = position - iconStart
		if not iconMoved
			and (math.abs(delta.X) >= ICON_DRAG_THRESHOLD
				or math.abs(delta.Y) >= ICON_DRAG_THRESHOLD)
		then
			iconMoved = true
		end

		if iconMoved then
			restoreButton.Position = U2(
				iconStartPosition.X.Scale,
				iconStartPosition.X.Offset + delta.X,
				iconStartPosition.Y.Scale,
				iconStartPosition.Y.Offset + delta.Y
			)
		end
	end

	local function finishIconDrag(input)
		if not iconDragging then
			return
		end
		if iconTouchInput and input ~= iconTouchInput then
			return
		end

		local shouldRestore = not iconMoved
		iconDragging = false
		iconMoved = false
		iconStart = nil
		iconStartPosition = nil
		iconTouchInput = nil

		if shouldRestore then
			setPanelOpen(true)
		end
	end

	restoreButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			beginIconDrag(input)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not iconDragging then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement
			and iconTouchInput == nil
		then
			updateIconDrag(input.Position)
		elseif input.UserInputType == Enum.UserInputType.Touch
			and input == iconTouchInput
		then
			updateIconDrag(input.Position)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			and iconTouchInput == nil
		then
			finishIconDrag(input)
		elseif input.UserInputType == Enum.UserInputType.Touch
			and input == iconTouchInput
		then
			finishIconDrag(input)
		end
	end)
end)()

minimizeButton.MouseButton1Click:Connect(function()
	setPanelOpen(
		false
	)
end)
closeButton.MouseButton1Click:Connect(function()
	if guiDestroyed then
		return
	end
	guiDestroyed = true
	panelOpen = false
	autoServerHopState.Utility.GuiMinimized = false
	local saver = rawget(_G, "__TUFFHUB_SAVE_SETTINGS_NOW")
	if type(saver) == "function" then
		pcall(saver, true)
	end
	screenGui:Destroy()
end)
end)()
UserInputService.InputBegan:Connect(
	function(input, gameProcessedEvent)
		if guiDestroyed then
			return
		end
		if gameProcessedEvent then
			return
		end
		if UserInputService:GetFocusedTextBox() then
			return
		end
		if input.KeyCode == TOGGLE_KEY then
			setPanelOpen(
				not panelOpen
			)
		end
	end
)
;(function()
	local dragging = false
	local dragState = {
		Start = nil,
		StartPosition = nil,
		TouchInput = nil,
	}

	local function belongsToWindow(object)
		return object == window
			or (object and object:IsDescendantOf(window))
	end

	local function isActuallyVisible(object)
		local current = object
		while current and current ~= window do
			if current:IsA("GuiObject") and not current.Visible then
				return false
			end
			current = current.Parent
		end
		return current == window
	end

	local function isInsidePanel(object)
		local current = object
		while current and current ~= window do
			if current:IsA("GuiObject")
				and string.find(current.Name, "EmptyPanel", 1, true)
			then
				return true
			end
			current = current.Parent
		end
		return false
	end

	local function objectBlocksDrag(object, point)
		if object == window or not object:IsA("GuiObject") then
			return false
		end
		if isInsidePanel(object) then
			return true
		end




		if object == selectedTabTitle and point then
			local bounds = object.TextBounds
			local position = object.AbsolutePosition
			local size = object.AbsoluteSize
			local textWidth = math.min(size.X, math.max(0, bounds.X))
			local textHeight = math.min(size.Y, math.max(0, bounds.Y))
			local textLeft = position.X
			local textTop = position.Y + ((size.Y - textHeight) * 0.5)
			return point.X >= textLeft
				and point.X <= textLeft + textWidth
				and point.Y >= textTop
				and point.Y <= textTop + textHeight
		end

		return object:IsA("GuiButton")
			or object:IsA("TextBox")
			or object:IsA("TextLabel")
			or object:IsA("ImageLabel")
			or object:IsA("ImageButton")
			or object.BackgroundTransparency < 0.999
	end




	local function pointIsEmptyBlackBackground(point)
		local hits
		local hitQuerySucceeded = pcall(function()
			local root = guiParent
			if not root or not root:IsA("BasePlayerGui") then
				if window:IsDescendantOf(CoreGui) then
					root = CoreGui
				else
					error("No BasePlayerGui hit-test root")
				end
			end
			hits = root:GetGuiObjectsAtPosition(point.X, point.Y)
		end)

		if hitQuerySucceeded and type(hits) == "table" then
			local foundWindow = false
			for _, object in ipairs(hits) do
				if belongsToWindow(object) then
					foundWindow = true
					if objectBlocksDrag(object, point) then
						return false
					end
				end
			end
			return foundWindow
		end


		if not pointInsideGui(window, point) then
			return false
		end
		for _, object in ipairs(window:GetDescendants()) do
			if object:IsA("GuiObject")
				and object.Visible
				and pointInsideGui(object, point)
				and isActuallyVisible(object)
				and objectBlocksDrag(object, point)
			then
				return false
			end
		end
		return true
	end

	local function touchStartsInScrollableContent(point)
		if pointInsideGui(menuHolder, point) then
			return true
		end

		if pointInsideGui(rightContent, point) then





			local canvasY = point.Y
				- rightContent.AbsolutePosition.Y
				+ rightContent.CanvasPosition.Y
			if canvasY >= CONTENT_TOP_PADDING then
				return true
			end
		end

		return false
	end

	local function beginDrag(input)
		if not window.Visible
			or not pointIsEmptyBlackBackground(input.Position)
			or (
				input.UserInputType == Enum.UserInputType.Touch
				and touchStartsInScrollableContent(input.Position)
			)
		then
			return
		end

		dragging = true
		dragState.Start = input.Position
		dragState.StartPosition = window.Position
		dragState.TouchInput = input.UserInputType == Enum.UserInputType.Touch
			and input
			or nil
	end

	local function endDrag()
		dragging = false
		dragState.Start = nil
		dragState.StartPosition = nil
		dragState.TouchInput = nil
	end

	local function updateDrag(position)
		if not dragging
			or not dragState.Start
			or not dragState.StartPosition
		then
			return
		end

		local delta = position - dragState.Start
		window.Position = UDim2.new(
			dragState.StartPosition.X.Scale,
			roundPixel(
				dragState.StartPosition.X.Offset + delta.X
			),
			dragState.StartPosition.Y.Scale,
			roundPixel(
				dragState.StartPosition.Y.Offset + delta.Y
			)
		)
	end

	UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			beginDrag(input)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not dragging then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement
			and dragState.TouchInput == nil
		then
			updateDrag(input.Position)
		elseif input.UserInputType == Enum.UserInputType.Touch
			and input == dragState.TouchInput
		then
			updateDrag(input.Position)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			and dragState.TouchInput == nil
		then
			endDrag()
		elseif input.UserInputType == Enum.UserInputType.Touch
			and input == dragState.TouchInput
		then
			endDrag()
		end
	end)
end)()








if IS_MINIGAME_PLACE then
	task.spawn(function()


		while screenGui.Parent do
			local emptyEnabled = autoSitState
				and autoSitState.EmptyTables
				and autoSitState.EmptyTables.Enabled == true
			local partnerEnabled = autoSitState
				and autoSitState.OneOfTwo
				and autoSitState.OneOfTwo.Enabled == true
			if autoServerHopState.Utility.PauseScript ~= true
			and autoServerHopState.Utility.PauseMinigameFeatures ~= true
				and (emptyEnabled or partnerEnabled)
			then
				break
			end
			task.wait(0.10)
		end
		if not screenGui.Parent then return end

		local PlayersAS = game:GetService("Players")
		local RSAS = game:GetService("ReplicatedStorage")
		local PathfindingServiceAS = game:GetService("PathfindingService")
		local RunServiceAS = game:GetService("RunService")
		local LocalPlayerAS = PlayersAS.LocalPlayer

		local function requireAS(moduleScript)
			while screenGui.Parent do
				local ok, result = pcall(require, moduleScript)
				if ok and result ~= nil then return result end
				task.wait(0.20)
			end
		end

		local sharedAS = RSAS:WaitForChild("Shared")
		local clientAS = RSAS:WaitForChild("Client")
		local EconomyMathAS = requireAS(sharedAS:WaitForChild("utils"):WaitForChild("EconomyMath"))
		local ReplicatorAS = requireAS(clientAS:WaitForChild("Modules"):WaitForChild("ReplicatorClient"))
		local RemotesAS = requireAS(sharedAS:WaitForChild("Remotes"))
		if not (EconomyMathAS and ReplicatorAS and RemotesAS) then return end

		local MinigameLeaveQueueAS = RemotesAS.MinigameLeaveQueue
		local activeMinigameAS
		local activeNegotiationAS
		local tablesFolderCacheAS
		local spawnMachineCacheAS
		local nextTablesFallbackScanAS = 0
		local routeBusyAS = false
		autoServerHopState.RuntimeAutoSitBusy = false
		local lastJoinAttemptAS = 0
		local blockedPreviousTableAS
		local lastObservedPhysicalTableAS
		local TABLE_APPROACH_DISTANCE_AS = 1.80
		local TABLE_MOVE_TIMEOUT_AS = 15.0
		local TABLE_PROMPT_CAPTURE_DISTANCE_AS = 7.50
		local PATH_WAYPOINT_SPACING_AS = 3.25
		local PATH_WAYPOINT_REACHED_AS = 1.35
		local PATH_PROGRESS_SAMPLE_AS = 0.02
		local PATH_PROGRESS_GAIN_AS = 0.12
		local PATH_REPATH_STALL_AS = 0.10
		local PATH_SLOW_SPEED_AS = 5.0
		local PATH_SLOW_DETECT_AS = 0.00
		local PATH_POST_JUMP_OBSERVE_AS = 0.08
		local PATH_JUMP_REARM_DISTANCE_AS = 2.0
		local PATH_REPATH_LIMIT_AS = 5
		local PARTNER_CLOSE_CONFIRM_AS = 0.45
		local FALLBACK_SPAWN_MACHINE_POSITION_AS = Vector3.new(
			-1460.782470703125,
			-20.79950523376465,
			-85.21368408203125
		)

		local function refreshReplicatorsAS()



			local okMinigame, freshMinigame = pcall(ReplicatorAS.get, "ActiveMinigame")
			if okMinigame then activeMinigameAS = freshMinigame end
			local okNegotiation, freshNegotiation = pcall(
				ReplicatorAS.get,
				"ActiveNegotiation"
			)
			if okNegotiation then activeNegotiationAS = freshNegotiation end
		end

		local function tryIndexAS(root, path)
			if not root then return nil end
			local ok, value = pcall(function() return root:TryIndex(path) end)
			return ok and value or nil
		end

		local function minigameQueuedAS()
			refreshReplicatorsAS()
			local queued = tryIndexAS(activeMinigameAS, {"queued"})
			if queued ~= nil then return queued == true end
			local ok, direct = pcall(function()
				return activeMinigameAS and activeMinigameAS.Data and activeMinigameAS.Data.queued
			end)
			return ok and direct == true
		end

		local function minigamePlayingAS()
			refreshReplicatorsAS()
			return tryIndexAS(activeMinigameAS, {"phase"}) ~= nil
				or tryIndexAS(activeMinigameAS, {"session", "gameId"}) ~= nil
		end

		local function negotiationActiveAS()
			refreshReplicatorsAS()
			return tryIndexAS(activeNegotiationAS, {"guid"}) ~= nil
		end

		local function activeTableAS()
			refreshReplicatorsAS()
			local model = tryIndexAS(activeMinigameAS, {"session", "public", "tableModel"})
			return typeof(model) == "Instance" and model:IsA("Model") and model or nil
		end

		local function tablesFolderAS()
			if tablesFolderCacheAS and tablesFolderCacheAS.Parent then return tablesFolderCacheAS end
			local gameObjects = workspace:FindFirstChild("GameObjects")
			local placeSpecific = gameObjects and gameObjects:FindFirstChild("PlaceSpecific")
			local tradePlaza = placeSpecific and placeSpecific:FindFirstChild("trade_plaza")
			local canonical = tradePlaza and tradePlaza:FindFirstChild("MinigameTables")
			if canonical then
				tablesFolderCacheAS = canonical
				return canonical
			end
			local now = os.clock()
			if now < nextTablesFallbackScanAS then return nil end
			nextTablesFallbackScanAS = now + 0.50
			for _, descendant in ipairs(workspace:GetDescendants()) do
				if descendant.Name == "MinigameTables"
					and descendant:FindFirstChildWhichIsA("Seat", true)
				then
					tablesFolderCacheAS = descendant
					return descendant
				end
			end
		end

		local function spawnMachinePositionAS()
			if spawnMachineCacheAS and spawnMachineCacheAS.Parent then
				return spawnMachineCacheAS.Position
			end
			local gameObjects = workspace:FindFirstChild("GameObjects")
			local placeSpecific = gameObjects and gameObjects:FindFirstChild("PlaceSpecific")
			local tradePlaza = placeSpecific and placeSpecific:FindFirstChild("trade_plaza")
			local spawnMachines = tradePlaza and tradePlaza:FindFirstChild("SpawnMachines")
			local defaultMachine = spawnMachines and spawnMachines:FindFirstChild("Default")
			local main = defaultMachine and defaultMachine:FindFirstChild("Main")
			if main and main:IsA("BasePart") then
				spawnMachineCacheAS = main
				return main.Position
			end
			return FALLBACK_SPAWN_MACHINE_POSITION_AS
		end

		local function characterPartsAS()
			local character = LocalPlayerAS.Character
			if not character then return nil end
			return character,
				character:FindFirstChildOfClass("Humanoid"),
				character:FindFirstChild("HumanoidRootPart")
		end

		local function customSeatWeldAS(root)
			return root and root.Parent and root:FindFirstChild("CustomSeatWeld") or nil
		end

		local function tableFromCustomSeatWeldAS(root, folder)
			local weld = customSeatWeldAS(root)
			if not weld or not folder then return nil end
			for _, propertyName in ipairs({"Part0", "Part1"}) do
				local part
				pcall(function() part = weld[propertyName] end)
				if typeof(part) == "Instance" and part:IsDescendantOf(folder) then
					local model = part:FindFirstAncestor("Table")
					if model and model:IsA("Model") then return model end
				end
			end
		end

		local function physicalCurrentTableAS()
			local folder = tablesFolderAS()
			local _, humanoid, root = characterPartsAS()
			if not folder then return nil end
			local custom = tableFromCustomSeatWeldAS(root, folder)
			if custom then return custom end
			local seat = humanoid and humanoid.SeatPart
			if seat and seat:IsDescendantOf(folder) then
				return seat:FindFirstAncestor("Table")
			end
		end

		local function tableSeatPromptAS(seat)
			if not seat then return nil end
			local prompt = seat:FindFirstChildOfClass("ProximityPrompt")
			if prompt and prompt.ActionText == "Join" and prompt.ObjectText == "Minigame Table" then
				return prompt
			end
		end

		local function getPlayerAtSeatAS(seat)
			if not seat or not seat.Parent then return nil end
			local occupant = seat.Occupant
			if occupant then
				local player = PlayersAS:GetPlayerFromCharacter(occupant.Parent)
				if player and player ~= LocalPlayerAS then return player end
			end
			for _, player in ipairs(PlayersAS:GetPlayers()) do
				if player ~= LocalPlayerAS then
					local character = player.Character
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")
					local root = character and character:FindFirstChild("HumanoidRootPart")
					if humanoid and humanoid.SeatPart == seat then return player end
					local weld = customSeatWeldAS(root)
					if weld then
						for _, propertyName in ipairs({"Part0", "Part1"}) do
							local part
							pcall(function() part = weld[propertyName] end)
							if part == seat then return player end
						end
					end
				end
			end
		end

		local function seatOccupiedByOtherAS(seat)
			if not seat or not seat.Parent then return true end
			local _, localHumanoid = characterPartsAS()
			if seat.Occupant and seat.Occupant ~= localHumanoid then return true end
			return getPlayerAtSeatAS(seat) ~= nil
		end

		local function replicatedTablePlayerCountAS(model)
			if not model or not model.Parent then return nil end
			local count = 0
			local folder = tablesFolderAS()
			for _, player in ipairs(PlayersAS:GetPlayers()) do
				local character = player.Character
				local root = character and character:FindFirstChild("HumanoidRootPart")
				if root and folder and tableFromCustomSeatWeldAS(root, folder) == model then
					count += 1
				end
			end
			if count > 0 then return math.min(count, 2) end

			local billboard = model:FindFirstChild("StatusBillboard", true)
			if billboard and billboard:IsA("BillboardGui") and billboard.Enabled then
				local header = billboard:FindFirstChild("HeaderLabel", true)
				local labelText = header and header:IsA("TextLabel") and header.Text or nil
				if type(labelText) == "string" then
					local billboardCount = tonumber(string.match(labelText, "(%d+)%s*/%s*2"))
					if billboardCount == 0 or billboardCount == 1 or billboardCount == 2 then
						return billboardCount
					end
				end
			end

			count = 0
			for _, player in ipairs(PlayersAS:GetPlayers()) do
				local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
				local seat = humanoid and humanoid.SeatPart
				if seat and seat:IsDescendantOf(model) then count += 1 end
			end
			return count > 0 and math.min(count, 2) or nil
		end

		local function waitingPartnerAtTableAS(model, knownPlayerCount)
			if not model then return nil end
			local folder = tablesFolderAS()
			for _, player in ipairs(PlayersAS:GetPlayers()) do
				if player ~= LocalPlayerAS then
					local character = player.Character
					local root = character and character:FindFirstChild("HumanoidRootPart")
					if root and folder and tableFromCustomSeatWeldAS(root, folder) == model then return player end
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")
					local seat = humanoid and humanoid.SeatPart
					if seat and seat:IsDescendantOf(model) then return player end
				end
			end
			for _, seatName in ipairs({"Seat1", "Seat2"}) do
				local seat = model:FindFirstChild(seatName)
				local player = seat and getPlayerAtSeatAS(seat)
				if player then return player end
			end
			if knownPlayerCount == 1 then return nil end
		end

		local function parseTokensAS(rawValue)
			if type(rawValue) == "number" then return math.max(0, rawValue) end
			local valueText = string.upper(tostring(rawValue or ""))
			valueText = string.gsub(valueText, ",", "")
			valueText = string.gsub(valueText, "%s+", "")
			local direct = tonumber(valueText)
			if direct then return math.max(0, direct) end
			local numberText, suffix = string.match(valueText, "([%d%.]+)([KMBTQ]?)")
			local value = tonumber(numberText)
			if not value then return 0 end
			local multipliers = {K=1e3, M=1e6, B=1e9, T=1e12, Q=1e15}
			return math.max(0, value * (multipliers[suffix] or 1))
		end

		local function publicTokensAS(player)
			local leaderstats = player and player:FindFirstChild("leaderstats")
			local stat = leaderstats and leaderstats:FindFirstChild("Trade Tokens")
			if stat then
				local ok, value = pcall(function() return stat.Value end)
				if ok then
					local parsed = parseTokensAS(value)
					if parsed > 0 then return parsed end
				end
			end
			for _, attributeName in ipairs({"TradeTokens", "Trade Tokens", "tradeTokens"}) do
				local ok, value = pcall(player.GetAttribute, player, attributeName)
				if ok and value ~= nil then
					local parsed = parseTokensAS(value)
					if parsed > 0 then return parsed end
				end
			end
			return 0
		end

		local function publicBrainrotCategoryAS(tool, name)
			local explicitRarity = tool:GetAttribute("Rarity")
				or tool:GetAttribute("BrainrotRarity")
			if explicitRarity == "Meta" then return "Meta" end

			local rarity = type(explicitRarity) == "string" and explicitRarity or nil
			if not rarity then
				pcall(function() rarity = EconomyMathAS.GetBrainrotRarity(name) end)
			end

			local metaMarked = tool:GetAttribute("Meta") == true
				or tool:GetAttribute("IsMeta") == true
				or (
					type(name) == "string"
					and string.find(string.lower(name), "%f[%a]meta%f[%A]") ~= nil
				)
			return rarity == "Infinity" and metaMarked and "Meta" or rarity
		end

		local function publicRarityCountsAS(player)
			local counts = {}
			local function scan(container)
				if not container then return end
				for _, tool in ipairs(container:GetChildren()) do
					if tool:IsA("Tool") then
						local name = tool:GetAttribute("BrainrotName")
						if type(name) == "string" and name ~= "" then
							local rarity = publicBrainrotCategoryAS(tool, name)
							if rarity then
								counts[rarity] = (counts[rarity] or 0) + 1
							end
						end
					end
				end
			end
			scan(player:FindFirstChildOfClass("Backpack"))
			scan(player.Character)
			return counts
		end

		local function isBlacklistedAS(player)
			if typeof(player) ~= "Instance" or not player:IsA("Player") then return false end
			local userId = tostring(player.UserId)
			local utility = autoServerHopState and autoServerHopState.Utility
			if not utility then return false end
			if utility.PauseScript ~= true then
				local scriptUsers = autoServerHopState.RuntimeScriptUserIds
				if type(scriptUsers) == "table" and scriptUsers[userId] == true then
					return true
				end
				local seenAt = autoServerHopState.RuntimePresencePlayerSeenAt
				local firstSeen = type(seenAt) == "table"
					and tonumber(seenAt[userId])
					or nil
				if firstSeen ~= nil and os.clock() - firstSeen < 2.0 then
					return true
				end
			end
			if utility.TempBlacklistPlayersAfterCanceledTrade == true then
				local temporary = autoServerHopState.RuntimeTempBlacklistedUserIds
				if type(temporary) == "table" and temporary[userId] == true then return true end
			end
			if utility.PermanentBlacklistPlayersAfterCanceledTrade == true then
				local permanent = utility.PermanentBlacklistedUserIds
				if type(permanent) == "table" and permanent[userId] == true then return true end
			end
			return false
		end

		local function mustOwnMatchesAS(player)
			local config = autoSitState and autoSitState.OneOfTwo
			if not config or typeof(player) ~= "Instance" or not player:IsA("Player") then return false end
			if isBlacklistedAS(player) then return false end
			local counts
			local selected = 0
			for _, rarity in ipairs(RARITY_OPTIONS) do
				if config.Targets and config.Targets[rarity] then
					selected += 1
					if rarity == "Tokens" then
						local required = math.clamp(math.floor(tonumber(config.Tokens) or 1), 1, 100000)
						if publicTokensAS(player) >= required then return true end
					else
						counts = counts or publicRarityCountsAS(player)
						local required = math.clamp(
							math.floor(tonumber(config.Amounts and config.Amounts[rarity]) or 1),
							1,
							100
						)
						if (counts[rarity] or 0) >= required then return true end
					end
				end
			end
			return selected == 0
		end

		local function machineDistanceAS(model)
			local center = model:GetPivot().Position
			local machine = spawnMachinePositionAS()
			return Vector3.new(center.X-machine.X, 0, center.Z-machine.Z).Magnitude
		end

		local function bestOpenSeatAS(model, playerCount)
			local _, _, root = characterPartsAS()
			local best
			for _, seatName in ipairs({"Seat1", "Seat2"}) do
				local seat = model:FindFirstChild(seatName)
				if seat and seat:IsA("Seat") then
					local prompt = tableSeatPromptAS(seat)
					if prompt and not seatOccupiedByOtherAS(seat) then
						local travel = root
							and Vector3.new(seat.Position.X-root.Position.X, 0, seat.Position.Z-root.Position.Z).Magnitude
							or math.huge
						local candidate = {
							Model=model, Seat=seat, Prompt=prompt,
							PromptReady=prompt.Enabled == true,
							TravelDistance=travel, PlayerCount=playerCount,
							MachineDistance=machineDistanceAS(model),
						}
						if not best
							or (candidate.PromptReady and not best.PromptReady)
							or (candidate.PromptReady == best.PromptReady and candidate.TravelDistance < best.TravelDistance)
						then
							best = candidate
						end
					end
				end
			end
			return best
		end

		local function collectCandidatesAS(partnersOnly, excludedModel)
			local folder = tablesFolderAS()
			if not folder then return {}, {} end
			local partners, empties = {}, {}

			if partnersOnly then
				local seen = {}
				for _, player in ipairs(PlayersAS:GetPlayers()) do
					if player ~= LocalPlayerAS then
						local character = player.Character
						local root = character and character:FindFirstChild("HumanoidRootPart")
						local humanoid = character and character:FindFirstChildOfClass("Humanoid")
						local model = root and tableFromCustomSeatWeldAS(root, folder)
						local seatPart = humanoid and humanoid.SeatPart
						if not model and seatPart and seatPart:IsDescendantOf(folder) then
							model = seatPart:FindFirstAncestor("Table")
						end
						if model
							and model ~= excludedModel
							and model ~= blockedPreviousTableAS
							and not seen[model]
							and mustOwnMatchesAS(player)
						then
							seen[model] = true
							local candidate = bestOpenSeatAS(model, 1)
							if candidate then
								candidate.Partner = player
								candidate.LockedAsPartner = true
								partners[#partners+1] = candidate
							end
						end
					end
				end
			else
				for _, model in ipairs(folder:GetChildren()) do
					if model:IsA("Model")
						and model.Name == "Table"
						and model ~= excludedModel
						and model ~= blockedPreviousTableAS
					then
						local count = replicatedTablePlayerCountAS(model)
						if count == nil or count < 2 then
							local partner = waitingPartnerAtTableAS(model, count)
							local candidate = bestOpenSeatAS(model, count)
							if candidate then
								if typeof(partner) == "Instance" and partner:IsA("Player") and mustOwnMatchesAS(partner) then
									candidate.Partner = partner
									candidate.LockedAsPartner = true
									partners[#partners+1] = candidate
								elseif partner == nil and (count == nil or count == 0) then
									empties[#empties+1] = candidate
								end
							end
						end
					end
				end
			end

			table.sort(partners, function(a,b)
				if a.PromptReady ~= b.PromptReady then return a.PromptReady == true end
				if a.MachineDistance ~= b.MachineDistance then return a.MachineDistance < b.MachineDistance end
				return a.TravelDistance < b.TravelDistance
			end)
			table.sort(empties, function(a,b)
				if a.MachineDistance ~= b.MachineDistance then return a.MachineDistance < b.MachineDistance end
				return a.TravelDistance < b.TravelDistance
			end)
			return partners, empties
		end

		local function bestTargetAS(excludedModel)
			local partners, empties = collectCandidatesAS(false, excludedModel)



			if autoSitState.OneOfTwo.Enabled == true and partners[1] then
				return partners[1]
			end
			if autoSitState.EmptyTables.Enabled == true then
				return empties[1]
			end
		end

		local function bestPartnerAS(currentModel)
			if autoSitState.OneOfTwo.Enabled ~= true then return nil end
			return (select(1, collectCandidatesAS(true, currentModel)))[1]
		end

		local function candidateStillAvailableAS(candidate, requirePartner)
			if not candidate
				or not candidate.Model
				or not candidate.Model.Parent
				or not candidate.Seat
				or not candidate.Seat.Parent
				or not candidate.Prompt
				or not candidate.Prompt.Parent
			then
				return false, "target_closed"
			end

			if seatOccupiedByOtherAS(candidate.Seat) then
				return false, "claimed"
			end

			local now = os.clock()
			local count = replicatedTablePlayerCountAS(candidate.Model)
			local partner = waitingPartnerAtTableAS(candidate.Model, count)
			local concretePartner = typeof(partner) == "Instance"
				and partner:IsA("Player")

			if candidate.LockedAsPartner == true or requirePartner == true then
				if concretePartner and mustOwnMatchesAS(partner) then
					candidate.Partner = partner
					candidate.LockedAsPartner = true
					candidate._PartnerMissingSince = nil
					return true
				end



				candidate._PartnerMissingSince = candidate._PartnerMissingSince or now
				if now - candidate._PartnerMissingSince < PARTNER_CLOSE_CONFIRM_AS then
					return true
				end
				return false, "partner_closed"
			end

			if concretePartner then



				if autoSitState.OneOfTwo.Enabled == true
					and mustOwnMatchesAS(partner)
				then
					candidate.Partner = partner
					candidate.LockedAsPartner = true
					candidate._PartnerMissingSince = nil
					return true
				end
				return false, "target_closed"
			end



			if count == 1 then
				candidate._UnresolvedOneSince = candidate._UnresolvedOneSince or now
				if now - candidate._UnresolvedOneSince < 0.30 then
					return true
				end
				return false, "target_closed"
			end

			candidate._UnresolvedOneSince = nil
			return count == nil or count == 0, (count and "target_closed" or nil)
		end

		local function firePromptAS(prompt)
			if not prompt or not prompt.Parent or not prompt.Enabled then return false end

			local firePrompt
			local environments = {_G}
			pcall(function()
				if getgenv then environments[#environments + 1] = getgenv() end
			end)
			pcall(function()
				if getrenv then environments[#environments + 1] = getrenv() end
			end)
			pcall(function()
				if getfenv then environments[#environments + 1] = getfenv(0) end
			end)
			for _, environment in ipairs(environments) do
				if type(environment) == "table" then
					local ok, value = pcall(function()
						return environment.fireproximityprompt
					end)
					if ok and type(value) == "function" then
						firePrompt = value
						break
					end
				end
			end

			if type(firePrompt) == "function" then
				local ok = pcall(firePrompt, prompt, 1, true)
				if ok then return true end
			end
			return pcall(function()
				prompt:InputHoldBegin()
				task.wait(math.max(prompt.HoldDuration, 0.05))
				prompt:InputHoldEnd()
			end)
		end

		local function releaseCurrentSeatAS(expectedTable)
			local _, humanoid, root = characterPartsAS()
			local folder = tablesFolderAS()
			if not humanoid or not root or not folder then return false end






			if not minigameQueuedAS() then
				return false
			end

			local fired = pcall(function()
				MinigameLeaveQueueAS:FireServer()
			end)
			if not fired then return false end

			local queueDeadline = os.clock() + 1.50
			while minigameQueuedAS() and os.clock() < queueDeadline do


				humanoid:Move(Vector3.zero, false)
				pcall(function() humanoid:MoveTo(root.Position) end)
				RunServiceAS.Heartbeat:Wait()
			end
			if minigameQueuedAS() then
				return false
			end



			local started = os.clock()
			local nextLocalBreakAt = started + 0.45
			while os.clock() - started < 1.50 do
				humanoid.Sit = false
				humanoid.PlatformStand = false
				humanoid.AutoRotate = true
				humanoid:Move(Vector3.zero, false)
				pcall(function() humanoid:MoveTo(root.Position) end)

				local seat = humanoid.SeatPart
				local stillRobloxSeated = seat ~= nil and seat:IsDescendantOf(folder)
				local weld = customSeatWeldAS(root)
				if not stillRobloxSeated and not weld then
					if LocalPlayerAS:GetAttribute("Seated") == true then
						LocalPlayerAS:SetAttribute("Seated", false)
					end
					pcall(humanoid.ChangeState, humanoid, Enum.HumanoidStateType.Running)
					return true
				end

				if stillRobloxSeated then
					pcall(humanoid.ChangeState, humanoid, Enum.HumanoidStateType.GettingUp)
				else
					pcall(humanoid.ChangeState, humanoid, Enum.HumanoidStateType.Running)
				end

				if weld and os.clock() >= nextLocalBreakAt then
					nextLocalBreakAt = os.clock() + 0.20
					pcall(function()
						if weld.Parent == root then weld:Destroy() end
					end)
				end
				RunServiceAS.Heartbeat:Wait()
			end

			local seat = humanoid.SeatPart
			local stillRobloxSeated = seat ~= nil and seat:IsDescendantOf(folder)
			local weld = customSeatWeldAS(root)
			if weld then
				pcall(function()
					if weld.Parent == root then weld:Destroy() end
				end)
				weld = customSeatWeldAS(root)
			end
			if not stillRobloxSeated and not weld then
				if LocalPlayerAS:GetAttribute("Seated") == true then
					LocalPlayerAS:SetAttribute("Seated", false)
				end
				pcall(humanoid.ChangeState, humanoid, Enum.HumanoidStateType.Running)
				return true
			end
			return false
		end

		local function clearOrphanedQueueAS()



			if physicalCurrentTableAS() ~= nil or not minigameQueuedAS() then
				return not minigameQueuedAS()
			end
			local fired = pcall(function()
				MinigameLeaveQueueAS:FireServer()
			end)
			if not fired then return false end
			local deadline = os.clock() + 1.50
			while minigameQueuedAS() and os.clock() < deadline do
				RunServiceAS.Heartbeat:Wait()
			end
			return not minigameQueuedAS()
		end

		local function flatDistanceAS(a, b)
			return Vector3.new(a.X - b.X, 0, a.Z - b.Z).Magnitude
		end

		local function tableApproachPointAS(candidate, root)
			local seat = candidate and candidate.Seat
			local model = candidate and candidate.Model
			if not seat or not model or not root then return nil end



			if candidate._ApproachSeat == seat
				and typeof(candidate._ApproachPoint) == "Vector3"
			then
				local cached = candidate._ApproachPoint
				return Vector3.new(cached.X, root.Position.Y, cached.Z)
			end

			local look = Vector3.new(
				seat.CFrame.LookVector.X,
				0,
				seat.CFrame.LookVector.Z
			)
			local center = model:GetPivot().Position
			local towardTable = Vector3.new(
				center.X - seat.Position.X,
				0,
				center.Z - seat.Position.Z
			)




			if look.Magnitude < 0.01 then look = towardTable end
			if towardTable.Magnitude > 0.01 and look:Dot(towardTable) < 0 then
				look = -look
			end
			if look.Magnitude < 0.01 then return nil end
			look = look.Unit

			local point3 = seat.Position - look * TABLE_APPROACH_DISTANCE_AS
			local point = Vector3.new(point3.X, root.Position.Y, point3.Z)
			candidate._ApproachSeat = seat
			candidate._ApproachPoint = point
			return point
		end

		local function computePathAS(fromPosition, toPosition)
			local path = PathfindingServiceAS:CreatePath({
				AgentRadius = 2.35,
				AgentHeight = 5,
				AgentCanJump = true,
				AgentCanClimb = false,
				WaypointSpacing = PATH_WAYPOINT_SPACING_AS,
			})
			local ok = pcall(path.ComputeAsync, path, fromPosition, toPosition)
			if not ok or path.Status ~= Enum.PathStatus.Success then
				return nil, nil
			end
			local waypoints = path:GetWaypoints()
			if #waypoints == 0 then return nil, nil end
			return path, waypoints
		end

		local function straightRouteClearAS(fromPosition, toPosition)
			local _, _, root = characterPartsAS()
			if not root then return false end

			local flatDelta = Vector3.new(
				toPosition.X - fromPosition.X,
				0,
				toPosition.Z - fromPosition.Z
			)
			local distance = flatDelta.Magnitude
			if distance <= PATH_WAYPOINT_REACHED_AS then return true end
			if math.abs(toPosition.Y - fromPosition.Y) > 2.5 then return false end

			local rayParams = RaycastParams.new()
			rayParams.FilterType = Enum.RaycastFilterType.Exclude
			rayParams.FilterDescendantsInstances = {LocalPlayerAS.Character}
			rayParams.IgnoreWater = true

			local direction = flatDelta.Unit
			local lateral = Vector3.new(-direction.Z, 0, direction.X)
			local castVector = direction * distance


			for _, sideOffset in ipairs({0, 0.80, -0.80}) do
				local origin = fromPosition + lateral * sideOffset
				local hit = workspace:Raycast(origin, castVector, rayParams)
				if hit and hit.Instance and hit.Instance.CanCollide == true then
					return false
				end
			end


			local samples = math.max(1, math.ceil(distance / 6))
			for index = 1, samples do
				local alpha = index / samples
				local sample = fromPosition:Lerp(toPosition, alpha) + Vector3.new(0, 3, 0)
				local ground = workspace:Raycast(
					sample,
					Vector3.new(0, -10, 0),
					rayParams
				)
				if not ground or not ground.Instance or ground.Instance.CanCollide ~= true then
					return false
				end
			end
			return true
		end

		local function buildShortestRouteAS(fromPosition, toPosition)
			if straightRouteClearAS(fromPosition, toPosition) then
				return nil, {
					{
						Position = toPosition,
						Action = Enum.PathWaypointAction.Walk,
					},
				}
			end
			return computePathAS(fromPosition, toPosition)
		end

		local function joinedTargetAS(candidate)
			if not candidate or not candidate.Model or not candidate.Model.Parent then
				return false
			end



			if physicalCurrentTableAS() == candidate.Model then
				return true
			end

			local active = activeTableAS()
			return active == candidate.Model
				and (minigameQueuedAS() or minigamePlayingAS())
		end

		local function pausedAS()
			return autoServerHopState.Utility.PauseScript == true
				or autoServerHopState.Utility.PauseMinigameFeatures == true
				or autoServerHopState.RuntimeServerHopPending == true
		end

		local function walkCommittedAS(candidate)
			if pausedAS() then return false, "paused" end
			local valid, invalidReason = candidateStillAvailableAS(
				candidate,
				candidate.LockedAsPartner == true
			)
			if not valid then return false, invalidReason or "invalid" end

			local _, humanoid, root = characterPartsAS()
			if not humanoid or not root then return false, "character" end

			local destination = tableApproachPointAS(candidate, root)
			if not destination then return false, "invalid" end

			local originalAutoJump = humanoid.AutoJumpEnabled
			humanoid.AutoJumpEnabled = false

			local path
			local waypoints
			local waypointIndex = 1
			local blockedConnection
			local pathBlocked = false
			local repathCount = 0
			local activeTarget
			local lastProgressAt = os.clock()
			local nextProgressSample = os.clock()
			local lastSamplePosition = root.Position
			local lastSampleDistance = math.huge
			local slowSince
			local jumpActive = false
			local jumpObserveUntil = 0
			local jumpStartDistance = math.huge
			local jumpRearmAnchor
			local nextPartnerScan = 0
			local deadline = os.clock() + TABLE_MOVE_TIMEOUT_AS

			local function cleanup(stopMovement)
				if blockedConnection then
					blockedConnection:Disconnect()
					blockedConnection = nil
				end
				if humanoid.Parent then
					humanoid.AutoJumpEnabled = originalAutoJump
					if stopMovement then
						humanoid:Move(Vector3.zero, false)
						pcall(function() humanoid:MoveTo(root.Position) end)
					end
				end
			end

			local function forwardObstacleDetected(target)
				if typeof(target) ~= "Vector3" or not root.Parent then return false end
				local delta = Vector3.new(
					target.X - root.Position.X,
					0,
					target.Z - root.Position.Z
				)
				if delta.Magnitude < 0.05 then return false end

				local rayParams = RaycastParams.new()
				rayParams.FilterType = Enum.RaycastFilterType.Exclude
				rayParams.FilterDescendantsInstances = {LocalPlayerAS.Character}
				rayParams.IgnoreWater = true

				local direction = delta.Unit * math.min(3.75, delta.Magnitude)
				local lateral = Vector3.new(-delta.Unit.Z, 0, delta.Unit.X)
				for _, yOffset in ipairs({0, -1.25}) do
					for _, sideOffset in ipairs({0, 0.80, -0.80}) do
						local origin = root.Position
							+ Vector3.new(0, yOffset, 0)
							+ lateral * sideOffset
						local hit = workspace:Raycast(origin, direction, rayParams)
						if hit and hit.Instance and hit.Instance.CanCollide == true then


							if not (
								candidate.Model
								and hit.Instance:IsDescendantOf(candidate.Model)
								and flatDistanceAS(root.Position, candidate.Seat.Position)
									<= TABLE_PROMPT_CAPTURE_DISTANCE_AS
							) then
								return true
							end
						end
					end
				end
				return false
			end

			local function issueTarget(target)
				if activeTarget
					and target
					and flatDistanceAS(activeTarget, target) <= 0.05
				then
					return
				end
				activeTarget = target
				if activeTarget then
					humanoid:MoveTo(activeTarget)
				end
			end

			local function requestNavigationJumpAS(target)
				local okState, state = pcall(humanoid.GetState, humanoid)
				if okState and (
					state == Enum.HumanoidStateType.Freefall
					or state == Enum.HumanoidStateType.Jumping
					or state == Enum.HumanoidStateType.FallingDown
				) then
					return false
				end



				local changed = pcall(
					humanoid.ChangeState,
					humanoid,
					Enum.HumanoidStateType.Jumping
				)
				if not changed then
					return false
				end

				jumpActive = true
				jumpRearmAnchor = root.Position


				if typeof(target) == "Vector3" then
					activeTarget = target
					humanoid:MoveTo(target)
				elseif activeTarget then
					humanoid:MoveTo(activeTarget)
				end
				return true
			end

			local function sustainJumpMovementAS()
				if not jumpActive or not activeTarget or not root.Parent or not humanoid.Parent then
					return
				end

				local okState, state = pcall(humanoid.GetState, humanoid)
				local airborne = okState and (
					state == Enum.HumanoidStateType.Jumping
					or state == Enum.HumanoidStateType.Freefall
				)
				if not airborne then
					return
				end

				local delta = Vector3.new(
					activeTarget.X - root.Position.X,
					0,
					activeTarget.Z - root.Position.Z
				)
				if delta.Magnitude <= 0.05 then
					return
				end




				humanoid:Move(delta.Unit, false)
				pcall(function()
					humanoid:MoveTo(activeTarget)
				end)
			end

			local function rebuildPath()
				local newPath, newWaypoints = buildShortestRouteAS(
					root.Position,
					destination
				)
				if not newWaypoints or #newWaypoints == 0 then
					repathCount += 1
					return false
				end

				if blockedConnection then
					blockedConnection:Disconnect()
					blockedConnection = nil
				end

				path = newPath
				waypoints = newWaypoints
				waypointIndex = 1
				pathBlocked = false
				repathCount += 1

				if path then
					blockedConnection = path.Blocked:Connect(function(blockedIndex)
						if blockedIndex >= waypointIndex then
							pathBlocked = true
						end
					end)
				end

				local waypoint = waypoints[waypointIndex]
				if waypoint.Action == Enum.PathWaypointAction.Jump
					and not jumpRearmAnchor
				then
					requestNavigationJumpAS(waypoint.Position)
				end
				issueTarget(waypoint.Position)
				lastProgressAt = os.clock()
				lastSamplePosition = root.Position
				lastSampleDistance = flatDistanceAS(root.Position, waypoint.Position)
				return true
			end

			if not rebuildPath() then


				while repathCount <= PATH_REPATH_LIMIT_AS and os.clock() < deadline do
					if pausedAS() then
						cleanup(true)
						return false, "paused"
					end
					RunServiceAS.Heartbeat:Wait()
					if rebuildPath() then break end
				end
				if not waypoints then
					cleanup(false)
					return false, "unreachable"
				end
			end

			while screenGui.Parent and os.clock() < deadline do
				if pausedAS() then
					cleanup(true)
					return false, "paused"
				end
				local now = os.clock()



				sustainJumpMovementAS()

				if joinedTargetAS(candidate) then
					cleanup(false)
					return true, "joined"
				end





				if candidate.Prompt
					and candidate.Prompt.Parent
					and candidate.Prompt.Enabled
					and candidate.Seat
					and candidate.Seat.Parent
				then
					local maxActivation = tonumber(candidate.Prompt.MaxActivationDistance) or 10
					local captureDistance = math.min(
						TABLE_PROMPT_CAPTURE_DISTANCE_AS,
						math.max(0, maxActivation - 0.35)
					)
					local seatDistance = (root.Position - candidate.Seat.Position).Magnitude

					if seatDistance <= captureDistance then
						local captureDeadline = math.min(deadline, os.clock() + 0.65)
						local lastCaptureAttempt = -math.huge

						while screenGui.Parent and os.clock() < captureDeadline do
							if pausedAS() then
								cleanup(true)
								return false, "paused"
							end
							if joinedTargetAS(candidate) then
								cleanup(false)
								return true, "joined"
							end

							local captureValid, captureReason = candidateStillAvailableAS(
								candidate,
								candidate.LockedAsPartner == true
							)
							if not captureValid then
								cleanup(false)
								return false, captureReason or "claimed"
							end

							local seatedHere = physicalCurrentTableAS() == candidate.Model
							if seatedHere then
								activeTarget = nil
								humanoid:Move(Vector3.zero, false)
								pcall(function() humanoid:MoveTo(root.Position) end)
							else
								local liveCapturePoint = tableApproachPointAS(candidate, root)
								if liveCapturePoint
									and flatDistanceAS(root.Position, liveCapturePoint)
										> PATH_WAYPOINT_REACHED_AS
								then
									activeTarget = liveCapturePoint
									humanoid:MoveTo(liveCapturePoint)
								end
							end

							local livePrompt = candidate.Prompt
							local liveSeat = candidate.Seat
							local liveDistance = liveSeat
								and liveSeat.Parent
								and (root.Position - liveSeat.Position).Magnitude
								or math.huge
							local liveMax = livePrompt
								and tonumber(livePrompt.MaxActivationDistance)
								or 10

							if livePrompt
								and livePrompt.Parent
								and livePrompt.Enabled
								and liveDistance <= math.max(0, liveMax - 0.15)
								and os.clock() - lastCaptureAttempt >= 0.06
							then
								lastCaptureAttempt = os.clock()
								lastJoinAttemptAS = lastCaptureAttempt
								firePromptAS(livePrompt)
							end

							RunServiceAS.Heartbeat:Wait()
						end

						if joinedTargetAS(candidate) then
							cleanup(false)
							return true, "joined"
						end

						if physicalCurrentTableAS() == candidate.Model then
							cleanup(false)
							return true, "joined"
						end



						rebuildPath()
					end
				end

				local routeValid, routeReason = candidateStillAvailableAS(
					candidate,
					candidate.LockedAsPartner == true
				)
				if not routeValid then
					cleanup(false)
					return false, routeReason or "invalid"
				end




				if candidate.LockedAsPartner ~= true
					and autoSitState.OneOfTwo.Enabled == true
					and now >= nextPartnerScan
				then
					nextPartnerScan = now + 0.12
					local better = bestPartnerAS(candidate.Model)
					if better
						and better.Model ~= candidate.Model
						and candidateStillAvailableAS(better, true)
					then
						cleanup(false)
						return false, "preempted", better
					end
				end

				local waypoint = waypoints and waypoints[waypointIndex]
				if not waypoint then
					cleanup(false)
					return false, "unreachable"
				end

				local distanceToWaypoint = flatDistanceAS(root.Position, waypoint.Position)
				local distanceToDestination = flatDistanceAS(root.Position, destination)

				if distanceToDestination <= PATH_WAYPOINT_REACHED_AS then
					cleanup(false)
					return true, "reached"
				end

				if distanceToWaypoint <= PATH_WAYPOINT_REACHED_AS then
					waypointIndex += 1
					waypoint = waypoints[waypointIndex]
					if not waypoint then
						cleanup(false)
						return true, "reached"
					end

					if waypoint.Action == Enum.PathWaypointAction.Jump
						and not jumpRearmAnchor
					then
						requestNavigationJumpAS(waypoint.Position)
					end
					issueTarget(waypoint.Position)
					lastProgressAt = now
					lastSamplePosition = root.Position
					lastSampleDistance = flatDistanceAS(root.Position, waypoint.Position)
					slowSince = nil
					pathBlocked = false
					RunServiceAS.Heartbeat:Wait()
					continue
				end

				if now >= nextProgressSample then
					local moved = flatDistanceAS(root.Position, lastSamplePosition)
					local currentDistance = flatDistanceAS(root.Position, waypoint.Position)
					local progress = lastSampleDistance - currentDistance
					local velocity = root.AssemblyLinearVelocity
					local flatSpeed = Vector3.new(velocity.X, 0, velocity.Z).Magnitude
					local wallAhead = forwardObstacleDetected(waypoint.Position)

					if progress >= PATH_PROGRESS_GAIN_AS then
						lastProgressAt = now
						slowSince = nil
					elseif wallAhead
						and (
							flatSpeed < PATH_SLOW_SPEED_AS
							or moved < PATH_PROGRESS_GAIN_AS
						)
					then


						slowSince = now
					else

						slowSince = nil
					end

					if jumpRearmAnchor
						and flatDistanceAS(root.Position, jumpRearmAnchor)
							>= PATH_JUMP_REARM_DISTANCE_AS
					then
						jumpRearmAnchor = nil
					end

					lastSamplePosition = root.Position
					lastSampleDistance = currentDistance
					nextProgressSample = now + PATH_PROGRESS_SAMPLE_AS
				end



				if jumpObserveUntil > 0 and now >= jumpObserveUntil then
					jumpObserveUntil = 0
					local currentDistance = flatDistanceAS(root.Position, waypoint.Position)
					if jumpStartDistance - currentDistance < PATH_PROGRESS_GAIN_AS then
						if repathCount >= PATH_REPATH_LIMIT_AS then
							cleanup(false)
							return false, "unreachable"
						end


						rebuildPath()
					else
						lastProgressAt = now
					end
					jumpActive = false
					slowSince = nil
				end

				if slowSince
					and now - slowSince >= PATH_SLOW_DETECT_AS
					and jumpObserveUntil <= 0
				then
					slowSince = nil
					if jumpRearmAnchor then
						if repathCount >= PATH_REPATH_LIMIT_AS then
							cleanup(false)
							return false, "unreachable"
						end
						rebuildPath()
					else
						jumpStartDistance = flatDistanceAS(root.Position, waypoint.Position)
						jumpObserveUntil = now + PATH_POST_JUMP_OBSERVE_AS
						requestNavigationJumpAS(waypoint.Position)
					end
				elseif pathBlocked and jumpObserveUntil <= 0 then
					pathBlocked = false
					if repathCount >= PATH_REPATH_LIMIT_AS then
						cleanup(false)
						return false, "unreachable"
					end




					if waypoint
						and forwardObstacleDetected(waypoint.Position)
						and not jumpRearmAnchor
					then
						jumpStartDistance = flatDistanceAS(root.Position, waypoint.Position)
						jumpObserveUntil = now + PATH_POST_JUMP_OBSERVE_AS
						requestNavigationJumpAS(waypoint.Position)
					else
						rebuildPath()
					end
				elseif now - lastProgressAt >= PATH_REPATH_STALL_AS
					and jumpObserveUntil <= 0
				then


					lastProgressAt = now
					if repathCount >= PATH_REPATH_LIMIT_AS then
						cleanup(false)
						return false, "unreachable"
					end
					rebuildPath()
				end

				RunServiceAS.Heartbeat:Wait()
			end

			cleanup(false)
			return joinedTargetAS(candidate), "timeout"
		end

		local function joinCandidateAS(candidate)
			if pausedAS()
				or routeBusyAS
				or autoServerHopState.RuntimeBoothMutationBusy == true
				or not candidate
			then
				return false
			end


			routeBusyAS = true
			autoServerHopState.RuntimeAutoSitBusy = true

			local joined = false
			local target = candidate

			local ok = pcall(function()
				for _ = 1, 6 do
					if pausedAS() or not target or minigamePlayingAS() or negotiationActiveAS() then
						return
					end

					local reached, reason, replacement = walkCommittedAS(target)

					if reason == "preempted" and replacement then


						target = replacement
						continue
					end

					if not reached then
						if reason == "partner_closed"
							or reason == "target_closed"
							or reason == "claimed"
						then


							target = bestTargetAS(target.Model)
							continue
						end


						if reason == "unreachable" or reason == "timeout" then
							continue
						end
						return
					end

					local valid = candidateStillAvailableAS(
						target,
						target.LockedAsPartner == true
					)
					if not valid then
						target = bestTargetAS(target.Model)
						continue
					end




					local promptDeadline = os.clock() + 1.25
					while os.clock() < promptDeadline do
						if pausedAS() then return end
						if joinedTargetAS(target) then
							joined = true
							break
						end

						if target.Prompt
							and target.Prompt.Parent
							and target.Prompt.Enabled
							and os.clock() - lastJoinAttemptAS >= 0.10
						then
							lastJoinAttemptAS = os.clock()
							firePromptAS(target.Prompt)
						end
						RunServiceAS.Heartbeat:Wait()
					end

					if joinedTargetAS(target) then
						joined = true
					end

					if joined then
						lastObservedPhysicalTableAS = target.Model
						if target.Model ~= blockedPreviousTableAS then
							blockedPreviousTableAS = nil
						end




						local ackDeadline = os.clock() + 4.0
						while screenGui.Parent
							and not pausedAS()
							and physicalCurrentTableAS() == target.Model
							and not minigameQueuedAS()
							and os.clock() < ackDeadline
						do
							RunServiceAS.Heartbeat:Wait()
						end
						return
					end



				end
			end)

			routeBusyAS = false
			autoServerHopState.RuntimeAutoSitBusy = false
			return ok and joined
		end

		local function switchToPartnerAS(currentModel, candidate)
			if pausedAS()
				or routeBusyAS
				or autoServerHopState.RuntimeBoothMutationBusy == true
				or not currentModel
				or not candidate
				or currentModel == candidate.Model
			then
				return false
			end




			if not minigameQueuedAS() then
				return false
			end

			local valid = candidateStillAvailableAS(candidate, true)
			if not valid then return false end

			routeBusyAS = true
			autoServerHopState.RuntimeAutoSitBusy = true
			local switched = false

			local ok = pcall(function()
				if pausedAS() then return end
				blockedPreviousTableAS = currentModel


				candidate.LockedAsPartner = true
				if not candidateStillAvailableAS(candidate, true) then return end
				if not releaseCurrentSeatAS(currentModel) then return end

				local target = candidate
				for _ = 1, 5 do
					if pausedAS() then return end
					if not candidateStillAvailableAS(target, true) then



						target = bestTargetAS(currentModel)
						if not target then return end
					end

					local reached, reason, replacement = walkCommittedAS(target)
					if reason == "preempted" and replacement then
						target = replacement
						continue
					end
					if not reached then
						if reason == "partner_closed"
							or reason == "target_closed"
							or reason == "claimed"
						then
							target = bestTargetAS(currentModel)
							continue
						end


						continue
					end

					local promptDeadline = os.clock() + 1.25
					while os.clock() < promptDeadline do
						if pausedAS() then return end
						if joinedTargetAS(target) then
							switched = true
							break
						end
						if target.Prompt
							and target.Prompt.Parent
							and target.Prompt.Enabled
							and os.clock() - lastJoinAttemptAS >= 0.10
						then
							lastJoinAttemptAS = os.clock()
							firePromptAS(target.Prompt)
						end
						RunServiceAS.Heartbeat:Wait()
					end

					if joinedTargetAS(target) then
						switched = true
					end
					if switched then
						lastObservedPhysicalTableAS = target.Model
						if target.Model ~= blockedPreviousTableAS then
							blockedPreviousTableAS = nil
						end

						local ackDeadline = os.clock() + 4.0
						while screenGui.Parent
							and not pausedAS()
							and physicalCurrentTableAS() == target.Model
							and not minigameQueuedAS()
							and os.clock() < ackDeadline
						do
							RunServiceAS.Heartbeat:Wait()
						end
						return
					end
				end
			end)

			routeBusyAS = false
			autoServerHopState.RuntimeAutoSitBusy = false
			return ok and switched
		end

		local function schedulerStepAS()
			if autoServerHopState.Utility.PauseScript ~= true
				and os.clock()
					- (tonumber(autoServerHopState.RuntimePresenceStartedAt) or 0)
					< 1.25
			then
				return
			end
			if autoServerHopState.Utility.PauseScript == true
			or autoServerHopState.Utility.PauseMinigameFeatures == true
				or autoServerHopState.RuntimeServerHopPending == true
				or autoServerHopState.RuntimeBoothMutationBusy == true
			then
				return
			end
			local emptyEnabled = autoSitState
				and autoSitState.EmptyTables
				and autoSitState.EmptyTables.Enabled == true
			local partnerEnabled = autoSitState
				and autoSitState.OneOfTwo
				and autoSitState.OneOfTwo.Enabled == true
			if not emptyEnabled and not partnerEnabled then return end
			if routeBusyAS or minigamePlayingAS() or negotiationActiveAS() then return end

			local current = physicalCurrentTableAS()
			local queued = minigameQueuedAS()

			if current then
				lastObservedPhysicalTableAS = current
			elseif lastObservedPhysicalTableAS then
				blockedPreviousTableAS = lastObservedPhysicalTableAS
				lastObservedPhysicalTableAS = nil
			end




			if queued and not current then
				local orphanedTable = activeTableAS()
				if orphanedTable then
					blockedPreviousTableAS = orphanedTable
				end
				if clearOrphanedQueueAS() then
					queued = false
				else
					return
				end
			end

			if current or queued then
				if current and queued then
					local currentCount = replicatedTablePlayerCountAS(current)
					local currentPartner = waitingPartnerAtTableAS(current, currentCount)
					if currentPartner and isBlacklistedAS(currentPartner) then
						releaseCurrentSeatAS(current)
						return
					end
				end
				if partnerEnabled and current and queued then
					local currentCount = replicatedTablePlayerCountAS(current)
					local currentPartner = waitingPartnerAtTableAS(current, currentCount)
					if not currentPartner then
						local better = bestPartnerAS(current)
						if better then
							switchToPartnerAS(current, better)
						end
					end
				end
				return
			end

			local target = bestTargetAS(nil)
			if target then
				joinCandidateAS(target)
			end
		end

		while screenGui.Parent do
			RunServiceAS.Heartbeat:Wait()
			local utility = autoServerHopState.Utility
			local emptyEnabled = autoSitState
				and autoSitState.EmptyTables
				and autoSitState.EmptyTables.Enabled == true
			local partnerEnabled = autoSitState
				and autoSitState.OneOfTwo
				and autoSitState.OneOfTwo.Enabled == true
			if utility.PauseScript == true
				or utility.PauseMinigameFeatures == true
				or autoServerHopState.RuntimeServerHopPending == true
				or autoServerHopState.RuntimeBoothMutationBusy == true
				or (not emptyEnabled and not partnerEnabled)
			then
				continue
			end
			local okStep = pcall(schedulerStepAS)
			if not okStep then

				task.wait(0.05)
			end
		end
	end)
end










if IS_MINIGAME_PLACE then
	task.spawn(function()
		while screenGui.Parent
			and not (
				autoServerHopState.Utility.PauseScript ~= true
				and autoServerHopState.Utility.PauseMinigameFeatures ~= true
				and autoServerHopState.Utility.AutoCancelMaster == true
			)
		do
			task.wait(0.10)
		end
		if not screenGui.Parent then return end

		local PlayersAC = game:GetService("Players")
		local RSAC = game:GetService("ReplicatedStorage")
		local RunServiceAC = game:GetService("RunService")
		local LocalPlayerAC = PlayersAC.LocalPlayer
		local SharedAC = RSAC:WaitForChild("Shared")
		local ClientAC = RSAC:WaitForChild("Client")

		local function requireAC(moduleScript)
			while screenGui.Parent do
				local ok, result = pcall(require, moduleScript)
				if ok and result ~= nil then return result end
				task.wait(0.25)
			end
		end

		local EconomyMathAC = requireAC(SharedAC:WaitForChild("utils"):WaitForChild("EconomyMath"))
		local ReplicatorAC = requireAC(ClientAC:WaitForChild("Modules"):WaitForChild("ReplicatorClient"))
		local RemotesAC = requireAC(SharedAC:WaitForChild("Remotes"))
		if not (EconomyMathAC and ReplicatorAC and RemotesAC) then return end

		local DeclineAC = RemotesAC.NegotiationDecline
		local LeaveQueueAC = RemotesAC.MinigameLeaveQueue
		local ActiveNegotiationAC
		local ActiveMinigameAC
		local lastDeclineGuidAC
		local lastDeclineAtAC = 0
		local lastQueueLeaveAtAC = 0
		local trackedGuidAC
		local tradeStartedAtAC = 0
		local noValueSinceAC
		local brainrotMismatchSinceAC
		local autoCancelWasActiveAC = false

		local function refreshAC()
			local negotiation, minigame
			pcall(function() negotiation = ReplicatorAC.get("ActiveNegotiation") end)
			pcall(function() minigame = ReplicatorAC.get("ActiveMinigame") end)
			if negotiation ~= nil then ActiveNegotiationAC = negotiation end
			if minigame ~= nil then ActiveMinigameAC = minigame end
		end

		local function tryAC(root, path)
			if not root then return nil end
			local ok, value = pcall(function() return root:TryIndex(path) end)
			return ok and value or nil
		end

		local function guidAC()
			refreshAC()
			return tryAC(ActiveNegotiationAC, {"guid"})
		end

		local function queuedAC()
			refreshAC()
			local value = tryAC(ActiveMinigameAC, {"queued"})
			if value ~= nil then return value == true end
			local ok, direct = pcall(function()
				return ActiveMinigameAC and ActiveMinigameAC.Data and ActiveMinigameAC.Data.queued
			end)
			return ok and direct == true
		end

		local function replicatedOpponentAC()
			refreshAC()
			local opponent = tryAC(ActiveNegotiationAC, {"player2", "player"})
			if typeof(opponent) == "Instance"
				and opponent:IsA("Player")
				and opponent ~= LocalPlayerAC
			then
				return opponent
			end
			opponent = tryAC(ActiveMinigameAC, {"session", "private", "opponent"})
			return typeof(opponent) == "Instance"
				and opponent:IsA("Player")
				and opponent ~= LocalPlayerAC
				and opponent or nil
		end

		local function tableFolderAC()
			local gameObjects = workspace:FindFirstChild("GameObjects")
			local placeSpecific = gameObjects and gameObjects:FindFirstChild("PlaceSpecific")
			local tradePlaza = placeSpecific and placeSpecific:FindFirstChild("trade_plaza")
			return tradePlaza and tradePlaza:FindFirstChild("MinigameTables")
		end

		local function physicalTableAC(player)
			local folder = tableFolderAC()
			local character = player and player.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local root = character and character:FindFirstChild("HumanoidRootPart")
			if not folder then return nil end
			if humanoid and humanoid.SeatPart and humanoid.SeatPart:IsDescendantOf(folder) then
				return humanoid.SeatPart:FindFirstAncestor("Table")
			end
			local weld = root and root:FindFirstChild("CustomSeatWeld")
			if weld then
				for _, propertyName in ipairs({"Part0", "Part1"}) do
					local part
					pcall(function() part = weld[propertyName] end)
					if part and part:IsDescendantOf(folder) then
						return part:FindFirstAncestor("Table")
					end
				end
			end
		end

		local function physicalOpponentAC()
			local myTable = physicalTableAC(LocalPlayerAC)
			if not myTable then return nil end
			for _, player in ipairs(PlayersAC:GetPlayers()) do
				if player ~= LocalPlayerAC and physicalTableAC(player) == myTable then
					return player
				end
			end
		end

		local function isBlacklistedAC(player)
			if typeof(player) ~= "Instance" or not player:IsA("Player") then return false end
			local userId = tostring(player.UserId)
			local utility = autoServerHopState.Utility
			if utility.TempBlacklistPlayersAfterCanceledTrade == true then
				local temporary = autoServerHopState.RuntimeTempBlacklistedUserIds
				if type(temporary) == "table" and temporary[userId] == true then return true end
			end
			if utility.PermanentBlacklistPlayersAfterCanceledTrade == true then
				local permanent = utility.PermanentBlacklistedUserIds
				if type(permanent) == "table" and permanent[userId] == true then return true end
			end
			return false
		end

		local function tempBlacklistAC(userId)
			local record = autoServerHopState.RecordCanceledTrade
			if type(record) == "function" then
				record(userId)
			end
		end

		local function categoryAC(tool)
			if not tool or not tool:IsA("Tool") then return nil end
			local name = tool:GetAttribute("BrainrotName")
			if type(name) ~= "string" or name == "" then return nil end
			local explicit = tool:GetAttribute("Rarity") or tool:GetAttribute("BrainrotRarity")
			if explicit == "Meta" then return "Meta" end

			local rarity = type(explicit) == "string" and explicit or nil
			if not rarity then
				pcall(function() rarity = EconomyMathAC.GetBrainrotRarity(name) end)
			end
			local metaMarked = tool:GetAttribute("Meta") == true
				or tool:GetAttribute("IsMeta") == true
				or string.find(string.lower(name), "%f[%a]meta%f[%A]") ~= nil
			return rarity == "Infinity" and metaMarked and "Meta" or rarity
		end

		local function selectedCriteriaAC()
			local criteria = {}
			for _, rarity in ipairs(RARITY_OPTIONS) do
				if autoCancelState.Targets[rarity] == true then
					criteria[#criteria + 1] = {
						Rarity = rarity,
						Amount = rarity == "Tokens"
							and math.clamp(
								math.floor(tonumber(autoCancelState.Tokens) or 1),
								1, 100000
							)
							or math.clamp(
								math.floor(tonumber(autoCancelState.Amounts and autoCancelState.Amounts[rarity]) or 1),
								1, 100
							),
					}
				end
			end
			return criteria
		end

		local function opponentMatchesAnyAC(player, criteria)
			if not player or #criteria == 0 then return true end
			local counts = {}
			local seenTools = {}
			local needsTokens = false
			local function scan(container)
				if not container then return end
				for _, tool in ipairs(container:GetChildren()) do
					if tool:IsA("Tool") and not seenTools[tool] then
						seenTools[tool] = true
						local rarity = categoryAC(tool)
						if rarity then counts[rarity] = (counts[rarity] or 0) + 1 end
					end
				end
			end
			scan(player:FindFirstChildOfClass("Backpack"))
			scan(player.Character)

			local opponentTokens
			for _, criterion in ipairs(criteria) do
				if criterion.Rarity == "Tokens" then
					needsTokens = true
					if opponentTokens == nil then
						refreshAC()
						opponentTokens = tonumber(
							tryAC(ActiveNegotiationAC, {"player2", "tradeTokens"})
						)
					end
					if opponentTokens ~= nil and opponentTokens >= criterion.Amount then
						return true
					end
				elseif (counts[criterion.Rarity] or 0) >= criterion.Amount then
					return true
				end
			end


			if needsTokens and opponentTokens == nil then return nil end
			return false
		end

		local function opponentHasValueAC()
			refreshAC()
			if math.max(0, math.floor(tonumber(
				tryAC(ActiveNegotiationAC, {"player2", "currency"})
			) or 0)) > 0 then
				return true
			end

			local slots = tryAC(ActiveNegotiationAC, {"player2", "slots"})
			if type(slots) ~= "table" then return false end
			for slotIndex = 1, 6 do
				local value = slots[tostring(slotIndex)]
				if value == nil then value = slots[slotIndex] end
				local id = type(value) == "table" and value.id or value
				if id ~= nil and id ~= false and tostring(id) ~= "" then
					return true
				end
			end
			return false
		end

		local function declineAC(expectedGuid, opponentUserId)
			if not DeclineAC or guidAC() ~= expectedGuid then return false end
			local ok = pcall(function() DeclineAC:FireServer() end)
			if not ok then return false end
			local deadline = os.clock() + 2.00
			while screenGui.Parent and guidAC() == expectedGuid and os.clock() < deadline do
				RunServiceAC.Heartbeat:Wait()
			end
			local canceled = guidAC() ~= expectedGuid
			if canceled then tempBlacklistAC(opponentUserId) end
			return canceled
		end

		local function leaveQueueAC(opponentUserId)
			if not LeaveQueueAC or not queuedAC() or os.clock() - lastQueueLeaveAtAC < 0.50 then
				return false
			end
			lastQueueLeaveAtAC = os.clock()
			local ok = pcall(function() LeaveQueueAC:FireServer() end)
			if ok then tempBlacklistAC(opponentUserId) end
			return ok
		end

		local function requestDeclineAC(guid)
			local opponent = replicatedOpponentAC() or physicalOpponentAC()
			local opponentUserId = opponent and opponent.UserId or nil
			if guid ~= nil then
				if lastDeclineGuidAC ~= guid or os.clock() - lastDeclineAtAC >= 0.50 then
					lastDeclineGuidAC = guid
					lastDeclineAtAC = os.clock()
					task.spawn(declineAC, guid, opponentUserId)
				end
			elseif queuedAC() then
				task.spawn(leaveQueueAC, opponentUserId)
			end
		end

		while screenGui.Parent do
			RunServiceAC.Heartbeat:Wait()
			local utilityAC = autoServerHopState.Utility
			local autoCancelActive =
				utilityAC.PauseScript ~= true
				and utilityAC.PauseMinigameFeatures ~= true
				and utilityAC.AutoCancelMaster == true
			if not autoCancelActive then
				if autoCancelWasActiveAC then
					trackedGuidAC = nil
					tradeStartedAtAC = 0
					noValueSinceAC = nil
					brainrotMismatchSinceAC = nil
					lastDeclineGuidAC = nil
					autoCancelWasActiveAC = false
				end
				continue
			end
			autoCancelWasActiveAC = true

			local now = os.clock()
			local guid = guidAC()
			if guid ~= trackedGuidAC then
				trackedGuidAC = guid
				tradeStartedAtAC = guid and now or 0
				noValueSinceAC = guid and now or nil
				brainrotMismatchSinceAC = nil
				lastDeclineGuidAC = nil
			end

			local shouldCancel = false
			local currentOpponentAC = replicatedOpponentAC() or physicalOpponentAC()
			if currentOpponentAC and isBlacklistedAC(currentOpponentAC) then
				shouldCancel = true
			end

			if not shouldCancel and utilityAC.AutoCancelCheckOpponentsBrainrots == true then
				local criteria = selectedCriteriaAC()
				local opponent = currentOpponentAC
				if #criteria > 0
					and opponent
					and opponentMatchesAnyAC(opponent, criteria) == false
				then
					brainrotMismatchSinceAC = brainrotMismatchSinceAC or now
					local delayBeforeCancel = math.clamp(
						tonumber(utilityAC.AutoCancelBrainrotConditionDelay) or 0,
						0,
						30
					)
					if now - brainrotMismatchSinceAC >= delayBeforeCancel then
						shouldCancel = true
					end
				else
					brainrotMismatchSinceAC = nil
				end
			else
				brainrotMismatchSinceAC = nil
			end

			if guid ~= nil and not shouldCancel then
				if utilityAC.AutoCancelTradeTimeoutEnabled == true then
					local limit = math.clamp(
						math.floor(tonumber(utilityAC.AutoCancelTradeTimeout) or 60),
						1, 60
					)
					if tradeStartedAtAC > 0 and now - tradeStartedAtAC >= limit then
						shouldCancel = true
					end
				end

				if utilityAC.AutoCancelNoValueTimeoutEnabled == true and not shouldCancel then
					if opponentHasValueAC() then
						noValueSinceAC = nil
					else
						noValueSinceAC = noValueSinceAC or now
						local limit = math.clamp(
							math.floor(tonumber(utilityAC.AutoCancelNoValueTimeout) or 15),
							1, 30
						)
						if now - noValueSinceAC >= limit then
							shouldCancel = true
						end
					end
				else
					noValueSinceAC = nil
				end
			end

			if shouldCancel then
				requestDeclineAC(guid)
			elseif guid ~= lastDeclineGuidAC then
				lastDeclineGuidAC = nil
			end
		end
	end)
end








if IS_MINIGAME_PLACE then
	task.spawn(function()
		while screenGui.Parent
			and autoServerHopState.Utility.TempBlacklistPlayersAfterCanceledTrade ~= true
			and autoServerHopState.Utility.PermanentBlacklistPlayersAfterCanceledTrade ~= true
		do
			task.wait(0.10)
		end
		if not screenGui.Parent then return end

		local RSBL = game:GetService("ReplicatedStorage")
		local PlayersBL = game:GetService("Players")
		local LocalPlayerBL = PlayersBL.LocalPlayer
		local function requireBL(moduleScript)
			while screenGui.Parent do
				local ok, result = pcall(require, moduleScript)
				if ok and result ~= nil then return result end
				task.wait(0.25)
			end
		end
		local ReplicatorBL = requireBL(
			RSBL:WaitForChild("Client"):WaitForChild("Modules"):WaitForChild("ReplicatorClient")
		)
		if not ReplicatorBL then return end

		local trackedGuidBL
		local negotiationOpponentUserIdBL
		local lifecycleOpponentUserIdBL
		local wasLifecycleBL = false
		local sawSelectionBL = false
		local sawPlayingBL = false
		local blacklistTrackingActiveBL = false

		local function getBL(name)
			local object
			pcall(function() object = ReplicatorBL.get(name) end)
			return object
		end

		local function tryBL(root, path)
			if not root then return nil end
			local ok, value = pcall(function() return root:TryIndex(path) end)
			return ok and value or nil
		end

		local function opponentUserIdBL(negotiation, active)
			local opponent = tryBL(negotiation, {"player2", "player"})
			if not (typeof(opponent) == "Instance" and opponent:IsA("Player")) then
				opponent = tryBL(active, {"session", "private", "opponent"})
			end
			if typeof(opponent) == "Instance"
				and opponent:IsA("Player")
				and opponent ~= LocalPlayerBL
			then
				return opponent.UserId
			end
		end

		local function tempBlacklistBL(userId)
			local record = autoServerHopState.RecordCanceledTrade
			if type(record) == "function" then
				record(userId)
			end
		end

		local function minigameTransitionActiveBL()
			local active = getBL("ActiveMinigame")



			return tryBL(active, {"queued"}) == true
				or tryBL(active, {"session", "gameId"}) ~= nil
				or type(tryBL(active, {"voting"})) == "table"
		end

		while screenGui.Parent do
			task.wait(0.05)
			if autoServerHopState.Utility.PauseScript == true
			or autoServerHopState.Utility.PauseMinigameFeatures == true
				or (
					autoServerHopState.Utility.TempBlacklistPlayersAfterCanceledTrade ~= true
					and autoServerHopState.Utility.PermanentBlacklistPlayersAfterCanceledTrade ~= true
				)
			then
				if blacklistTrackingActiveBL then
					trackedGuidBL = nil
					negotiationOpponentUserIdBL = nil
					lifecycleOpponentUserIdBL = nil
					wasLifecycleBL = false
					sawSelectionBL = false
					sawPlayingBL = false
					blacklistTrackingActiveBL = false
				end
				continue
			end
			blacklistTrackingActiveBL = true

			local negotiation = getBL("ActiveNegotiation")
			local active = getBL("ActiveMinigame")
			local guid = tryBL(negotiation, {"guid"})
			local opponentUserId = opponentUserIdBL(negotiation, active)
			local queued = tryBL(active, {"queued"}) == true
			local phase = tryBL(active, {"phase"})
			local gameId = tryBL(active, {"session", "gameId"})
			local voting = tryBL(active, {"voting"})

			if guid ~= nil then
				if trackedGuidBL ~= guid then
					trackedGuidBL = guid
					negotiationOpponentUserIdBL = opponentUserId
				elseif opponentUserId ~= nil then
					negotiationOpponentUserIdBL = opponentUserId
				end
			elseif trackedGuidBL ~= nil then
				local endedOpponentUserId = negotiationOpponentUserIdBL
				trackedGuidBL = nil
				negotiationOpponentUserIdBL = nil



				task.delay(0.75, function()
					if screenGui.Parent
						and autoServerHopState.Utility.PauseScript ~= true
						and autoServerHopState.Utility.PauseMinigameFeatures ~= true
						and (
							autoServerHopState.Utility.TempBlacklistPlayersAfterCanceledTrade == true
							or autoServerHopState.Utility.PermanentBlacklistPlayersAfterCanceledTrade == true
						)
						and not minigameTransitionActiveBL()
					then
						tempBlacklistBL(endedOpponentUserId)
					end
				end)
			end

			local lifecycle = guid ~= nil
				or queued
				or phase ~= nil
				or gameId ~= nil
				or type(voting) == "table"
			if lifecycle then
				wasLifecycleBL = true
				if opponentUserId ~= nil then
					lifecycleOpponentUserIdBL = opponentUserId
				end
				if phase ~= nil or gameId ~= nil or type(voting) == "table" then
					sawSelectionBL = true
				end
				if phase == "Playing" and gameId ~= nil then
					sawPlayingBL = true
				end
			elseif wasLifecycleBL then


				if sawSelectionBL and not sawPlayingBL then
					tempBlacklistBL(lifecycleOpponentUserIdBL)
				end
				lifecycleOpponentUserIdBL = nil
				wasLifecycleBL = false
				sawSelectionBL = false
				sawPlayingBL = false
			end
		end
	end)
end












if IS_MINIGAME_PLACE then
	task.spawn(function()
		local PlayersSP = game:GetService("Players")
		local HttpServiceSP = game:GetService("HttpService")
		local LocalPlayerSP = PlayersSP.LocalPlayer

		autoServerHopState.RuntimePresencePlayerSeenAt =
			autoServerHopState.RuntimePresencePlayerSeenAt or {}
		for _, player in ipairs(PlayersSP:GetPlayers()) do
			if player ~= LocalPlayerSP then
				autoServerHopState.RuntimePresencePlayerSeenAt[
					tostring(player.UserId)
				] = os.clock()
			end
		end




		local oldStopSP = rawget(_G, "__TUFFHUB_PRESENCE_STOP")
		if type(oldStopSP) == "function" then pcall(oldStopSP) end
		rawset(_G, "__TUFFHUB_PRESENCE_STOP", nil)

		local function hash32SP(value, seed)
			local h = seed or 5381
			value = tostring(value or "")
			for i = 1, #value do
				h = (h * 33 + string.byte(value, i)) % 4294967296
			end
			return string.format("%08x", h)
		end

		local materialSP = "THP10|" .. tostring(game.PlaceId) .. "|" .. tostring(game.JobId) .. "|8f31c6"
		local serverKeySP = hash32SP(materialSP, 5381) .. hash32SP(materialSP, 2166136261)
		local roomSP = "thp10-" .. serverKeySP
		local heartbeatEverySP = 0.75
		local staleAfterMsSP = 8000
		local reconnectEverySP = 0.75

		local identityKeySP = "__TUFFHUB_PRESENCE_IDENTITY"
		local identitySP = rawget(_G, identityKeySP)
		if type(identitySP) ~= "table"
			or identitySP.jobId ~= tostring(game.JobId)
			or tonumber(identitySP.userId) ~= tonumber(LocalPlayerSP.UserId)
		then
			local seen = {}
			for _, player in ipairs(PlayersSP:GetPlayers()) do
				if player ~= LocalPlayerSP then
					seen[tostring(player.UserId)] = true
				end
			end
			local createdAt = math.floor(workspace:GetServerTimeNow() * 1000)
			identitySP = {
				jobId = tostring(game.JobId),
				userId = tonumber(LocalPlayerSP.UserId),
				startedMs = createdAt,
				instanceId = tostring(createdAt) .. "-" .. tostring(math.random(100000000, 999999999)),
				seenAtStart = seen,
			}
			rawset(_G, identityKeySP, identitySP)
		elseif type(identitySP.seenAtStart) ~= "table" then
			identitySP.seenAtStart = {}
			for _, player in ipairs(PlayersSP:GetPlayers()) do
				if player ~= LocalPlayerSP then
					identitySP.seenAtStart[tostring(player.UserId)] = true
				end
			end
		end

		local startedMsSP = tonumber(identitySP.startedMs) or math.floor(workspace:GetServerTimeNow() * 1000)
		local instanceIdSP = tostring(identitySP.instanceId or (tostring(startedMsSP) .. "-" .. tostring(math.random(100000000, 999999999))))
		identitySP.startedMs = startedMsSP
		identitySP.instanceId = instanceIdSP

		local function enabledSP()
			return screenGui.Parent
				and autoServerHopState.Utility.PauseScript ~= true
		end

		local function playerStillHereSP(userId)
			userId = tonumber(userId)
			if not userId then return false end
			for _, player in ipairs(PlayersSP:GetPlayers()) do
				if tonumber(player.UserId) == userId then return true end
			end
			return false
		end

		local function markScriptUserSP(userId)
			userId = tonumber(userId)
			if not userId
				or userId == tonumber(LocalPlayerSP.UserId)
				or not playerStillHereSP(userId)
			then
				return false
			end
			autoServerHopState.RuntimeScriptUserIds =
				autoServerHopState.RuntimeScriptUserIds or {}
			autoServerHopState.RuntimeScriptUserIds[tostring(userId)] = true
			return true
		end

		local function encodeSeenSP()
			local list = {}
			for userId in pairs(identitySP.seenAtStart or {}) do
				if tonumber(userId) then list[#list + 1] = tostring(userId) end
			end
			table.sort(list)
			return table.concat(list, ",")
		end
		local localSeenStringSP = encodeSeenSP()

		local function parseSeenSP(value)
			local set = {}
			if type(value) ~= "string" then return set end
			for id in string.gmatch(value, "%d+") do set[id] = true end
			return set
		end

		local function shouldYieldSP(remoteUserId, remoteStartedMs, remoteInstanceId, remoteSeen)
			remoteUserId = tonumber(remoteUserId)
			remoteStartedMs = tonumber(remoteStartedMs)
			remoteInstanceId = tostring(remoteInstanceId or "")
			if not remoteUserId
				or remoteUserId == tonumber(LocalPlayerSP.UserId)
				or not remoteStartedMs
				or remoteInstanceId == ""
				or not playerStillHereSP(remoteUserId)
			then
				return false
			end

			local localSawRemote = identitySP.seenAtStart
				and identitySP.seenAtStart[tostring(remoteUserId)] == true
			local remoteSawLocal = type(remoteSeen) == "table"
				and remoteSeen[tostring(LocalPlayerSP.UserId)] == true
			if localSawRemote ~= remoteSawLocal then
				return localSawRemote
			end

			if remoteStartedMs ~= startedMsSP then return remoteStartedMs < startedMsSP end
			if remoteUserId ~= tonumber(LocalPlayerSP.UserId) then
				return remoteUserId < tonumber(LocalPlayerSP.UserId)
			end
			return remoteInstanceId < instanceIdSP
		end

		local function heartbeatTableSP(extra)
			local data = {
				t = "thp10",
				k = serverKeySP,
				uid = tonumber(LocalPlayerSP.UserId),
				name = tostring(LocalPlayerSP.Name),
				start = startedMsSP,
				iid = instanceIdSP,
				seen = localSeenStringSP,
				ts = math.floor(workspace:GetServerTimeNow() * 1000),
			}
			if type(extra) == "table" then
				for key, value in pairs(extra) do data[key] = value end
			end
			return data
		end

		local function decodePresenceSP(message)
			if type(message) ~= "string" or message == "" then return nil end
			local decoded
			local ok = pcall(function() decoded = HttpServiceSP:JSONDecode(message) end)
			if not ok or type(decoded) ~= "table" then return nil end
			if decoded.t ~= "thp10" or tostring(decoded.k or "") ~= serverKeySP then return nil end
			local remoteUserId = tonumber(decoded.uid)
			local remoteStarted = tonumber(decoded.start)
			local remoteId = decoded.iid and tostring(decoded.iid) or nil
			local remoteTs = tonumber(decoded.ts)
			if not remoteUserId or not remoteStarted or not remoteId or not remoteTs then return nil end
			local nowMs = math.floor(workspace:GetServerTimeNow() * 1000)
			if remoteTs > nowMs + 5000 or nowMs - remoteTs > staleAfterMsSP then return nil end
			return remoteUserId, remoteStarted, remoteId, parseSeenSP(decoded.seen)
		end

		local envsSP = {}
		local function addEnvSP(env)
			if type(env) ~= "table" then return end
			for _, existing in ipairs(envsSP) do
				if existing == env then return end
			end
			envsSP[#envsSP + 1] = env
		end
		addEnvSP(_G)
		pcall(function() if getgenv then addEnvSP(getgenv()) end end)
		pcall(function() if getrenv then addEnvSP(getrenv()) end end)
		pcall(function() if getfenv then addEnvSP(getfenv(0)) end end)

		local connectorsSP = {}
		local connectorSeenSP = {}
		local inspectedSocketTablesSP = {}
		local function addConnectorSP(fn)
			if type(fn) ~= "function" or connectorSeenSP[fn] then return end
			connectorSeenSP[fn] = true
			connectorsSP[#connectorsSP + 1] = fn
		end
		local function inspectSocketTableSP(value)
			if type(value) ~= "table" or inspectedSocketTablesSP[value] then return end
			inspectedSocketTablesSP[value] = true
			local ok, fn = pcall(function() return value.connect end)
			if ok then addConnectorSP(fn) end
			ok, fn = pcall(function() return value.Connect end)
			if ok then addConnectorSP(fn) end
			ok, fn = pcall(function() return value.websocket end)
			if ok and type(fn) == "table" then inspectSocketTableSP(fn) end
			ok, fn = pcall(function() return value.WebSocket end)
			if ok and type(fn) == "table" then inspectSocketTableSP(fn) end
		end
		for _, env in ipairs(envsSP) do
			for _, key in ipairs({"WebSocket", "websocket", "Websocket", "WS", "ws", "syn", "Krnl", "krnl", "Delta", "delta"}) do
				local ok, value = pcall(function() return env[key] end)
				if ok and type(value) == "table" then inspectSocketTableSP(value) end
			end
			for _, key in ipairs({"websocket_connect", "WebSocketConnect", "connectwebsocket"}) do
				local ok, value = pcall(function() return env[key] end)
				if ok then addConnectorSP(value) end
			end
		end
		if #connectorsSP == 0 then return end

		local function connectSocketSP(url)
			for _, connector in ipairs(connectorsSP) do
				local ok, socket = pcall(connector, url)
				if ok and socket ~= nil then return socket end
			end
			return nil
		end

		local function socketSendSP(socket, message)
			if socket == nil or type(message) ~= "string" then return false end
			local ok, sent = pcall(function()
				local method = socket.Send
				if type(method) == "function" then method(socket, message) return true end
				method = socket.send
				if type(method) == "function" then method(socket, message) return true end
				return false
			end)
			return ok and sent == true
		end

		local function socketCloseSP(socket)
			if socket == nil then return end
			pcall(function()
				local method = socket.Close
				if type(method) == "function" then method(socket) return end
				method = socket.close
				if type(method) == "function" then method(socket) end
			end)
		end

		local function disconnectSignalSP(connection)
			if connection == nil then return end
			pcall(function()
				if typeof(connection) == "RBXScriptConnection" then
					connection:Disconnect()
					return
				end
				local method = connection.Disconnect
				if type(method) == "function" then method(connection) return end
				method = connection.disconnect
				if type(method) == "function" then method(connection) end
			end)
		end

		local function connectSignalSP(signal, callback)
			if signal == nil then return nil end
			local connection
			local ok = pcall(function()
				if type(signal.Connect) == "function" then
					connection = signal:Connect(callback)
				elseif type(signal.connect) == "function" then
					connection = signal:connect(callback)
				end
			end)
			return ok and connection or nil
		end

		local endpointsSP = {
			{kind = "router", url = "wss://router.metapage.io/" .. roomSP},
			{kind = "getlost", url = "wss://wss.getlost.ovh"},
		}
		local channelsSP = {}
		for index, endpoint in ipairs(endpointsSP) do
			channelsSP[index] = {
				endpoint = endpoint,
				socket = nil,
				messageConnection = nil,
				closeConnection = nil,
				connecting = false,
				nextAttempt = 0,
				lastSend = 0,
				generation = 0,
			}
		end

		local playerAddedConnectionSP
		local playerRemovingConnectionSP
		local lastReplyAtSP = 0
		local stoppedSP = false

		local function cleanupChannelSP(channel, closeSocket)
			if not channel then return end
			channel.generation = (tonumber(channel.generation) or 0) + 1
			local oldSocket = channel.socket
			channel.socket = nil
			channel.connecting = false
			disconnectSignalSP(channel.messageConnection)
			disconnectSignalSP(channel.closeConnection)
			channel.messageConnection = nil
			channel.closeConnection = nil
			if closeSocket and oldSocket then socketCloseSP(oldSocket) end
		end

		local function cleanupAllChannelsSP(closeSockets)
			for _, channel in ipairs(channelsSP) do
				cleanupChannelSP(channel, closeSockets)
			end
		end

		local function requestPresenceHopSP()
			autoServerHopState.RuntimeScriptUserHopRequested = true
			local wake = autoServerHopState.RuntimePresenceHopWake
			if type(wake) == "function" then
				task.spawn(wake)
			end
		end

		local function armLeaveIfOlderSP(remoteUserId, remoteStarted, remoteId, remoteSeen)
			if autoServerHopState.RuntimeScriptUserHopRequested == true then
				requestPresenceHopSP()
				return true
			end
			if shouldYieldSP(remoteUserId, remoteStarted, remoteId, remoteSeen) then
				requestPresenceHopSP()
				return true
			end
			return false
		end

		local function channelHeartbeatPayloadSP(channel)
			local extra
			if channel and channel.endpoint.kind == "getlost" then
				extra = {
					roomId = roomSP,
					from = "thp10-" .. tostring(LocalPlayerSP.UserId) .. "-" .. tostring(startedMsSP) .. "-" .. instanceIdSP,
				}
			end
			return HttpServiceSP:JSONEncode(heartbeatTableSP(extra))
		end

		local function sendHeartbeatChannelSP(channel, force)
			if not enabledSP() or not channel or not channel.socket then return false end
			local now = os.clock()
			if not force and now - (tonumber(channel.lastSend) or 0) < heartbeatEverySP then
				return true
			end
			if socketSendSP(channel.socket, channelHeartbeatPayloadSP(channel)) then
				channel.lastSend = now
				return true
			end
			return false
		end

		local function sendHeartbeatAllSP(force)
			local sentAny = false
			for _, channel in ipairs(channelsSP) do
				if channel.socket then
					if sendHeartbeatChannelSP(channel, force) then
						sentAny = true
					else
						cleanupChannelSP(channel, true)
						channel.nextAttempt = os.clock() + reconnectEverySP
					end
				end
			end
			return sentAny
		end

		local function parseGetLostRosterSP(message)
			if type(message) ~= "string" or message == "" then return end
			local decoded
			local ok = pcall(function() decoded = HttpServiceSP:JSONDecode(message) end)
			if not ok
				or type(decoded) ~= "table"
				or decoded.sys ~= "roster"
				or type(decoded.roster) ~= "table"
			then
				return
			end
			for _, peer in ipairs(decoded.roster) do
				if type(peer) == "string" then
					local uid, start, iid = peer:match("^thp10%-(%d+)%-(%d+)%-(.+)$")
					uid, start = tonumber(uid), tonumber(start)
					if uid
						and start
						and iid
						and uid ~= tonumber(LocalPlayerSP.UserId)
						and playerStillHereSP(uid)
					then
						markScriptUserSP(uid)



						if start < startedMsSP
							or (start == startedMsSP and uid < tonumber(LocalPlayerSP.UserId))
						then
							requestPresenceHopSP()
							return
						end
					end
				end
			end
		end

		local function handleMessageSP(channel, message)
			if not enabledSP() then return end
			if channel and channel.endpoint.kind == "getlost" then
				parseGetLostRosterSP(message)
			end
			if autoServerHopState.RuntimeScriptUserHopRequested == true then return end
			local remoteUserId, remoteStarted, remoteId, remoteSeen = decodePresenceSP(message)
			if not remoteUserId then return end
			markScriptUserSP(remoteUserId)
			if armLeaveIfOlderSP(remoteUserId, remoteStarted, remoteId, remoteSeen) then return end



			local now = os.clock()
			if now - lastReplyAtSP >= 0.12 then
				lastReplyAtSP = now
				sendHeartbeatAllSP(true)
			end
		end

		local function attachChannelSP(channel, socket, expectedGeneration)
			if not channel or not socket then return false end
			if stoppedSP
				or not screenGui.Parent
				or not enabledSP()
				or channel.generation ~= expectedGeneration
			then
				socketCloseSP(socket)
				return false
			end

			channel.socket = socket
			channel.connecting = false
			channel.lastSend = 0

			local onMessage
			pcall(function() onMessage = socket.OnMessage end)
			if onMessage == nil then pcall(function() onMessage = socket.onmessage end) end
			channel.messageConnection = connectSignalSP(onMessage, function(message)
				handleMessageSP(channel, message)
			end)
			if channel.messageConnection == nil then
				cleanupChannelSP(channel, true)
				channel.nextAttempt = os.clock() + reconnectEverySP
				return false
			end

			local onClose
			pcall(function() onClose = socket.OnClose end)
			if onClose == nil then pcall(function() onClose = socket.onclose end) end
			channel.closeConnection = connectSignalSP(onClose, function()
				if channel.socket == socket then
					cleanupChannelSP(channel, false)
					channel.nextAttempt = os.clock() + reconnectEverySP
				end
			end)

			if channel.endpoint.kind == "getlost" then
				local peerId = "thp10-"
					.. tostring(LocalPlayerSP.UserId)
					.. "-"
					.. tostring(startedMsSP)
					.. "-"
					.. instanceIdSP
				local announced = socketSendSP(socket, HttpServiceSP:JSONEncode({
					roomId = roomSP,
					announce = true,
					from = peerId,
				}))
				if not announced then
					cleanupChannelSP(channel, true)
					channel.nextAttempt = os.clock() + reconnectEverySP
					return false
				end
			end

			if not sendHeartbeatChannelSP(channel, true) then
				cleanupChannelSP(channel, true)
				channel.nextAttempt = os.clock() + reconnectEverySP
				return false
			end
			return true
		end

		local function tryConnectChannelSP(channel)
			if not channel
				or channel.connecting
				or channel.socket
				or not enabledSP()
			then
				return
			end
			channel.connecting = true
			channel.generation = (tonumber(channel.generation) or 0) + 1
			local expectedGeneration = channel.generation
			local endpoint = channel.endpoint
			task.spawn(function()
				local socket = connectSocketSP(endpoint.url)
				if stoppedSP
					or not screenGui.Parent
					or not enabledSP()
					or channel.generation ~= expectedGeneration
				then
					socketCloseSP(socket)
					if channel.generation == expectedGeneration then
						channel.connecting = false
					end
					return
				end
				if socket then
					attachChannelSP(channel, socket, expectedGeneration)
				else
					channel.connecting = false
					channel.nextAttempt = os.clock() + reconnectEverySP
				end
			end)
		end

		playerAddedConnectionSP = PlayersSP.PlayerAdded:Connect(function(player)
			if player ~= LocalPlayerSP then
				autoServerHopState.RuntimePresencePlayerSeenAt =
					autoServerHopState.RuntimePresencePlayerSeenAt or {}
				autoServerHopState.RuntimePresencePlayerSeenAt[
					tostring(player.UserId)
				] = os.clock()
			end
			if player ~= LocalPlayerSP and enabledSP() then


				sendHeartbeatAllSP(true)
				for _, channel in ipairs(channelsSP) do
					if not channel.socket and not channel.connecting then
						channel.nextAttempt = 0
						tryConnectChannelSP(channel)
					end
				end
			end
		end)

		playerRemovingConnectionSP = PlayersSP.PlayerRemoving:Connect(function(player)
			local userId = tostring(player.UserId)
			local detected = autoServerHopState.RuntimeScriptUserIds
			if type(detected) == "table" then
				detected[userId] = nil
			end
			local seenAt = autoServerHopState.RuntimePresencePlayerSeenAt
			if type(seenAt) == "table" then
				seenAt[userId] = nil
			end
		end)

		rawset(_G, "__TUFFHUB_PRESENCE_STOP", function()
			stoppedSP = true
			disconnectSignalSP(playerAddedConnectionSP)
			disconnectSignalSP(playerRemovingConnectionSP)
			playerAddedConnectionSP = nil
			playerRemovingConnectionSP = nil
			cleanupAllChannelsSP(true)
		end)

		local wasEnabledSP = false
		while screenGui.Parent and not stoppedSP do
			local enabled = enabledSP()
			if enabled then
				if not wasEnabledSP then
					autoServerHopState.RuntimeScriptUserHopRequested = false
					autoServerHopState.RuntimePresenceStartedAt = os.clock()
					autoServerHopState.RuntimePresencePlayerSeenAt =
						autoServerHopState.RuntimePresencePlayerSeenAt or {}
					for _, player in ipairs(PlayersSP:GetPlayers()) do
						if player ~= LocalPlayerSP then
							autoServerHopState.RuntimePresencePlayerSeenAt[
								tostring(player.UserId)
							] = os.clock()
						end
					end
					lastReplyAtSP = 0
					for _, channel in ipairs(channelsSP) do
						channel.nextAttempt = 0
						channel.lastSend = 0
					end
				end

				for _, channel in ipairs(channelsSP) do
					if channel.socket then
						if not sendHeartbeatChannelSP(channel, false) then
							cleanupChannelSP(channel, true)
							channel.nextAttempt = os.clock() + reconnectEverySP
						end
					elseif not channel.connecting and os.clock() >= (tonumber(channel.nextAttempt) or 0) then
						tryConnectChannelSP(channel)
					end
				end
			else
				autoServerHopState.RuntimeScriptUserHopRequested = false
				for _, channel in ipairs(channelsSP) do
					channel.nextAttempt = 0
					if channel.socket or channel.connecting then
						cleanupChannelSP(channel, true)
					end
				end
			end
			wasEnabledSP = enabled



			task.wait(0.12)
		end

		disconnectSignalSP(playerAddedConnectionSP)
		disconnectSignalSP(playerRemovingConnectionSP)
		playerAddedConnectionSP = nil
		playerRemovingConnectionSP = nil
		cleanupAllChannelsSP(true)
		if rawget(_G, "__TUFFHUB_PRESENCE_STOP") then
			rawset(_G, "__TUFFHUB_PRESENCE_STOP", nil)
		end
	end)
end




if IS_MINIGAME_PLACE then
	task.spawn(function()
		if not screenGui.Parent then return end

		local PlayersCS = game:GetService("Players")
		local RSCS = game:GetService("ReplicatedStorage")
		local LocalPlayerCS = PlayersCS.LocalPlayer

		local function requireCS(moduleScript)
			while screenGui.Parent do
				local ok, result = pcall(require, moduleScript)
				if ok and result ~= nil then return result end
				task.wait(0.20)
			end
		end

		local SharedCS = RSCS:WaitForChild("Shared")
		local ReplicatorCS = requireCS(
			RSCS:WaitForChild("Client"):WaitForChild("Modules"):WaitForChild("ReplicatorClient")
		)
		local EconomyMathCS = requireCS(
			SharedCS:WaitForChild("utils"):WaitForChild("EconomyMath")
		)
		if not (ReplicatorCS and EconomyMathCS) then return end

		local playerSeenAtCS = {}
		local minigameBoundsCacheCS
		local minigameBoundsBuiltAtCS = 0

		for _, player in ipairs(PlayersCS:GetPlayers()) do
			playerSeenAtCS[tostring(player.UserId)] = os.clock()
		end

		PlayersCS.PlayerAdded:Connect(function(player)
			playerSeenAtCS[tostring(player.UserId)] = os.clock()
		end)
		PlayersCS.PlayerRemoving:Connect(function(player)
			playerSeenAtCS[tostring(player.UserId)] = nil
		end)

		local function tryCS(root, path)
			if not root then return nil end
			local ok, value = pcall(function()
				return root:TryIndex(path)
			end)
			return ok and value or nil
		end

		local function selectedRaritiesCS()
			local selected =
				autoServerHopState.Utility.CheckServerBrainrotRarities
			if type(selected) ~= "table" then return nil, false end
			for _, rarity in ipairs(BRAINROT_RARITY_OPTIONS) do
				if selected[rarity] == true then
					return selected, true
				end
			end
			return selected, false
		end

		local function publicBrainrotRarityCS(tool, name)
			local explicit = tool:GetAttribute("Rarity")
				or tool:GetAttribute("BrainrotRarity")
			if explicit == "Meta" then return "Meta" end

			local rarity = type(explicit) == "string" and explicit or nil
			if not rarity then
				pcall(function()
					rarity = EconomyMathCS.GetBrainrotRarity(name)
				end)
			end

			local metaMarked = tool:GetAttribute("Meta") == true
				or tool:GetAttribute("IsMeta") == true
				or (
					type(name) == "string"
					and string.find(
						string.lower(name),
						"%f[%a]meta%f[%A]"
					) ~= nil
				)

			return rarity == "Infinity" and metaMarked and "Meta" or rarity
		end

		local function playerHasSelectedBrainrotCS(player, selected)
			if typeof(player) ~= "Instance"
				or not player:IsA("Player")
				or player == LocalPlayerCS
			then
				return false
			end

			local function scan(container)
				if not container then return false end
				for _, tool in ipairs(container:GetChildren()) do
					if tool:IsA("Tool") then
						local name = tool:GetAttribute("BrainrotName")
						if type(name) == "string" and name ~= "" then
							local rarity = publicBrainrotRarityCS(tool, name)
							if rarity and selected[rarity] == true then
								return true
							end
						end
					end
				end
				return false
			end

			return scan(player:FindFirstChildOfClass("Backpack"))
				or scan(player.Character)
		end

		local function minigameTablesCS()
			local gameObjects = workspace:FindFirstChild("GameObjects")
			local placeSpecific = gameObjects and gameObjects:FindFirstChild("PlaceSpecific")
			local tradePlaza = placeSpecific and placeSpecific:FindFirstChild("trade_plaza")
			return tradePlaza and tradePlaza:FindFirstChild("MinigameTables")
		end

		local function minigameBoundsCS()
			local now = os.clock()
			if minigameBoundsCacheCS
				and now - minigameBoundsBuiltAtCS < 5
			then
				return minigameBoundsCacheCS
			end

			local folder = minigameTablesCS()
			if not folder then
				minigameBoundsCacheCS = nil
				return nil
			end

			local minX, maxX, minZ, maxZ
			for _, descendant in ipairs(folder:GetDescendants()) do
				if descendant:IsA("BasePart") then
					local p = descendant.Position
					minX = minX and math.min(minX, p.X) or p.X
					maxX = maxX and math.max(maxX, p.X) or p.X
					minZ = minZ and math.min(minZ, p.Z) or p.Z
					maxZ = maxZ and math.max(maxZ, p.Z) or p.Z
				end
			end

			if not minX then
				minigameBoundsCacheCS = nil
				return nil
			end


			local margin = 30
			minigameBoundsCacheCS = {
				MinX = minX - margin,
				MaxX = maxX + margin,
				MinZ = minZ - margin,
				MaxZ = maxZ + margin,
			}
			minigameBoundsBuiltAtCS = now
			return minigameBoundsCacheCS
		end

		local function playerInMinigamesAreaCS(player)
			local bounds = minigameBoundsCS()
			local character = player and player.Character
			local root = character and character:FindFirstChild("HumanoidRootPart")
			if not bounds or not root then return false end
			local p = root.Position
			return p.X >= bounds.MinX
				and p.X <= bounds.MaxX
				and p.Z >= bounds.MinZ
				and p.Z <= bounds.MaxZ
		end

		local function rosterStableCS()
			local now = os.clock()
			for _, player in ipairs(PlayersCS:GetPlayers()) do
				if player ~= LocalPlayerCS then
					local seenAt =
						playerSeenAtCS[tostring(player.UserId)]
						or now
					if now - seenAt < 2.5 then
						return false
					end
				end
			end
			return true
		end

		local function eligiblePlayersCS(selected, areaOnly)
			local list = {}
			for _, player in ipairs(PlayersCS:GetPlayers()) do
				if player ~= LocalPlayerCS
					and (not areaOnly or playerInMinigamesAreaCS(player))
					and playerHasSelectedBrainrotCS(player, selected)
				then
					list[#list + 1] = player
				end
			end
			return list
		end

		local function everyonePlayedCS(players)
			if #players == 0 then return false end
			local played = autoServerHopState.RuntimePlayedMinigameUserIds
			if type(played) ~= "table" then return false end
			for _, player in ipairs(players) do
				if played[tostring(player.UserId)] ~= true then
					return false
				end
			end
			return true
		end

		while screenGui.Parent do
			task.wait(0.35)

			local utility = autoServerHopState.Utility
			if utility.PauseScript == true
				or utility.PauseMinigameFeatures == true
			then
				autoServerHopState.RuntimeCheckServerHopRequested = false
				continue
			end



			local active
			pcall(function()
				active = ReplicatorCS.get("ActiveMinigame")
			end)
			if tryCS(active, {"phase"}) == "Playing" then
				local opponent =
					tryCS(active, {"session", "private", "opponent"})
				if typeof(opponent) == "Instance"
					and opponent:IsA("Player")
					and opponent ~= LocalPlayerCS
				then
					autoServerHopState.RuntimePlayedMinigameUserIds =
						autoServerHopState.RuntimePlayedMinigameUserIds or {}
					autoServerHopState.RuntimePlayedMinigameUserIds[
						tostring(opponent.UserId)
					] = true
				end
			end

			local anyCondition =
				utility.CheckServerHopNobodyServer == true
				or utility.CheckServerHopPlayedEveryoneServer == true
				or utility.CheckServerHopNobodyMinigamesArea == true
				or utility.CheckServerHopPlayedEveryoneMinigamesArea == true

			if not anyCondition or not rosterStableCS() then
				autoServerHopState.RuntimeCheckServerHopRequested = false
				continue
			end

			local selected, hasSelection = selectedRaritiesCS()
			if not hasSelection then
				autoServerHopState.RuntimeCheckServerHopRequested = false
				continue
			end

			local serverPlayers
			local areaPlayers
			local shouldHop = false

			if utility.CheckServerHopNobodyServer == true
				or utility.CheckServerHopPlayedEveryoneServer == true
			then
				serverPlayers = eligiblePlayersCS(selected, false)
				if utility.CheckServerHopNobodyServer == true
					and #serverPlayers == 0
				then
					shouldHop = true
				end
				if not shouldHop
					and utility.CheckServerHopPlayedEveryoneServer == true
					and everyonePlayedCS(serverPlayers)
				then
					shouldHop = true
				end
			end

			if not shouldHop
				and (
					utility.CheckServerHopNobodyMinigamesArea == true
					or utility.CheckServerHopPlayedEveryoneMinigamesArea == true
				)
			then
				areaPlayers = eligiblePlayersCS(selected, true)
				if utility.CheckServerHopNobodyMinigamesArea == true
					and #areaPlayers == 0
				then
					shouldHop = true
				end
				if not shouldHop
					and utility.CheckServerHopPlayedEveryoneMinigamesArea == true
					and everyonePlayedCS(areaPlayers)
				then
					shouldHop = true
				end
			end

			autoServerHopState.RuntimeCheckServerHopRequested = shouldHop
		end
	end)
end








if IS_MINIGAME_PLACE then
	task.spawn(function()
		if not screenGui.Parent then return end
		local HttpServiceHP = game:GetService("HttpService")
		local TeleportServiceHP = game:GetService("TeleportService")
		local RSHP = game:GetService("ReplicatedStorage")
		local LocalPlayerHP = game:GetService("Players").LocalPlayer
		local function requireHP(moduleScript)
			while screenGui.Parent do
				local ok, result = pcall(require, moduleScript)
				if ok and result ~= nil then return result end
				task.wait(0.25)
			end
		end
		local ReplicatorHP = requireHP(
			RSHP:WaitForChild("Client"):WaitForChild("Modules"):WaitForChild("ReplicatorClient")
		)
		if not ReplicatorHP then return end

		local nowStartedHP = os.clock()
		local startupElapsedHP = math.max(
			0,
			nowStartedHP - (tonumber(autoServerHopState.RuntimeStartedAt) or nowStartedHP)
		)


		local serverElapsedHP = (
			autoServerHopState.Enabled == true
			and autoServerHopState.ServerTimeEnabled == true
		) and startupElapsedHP or 0
		local noGameElapsedHP = (
			autoServerHopState.Enabled == true
			and autoServerHopState.TimeSinceLastGameEnabled == true
		) and startupElapsedHP or 0
		local lastTimerTickHP = nowStartedHP
		local lastResetEpochHP = tonumber(autoServerHopState.RuntimeSettingsResetEpoch) or 0
		local wasPlayingHP = false
		local hoppingHP = false
		local lastResultSignatureHP
		local lastGameIdHP
		local serverRngHP = Random.new(
			math.floor((DateTime.now().UnixTimestampMillis + os.clock() * 1000000) % 2147483647)
		)


		local boothBlockRemainingHP = 0
		local previousBoothOffersHP = {}
		local pendingBoothChecksHP = {}
		local nextBoothScanAtHP = 0









		local cachedCandidatesHP = {}
		local serverCacheAtHP = 0
		local cacheRefreshingHP = false
		local wasPresenceDueHP = false
		local PRESENCE_HOP_CACHE_MAX_AGE_HP = 2.0




		local function recordRecentServerHP(id)
			if type(id) ~= "string" or id == "" then return end
			local list = autoServerHopState.RecentServerIds
			if type(list) ~= "table" then
				list = {}
				autoServerHopState.RecentServerIds = list
			end
			for index = #list, 1, -1 do
				if list[index] == id then table.remove(list, index) end
			end
			list[#list + 1] = id
			while #list > 10 do table.remove(list, 1) end
		end

		recordRecentServerHP(game.JobId)

		local function tryIndexHP(root, path)
			if not root then return nil end
			local ok, value = pcall(function() return root:TryIndex(path) end)
			return ok and value or nil
		end

		TeleportServiceHP.TeleportInitFailed:Connect(function(player)
			if player == LocalPlayerHP then
				hoppingHP = false
				serverCacheAtHP = 0
			end
		end)

		local function activeMinigameHP()
			local active
			pcall(function() active = ReplicatorHP.get("ActiveMinigame") end)
			return active
		end




		local lastNegotiationSeenAtHP = -math.huge
		local function lifecycleBlockedHP(active)
			local negotiation
			pcall(function() negotiation = ReplicatorHP.get("ActiveNegotiation") end)

			local now = os.clock()
			if tryIndexHP(negotiation, {"guid"}) ~= nil then
				lastNegotiationSeenAtHP = now
				return true
			end
			if now - lastNegotiationSeenAtHP < 1.00 then return true end
			if tryIndexHP(active, {"phase"}) ~= nil then return true end
			if tryIndexHP(active, {"session", "gameId"}) ~= nil then return true end
			if type(tryIndexHP(active, {"voting"})) == "table" then return true end
			return false
		end

		local function playingHP(active)
			if not active then return false end
			return tryIndexHP(active, {"phase"}) == "Playing"
				and tryIndexHP(active, {"session", "gameId"}) ~= nil
		end

		local function serverDurationHP()
			return math.max(1, tonumber(autoServerHopState.ServerTime) or 10) * 60
		end

		local function noGameDurationHP()
			return math.max(1, tonumber(autoServerHopState.TimeSinceLastGame) or 3) * 60
		end

		local function presenceDueHP()
			return autoServerHopState.Utility.PauseScript ~= true
				and autoServerHopState.RuntimeScriptUserHopRequested == true
		end

		local function scheduledDueHP()


			if autoServerHopState.Utility.PauseScript == true then
				return false
			end
			if presenceDueHP() then
				return true
			end
			if autoServerHopState.Utility.PauseMinigameFeatures == true then
				return false
			end
			if autoServerHopState.RuntimeCheckServerHopRequested == true
				or autoServerHopState.RuntimeManualServerHopRequested == true
			then
				return true
			end
			if autoServerHopState.Enabled ~= true then
				return false
			end
			if autoServerHopState.ServerTimeEnabled == true
				and serverElapsedHP >= serverDurationHP()
			then
				return true
			end
			if autoServerHopState.TimeSinceLastGameEnabled == true
				and noGameElapsedHP >= noGameDurationHP()
			then
				return true
			end
			return false
		end

		local function myBoothStateHP()
			local booths
			pcall(function() booths = ReplicatorHP.get("TradingBooths") end)
			local data = booths and booths.Data
			if type(data) ~= "table" then return nil end
			for _, entry in pairs(data) do
				if type(entry) == "table" and entry.player == LocalPlayerHP then
					return entry
				end
			end
		end

		local function boothContainsItemHP(state, itemId)
			local wanted = tostring(itemId)
			for offerId, item in pairs(state and state.items or {}) do
				if tostring(offerId) == wanted then return true end
				if type(item) == "table" then
					local id = item.guid or item.id
					if id ~= nil and tostring(id) == wanted then return true end
				end
			end
			return false
		end

		local function inventoryContainsHP(itemId)
			local playerData
			pcall(function() playerData = ReplicatorHP.get("PlayerData") end)
			local inventory = tryIndexHP(playerData, {"Inventory"})
			if type(inventory) ~= "table" then return false end
			return inventory[itemId] ~= nil
				or inventory[tostring(itemId)] ~= nil
				or (tonumber(itemId) ~= nil and inventory[tonumber(itemId)] ~= nil)
		end

		local function scanBoothPurchasesHP()
			local state = myBoothStateHP()
			local currentOffers = {}
			for offerId in pairs(state and state.offers or {}) do
				local item = state.items and (state.items[offerId] or state.items[tostring(offerId)]) or nil
				local itemId = type(item) == "table" and (item.guid or item.id) or offerId
				currentOffers[tostring(offerId)] = itemId or offerId
			end

			for offerKey, itemId in pairs(previousBoothOffersHP) do
				local suppressions = autoServerHopState.RuntimeBoothScriptRemoveUntil
				local suppressedUntil = type(suppressions) == "table"
					and tonumber(suppressions[offerKey]) or 0
				if currentOffers[offerKey] == nil
					and os.clock() >= suppressedUntil
					and not pendingBoothChecksHP[offerKey]
				then
					pendingBoothChecksHP[offerKey] = true
					task.delay(0.75, function()
						pendingBoothChecksHP[offerKey] = nil
						if not screenGui.Parent or autoServerHopState.Enabled ~= true then return end
						local liveState = myBoothStateHP()
						if boothContainsItemHP(liveState, itemId) or inventoryContainsHP(itemId) then return end
						local seconds = math.clamp(
							math.floor(tonumber(autoServerHopState.BoothPurchaseTimeAdded) or 1),
							1, 60
						) * 60
						boothBlockRemainingHP = math.max(boothBlockRemainingHP, seconds)
					end)
				end
			end
			previousBoothOffersHP = currentOffers
			local suppressions = autoServerHopState.RuntimeBoothScriptRemoveUntil
			if type(suppressions) == "table" then
				for offerKey, untilAt in pairs(suppressions) do
					if os.clock() >= (tonumber(untilAt) or 0) then suppressions[offerKey] = nil end
				end
			end
		end

		local function processMatchResultHP(active, nowPlaying)
			local gameId = tryIndexHP(active, {"session", "gameId"})
			if type(gameId) == "string" and gameId ~= "" and gameId ~= lastGameIdHP then
				lastGameIdHP = gameId
			end
			if nowPlaying and not wasPlayingHP then lastResultSignatureHP = nil end

			local result = tryIndexHP(active, {"matchResult"})
			if type(result) ~= "table" then return end
			local winner = tonumber(result.winnerIndex)
			if winner == nil or winner == 0 then return end
			local signature = tostring(lastGameIdHP or gameId or "Unknown")
				.. ":" .. tostring(winner)
				.. ":" .. tostring(result.round or result.roundIndex or result.bestOf or "")
			if signature == lastResultSignatureHP then return end
			lastResultSignatureHP = signature

			if autoServerHopState.Enabled ~= true then return end
			if winner == 1 then
				if autoServerHopState.ServerTimeEnabled == true then
					local addedSeconds = math.clamp(
						tonumber(autoServerHopState.WinWagerTimeAdded) or 3,
						0, 60
					) * 60
					local duration = serverDurationHP()


					serverElapsedHP = math.min(
						serverElapsedHP - addedSeconds,
						duration - addedSeconds
					)
				end
			end
		end

		local function requestFunctionHP()
			local env
			pcall(function()
				if type(getgenv) == "function" then env = getgenv() end
			end)
			if type(env) ~= "table" then env = _G end

			local direct = env.request or env.http_request or rawget(_G, "request") or rawget(_G, "http_request")
			if type(direct) == "function" then return direct end

			local synTable = env.syn or rawget(_G, "syn")
			if type(synTable) == "table" and type(synTable.request) == "function" then return synTable.request end

			local httpTable = env.http or rawget(_G, "http")
			if type(httpTable) == "table" and type(httpTable.request) == "function" then return httpTable.request end
		end

		local function decodeServerPageHP(body)
			if type(body) ~= "string" or body == "" then return nil end
			local decoded
			local okDecode = pcall(function() decoded = HttpServiceHP:JSONDecode(body) end)
			return okDecode and type(decoded) == "table" and decoded or nil
		end

		local function fetchServerPageHP(requestFn, cursor)
			local url = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId)
				.. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true"
			if cursor and cursor ~= "" then url ..= "&cursor=" .. HttpServiceHP:UrlEncode(cursor) end

			if requestFn then
				local ok, response = pcall(requestFn, {
					Url = url,
					Method = "GET",
					Headers = { ["Accept"] = "application/json" },
				})
				if ok and response ~= nil then
					local body
					if type(response) == "string" then
						body = response
					elseif type(response) == "table" then
						body = response.Body or response.body
					end
					local decoded = decodeServerPageHP(body)
					if decoded then return decoded end
				end
			end

			local body
			local okHttpGet = pcall(function() body = game:HttpGet(url) end)
			if not okHttpGet then return nil end
			return decodeServerPageHP(body)
		end

		local function collectCandidatesHP()
			local requestFn = requestFunctionHP()
			local candidates = {}
			local seen = {}




			local decoded = fetchServerPageHP(requestFn, nil)
			if not decoded then return candidates end
			for _, server in ipairs(decoded.data or {}) do
				local id = server.id
				local playing = tonumber(server.playing)
				local maxPlayers = tonumber(server.maxPlayers)
				if type(id) == "string"
					and id ~= ""
					and id ~= game.JobId
					and not seen[id]
					and playing
					and maxPlayers
					and maxPlayers > 0
					and playing < maxPlayers
				then
					seen[id] = true
					candidates[#candidates + 1] = {
						id = id,
						playing = playing,
						maxPlayers = maxPlayers,
						fullness = playing / maxPlayers,
						openSlots = maxPlayers - playing,
					}
				end
			end
			table.sort(candidates, function(a, b)
				if a.playing ~= b.playing then return a.playing > b.playing end
				if a.fullness ~= b.fullness then return a.fullness > b.fullness end
				if a.openSlots ~= b.openSlots then return a.openSlots < b.openSlots end
				return a.id < b.id
			end)
			return candidates
		end

		local function refreshServerCacheHP()
			if cacheRefreshingHP or not screenGui.Parent then return end
			cacheRefreshingHP = true
			local ok, candidates = pcall(collectCandidatesHP)
			if ok and type(candidates) == "table" and #candidates > 0 then
				cachedCandidatesHP = candidates
				serverCacheAtHP = os.clock()
			end
			cacheRefreshingHP = false
		end

		local function chooseTopTenHP(candidates)
			if type(candidates) ~= "table" or #candidates == 0 then return nil end
			local topTen = {}
			for _, candidate in ipairs(candidates) do
				if candidate.id ~= game.JobId
					and tonumber(candidate.playing)
					and tonumber(candidate.maxPlayers)
					and candidate.playing < candidate.maxPlayers
				then
					topTen[#topTen + 1] = candidate
					if #topTen >= 10 then break end
				end
			end
			if #topTen == 0 then return nil end




			return topTen[serverRngHP:NextInteger(1, #topTen)]
		end

		local function cachedChoiceHP()
			return chooseTopTenHP(cachedCandidatesHP)
		end

		local function freshPresenceChoiceHP()
			if serverCacheAtHP <= 0 then return nil end
			if os.clock() - serverCacheAtHP > PRESENCE_HOP_CACHE_MAX_AGE_HP then return nil end
			return cachedChoiceHP()
		end

		local function presenceChoiceHP()




			return freshPresenceChoiceHP() or cachedChoiceHP()
		end

		local function hopDifferentHP()
			local collisionDueHP = presenceDueHP()
			if hoppingHP
				or autoServerHopState.Utility.PauseScript == true
				or (
					autoServerHopState.Utility.PauseMinigameFeatures == true
					and not collisionDueHP
				)
				or not scheduledDueHP()
			then
				return
			end
			hoppingHP = true



			if autoServerHopState.Utility.PauseScript == true
				or (
					autoServerHopState.Utility.PauseMinigameFeatures == true
					and not collisionDueHP
				)
			then
				hoppingHP = false
				return
			end
			local activeBeforeTeleport = activeMinigameHP()
			local checkServerDueHP =
				autoServerHopState.RuntimeCheckServerHopRequested == true
			local manualDueHP =
				autoServerHopState.RuntimeManualServerHopRequested == true
			if not scheduledDueHP()
				or (
					not collisionDueHP
					and not checkServerDueHP
					and not manualDueHP
					and boothBlockRemainingHP > 0
				)
				or (not collisionDueHP and lifecycleBlockedHP(activeBeforeTeleport))
			then
				hoppingHP = false
				return
			end





			local chosen = collisionDueHP and presenceChoiceHP() or cachedChoiceHP()
			if not chosen then
				hoppingHP = false
				if not cacheRefreshingHP then task.spawn(refreshServerCacheHP) end
				return
			end

			local originJobId = game.JobId
			recordRecentServerHP(originJobId)
			recordRecentServerHP(chosen.id)
			local saver = rawget(_G, "__TUFFHUB_SAVE_SETTINGS_NOW")
			if type(saver) == "function" then pcall(saver, true) end

			if autoServerHopState.Utility.PauseScript == true
				or (
					autoServerHopState.Utility.PauseMinigameFeatures == true
					and not collisionDueHP
				)
			then
				hoppingHP = false
				return
			end

			local ok = pcall(function()
				TeleportServiceHP:TeleportToPlaceInstance(game.PlaceId, chosen.id, LocalPlayerHP)
			end)

			if not ok then
				serverCacheAtHP = 0
				task.delay(2, function() hoppingHP = false end)
				return
			end

			task.delay(10, function()
				if screenGui.Parent and game.JobId == originJobId then
					hoppingHP = false
					serverCacheAtHP = 0
				end
			end)
		end

		local wakePresenceHopHP = function()
			if not screenGui.Parent or not presenceDueHP() then return end
			if presenceChoiceHP() == nil then
				if not cacheRefreshingHP then task.spawn(refreshServerCacheHP) end
				return
			end
			hopDifferentHP()
		end
		autoServerHopState.RuntimePresenceHopWake = wakePresenceHopHP

		while screenGui.Parent do
			task.wait(0.10)





			if autoServerHopState.Utility.PauseScript == true then
				autoServerHopState.RuntimeServerHopPending = false
				autoServerHopState.RuntimeScriptUserHopRequested = false
				lastTimerTickHP = os.clock()
				wasPresenceDueHP = false
				continue
			end

			local active = activeMinigameHP()
			local nowPlaying = playingHP(active)
			local lifecycleBlocked = lifecycleBlockedHP(active)
			local pausedHP = autoServerHopState.Utility.PauseScript == true
				or autoServerHopState.Utility.PauseMinigameFeatures == true
			if not pausedHP then
				processMatchResultHP(active, nowPlaying)
			end

			local nowHP = os.clock()


			if not pausedHP
				and autoServerHopState.Enabled == true
				and nowHP >= nextBoothScanAtHP
			then
				nextBoothScanAtHP = nowHP + 0.50
				scanBoothPurchasesHP()
			end
			local resetEpochHP = tonumber(autoServerHopState.RuntimeSettingsResetEpoch) or 0
			if resetEpochHP ~= lastResetEpochHP then
				lastResetEpochHP = resetEpochHP
				serverElapsedHP = 0
				noGameElapsedHP = 0
				boothBlockRemainingHP = 0
				lastTimerTickHP = nowHP
			end
			local deltaHP = math.max(0, nowHP - lastTimerTickHP)
			lastTimerTickHP = nowHP
			local masterEnabledHP = autoServerHopState.Enabled == true
				and autoServerHopState.Utility.PauseScript ~= true
				and autoServerHopState.Utility.PauseMinigameFeatures ~= true
			local serverTimerEnabledHP = masterEnabledHP
				and autoServerHopState.ServerTimeEnabled == true
			local noGameTimerEnabledHP = masterEnabledHP
				and autoServerHopState.TimeSinceLastGameEnabled == true



			if serverTimerEnabledHP then serverElapsedHP += deltaHP end



			if nowPlaying then
				noGameElapsedHP = 0
			elseif noGameTimerEnabledHP then
				if wasPlayingHP then


					noGameElapsedHP = 0
				else
					noGameElapsedHP += deltaHP
				end
			end
			wasPlayingHP = nowPlaying

			if masterEnabledHP and boothBlockRemainingHP > 0 then
				boothBlockRemainingHP = math.max(0, boothBlockRemainingHP - deltaHP)
			end




			if autoServerHopState.Utility.PauseScript == true then
				autoServerHopState.RuntimeScriptUserHopRequested = false
			end





			local presenceNowHP = presenceDueHP()
			if presenceNowHP and not wasPresenceDueHP then
				if freshPresenceChoiceHP() == nil and not cacheRefreshingHP then
					task.spawn(refreshServerCacheHP)
				end
			end
			wasPresenceDueHP = presenceNowHP




			local hopDueHP = scheduledDueHP()
			local preparedHopReadyHP = hopDueHP and (
				(presenceNowHP and presenceChoiceHP() ~= nil)
				or (not presenceNowHP and cachedChoiceHP() ~= nil)
			)
			autoServerHopState.RuntimeServerHopPending =
				presenceNowHP
				or autoServerHopState.RuntimeCheckServerHopRequested == true
				or autoServerHopState.RuntimeManualServerHopRequested == true
				or preparedHopReadyHP
				or hoppingHP




			if not cacheRefreshingHP then
				local shouldRefreshHP = false
				local maxCacheAgeHP = 10

				if autoServerHopState.Utility.PauseScript ~= true then
					shouldRefreshHP = serverCacheAtHP == 0
						or nowHP - serverCacheAtHP >= 1.25
					maxCacheAgeHP = 1.25
				elseif autoServerHopState.RuntimeCheckServerHopRequested == true
					or autoServerHopState.RuntimeManualServerHopRequested == true
				then
					shouldRefreshHP = serverCacheAtHP == 0
						or nowHP - serverCacheAtHP >= 1.25
					maxCacheAgeHP = 1.25
				elseif masterEnabledHP then
					local nearestRemainingHP = math.huge
					if serverTimerEnabledHP then
						nearestRemainingHP = math.min(nearestRemainingHP, serverDurationHP() - serverElapsedHP)
					end
					if noGameTimerEnabledHP and not nowPlaying then
						nearestRemainingHP = math.min(nearestRemainingHP, noGameDurationHP() - noGameElapsedHP)
					end

					if nearestRemainingHP <= 5 then
						maxCacheAgeHP = 1
						shouldRefreshHP = serverCacheAtHP == 0 or nowHP - serverCacheAtHP >= maxCacheAgeHP
					elseif nearestRemainingHP <= 15 then
						maxCacheAgeHP = 2.5
						shouldRefreshHP = serverCacheAtHP == 0 or nowHP - serverCacheAtHP >= maxCacheAgeHP
					elseif nearestRemainingHP <= 30 then
						maxCacheAgeHP = 10
						shouldRefreshHP = serverCacheAtHP == 0 or nowHP - serverCacheAtHP >= maxCacheAgeHP
					end
				end

				if shouldRefreshHP then
					task.spawn(refreshServerCacheHP)
				end
			end




			if hopDueHP
				and (presenceNowHP or not lifecycleBlocked)
				and (
					presenceNowHP
					or autoServerHopState.RuntimeCheckServerHopRequested == true
					or autoServerHopState.RuntimeManualServerHopRequested == true
					or boothBlockRemainingHP <= 0
				)
				and not hoppingHP
				and preparedHopReadyHP
			then
				task.spawn(hopDifferentHP)
			end
		end
		if autoServerHopState.RuntimePresenceHopWake == wakePresenceHopHP then
			autoServerHopState.RuntimePresenceHopWake = nil
		end
	end)
end






if IS_MINIGAME_PLACE then
	(function()
		local GuiServiceAR = game:GetService("GuiService")
		local TeleportServiceAR = game:GetService("TeleportService")
		local PlayersAR = game:GetService("Players")
		local LocalPlayerAR = PlayersAR.LocalPlayer
		local reconnectingAR = false
		local reconnectSerialAR = 0

		local function isConnectionLossAR(message)
			if type(message) ~= "string" or message == "" then return false end
			local text = string.lower(message)



			if string.find(text, "kicked", 1, true)
				or string.find(text, "error code: 267", 1, true)
				or string.find(text, "error code: 268", 1, true)
			then
				return false
			end

			return string.find(text, "error code: 277", 1, true) ~= nil
				or string.find(text, "error code: 279", 1, true) ~= nil
				or string.find(text, "error code: 266", 1, true) ~= nil
				or string.find(text, "server shut", 1, true) ~= nil
				or string.find(text, "server shutdown", 1, true) ~= nil
				or string.find(text, "failed to connect", 1, true) ~= nil
				or string.find(text, "connection timed out", 1, true) ~= nil
				or string.find(text, "lost connection", 1, true) ~= nil
				or string.find(text, "internet connection", 1, true) ~= nil
				or (
					string.find(text, "disconnect", 1, true) ~= nil
					and string.find(text, "same account", 1, true) == nil
				)
		end

		local function beginReconnectAR()
			local utility = autoServerHopState and autoServerHopState.Utility
			if reconnectingAR
				or not utility
				or utility.PauseScript == true
				or utility.AutoReconnect ~= true
			then
				return
			end

			reconnectingAR = true
			reconnectSerialAR += 1
			local serial = reconnectSerialAR
			local originJobId = game.JobId

			task.spawn(function()
				local attempt = 0
				while screenGui.Parent
					and serial == reconnectSerialAR
					and autoServerHopState.Utility.AutoReconnect == true
					and autoServerHopState.Utility.PauseScript ~= true
					and game.JobId == originJobId
				do
					attempt += 1
					pcall(function()
						TeleportServiceAR:Teleport(game.PlaceId, LocalPlayerAR)
					end)




					local retryAt = os.clock() + math.min(8, 3 + attempt)
					while screenGui.Parent
						and serial == reconnectSerialAR
						and autoServerHopState.Utility.AutoReconnect == true
						and autoServerHopState.Utility.PauseScript ~= true
						and game.JobId == originJobId
						and os.clock() < retryAt
					do
						task.wait(0.20)
					end
				end

				if serial == reconnectSerialAR then
					reconnectingAR = false
				end
			end)
		end

		GuiServiceAR.ErrorMessageChanged:Connect(function(message)
			if not screenGui.Parent then return end
			if autoServerHopState.Utility.AutoReconnect ~= true
				or autoServerHopState.Utility.PauseScript == true
			then
				return
			end
			if isConnectionLossAR(message) then
				beginReconnectAR()
			end
		end)




		TeleportServiceAR.TeleportInitFailed:Connect(function(player, _, errorMessage)
			if player ~= LocalPlayerAR or not screenGui.Parent then return end
			if autoServerHopState.Utility.AutoReconnect ~= true
				or autoServerHopState.Utility.PauseScript == true
			then
				return
			end
			if isConnectionLossAR(errorMessage) then
				beginReconnectAR()
			end
		end)
	end)()
end





if IS_MINIGAME_PLACE then




	local autoChatExecutedAtAC = os.clock()
	task.spawn(function()
		while screenGui.Parent
			and not (
				autoServerHopState
				and autoServerHopState.Utility
				and autoServerHopState.Utility.PauseScript ~= true
				and autoServerHopState.Utility.PauseMinigameFeatures ~= true
				and autoServerHopState.Utility.AutoChat == true
			)
		do
			task.wait(0.10)
		end
		if not screenGui.Parent then return end
		local TextChatServiceAC = game:GetService("TextChatService")
		local ReplicatedStorageAC = game:GetService("ReplicatedStorage")
		local ReplicatorPublicChatAC
		pcall(function()
			ReplicatorPublicChatAC = require(
				ReplicatedStorageAC:WaitForChild("Client")
					:WaitForChild("Modules")
					:WaitForChild("ReplicatorClient")
			)
		end)
		local nextChatAtAC = 0
		local lastEnabledAC = false
		local lastRevisionAC = -1
		local lastIntervalAC
		local pausedAtAC

		local function sendPublicChatMessageAC(message)
			local value = tostring(message or "")
			if value == "" then return false end

			if TextChatServiceAC.ChatVersion == Enum.ChatVersion.LegacyChatService then
				local events = ReplicatedStorageAC:FindFirstChild("DefaultChatSystemChatEvents")
				local say = events and events:FindFirstChild("SayMessageRequest")
				if not say then return false end
				local ok = pcall(function()
					say:FireServer(value, "All")
				end)
				return ok
			end

			local channels = TextChatServiceAC:FindFirstChild("TextChannels")
			local general = channels and channels:FindFirstChild("RBXGeneral")
			return general and pcall(general.SendAsync, general, value) or false
		end

		local function activeTradeAC()
			if not ReplicatorPublicChatAC then return false end
			local negotiation
			pcall(function()
				negotiation = ReplicatorPublicChatAC.get("ActiveNegotiation")
			end)
			if not negotiation then return false end
			local ok, guid = pcall(function()
				return negotiation:TryIndex({"guid"})
			end)
			return ok and guid ~= nil
		end

		while screenGui.Parent do
			task.wait(0.10)

			local state = autoServerHopState and autoServerHopState.Utility
			local enabled = state
				and state.PauseScript ~= true
				and state.PauseMinigameFeatures ~= true
				and state.AutoChat == true
			local now = os.clock()

			if not enabled then



				if lastEnabledAC and pausedAtAC == nil then
					pausedAtAC = now
				end
				continue
			end

			if pausedAtAC ~= nil then


				if nextChatAtAC > 0 then
					nextChatAtAC += now - pausedAtAC
				end
				pausedAtAC = nil
			end



			if state.AutoChatEditing == true then
				continue
			end

			local executionDelay = math.clamp(
				tonumber(state.AutoChatExecutionDelay) or 0,
				0,
				60
			)
			if now < autoChatExecutedAtAC + executionDelay then
				continue
			end




			if state.AutoChatDoNotSendDuringActiveTrade == true
				and activeTradeAC()
			then
				continue
			end

			local message = tostring(state.AutoChatMessage or "")
			local revision = math.floor(
				tonumber(state.AutoChatMessageRevision) or 0
			)
			if message == "" then
				lastEnabledAC = true
				nextChatAtAC = 0
				lastRevisionAC = revision
				continue
			end

			local intervalMinutes = math.clamp(
				math.floor((tonumber(state.ChatIntervalMinutes) or 1) + 0.5),
				1,
				5
			)
			local interval = intervalMinutes * 60
			if lastIntervalAC ~= nil and interval ~= lastIntervalAC then

				nextChatAtAC = now + interval
			end
			lastIntervalAC = interval
			local committedNow = revision ~= lastRevisionAC



			if not lastEnabledAC
				or committedNow
				or nextChatAtAC <= 0
				or now >= nextChatAtAC
			then
				local sent = sendPublicChatMessageAC(message)
				nextChatAtAC = now + (sent and interval or 5)
			end

			lastRevisionAC = revision
			lastEnabledAC = true
		end
	end)







	task.spawn(function()
		local ReplicatedStorageATM = game:GetService("ReplicatedStorage")
		local PlayersATM = game:GetService("Players")
		local LocalPlayerATM = PlayersATM.LocalPlayer

		local function requireATM(moduleScript)
			while screenGui.Parent do
				local ok, result = pcall(require, moduleScript)
				if ok and result ~= nil then return result end
				task.wait(0.25)
			end
		end

		local ReplicatorATM = requireATM(
			ReplicatedStorageATM:WaitForChild("Client")
				:WaitForChild("Modules")
				:WaitForChild("ReplicatorClient")
		)
		local RemotesATM = requireATM(
			ReplicatedStorageATM:WaitForChild("Shared"):WaitForChild("Remotes")
		)
		if not (ReplicatorATM and RemotesATM) then return end

		local ActiveNegotiationATM
		local currentGuidATM
		local tradeStartedAtATM = 0
		local primaryRevisionSentATM
		local lastPrimarySentAtATM = 0
		local noValueSinceATM
		local noValueSentATM = false
		local processedMessageCountATM = 0
		local sendBusyATM = false
		local wasTradeChatEnabledATM = false

		local function tryIndexATM(root, path)
			if not root then return nil end
			local ok, value = pcall(function()
				return root:TryIndex(path)
			end)
			return ok and value or nil
		end

		local function refreshActiveNegotiationATM()
			local ok, fresh = pcall(function()
				return ReplicatorATM.get("ActiveNegotiation")
			end)
			if ok then
				ActiveNegotiationATM = fresh
			end
			return ActiveNegotiationATM
		end

		local function negotiationGuidATM()
			return tryIndexATM(
				refreshActiveNegotiationATM(),
				{"guid"}
			)
		end

		local function sendTradeMessageATM(expectedGuid, message)
			if sendBusyATM
				or not expectedGuid
				or negotiationGuidATM() ~= expectedGuid
			then
				return false
			end

			local remote = RemotesATM.TradeChatSendMessage
			if not remote then return false end

			local value = tostring(message or "")
			if value == "" then return false end

			local state = autoServerHopState and autoServerHopState.Utility
			if not state
				or state.PauseScript == true
				or state.PauseMinigameFeatures == true
				or state.AutoTradeChat ~= true
			then
				return false
			end

			sendBusyATM = true
			local success = false

			refreshActiveNegotiationATM()
			local channelReadyUntil = os.clock() + 3.0
			while negotiationGuidATM() == expectedGuid
				and os.clock() < channelReadyUntil
				and type(
					tryIndexATM(
						ActiveNegotiationATM,
						{"chatChannel", "messages"}
					)
				) ~= "table"
			do
				task.wait(0.05)
			end

			if negotiationGuidATM() == expectedGuid then
				for attempt = 1, 3 do
					local currentState =
						autoServerHopState and autoServerHopState.Utility
					if negotiationGuidATM() ~= expectedGuid
						or not currentState
						or currentState.PauseScript == true
						or currentState.PauseMinigameFeatures == true
						or currentState.AutoTradeChat ~= true
					then
						break
					end

					local ok, result = pcall(function()
						return remote:InvokeServer(value)
					end)
					if ok and result ~= false then
						success = true
						break
					end
					if attempt < 3 then
						task.wait(0.1875)
					end
				end
			end

			sendBusyATM = false
			return success
		end

		local function opponentHasValueATM()
			refreshActiveNegotiationATM()

			if math.max(
				0,
				math.floor(
					tonumber(
						tryIndexATM(
							ActiveNegotiationATM,
							{"player2", "currency"}
						)
					) or 0
				)
			) > 0 then
				return true
			end

			local slots = tryIndexATM(
				ActiveNegotiationATM,
				{"player2", "slots"}
			)
			if type(slots) ~= "table" then
				return false
			end

			for slotIndex = 1, 6 do
				local value = slots[tostring(slotIndex)]
				if value == nil then
					value = slots[slotIndex]
				end
				local id = type(value) == "table" and value.id or value
				if id ~= nil and id ~= false and tostring(id) ~= "" then
					return true
				end
			end
			return false
		end

		local function normalizeMessageATM(value)
			value = string.lower(tostring(value or ""))
			value = string.gsub(value, "[%p%c]+", " ")
			value = string.gsub(value, "%s+", " ")
			value = string.gsub(value, "^%s+", "")
			value = string.gsub(value, "%s+$", "")
			return value
		end

		local function messageDistanceATM(a, b)
			local aLen, bLen = #a, #b
			if aLen == 0 then return bLen end
			if bLen == 0 then return aLen end

			local previous = {}
			for j = 0, bLen do
				previous[j] = j
			end

			for i = 1, aLen do
				local current = {[0] = i}
				local aByte = string.byte(a, i)
				for j = 1, bLen do
					local cost = aByte == string.byte(b, j) and 0 or 1
					current[j] = math.min(
						current[j - 1] + 1,
						previous[j] + 1,
						previous[j - 1] + cost
					)
				end
				previous = current
			end
			return previous[bLen]
		end

		local function similarMessageATM(message, wanted)
			local haystack = normalizeMessageATM(message)
			local needle = normalizeMessageATM(wanted)
			if haystack == "" or needle == "" then
				return false
			end



			if string.find(haystack, needle, 1, true)
				or string.find(needle, haystack, 1, true)
			then
				return true
			end



			local longest = math.max(#haystack, #needle)
			if longest <= 3 then
				return false
			end
			local distance = messageDistanceATM(haystack, needle)
			local similarity = 1 - (distance / longest)
			if similarity >= 0.78 then
				return true
			end


			local wantedWords = {}
			local wantedCount = 0
			for word in string.gmatch(needle, "%S+") do
				if not wantedWords[word] then
					wantedWords[word] = true
					wantedCount += 1
				end
			end
			if wantedCount == 0 then return false end

			local matched = 0
			local seen = {}
			for word in string.gmatch(haystack, "%S+") do
				if wantedWords[word] and not seen[word] then
					seen[word] = true
					matched += 1
				end
			end
			return matched / wantedCount >= 0.75
		end

		local function resetTradeStateATM(guid)
			currentGuidATM = guid
			tradeStartedAtATM = guid and os.clock() or 0
			primaryRevisionSentATM = nil
			lastPrimarySentAtATM = 0
			noValueSinceATM = guid and tradeStartedAtATM or nil
			noValueSentATM = false
			processedMessageCountATM = 0
		end

		while screenGui.Parent do
			task.wait(0.08)

			local state = autoServerHopState and autoServerHopState.Utility
			local enabled = state
				and state.PauseScript ~= true
				and state.PauseMinigameFeatures ~= true
				and state.AutoTradeChat == true
			if not enabled then
				wasTradeChatEnabledATM = false
				continue
			end

			local guid = negotiationGuidATM()
			if guid ~= currentGuidATM then
				resetTradeStateATM(guid)
			end
			if guid == nil then
				wasTradeChatEnabledATM = true
				continue
			end

			if not wasTradeChatEnabledATM then
				wasTradeChatEnabledATM = true
				local existingMessages = tryIndexATM(
					ActiveNegotiationATM,
					{"chatChannel", "messages"}
				)
				processedMessageCountATM =
					type(existingMessages) == "table" and #existingMessages or 0
			end

			local now = os.clock()




			if state.AutoTradeChatEditing ~= true then
				local message = tostring(state.AutoTradeMessage or "")
				local revision = math.floor(
					tonumber(state.AutoTradeMessageRevision) or 0
				)
				local startDelay = math.clamp(
					tonumber(state.AutoTradeMessageStartDelay) or 1.125,
					0,
					10
				)

				if message ~= ""
					and now - tradeStartedAtATM >= startDelay
				then
					if primaryRevisionSentATM ~= revision then
						if sendTradeMessageATM(guid, message) then
							primaryRevisionSentATM = revision
							lastPrimarySentAtATM = os.clock()
							state._LastTradeMessageGuid = tostring(guid)
							state._LastTradeMessageSentAt = lastPrimarySentAtATM
						end
					elseif state.AutoTradeRepeatMessage == true then
						local repeatInterval = math.clamp(
							tonumber(state.AutoTradeRepeatInterval) or 10,
							1,
							60
						)
						if now - lastPrimarySentAtATM >= repeatInterval
							and sendTradeMessageATM(guid, message)
						then
							lastPrimarySentAtATM = os.clock()
							state._LastTradeMessageSentAt = lastPrimarySentAtATM
						end
					end
				end
			end





			if state.AutoTradeSendIfValueNotOffered == true
				and state.AutoTradeNoValueMessageEditing ~= true
			then
				if opponentHasValueATM() then
					noValueSinceATM = nil
				else
					noValueSinceATM = noValueSinceATM or now
					local delay = math.clamp(
						tonumber(state.AutoTradeNoValueDelay) or 10,
						0,
						60
					)
					local message = tostring(state.AutoTradeNoValueMessage or "")
					if not noValueSentATM
						and message ~= ""
						and now - noValueSinceATM >= delay
						and sendTradeMessageATM(guid, message)
					then
						noValueSentATM = true
					end
				end
			else
				noValueSinceATM = nil
				noValueSentATM = false
			end




			if state.AutoTradeCustomRepliesEnabled == true then
				local messages = tryIndexATM(
					ActiveNegotiationATM,
					{"chatChannel", "messages"}
				)
				if type(messages) == "table" then
					if #messages < processedMessageCountATM then
						processedMessageCountATM = 0
					end

					for messageIndex = processedMessageCountATM + 1, #messages do
						local messageData = messages[messageIndex]
						if type(messageData) == "table"
							and messageData.from ~= LocalPlayerATM
						then
							local incoming = tostring(messageData.message or "")
							for _, replyRule in ipairs(
								type(state.AutoTradeCustomReplies) == "table"
									and state.AutoTradeCustomReplies
									or {}
							) do
								if type(replyRule) == "table" then
									local lookFor = tostring(replyRule.LookFor or "")
									local reply = tostring(replyRule.Reply or "")
									if lookFor ~= ""
										and reply ~= ""
										and similarMessageATM(incoming, lookFor)
									then
										sendTradeMessageATM(guid, reply)
										break
									end
								end
							end
						end
					end
					processedMessageCountATM = #messages
				end
			else
				local messages = tryIndexATM(
					ActiveNegotiationATM,
					{"chatChannel", "messages"}
				)
				processedMessageCountATM =
					type(messages) == "table" and #messages or 0
			end
		end
	end)





	task.spawn(function()
		while screenGui.Parent
			and not (
				autoServerHopState
				and autoServerHopState.Utility
				and autoServerHopState.Utility.AutoDeleteWorstInventory == true
			)
		do
			task.wait(0.10)
		end
		if not screenGui.Parent then return end
		local PlayersADI = game:GetService("Players")
		local ReplicatedStorageADI = game:GetService("ReplicatedStorage")
		local LocalPlayerADI = PlayersADI.LocalPlayer

		local function requireADI(moduleScript)
			while screenGui.Parent do
				local ok, result = pcall(require, moduleScript)
				if ok and result ~= nil then return result end
				task.wait(0.25)
			end
		end
		local ReplicatorADI = requireADI(
			ReplicatedStorageADI:WaitForChild("Client")
				:WaitForChild("Modules")
				:WaitForChild("ReplicatorClient")
		)
		local SharedADI = ReplicatedStorageADI:WaitForChild("Shared")
		local RemotesADI = requireADI(SharedADI:WaitForChild("Remotes"))
		local GetItemTypeADI = requireADI(
			SharedADI:WaitForChild("utils"):WaitForChild("GetItemType")
		)
		local EconomyMathADI = requireADI(
			SharedADI:WaitForChild("utils"):WaitForChild("EconomyMath")
		)
		local ItemToStringADI = requireADI(
			SharedADI:WaitForChild("utils"):WaitForChild("ItemToString")
		)
		if not (
			ReplicatorADI
			and RemotesADI
			and GetItemTypeADI
			and EconomyMathADI
			and ItemToStringADI
		) then
			return
		end

		local DeleteInventoryItemADI = RemotesADI.DeleteInventoryItem
		local LockInventoryItemADI = RemotesADI.LockItem
		local PlayerDataADI
		local ActiveNegotiationADI
		local ActiveMinigameADI
		local deleteBusyADI = false



		local RARITY_ORDER_ADI = {
			Common = 1,
			Uncommon = 2,
			Rare = 3,
			Epic = 4,
			Legendary = 5,
			Mythical = 6,
			Cosmic = 7,
			Secret = 8,
			Celestial = 9,
			Divine = 10,
			Infinity = 11,
			Paradox = 12,
			Eternal = 13,
		}

		local function tryIndexADI(root, path)
			if not root then return nil end
			local ok, value = pcall(function()
				return root:TryIndex(path)
			end)
			return ok and value or nil
		end

		local function refreshReplicatorsADI()
			pcall(function()
				PlayerDataADI = ReplicatorADI.get("PlayerData") or PlayerDataADI
			end)
			pcall(function()
				ActiveNegotiationADI =
					ReplicatorADI.get("ActiveNegotiation") or ActiveNegotiationADI
			end)
			pcall(function()
				ActiveMinigameADI =
					ReplicatorADI.get("ActiveMinigame") or ActiveMinigameADI
			end)
		end

		local function inventoryDataADI()
			refreshReplicatorsADI()
			local inventory = tryIndexADI(PlayerDataADI, {"Inventory"})
			return type(inventory) == "table" and inventory or nil
		end

		local function inventoryItemTypeADI(item)
			if type(item) ~= "table" then return nil end
			local itemType
			pcall(function()
				itemType = GetItemTypeADI(item)
			end)
			return itemType
		end

		local function getItemRarityADI(item)
			if type(item) ~= "table"
				or inventoryItemTypeADI(item) ~= "Brainrot"
			then
				return nil
			end

			local explicit = item.sub and item.sub.rarity
			if type(explicit) == "string" and RARITY_ORDER_ADI[explicit] then
				return explicit
			end

			local rarity
			pcall(function()
				rarity = EconomyMathADI.GetBrainrotRarity(item.name)
			end)
			return type(rarity) == "string" and rarity or nil
		end

		local function brainrotIsMetaADI(item)
			local name = type(item) == "table"
				and (item.name or (item.sub and item.sub.name))
				or nil
			if type(name) ~= "string" then return false end

			local lower = string.lower(name)
			local metaNames = rawget(_G, "__TSUNAMI_META_NAMES_V215")
			if type(metaNames) == "table" then
				if metaNames[name] ~= nil then return true end
				for configuredName in pairs(metaNames) do
					if type(configuredName) == "string"
						and string.find(
							lower,
							string.lower(configuredName),
							1,
							true
						)
					then
						return true
					end
				end
			end

			return string.find(lower, "%f[%a]meta%f[%A]") ~= nil
		end

		local function negotiationGuidADI()
			refreshReplicatorsADI()
			return tryIndexADI(ActiveNegotiationADI, {"guid"})
		end

		local function minigamePhaseADI()
			refreshReplicatorsADI()
			return tryIndexADI(ActiveMinigameADI, {"phase"})
		end

		local function minigameGameIdADI()
			refreshReplicatorsADI()
			return tryIndexADI(ActiveMinigameADI, {"session", "gameId"})
		end

		local function deleteBlockedADI()
			if autoServerHopState.Utility.PauseScript == true or autoServerHopState.Utility.PauseMinigameFeatures == true then return true end
			return negotiationGuidADI() ~= nil
				or minigamePhaseADI() ~= nil
				or minigameGameIdADI() ~= nil
		end




		local function effectiveInventoryCountADI()
			local count = 0
			local backpack = LocalPlayerADI:FindFirstChildOfClass("Backpack")
			local character = LocalPlayerADI.Character

			if backpack then
				for _, child in ipairs(backpack:GetChildren()) do
					if child:IsA("Tool") then
						count += 1
					end
				end
			end

			if character then
				for _, child in ipairs(character:GetChildren()) do
					if child:IsA("Tool") then
						count += 1
					end
				end
			end

			if not backpack and not character then
				local inventory = inventoryDataADI()
				for _ in pairs(inventory or {}) do
					count += 1
				end
			end

			return count
		end

		local function configuredBrainrotRarityADI(item)
			if type(item) ~= "table" then return nil end

			local explicit = (item.sub and item.sub.rarity)
				or item.rarity
				or item.Rarity
			if type(explicit) == "string"
				and RARITY_ORDER_ADI[explicit] ~= nil
			then
				return explicit
			end

			local name = item.name or (item.sub and item.sub.name)
			if type(name) ~= "string" or name == "" then
				return nil
			end

			local rarity
			pcall(function()
				rarity = EconomyMathADI.GetBrainrotRarity(name)
			end)
			return type(rarity) == "string"
				and RARITY_ORDER_ADI[rarity] ~= nil
				and rarity
				or nil
		end

		local function neverDeleteNameADI(item)
			if type(item) ~= "table" then return nil end
			local displayName
			pcall(function()
				displayName = ItemToStringADI(item, {
					rich = false,
					displayLevel = false,
					displayMutation = false,
				})
			end)
			return tostring(
				displayName
					or item.name
					or (item.sub and item.sub.name)
					or item.displayName
					or item.DisplayName
					or ""
			)
		end

		local function neverDeleteADI(item)
			local state = autoServerHopState and autoServerHopState.Utility
			if not state or state.NeverDeleteEnabled ~= true then
				return false
			end
			local selected = state.NeverDeleteItems
			if type(selected) ~= "table" then return false end
			local name = neverDeleteNameADI(item)
			return name ~= nil and name ~= "" and selected[name] == true
		end

		local function isCapacityNonBrainrotCandidateADI(item, id)
			if id == nil or type(item) ~= "table" or neverDeleteADI(item) then
				return false
			end

			if inventoryItemTypeADI(item) == "Brainrot" then
				return false
			end



			return configuredBrainrotRarityADI(item) == nil
		end

		local function nonBrainrotIdsADI()
			local ids = {}
			for id, item in pairs(inventoryDataADI() or {}) do
				if isCapacityNonBrainrotCandidateADI(item, id) then
					ids[#ids + 1] = id
				end
			end
			return ids
		end

		local function modifierCountADI(item)
			if type(item) ~= "table" then return math.huge end

			local count = 0
			local sub = type(item.sub) == "table" and item.sub or nil

			local mutation = (sub and sub.mutation) or item.mutation
			if type(mutation) == "string" then
				local lower = string.lower(mutation)
				if lower ~= "" and lower ~= "none" then
					count += 1
				end
			elseif mutation ~= nil and mutation ~= false then
				count += 1
			end

			local traits = (sub and sub.traits) or item.traits
			if type(traits) == "table" then
				for key, value in pairs(traits) do
					if value ~= nil and value ~= false then
						if type(key) == "number" then
							if tostring(value) ~= "" then
								count += 1
							end
						elseif value == true
							or type(value) == "number"
							or type(value) == "string"
							or type(value) == "table"
						then
							count += 1
						end
					end
				end
			elseif type(traits) == "string" then
				local trimmed = string.gsub(traits, "^%s*(.-)%s*$", "%1")
				if trimmed ~= "" and string.lower(trimmed) ~= "none" then
					for _ in string.gmatch(trimmed, "[^,%|;]+") do
						count += 1
					end
				end
			end

			return count
		end

		local function deletionBucketADI(item)
			if type(item) ~= "table"
				or neverDeleteADI(item)
				or inventoryItemTypeADI(item) ~= "Brainrot"
			then
				return nil
			end

			local rarity = getItemRarityADI(item)


			if rarity == "Paradox" or rarity == "Eternal" then
				return nil
			end

			local rarityRank = type(rarity) == "string"
				and RARITY_ORDER_ADI[rarity]
				or nil
			if rarityRank == nil then
				return nil
			end

			if rarity == "Infinity" then

				return brainrotIsMetaADI(item) and 1001 or 1000
			end

			return rarityRank
		end

		local function worstBrainrotIdADI()
			local inventory = inventoryDataADI()
			if not inventory then return nil end

			local worstBucket = math.huge
			for _, item in pairs(inventory) do
				local bucket = deletionBucketADI(item)
				if bucket ~= nil and bucket < worstBucket then
					worstBucket = bucket
				end
			end
			if worstBucket == math.huge then
				return nil
			end

			local minimumModifiers = math.huge
			local exactWorst = {}

			for id, item in pairs(inventory) do
				if deletionBucketADI(item) == worstBucket then
					local modifiers = modifierCountADI(item)

					if modifiers < minimumModifiers then
						minimumModifiers = modifiers
						table.clear(exactWorst)
					end

					if modifiers == minimumModifiers then
						exactWorst[#exactWorst + 1] = id
					end
				end
			end

			if #exactWorst == 0 then
				return nil
			end


			return exactWorst[math.random(1, #exactWorst)]
		end

		local function unlockInventoryEntryIfNeededADI(id)
			local inventory = inventoryDataADI()
			local item = inventory and (
				inventory[id]
				or inventory[tostring(id)]
				or (tonumber(id) and inventory[tonumber(id)] or nil)
			)
			if not item or item.locked ~= true then
				return true
			end

			if not LockInventoryItemADI then
				return false
			end

			local fired = pcall(function()
				LockInventoryItemADI:FireServer(tostring(id), false)
			end)
			if not fired then return false end

			local started = os.clock()
			repeat
				task.wait(0.05)
				inventory = inventoryDataADI()
				item = inventory and (
					inventory[id]
						or inventory[tostring(id)]
						or (tonumber(id) and inventory[tonumber(id)] or nil)
				)
				if not item or item.locked ~= true then
					return true
				end
			until os.clock() - started >= 0.75

			return false
		end

		local function deleteNonBrainrotEntryCompletelyADI(id)
			local state = autoServerHopState and autoServerHopState.Utility
			if not state
				or state.AutoDeleteWorstInventory ~= true
				or id == nil
				or deleteBlockedADI()
			then
				return false
			end

			local inventory = inventoryDataADI()
			local item = inventory and (
				inventory[id]
					or inventory[tostring(id)]
					or (tonumber(id) and inventory[tonumber(id)] or nil)
			)
			if not item then return true end
			if not isCapacityNonBrainrotCandidateADI(item, id) then
				return false
			end

			local stableType = tostring(inventoryItemTypeADI(item) or "NonBrainrot")
			local stableName = tostring(item.name or (item.sub and item.sub.name) or "")
			local stableGuid = tostring(item.guid or item.id or "")

			for confirmation = 1, 3 do
				state = autoServerHopState and autoServerHopState.Utility
				if not state
					or state.AutoDeleteWorstInventory ~= true
					or deleteBlockedADI()
				then
					return false
				end

				inventory = inventoryDataADI()
				item = inventory and (
					inventory[id]
						or inventory[tostring(id)]
						or (tonumber(id) and inventory[tonumber(id)] or nil)
				)
				if not item then return true end
				if not isCapacityNonBrainrotCandidateADI(item, id) then
					return false
				end

				local liveType = tostring(inventoryItemTypeADI(item) or "NonBrainrot")
				local liveName = tostring(item.name or (item.sub and item.sub.name) or "")
				local liveGuid = tostring(item.guid or item.id or "")
				if liveType ~= stableType
					or liveName ~= stableName
					or liveGuid ~= stableGuid
				then
					return false
				end

				if confirmation < 3 then task.wait(0.05) end
			end

			if not unlockInventoryEntryIfNeededADI(id) then
				return false
			end

			inventory = inventoryDataADI()
			item = inventory and (
				inventory[id]
					or inventory[tostring(id)]
					or (tonumber(id) and inventory[tonumber(id)] or nil)
			)
			if not item
				or deleteBlockedADI()
				or not isCapacityNonBrainrotCandidateADI(item, id)
			then
				return false
			end

			local finalType = tostring(inventoryItemTypeADI(item) or "NonBrainrot")
			local finalName = tostring(item.name or (item.sub and item.sub.name) or "")
			local finalGuid = tostring(item.guid or item.id or "")
			if finalType ~= stableType
				or finalName ~= stableName
				or finalGuid ~= stableGuid
			then
				return false
			end

			if not DeleteInventoryItemADI then
				return false
			end

			local ok, success = pcall(function()
				return DeleteInventoryItemADI:InvokeServer(tostring(id), 1)
			end)
			if not ok or success ~= true then
				return false
			end

			local ackUntil = os.clock() + 1.00
			repeat
				task.wait(0.05)
				inventory = inventoryDataADI()
				if not inventory
					or (
						inventory[id] == nil
						and inventory[tostring(id)] == nil
						and (
							not tonumber(id)
							or inventory[tonumber(id)] == nil
						)
					)
				then
					return true
				end
			until os.clock() >= ackUntil

			return false
		end

		local function deleteBrainrotEntryCompletelyADI(id)
			local state = autoServerHopState and autoServerHopState.Utility
			if not state
				or state.AutoDeleteWorstInventory ~= true
				or id == nil
				or deleteBlockedADI()
			then
				return false
			end

			local function capacityClassification(item)
				if type(item) ~= "table"
					or inventoryItemTypeADI(item) ~= "Brainrot"
				then
					return nil
				end

				local rarity = getItemRarityADI(item)
				if type(rarity) ~= "string"
					or RARITY_ORDER_ADI[rarity] == nil
					or rarity == "Paradox"
					or rarity == "Eternal"
				then
					return nil
				end

				local name = item.name or (item.sub and item.sub.name)
				return tostring(name or ""),
					rarity,
					brainrotIsMetaADI(item),
					tostring(item.guid or item.id or "")
			end

			local inventory = inventoryDataADI()
			local item = inventory and (
				inventory[id]
					or inventory[tostring(id)]
					or (tonumber(id) and inventory[tonumber(id)] or nil)
			)
			if not item then
				return false
			end

			local stableName, stableRarity, stableMeta, stableGuid =
				capacityClassification(item)
			if not stableName then
				return false
			end


			for confirmation = 1, 3 do
				state = autoServerHopState and autoServerHopState.Utility
				if not state
					or state.AutoDeleteWorstInventory ~= true
					or deleteBlockedADI()
				then
					return false
				end

				inventory = inventoryDataADI()
				item = inventory and (
					inventory[id]
						or inventory[tostring(id)]
						or (tonumber(id) and inventory[tonumber(id)] or nil)
				)
				if not item then
					return true
				end

				local name, rarity, isMeta, guid =
					capacityClassification(item)
				if name ~= stableName
					or rarity ~= stableRarity
					or isMeta ~= stableMeta
					or guid ~= stableGuid
				then
					return false
				end

				if confirmation < 3 then
					task.wait(0.05)
				end
			end

			if not unlockInventoryEntryIfNeededADI(id) then
				return false
			end



			inventory = inventoryDataADI()
			item = inventory and (
				inventory[id]
					or inventory[tostring(id)]
					or (tonumber(id) and inventory[tonumber(id)] or nil)
			)
			if not item or deleteBlockedADI() then
				return false
			end

			local finalName, finalRarity, finalMeta, finalGuid =
				capacityClassification(item)
			if finalName ~= stableName
				or finalRarity ~= stableRarity
				or finalMeta ~= stableMeta
				or finalGuid ~= stableGuid
			then
				return false
			end

			if not DeleteInventoryItemADI then
				return false
			end

			local ok, success = pcall(function()
				return DeleteInventoryItemADI:InvokeServer(tostring(id), 1)
			end)
			if not ok or success ~= true then
				return false
			end

			local ackUntil = os.clock() + 1.00
			repeat
				task.wait(0.05)
				inventory = inventoryDataADI()
				if not inventory
					or (
						inventory[id] == nil
						and inventory[tostring(id)] == nil
						and (
							not tonumber(id)
							or inventory[tonumber(id)] == nil
						)
					)
				then
					return true
				end
			until os.clock() >= ackUntil

			return false
		end

		while screenGui.Parent do
			task.wait(0.10)

			local state = autoServerHopState and autoServerHopState.Utility
			if deleteBusyADI
				or not state
				or state.AutoDeleteWorstInventory ~= true
				or deleteBlockedADI()
			then
				continue
			end

			local threshold = math.clamp(
				math.floor(
					tonumber(state.DeleteInventoryThreshold) or 95
				),
				1,
				100
			)



			if effectiveInventoryCountADI() < threshold then
				continue
			end

			local deleteNonFirst = state.DeleteNonBrainrotsFirst == true
			local deleteBrainrotFirst = state.DeleteWorstBrainrotsFirst == true

			if not deleteNonFirst and not deleteBrainrotFirst then
				continue
			end

			local brainrotId = worstBrainrotIdADI()
			local junkIds = nonBrainrotIdsADI()
			local junkId = #junkIds > 0
				and junkIds[math.random(1, #junkIds)]
				or nil

			local selectedId
			local selectedKind

			if deleteNonFirst then
				if junkId ~= nil then
					selectedId = junkId
					selectedKind = "NonBrainrot"
				elseif brainrotId ~= nil then
					selectedId = brainrotId
					selectedKind = "Brainrot"
				end
			else
				if brainrotId ~= nil then
					selectedId = brainrotId
					selectedKind = "Brainrot"
				elseif junkId ~= nil then
					selectedId = junkId
					selectedKind = "NonBrainrot"
				end
			end

			if selectedId == nil then
				continue
			end

			deleteBusyADI = true
			if selectedKind == "NonBrainrot" then
				pcall(deleteNonBrainrotEntryCompletelyADI, selectedId)
			else
				pcall(deleteBrainrotEntryCompletelyADI, selectedId)
			end
			deleteBusyADI = false
		end
	end)
end







if IS_MINIGAME_PLACE then
    task.spawn(function()
        while screenGui.Parent do
            local utility = autoServerHopState and autoServerHopState.Utility
            local anyEnabled = false
            if utility
                and utility.PauseScript ~= true
                and utility.PauseMinigameFeatures ~= true
                and utility.AutoOfferMaster == true
            then
                for _, config in pairs(autoOfferState or {}) do
                    if type(config) == "table" and config.Enabled == true then
                        anyEnabled = true
                        break
                    end
                end
                if utility.AutoOfferTokensEnabled == true then anyEnabled = true end
            end
            if anyEnabled then break end
            task.wait(0.10)
        end
        if not screenGui.Parent then return end
        local RSAO = game:GetService("ReplicatedStorage")

        local function requireAO(moduleScript)
            while screenGui.Parent do
                local ok, result = pcall(require, moduleScript)
                if ok and result ~= nil then return result end
                task.wait(0.25)
            end
        end

        local clientModules = RSAO:WaitForChild("Client"):WaitForChild("Modules")
        local shared = RSAO:WaitForChild("Shared")
        local ReplicatorAO = requireAO(clientModules:WaitForChild("ReplicatorClient"))
        local RemotesAO = requireAO(shared:WaitForChild("Remotes"))
        local SortItemsAO = requireAO(clientModules:WaitForChild("utils"):WaitForChild("SortItems"))
        local GetItemTypeAO = requireAO(shared:WaitForChild("utils"):WaitForChild("GetItemType"))
        local ItemIsTradeableAO = requireAO(shared:WaitForChild("utils"):WaitForChild("ItemIsTradeable"))
        local EconomyMathAO = requireAO(shared:WaitForChild("utils"):WaitForChild("EconomyMath"))
        local BrainrotsConfigAO = requireAO(shared:WaitForChild("Config"):WaitForChild("Brainrots"))

        if not (ReplicatorAO and RemotesAO and SortItemsAO and GetItemTypeAO
            and ItemIsTradeableAO and EconomyMathAO and BrainrotsConfigAO)
        then
            return
        end

        local SetSlotAO = RemotesAO.NegotiationSetSlot
        local OfferCurrencyAO = RemotesAO.NegotiationOfferCurrency
        local playerDataAO
        local negotiationAO
        local lastAppliedSignature
        local pendingSignature
        local pendingContext
        local reactionDueAt = 0
        local opponentItemCache = {}
        local configuredRarityAO = {}
        if type(BrainrotsConfigAO) == "table" then
            for _, rarity in ipairs(BrainrotsConfigAO.ClassNames or {}) do
                local entries = (BrainrotsConfigAO.Chances or {})[rarity]
                if type(entries) == "table" then
                    for name in pairs(entries) do
                        if type(name) == "string" then
                            configuredRarityAO[name] = rarity
                        end
                    end
                end
            end
            for name, rarity in pairs(BrainrotsConfigAO.BrainrotRarities or {}) do
                if type(name) == "string" and type(rarity) == "string" then
                    configuredRarityAO[name] = rarity
                end
            end
        end

        local function refreshAO()
            pcall(function() playerDataAO = ReplicatorAO.get("PlayerData") or playerDataAO end)
            pcall(function() negotiationAO = ReplicatorAO.get("ActiveNegotiation") or negotiationAO end)
        end

        local function tryIndexAO(root, path)
            if not root then return nil end
            local ok, value = pcall(function() return root:TryIndex(path) end)
            return ok and value or nil
        end

        local function hasMetaMarkerAO(item)
            if type(item) ~= "table" then return false end
            local explicit = item.rarity or item.Rarity
                or (item.sub and (item.sub.rarity or item.sub.Rarity))
            if explicit == "Meta"
                or item.Meta == true
                or item.IsMeta == true
                or (item.sub and (item.sub.Meta == true or item.sub.IsMeta == true))
            then
                return true
            end
            local name = item.name or (item.sub and item.sub.name)
            return type(name) == "string"
                and string.find(string.lower(name), "%f[%a]meta%f[%A]") ~= nil
        end

        local function rarityAO(item)
            if type(item) ~= "table" then return nil end






            local name = item.name or (item.sub and item.sub.name)
            local configured = type(name) == "string"
                and configuredRarityAO[name]
                or nil
            if type(configured) == "string" and autoOfferState[configured] ~= nil then
                if configured == "Infinity" and hasMetaMarkerAO(item) then
                    return "Meta"
                end
                return configured
            end

            local explicit = item.rarity or item.Rarity
                or (item.sub and (item.sub.rarity or item.sub.Rarity))
            if type(explicit) == "string" and autoOfferState[explicit] ~= nil then
                if explicit == "Infinity" and hasMetaMarkerAO(item) then
                    return "Meta"
                end
                return explicit
            end

            local itemType
            pcall(function() itemType = GetItemTypeAO(item) end)
            if itemType ~= "Brainrot" then return nil end
            local value
            pcall(function() value = EconomyMathAO.GetBrainrotRarity(item.name) end)
            if type(value) ~= "string" or autoOfferState[value] == nil then
                return nil
            end
            if value == "Infinity" and hasMetaMarkerAO(item) then
                return "Meta"
            end
            return value
        end

        local function opponentSourcesAO()
            local slots = tryIndexAO(negotiationAO, {"player2", "slots"})
            if type(slots) ~= "table" then slots = {} end

            local sourceCounts = {}
            local signature = {}
            for slotIndex = 1, 6 do
                local value = slots[tostring(slotIndex)]
                if value == nil then value = slots[slotIndex] end
                local id = type(value) == "table" and value.id or value
                local item = type(value) == "table" and value.item or nil
                local cacheKey = tostring(slotIndex)

                if type(item) == "table" and rarityAO(item) then
                    opponentItemCache[cacheKey] = {id = tostring(id or ""), item = item}
                elseif id ~= nil then
                    local cached = opponentItemCache[cacheKey]
                    if cached and cached.id == tostring(id) then item = cached.item end
                else
                    opponentItemCache[cacheKey] = nil
                end

                local rarity = rarityAO(item)
                if rarity then
                    sourceCounts[rarity] = (sourceCounts[rarity] or 0) + 1
                end
                signature[#signature + 1] = tostring(id or "") .. ":" .. tostring(rarity or "")
            end

            local tokens = math.max(0, math.floor(tonumber(
                tryIndexAO(negotiationAO, {"player2", "currency"})
            ) or 0))
            signature[#signature + 1] = "T=" .. tostring(tokens)
            return sourceCounts, tokens, table.concat(signature, "|")
        end

        local function inventoryAO()
            local inv = tryIndexAO(playerDataAO, {"Inventory"})
            return type(inv) == "table" and inv or nil
        end

        local function tokenBalanceAO()
            return math.max(0, math.floor(tonumber(tryIndexAO(playerDataAO, {"TradeTokens"})) or 0))
        end

        local function findRarityItemAO(targetRarity, usedIds)
            local inv = inventoryAO()
            if not inv then return nil end
            local ids = {}
            local ok, sorted = pcall(SortItemsAO, inv)
            if ok and type(sorted) == "table" then
                ids = sorted
            else
                for id in pairs(inv) do ids[#ids + 1] = id end
            end
            for _, id in ipairs(ids) do
                local item = inv[id] or inv[tostring(id)]
                local sid = tostring(id)
                if (not usedIds or not usedIds[sid])
                    and type(item) == "table"
                    and not item.locked
                    and rarityAO(item) == targetRarity
                then



                    local tradeable = targetRarity == "Paradox"
                        or targetRarity == "Eternal"
                        or targetRarity == "Meta"
                    if not tradeable then
                        pcall(function() tradeable = ItemIsTradeableAO(item) == true end)
                    end
                    if tradeable then return sid end
                end
            end
            return nil
        end

        local function availableRarityCountsAO()
            local counts = {}
            local inv = inventoryAO()
            if not inv then return counts end

            for _, item in pairs(inv) do
                if type(item) == "table" and not item.locked then
                    local itemRarity = rarityAO(item)
                    if itemRarity then
                        local tradeable = itemRarity == "Paradox"
                            or itemRarity == "Eternal"
                            or itemRarity == "Meta"
                        if not tradeable then
                            pcall(function() tradeable = ItemIsTradeableAO(item) == true end)
                        end
                        if tradeable then
                            counts[itemRarity] = (counts[itemRarity] or 0) + 1
                        end
                    end
                end
            end
            return counts
        end

        local function invokeAO(remote, ...)
            if not remote then return false end
            local args = table.pack(...)
            return pcall(function()
                return remote:InvokeServer(table.unpack(args, 1, args.n))
            end)
        end

        local function slotIdAO(slotIndex)
            local slots = tryIndexAO(negotiationAO, {"player1", "slots"}) or {}
            local value = slots[tostring(slotIndex)]
            if value == nil then value = slots[slotIndex] end
            return type(value) == "table" and value.id or value
        end

        local function sameIdAO(a, b)
            if a == b then return true end
            return a ~= nil and b ~= nil and tostring(a) == tostring(b)
        end

        local function setCurrencyAO(expectedGuid, amount)
            amount = math.max(0, math.floor(tonumber(amount) or 0))
            for _ = 1, 3 do
                if autoServerHopState.Utility.PauseScript == true
                or autoServerHopState.Utility.PauseMinigameFeatures == true
                    or tryIndexAO(negotiationAO, {"guid"}) ~= expectedGuid
                then
                    return false
                end
                local current = math.max(
                    0,
                    math.floor(tonumber(
                        tryIndexAO(negotiationAO, {"player1", "currency"})
                    ) or 0)
                )
                if current == amount then return true end
                invokeAO(OfferCurrencyAO, amount)
                task.wait(math.clamp(
                    (autoServerHopState.Utility.CustomDelays == true
                        and tonumber(
                            current < amount
                                and autoServerHopState.Utility.AddTokenDelay
                                or autoServerHopState.Utility.RemoveTokenDelay
                        ))
                        or 0,
                    0,
                    5
                ))
                local verifyUntil = os.clock() + 0.35
                while tryIndexAO(negotiationAO, {"guid"}) == expectedGuid
                    and os.clock() < verifyUntil
                do
                    local replicated = math.max(
                        0,
                        math.floor(tonumber(
                            tryIndexAO(negotiationAO, {"player1", "currency"})
                        ) or 0)
                    )
                    if replicated == amount then return true end
                    task.wait(0.02)
                end
            end
            return false
        end

        local function setDesiredItemsAO(expectedGuid, desiredIds)
            for attempt = 1, 3 do
                if autoServerHopState.Utility.PauseScript == true
                or autoServerHopState.Utility.PauseMinigameFeatures == true
                    or tryIndexAO(negotiationAO, {"guid"}) ~= expectedGuid
                then
                    return false
                end

                for slotIndex = 1, 6 do
                    if tryIndexAO(negotiationAO, {"guid"}) ~= expectedGuid then
                        return false
                    end
                    local currentId = slotIdAO(slotIndex)
                    local desiredId = desiredIds[slotIndex]
                    if currentId ~= nil and not sameIdAO(currentId, desiredId) then
                        invokeAO(SetSlotAO, tostring(slotIndex), nil)
                        task.wait(math.clamp(
                            (autoServerHopState.Utility.CustomDelays == true
                                and tonumber(autoServerHopState.Utility.RemoveBrainrotDelay))
                                or 0.1125,
                            0,
                            5
                        ))
                    end
                end

                for slotIndex = 1, 6 do
                    if tryIndexAO(negotiationAO, {"guid"}) ~= expectedGuid then
                        return false
                    end
                    local desiredId = desiredIds[slotIndex]
                    local currentId = slotIdAO(slotIndex)
                    if desiredId ~= nil and not sameIdAO(currentId, desiredId) then
                        invokeAO(SetSlotAO, tostring(slotIndex), desiredId)
                        task.wait(math.clamp(
                            (autoServerHopState.Utility.CustomDelays == true
                                and tonumber(autoServerHopState.Utility.AddBrainrotDelay))
                                or 0.234375,
                            0,
                            5
                        ))
                    end
                end

                local verified = true
                for slotIndex = 1, 6 do
                    if not sameIdAO(slotIdAO(slotIndex), desiredIds[slotIndex]) then
                        verified = false
                        break
                    end
                end
                if verified then return true end
                task.wait(0.03 * attempt)
            end
            return false
        end

        while screenGui.Parent do
            local utilityAO = autoServerHopState.Utility
            if utilityAO.PauseScript == true
                or utilityAO.PauseMinigameFeatures == true
                or utilityAO.AutoOfferMaster ~= true
            then
                lastAppliedSignature = nil
                pendingSignature = nil
                pendingContext = nil
                reactionDueAt = 0
                task.wait(0.08)
                continue
            end

            refreshAO()
            local guid = tryIndexAO(negotiationAO, {"guid"})
            if not guid then
                lastAppliedSignature = nil
                pendingSignature = nil
                pendingContext = nil
                reactionDueAt = 0
                table.clear(opponentItemCache)
                if autoServerHopState and autoServerHopState.Utility then
                    autoServerHopState.Utility._AutoOfferReactiveGuid = nil
                end
                task.wait(0.10)
                continue
            end

            local autoOfferAlreadyOwnsAO =
                tostring(utilityAO._AutoOfferReactiveGuid or "") == tostring(guid)
            local sourceCounts, opponentTokens, offerSignature = opponentSourcesAO()
            local aggregateTargets = {}
            local aggregateFallbackTargets = {}
            local aggregateFallbackRequests = {}
            local aggregateTokens = 0
            local aggregateSignature = {}
            local hasEnabledSource = false
            local tokenRuleAuthoritative = false
            local fallbackRuleAuthoritative = false
            local openingTakeoverAO = false

            local fallbackEnabled = utilityAO.FallbackOffers == true
                and (
                    utilityAO.FallbackToTokens == true
                    or utilityAO.FallbackToNextLowerRarityBrainrot == true
                )






            local availableCounts = availableRarityCountsAO()
            local plannedInventoryUse = {}
            local primaryRequests = {}
            local sourceOccurrences = {}

            local function nextLowerRarityAO(rarity)
                local index = table.find(BRAINROT_RARITY_OPTIONS, rarity)
                return index and index > 1 and BRAINROT_RARITY_OPTIONS[index - 1] or nil
            end

            local function availableForRarityAO(rarity)
                return math.max(
                    0,
                    math.floor(tonumber(availableCounts[rarity]) or 0)
                        - math.floor(tonumber(plannedInventoryUse[rarity]) or 0)
                )
            end

            local function reservePrimaryAO(rarity, wanted, slotBudget)
                wanted = math.max(0, math.floor(tonumber(wanted) or 0))
                slotBudget = math.max(0, math.floor(tonumber(slotBudget) or 0))
                if wanted <= 0 or slotBudget <= 0 then return 0 end
                local reserved = math.min(wanted, slotBudget, availableForRarityAO(rarity))
                if reserved > 0 then
                    plannedInventoryUse[rarity] =
                        (plannedInventoryUse[rarity] or 0) + reserved
                    aggregateTargets[rarity] = (aggregateTargets[rarity] or 0) + reserved
                end
                return reserved
            end

            local function reserveFallbackAO(rarity, wanted, slotBudget)
                wanted = math.max(0, math.floor(tonumber(wanted) or 0))
                slotBudget = math.max(0, math.floor(tonumber(slotBudget) or 0))
                if wanted <= 0 or slotBudget <= 0 then return 0 end
                local reserved = math.min(wanted, slotBudget, availableForRarityAO(rarity))
                if reserved > 0 then
                    plannedInventoryUse[rarity] =
                        (plannedInventoryUse[rarity] or 0) + reserved
                    aggregateFallbackTargets[rarity] =
                        (aggregateFallbackTargets[rarity] or 0) + reserved
                end
                return reserved
            end

            local function markOccurrenceFallbackAO(occurrence, targetRarity)
                if not occurrence then return end
                occurrence.NeedsFallback = true
                occurrence.MissingTargets = occurrence.MissingTargets or {}
                occurrence.MissingTargets[targetRarity] = true
                fallbackRuleAuthoritative = true
            end




            for _, sourceRarity in ipairs(BRAINROT_RARITY_OPTIONS) do
                local sourceCount = math.max(
                    0,
                    math.floor(tonumber(sourceCounts[sourceRarity]) or 0)
                )
                local config = autoOfferState[sourceRarity]
                if sourceCount > 0 and type(config) == "table" and config.Enabled == true then
                    hasEnabledSource = true
                    local perItemTokens = math.clamp(
                        math.floor(tonumber(config.Tokens) or 0), 0, 100000
                    )
                    local targets = type(config.Targets) == "table" and config.Targets or {}
                    local sourceHasConfiguredResponseAO = perItemTokens > 0
                    if not sourceHasConfiguredResponseAO then
                        for _, targetRarityAO in ipairs(BRAINROT_RARITY_OPTIONS) do
                            if targets[targetRarityAO] == true then
                                sourceHasConfiguredResponseAO = true
                                break
                            end
                        end
                    end
                    if sourceHasConfiguredResponseAO then
                        openingTakeoverAO = true
                    end

                    for sourceIndex = 1, sourceCount do
                        aggregateTokens += perItemTokens
                        local occurrence = {
                            SourceRarity = sourceRarity,
                            SourceIndex = sourceIndex,
                            NeedsFallback = false,
                            MissingTargets = {},
                        }
                        sourceOccurrences[#sourceOccurrences + 1] = occurrence

                        for _, targetRarity in ipairs(BRAINROT_RARITY_OPTIONS) do
                            if targets[targetRarity] then
                                local perItemAmount = math.clamp(
                                    math.floor(tonumber(
                                        config.Amounts and config.Amounts[targetRarity]
                                    ) or 1),
                                    1,
                                    6
                                )
                                primaryRequests[#primaryRequests + 1] = {
                                    Rarity = targetRarity,
                                    Amount = perItemAmount,
                                    Occurrence = occurrence,
                                }
                            end
                        end
                    end

                    aggregateSignature[#aggregateSignature + 1] =
                        sourceRarity .. "x" .. tostring(sourceCount)
                end
            end




            if utilityAO.AutoOfferTokensEnabled == true then
                local matchTokens = utilityAO.AutoOfferMatchTokensWithTokens == true
                local targetRarity = utilityAO.AutoOfferTokenRarity
                local validBrainrotRule = utilityAO.AutoOfferMatchTokensWithBrainrots == true
                    and type(targetRarity) == "string"
                    and table.find(BRAINROT_RARITY_OPTIONS, targetRarity) ~= nil

                if matchTokens or validBrainrotRule then
                    hasEnabledSource = true
                    aggregateSignature[#aggregateSignature + 1] =
                        "Tokens=" .. tostring(opponentTokens)

                    if matchTokens then
                        local lowestTokensToMatch = math.clamp(
                            math.floor(tonumber(utilityAO.AutoOfferLowestTokensToMatch) or 1),
                            1,
                            100000
                        )
                        if opponentTokens >= lowestTokensToMatch then
                            openingTakeoverAO = true
                            local tokenAddRatio = math.clamp(
                                math.floor(tonumber(utilityAO.AutoOfferTokenAddRatio) or 1),
                                1,
                                10
                            )
                            aggregateTokens += math.max(0, opponentTokens) * tokenAddRatio
                        end
                    end

                    if validBrainrotRule then
                        local tokenUnit = math.clamp(
                            math.floor(tonumber(utilityAO.AutoOfferTokenAmount) or 0),
                            0,
                            100000
                        )
                        if tokenUnit > 0 then
                            local brainrotUnits = math.floor(math.max(0, opponentTokens) / tokenUnit)
                            if brainrotUnits > 0 then
                                openingTakeoverAO = true
                                primaryRequests[#primaryRequests + 1] = {
                                    Rarity = targetRarity,
                                    Amount = brainrotUnits,
                                    Occurrence = nil,
                                }
                            end
                        end
                    end
                end
            end





            if openingTakeoverAO then
                utilityAO._AutoOfferReactiveGuid = tostring(guid)
            end
            local autoOfferOwnsAO = openingTakeoverAO or autoOfferAlreadyOwnsAO
            if utilityAO.AutoOfferTokensEnabled == true
                and (
                    utilityAO.AutoOfferMatchTokensWithTokens == true
                    or utilityAO.AutoOfferMatchTokensWithBrainrots == true
                )
                and autoOfferOwnsAO
            then





                tokenRuleAuthoritative = true
            end





            local selectionSlotsLeft = 6
            for rarityIndex = #BRAINROT_RARITY_OPTIONS, 1, -1 do
                local rarity = BRAINROT_RARITY_OPTIONS[rarityIndex]
                for _, request in ipairs(primaryRequests) do
                    if request.Rarity == rarity then
                        local wanted = math.max(0, math.floor(tonumber(request.Amount) or 0))
                        local selected = math.min(wanted, selectionSlotsLeft)
                        local overflow = wanted - selected
                        if overflow > 0 then
                            markOccurrenceFallbackAO(request.Occurrence, rarity)
                        end

                        if selected > 0 then
                            local reserved = reservePrimaryAO(rarity, selected, selectionSlotsLeft)
                            if reserved < selected then
                                markOccurrenceFallbackAO(request.Occurrence, rarity)
                            end
                            selectionSlotsLeft -= selected
                        end
                    end
                end
            end




            if fallbackEnabled then
                for _, occurrence in ipairs(sourceOccurrences) do
                    if occurrence.NeedsFallback == true then
                        if utilityAO.FallbackToTokens == true then
                            aggregateTokens += math.clamp(
                                math.floor(tonumber(
                                    utilityAO["FallbackTokens" .. occurrence.SourceRarity]
                                ) or 0),
                                0,
                                100000
                            )
                        end

                        if utilityAO.FallbackToNextLowerRarityBrainrot == true then
                            local lowerAmount = math.clamp(
                                math.floor(tonumber(
                                    utilityAO.FallbackNextLowerRarityAmount
                                ) or 1),
                                1,
                                6
                            )
                            for missingRarity in pairs(occurrence.MissingTargets or {}) do
                                local lowerRarity = nextLowerRarityAO(missingRarity)
                                if lowerRarity then
                                    aggregateFallbackRequests[lowerRarity] =
                                        (aggregateFallbackRequests[lowerRarity] or 0)
                                        + lowerAmount
                                end
                            end
                        end
                    end
                end
            end






            local reservedPrimarySlots = 0
            for _, amount in pairs(aggregateTargets) do
                reservedPrimarySlots += math.max(0, math.floor(tonumber(amount) or 0))
            end
            local fallbackSlotsLeft = math.max(0, 6 - reservedPrimarySlots)
            if fallbackEnabled
                and utilityAO.FallbackToNextLowerRarityBrainrot == true
                and fallbackSlotsLeft > 0
            then
                for rarityIndex = #BRAINROT_RARITY_OPTIONS, 1, -1 do
                    local fallbackRarity = BRAINROT_RARITY_OPTIONS[rarityIndex]
                    local wantedFallback = math.max(
                        0,
                        math.floor(tonumber(aggregateFallbackRequests[fallbackRarity]) or 0)
                    )
                    if wantedFallback > 0 then
                        local reserved = reserveFallbackAO(
                            fallbackRarity,
                            wantedFallback,
                            fallbackSlotsLeft
                        )
                        fallbackSlotsLeft -= reserved
                        if fallbackSlotsLeft <= 0 then break end
                    end
                end
            end

            if not hasEnabledSource and not autoOfferOwnsAO then
                lastAppliedSignature = nil
                pendingSignature = nil
                pendingContext = nil
                reactionDueAt = 0
                task.wait(0.08)
                continue
            end

            local targetSignature = {}
            local requestedSlots = 0
            for _, targetRarity in ipairs(BRAINROT_RARITY_OPTIONS) do
                local amount = math.max(
                    0,
                    math.floor(tonumber(aggregateTargets[targetRarity]) or 0)
                )
                local fallbackAmount = math.max(
                    0,
                    math.floor(tonumber(aggregateFallbackTargets[targetRarity]) or 0)
                )
                if amount > 0 then
                    targetSignature[#targetSignature + 1] =
                        targetRarity .. "=" .. tostring(amount)
                    requestedSlots += amount
                end
                if fallbackAmount > 0 then
                    targetSignature[#targetSignature + 1] =
                        "FB-" .. targetRarity .. "=" .. tostring(fallbackAmount)
                    requestedSlots += fallbackAmount
                end
            end

            if requestedSlots <= 0 and aggregateTokens <= 0
                and not tokenRuleAuthoritative
                and not fallbackRuleAuthoritative
                and not autoOfferOwnsAO
            then
                pendingSignature = nil
                pendingContext = nil
                reactionDueAt = 0
                task.wait(0.08)
                continue
            end

            local desiredSignature = tostring(guid)
                .. ":" .. tostring(offerSignature)
                .. ":SRC=" .. table.concat(aggregateSignature, ",")
                .. ":OUT=" .. table.concat(targetSignature, ",")
                .. ":T=" .. tostring(aggregateTokens)

            if desiredSignature == lastAppliedSignature then
                pendingSignature = nil
                pendingContext = nil
                reactionDueAt = 0
                task.wait(0.06)
                continue
            end

            local reactionContext = tostring(guid)
            if pendingContext ~= reactionContext then
                pendingContext = reactionContext
                pendingSignature = desiredSignature
                reactionDueAt = os.clock() + math.clamp(
                    (autoServerHopState.Utility.CustomDelays == true
                        and tonumber(autoServerHopState.Utility.ReactionDelay)) or 1.6875, 0, 5
                )
            elseif pendingSignature ~= desiredSignature then


                pendingSignature = desiredSignature
            end

            if os.clock() < reactionDueAt then
                task.wait(0.03)
                continue
            end

            local desiredIds = {}
            local usedIds = {}
            local slotIndex = 1



            for rarityIndex = #BRAINROT_RARITY_OPTIONS, 1, -1 do
                local targetRarity = BRAINROT_RARITY_OPTIONS[rarityIndex]
                local wanted = math.max(
                    0,
                    math.floor(tonumber(aggregateTargets[targetRarity]) or 0)
                )
                for _ = 1, wanted do
                    if slotIndex > 6 then break end
                    local itemId = findRarityItemAO(targetRarity, usedIds)
                    if not itemId then break end
                    usedIds[itemId] = true
                    desiredIds[slotIndex] = itemId
                    slotIndex += 1
                end
                if slotIndex > 6 then break end
            end

            if slotIndex <= 6 then
                for rarityIndex = #BRAINROT_RARITY_OPTIONS, 1, -1 do
                    local targetRarity = BRAINROT_RARITY_OPTIONS[rarityIndex]
                    local wanted = math.max(
                        0,
                        math.floor(tonumber(aggregateFallbackTargets[targetRarity]) or 0)
                    )
                    for _ = 1, wanted do
                        if slotIndex > 6 then break end
                        local itemId = findRarityItemAO(targetRarity, usedIds)
                        if not itemId then break end
                        usedIds[itemId] = true
                        desiredIds[slotIndex] = itemId
                        slotIndex += 1
                    end
                    if slotIndex > 6 then break end
                end
            end



            local tokenAmount = math.min(
                math.max(0, math.floor(aggregateTokens)),
                tokenBalanceAO()
            )
            local tokenOk = setCurrencyAO(guid, tokenAmount)
            local itemOk = tryIndexAO(negotiationAO, {"guid"}) == guid
                and setDesiredItemsAO(guid, desiredIds)

            if tokenOk and itemOk and tryIndexAO(negotiationAO, {"guid"}) == guid then
                lastAppliedSignature = desiredSignature
                pendingSignature = nil
                pendingContext = nil
                reactionDueAt = 0
            else
                reactionDueAt = os.clock() + 0.10
            end
            task.wait(0.05)
        end
    end)
end








if IS_MINIGAME_PLACE then
	task.spawn(function()
		while screenGui.Parent do
			local anyEnabled = false
			if autoServerHopState.Utility.PauseScript ~= true
			and autoServerHopState.Utility.PauseMinigameFeatures ~= true
				and autoServerHopState.Utility.AutoAcceptMaster == true
			then
				for _, entry in pairs(autoAcceptState or {}) do
					if type(entry) == "table" and entry.Enabled == true then
						anyEnabled = true
						break
					end
				end
			end
			if anyEnabled then break end
			task.wait(0.10)
		end
		if not screenGui.Parent then return end
		local RSAAC = game:GetService("ReplicatedStorage")

		local function requireAAC(moduleScript)
			while screenGui.Parent do
				local ok, result = pcall(require, moduleScript)
				if ok and result ~= nil then
					return result
				end
				task.wait(0.25)
			end
		end

		local clientModules = RSAAC:WaitForChild("Client"):WaitForChild("Modules")
		local shared = RSAAC:WaitForChild("Shared")
		local ReplicatorAAC = requireAAC(clientModules:WaitForChild("ReplicatorClient"))
		local RemotesAAC = requireAAC(shared:WaitForChild("Remotes"))
		local GetItemTypeAAC = requireAAC(shared:WaitForChild("utils"):WaitForChild("GetItemType"))
		local EconomyMathAAC = requireAAC(shared:WaitForChild("utils"):WaitForChild("EconomyMath"))
		local BrainrotsConfigAAC = requireAAC(shared:WaitForChild("Config"):WaitForChild("Brainrots"))

		if not (ReplicatorAAC and RemotesAAC and GetItemTypeAAC
			and EconomyMathAAC and BrainrotsConfigAAC)
		then
			return
		end

		local ReadyAAC = RemotesAAC.NegotiationReady
		if not ReadyAAC then
			return
		end

		local negotiationAAC
		local opponentItemCacheAAC = {}
		local lastReadySignatureAAC
		local pendingReadySignatureAAC
		local readyDueAtAAC = 0
		local configuredRarityAAC = {}
		if type(BrainrotsConfigAAC) == "table" then
			for _, rarity in ipairs(BrainrotsConfigAAC.ClassNames or {}) do
				local entries = (BrainrotsConfigAAC.Chances or {})[rarity]
				if type(entries) == "table" then
					for name in pairs(entries) do
						if type(name) == "string" then
							configuredRarityAAC[name] = rarity
						end
					end
				end
			end
			for name, rarity in pairs(BrainrotsConfigAAC.BrainrotRarities or {}) do
				if type(name) == "string" and type(rarity) == "string" then
					configuredRarityAAC[name] = rarity
				end
			end
		end

		local function refreshAAC()
			pcall(function()
				negotiationAAC = ReplicatorAAC.get("ActiveNegotiation") or negotiationAAC
			end)
		end

		local function tryIndexAAC(root, path)
			if not root then
				return nil
			end
			local ok, value = pcall(function()
				return root:TryIndex(path)
			end)
			return ok and value or nil
		end

		local function rarityAAC(item)
			if type(item) ~= "table" then return nil end

			local name = item.name or (item.sub and item.sub.name)
			local explicit = item.rarity
				or item.Rarity
				or (item.sub and (item.sub.rarity or item.sub.Rarity))
			if explicit == "Meta" then return "Meta" end

			local baseRarity = type(explicit) == "string"
				and autoAcceptState[explicit] ~= nil
				and explicit
				or nil
			if not baseRarity and type(name) == "string" then
				local configured = configuredRarityAAC[name]
				if type(configured) == "string" and autoAcceptState[configured] ~= nil then
					baseRarity = configured
				end
			end

			if not baseRarity then
				local itemType
				pcall(function() itemType = GetItemTypeAAC(item) end)
				if itemType ~= "Brainrot" then return nil end
				pcall(function() baseRarity = EconomyMathAAC.GetBrainrotRarity(name) end)
			end

			if type(baseRarity) ~= "string" or autoAcceptState[baseRarity] == nil then
				return nil
			end

			local metaMarked = item.Meta == true
				or item.IsMeta == true
				or (item.sub and (item.sub.Meta == true or item.sub.IsMeta == true))
				or (type(name) == "string"
					and string.find(string.lower(name), "%f[%a]meta%f[%A]") ~= nil)
			return baseRarity == "Infinity" and metaMarked and "Meta" or baseRarity
		end

		local function opponentOfferAAC()
			local counts = {}
			local signatureParts = {}
			local slots = tryIndexAAC(negotiationAAC, {"player2", "slots"})
			if type(slots) ~= "table" then
				slots = {}
			end

			for slotIndex = 1, 6 do
				local value = slots[tostring(slotIndex)]
				if value == nil then
					value = slots[slotIndex]
				end

				local id = type(value) == "table" and value.id or value
				signatureParts[#signatureParts + 1] = tostring(id or "")

				local item = type(value) == "table" and value.item or nil
				local cacheKey = tostring(slotIndex)
				if type(item) == "table" and rarityAAC(item) then
					opponentItemCacheAAC[cacheKey] = {
						id = tostring(id or ""),
						item = item,
					}
				elseif id ~= nil then
					local cached = opponentItemCacheAAC[cacheKey]
					if cached and cached.id == tostring(id) then
						item = cached.item
					end
				else
					opponentItemCacheAAC[cacheKey] = nil
				end

				local rarity = rarityAAC(item)
				if rarity then
					counts[rarity] = (counts[rarity] or 0) + 1
				end
			end

			local tokens = math.max(
				0,
				math.floor(
					tonumber(
						tryIndexAAC(negotiationAAC, {"player2", "currency"})
					) or 0
				)
			)
			signatureParts[#signatureParts + 1] = "T=" .. tostring(tokens)

			return counts, tokens, table.concat(signatureParts, "|")
		end

		local function requirementsMatchAAC(counts, tokens)
			local enabledCount = 0
			local matchedAny = false

			for _, rarity in ipairs({
				"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythical",
				"Cosmic", "Secret", "Celestial", "Divine", "Infinity", "Meta", "Paradox",
				"Eternal",
			}) do
				local config = autoAcceptState[rarity]
				if config and config.Enabled == true then
					enabledCount += 1
					local wanted = math.clamp(
						math.floor(tonumber(config.Amount) or 1),
						1,
						6
					)
					if (counts[rarity] or 0) >= wanted then
						matchedAny = true
					end
				end
			end

			local tokenConfig = autoAcceptState.Tokens
			if tokenConfig and tokenConfig.Enabled == true then
				enabledCount += 1
				local wantedTokens = math.clamp(
					math.floor(tonumber(tokenConfig.Amount) or 1),
					1,
					100000
				)
				if tokens >= wantedTokens then
					matchedAny = true
				end
			end

			return matchedAny, enabledCount
		end

		while screenGui.Parent do
			local utilityAAC = autoServerHopState.Utility
			if utilityAAC.PauseScript == true
			or utilityAAC.PauseMinigameFeatures == true
				or utilityAAC.AutoAcceptMaster ~= true
			then


				if lastReadySignatureAAC then
					refreshAAC()
					if tryIndexAAC(negotiationAAC, {"player1", "ready"}) == true then
						local version =
							tryIndexAAC(negotiationAAC, {"timers", "version"}) or 0
						pcall(function() ReadyAAC:FireServer(false, version) end)
					end
				end
				lastReadySignatureAAC = nil
				pendingReadySignatureAAC = nil
				readyDueAtAAC = 0
				table.clear(opponentItemCacheAAC)
				task.wait(0.08)
				continue
			end

			refreshAAC()
			local guid = tryIndexAAC(negotiationAAC, {"guid"})
			if not guid then
				lastReadySignatureAAC = nil
				pendingReadySignatureAAC = nil
				readyDueAtAAC = 0
				table.clear(opponentItemCacheAAC)
				task.wait(0.10)
				continue
			end

			local counts, tokens, offerSignature = opponentOfferAAC()
			local matches, enabledCount = requirementsMatchAAC(counts, tokens)
			if enabledCount == 0 then
				lastReadySignatureAAC = nil
				pendingReadySignatureAAC = nil
				readyDueAtAAC = 0
				task.wait(0.10)
				continue
			end

			local localReady = tryIndexAAC(
				negotiationAAC,
				{"player1", "ready"}
			) == true
			local version = tryIndexAAC(
				negotiationAAC,
				{"timers", "version"}
			) or 0

			if not matches then
				lastReadySignatureAAC = nil
				pendingReadySignatureAAC = nil
				readyDueAtAAC = 0
				if localReady then
					pcall(function()
						ReadyAAC:FireServer(false, version)
					end)
				end
				task.wait(0.08)
				continue
			end

			local lastUpdate = tonumber(
				tryIndexAAC(
					negotiationAAC,
					{"timers", "lastUpdate"}
				)
			) or -1
			local stable = lastUpdate + 3 < workspace:GetServerTimeNow()
			local readySignature = tostring(guid)
				.. ":"
				.. offerSignature
				.. ":"
				.. tostring(version)

			if stable and not localReady then
				if pendingReadySignatureAAC ~= readySignature then
					pendingReadySignatureAAC = readySignature
					readyDueAtAAC = os.clock() + math.clamp(
						(autoServerHopState.Utility.CustomDelays == true
							and tonumber(autoServerHopState.Utility.AcceptOfferDelay)) or 0.1875,
						0,
						5
					)
				end
				if os.clock() >= readyDueAtAAC
					and lastReadySignatureAAC ~= readySignature
				then
					lastReadySignatureAAC = readySignature
					pendingReadySignatureAAC = nil
					task.spawn(function()
						local fired = pcall(function()
							ReadyAAC:FireServer(true, version)
						end)
						if not fired then
							if lastReadySignatureAAC == readySignature then
								lastReadySignatureAAC = nil
							end
							return
						end
						task.wait(0.25)
						refreshAAC()
						if tryIndexAAC(negotiationAAC, {"guid"}) == guid
							and tryIndexAAC(negotiationAAC, {"player1", "ready"}) ~= true
							and lastReadySignatureAAC == readySignature
						then


							lastReadySignatureAAC = nil
						end
					end)
				end
			else
				pendingReadySignatureAAC = nil
				readyDueAtAAC = 0
			end

			task.wait(0.08)
		end
	end)
end





if IS_MINIGAME_PLACE then



	task.spawn(function()
		while screenGui.Parent
			and not (
				autoServerHopState
				and autoServerHopState.Utility
				and autoServerHopState.Utility.AutoEquipBestBrainrot == true
			)
		do
			task.wait(0.10)
		end
		if not screenGui.Parent then return end
		local PlayersAE = game:GetService("Players")
		local RSAE = game:GetService("ReplicatedStorage")
		local LocalPlayerAE = PlayersAE.LocalPlayer
		local ClientModulesAE = RSAE:WaitForChild("Client"):WaitForChild("Modules")
		local SharedAE = RSAE:WaitForChild("Shared")
		local function requireAE(moduleScript)
			while screenGui.Parent do
				local ok, result = pcall(require, moduleScript)
				if ok and result ~= nil then return result end
				task.wait(0.25)
			end
		end
		local ReplicatorAE = requireAE(ClientModulesAE:WaitForChild("ReplicatorClient"))
		local SortItemsAE = requireAE(ClientModulesAE:WaitForChild("utils"):WaitForChild("SortItems"))
		local GetItemTypeAE = requireAE(SharedAE:WaitForChild("utils"):WaitForChild("GetItemType"))
		local EconomyMathAE = requireAE(SharedAE:WaitForChild("utils"):WaitForChild("EconomyMath"))
		local RideableAE = requireAE(SharedAE:WaitForChild("Config"):WaitForChild("RideableBrainrots"))
		local RemotesAE = requireAE(SharedAE:WaitForChild("Remotes"))
		if not (ReplicatorAE and SortItemsAE and GetItemTypeAE and EconomyMathAE and RideableAE and RemotesAE) then
			return
		end
		local RideActionAE = RemotesAE.RideableBrainrotAction
		local PlayerDataAE
		local ActiveMinigameAE
		local nextRideAtAE = 0
		local rarityRankAE = {
			Common=1, Uncommon=2, Rare=3, Epic=4, Legendary=5, Mythical=6,
			Cosmic=7, Secret=8, Celestial=9, Divine=10, Infinity=11,
			Paradox=12, Eternal=13,
		}

		local function tryAE(root, path)
			if not root then return nil end
			local ok, value = pcall(function() return root:TryIndex(path) end)
			return ok and value or nil
		end

		local function refreshAE()
			local freshPlayerData
			local freshMinigame
			pcall(function() freshPlayerData = ReplicatorAE.get("PlayerData") end)
			pcall(function() freshMinigame = ReplicatorAE.get("ActiveMinigame") end)
			if freshPlayerData ~= nil then PlayerDataAE = freshPlayerData end
			if freshMinigame ~= nil then ActiveMinigameAE = freshMinigame end
		end

		local function itemTypeAE(item)
			local value
			pcall(function() value = GetItemTypeAE(item) end)
			return value
		end

		local function rarityAE(item)
			if type(item) ~= "table" or itemTypeAE(item) ~= "Brainrot" then return nil end
			local explicit = item.sub and (item.sub.rarity or item.sub.Rarity)
				or item.rarity or item.Rarity
			if type(explicit) == "string" and rarityRankAE[explicit] then
				return explicit
			end
			local value
			pcall(function()
				value = EconomyMathAE.GetBrainrotRarity(
					item.name or (item.sub and item.sub.name)
				)
			end)
			return type(value) == "string" and value or nil
		end

		local function sortedIdsAE(inventory)
			local sorted
			local ok = pcall(function() sorted = SortItemsAE(inventory) end)
			if ok and type(sorted) == "table" then return sorted end
			sorted = {}
			for id in pairs(inventory or {}) do sorted[#sorted + 1] = id end
			return sorted
		end

		local function tablesFolderAE()
			local gameObjects = workspace:FindFirstChild("GameObjects")
			local placeSpecific = gameObjects and gameObjects:FindFirstChild("PlaceSpecific")
			local tradePlaza = placeSpecific and placeSpecific:FindFirstChild("trade_plaza")
			local canonical = tradePlaza and tradePlaza:FindFirstChild("MinigameTables")
			if canonical then return canonical end
			for _, descendant in ipairs(workspace:GetDescendants()) do
				if descendant.Name == "MinigameTables"
					and descendant:FindFirstChildWhichIsA("Seat", true)
				then
					return descendant
				end
			end
		end

		local function seatedAtTableAE(character, humanoid)
			local folder = tablesFolderAE()
			if not folder then return false end
			if humanoid and humanoid.SeatPart and humanoid.SeatPart:IsDescendantOf(folder) then
				return true
			end
			local root = character and character:FindFirstChild("HumanoidRootPart")
			local weld = root and root:FindFirstChild("CustomSeatWeld")
			if weld then
				for _, propertyName in ipairs({"Part0", "Part1"}) do
					local part
					pcall(function() part = weld[propertyName] end)
					if typeof(part) == "Instance" and part:IsDescendantOf(folder) then
						return true
					end
				end
			end
			return false
		end

		local function unequipBrainrotToolsAE(character, humanoid, inventory)
			for _, child in ipairs(character:GetChildren()) do
				if child:IsA("Tool") then
					local item = inventory[child.Name] or inventory[tonumber(child.Name)]
					if type(item) == "table" and itemTypeAE(item) == "Brainrot" then
						pcall(humanoid.UnequipTools, humanoid)
						return
					end
				end
			end
		end

		local function mountAE()
			if not RideActionAE or os.clock() < nextRideAtAE then return false end
			nextRideAtAE = os.clock() + 0.75
			local ok, result = pcall(function()
				return RideActionAE:InvokeServer("mount")
			end)
			return ok and result ~= false
		end

		while screenGui.Parent do
			task.wait(0.35)
			local state = autoServerHopState.Utility
			if state.PauseScript == true
			or state.PauseMinigameFeatures == true
				or state.AutoEquipBestBrainrot ~= true
				or (state.EquipBestBrainrot ~= true
					and state.EquipBestMountableBrainrot ~= true
					and state.EquipSpecificBrainrot ~= true)
			then
				continue
			end

			refreshAE()
			local inventory = tryAE(PlayerDataAE, {"Inventory"})
			local character = LocalPlayerAE.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local backpack = LocalPlayerAE:FindFirstChildOfClass("Backpack")
			if type(inventory) ~= "table" or not character or not humanoid or not backpack then
				continue
			end

			local minigameActive = tryAE(ActiveMinigameAE, {"phase"}) ~= nil
				or tryAE(ActiveMinigameAE, {"session", "gameId"}) ~= nil
			if seatedAtTableAE(character, humanoid) or minigameActive then
				unequipBrainrotToolsAE(character, humanoid, inventory)
				continue
			end

			local bestId
			local bestRank
			local bestRideableId
			local bestRideableName

			for _, id in ipairs(sortedIdsAE(inventory)) do
				local item = inventory[id] or inventory[tostring(id)]
				if type(item) == "table" and itemTypeAE(item) == "Brainrot" then
					local rarity = rarityAE(item)
					local rank = rarityRankAE[rarity]
					if not bestId then
						bestId = tostring(id)
						bestRank = rank
					end

					if bestRank and rank
						and (rank == bestRank or rank == bestRank - 1)
					then
						local itemName = item.name or (item.sub and item.sub.name)
						local rideable = false
						if type(itemName) == "string" and itemName ~= "" then
							pcall(function()
								rideable = RideableAE.isRideable(itemName) == true
							end)
						end
						if rideable then
							bestRideableId = tostring(id)
							bestRideableName = itemName
							break
						end
					elseif bestRank and rank and rank < bestRank - 1 then
						break
					end
				end
			end

			local mounted = LocalPlayerAE:GetAttribute("RideableBrainrotActive") == true
			local specificId = state.EquipSpecificBrainrot == true
				and state.SpecificBrainrotId
				or nil
			local specificItem = specificId and (
				inventory[specificId]
					or inventory[tostring(specificId)]
					or (tonumber(specificId) and inventory[tonumber(specificId)] or nil)
			) or nil
			if specificId ~= nil
				and (
					type(specificItem) ~= "table"
					or itemTypeAE(specificItem) ~= "Brainrot"
				)
			then


				state.SpecificBrainrotId = nil
				specificId = nil
				specificItem = nil
				local refreshSettings = rawget(_G, "__TUFFHUB_REFRESH_DYNAMIC_DROPDOWNS")
				if type(refreshSettings) == "function" then
					task.defer(refreshSettings)
				end
			end

			local desiredId
			local desiredName
			local shouldMount = false

			if specificId ~= nil then
				desiredId = tostring(specificId)
				desiredName = specificItem.name
					or (specificItem.sub and specificItem.sub.name)
				if state.MountBrainrotIfPossible == true
					and type(desiredName) == "string"
				then
					pcall(function()
						shouldMount = RideableAE.isRideable(desiredName) == true
					end)
				end
			elseif state.EquipBestMountableBrainrot == true then
				desiredId = bestRideableId
				desiredName = bestRideableName
				shouldMount = desiredId ~= nil
			else


				desiredId = bestId
				local desiredItem = desiredId and (
					inventory[desiredId] or inventory[tostring(desiredId)]
				) or nil
				desiredName = type(desiredItem) == "table"
					and (desiredItem.name or (desiredItem.sub and desiredItem.sub.name))
					or nil
				if state.MountBrainrotIfPossible == true
					and type(desiredName) == "string"
				then
					pcall(function()
						shouldMount = RideableAE.isRideable(desiredName) == true
					end)
				end
			end

			if not desiredId then continue end

			if mounted then
				local mountedName = LocalPlayerAE:GetAttribute("RideableBrainrotName")
				if shouldMount
					and (
						desiredName == nil
						or mountedName == desiredName
					)
				then
					unequipBrainrotToolsAE(character, humanoid, inventory)
					continue
				end


				continue
			end

			local equipped = character:FindFirstChild(desiredId)
			if not (equipped and equipped:IsA("Tool")) then
				local tool = backpack:FindFirstChild(desiredId)
				if tool and tool:IsA("Tool") then
					pcall(humanoid.EquipTool, humanoid, tool)
					equipped = character:FindFirstChild(desiredId)
				end
			end

			if shouldMount and equipped and equipped:IsA("Tool") and mountAE() then
				task.spawn(function()
					local deadline = os.clock() + 1.25
					while screenGui.Parent
						and os.clock() < deadline
						and LocalPlayerAE:GetAttribute("RideableBrainrotActive") ~= true
					do
						task.wait(0.03)
					end
					if LocalPlayerAE:GetAttribute("RideableBrainrotActive") == true
						and (
							desiredName == nil
							or LocalPlayerAE:GetAttribute("RideableBrainrotName") == desiredName
						)
					then
						local liveCharacter = LocalPlayerAE.Character
						local liveHumanoid = liveCharacter
							and liveCharacter:FindFirstChildOfClass("Humanoid")
						if liveCharacter and liveHumanoid then
							unequipBrainrotToolsAE(liveCharacter, liveHumanoid, inventory)
						end
					end
				end)
			end
		end
	end)





	task.spawn(function()
		while screenGui.Parent do
			local state = autoServerHopState and autoServerHopState.Utility
			if state
				and state.PauseScript ~= true
				and state.PauseMinigameFeatures ~= true
				and (
					state.AutoshowBestBrainrots == true
					or state.AutoshowAllTokens == true
					or state.CustomOpeningOffer == true
				)
			then
				break
			end
			task.wait(0.10)
		end
		if not screenGui.Parent then return end
		local RSAO2 = game:GetService("ReplicatedStorage")
		local ClientModulesAO2 = RSAO2:WaitForChild("Client"):WaitForChild("Modules")
		local SharedAO2 = RSAO2:WaitForChild("Shared")
		local function requireAO2(moduleScript)
			while screenGui.Parent do
				local ok, result = pcall(require, moduleScript)
				if ok and result ~= nil then return result end
				task.wait(0.25)
			end
		end
		local ReplicatorAO2 = requireAO2(ClientModulesAO2:WaitForChild("ReplicatorClient"))
		local SortItemsAO2 = requireAO2(ClientModulesAO2:WaitForChild("utils"):WaitForChild("SortItems"))
		local GetItemTypeAO2 = requireAO2(SharedAO2:WaitForChild("utils"):WaitForChild("GetItemType"))
		local TradeableAO2 = requireAO2(SharedAO2:WaitForChild("utils"):WaitForChild("ItemIsTradeable"))
		local EconomyMathAO2 = requireAO2(SharedAO2:WaitForChild("utils"):WaitForChild("EconomyMath"))
		local BrainrotsAO2 = requireAO2(SharedAO2:WaitForChild("Config"):WaitForChild("Brainrots"))
		local RemotesAO2 = requireAO2(SharedAO2:WaitForChild("Remotes"))
		if not (ReplicatorAO2 and SortItemsAO2 and GetItemTypeAO2 and TradeableAO2
			and EconomyMathAO2 and BrainrotsAO2 and RemotesAO2)
		then
			return
		end
		local SetSlotAO2 = RemotesAO2.NegotiationSetSlot
		local OfferCurrencyAO2 = RemotesAO2.NegotiationOfferCurrency
		local PlayerDataAO2
		local NegotiationAO2
		local appliedSignatureAO2
		local scheduledSignatureAO2
		local scheduleStartedAtAO2 = 0
		local configuredRarityAO2 = {}
		if type(BrainrotsAO2) == "table" then
			for _, rarity in ipairs(BrainrotsAO2.ClassNames or {}) do
				local entries = (BrainrotsAO2.Chances or {})[rarity]
				if type(entries) == "table" then
					for name in pairs(entries) do
						if type(name) == "string" then
							configuredRarityAO2[name] = rarity
						end
					end
				end
			end
			for name, rarity in pairs(BrainrotsAO2.BrainrotRarities or {}) do
				if type(name) == "string" and type(rarity) == "string" then
					configuredRarityAO2[name] = rarity
				end
			end
		end
		local protectedDisplayNamesAO2 = {
			["Happini Sadini"] = true,
			["Panicini Bloomini"] = true,
			["Warini Tranquilini"] = true,
			["Fortunini Sfortunetti"] = true,
			["Derpolini Strictorini"] = true,
			["Vortice Cornaluna"] = true,
			["Halloumillo Incendrollo"] = true,
			["Reeki Rak Nada"] = true,
			Ascendro = true,
			Zeledrax = true,
		}

		local function tryAO2(root, path)
			if not root then return nil end
			local ok, value = pcall(function() return root:TryIndex(path) end)
			return ok and value or nil
		end

		local function refreshAO2()
			local freshPlayerData
			local freshNegotiation
			pcall(function() freshPlayerData = ReplicatorAO2.get("PlayerData") end)
			pcall(function() freshNegotiation = ReplicatorAO2.get("ActiveNegotiation") end)
			if freshPlayerData ~= nil then PlayerDataAO2 = freshPlayerData end
			if freshNegotiation ~= nil then NegotiationAO2 = freshNegotiation end
		end

		local function guidAO2()
			refreshAO2()
			return tryAO2(NegotiationAO2, {"guid"})
		end

		local function autoOfferOwnsWagerAO2(expectedGuid)
			local utility = autoServerHopState and autoServerHopState.Utility
			return utility ~= nil
				and tostring(utility._AutoOfferReactiveGuid or "") == tostring(expectedGuid)
		end

		local function openingStillActiveAO2(expectedGuid)
			if autoServerHopState.Utility.PauseScript == true or autoServerHopState.Utility.PauseMinigameFeatures == true then return false end
			if guidAO2() ~= expectedGuid then return false end
			if tryAO2(NegotiationAO2, {"player1", "ready"}) == true then return false end



			return not autoOfferOwnsWagerAO2(expectedGuid)
		end

		local function invokeAO2(remote, ...)
			if not remote then return false, nil end
			local args = table.pack(...)
			local ok, result = pcall(function()
				return remote:InvokeServer(table.unpack(args, 1, args.n))
			end)
			return ok, result
		end

		local function slotIdAO2(slotIndex)
			local slots = tryAO2(NegotiationAO2, {"player1", "slots"})
			if type(slots) ~= "table" then return nil end
			local value = slots[tostring(slotIndex)]
			if value == nil then value = slots[slotIndex] end
			return type(value) == "table" and value.id or value
		end

		local function sameIdAO2(a, b)
			if a == b then return true end
			return a ~= nil and b ~= nil and tostring(a) == tostring(b)
		end

		local function displayTradeableAO2(item)
			if type(item) ~= "table" then return false end




			local explicit = item.rarity
				or item.Rarity
				or (item.sub and (item.sub.rarity or item.sub.Rarity))
			if explicit == "Paradox" or explicit == "Eternal" then return true end

			local rarity
			local name = item.name or (item.sub and item.sub.name)
			if type(name) == "string" then
				rarity = configuredRarityAO2[name]
				if rarity == nil then
					pcall(function() rarity = EconomyMathAO2.GetBrainrotRarity(name) end)
				end
			end
			if rarity == "Paradox"
				or rarity == "Eternal"
				or (type(name) == "string" and protectedDisplayNamesAO2[name] == true)
			then
				return true
			end

			local tradeable = false
			pcall(function() tradeable = TradeableAO2(item) == true end)
			return tradeable
		end

		local function topBrainrotsAO2()
			local inventory = tryAO2(PlayerDataAO2, {"Inventory"})
			if type(inventory) ~= "table" then return {} end
			local sorted
			local ok = pcall(function() sorted = SortItemsAO2(inventory) end)
			if not ok or type(sorted) ~= "table" then
				sorted = {}
				for id in pairs(inventory) do sorted[#sorted + 1] = id end
			end

			local result = {}
			for _, id in ipairs(sorted) do
				if #result >= 6 then break end
				local item = inventory[id] or inventory[tostring(id)]
				if type(item) == "table" and not item.locked then
					local itemType
					pcall(function() itemType = GetItemTypeAO2(item) end)
					if itemType == "Brainrot" and displayTradeableAO2(item) then
						result[#result + 1] = tostring(id)
					end
				end
			end
			return result
		end

		local function customBrainrotsAO2(state)
			local inventory = tryAO2(PlayerDataAO2, {"Inventory"})
			if type(inventory) ~= "table" then return {} end

			local desired = {}
			local used = {}
			for slotIndex = 1, 6 do
				local selectedId = state["OpeningOfferBrainrot" .. tostring(slotIndex)]
				local item = selectedId and (
					inventory[selectedId]
						or inventory[tostring(selectedId)]
						or (tonumber(selectedId) and inventory[tonumber(selectedId)] or nil)
				) or nil

				local valid = false
				if type(item) == "table" and not item.locked then
					local itemType
					pcall(function() itemType = GetItemTypeAO2(item) end)
					valid = itemType == "Brainrot"
						and displayTradeableAO2(item)
						and used[tostring(selectedId)] ~= true
				end

				if valid then
					desired[slotIndex] = tostring(selectedId)
					used[tostring(selectedId)] = true
				elseif selectedId ~= nil then


					state["OpeningOfferBrainrot" .. tostring(slotIndex)] = nil
					local refreshSettings = rawget(_G, "__TUFFHUB_REFRESH_DYNAMIC_DROPDOWNS")
					if type(refreshSettings) == "function" then
						task.defer(refreshSettings)
					end
				end
			end

			local best = topBrainrotsAO2()
			local bestIndex = 1
			for slotIndex = 1, 6 do
				if desired[slotIndex] == nil then
					while bestIndex <= #best and used[tostring(best[bestIndex])] do
						bestIndex += 1
					end
					if bestIndex <= #best then
						local id = tostring(best[bestIndex])
						desired[slotIndex] = id
						used[id] = true
						bestIndex += 1
					end
				end
			end
			return desired
		end

		local function tokenBalanceAO2()
			return math.max(
				0,
				math.floor(tonumber(tryAO2(PlayerDataAO2, {"TradeTokens"})) or 0)
			)
		end

		local function setTokensAO2(expectedGuid, amount)
			amount = math.max(0, math.floor(tonumber(amount) or 0))
			for _ = 1, 3 do
				if not openingStillActiveAO2(expectedGuid) then return false end
				local current = math.max(
					0,
					math.floor(tonumber(
						tryAO2(NegotiationAO2, {"player1", "currency"})
					) or 0)
				)
				if current == amount then return true end
				if not openingStillActiveAO2(expectedGuid) then return false end
				invokeAO2(OfferCurrencyAO2, amount)
				task.wait(math.clamp(
					(autoServerHopState.Utility.CustomDelays == true
						and tonumber(
							current < amount
								and autoServerHopState.Utility.AddTokenDelay
								or autoServerHopState.Utility.RemoveTokenDelay
						))
						or 0,
					0,
					5
				))
				local verifyUntil = os.clock() + 0.35
				while openingStillActiveAO2(expectedGuid) and os.clock() < verifyUntil do
					local replicated = math.max(
						0,
						math.floor(tonumber(
							tryAO2(NegotiationAO2, {"player1", "currency"})
						) or 0)
					)
					if replicated == amount then return true end
					task.wait(0.02)
				end
			end
			return false
		end

		local function setItemsAO2(expectedGuid, desired)
			for attempt = 1, 3 do
				if not openingStillActiveAO2(expectedGuid) then return false end

				for slotIndex = 1, 6 do
					if not openingStillActiveAO2(expectedGuid) then return false end
					local desiredId = desired[slotIndex]
					local currentId = slotIdAO2(slotIndex)
					if currentId ~= nil and not sameIdAO2(currentId, desiredId) then
						if not openingStillActiveAO2(expectedGuid) then return false end
						invokeAO2(SetSlotAO2, tostring(slotIndex), nil)
						task.wait(math.clamp(
							(autoServerHopState.Utility.CustomDelays == true
								and tonumber(autoServerHopState.Utility.RemoveBrainrotDelay))
								or 0.1125,
							0,
							5
						))
					end
				end

				for slotIndex = 1, 6 do
					if not openingStillActiveAO2(expectedGuid) then return false end
					local desiredId = desired[slotIndex]
					local currentId = slotIdAO2(slotIndex)
					if desiredId ~= nil and not sameIdAO2(currentId, desiredId) then
						if not openingStillActiveAO2(expectedGuid) then return false end
						invokeAO2(SetSlotAO2, tostring(slotIndex), desiredId)
						task.wait(math.clamp(
							(autoServerHopState.Utility.CustomDelays == true
								and tonumber(autoServerHopState.Utility.AddBrainrotDelay))
								or 0.234375,
							0,
							5
						))
					end
				end

				if not openingStillActiveAO2(expectedGuid) then return false end
				local verified = true
				for slotIndex = 1, 6 do
					if not sameIdAO2(slotIdAO2(slotIndex), desired[slotIndex]) then
						verified = false
						break
					end
				end
				if verified then return true end
				task.wait(0.03 * attempt)
			end
			return false
		end

		while screenGui.Parent do
			task.wait(0.05)
			local state = autoServerHopState.Utility
			if state.PauseScript == true or state.PauseMinigameFeatures == true then
				scheduledSignatureAO2 = nil
				task.wait(0.05)
				continue
			end
			local customItems = state.CustomOpeningOffer == true
			local showItems = state.AutoshowBestBrainrots == true or customItems
			local showTokens = state.AutoshowAllTokens == true
			if not showItems and not showTokens then
				appliedSignatureAO2 = nil
				scheduledSignatureAO2 = nil
				continue
			end

			local guid = guidAO2()
			if not guid then
				appliedSignatureAO2 = nil
				scheduledSignatureAO2 = nil
				continue
			end

			if autoOfferOwnsWagerAO2(guid) then



				continue
			end
			if tryAO2(NegotiationAO2, {"player1", "ready"}) == true then
				continue
			end

			local signature = tostring(guid)
				.. ":I=" .. tostring(showItems)
				.. ":C=" .. tostring(customItems)
				.. ":B1=" .. tostring(state.OpeningOfferBrainrot1)
				.. ":B2=" .. tostring(state.OpeningOfferBrainrot2)
				.. ":B3=" .. tostring(state.OpeningOfferBrainrot3)
				.. ":B4=" .. tostring(state.OpeningOfferBrainrot4)
				.. ":B5=" .. tostring(state.OpeningOfferBrainrot5)
				.. ":B6=" .. tostring(state.OpeningOfferBrainrot6)
				.. ":T=" .. tostring(showTokens)
			if appliedSignatureAO2 == signature then continue end

			if scheduledSignatureAO2 ~= signature then
				scheduledSignatureAO2 = signature
				scheduleStartedAtAO2 = os.clock()
			end

			local initialDelay = math.clamp(
				(state.CustomDelays == true and tonumber(state.InitialJoinDelay)) or 1.125,
				0,
				5
			)
			if os.clock() - scheduleStartedAtAO2 < initialDelay then continue end

			if state.AutoTradeChat == true
				and tostring(state.AutoTradeMessage or "") ~= ""
			then
				if tostring(state._LastTradeMessageGuid or "") == tostring(guid) then
					local sentAt = tonumber(state._LastTradeMessageSentAt) or 0
					local postDelay = math.clamp(
						(state.CustomDelays == true and tonumber(state.DelayAfterTradeMessage)) or 0.75,
						0,
						5
					)
					if os.clock() - sentAt < postDelay then continue end
				elseif os.clock() - scheduleStartedAtAO2 < initialDelay + 3.0 then


					continue
				end
			end

			if guidAO2() ~= guid then continue end

			local itemOk = true
			local tokenOk = true
			if showTokens and openingStillActiveAO2(guid) then
				tokenOk = setTokensAO2(guid, tokenBalanceAO2())
			end
			if showItems and openingStillActiveAO2(guid) then
				itemOk = setItemsAO2(
					guid,
					customItems and customBrainrotsAO2(state) or topBrainrotsAO2()
				)
			end

			if openingStillActiveAO2(guid) and itemOk and tokenOk then
				appliedSignatureAO2 = signature
			end
		end
	end)






	task.spawn(function()
		while screenGui.Parent do
			local state = autoServerHopState and autoServerHopState.Utility
			if state
				and state.PauseScript ~= true
				and state.PauseMinigameFeatures ~= true
				and (
					state.AutoChooseGame == true
					or state.AutoChooseRounds == true
				)
			then
				break
			end
			task.wait(0.10)
		end
		if not screenGui.Parent then return end
		local RSVC = game:GetService("ReplicatedStorage")
		local ClientModulesVC = RSVC:WaitForChild("Client"):WaitForChild("Modules")
		local SharedVC = RSVC:WaitForChild("Shared")
		local function requireVC(moduleScript)
			while screenGui.Parent do
				local ok, result = pcall(require, moduleScript)
				if ok and result ~= nil then return result end
				task.wait(0.25)
			end
		end
		local ReplicatorVC = requireVC(ClientModulesVC:WaitForChild("ReplicatorClient"))
		local RemotesVC = requireVC(SharedVC:WaitForChild("Remotes"))
		if not (ReplicatorVC and RemotesVC) then return end
		local VoteRemoteVC = RemotesVC.MinigameVote
		local ActiveVC
		local NegotiationVC
		local voteGenerationVC = 0
		local votePhaseSeenVC
		local voteRoundSeenVC
		local voteSuspendedVC = false
		local gameMapVC = {
			["Candy Bomb"]="CandyBomb",
			["Popcorn Burst"]="PopcornBurst",
			["Higher Or Lower"]="NumberGuess",
			["Connect 4"]="ConnectFour",
			["Battle Ship"]="Battleship",
			["Knockout"]="Knockout",
			["Football Draft"]="FootballDraft",
		}
		local gameLabelVC = {}
		for label, id in pairs(gameMapVC) do gameLabelVC[id] = label end

		local function tryVC(root, path)
			if not root then return nil end
			local ok, value = pcall(function() return root:TryIndex(path) end)
			return ok and value or nil
		end

		local function refreshVC()
			local active
			local negotiation
			pcall(function() active = ReplicatorVC.get("ActiveMinigame") end)
			pcall(function() negotiation = ReplicatorVC.get("ActiveNegotiation") end)
			if active ~= nil then ActiveVC = active end
			if negotiation ~= nil then NegotiationVC = negotiation end
		end

		local function votingVC()
			refreshVC()
			return tryVC(ActiveVC, {"voting"})
		end

		local function phaseVC()
			refreshVC()
			return tryVC(ActiveVC, {"phase"})
		end

		local function negotiationGuidVC()
			refreshVC()
			return tryVC(NegotiationVC, {"guid"})
		end

		local function fireVoteVC(gameId, bestOf)
			if not VoteRemoteVC then return false end
			return pcall(function()
				VoteRemoteVC:FireServer(gameId, bestOf)
			end)
		end

		local function stillVoteVC(generation, wantedPhase, selectionRound)
			if autoServerHopState.Utility.PauseScript == true
				or autoServerHopState.Utility.PauseMinigameFeatures == true
				or generation ~= voteGenerationVC
				or negotiationGuidVC() ~= nil
				or phaseVC() == nil
			then
				return false, nil
			end
			local voting = votingVC()
			if type(voting) ~= "table"
				or (voting.votePhase or "game") ~= wantedPhase
			then
				return false, voting
			end
			local liveRound = tonumber(voting.voteRound) or selectionRound
			return liveRound == selectionRound, voting
		end

		local function sendGameVC(generation, selectionRound, gameId)
			local valid = stillVoteVC(generation, "game", selectionRound)
			if not valid or not gameLabelVC[gameId] then return false end
			return fireVoteVC(gameId, nil)
		end

		local function sendRoundsVC(generation, selectionRound, bestOf)
			local valid = stillVoteVC(generation, "rounds", selectionRound)
			if not valid or (bestOf ~= 1 and bestOf ~= 3 and bestOf ~= 5) then
				return false
			end
			return fireVoteVC(nil, bestOf)
		end

		local function startGameVoteVC()
			voteGenerationVC += 1
			local generation = voteGenerationVC
			local voting = votingVC()
			local selectionRound = type(voting) == "table"
				and tonumber(voting.voteRound) or tonumber(voteRoundSeenVC) or 1
			local state = autoServerHopState.Utility
			local primary = gameMapVC[state.GameToChoose] or "PopcornBurst"

			local function submit(choice)
				if not sendGameVC(generation, selectionRound, choice) then return end
				task.spawn(function()
					for _, delayTime in ipairs({0.12, 0.30}) do
						task.wait(delayTime)
						local valid = stillVoteVC(generation, "game", selectionRound)
						if not valid then return end
						sendGameVC(generation, selectionRound, choice)
					end
				end)
			end

			local waitSeconds = math.clamp(
				tonumber(
					selectionRound <= 1
						and state.AutoChooseRound1Delay
						or (
							selectionRound == 2
								and state.AutoChooseRound2Delay
								or state.AutoChooseRound3Delay
						)
				) or 0,
				0,
				10
			)
			task.spawn(function()
				local started = os.clock()
				while os.clock() - started < waitSeconds do
					local valid, liveVoting = stillVoteVC(
						generation,
						"game",
						selectionRound
					)
					if not valid then return end
					if state.MatchOpponentGame == true then
						local opponentChoice = type(liveVoting.opponentVote) == "table"
							and liveVoting.opponentVote.gameId or nil
						local label = gameLabelVC[opponentChoice]
						local choicesToMatch = state.FallbackGameChoices
						if label
							and type(choicesToMatch) == "table"
							and choicesToMatch[label] == true
						then
							submit(opponentChoice)
							return
						end
					end
					task.wait(0.03)
				end
				local valid, liveVoting = stillVoteVC(generation, "game", selectionRound)
				if not valid then return end
				local opponentChoice = type(liveVoting.opponentVote) == "table"
					and liveVoting.opponentVote.gameId or nil
				local label = gameLabelVC[opponentChoice]
				local choicesToMatch = state.FallbackGameChoices
				submit(
					state.MatchOpponentGame == true
						and label
						and type(choicesToMatch) == "table"
						and choicesToMatch[label] == true
						and opponentChoice
						or primary
				)
			end)
		end

		local function startRoundsVoteVC()
			voteGenerationVC += 1
			local generation = voteGenerationVC
			local voting = votingVC()
			local selectionRound = type(voting) == "table"
				and tonumber(voting.voteRound) or tonumber(voteRoundSeenVC) or 1
			local state = autoServerHopState.Utility
			local primary = tonumber(state.RoundsToChoose) or 1
			if primary ~= 1 and primary ~= 3 and primary ~= 5 then primary = 1 end

			local function submit(choice)
				sendRoundsVC(generation, selectionRound, choice)
			end

			local waitSeconds = math.clamp(
				tonumber(
					selectionRound <= 1
						and state.AutoChooseRound1Delay
						or (
							selectionRound == 2
								and state.AutoChooseRound2Delay
								or state.AutoChooseRound3Delay
						)
				) or 0,
				0,
				10
			)
			task.spawn(function()
				local started = os.clock()
				while os.clock() - started < waitSeconds do
					local valid, liveVoting = stillVoteVC(
						generation,
						"rounds",
						selectionRound
					)
					if not valid then return end
					if state.MatchOpponentRounds == true then
						local opponentChoice = type(liveVoting.opponentVote) == "table"
							and tonumber(liveVoting.opponentVote.bestOf) or nil
						local choicesToMatch = state.FallbackRoundChoices
						if opponentChoice
							and type(choicesToMatch) == "table"
							and choicesToMatch[tostring(opponentChoice)] == true
						then
							submit(opponentChoice)
							return
						end
					end
					task.wait(0.03)
				end
				local valid, liveVoting = stillVoteVC(generation, "rounds", selectionRound)
				if not valid then return end
				local opponentChoice = type(liveVoting.opponentVote) == "table"
					and tonumber(liveVoting.opponentVote.bestOf) or nil
				local choicesToMatch = state.FallbackRoundChoices
				submit(
					state.MatchOpponentRounds == true
						and opponentChoice
						and type(choicesToMatch) == "table"
						and choicesToMatch[tostring(opponentChoice)] == true
						and opponentChoice
						or primary
				)
			end)
		end

		while screenGui.Parent do
			task.wait(0.05)
			local state = autoServerHopState.Utility
			if state.PauseScript == true
				or state.PauseMinigameFeatures == true
				or (
					state.AutoChooseGame ~= true
					and state.AutoChooseRounds ~= true
				)
			then
				if not voteSuspendedVC then
					votePhaseSeenVC = nil
					voteRoundSeenVC = nil
					voteGenerationVC += 1
					voteSuspendedVC = true
				end
				continue
			end
			if negotiationGuidVC() ~= nil then
				if not voteSuspendedVC then
					votePhaseSeenVC = nil
					voteRoundSeenVC = nil
					voteGenerationVC += 1
					voteSuspendedVC = true
				end
				continue
			end
			voteSuspendedVC = false

			local phase = phaseVC()
			local voting = votingVC()
			if phase == nil or type(voting) ~= "table" then
				votePhaseSeenVC = nil
				voteRoundSeenVC = nil
				continue
			end

			local votePhase = voting.votePhase or "game"
			local voteRound = tonumber(voting.voteRound) or 1
			if votePhase == "game" then
				if state.AutoChooseGame ~= true then
					if votePhaseSeenVC == "game" then votePhaseSeenVC = nil end
					continue
				end
				if votePhaseSeenVC ~= "game" or voteRoundSeenVC ~= voteRound then
					votePhaseSeenVC = "game"
					voteRoundSeenVC = voteRound
					startGameVoteVC()
				end
			elseif votePhase == "rounds" then
				if state.AutoChooseRounds ~= true then
					if votePhaseSeenVC == "rounds" then votePhaseSeenVC = nil end
					continue
				end
				if votePhaseSeenVC ~= "rounds" or voteRoundSeenVC ~= voteRound then
					votePhaseSeenVC = "rounds"
					voteRoundSeenVC = voteRound
					startRoundsVoteVC()
				end
			end
		end
	end)


	task.spawn(function()
		while screenGui.Parent do
			local state = autoServerHopState and autoServerHopState.Utility
			if state
				and state.PrintWinsLossesToTerminal == true
			then
				break
			end
			task.wait(0.10)
		end
		if not screenGui.Parent then return end
		local RSLG = game:GetService("ReplicatedStorage")
		local function requireLG(moduleScript)
			while screenGui.Parent do
				local ok, result = pcall(require, moduleScript)
				if ok and result ~= nil then return result end
				task.wait(0.25)
			end
		end
		local SharedLG = RSLG:WaitForChild("Shared")
		local ReplicatorLG = requireLG(
			RSLG:WaitForChild("Client")
				:WaitForChild("Modules")
				:WaitForChild("ReplicatorClient")
		)
		local GetItemTypeLG = requireLG(SharedLG:WaitForChild("utils"):WaitForChild("GetItemType"))
		local EconomyMathLG = requireLG(SharedLG:WaitForChild("utils"):WaitForChild("EconomyMath"))
		local BrainrotsConfigLG = requireLG(SharedLG:WaitForChild("Config"):WaitForChild("Brainrots"))
		if not ReplicatorLG then return end
		local ActiveLG
		local observedActiveLG
		local lastPrintedLG
		local lastGameLG
		local lastOpponentUserLG = "Unknown"
		local lastWagerLG
		local queuedResultLG
		local wasPlayingLG = false
		local namesLG = {
			PopcornBurst="Popcorn Burst",
			ConnectFour="Connect Four",
			CandyBomb="Candy Bomb",
			NumberGuess="Higher Or Lower",
			FootballDraft="Football Draft",
			Knockout="Knockout",
			Battleship="Battle Ship",
		}
		local configuredRarityLG = {}
		if type(BrainrotsConfigLG) == "table" then
			for name, rarity in pairs(BrainrotsConfigLG.BrainrotRarities or {}) do
				configuredRarityLG[tostring(name)] = tostring(rarity)
			end
		end

		local function tryLG(root, path)
			if not root then return nil end
			local ok, value = pcall(function() return root:TryIndex(path) end)
			return ok and value or nil
		end

		local function refreshLG()
			local fresh
			pcall(function() fresh = ReplicatorLG.get("ActiveMinigame") end)
			if fresh ~= nil then ActiveLG = fresh end
		end

		local function cacheContextLG()
			local gameId = tryLG(ActiveLG, {"session", "gameId"})
			if type(gameId) == "string" and gameId ~= "" then
				lastGameLG = gameId
			end
			local opponent = tryLG(ActiveLG, {"session", "private", "opponent"})
			if typeof(opponent) == "Instance" and opponent:IsA("Player") then
				lastOpponentUserLG = opponent.Name
			end
			local wager = tryLG(ActiveLG, {"wager"})
			if type(wager) == "table" then
				lastWagerLG = wager
			end
		end

		local function itemNameLG(item)
			if type(item) ~= "table" then return nil end
			local name = item.name or item.Name
			if name == nil and type(item.sub) == "table" then
				name = item.sub.name or item.sub.Name
			end
			return name ~= nil and tostring(name) or nil
		end

		local function itemRarityLG(item, name)
			if type(item) ~= "table" then return nil end
			local rarity = item.rarity or item.Rarity or item.BrainrotRarity
			if rarity == nil and type(item.sub) == "table" then
				rarity = item.sub.rarity or item.sub.Rarity or item.sub.BrainrotRarity
			end
			if rarity ~= nil then return tostring(rarity) end
			if name and configuredRarityLG[name] then return configuredRarityLG[name] end
			if EconomyMathLG and name then
				local ok, value = pcall(EconomyMathLG.GetBrainrotRarity, name)
				if ok and value ~= nil then return tostring(value) end
			end
			return "Unknown"
		end

		local function isBrainrotLG(item)
			if type(item) ~= "table" then return false end
			if GetItemTypeLG then
				local ok, value = pcall(GetItemTypeLG, item)
				if ok then return value == "Brainrot" end
			end
			return itemNameLG(item) ~= nil
		end

		local function appendWagerLG(parts, won, wager)
			wager = type(wager) == "table" and wager or {}
			local currency = tonumber(won and wager.oppCurrency or wager.myCurrency) or 0
			parts[#parts + 1] = "Tokens: " .. tostring(math.floor(currency))
			local items = won and wager.oppItems or wager.myItems
			if type(items) == "table" then
				for _, item in pairs(items) do
					if isBrainrotLG(item) then
						local name = itemNameLG(item) or "Unknown"
						parts[#parts + 1] = "Brainrot: " .. name .. " Rarity: " .. itemRarityLG(item, name)
					end
				end
			end
		end

		local function printResultLG(result)
			if type(result) ~= "table" then return end
			local winner = tonumber(result.winnerIndex)
			if not winner or winner == 0 then return end
			cacheContextLG()
			local identity = tostring(lastGameLG or "Unknown")
				.. ":" .. tostring(winner)
				.. ":" .. tostring(result.round or result.roundIndex or result.bestOf or "")
			if identity == lastPrintedLG then return end
			lastPrintedLG = identity

			if autoServerHopState.Utility.PauseScript ~= true
				and autoServerHopState.Utility.PauseMinigameFeatures ~= true
				and autoServerHopState.Utility.PrintWinsLossesToTerminal == true
			then
				local won = winner == 1
				local parts = {
					won and "WIN" or "LOSS",
					"User: " .. tostring(lastOpponentUserLG or "Unknown"),
					"Game: " .. tostring(namesLG[lastGameLG] or lastGameLG or "Unknown"),
				}
				appendWagerLG(parts, won, lastWagerLG)
				print(table.concat(parts, " | "))
				print(string.rep("\\", 10))
			end
		end

		local function bindObserverLG()
			if not ActiveLG or ActiveLG == observedActiveLG then return end
			local object = ActiveLG
			local ok = pcall(function()
				object:Observe({"matchResult"}, function(result)

					if object == ActiveLG and type(result) == "table" then
						queuedResultLG = result
					end
				end)
			end)
			if ok then observedActiveLG = object end
		end

		while screenGui.Parent do
			task.wait(0.05)
			refreshLG()
			bindObserverLG()
			cacheContextLG()

			local gameId = tryLG(ActiveLG, {"session", "gameId"})
			local phase = tryLG(ActiveLG, {"phase"})
			local playingNow = phase == "Playing"
				and type(gameId) == "string"
				and gameId ~= ""
			if playingNow and not wasPlayingLG then
				lastPrintedLG = nil
			end
			wasPlayingLG = playingNow

			if type(gameId) == "string" and gameId ~= "" then
				if gameId ~= lastGameLG then lastPrintedLG = nil end
				lastGameLG = gameId
			end

			local result = queuedResultLG or tryLG(ActiveLG, {"matchResult"})
			queuedResultLG = nil
			if result ~= nil then
				printResultLG(result)
			end
		end
	end)

end







if IS_MINIGAME_PLACE then
	task.spawn(function()
		while screenGui.Parent
			and not (autoServerHopState.Utility.AutoBooth == true)
		do
			task.wait(0.10)
		end
		if not screenGui.Parent then return end

		local PlayersAB = game:GetService("Players")
		local RSAB = game:GetService("ReplicatedStorage")
		local TextChatServiceAB = game:GetService("TextChatService")
		local LocalPlayerAB = PlayersAB.LocalPlayer
		local SharedAB = RSAB:WaitForChild("Shared")
		local ClientModulesAB = RSAB:WaitForChild("Client"):WaitForChild("Modules")

		local function requireAB(moduleScript)
			while screenGui.Parent do
				local ok, result = pcall(require, moduleScript)
				if ok and result ~= nil then return result end
				task.wait(0.25)
			end
		end

		local ReplicatorAB = requireAB(ClientModulesAB:WaitForChild("ReplicatorClient"))
		local SortItemsAB = requireAB(ClientModulesAB:WaitForChild("utils"):WaitForChild("SortItems"))
		local RemotesAB = requireAB(SharedAB:WaitForChild("Remotes"))
		local GetItemTypeAB = requireAB(SharedAB:WaitForChild("utils"):WaitForChild("GetItemType"))
		local ItemIsTradeableAB = requireAB(SharedAB:WaitForChild("utils"):WaitForChild("ItemIsTradeable"))
		local EconomyMathAB = requireAB(SharedAB:WaitForChild("utils"):WaitForChild("EconomyMath"))
		local GetMaxBoothSlotsAB = requireAB(SharedAB:WaitForChild("utils"):WaitForChild("GetMaxBoothSlots"))
		local BrainrotsConfigAB = requireAB(SharedAB:WaitForChild("Config"):WaitForChild("Brainrots"))
		if not (
			ReplicatorAB
			and SortItemsAB
			and RemotesAB
			and GetItemTypeAB
			and ItemIsTradeableAB
			and EconomyMathAB
			and GetMaxBoothSlotsAB
			and BrainrotsConfigAB
		) then
			return
		end

		local ClaimBoothAB = RemotesAB.ClaimBooth
		local ListBoothOfferingAB = RemotesAB.ListBoothOffering
		local RemoveBoothOfferingAB = RemotesAB.RemoveBoothOffering
		local ChangeBoothMessageAB = RemotesAB.ChangeBoothMessage
		if not (ClaimBoothAB and ListBoothOfferingAB and RemoveBoothOfferingAB and ChangeBoothMessageAB) then
			return
		end

		local PlayerDataAB
		local TradingBoothsAB
		local ActiveNegotiationAB
		local ActiveMinigameAB
		local nextMutationAtAB = 0
		local messageRetryAtAB = 0
		local configuredCompleteMessagedAB = false
		local possibleCompleteMessagedAB = false
		local configuredRarityAB = {}
		local BOOTH_MUTATION_MIN_INTERVAL_AB = 2.00
		local BOOTH_MUTATION_FAILURE_BACKOFF_AB = 3.00
		local BOOTH_REPLICATION_CONFIRM_TIMEOUT_AB = 1.25
		local BOOTH_MESSAGE_RETRY_HOLD_AB = 4.00
		autoServerHopState.RuntimeBoothMutationBusy = false

		if type(BrainrotsConfigAB) == "table" then
			for _, rarity in ipairs(BrainrotsConfigAB.ClassNames or {}) do
				local entries = (BrainrotsConfigAB.Chances or {})[rarity]
				if type(entries) == "table" then
					for name in pairs(entries) do
						if type(name) == "string" then configuredRarityAB[name] = rarity end
					end
				end
			end
			for name, rarity in pairs(BrainrotsConfigAB.BrainrotRarities or {}) do
				if type(name) == "string" and type(rarity) == "string" then
					configuredRarityAB[name] = rarity
				end
			end
		end

		local function refreshAB()
			local playerData, booths, negotiation, minigame
			pcall(function() playerData = ReplicatorAB.get("PlayerData") end)
			pcall(function() booths = ReplicatorAB.get("TradingBooths") end)
			pcall(function() negotiation = ReplicatorAB.get("ActiveNegotiation") end)
			pcall(function() minigame = ReplicatorAB.get("ActiveMinigame") end)
			if playerData ~= nil then PlayerDataAB = playerData end
			if booths ~= nil then TradingBoothsAB = booths end
			if negotiation ~= nil then ActiveNegotiationAB = negotiation end
			if minigame ~= nil then ActiveMinigameAB = minigame end
		end

		local function tryAB(root, path)
			if not root then return nil end
			local ok, value = pcall(function() return root:TryIndex(path) end)
			return ok and value or nil
		end

		local function inventoryAB()
			refreshAB()
			local inventory = tryAB(PlayerDataAB, {"Inventory"})
			return type(inventory) == "table" and inventory or nil
		end

		local function myBoothStateAB(skipRefresh)
			if not skipRefresh then refreshAB() end
			local data = TradingBoothsAB and TradingBoothsAB.Data
			if type(data) ~= "table" then return nil, nil end
			for key, entry in pairs(data) do
				if type(entry) == "table" and entry.player == LocalPlayerAB then
					return entry, key
				end
			end
		end

		local function boothMutationAllowedAB()
			if autoServerHopState.Utility.PauseScript == true
			or autoServerHopState.Utility.PauseMinigameFeatures == true
				or autoServerHopState.Utility.AutoBooth ~= true
				or autoServerHopState.RuntimeAutoSitBusy == true
				or LocalPlayerAB:GetAttribute("Seated") == true
			then
				return false
			end
			refreshAB()
			if tryAB(ActiveNegotiationAB, {"guid"}) ~= nil then return false end
			if tryAB(ActiveMinigameAB, {"queued"}) == true
				or tryAB(ActiveMinigameAB, {"phase"}) ~= nil
				or tryAB(ActiveMinigameAB, {"session", "gameId"}) ~= nil
				or type(tryAB(ActiveMinigameAB, {"voting"})) == "table"
			then
				return false
			end

			local character = LocalPlayerAB.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local root = character and character:FindFirstChild("HumanoidRootPart")
			if root and root:FindFirstChild("CustomSeatWeld") then return false end
			if humanoid then


				local gameObjects = workspace:FindFirstChild("GameObjects")
				local placeSpecific = gameObjects and gameObjects:FindFirstChild("PlaceSpecific")
				local tradePlaza = placeSpecific and placeSpecific:FindFirstChild("trade_plaza")
				local tables = tradePlaza and tradePlaza:FindFirstChild("MinigameTables")
				if tables then
					for _, tableModel in ipairs(tables:GetChildren()) do
						if tableModel:IsA("Model") then
							for _, seatName in ipairs({"Seat1", "Seat2"}) do
								local seat = tableModel:FindFirstChild(seatName)
								if seat and seat:IsA("Seat") and seat.Occupant == humanoid then
									return false
								end
							end
						end
					end
				end
				if humanoid.SeatPart ~= nil or humanoid.Sit then return false end
				local ok, state = pcall(humanoid.GetState, humanoid)
				if ok and state == Enum.HumanoidStateType.Seated then return false end
			end
			return true
		end

		local function waitMutationSlotAB()
			while screenGui.Parent and autoServerHopState.Utility.AutoBooth == true do
				if not boothMutationAllowedAB() then return false end
				local remaining = nextMutationAtAB - os.clock()
				if remaining <= 0 then
					nextMutationAtAB = os.clock() + BOOTH_MUTATION_MIN_INTERVAL_AB
					return true
				end
				task.wait(math.min(remaining, 0.10))
			end
			return false
		end

		local function invokeMutationAB(remote, rejectFalse, ...)
			if not remote or not waitMutationSlotAB() then return false, nil end


			if not boothMutationAllowedAB()
				or autoServerHopState.RuntimeBoothMutationBusy == true
			then
				return false, nil
			end




			autoServerHopState.RuntimeBoothMutationBusy = true
			local args = table.pack(...)
			local ok, result = pcall(function()
				return remote:InvokeServer(table.unpack(args, 1, args.n))
			end)
			autoServerHopState.RuntimeBoothMutationBusy = false
			if not ok or (rejectFalse and result == false) then
				nextMutationAtAB = math.max(nextMutationAtAB, os.clock() + BOOTH_MUTATION_FAILURE_BACKOFF_AB)
				return false, result
			end
			return true, result
		end

		local function boothFolderAB()
			local gameObjects = workspace:FindFirstChild("GameObjects")
			return gameObjects and gameObjects:FindFirstChild("Booths") or nil
		end

		local function claimAnyBoothAB()
			local state, key = myBoothStateAB()
			if state then return state, key end
			if not boothMutationAllowedAB() then return nil, nil end
			local folder = boothFolderAB()
			if not folder then return nil, nil end
			local data = TradingBoothsAB and TradingBoothsAB.Data or {}
			for _, booth in ipairs(folder:GetChildren()) do
				if booth:IsA("Model") then
					local live = data[booth.Name]
					if type(live) ~= "table" or live.player == nil then
						if not boothMutationAllowedAB() then return nil, nil end
						local invoked = invokeMutationAB(ClaimBoothAB, true, booth.Name, false)
						if invoked then
							local deadline = os.clock() + BOOTH_REPLICATION_CONFIRM_TIMEOUT_AB
							repeat
								state, key = myBoothStateAB()
								if state then return state, key end
								task.wait(0.05)
							until os.clock() >= deadline


							return myBoothStateAB()
						end
					end
				end
			end
			return myBoothStateAB()
		end

		local function isMetaAB(item)
			if type(item) ~= "table" then return false end
			local name = item.name or (item.sub and item.sub.name)
			local explicit = item.rarity or item.Rarity or (item.sub and (item.sub.rarity or item.sub.Rarity))
			if explicit == "Meta" or item.Meta == true or item.IsMeta == true
				or (item.sub and (item.sub.Meta == true or item.sub.IsMeta == true))
			then
				return true
			end
			return type(name) == "string" and string.find(string.lower(name), "%f[%a]meta%f[%A]") ~= nil
		end

		local function rarityAB(item)
			if type(item) ~= "table" then return nil end
			if isMetaAB(item) then return "Meta" end
			local explicit = item.rarity or item.Rarity or (item.sub and (item.sub.rarity or item.sub.Rarity))
			if type(explicit) == "string" then
				for _, valid in ipairs(BRAINROT_RARITY_OPTIONS) do
					if explicit == valid then return explicit end
				end
			end
			local name = item.name or (item.sub and item.sub.name)
			local configured = type(name) == "string" and configuredRarityAB[name] or nil
			if type(configured) == "string" then return configured end
			local itemType
			pcall(function() itemType = GetItemTypeAB(item) end)
			if itemType ~= "Brainrot" then return nil end
			local value
			pcall(function() value = EconomyMathAB.GetBrainrotRarity(name) end)
			return value
		end

		local function boothContainsItemAB(state, itemId)
			local wanted = tostring(itemId)
			for offerId, item in pairs(state and state.items or {}) do
				if tostring(offerId) == wanted then return true end
				if type(item) == "table" then
					local guid = item.guid or item.id
					if guid ~= nil and tostring(guid) == wanted then return true end
				end
			end
			return false
		end

		local function boothOfferCountAB(state)
			local count = 0
			for _ in pairs(state and state.offers or {}) do count += 1 end
			return count
		end

		local function ownedInventoryCountAB(state)
			local seen = {}
			local count = 0
			for id in pairs(inventoryAB() or {}) do
				local key = tostring(id)
				if not seen[key] then seen[key] = true; count += 1 end
			end
			for offerId, item in pairs(state and state.items or {}) do
				local id = type(item) == "table" and (item.guid or item.id) or offerId
				local key = tostring(id or offerId)
				if not seen[key] then seen[key] = true; count += 1 end
			end
			return count
		end

		local function maxBoothSlotsAB()
			local maximum = tonumber(autoServerHopState.RuntimeBoothMaxSlots) or 3
			pcall(function()
				local root = tryAB(PlayerDataAB, {})
				if type(root) == "table" then
					maximum = math.clamp(
						math.floor(tonumber(GetMaxBoothSlotsAB(root)) or maximum),
						3,
						14
					)
				end
			end)
			autoServerHopState.RuntimeBoothMaxSlots = maximum
			return maximum
		end

		local function brainrotNameAB(item)
			if type(item) ~= "table" then return nil end
			local name = item.name or (item.sub and item.sub.name)
			return type(name) == "string" and name or nil
		end

		local function brainrotMutationAB(item)
			if type(item) ~= "table" then return nil end
			local mutation = item.mutation
				or item.Mutation
				or (item.sub and (item.sub.mutation or item.sub.Mutation))
			return type(mutation) == "string" and mutation or nil
		end

		local function brainrotTraitsAB(item)
			if type(item) ~= "table" then return {} end
			local traits = item.traits
				or item.Traits
				or (item.sub and (item.sub.traits or item.sub.Traits))
			if type(traits) == "table" then return traits end
			if type(traits) == "string" and traits ~= "" then
				local parsed = {}
				for trait in string.gmatch(traits, "[^,]+") do
					parsed[#parsed + 1] = trait
				end
				return parsed
			end
			return {}
		end

		local function itemPassesGlobalFiltersAB(item)
			local utility = autoServerHopState.Utility
			local avoidNames = utility.AutoBoothAvoidBrainrots
			local avoidMutations = utility.AutoBoothAvoidMutations
			local avoidTraits = utility.AutoBoothAvoidTraits
			local specificOnly = utility.AutoBoothSpecificOnly == true

			local hasAvoidNames =
				type(avoidNames) == "table" and next(avoidNames) ~= nil
			local hasAvoidMutations =
				type(avoidMutations) == "table" and next(avoidMutations) ~= nil
			local hasAvoidTraits =
				type(avoidTraits) == "table" and next(avoidTraits) ~= nil

			if not specificOnly
				and not hasAvoidNames
				and not hasAvoidMutations
				and not hasAvoidTraits
			then
				return true
			end

			local name
			if specificOnly or hasAvoidNames then
				name = brainrotNameAB(item)
				if not name then return false end
				if hasAvoidNames and avoidNames[name] == true then
					return false
				end
				if specificOnly then
					local specific = utility.AutoBoothSpecificBrainrots
					if type(specific) ~= "table" or specific[name] ~= true then
						return false
					end
				end
			end

			if hasAvoidMutations then
				local mutation = brainrotMutationAB(item)
				if mutation and avoidMutations[mutation] == true then
					return false
				end
			end

			if hasAvoidTraits then
				for _, trait in ipairs(brainrotTraitsAB(item)) do
					if avoidTraits[tostring(trait)] == true then
						return false
					end
				end
			end
			return true
		end

		local function itemMatchesListingSpecAB(item, spec)
			if type(item) ~= "table" or type(spec) ~= "table" then
				return false
			end
			if spec.Mode == "Brainrot" then
				return brainrotNameAB(item) == spec.Brainrot
			end
			return spec.Mode == "Rarity"
				and rarityAB(item) == spec.Rarity
		end

		local function ownedChoiceCountsAB(state)
			local seen = {}
			local nameCounts = {}
			local rarityCounts = {}
			local function addItem(id, item)
				if type(item) ~= "table" then return end
				local key = tostring(id)
				if seen[key] then return end
				seen[key] = true

				local name = brainrotNameAB(item)
				if name then
					nameCounts[name] = (nameCounts[name] or 0) + 1
				end
				local rarity = rarityAB(item)
				if rarity then
					rarityCounts[rarity] = (rarityCounts[rarity] or 0) + 1
				end
			end

			for id, item in pairs(inventoryAB() or {}) do
				addItem(id, item)
			end
			for offerId, item in pairs(state and state.items or {}) do
				local id = type(item) == "table" and (item.guid or item.id) or offerId
				addItem(id or offerId, item)
			end
			return nameCounts, rarityCounts
		end

		local function desiredSpecsAB(state, inventoryCount)
			local utility = autoServerHopState.Utility
			local specs = {}
			local nameCounts, rarityCounts = ownedChoiceCountsAB(state)
			for index = 1, maxBoothSlotsAB() do
				local prefix = "AutoBoothListing" .. tostring(index)
				local enabled = utility[prefix .. "Enabled"] == true
				local listByBrainrot = utility[prefix .. "ListByBrainrot"] == true
				local listByRarity = utility[prefix .. "ListByRarity"] == true
				local rarity = utility[prefix .. "Rarity"]
				local brainrot = utility[prefix .. "Brainrot"]
				local threshold = math.clamp(
					math.floor(tonumber(
						utility[prefix .. "InventoryThreshold"]
					) or 95),
					1,
					100
				)
				local minimumCopies = math.clamp(
					math.floor(tonumber(
						utility[prefix .. "MinimumCopies"]
					) or 1),
					1,
					100
				)

				local spec
				if listByBrainrot and type(brainrot) == "string" and brainrot ~= "" then
					spec = {
						Index = index,
						Mode = "Brainrot",
						Brainrot = brainrot,
					}
				elseif listByRarity and type(rarity) == "string" and rarity ~= "" then
					spec = {
						Index = index,
						Mode = "Rarity",
						Rarity = rarity,
					}
				end

				local ownedCount = spec
					and (
						spec.Mode == "Brainrot"
							and (nameCounts[spec.Brainrot] or 0)
							or (rarityCounts[spec.Rarity] or 0)
					)
					or 0
				if enabled
					and spec
					and inventoryCount >= threshold
					and ownedCount >= minimumCopies
				then
					spec.Price = math.clamp(
						math.floor(tonumber(
							utility[prefix .. "Tokens"]
						) or 1),
						1,
						1000000
					)
					spec.MessageWhenListed =
						utility[prefix .. "MessageWhenListed"] == true
					spec.ListedMessage =
						tostring(utility[prefix .. "ListedMessage"] or "")
					spec.MessageDelay = math.clamp(
						tonumber(utility[prefix .. "MessageDelay"]) or 0,
						0,
						30
					)
					spec.MessageGuardKey = prefix .. "MessageWhenListed"
					specs[#specs + 1] = spec
				end
			end
			return specs
		end

		local function matchExistingAB(state, specs)
			local matchedOffers, matchedSpecs = {}, {}
			for offerId, offer in pairs(state and state.offers or {}) do
				local item = state.items and state.items[offerId] or nil
				local rarity = rarityAB(item)
				local price = tonumber(offer and offer.cost and offer.cost.value)
				for specIndex, spec in ipairs(specs) do
					if not matchedSpecs[specIndex]
						and itemMatchesListingSpecAB(item, spec)
						and price == spec.Price
						and itemPassesGlobalFiltersAB(item)
					then
						matchedSpecs[specIndex] = offerId
						matchedOffers[tostring(offerId)] = true
						break
					end
				end
			end
			return matchedOffers, matchedSpecs
		end

		local function removeOfferAB(offerId)
			local suppressions = autoServerHopState.RuntimeBoothScriptRemoveUntil
			if type(suppressions) ~= "table" then
				suppressions = {}
				autoServerHopState.RuntimeBoothScriptRemoveUntil = suppressions
			end
			suppressions[tostring(offerId)] = os.clock() + 3.0
			local invoked = invokeMutationAB(RemoveBoothOfferingAB, true, offerId)
			if not invoked then return false end
			local deadline = os.clock() + BOOTH_REPLICATION_CONFIRM_TIMEOUT_AB
			repeat
				task.wait(0.05)
				local state = myBoothStateAB()
				if not state or not (state.offers and state.offers[offerId]) then return true end
			until os.clock() >= deadline
			return false
		end

		local function findListingItemAB(spec, state, reserved)
			local inventory = inventoryAB()
			if not inventory or type(spec) ~= "table" then return nil end

			local sorted
			local ok = pcall(function() sorted = SortItemsAB(inventory) end)
			if not ok or type(sorted) ~= "table" then return nil end

			local utility = autoServerHopState.Utility
			local bestFirst = utility.AutoBoothListBestFirst == true


			local first = bestFirst and 1 or #sorted
			local last = bestFirst and #sorted or 1
			local step = bestFirst and 1 or -1

			for index = first, last, step do
				local id = sorted[index]
				local sid = tostring(id)
				local item = inventory[id] or inventory[sid]
				if not reserved[sid]
					and type(item) == "table"
					and item.locked ~= true
					and itemMatchesListingSpecAB(item, spec)
					and itemPassesGlobalFiltersAB(item)
					and not boothContainsItemAB(state, id)
				then
					local tradeable = false
					pcall(function()
						tradeable = ItemIsTradeableAB(item) == true
					end)
					if tradeable then return sid end
				end
			end
		end

		local function sendPublicChatAB(message)
			if autoServerHopState.Utility.PauseScript == true or autoServerHopState.Utility.PauseMinigameFeatures == true then return false end
			message = tostring(message or "")
			if message == "" then return false end
			local channels = TextChatServiceAB:FindFirstChild("TextChannels")
			local general = channels and channels:FindFirstChild("RBXGeneral")
			if general then
				local ok = pcall(general.SendAsync, general, message)
				if ok then return true end
			end
			local events = RSAB:FindFirstChild("DefaultChatSystemChatEvents")
			local say = events and events:FindFirstChild("SayMessageRequest")
			return say and pcall(say.FireServer, say, message, "All") or false
		end

		local function scheduleBoothMessageAB(message, delaySeconds, guardKey)
			message = tostring(message or "")
			if message == "" then return end
			delaySeconds = math.clamp(tonumber(delaySeconds) or 0, 0, 30)
			task.spawn(function()
				if delaySeconds > 0 then task.wait(delaySeconds) end
				local utility = autoServerHopState.Utility
				if screenGui.Parent
					and utility.AutoBooth == true
					and (guardKey == nil or utility[guardKey] == true)
				then
					sendPublicChatAB(message)
				end
			end)
		end

		local function listItemAB(itemId, spec)
			local inventory = inventoryAB()
			local item = inventory and (inventory[itemId] or inventory[tostring(itemId)])
			if type(item) ~= "table" or item.locked == true then return false end
			local tradeable = false
			pcall(function() tradeable = ItemIsTradeableAB(item) == true end)
			if not tradeable then return false end

			local invoked = invokeMutationAB(ListBoothOfferingAB, true, itemId, spec.Price)
			if not invoked then return false end
			local deadline = os.clock() + BOOTH_REPLICATION_CONFIRM_TIMEOUT_AB
			repeat
				task.wait(0.05)
				local live = myBoothStateAB()
				if boothContainsItemAB(live, itemId) then
					if spec.MessageWhenListed == true and spec.ListedMessage ~= "" then
						scheduleBoothMessageAB(
							spec.ListedMessage,
							spec.MessageDelay,
							spec.MessageGuardKey
						)
					end
					return true
				end
			until os.clock() >= deadline
			return false
		end

		local function updateBoothNameAB(state)
			local wanted = string.sub(tostring(autoServerHopState.Utility.AutoBoothName or ""), 1, 70)
			local current = state.details and tostring(state.details.BoothMessage or "") or ""
			if current == wanted then messageRetryAtAB = 0; return false end
			if os.clock() < messageRetryAtAB then return false end
			local invoked = invokeMutationAB(ChangeBoothMessageAB, false, wanted)
			if invoked then
				messageRetryAtAB = os.clock() + BOOTH_MESSAGE_RETRY_HOLD_AB
				return true
			end
			return false
		end

		local function maintainBoothAB()
			if not boothMutationAllowedAB() then return end
			local state = myBoothStateAB(true)
			if not state then state = select(1, claimAnyBoothAB()) end
			if not state then return end

			if updateBoothNameAB(state) then return end

			if autoServerHopState.Utility.AutoBoothMessageAllListingsCompleted ~= true then
				configuredCompleteMessagedAB = false
			end
			if autoServerHopState.Utility.AutoBoothMessageAllPossibleCompleted ~= true then
				possibleCompleteMessagedAB = false
			end

			local inventoryCount = ownedInventoryCountAB(state)
			local specs = desiredSpecsAB(state, inventoryCount)
			local boothCapacity = maxBoothSlotsAB()

			local matchedOffers, matchedSpecs = matchExistingAB(state, specs)
			for offerId in pairs(state.offers or {}) do
				if not matchedOffers[tostring(offerId)] then
					configuredCompleteMessagedAB = false
					possibleCompleteMessagedAB = false
					removeOfferAB(offerId)
					return
				end
			end

			local matchedCount = 0
			for _ in pairs(matchedSpecs) do matchedCount += 1 end
			local allConfiguredComplete =
				#specs > 0 and matchedCount >= #specs

			if allConfiguredComplete then
				if not configuredCompleteMessagedAB
					and autoServerHopState.Utility.AutoBoothMessageAllListingsCompleted == true
				then
					configuredCompleteMessagedAB = true
					scheduleBoothMessageAB(
						autoServerHopState.Utility.AutoBoothAllListingsCompletedMessage,
						autoServerHopState.Utility.AutoBoothAllListingsCompletedMessageDelay,
						"AutoBoothMessageAllListingsCompleted"
					)
				end
			else
				configuredCompleteMessagedAB = false
			end

			if #specs == 0 then
				possibleCompleteMessagedAB = false
				return
			end

			local offerCount = boothOfferCountAB(state)
			if offerCount >= boothCapacity then
				if not possibleCompleteMessagedAB
					and autoServerHopState.Utility.AutoBoothMessageAllPossibleCompleted == true
				then
					possibleCompleteMessagedAB = true
					scheduleBoothMessageAB(
						autoServerHopState.Utility.AutoBoothAllPossibleCompletedMessage,
						autoServerHopState.Utility.AutoBoothAllPossibleCompletedMessageDelay,
						"AutoBoothMessageAllPossibleCompleted"
					)
				end
				return
			end

			if allConfiguredComplete then


				possibleCompleteMessagedAB = false
				return
			end

			local reserved = {}
			for offerId, item in pairs(state.items or {}) do
				local id = type(item) == "table" and (item.guid or item.id) or offerId
				reserved[tostring(id or offerId)] = true
			end

			for specIndex, spec in ipairs(specs) do
				if not matchedSpecs[specIndex] then
					local itemId = findListingItemAB(spec, state, reserved)
					if itemId then
						possibleCompleteMessagedAB = false
						reserved[tostring(itemId)] = true
						listItemAB(itemId, spec)
						return
					end
				end
			end


			if not possibleCompleteMessagedAB
				and autoServerHopState.Utility.AutoBoothMessageAllPossibleCompleted == true
			then
				possibleCompleteMessagedAB = true
				scheduleBoothMessageAB(
					autoServerHopState.Utility.AutoBoothAllPossibleCompletedMessage
				)
			end
		end

		while screenGui.Parent do
			if autoServerHopState.Utility.PauseScript ~= true
			and autoServerHopState.Utility.PauseMinigameFeatures ~= true
				and autoServerHopState.Utility.AutoBooth == true
			then
				local ok = pcall(maintainBoothAB)
				if not ok then
					task.wait(0.50)
				end
			else
				configuredCompleteMessagedAB = false
				possibleCompleteMessagedAB = false
			end
			task.wait(0.10)
		end
	end)
end






if IS_MINIGAME_PLACE then






task.spawn(function()


while screenGui.Parent do
    local flags = rawget(_G, "__TUFFHUB_MINIGAME_AUTOPLAY")
    local utility = rawget(_G, "__TUFFHUB_UTILITY_FEATURES")
    local enabled = false
    if type(utility) == "table"
        and utility.PauseScript ~= true
        and utility.PauseMinigameFeatures ~= true
        and utility.AutoPlayMaster == true
        and type(flags) == "table"
    then
        for _, value in pairs(flags) do
            if value == true then
                enabled = true
                break
            end
        end
    end
    if enabled then break end
    task.wait(0.10)
end
if not screenGui.Parent then return end


















local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local function requireWhenReadyMG(moduleScript)
    while screenGui.Parent do
        local ok, result = pcall(require, moduleScript)
        if ok and result ~= nil then return result end
        task.wait(0.25)
    end
end

local ClientGlobals = requireWhenReadyMG(
    ReplicatedStorage:WaitForChild("Client")
        :WaitForChild("Modules")
        :WaitForChild("ClientGlobals")
)
local Remotes = requireWhenReadyMG(
    ReplicatedStorage:WaitForChild("Shared")
        :WaitForChild("Remotes")
)
if not (ClientGlobals and Remotes) then return end
local ActiveMinigame = ClientGlobals.ActiveMinigame
local MinigameGameAction = Remotes.MinigameGameAction
local LocalPlayer = Players.LocalPlayer

local MINIGAME_AUTOPLAY_KEY = "__TUFFHUB_MINIGAME_AUTOPLAY"
local function minigameAutoplayEnabled(id)
    local flags = rawget(_G, MINIGAME_AUTOPLAY_KEY)
    local utility = rawget(_G, "__TUFFHUB_UTILITY_FEATURES")
    return type(utility) == "table"
        and utility.PauseScript ~= true
        and utility.PauseMinigameFeatures ~= true
        and utility.AutoPlayMaster == true
        and type(flags) == "table"
        and flags[id] == true
end

local scriptEnabled = true
local GLOBAL_KEY = "__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V13"

local oldController = rawget(_G, GLOBAL_KEY)
    or rawget(_G, "__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V11")
    or rawget(_G, "__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V10")
    or rawget(_G, "__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V9")
    or rawget(_G, "__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V8")
    or rawget(_G, "__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V7")
    or rawget(_G, "__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V6")
    or rawget(_G, "__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V5")
    or rawget(_G, "__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V4")
    or rawget(_G, "__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V3")
    or rawget(_G, "__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V2")
    or rawget(_G, "__TSUNAMI_UNIVERSAL_SMART_MINIGAMES_V1")
if oldController and type(oldController.Destroy) == "function" then
    pcall(function() oldController:Destroy() end)
end
rawset(_G, GLOBAL_KEY, nil)

local controller = {
    destroyed = false,
    startedAt = os.clock(),
}
rawset(_G, GLOBAL_KEY, controller)

local function envFunction(name)
    local environments = {}
    local function add(env)
        if type(env) ~= "table" then return end
        for _, existing in ipairs(environments) do
            if existing == env then return end
        end
        environments[#environments + 1] = env
    end

    add(_G)
    pcall(function() if getgenv then add(getgenv()) end end)
    pcall(function() if getrenv then add(getrenv()) end end)
    pcall(function() if getfenv then add(getfenv(0)) end end)

    local aliases = { name }
    if name == "request" or name == "http_request" then
        aliases = { "request", "http_request", "httprequest", "krnl_request" }
    end

    for _, env in ipairs(environments) do
        for _, alias in ipairs(aliases) do
            local ok, value = pcall(function() return env[alias] end)
            if ok and type(value) == "function" then return value end
        end
        for _, namespaceName in ipairs({ "syn", "http", "fluxus" }) do
            local ok, namespace = pcall(function() return env[namespaceName] end)
            if ok and type(namespace) == "table" then
                for _, alias in ipairs(aliases) do
                    local ok2, value = pcall(function() return namespace[alias] end)
                    if ok2 and type(value) == "function" then return value end
                end
            end
        end
    end
    return nil
end

local function tryIndex(path)
    local ok, value = pcall(function()
        return ActiveMinigame:TryIndex(path)
    end)
    return ok and value or nil
end

local function safeIndex(value, key)
    if value == nil then return nil end
    local ok, result = pcall(function() return value[key] end)
    return ok and result or nil
end

local function gameId()
    return tryIndex({ "session", "gameId" })
end

local function publicPhase()
    return tryIndex({ "session", "public", "phase" })
end

local function seatIndex()
    return tonumber(tryIndex({ "session", "private", "seatIndex" }))
end

controller.MoveDelaySeconds = function(id)


    if id == "PopcornBurst" then
        return 0
    end

    local utility = rawget(_G, "__TUFFHUB_UTILITY_FEATURES")
    if type(utility) ~= "table" or type(id) ~= "string" then
        return 0
    end
    return math.clamp(
        tonumber(utility["MoveDelay" .. id]) or 0,
        0,
        5
    )
end

controller.MoveDelayApplied = {}

local MOVE_DELAY_RESERVE = {
    ConnectFour = 2.00,
    CandyBomb = 1.25,
    NumberGuess = 1.25,
    FootballDraft = 1.25,
    Knockout = 3.25,
    Battleship = 1.25,
}

local function moveDelayEligibleAction(id, action)
    if id == "ConnectFour" then
        return action == "DropChip"
    elseif id == "CandyBomb" then
        return action == "PlaceBombs" or action == "EatCandy"
    elseif id == "NumberGuess" then
        return action == "PickNumber" or action == "Guess"
    elseif id == "FootballDraft" then

        return action == "Reroll" or action == "Pick"
    elseif id == "Knockout" then


        return action == "LockAim"
    elseif id == "Battleship" then


        return action == "Fire"
    end
    return false
end

local function fireAction(action, ...)
    local currentGameId = gameId()
    if controller.destroyed
        or not scriptEnabled
        or not minigameAutoplayEnabled(currentGameId)
    then
        return false
    end

    local args = table.pack(...)
    local requestedDelay = controller.MoveDelaySeconds(currentGameId)

    if requestedDelay > 0 and moveDelayEligibleAction(currentGameId, action) then
        local phaseBefore = publicPhase()
        local publicTurnBefore = tryIndex({ "session", "public", "currentTurn" })
        local privateBefore = tryIndex({ "session", "private" })
        local privateTurnBefore = safeIndex(privateBefore, "currentTurn")

        local publicDeadline = tonumber(tryIndex({ "session", "public", "deadline" }))
        local privateDeadline = tonumber(safeIndex(privateBefore, "phaseDeadline"))
        local actionDeadline = publicDeadline or privateDeadline

        local delayToken = table.concat({
            tostring(currentGameId),
            tostring(phaseBefore),
            tostring(publicTurnBefore),
            tostring(privateTurnBefore),
            tostring(actionDeadline),
            currentGameId == "FootballDraft" and tostring(action) or "",
            currentGameId == "NumberGuess" and tostring(action) or "",
            currentGameId == "CandyBomb" and tostring(action) or "",
        }, "|")

        if controller.MoveDelayApplied[delayToken] ~= true then
            controller.MoveDelayApplied[delayToken] = true

            if next(controller.MoveDelayApplied) ~= nil then
                local count = 0
                for _ in pairs(controller.MoveDelayApplied) do
                    count += 1
                    if count > 96 then
                        controller.MoveDelayApplied = { [delayToken] = true }
                        break
                    end
                end
            end

            local actualDelay = requestedDelay
            if actionDeadline then
                local remaining =
                    actionDeadline - workspace:GetServerTimeNow()
                actualDelay = math.min(
                    actualDelay,
                    math.max(
                        0,
                        remaining - (MOVE_DELAY_RESERVE[currentGameId] or 1.25)
                    )
                )
            end

            if actualDelay > 0 then
                task.wait(actualDelay)

                if controller.destroyed
                    or not scriptEnabled
                    or gameId() ~= currentGameId
                    or publicPhase() ~= phaseBefore
                    or not minigameAutoplayEnabled(currentGameId)
                then
                    return false
                end

                local publicTurnAfter =
                    tryIndex({ "session", "public", "currentTurn" })
                if publicTurnBefore ~= nil
                    and publicTurnAfter ~= publicTurnBefore
                then
                    return false
                end

                local privateAfter = tryIndex({ "session", "private" })
                local privateTurnAfter = safeIndex(privateAfter, "currentTurn")
                if privateTurnBefore ~= nil
                    and privateTurnAfter ~= privateTurnBefore
                then
                    return false
                end
            end
        end
    end

    return pcall(function()
        MinigameGameAction:FireServer(action, table.unpack(args, 1, args.n))
    end)
end

local function randomRange(rng, a, b)
    return a + (b - a) * rng:NextNumber()
end

function controller:Destroy()
    if self.destroyed then return end
    self.destroyed = true
    scriptEnabled = false

    local popController = rawget(_G, "__TSUNAMI_POPCORN_PERFECT_V17")
        or rawget(_G, "__TSUNAMI_POPCORN_PERFECT_V16")
    if popController and type(popController.Destroy) == "function" then
        pcall(function() popController:Destroy() end)
    end

    if rawget(_G, GLOBAL_KEY) == self then
        rawset(_G, GLOBAL_KEY, nil)
    end
end




task.spawn(function()









































local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")



for _, key in ipairs({
    "__TSUNAMI_PERFECT_POPCORN",
    "__TSUNAMI_POPCORN_PERFECT_V2",
    "__TSUNAMI_POPCORN_PERFECT_V3",
    "__TSUNAMI_POPCORN_PERFECT_V4",
    "__TSUNAMI_POPCORN_PERFECT_V5",
    "__TSUNAMI_POPCORN_PERFECT_V6",
    "__TSUNAMI_POPCORN_PERFECT_V7",
    "__TSUNAMI_POPCORN_PERFECT_V8",
    "__TSUNAMI_POPCORN_PERFECT_V9",
    "__TSUNAMI_POPCORN_PERFECT_V11",
    "__TSUNAMI_POPCORN_PERFECT_V12",
    "__TSUNAMI_POPCORN_PERFECT_V13",
    "__TSUNAMI_POPCORN_PERFECT_V14",
    "__TSUNAMI_POPCORN_PERFECT_V15",
    "__TSUNAMI_POPCORN_PERFECT_V16",
    "__TSUNAMI_POPCORN_PERFECT_V17",
}) do
    local old = rawget(_G, key)
    if old and type(old.Destroy) == "function" then
        pcall(function()
            old:Destroy()
        end)
    end
    rawset(_G, key, nil)
end

local ClientGlobals = require(ReplicatedStorage.Client.Modules.ClientGlobals)
local Remotes = require(ReplicatedStorage.Shared.Remotes)

local ActiveMinigame = ClientGlobals.ActiveMinigame
local MinigameGameAction = Remotes.MinigameGameAction
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local GAME_ID = "PopcornBurst"

local OUTER_START_SCALE = 0.65
local TARGET_SCALE = 0.35
local TARGET_FRACTION = 1 - TARGET_SCALE / OUTER_START_SCALE





local TRACKING_HISTORY = 7
local TRACKING_PING_REFRESH = 0.10
local MIN_GEOMETRY_SAMPLES = 5
local MAX_GEOMETRY_SAMPLES = 12
local GEOMETRY_LOCK_SPREAD = 0.008


local LIMITED_GEOMETRY_LOCK_WINDOW = 0.024
local ZERO_GEOMETRY_HARD_FALLBACK_WINDOW = 0.010
local PING_HISTORY_LIMIT = 31
local CURRENT_PING_WEIGHT = 0.20
local MAX_CURRENT_PING_DEVIATION = 0.015
local MAX_KERNEL_COMPENSATION_DRIFT = 0.008
local KERNEL_COMPENSATION_HISTORY = 7



local BASE_PRECISION_SPIN_WINDOW = 0.004
local MAX_PRECISION_SPIN_WINDOW = 0.010
local FAILSAFE_EXTRA_EARLY_LEAD = 0.000




local MAX_INBOUND_COMPENSATION = 0.200




local HIGH_SCORE_ANCHOR_MIN = 90
local PING_FOLLOW_FACTOR = 0.50
local STALE_ANCHOR_PING_DELTA = 0.055
local EXPLICIT_DIRECTION_STEP_MIN = 0.0010
local EXPLICIT_DIRECTION_STEP_MAX = 0.0080
local EXPLICIT_BIAS_MAX_ABS = 0.020
local ADAPTIVE_BIAS_MAX_ABS = 0.018
local PROBE_OFFSET = 0.0015
local PROBE_MIN_SCORE_GAP = 4
local PROBE_STEP_MIN = 0.0005
local PROBE_STEP_MAX = 0.0030
local LOCAL_RESIDUAL_LEARN_FACTOR = 0.45
local LOCAL_RESIDUAL_MAX_CORRECTION = 0.0020




rawset(_G, "__TSUNAMI_POPCORN_CALIBRATION", nil)
rawset(_G, "__TSUNAMI_POPCORN_TIMING_MODEL_V6", nil)

local timingModel = rawget(_G, "__TSUNAMI_POPCORN_TIMING_MODEL_V11")
if type(timingModel) ~= "table" then
    timingModel = {
        anchorBaseComp = nil,
        anchorPingHalf = nil,
        anchorQuality = 0,
        explicitBias = 0,
        adaptiveBias = 0,
        probePolarity = 1,
        probePositive = nil,
        probeNegative = nil,
        lastQuality = nil,
    }
    rawset(_G, "__TSUNAMI_POPCORN_TIMING_MODEL_V11", timingModel)
end

local controller = {
    destroyed = false,
    connections = {},
    disconnectors = {},
    scheduled = {},
    fired = {},
    attempts = {},
    resultProcessed = {},
    lastAttemptKeyBySlot = {},
    roundSerial = 0,
    kernelOccurrence = 0,
    currentKernelKey = nil,
    currentKernelSlot = nil,
    wasActive = false,
    lastResultIdentity = nil,
    currentButton = nil,
    currentOuter = nil,
    dataPingSamples = {},
    networkPingSamples = {},
    timingModel = timingModel,
    authoritativeFieldPrinted = {},
}

_G.__TSUNAMI_POPCORN_PERFECT_V17 = controller

local function nowServer()
    return workspace:GetServerTimeNow()
end

local function tryIndex(path)
    local ok, value = pcall(function()
        return ActiveMinigame:TryIndex(path)
    end)
    return ok and value or nil
end

local function privateState()
    local private = tryIndex({ "session", "private" })
    return type(private) == "table" and private.myState or nil
end

local function popcornActive()
    if not scriptEnabled or not minigameAutoplayEnabled(GAME_ID) then
        return false
    end

    if tryIndex({ "session", "gameId" }) ~= GAME_ID then
        return false
    end

    local phase = tryIndex({ "session", "public", "phase" })
    if phase ~= nil and phase ~= "Playing" then
        return false
    end

    local state = privateState()
    return type(state) == "table" and state.finished ~= true
end

local function median(values)
    if #values == 0 then return nil end

    local copy = table.clone(values)
    table.sort(copy)

    local n = #copy
    if n % 2 == 1 then
        return copy[(n + 1) // 2]
    end

    return (copy[n // 2] + copy[n // 2 + 1]) * 0.5
end

local function pushSample(list, value, limit)
    if type(value) ~= "number" or value <= 0 then
        return
    end

    list[#list + 1] = value

    while #list > limit do
        table.remove(list, 1)
    end
end

local function readDataPingSeconds()
    local ok, value = pcall(function()
        local network = Stats:FindFirstChild("Network")
        local serverStats = network and network:FindFirstChild("ServerStatsItem")
        local dataPing = serverStats and serverStats:FindFirstChild("Data Ping")
        return dataPing and dataPing:GetValue()
    end)

    value = ok and tonumber(value) or nil
    if not value or value <= 0 then
        return nil
    end



    if value > 5 then
        value /= 1000
    end

    if value > 2 then
        return nil
    end

    return value
end

local function readNetworkPingSeconds()
    local ok, value = pcall(function()
        return LocalPlayer:GetNetworkPing()
    end)

    value = ok and tonumber(value) or nil
    if not value or value <= 0 or value > 2 then
        return nil
    end

    return value
end

local function updatePingSamples()
    local data = readDataPingSeconds()
    local network = readNetworkPingSeconds()

    pushSample(controller.dataPingSamples, data, PING_HISTORY_LIMIT)
    pushSample(controller.networkPingSamples, network, PING_HISTORY_LIMIT)

    return data, network
end

local function inboundReplicationEstimate()


    local currentData = readDataPingSeconds()
    local currentNetwork = readNetworkPingSeconds()




    local dataSorted = table.clone(controller.dataPingSamples)
    local networkSorted = table.clone(controller.networkPingSamples)
    table.sort(dataSorted)
    table.sort(networkSorted)

    local function quantile(sorted, fraction)
        if #sorted == 0 then return nil end
        local position = 1 + (#sorted - 1) * math.clamp(fraction, 0, 1)
        local lower = math.floor(position)
        local upper = math.ceil(position)
        if lower == upper then return sorted[lower] end
        local alpha = position - lower
        return sorted[lower] + (sorted[upper] - sorted[lower]) * alpha
    end

    local dataMedian = quantile(dataSorted, 0.50)
    local networkMedian = quantile(networkSorted, 0.50)





    local networkMedianHalf = networkMedian and networkMedian * 0.5 or nil
    local dataMedianHalf = dataMedian and dataMedian * 0.5 or nil
    local medianHalf
    if networkMedianHalf and dataMedianHalf then
        medianHalf = networkMedianHalf + math.clamp(
            (dataMedianHalf - networkMedianHalf) * 0.50,
            0,
            0.020
        )
    else
        medianHalf = dataMedianHalf or networkMedianHalf or 0
    end

    local currentNetworkHalf = currentNetwork and currentNetwork * 0.5 or nil
    local currentDataHalf = currentData and currentData * 0.5 or nil
    local currentHalf
    if currentNetworkHalf and currentDataHalf then
        currentHalf = currentNetworkHalf + math.clamp(
            (currentDataHalf - currentNetworkHalf) * 0.50,
            0,
            0.020
        )
    else
        currentHalf = currentDataHalf or currentNetworkHalf or medianHalf
    end





    currentHalf = math.clamp(
        currentHalf,
        math.max(0, medianHalf - MAX_CURRENT_PING_DEVIATION),
        medianHalf + MAX_CURRENT_PING_DEVIATION
    )
    local liveHalf = medianHalf * (1 - CURRENT_PING_WEIGHT)
        + currentHalf * CURRENT_PING_WEIGHT

    local model = controller.timingModel
    local baseEstimate = liveHalf

    if type(model.anchorBaseComp) == "number"
        and type(model.anchorPingHalf) == "number"
    then




        local pingDelta = math.clamp(
            liveHalf - model.anchorPingHalf,
            -STALE_ANCHOR_PING_DELTA,
            STALE_ANCHOR_PING_DELTA
        )
        baseEstimate = model.anchorBaseComp + pingDelta * PING_FOLLOW_FACTOR
    end

    local explicitBias = math.clamp(
        tonumber(model.explicitBias) or 0,
        -EXPLICIT_BIAS_MAX_ABS,
        EXPLICIT_BIAS_MAX_ABS
    )
    local adaptiveBias = math.clamp(
        tonumber(model.adaptiveBias) or 0,
        -ADAPTIVE_BIAS_MAX_ABS,
        ADAPTIVE_BIAS_MAX_ABS
    )

    local estimate = baseEstimate + explicitBias + adaptiveBias

    return math.clamp(estimate, 0, MAX_INBOUND_COMPENSATION),
        dataMedian,
        networkMedian,
        liveHalf,
        currentData,
        currentNetwork,
        baseEstimate,
        explicitBias,
        adaptiveBias
end

local function popcornHolder()
    local minigameGui = PlayerGui:FindFirstChild("MinigameGui")
    local games = minigameGui and minigameGui:FindFirstChild("Games")
    local gui = games and games:FindFirstChild("PopcornBurstGui")
    return gui and gui:FindFirstChild("Holder")
end

local function clearGeometryCache()
    controller.currentButton = nil
    controller.currentOuter = nil
end

local function cacheStillValid()
    local h = popcornHolder()
    return h
        and controller.currentButton
        and controller.currentButton.Parent == h
        and controller.currentOuter
        and controller.currentOuter.Parent == controller.currentButton
end

local function locateOuterRing()
    if cacheStillValid() then
        return controller.currentOuter
    end

    clearGeometryCache()

    local h = popcornHolder()
    if not h then
        return nil
    end








    for _, button in ipairs(h:GetChildren()) do
        if button:IsA("TextButton") then
            local candidate = nil
            local candidateScale = -math.huge

            for _, child in ipairs(button:GetChildren()) do
                if child:IsA("Frame") and child:FindFirstChildOfClass("UIStroke") then
                    local scale = tonumber(child.Size.X.Scale)
                    if scale and scale > TARGET_SCALE + 0.00001 and scale > candidateScale then
                        candidate = child
                        candidateScale = scale
                    end
                end
            end



            if not candidate then
                local farthest = nil
                local farthestDistance = 0

                for _, child in ipairs(button:GetChildren()) do
                    if child:IsA("Frame") and child:FindFirstChildOfClass("UIStroke") then
                        local scale = tonumber(child.Size.X.Scale)
                        if scale then
                            local distance = math.abs(scale - TARGET_SCALE)
                            if distance > farthestDistance + 1e-6 then
                                farthest = child
                                farthestDistance = distance
                            end
                        end
                    end
                end

                candidate = farthest
            end

            if candidate then
                controller.currentButton = button
                controller.currentOuter = candidate
                return candidate
            end
        end
    end

    return nil
end

local function sampleOuterScale()
    local outer = locateOuterRing()
    if not outer then return nil end

    local before = nowServer()

    local ok, scale = pcall(function()
        return outer.Size.X.Scale
    end)

    local after = nowServer()

    if not ok then
        clearGeometryCache()
        return nil
    end

    scale = tonumber(scale)
    if not scale then
        return nil
    end

    return scale, (before + after) * 0.5
end

local function resultBlocksAttempt(state)




    return type(state and state.lastResult) == "table"
end

local function kernelStillLive(slot)
    if controller.destroyed or not popcornActive() then
        return false
    end

    local state = privateState()
    if type(state) ~= "table"
        or state.finished == true
        or tonumber(state.activeKernelSlot) ~= tonumber(slot)
        or resultBlocksAttempt(state)
    then
        return false
    end

    return (tonumber(state.ringDuration) or 0) > 0
end

local function normalizeServerTimestamp(value)
    value = tonumber(value)
    if not value then return nil end


    if value > 100000000000 then
        value /= 1000
    end



    if math.abs(value - nowServer()) > 15 then
        return nil
    end

    return value
end

local function scanTimingTable(tbl, prefix, duration, depth, seen)
    if type(tbl) ~= "table" or depth > 2 or seen[tbl] then
        return nil
    end

    seen[tbl] = true

    for key, value in pairs(tbl) do
        local keyString = string.lower(tostring(key))
        local fullKey = prefix == "" and tostring(key)
            or (prefix .. "." .. tostring(key))

        if type(value) == "number" then
            local timestamp = normalizeServerTimestamp(value)

            if timestamp then


                if (string.find(keyString, "perfect", 1, true)
                    or string.find(keyString, "target", 1, true))
                    and string.find(keyString, "time", 1, true)
                then
                    return timestamp, fullKey, "target"
                end


                if (string.find(keyString, "ring", 1, true)
                    and (string.find(keyString, "start", 1, true)
                        or string.find(keyString, "begin", 1, true)))
                    or keyString == "ringstartedat"
                    or keyString == "ringstarttime"
                then
                    return timestamp + duration * TARGET_FRACTION,
                        fullKey,
                        "start"
                end


                if string.find(keyString, "ring", 1, true)
                    and (string.find(keyString, "deadline", 1, true)
                        or string.find(keyString, "end", 1, true)
                        or string.find(keyString, "expire", 1, true))
                then
                    local startTime = timestamp - duration
                    return startTime + duration * TARGET_FRACTION,
                        fullKey,
                        "deadline"
                end
            end
        elseif type(value) == "table" then
            local target, foundKey, kind = scanTimingTable(
                value,
                fullKey,
                duration,
                depth + 1,
                seen
            )

            if target then
                return target, foundKey, kind
            end
        end
    end

    return nil
end

local function authoritativeTargetFromState(state, duration)
    if type(state) ~= "table" then
        return nil
    end

    return scanTimingTable(state, "", duration, 0, {})
end

local function visualCrossingFromSample(scale, sampledAt, duration)
    if type(scale) ~= "number" or type(sampledAt) ~= "number" then
        return nil
    end
    if scale < -0.01 or scale > OUTER_START_SCALE + 0.02 then
        return nil
    end




    return sampledAt
        + duration * ((scale - TARGET_SCALE) / OUTER_START_SCALE)
end

local function chooseProbeOffset()



    return 0
end

local function precisionSpinWindow()
    local frameTime
    pcall(function() frameTime = tonumber(Stats.FrameTime) end)
    frameTime = tonumber(frameTime) or 0
    return math.clamp(
        math.max(BASE_PRECISION_SPIN_WINDOW, frameTime * 0.20),
        BASE_PRECISION_SPIN_WINDOW,
        MAX_PRECISION_SPIN_WINDOW
    )
end

local function preciseWaitUntil(targetTime, slot, key)
    while controller.currentKernelKey == key and kernelStillLive(slot) do
        local remaining = targetTime - nowServer()
        local spinWindow = precisionSpinWindow()
        if remaining <= spinWindow then
            break
        end



        task.wait(math.max(0.001, remaining - spinWindow))
    end

    if controller.currentKernelKey ~= key or not kernelStillLive(slot) then
        return false
    end

    while nowServer() < targetTime do
        if controller.destroyed
            or not scriptEnabled
            or not minigameAutoplayEnabled(GAME_ID)
            or controller.currentKernelKey ~= key
        then
            return false
        end
    end

    return controller.currentKernelKey == key and kernelStillLive(slot)
end

local function fireAttempt(slot, key, targetTime, details)
    if controller.fired[key]
        or controller.currentKernelKey ~= key
        or not kernelStillLive(slot)
    then
        return false
    end




    local firedAt
    local sent = false
    for _ = 1, 3 do
        if controller.currentKernelKey ~= key or not kernelStillLive(slot) then
            return false
        end

        firedAt = nowServer()




        local reportedAt = tonumber(targetTime) or firedAt
        if reportedAt > firedAt then
            reportedAt = firedAt
        end
        sent = pcall(
            MinigameGameAction.FireServer,
            MinigameGameAction,
            "AttemptPop",
            reportedAt
        )
        details.reportedAt = reportedAt
        if sent then
            break
        end
    end

    if not sent then
        return false
    end

    controller.fired[key] = true

    local localScale, localScaleAt = sampleOuterScale()
    local scaleAtFire = localScale
    if type(localScale) == "number"
        and type(localScaleAt) == "number"
        and type(details.duration) == "number"
        and details.duration > 0
    then
        scaleAtFire = localScale + OUTER_START_SCALE
            * math.max(0, localScaleAt - firedAt) / details.duration
    end

    details.targetTime = targetTime
    details.firedAt = firedAt
    details.localScale = scaleAtFire
    details.localScaleAt = firedAt
    details.schedulerErrorMs = (firedAt - targetTime) * 1000

    if type(scaleAtFire) == "number"
        and type(details.effectiveCompensation) == "number"
        and type(details.duration) == "number"
        and details.duration > 0
        and string.sub(tostring(details.source), 1, 7) ~= "server:"
    then
        local expectedScale = TARGET_SCALE
            + OUTER_START_SCALE
                * (details.effectiveCompensation / details.duration)
        details.expectedLocalScale = expectedScale
        details.localTimingResidual = (expectedScale - scaleAtFire)
            * details.duration / OUTER_START_SCALE
    end

    controller.attempts[key] = details
    controller.lastAttemptKeyBySlot[slot] = key
    return true
end

local function runKernel(slot, duration, key, stateSeenAt)
    clearGeometryCache()

    local state = privateState()
    local authoritativeTarget, authoritativeField, authoritativeKind =
        authoritativeTargetFromState(state, duration)

    local compensation, dataRtt, networkRtt, livePingHalf,
        currentDataRtt, currentNetworkRtt, baseCompensation,
        explicitBias, adaptiveBias = inboundReplicationEstimate()

    local targetTime
    local source
    local visualTarget = nil
    local sampleCount = 0
    local probeOffset = 0
    local latestScale = nil
    local crossingHistory = {}
    local kernelBaseCompensation = compensation
    local compensationHistory = { compensation }

    if authoritativeTarget then
        targetTime = authoritativeTarget
        source = "server:" .. tostring(authoritativeField)

        if not controller.authoritativeFieldPrinted[authoritativeField] then
            controller.authoritativeFieldPrinted[authoritativeField] = true
        end
    else
        probeOffset = chooseProbeOffset()
        visualTarget = stateSeenAt + duration * TARGET_FRACTION
        source = "live-ring+latency"

        local nextPingRefreshAt = 0




        while kernelStillLive(slot) do
            local scale, sampledAt = sampleOuterScale()
            latestScale = scale or latestScale

            local crossing = visualCrossingFromSample(scale, sampledAt, duration)
            if crossing then
                crossingHistory[#crossingHistory + 1] = crossing
                while #crossingHistory > TRACKING_HISTORY do
                    table.remove(crossingHistory, 1)
                end
                visualTarget = median(crossingHistory) or crossing
                sampleCount += 1
            end

            local nowClock = os.clock()
            if nowClock >= nextPingRefreshAt then
                local freshCompensation
                freshCompensation, dataRtt, networkRtt, livePingHalf,
                    currentDataRtt, currentNetworkRtt, baseCompensation,
                    explicitBias, adaptiveBias = inboundReplicationEstimate()




                freshCompensation = math.clamp(
                    freshCompensation,
                    math.max(0, kernelBaseCompensation - MAX_KERNEL_COMPENSATION_DRIFT),
                    kernelBaseCompensation + MAX_KERNEL_COMPENSATION_DRIFT
                )
                pushSample(
                    compensationHistory,
                    freshCompensation,
                    KERNEL_COMPENSATION_HISTORY
                )
                compensation = median(compensationHistory) or freshCompensation
                nextPingRefreshAt = nowClock + TRACKING_PING_REFRESH
            end





            local failsafeLead = sampleCount >= MIN_GEOMETRY_SAMPLES
                and 0 or FAILSAFE_EXTRA_EARLY_LEAD
            targetTime = visualTarget - compensation - probeOffset - failsafeLead




            local remainingToTarget = targetTime - nowServer()
            local stableGeometry = false
            if sampleCount >= MIN_GEOMETRY_SAMPLES and #crossingHistory > 0 then
                local minCrossing = math.huge
                local maxCrossing = -math.huge
                for _, value in ipairs(crossingHistory) do
                    minCrossing = math.min(minCrossing, value)
                    maxCrossing = math.max(maxCrossing, value)
                end
                stableGeometry = maxCrossing - minCrossing <= GEOMETRY_LOCK_SPREAD
            end

            if stableGeometry or sampleCount >= MAX_GEOMETRY_SAMPLES then
                source = "live-ring+latency"
                break
            elseif sampleCount > 0
                and remainingToTarget <= LIMITED_GEOMETRY_LOCK_WINDOW
            then
                source = "limited-ring-failsafe"
                break
            elseif sampleCount == 0
                and remainingToTarget <= ZERO_GEOMETRY_HARD_FALLBACK_WINDOW
            then
                source = "state-arrival-failsafe"
                break
            end

            RunService.RenderStepped:Wait()
        end
    end

    if not kernelStillLive(slot) then
        controller.scheduled[key] = nil
        return
    end



    targetTime = targetTime or nowServer()




    local effectiveCompensation = string.sub(tostring(source), 1, 7) == "server:"
        and 0
        or (compensation + probeOffset)

    local details = {
        source = source,
        duration = duration,
        stateSeenAt = stateSeenAt,
        visualStart = visualTarget and (visualTarget - duration * TARGET_FRACTION) or nil,
        visualTarget = visualTarget,
        inbound = compensation,
        baseCompensation = baseCompensation,
        effectiveCompensation = effectiveCompensation,
        probeOffset = probeOffset,
        dataRtt = dataRtt,
        networkRtt = networkRtt,
        livePingHalf = livePingHalf,
        currentDataRtt = currentDataRtt,
        currentNetworkRtt = currentNetworkRtt,
        explicitBias = explicitBias or 0,
        adaptiveBias = adaptiveBias or 0,
        anchorBaseComp = controller.timingModel.anchorBaseComp,
        anchorQuality = controller.timingModel.anchorQuality or 0,
        geometrySamples = sampleCount,
        latestTrackedScale = latestScale,
    }

    if preciseWaitUntil(targetTime, slot, key) then
        fireAttempt(slot, key, targetTime, details)
    end

    controller.scheduled[key] = nil
end

local function directionalHintFromResult(result)
    if type(result) ~= "table" then
        return nil
    end




    for key, value in pairs(result) do
        local keyText = string.lower(tostring(key))
        local valueText = string.lower(tostring(value))

        if string.find(keyText, "early", 1, true)
            or string.find(valueText, "early", 1, true)
        then
            return -1
        end

        if string.find(keyText, "late", 1, true)
            or string.find(valueText, "late", 1, true)
        then
            return 1
        end
    end

    return nil
end

local function learnFromResult(result, attempt)
    if not attempt
        or string.sub(tostring(attempt.source), 1, 7) == "server:"
    then
        return
    end

    local model = controller.timingModel
    local points = tonumber(result.points)
    local rating = tostring(result.rating)
    local quality = points or (rating == "Perfect" and 100 or 0)
    quality = math.clamp(tonumber(quality) or 0, 0, 100)
    model.lastQuality = quality



    local direction = directionalHintFromResult(result)
    if direction then
        local deficit = (100 - quality) / 100
        local step = EXPLICIT_DIRECTION_STEP_MIN
            + (EXPLICIT_DIRECTION_STEP_MAX - EXPLICIT_DIRECTION_STEP_MIN) * deficit

        model.explicitBias = math.clamp(
            (tonumber(model.explicitBias) or 0) + direction * step,
            -EXPLICIT_BIAS_MAX_ABS,
            EXPLICIT_BIAS_MAX_ABS
        )
    end




    local localResidual = tonumber(attempt.localTimingResidual)
    local reliableGeometryResidual =
        attempt.source == "live-ring+latency"
        and (tonumber(attempt.geometrySamples) or 0) >= MIN_GEOMETRY_SAMPLES
    if quality > 0
        and quality < 99
        and reliableGeometryResidual
        and localResidual
        and math.abs(localResidual) >= 0.00030
    then
        local correction = math.clamp(
            localResidual * LOCAL_RESIDUAL_LEARN_FACTOR,
            -LOCAL_RESIDUAL_MAX_CORRECTION,
            LOCAL_RESIDUAL_MAX_CORRECTION
        )
        model.explicitBias = math.clamp(
            (tonumber(model.explicitBias) or 0) + correction,
            -EXPLICIT_BIAS_MAX_ABS,
            EXPLICIT_BIAS_MAX_ABS
        )
    end




    local probeOffset = tonumber(attempt.probeOffset) or 0
    if math.abs(probeOffset) >= PROBE_OFFSET * 0.5 then
        local sample = {
            quality = quality,
            pingHalf = tonumber(attempt.livePingHalf) or 0,
            duration = tonumber(attempt.duration) or 0,
        }

        if probeOffset > 0 then
            model.probePositive = sample
        else
            model.probeNegative = sample
        end

        local positive = model.probePositive
        local negative = model.probeNegative
        if type(positive) == "table" and type(negative) == "table" then
            local comparablePing = math.abs(
                (tonumber(positive.pingHalf) or 0)
                - (tonumber(negative.pingHalf) or 0)
            ) <= 0.025
            local comparableDuration = math.abs(
                (tonumber(positive.duration) or 0)
                - (tonumber(negative.duration) or 0)
            ) <= 1.50

            if comparablePing and comparableDuration then
                local gap = (tonumber(positive.quality) or 0)
                    - (tonumber(negative.quality) or 0)

                if math.abs(gap) >= PROBE_MIN_SCORE_GAP then
                    local strength = math.clamp(math.abs(gap) / 35, 0, 1)
                    local step = PROBE_STEP_MIN
                        + (PROBE_STEP_MAX - PROBE_STEP_MIN) * strength
                    local directionFromProbe = gap > 0 and 1 or -1

                    model.adaptiveBias = math.clamp(
                        (tonumber(model.adaptiveBias) or 0)
                            + directionFromProbe * step,
                        -ADAPTIVE_BIAS_MAX_ABS,
                        ADAPTIVE_BIAS_MAX_ABS
                    )
                end
            end



            model.probePositive = nil
            model.probeNegative = nil
        end
    end





    local previousAnchorQuality = tonumber(model.anchorQuality) or 0
    local mayUpdateAnchor = rating == "Perfect"
        or quality >= 99
        or (previousAnchorQuality < 99 and quality >= HIGH_SCORE_ANCHOR_MIN)

    if mayUpdateAnchor then
        local weight
        if rating == "Perfect" then
            weight = 0.90
        elseif quality >= 99 then
            weight = 0.80
        else
            weight = 0.20 + 0.35 * math.clamp(
                (quality - HIGH_SCORE_ANCHOR_MIN) / (100 - HIGH_SCORE_ANCHOR_MIN),
                0,
                1
            )
        end

        local observedBase = tonumber(attempt.baseCompensation)
        local observedPing = tonumber(attempt.livePingHalf)
        if observedBase and observedPing then
            if type(model.anchorBaseComp) ~= "number" then
                model.anchorBaseComp = observedBase
                model.anchorPingHalf = observedPing
            else
                model.anchorBaseComp = model.anchorBaseComp
                    + (observedBase - model.anchorBaseComp) * weight
                model.anchorPingHalf = model.anchorPingHalf
                    + (observedPing - model.anchorPingHalf) * weight
            end
        end

        model.anchorQuality = math.max(previousAnchorQuality, quality)
    end
end

local function armCurrentKernel()
    if controller.destroyed or not popcornActive() then
        return
    end

    local state = privateState()
    if type(state) ~= "table" or state.finished == true then
        return
    end

    local slot = tonumber(state.activeKernelSlot) or 0
    local duration = tonumber(state.ringDuration) or 0

    if slot <= 0 or duration <= 0 or duration > 10 then
        return
    end

    if resultBlocksAttempt(state) then



        return
    end



    if controller.currentKernelKey == nil
        or controller.currentKernelSlot ~= slot
    then
        controller.kernelOccurrence += 1
        controller.currentKernelSlot = slot
        controller.currentKernelKey = table.concat({
            tostring(controller.roundSerial),
            tostring(controller.kernelOccurrence),
            tostring(slot),
        }, ":")
    end

    local key = controller.currentKernelKey

    if controller.scheduled[key] or controller.fired[key] then
        return
    end

    controller.scheduled[key] = true


    local stateSeenAt = nowServer()

    task.spawn(runKernel, slot, duration, key, stateSeenAt)
end

local function resultIdentity(result, key)
    if type(result) ~= "table" then return nil end



    return table.concat({
        tostring(key or "unowned"),
        tostring(result.cellIndex),
        tostring(result.rating),
        tostring(result.points),
    }, ":")
end

local function reportAndCalibrate()
    local state = privateState()
    local result = state and state.lastResult
    if type(result) ~= "table" then
        return
    end

    local slot = tonumber(result.cellIndex)
    local key = controller.currentKernelKey




    if not key
        or tonumber(controller.currentKernelSlot) ~= slot
        or controller.resultProcessed[key] == true
    then
        return
    end

    controller.resultProcessed[key] = true
    controller.lastResultIdentity = resultIdentity(result, key)

    local attempt = controller.attempts[key]
        or (slot and controller.attempts[controller.lastAttemptKeyBySlot[slot]])


    controller.currentKernelKey = nil
    controller.currentKernelSlot = nil

    learnFromResult(result, attempt)

end

local function resetRound()
    controller.roundSerial += 1
    controller.kernelOccurrence = 0
    controller.currentKernelKey = nil
    controller.currentKernelSlot = nil
    table.clear(controller.scheduled)
    table.clear(controller.fired)
    table.clear(controller.attempts)
    table.clear(controller.resultProcessed)
    table.clear(controller.lastAttemptKeyBySlot)
    controller.lastResultIdentity = nil
    clearGeometryCache()
end

local function update()
    local isActive = popcornActive()

    if isActive and not controller.wasActive then
        controller.wasActive = true
        resetRound()
    elseif not isActive and controller.wasActive then
        controller.wasActive = false
        resetRound()
        return
    end

    if isActive then
        armCurrentKernel()
        reportAndCalibrate()
    end
end

local function addDisconnector(fn)
    if type(fn) == "function" then
        controller.disconnectors[#controller.disconnectors + 1] = fn
    end
end


for _ = 1, 7 do
    updatePingSamples()
end



local rawConnection = ActiveMinigame:ListenRaw(function()
    update()
end)
if rawConnection then
    if typeof(rawConnection) == "RBXScriptConnection" then
        controller.connections[#controller.connections + 1] = rawConnection
    elseif type(rawConnection) == "function" then
        addDisconnector(rawConnection)
    end
end

addDisconnector(ActiveMinigame:Listen({ "session", "private" }, function()
    update()
end))

addDisconnector(ActiveMinigame:Listen({ "session", "gameId" }, function()
    update()
end))

addDisconnector(ActiveMinigame:Listen({ "session", "public", "phase" }, function()
    update()
end))




controller.connections[#controller.connections + 1] =
    RunService.RenderStepped:Connect(function()
        if popcornActive() then
            update()
        end
    end)

local pingAccumulator = 0

controller.connections[#controller.connections + 1] =
    RunService.Heartbeat:Connect(function(dt)
        if not popcornActive() then
            pingAccumulator = 0
            return
        end

        pingAccumulator += dt
        if pingAccumulator >= 0.05 then
            pingAccumulator = 0
            updatePingSamples()
        end




    end)

function controller:Destroy()
    if self.destroyed then
        return
    end

    self.destroyed = true
    self.roundSerial += 1

    for _, disconnect in ipairs(self.disconnectors) do
        pcall(disconnect)
    end
    table.clear(self.disconnectors)

    for _, connection in ipairs(self.connections) do
        pcall(function()
            connection:Disconnect()
        end)
    end
    table.clear(self.connections)

    table.clear(self.scheduled)
    table.clear(self.fired)
    table.clear(self.attempts)
    table.clear(self.resultProcessed)
    table.clear(self.lastAttemptKeyBySlot)
    clearGeometryCache()

    if rawget(_G, "__TSUNAMI_POPCORN_PERFECT_V17") == self then
        rawset(_G, "__TSUNAMI_POPCORN_PERFECT_V17", nil)
    end
end

update()


end)


task.spawn(function()


local function createCFSolver()
local COLS = 7
local ROWS = 6
local CELLS = 42
local WORD = 4294967296
local TIME_LIMIT = 15.0
local CHECK_INTERVAL = 512
local b32 = bit32

local function add64(alo, ahi, blo, bhi)
    local lo = alo + blo
    local carry = 0
    if lo >= WORD then
        lo -= WORD
        carry = 1
    end
    return lo, ahi + bhi + carry
end

local function band64(alo, ahi, blo, bhi)
    return b32.band(alo, blo), b32.band(ahi, bhi)
end

local function bor64(alo, ahi, blo, bhi)
    return b32.bor(alo, blo), b32.bor(ahi, bhi)
end

local function bxor64(alo, ahi, blo, bhi)
    return b32.bxor(alo, blo), b32.bxor(ahi, bhi)
end

local function shl64(lo, hi, shift)
    if shift == 0 then return lo, hi end
    if shift < 32 then
        return b32.lshift(lo, shift), b32.bor(b32.lshift(hi, shift), b32.rshift(lo, 32 - shift))
    end
    return 0, b32.lshift(lo, shift - 32)
end

local function shr64(lo, hi, shift)
    if shift == 0 then return lo, hi end
    if shift < 32 then
        return b32.bor(b32.rshift(lo, shift), b32.lshift(hi, 32 - shift)), b32.rshift(hi, shift)
    end
    return b32.rshift(hi, shift - 32), 0
end

local BYTE_POPCOUNT = table.create(256, 0)
for i = 1, 255 do
    BYTE_POPCOUNT[i + 1] = BYTE_POPCOUNT[math.floor(i / 2) + 1] + (i % 2)
end

local function popcount32(x)
    return BYTE_POPCOUNT[b32.band(x, 0xFF) + 1]
        + BYTE_POPCOUNT[b32.band(b32.rshift(x, 8), 0xFF) + 1]
        + BYTE_POPCOUNT[b32.band(b32.rshift(x, 16), 0xFF) + 1]
        + BYTE_POPCOUNT[b32.band(b32.rshift(x, 24), 0xFF) + 1]
end

local function popcount64(lo, hi)
    return popcount32(lo) + popcount32(hi)
end

local function isZero64(lo, hi)
    return lo == 0 and hi == 0
end

local function isSingleBit64(lo, hi)
    if hi == 0 then
        return lo ~= 0 and b32.band(lo, lo - 1) == 0
    end
    return lo == 0 and b32.band(hi, hi - 1) == 0
end

local function div2(v)
    if v >= 0 then return math.floor(v / 2) end
    return math.ceil(v / 2)
end

local COL_LO = table.create(COLS)
local COL_HI = table.create(COLS)
local BOTTOM_LO = 0
local BOTTOM_HI = 0
local BOARD_LO = 0
local BOARD_HI = 0
local CELL_LO = table.create(COLS * ROWS)
local CELL_HI = table.create(COLS * ROWS)

for col = 0, 6 do
    local baseBit = col * 7
    local bottomLo, bottomHi
    if baseBit < 32 then
        bottomLo, bottomHi = 2 ^ baseBit, 0
    else
        bottomLo, bottomHi = 0, 2 ^ (baseBit - 32)
    end
    BOTTOM_LO = b32.bor(BOTTOM_LO, bottomLo)
    BOTTOM_HI = b32.bor(BOTTOM_HI, bottomHi)

    local colLo, colHi = 0, 0
    for row = 0, 5 do
        local bit = baseBit + row
        local lo, hi
        if bit < 32 then
            lo, hi = 2 ^ bit, 0
        else
            lo, hi = 0, 2 ^ (bit - 32)
        end
        colLo = b32.bor(colLo, lo)
        colHi = b32.bor(colHi, hi)
        CELL_LO[col * ROWS + row + 1] = lo
        CELL_HI[col * ROWS + row + 1] = hi
    end

    COL_LO[col + 1] = colLo
    COL_HI[col + 1] = colHi
    BOARD_LO = b32.bor(BOARD_LO, colLo)
    BOARD_HI = b32.bor(BOARD_HI, colHi)
end

local function possibleMoves(maskLo, maskHi)
    local lo, hi = add64(maskLo, maskHi, BOTTOM_LO, BOTTOM_HI)
    return band64(lo, hi, BOARD_LO, BOARD_HI)
end

local function winningPosition(posLo, posHi, maskLo, maskHi)
    local resultLo, resultHi = 0, 0
    local aLo, aHi, bLo, bHi, pLo, pHi, rLo, rHi

    aLo, aHi = shl64(posLo, posHi, 1)
    bLo, bHi = shl64(posLo, posHi, 2)
    pLo, pHi = band64(aLo, aHi, bLo, bHi)
    aLo, aHi = shl64(posLo, posHi, 3)
    pLo, pHi = band64(pLo, pHi, aLo, aHi)
    resultLo, resultHi = bor64(resultLo, resultHi, pLo, pHi)

    aLo, aHi = shl64(posLo, posHi, 7)
    bLo, bHi = shl64(posLo, posHi, 14)
    pLo, pHi = band64(aLo, aHi, bLo, bHi)
    aLo, aHi = shl64(posLo, posHi, 21)
    rLo, rHi = band64(pLo, pHi, aLo, aHi)
    resultLo, resultHi = bor64(resultLo, resultHi, rLo, rHi)
    aLo, aHi = shr64(posLo, posHi, 7)
    rLo, rHi = band64(pLo, pHi, aLo, aHi)
    resultLo, resultHi = bor64(resultLo, resultHi, rLo, rHi)

    aLo, aHi = shr64(posLo, posHi, 7)
    bLo, bHi = shr64(posLo, posHi, 14)
    pLo, pHi = band64(aLo, aHi, bLo, bHi)
    aLo, aHi = shl64(posLo, posHi, 7)
    rLo, rHi = band64(pLo, pHi, aLo, aHi)
    resultLo, resultHi = bor64(resultLo, resultHi, rLo, rHi)
    aLo, aHi = shr64(posLo, posHi, 21)
    rLo, rHi = band64(pLo, pHi, aLo, aHi)
    resultLo, resultHi = bor64(resultLo, resultHi, rLo, rHi)

    aLo, aHi = shl64(posLo, posHi, 6)
    bLo, bHi = shl64(posLo, posHi, 12)
    pLo, pHi = band64(aLo, aHi, bLo, bHi)
    aLo, aHi = shl64(posLo, posHi, 18)
    rLo, rHi = band64(pLo, pHi, aLo, aHi)
    resultLo, resultHi = bor64(resultLo, resultHi, rLo, rHi)
    aLo, aHi = shr64(posLo, posHi, 6)
    rLo, rHi = band64(pLo, pHi, aLo, aHi)
    resultLo, resultHi = bor64(resultLo, resultHi, rLo, rHi)

    aLo, aHi = shr64(posLo, posHi, 6)
    bLo, bHi = shr64(posLo, posHi, 12)
    pLo, pHi = band64(aLo, aHi, bLo, bHi)
    aLo, aHi = shl64(posLo, posHi, 6)
    rLo, rHi = band64(pLo, pHi, aLo, aHi)
    resultLo, resultHi = bor64(resultLo, resultHi, rLo, rHi)
    aLo, aHi = shr64(posLo, posHi, 18)
    rLo, rHi = band64(pLo, pHi, aLo, aHi)
    resultLo, resultHi = bor64(resultLo, resultHi, rLo, rHi)

    aLo, aHi = shl64(posLo, posHi, 8)
    bLo, bHi = shl64(posLo, posHi, 16)
    pLo, pHi = band64(aLo, aHi, bLo, bHi)
    aLo, aHi = shl64(posLo, posHi, 24)
    rLo, rHi = band64(pLo, pHi, aLo, aHi)
    resultLo, resultHi = bor64(resultLo, resultHi, rLo, rHi)
    aLo, aHi = shr64(posLo, posHi, 8)
    rLo, rHi = band64(pLo, pHi, aLo, aHi)
    resultLo, resultHi = bor64(resultLo, resultHi, rLo, rHi)

    aLo, aHi = shr64(posLo, posHi, 8)
    bLo, bHi = shr64(posLo, posHi, 16)
    pLo, pHi = band64(aLo, aHi, bLo, bHi)
    aLo, aHi = shl64(posLo, posHi, 8)
    rLo, rHi = band64(pLo, pHi, aLo, aHi)
    resultLo, resultHi = bor64(resultLo, resultHi, rLo, rHi)
    aLo, aHi = shr64(posLo, posHi, 24)
    rLo, rHi = band64(pLo, pHi, aLo, aHi)
    resultLo, resultHi = bor64(resultLo, resultHi, rLo, rHi)

    local emptyLo, emptyHi = bxor64(BOARD_LO, BOARD_HI, maskLo, maskHi)
    return band64(resultLo, resultHi, emptyLo, emptyHi)
end

local function canWinNext(posLo, posHi, maskLo, maskHi)
    local winLo, winHi = winningPosition(posLo, posHi, maskLo, maskHi)
    local possibleLo, possibleHi = possibleMoves(maskLo, maskHi)
    local hitLo, hitHi = band64(winLo, winHi, possibleLo, possibleHi)
    return not isZero64(hitLo, hitHi)
end

local function possibleNonLosingMoves(posLo, posHi, maskLo, maskHi)
    local possibleLo, possibleHi = possibleMoves(maskLo, maskHi)
    local opponentLo, opponentHi = bxor64(posLo, posHi, maskLo, maskHi)
    local opponentWinLo, opponentWinHi = winningPosition(opponentLo, opponentHi, maskLo, maskHi)
    local forcedLo, forcedHi = band64(possibleLo, possibleHi, opponentWinLo, opponentWinHi)
    if not isZero64(forcedLo, forcedHi) then
        if not isSingleBit64(forcedLo, forcedHi) then return 0, 0 end
        possibleLo, possibleHi = forcedLo, forcedHi
    end

    local belowThreatLo, belowThreatHi = shr64(opponentWinLo, opponentWinHi, 1)
    local safeMaskLo, safeMaskHi = bxor64(BOARD_LO, BOARD_HI, belowThreatLo, belowThreatHi)
    return band64(possibleLo, possibleHi, safeMaskLo, safeMaskHi)
end

local COLUMN_ORDER = {3, 4, 2, 5, 1, 6, 0}

local function moveFromPossible(possibleLo, possibleHi, col)
    return band64(possibleLo, possibleHi, COL_LO[col + 1], COL_HI[col + 1])
end

local function columnFromMove(moveLo, moveHi)
    for col = 0, 6 do
        if b32.band(moveLo, COL_LO[col + 1]) ~= 0 or b32.band(moveHi, COL_HI[col + 1]) ~= 0 then
            return col
        end
    end
    return nil
end

local function moveScore(posLo, posHi, maskLo, maskHi, moveLo, moveHi)
    local nextPosLo, nextPosHi = bor64(posLo, posHi, moveLo, moveHi)
    local wLo, wHi = winningPosition(nextPosLo, nextPosHi, maskLo, maskHi)
    return popcount64(wLo, wHi)
end

local BOOK_PATH = "connect4_solver/7x6.book"
local BOOK_URLS = {
    "https://github.com/PascalPons/connect4/releases/download/book/7x6.book",
    "https://github.com/bennywong3/connect4solver-cpp/raw/refs/heads/main/7x6.book",
}

local bookData = nil
local bookDepth = -1
local bookKeyBytes = 0
local bookValueBytes = 0
local bookTableSize = 0
local bookKeysOffset = 0
local bookValuesOffset = 0
local bookLoaded = false
local bookDownloadAttempted = false

local function parseOpeningBook(data)
    if type(data) ~= "string" or #data < 16 then return false end
    local width, height, depth, keyBytes, valueBytes, logSize = string.byte(data, 1, 6)
    if width ~= 7 or height ~= 6 then return false end
    if not depth or depth < 0 or depth > 42 then return false end
    if keyBytes ~= 1 and keyBytes ~= 2 and keyBytes ~= 4 then return false end
    if valueBytes ~= 1 then return false end
    if not logSize or logSize < 1 or logSize > 30 then return false end

    local payload = #data - 6
    local stride = keyBytes + valueBytes
    if payload <= 0 or payload % stride ~= 0 then return false end

    local size = payload / stride
    if size < 2 ^ logSize then return false end

    bookData = data
    bookDepth = depth
    bookKeyBytes = keyBytes
    bookValueBytes = valueBytes
    bookTableSize = size
    bookKeysOffset = 7
    bookValuesOffset = 7 + size * keyBytes
    bookLoaded = true
    return true
end

local function ensureBookFolder()
    local makefolderFn = envFunction("makefolder")
    local isfolderFn = envFunction("isfolder")
    if not makefolderFn then return end
    local shouldCreate = true
    if isfolderFn then
        local ok, exists = pcall(isfolderFn, "connect4_solver")
        shouldCreate = not (ok and exists)
    end
    if shouldCreate then pcall(makefolderFn, "connect4_solver") end
end

local function loadOpeningBook()
    if bookLoaded then return true end

    local isfileFn = envFunction("isfile")
    local readfileFn = envFunction("readfile")
    if isfileFn and readfileFn then
        local okFile, exists = pcall(isfileFn, BOOK_PATH)
        if okFile and exists then
            local okRead, data = pcall(readfileFn, BOOK_PATH)
            if okRead and parseOpeningBook(data) then return true end
        end
    end

    if bookDownloadAttempted then return false end
    bookDownloadAttempted = true

    local requestFn = envFunction("request") or envFunction("http_request")
    if not requestFn then return false end

    for _, url in ipairs(BOOK_URLS) do
        local okReq, response = pcall(function()
            return requestFn({
                Url = url,
                Method = "GET",
                Headers = {
                    ["Accept"] = "application/octet-stream",
                    ["User-Agent"] = "Connect4Solver",
                },
            })
        end)
        if okReq and response ~= nil then
            local status
            local body
            if type(response) == "string" then
                body = response
            else
                pcall(function()
                    status = tonumber(response.StatusCode or response.Status)
                    body = response.Body or response.body
                end)
            end
            if type(body) == "string" and (status == nil or (status >= 200 and status < 300)) then
                if parseOpeningBook(body) then
                    local writefileFn = envFunction("writefile")
                    if writefileFn then
                        ensureBookFolder()
                        pcall(writefileFn, BOOK_PATH, body)
                    end
                    return true
                end
            end
        end
    end

    return false
end

local function bitSet64(lo, hi, bitIndex)
    if bitIndex < 32 then
        return b32.band(lo, 2 ^ bitIndex) ~= 0
    end
    return b32.band(hi, 2 ^ (bitIndex - 32)) ~= 0
end

local function partialKey3(key, col, posLo, posHi, maskLo, maskHi)
    local baseBit = col * 7
    for row = 0, 5 do
        local bitIndex = baseBit + row
        if not bitSet64(maskLo, maskHi, bitIndex) then break end
        key *= 3
        if bitSet64(posLo, posHi, bitIndex) then
            key += 1
        else
            key += 2
        end
    end
    return key * 3
end

local function key3(posLo, posHi, maskLo, maskHi)
    local forward = 0
    for col = 0, 6 do
        forward = partialKey3(forward, col, posLo, posHi, maskLo, maskHi)
    end
    local reverse = 0
    for col = 6, 0, -1 do
        reverse = partialKey3(reverse, col, posLo, posHi, maskLo, maskHi)
    end
    local k = (forward < reverse) and forward or reverse
    return math.floor(k / 3)
end

local function readBookPartialKey(pos)
    local value = 0
    local mul = 1
    for i = 0, bookKeyBytes - 1 do
        local byte = string.byte(bookData, pos + i)
        if not byte then return nil end
        value += byte * mul
        mul *= 256
    end
    return value
end

local function openingBookValue(posLo, posHi, maskLo, maskHi, played)
    if not bookLoaded or played > bookDepth then return 0 end
    local k = key3(posLo, posHi, maskLo, maskHi)
    local index = k % bookTableSize
    local keyPos = bookKeysOffset + index * bookKeyBytes
    local storedKey = readBookPartialKey(keyPos)
    if storedKey == nil then return 0 end
    local modulus = 256 ^ bookKeyBytes
    if storedKey ~= (k % modulus) then return 0 end
    return string.byte(bookData, bookValuesOffset + index) or 0
end

local function openingBookScore(posLo, posHi, maskLo, maskHi, played)
    local value = openingBookValue(posLo, posHi, maskLo, maskHi, played)
    if value == 0 then return nil end
    return value - 19
end

pcall(loadOpeningBook)

local TT_SIZE = 1048576
local TT_MASK = TT_SIZE - 1


local ttKeyLo = buffer.create(TT_SIZE * 4)
local ttKeyHi = buffer.create(TT_SIZE * 4)
local ttData = buffer.create(TT_SIZE * 2)
local TT_LOWER = 1
local TT_UPPER = 2

local function hashKey(lo, hi)
    local h = b32.bxor(lo, b32.lshift(hi, 15))
    h = b32.bxor(h, b32.rshift(h, 16))
    h = b32.bxor(h, b32.lshift(h, 7))
    h = b32.bxor(h, b32.rshift(h, 11))
    return b32.band(h, TT_MASK) + 1
end

local function packTT(score, flag, bestCol)
    return (score + 32) * 32 + flag * 8 + ((bestCol ~= nil) and (bestCol + 1) or 0)
end

local function unpackTT(data)
    local bestCode = data % 8
    local flag = math.floor(data / 8) % 4
    local score = math.floor(data / 32) - 32
    local bestCol = (bestCode == 0) and nil or (bestCode - 1)
    return score, flag, bestCol
end

local function ttLookup(keyLo, keyHi)
    local idx = hashKey(keyLo, keyHi)
    local keyOffset = (idx - 1) * 4
    local dataOffset = (idx - 1) * 2
    local stored = buffer.readu16(ttData, dataOffset)
    if stored ~= 0
        and buffer.readu32(ttKeyLo, keyOffset) == keyLo
        and buffer.readu32(ttKeyHi, keyOffset) == keyHi
    then
        return unpackTT(stored - 1)
    end
    return nil, nil, nil
end

local function ttWrite(keyLo, keyHi, score, flag, bestCol)
    local idx = hashKey(keyLo, keyHi)
    local keyOffset = (idx - 1) * 4
    local dataOffset = (idx - 1) * 2
    buffer.writeu32(ttKeyLo, keyOffset, keyLo)
    buffer.writeu32(ttKeyHi, keyOffset, keyHi)
    buffer.writeu16(ttData, dataOffset, packTT(score, flag, bestCol) + 1)
end

local MAX_PLY = 43
local MOVE_LO_POOL = table.create(MAX_PLY)
local MOVE_HI_POOL = table.create(MAX_PLY)
local MOVE_SCORE_POOL = table.create(MAX_PLY)
local MOVE_COL_POOL = table.create(MAX_PLY)
for i = 1, MAX_PLY do
    MOVE_LO_POOL[i] = table.create(7, 0)
    MOVE_HI_POOL[i] = table.create(7, 0)
    MOVE_SCORE_POOL[i] = table.create(7, 0)
    MOVE_COL_POOL[i] = table.create(7, 0)
end

local nodeCount = 0
local deadline = 0
local aborted = false
local rootWitnessCol = nil
local lastWeakScore = nil
local lastExactScore = nil

local function expired()
    if aborted then return true end
    if nodeCount % CHECK_INTERVAL == 0 and os.clock() >= deadline then
        aborted = true
        return true
    end
    return false
end

local negamax
negamax = function(posLo, posHi, maskLo, maskHi, alpha, beta, ply)
    nodeCount += 1
    if expired() then return nil end

    local played = popcount64(maskLo, maskHi)
    local possibleLo, possibleHi = possibleNonLosingMoves(posLo, posHi, maskLo, maskHi)
    if isZero64(possibleLo, possibleHi) then
        return -div2(CELLS - played)
    end
    if played >= CELLS - 2 then return 0 end

    local minScore = -div2(CELLS - 2 - played)
    if alpha < minScore then
        alpha = minScore
        if alpha >= beta then return alpha end
    end

    local maxScore = div2(CELLS - 1 - played)
    if beta > maxScore then
        beta = maxScore
        if alpha >= beta then return beta end
    end

    local keyLo, keyHi = add64(posLo, posHi, maskLo, maskHi)
    local ttScore, ttFlag, ttBestCol = ttLookup(keyLo, keyHi)
    if ttScore ~= nil then
        if ttFlag == TT_LOWER then
            if ttScore > alpha then alpha = ttScore end
            if alpha >= beta then return alpha end
        elseif ttFlag == TT_UPPER then
            if ttScore < beta then beta = ttScore end
            if alpha >= beta then return beta end
        end
    end

    local bookScore = openingBookScore(posLo, posHi, maskLo, maskHi, played)
    if bookScore ~= nil then return bookScore end

    local opponentLo, opponentHi = bxor64(posLo, posHi, maskLo, maskHi)
    local poolIndex = math.min(ply + 1, MAX_PLY)
    local moveLoList = MOVE_LO_POOL[poolIndex]
    local moveHiList = MOVE_HI_POOL[poolIndex]
    local moveScores = MOVE_SCORE_POOL[poolIndex]
    local moveCols = MOVE_COL_POOL[poolIndex]
    local count = 0

    for orderIndex = 1, 7 do
        local col = COLUMN_ORDER[orderIndex]
        local moveLo, moveHi = moveFromPossible(possibleLo, possibleHi, col)
        if not isZero64(moveLo, moveHi) then
            local score = moveScore(posLo, posHi, maskLo, maskHi, moveLo, moveHi)
            if col == ttBestCol then score += 64 end
            count += 1
            local j = count - 1
            while j >= 1 and moveScores[j] < score do
                moveLoList[j + 1] = moveLoList[j]
                moveHiList[j + 1] = moveHiList[j]
                moveScores[j + 1] = moveScores[j]
                moveCols[j + 1] = moveCols[j]
                j -= 1
            end
            moveLoList[j + 1] = moveLo
            moveHiList[j + 1] = moveHi
            moveScores[j + 1] = score
            moveCols[j + 1] = col
        end
    end

    local bestCol = nil
    for i = 1, count do
        local moveLo = moveLoList[i]
        local moveHi = moveHiList[i]
        local col = moveCols[i]
        local nextMaskLo, nextMaskHi = bor64(maskLo, maskHi, moveLo, moveHi)
        local childScore = negamax(opponentLo, opponentHi, nextMaskLo, nextMaskHi, -beta, -alpha, ply + 1)
        if childScore == nil then return nil end
        local score = -childScore

        if score > alpha then
            alpha = score
            bestCol = col
        end

        if score >= beta then
            ttWrite(keyLo, keyHi, score, TT_LOWER, col)
            if ply == 0 then rootWitnessCol = col end
            return score
        end
    end

    ttWrite(keyLo, keyHi, alpha, TT_UPPER, bestCol or ttBestCol)
    return alpha
end

local function solveScore(posLo, posHi, maskLo, maskHi, weak)
    if canWinNext(posLo, posHi, maskLo, maskHi) then
        return div2(CELLS + 1 - popcount64(maskLo, maskHi))
    end

    local played = popcount64(maskLo, maskHi)
    local minScore = -div2(CELLS - played)
    local maxScore = div2(CELLS + 1 - played)
    if weak then
        minScore = -1
        maxScore = 1
    end

    while minScore < maxScore do
        if expired() then return nil end

        local med = minScore + div2(maxScore - minScore)
        if med <= 0 and div2(minScore) < med then
            med = div2(minScore)
        elseif med >= 0 and div2(maxScore) > med then
            med = div2(maxScore)
        end

        local result = negamax(posLo, posHi, maskLo, maskHi, med, med + 1, 0)
        if result == nil then return nil end

        if result <= med then
            maxScore = result
        else
            minScore = result
        end
    end

    return minScore
end

local function rootProbe(posLo, posHi, maskLo, maskHi, alpha, beta)
    local possibleLo, possibleHi = possibleNonLosingMoves(posLo, posHi, maskLo, maskHi)
    if isZero64(possibleLo, possibleHi) then return nil end

    local keyLo, keyHi = add64(posLo, posHi, maskLo, maskHi)
    local _, _, ttBestCol = ttLookup(keyLo, keyHi)
    local opponentLo, opponentHi = bxor64(posLo, posHi, maskLo, maskHi)

    local moveLoList = MOVE_LO_POOL[1]
    local moveHiList = MOVE_HI_POOL[1]
    local moveScores = MOVE_SCORE_POOL[1]
    local moveCols = MOVE_COL_POOL[1]
    local count = 0

    for orderIndex = 1, 7 do
        local col = COLUMN_ORDER[orderIndex]
        local moveLo, moveHi = moveFromPossible(possibleLo, possibleHi, col)
        if not isZero64(moveLo, moveHi) then
            local orderScore = moveScore(posLo, posHi, maskLo, maskHi, moveLo, moveHi)
            if col == ttBestCol then orderScore += 64 end
            count += 1
            local j = count - 1
            while j >= 1 and moveScores[j] < orderScore do
                moveLoList[j + 1] = moveLoList[j]
                moveHiList[j + 1] = moveHiList[j]
                moveScores[j + 1] = moveScores[j]
                moveCols[j + 1] = moveCols[j]
                j -= 1
            end
            moveLoList[j + 1] = moveLo
            moveHiList[j + 1] = moveHi
            moveScores[j + 1] = orderScore
            moveCols[j + 1] = col
        end
    end

    local bestCol = nil
    for i = 1, count do
        if expired() then return nil end
        local moveLo, moveHi, col = moveLoList[i], moveHiList[i], moveCols[i]
        local nextMaskLo, nextMaskHi = bor64(maskLo, maskHi, moveLo, moveHi)
        local child = negamax(opponentLo, opponentHi, nextMaskLo, nextMaskHi, -beta, -alpha, 1)
        if child == nil then return nil end
        local score = -child
        if score > alpha then
            alpha = score
            bestCol = col
        end
        if score >= beta then return col end
    end
    return bestCol
end

local function gridToBitboards(grid, player)
    local posLo, posHi = 0, 0
    local maskLo, maskHi = 0, 0
    for col = 1, COLS do
        local column = grid[col]
        if type(column) == "table" then
            local height = math.min(#column, ROWS)
            for row = 1, height do
                local piece = column[row]
                if piece ~= nil and piece ~= 0 then
                    local idx = (col - 1) * ROWS + row
                    local lo, hi = CELL_LO[idx], CELL_HI[idx]
                    maskLo, maskHi = bor64(maskLo, maskHi, lo, hi)
                    if piece == player then
                        posLo, posHi = bor64(posLo, posHi, lo, hi)
                    end
                end
            end
        end
    end
    return posLo, posHi, maskLo, maskHi
end

local function chooseCFMove(grid, me, enemy)
    local posLo, posHi, maskLo, maskHi = gridToBitboards(grid, me)
    local played = popcount64(maskLo, maskHi)
    if played >= CELLS then return nil end
    if played == 0 then return 4 end

    local possibleLo, possibleHi = possibleMoves(maskLo, maskHi)
    if isZero64(possibleLo, possibleHi) then return nil end

    local winningLo, winningHi = winningPosition(posLo, posHi, maskLo, maskHi)
    local immediateLo, immediateHi = band64(winningLo, winningHi, possibleLo, possibleHi)
    if not isZero64(immediateLo, immediateHi) then
        for i = 1, 7 do
            local col = COLUMN_ORDER[i]
            if b32.band(immediateLo, COL_LO[col + 1]) ~= 0 or b32.band(immediateHi, COL_HI[col + 1]) ~= 0 then
                return col + 1
            end
        end
    end

    local safeLo, safeHi = possibleNonLosingMoves(posLo, posHi, maskLo, maskHi)
    if isZero64(safeLo, safeHi) then
        for i = 1, 7 do
            local col = COLUMN_ORDER[i]
            local mLo, mHi = moveFromPossible(possibleLo, possibleHi, col)
            if not isZero64(mLo, mHi) then return col + 1 end
        end
        return nil
    end

    if isSingleBit64(safeLo, safeHi) then
        local forcedCol = columnFromMove(safeLo, safeHi)
        return forcedCol and (forcedCol + 1) or nil
    end

    if bookLoaded and played + 1 <= bookDepth then
        local opponentLo, opponentHi = bxor64(posLo, posHi, maskLo, maskHi)
        local allKnown = true
        local bookBestCol = nil
        local bookBestScore = -math.huge

        for i = 1, 7 do
            local col = COLUMN_ORDER[i]
            local mLo, mHi = moveFromPossible(possibleLo, possibleHi, col)
            if not isZero64(mLo, mHi) then
                local nextMaskLo, nextMaskHi = bor64(maskLo, maskHi, mLo, mHi)
                local childScore = openingBookScore(opponentLo, opponentHi, nextMaskLo, nextMaskHi, played + 1)
                if childScore == nil then
                    allKnown = false
                    break
                end
                local score = -childScore
                if score > bookBestScore then
                    bookBestScore = score
                    bookBestCol = col
                end
            end
        end

        if allKnown and bookBestCol ~= nil then return bookBestCol + 1 end
    end

    local fallbackCol = nil
    local fallbackScore = -math.huge
    for i = 1, 7 do
        local col = COLUMN_ORDER[i]
        local mLo, mHi = moveFromPossible(safeLo, safeHi, col)
        if not isZero64(mLo, mHi) then
            local score = moveScore(posLo, posHi, maskLo, maskHi, mLo, mHi)
            if score > fallbackScore then
                fallbackScore = score
                fallbackCol = col
            end
        end
    end
    local bestMove = fallbackCol and (fallbackCol + 1) or nil

    deadline = os.clock() + TIME_LIMIT
    nodeCount = 0
    aborted = false
    rootWitnessCol = nil
    lastWeakScore = nil
    lastExactScore = nil

    local weakScore = solveScore(posLo, posHi, maskLo, maskHi, true)
    if weakScore ~= nil then
        lastWeakScore = weakScore
        local proofCol
        if weakScore > 0 then
            proofCol = rootProbe(posLo, posHi, maskLo, maskHi, 0, 1)
        elseif weakScore == 0 then
            proofCol = rootProbe(posLo, posHi, maskLo, maskHi, -1, 0)
        end
        if proofCol ~= nil then
            bestMove = proofCol + 1
        elseif rootWitnessCol ~= nil and weakScore >= 0 then
            bestMove = rootWitnessCol + 1
        end
    end

    if not aborted and os.clock() < deadline then
        rootWitnessCol = nil
        local exactScore = solveScore(posLo, posHi, maskLo, maskHi, false)
        if exactScore ~= nil then
            lastExactScore = exactScore
            local exactCol = rootProbe(posLo, posHi, maskLo, maskHi, exactScore - 1, exactScore)
            if exactCol ~= nil then
                bestMove = exactCol + 1
            elseif rootWitnessCol ~= nil then
                bestMove = rootWitnessCol + 1
            end
        elseif rootWitnessCol ~= nil then
            bestMove = rootWitnessCol + 1
        end
    end

    return bestMove
end

local function dispose()
    aborted = true
    bookData = nil
    ttKeyLo = nil
    ttKeyHi = nil
    ttData = nil
    MOVE_LO_POOL = nil
    MOVE_HI_POOL = nil
    MOVE_SCORE_POOL = nil
    MOVE_COL_POOL = nil
end

    return chooseCFMove, dispose
end

local chooseCFMove = nil
local disposeCFSolver = nil

local function ensureCFSolver()
    if type(chooseCFMove) == "function" then return true end
    local ok, choose, dispose = pcall(createCFSolver)
    if not ok or type(choose) ~= "function" then
        chooseCFMove = nil
        disposeCFSolver = nil
        return false
    end
    chooseCFMove = choose
    disposeCFSolver = type(dispose) == "function" and dispose or nil
    return true
end

local function releaseCFSolver()
    if disposeCFSolver then pcall(disposeCFSolver) end
    chooseCFMove = nil
    disposeCFSolver = nil
end

local function cfCopy(grid)
    local board = {}
    for col = 1, 7 do
        board[col] = {}
        local source = grid and grid[col]
        if type(source) == "table" then
            for row = 1, math.min(#source, 6) do
                board[col][row] = source[row]
            end
        end
    end
    return board
end

local function cfHeight(board, col)
    local c = board[col]
    return c and #c or 0
end

local function cfPlayable(board, col)
    return cfHeight(board, col) < 6
end

local function cfCell(board, col, row)
    local c = board[col]
    return c and (c[row] or 0) or 0
end

local function cfLineCount(board, col, row, dc, dr, player)
    local count = 0
    while true do
        local c = col + dc * count
        local r = row + dr * count
        if c < 1 or c > 7 or r < 1 or r > 6 then break end
        if cfCell(board, c, r) ~= player then break end
        count += 1
    end
    return count
end

local function cfWon(board, player)
    local dirs = {{1,0},{0,1},{1,1},{1,-1}}
    for col = 1, 7 do
        local height = cfHeight(board, col)
        for row = 1, height do
            if cfCell(board, col, row) == player then
                for _, d in ipairs(dirs) do
                    local a = cfLineCount(board, col, row, d[1], d[2], player)
                    local b = cfLineCount(board, col, row, -d[1], -d[2], player)
                    if a + b - 1 >= 4 then return true end
                end
            end
        end
    end
    return false
end

local function cfFull(board)
    for col = 1, 7 do
        if cfPlayable(board, col) then return false end
    end
    return true
end

local function cfSignature(grid)
    if type(grid) ~= "table" then return nil end
    local out = {}
    for col = 1, 7 do
        local column = grid[col]
        if type(column) == "table" then
            for row = 1, #column do out[#out + 1] = tostring(column[row]) end
        end
        out[#out + 1] = "|"
    end
    return table.concat(out)
end





local cfRng = Random.new(math.floor(workspace:GetServerTimeNow() * 1000) % 2147483647)
local lastCFGame = nil
local lastCFSignature = nil
local cfBusy = false

local function currentGrid()
    return tryIndex({ "session", "public", "grid" })
end

local function confirmedDrop(expectedSignature, expectedSeat, move)
    for attempt = 1, 3 do
        if controller.destroyed
            or gameId() ~= "ConnectFour"
            or publicPhase() ~= "Playing"
            or tonumber(tryIndex({ "session", "public", "currentTurn" })) ~= expectedSeat
        then
            return false
        end

        fireAction("DropChip", move)
        local deadline = os.clock() + 1.25
        while os.clock() < deadline do
            task.wait(0.03)
            local latest = currentGrid()
            local sig = cfSignature(latest)
            if sig and sig ~= expectedSignature then return true end
            if tonumber(tryIndex({ "session", "public", "currentTurn" })) ~= expectedSeat then
                return true
            end
        end
        task.wait(0.10 + attempt * 0.04)
    end
    return false
end

while not controller.destroyed do
    task.wait(gameId() == "ConnectFour" and 0.05 or 0.15)
    if gameId() ~= "ConnectFour" then
        if chooseCFMove ~= nil then releaseCFSolver() end
        lastCFGame = nil
        lastCFSignature = nil
        cfBusy = false
        continue
    end

    if not minigameAutoplayEnabled("ConnectFour") then
        if chooseCFMove ~= nil then releaseCFSolver() end
        continue
    end
    if not ensureCFSolver() then
        task.wait(0.10)
        continue
    end

    if publicPhase() ~= "Playing" or cfBusy then continue end
    local mine = seatIndex()
    local turn = tonumber(tryIndex({ "session", "public", "currentTurn" }))
    local raw = currentGrid()
    if not mine or turn ~= mine or type(raw) ~= "table" then continue end

    local sig = cfSignature(raw)
    if not sig or sig == lastCFSignature then continue end

    local board = cfCopy(raw)
    local enemy = mine == 1 and 2 or 1
    if cfWon(board, mine) or cfWon(board, enemy) or cfFull(board) then continue end

    cfBusy = true
    task.spawn(function()
        local expectedSig = sig
        local expectedGame = gameId()
        task.wait(randomRange(cfRng, 0.18, 0.42))

        if controller.destroyed
            or gameId() ~= expectedGame
            or publicPhase() ~= "Playing"
            or tonumber(tryIndex({ "session", "public", "currentTurn" })) ~= mine
            or cfSignature(currentGrid()) ~= expectedSig
        then
            cfBusy = false
            return
        end

        local latest = currentGrid()
        local fresh = cfCopy(latest)
        local move = chooseCFMove(fresh, mine, enemy)
        if move and cfPlayable(fresh, move) then
            if confirmedDrop(expectedSig, mine, move) then
                lastCFSignature = expectedSig
            else
                lastCFSignature = nil
            end
        end
        cfBusy = false
    end)
end

releaseCFSolver()

end)



task.spawn(function()
    local rng = Random.new(
        (LocalPlayer.UserId * 1103515245
            + math.floor(workspace:GetServerTimeNow() * 1000))
        % 2147483647
    )


    local combos = {}
    local comboByKey = {}
    for a = 1, 10 do
        for b = a + 1, 11 do
            for c = b + 1, 12 do
                local key = tostring(a) .. "," .. tostring(b) .. "," .. tostring(c)
                local combo = { a, b, c, key = key }
                combos[#combos + 1] = combo
                comboByKey[key] = combo
            end
        end
    end

    local function newProfile()
        local p = {
            bombRounds = 0,
            comboCounts = {},
            bombCellCounts = table.create(12, 0),
            pairCounts = {},
            recentBombCombos = {},
            lastBombCombo = nil,
            overlapCounts = { 1, 1, 1, 1 },

            eatRounds = 0,
            eatMarginal = table.create(12, 0),
            eatRecent = table.create(12, 0),
            eatStage = {},
            eatTransition = {},
            eatFirst = table.create(12, 0),
            placementCounts = {},
        }

        for i = 1, 12 do
            p.bombCellCounts[i] = 0
            p.eatMarginal[i] = 0
            p.eatRecent[i] = 0
            p.eatFirst[i] = 0
            p.eatStage[i] = table.create(12, 0)
            p.eatTransition[i] = table.create(12, 0)
            for j = 1, 12 do
                p.eatStage[i][j] = 0
                p.eatTransition[i][j] = 0
            end
        end
        return p
    end

    local CANDY_LEARNING_PATH = "TuffHub_CandyLearning_v1.json"
    local model = rawget(_G, "__TSUNAMI_CANDY_ULTIMATE_V7")
        or rawget(_G, "__TSUNAMI_CANDY_ULTIMATE_V6")
    if type(model) ~= "table" then
        local readfileFn = envFunction("readfile")
        local isfileFn = envFunction("isfile")
        if readfileFn and isfileFn then
            local okExists, exists = pcall(isfileFn, CANDY_LEARNING_PATH)
            if okExists and exists then
                local okRead, body = pcall(readfileFn, CANDY_LEARNING_PATH)
                if okRead and type(body) == "string" then
                    local okDecode, decoded = pcall(HttpService.JSONDecode, HttpService, body)
                    if okDecode and type(decoded) == "table" then model = decoded end
                end
            end
        end
    end
    if type(model) ~= "table" then
        model = { profiles = {}, global = newProfile() }
    end
    rawset(_G, "__TSUNAMI_CANDY_ULTIMATE_V7", model)
    if type(model.profiles) ~= "table" then model.profiles = {} end
    if type(model.global) ~= "table" then model.global = newProfile() end

    local function ensureProfile(p)
        if type(p) ~= "table" then p = newProfile() end
        p.comboCounts = type(p.comboCounts) == "table" and p.comboCounts or {}
        p.bombCellCounts = type(p.bombCellCounts) == "table" and p.bombCellCounts or table.create(12, 0)
        p.pairCounts = type(p.pairCounts) == "table" and p.pairCounts or {}
        p.recentBombCombos = type(p.recentBombCombos) == "table" and p.recentBombCombos or {}
        p.overlapCounts = type(p.overlapCounts) == "table" and p.overlapCounts or { 1, 1, 1, 1 }
        p.eatMarginal = type(p.eatMarginal) == "table" and p.eatMarginal or table.create(12, 0)
        p.eatRecent = type(p.eatRecent) == "table" and p.eatRecent or table.create(12, 0)
        p.eatStage = type(p.eatStage) == "table" and p.eatStage or {}
        p.eatTransition = type(p.eatTransition) == "table" and p.eatTransition or {}
        p.eatFirst = type(p.eatFirst) == "table" and p.eatFirst or table.create(12, 0)
        p.placementCounts = type(p.placementCounts) == "table" and p.placementCounts or {}
        for i = 1, 12 do
            p.bombCellCounts[i] = tonumber(p.bombCellCounts[i]) or 0
            p.eatMarginal[i] = tonumber(p.eatMarginal[i]) or 0
            p.eatRecent[i] = tonumber(p.eatRecent[i]) or 0
            p.eatFirst[i] = tonumber(p.eatFirst[i]) or 0
            if type(p.eatStage[i]) ~= "table" then p.eatStage[i] = table.create(12, 0) end
            if type(p.eatTransition[i]) ~= "table" then p.eatTransition[i] = table.create(12, 0) end
            for j = 1, 12 do
                p.eatStage[i][j] = tonumber(p.eatStage[i][j]) or 0
                p.eatTransition[i][j] = tonumber(p.eatTransition[i][j]) or 0
            end
        end
        return p
    end

    model.global = ensureProfile(model.global)

    local candyDirty = false
    local lastCandySave = 0
    local function saveCandyLearning(force)
        if not candyDirty then return end
        local now = os.clock()
        if not force and now - lastCandySave < 0.75 then return end
        local writefileFn = envFunction("writefile")
        if not writefileFn then return end
        local okEncode, body = pcall(HttpService.JSONEncode, HttpService, model)
        if okEncode and type(body) == "string" then
            local okWrite = pcall(writefileFn, CANDY_LEARNING_PATH, body)
            if okWrite then
                candyDirty = false
                lastCandySave = now
            end
        end
    end

    local function privateState()
        return tryIndex({ "session", "private" })
    end

    local function opponentKey(private)
        local opponent = safeIndex(private, "opponent")
        if typeof(opponent) == "Instance" and opponent:IsA("Player") then
            return "uid:" .. tostring(opponent.UserId)
        end

        local players = Players:GetPlayers()
        if #players == 2 then
            for _, player in ipairs(players) do
                if player ~= LocalPlayer then
                    return "uid:" .. tostring(player.UserId)
                end
            end
        end

        return "unknown"
    end

    local function profileFor(private)
        local key = opponentKey(private)
        local p = model.profiles[key]
        if type(p) ~= "table" then
            p = newProfile()
            model.profiles[key] = p
        else
            p = ensureProfile(p)
            model.profiles[key] = p
        end
        return p
    end

    local function boardCells(board)
        return safeIndex(board, "cells")
    end

    local function cellValue(cells, i, field)
        local cell = safeIndex(cells, i)
        return safeIndex(cell, field)
    end

    local function boardSignature(cells)
        local out = table.create(12)
        for i = 1, 12 do
            out[i] =
                (cellValue(cells, i, "eaten") == true and "1" or "0")
                .. (cellValue(cells, i, "wasBomb") == true and "B" or "?")
        end
        return table.concat(out, "")
    end

    local function comboContains(combo, idx)
        return combo[1] == idx or combo[2] == idx or combo[3] == idx
    end

    local function comboOverlap(a, b)
        if not a or not b then return 0 end
        local n = 0
        for i = 1, 3 do
            if comboContains(b, a[i]) then n += 1 end
        end
        return n
    end

    local function pairKey(a, b)
        if a > b then a, b = b, a end
        return tostring(a) .. ":" .. tostring(b)
    end

    local function completeBombLeak(cells)



        local bombs = {}
        for i = 1, 12 do
            if cellValue(cells, i, "wasBomb") == true then
                bombs[#bombs + 1] = i
            end
        end
        if #bombs ~= 3 then return nil end
        local set = {}
        for _, idx in ipairs(bombs) do set[idx] = true end
        return set
    end

    local function recordBombLayout(profile, bombIds, weight)
        if #bombIds ~= 3 then return end
        weight = weight or 1
        table.sort(bombIds)
        local key = table.concat(bombIds, ",")
        local combo = comboByKey[key]
        if not combo then return end

        local previous = profile.lastBombCombo and comboByKey[profile.lastBombCombo] or nil
        if previous then
            local overlap = comboOverlap(previous, combo)
            profile.overlapCounts[overlap + 1] =
                (tonumber(profile.overlapCounts[overlap + 1]) or 1) + weight
        end

        profile.bombRounds = (tonumber(profile.bombRounds) or 0) + weight
        profile.comboCounts[key] = (tonumber(profile.comboCounts[key]) or 0) + weight
        for _, idx in ipairs(bombIds) do
            profile.bombCellCounts[idx] =
                (tonumber(profile.bombCellCounts[idx]) or 0) + weight
        end
        for i = 1, 2 do
            for j = i + 1, 3 do
                local pk = pairKey(bombIds[i], bombIds[j])
                profile.pairCounts[pk] = (tonumber(profile.pairCounts[pk]) or 0) + weight
            end
        end

        profile.recentBombCombos[#profile.recentBombCombos + 1] = key
        while #profile.recentBombCombos > 36 do
            table.remove(profile.recentBombCombos, 1)
        end
        profile.lastBombCombo = key
    end

    local function comboLogPrior(profile, combo)
        local global = model.global
        local rounds = math.max(0, tonumber(profile.bombRounds) or 0)
        local gRounds = math.max(0, tonumber(global.bombRounds) or 0)



        local exact = tonumber(profile.comboCounts[combo.key]) or 0
        local gExact = tonumber(global.comboCounts[combo.key]) or 0
        local logw = math.log(0.65 + exact * 8.0 + gExact * 0.35)

        for j = 1, 3 do
            local idx = combo[j]
            local p = ((tonumber(profile.bombCellCounts[idx]) or 0) + 0.8)
                / (rounds * 3 + 0.8 * 12)
            local gp = ((tonumber(global.bombCellCounts[idx]) or 0) + 0.8)
                / (gRounds * 3 + 0.8 * 12)
            logw += 0.62 * math.log(math.max(1e-8, p * 12))
            logw += 0.10 * math.log(math.max(1e-8, gp * 12))
        end

        for i = 1, 2 do
            for j = i + 1, 3 do
                local count = tonumber(profile.pairCounts[pairKey(combo[i], combo[j])]) or 0
                logw += 0.18 * math.log(1 + count)
            end
        end

        for r = #profile.recentBombCombos, 1, -1 do
            if profile.recentBombCombos[r] == combo.key then
                local age = #profile.recentBombCombos - r
                logw += 0.55 * math.exp(-0.22 * age)
            end
        end

        local last = profile.lastBombCombo and comboByKey[profile.lastBombCombo] or nil
        if last then
            local overlap = comboOverlap(last, combo)
            local total = 0
            for k = 1, 4 do total += tonumber(profile.overlapCounts[k]) or 1 end
            local overlapP = (tonumber(profile.overlapCounts[overlap + 1]) or 1) / math.max(total, 1)
            logw += 0.40 * math.log(math.max(1e-8, overlapP * 4))
        end

        return logw
    end

    local function posteriorWeights(cells, profile)
        local mustBomb = {}
        local mustSafe = {}
        for i = 1, 12 do
            if cellValue(cells, i, "eaten") == true then
                if cellValue(cells, i, "wasBomb") == true then
                    mustBomb[i] = true
                else
                    mustSafe[i] = true
                end
            end
        end

        local logs = table.create(#combos)
        local maxLog = -math.huge
        for index, combo in ipairs(combos) do
            local consistent = true
            for idx in pairs(mustBomb) do
                if not comboContains(combo, idx) then
                    consistent = false
                    break
                end
            end
            if consistent then
                for idx in pairs(mustSafe) do
                    if comboContains(combo, idx) then
                        consistent = false
                        break
                    end
                end
            end

            if consistent then
                local value = comboLogPrior(profile, combo)
                logs[index] = value
                if value > maxLog then maxLog = value end
            else
                logs[index] = nil
            end
        end

        local weights = table.create(#combos, 0)
        local total = 0
        if maxLog == -math.huge then return weights, 0 end
        for i = 1, #combos do
            local value = logs[i]
            if value ~= nil then
                local w = math.exp(value - maxLog)
                weights[i] = w
                total += w
            else
                weights[i] = 0
            end
        end
        return weights, total
    end

    local function bombRiskForCell(cellIndex, weights, total)
        if total <= 0 then return 1 end
        local bomb = 0
        for i, combo in ipairs(combos) do
            local w = weights[i] or 0
            if w > 0 and comboContains(combo, cellIndex) then
                bomb += w
            end
        end
        return bomb / total
    end

    local function nextEatWeights(profile, stage, lastCell, remaining)
        local global = model.global
        local weights = {}
        local total = 0
        stage = math.clamp(stage, 1, 12)

        local stageRow = profile.eatStage[stage]
        local transitionRow = lastCell and profile.eatTransition[lastCell] or nil
        local gStage = global.eatStage[stage]

        local stageTotal, transitionTotal, marginalTotal, gStageTotal = 0, 0, 0, 0
        for i = 1, 12 do
            stageTotal += tonumber(stageRow[i]) or 0
            if transitionRow then transitionTotal += tonumber(transitionRow[i]) or 0 end
            marginalTotal += tonumber(profile.eatMarginal[i]) or 0
            gStageTotal += tonumber(gStage[i]) or 0
        end

        for _, idx in ipairs(remaining) do
            local pStage = ((tonumber(stageRow[idx]) or 0) + 0.55) / (stageTotal + 0.55 * 12)
            local pTransition = transitionRow
                and (((tonumber(transitionRow[idx]) or 0) + 0.40) / (transitionTotal + 0.40 * 12))
                or (1 / 12)
            local pMarginal = ((tonumber(profile.eatMarginal[idx]) or 0) + 0.65)
                / (marginalTotal + 0.65 * 12)
            local pGlobal = ((tonumber(gStage[idx]) or 0) + 0.75) / (gStageTotal + 0.75 * 12)
            local recency = tonumber(profile.eatRecent[idx]) or 0

            local logScore =
                0.48 * math.log(math.max(pStage, 1e-9))
                + 0.27 * math.log(math.max(pTransition, 1e-9))
                + 0.18 * math.log(math.max(pMarginal, 1e-9))
                + 0.07 * math.log(math.max(pGlobal, 1e-9))
                + 0.08 * recency

            local w = math.exp(logScore)
            weights[idx] = w
            total += w
        end

        if total <= 0 then
            for _, idx in ipairs(remaining) do weights[idx] = 1 end
            total = #remaining
        end
        return weights, total
    end

    local function chooseBombPlacement(profile)


        local observedClicks = 0
        for i = 1, 12 do observedClicks += tonumber(profile.eatMarginal[i]) or 0 end
        if observedClicks <= 0 then
            local ids = {}
            for i = 1, 12 do ids[i] = i end
            for i = 12, 2, -1 do
                local j = rng:NextInteger(1, i)
                ids[i], ids[j] = ids[j], ids[i]
            end
            local chosen = { ids[1], ids[2], ids[3] }
            table.sort(chosen)
            local key = table.concat(chosen, ",")
            profile.placementCounts[key] = (tonumber(profile.placementCounts[key]) or 0) + 1
            candyDirty = true
            return chosen
        end





        local scoreByKey = {}
        for _, combo in ipairs(combos) do scoreByKey[combo.key] = 0 end

        local states = { [0] = { [0] = 1 } }
        for stage = 1, 12 do
            local nextStates = {}
            for mask, byLast in pairs(states) do
                local remaining = {}
                for idx = 1, 12 do
                    if bit32.band(mask, bit32.lshift(1, idx - 1)) == 0 then
                        remaining[#remaining + 1] = idx
                    end
                end
                for last, stateProb in pairs(byLast) do
                    if stateProb > 1e-15 then
                        local weights, total = nextEatWeights(profile, stage, last ~= 0 and last or nil, remaining)
                        if total > 0 then
                            for _, chosen in ipairs(remaining) do
                                local transitionProb = stateProb * ((weights[chosen] or 0) / total)
                                if transitionProb > 1e-15 then
                                    local newMask = bit32.bor(mask, bit32.lshift(1, chosen - 1))
                                    local row = nextStates[newMask]
                                    if not row then row = {}; nextStates[newMask] = row end
                                    row[chosen] = (row[chosen] or 0) + transitionProb

                                    if stage >= 3 then
                                        local prior = {}
                                        for idx = 1, 12 do
                                            if bit32.band(mask, bit32.lshift(1, idx - 1)) ~= 0 then
                                                prior[#prior + 1] = idx
                                            end
                                        end
                                        local terminalUtility =
                                            5.0 * (stage <= 4 and 1 or 0)
                                            + 2.6 * (stage <= 5 and 1 or 0)
                                            + 1.2 * (stage <= 6 and 1 or 0)
                                            + math.exp(-0.34 * (stage - 3))
                                        for a = 1, #prior - 1 do
                                            for b = a + 1, #prior do
                                                local triple = { prior[a], prior[b], chosen }
                                                table.sort(triple)
                                                local key = table.concat(triple, ",")
                                                if scoreByKey[key] ~= nil then
                                                    scoreByKey[key] += transitionProb * terminalUtility
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            states = nextStates
        end

        local bestScore = -math.huge
        local nearBest = {}
        for _, combo in ipairs(combos) do
            local score = scoreByKey[combo.key] or 0

            score -= (tonumber(profile.placementCounts[combo.key]) or 0) * 0.006
            if score > bestScore + 1e-10 then
                bestScore = score
                table.clear(nearBest)
                nearBest[1] = combo
            elseif score >= bestScore - 0.004 then
                nearBest[#nearBest + 1] = combo
            end
        end

        local chosen = nearBest[rng:NextInteger(1, #nearBest)]
        profile.placementCounts[chosen.key] = (tonumber(profile.placementCounts[chosen.key]) or 0) + 1
        candyDirty = true
        return { chosen[1], chosen[2], chosen[3] }
    end

    local function chooseCandyToEat(cells, profile, attemptedCells)
        local available = {}
        for i = 1, 12 do
            if cellValue(cells, i, "eaten") ~= true
                and attemptedCells[i] ~= true
            then
                available[#available + 1] = i
            end
        end

        if #available == 0 then
            table.clear(attemptedCells)
            for i = 1, 12 do
                if cellValue(cells, i, "eaten") ~= true then
                    available[#available + 1] = i
                end
            end
        end
        if #available == 0 then return nil end

        local leaked = completeBombLeak(cells)
        if leaked then
            local safe = {}
            for _, idx in ipairs(available) do
                if leaked[idx] ~= true then safe[#safe + 1] = idx end
            end
            if #safe > 0 then
                return safe[rng:NextInteger(1, #safe)]
            end
        end

        local weights, total = posteriorWeights(cells, profile)
        if total <= 0 then
            return available[rng:NextInteger(1, #available)]
        end




        local bestRisk = math.huge
        local tied = {}
        for _, idx in ipairs(available) do
            local risk = bombRiskForCell(idx, weights, total)
            if risk < bestRisk - 1e-10 then
                bestRisk = risk
                table.clear(tied)
                tied[1] = idx
            elseif math.abs(risk - bestRisk) <= 1e-10 then
                tied[#tied + 1] = idx
            end
        end
        return tied[rng:NextInteger(1, #tied)]
    end

    local roundKey = nil
    local placementSentFor = nil
    local recordedBombRound = nil
    local previousPhase = nil
    local attemptedCells = {}
    local pendingChoice = nil
    local pendingSignature = nil
    local pendingSentAt = 0
    local previousTurn = nil
    local bombEventSerial = 0
    local pendingBombSerial = 0
    local seenOpponentEaten = {}
    local opponentEatOrder = 0
    local previousOpponentEat = nil
    local activeProfile = model.global

    local function resetActionState(clearAttempts)
        pendingChoice = nil
        pendingSignature = nil
        pendingSentAt = 0
        pendingBombSerial = bombEventSerial
        previousTurn = nil
        if clearAttempts then table.clear(attemptedCells) end
    end

    local function resetRoundLearning()
        table.clear(seenOpponentEaten)
        opponentEatOrder = 0
        previousOpponentEat = nil
    end

    local function observeOpponentEating(opponentCells)
        if not opponentCells then return end
        local newly = {}
        for i = 1, 12 do
            if cellValue(opponentCells, i, "eaten") == true
                and seenOpponentEaten[i] ~= true
            then
                newly[#newly + 1] = i
            end
        end



        for i = #newly, 2, -1 do
            local j = rng:NextInteger(1, i)
            newly[i], newly[j] = newly[j], newly[i]
        end

        for _, idx in ipairs(newly) do
            seenOpponentEaten[idx] = true
            opponentEatOrder += 1
            local stage = math.clamp(opponentEatOrder, 1, 12)

            for i = 1, 12 do
                activeProfile.eatRecent[i] = (tonumber(activeProfile.eatRecent[i]) or 0) * 0.94
            end
            activeProfile.eatRecent[idx] = (tonumber(activeProfile.eatRecent[idx]) or 0) + 1
            activeProfile.eatMarginal[idx] = (tonumber(activeProfile.eatMarginal[idx]) or 0) + 1
            activeProfile.eatStage[stage][idx] = (tonumber(activeProfile.eatStage[stage][idx]) or 0) + 1
            model.global.eatMarginal[idx] = (tonumber(model.global.eatMarginal[idx]) or 0) + 0.20
            model.global.eatStage[stage][idx] = (tonumber(model.global.eatStage[stage][idx]) or 0) + 0.20

            if stage == 1 then
                activeProfile.eatFirst[idx] = (tonumber(activeProfile.eatFirst[idx]) or 0) + 1
            end
            if previousOpponentEat then
                activeProfile.eatTransition[previousOpponentEat][idx] =
                    (tonumber(activeProfile.eatTransition[previousOpponentEat][idx]) or 0) + 1
            end
            previousOpponentEat = idx
            candyDirty = true
        end
    end

    local function recordCompletedOpponentBombs(cells)
        if recordedBombRound == roundKey or not cells then return end
        local bombs = {}
        for i = 1, 12 do
            if cellValue(cells, i, "wasBomb") == true then
                bombs[#bombs + 1] = i
            end
        end
        if #bombs ~= 3 then return end
        recordBombLayout(activeProfile, table.clone(bombs), 1)
        recordBombLayout(model.global, table.clone(bombs), 0.20)
        recordedBombRound = roundKey
        candyDirty = true
        saveCandyLearning(true)
    end

    local bombConnection = nil
    pcall(function()
        local remote = Remotes.MinigameBombExplosion
        if remote and remote.OnClientEvent then
            bombConnection = remote.OnClientEvent:Connect(function(_, explodedPlayer)
                if controller.destroyed
                    or not minigameAutoplayEnabled("CandyBomb")
                    or gameId() ~= "CandyBomb"
                then
                    return
                end
                if explodedPlayer == LocalPlayer then
                    bombEventSerial += 1
                    pendingChoice = nil
                    pendingSignature = nil
                    pendingSentAt = 0
                end
            end)
        end
    end)

    while not controller.destroyed do
        task.wait(gameId() == "CandyBomb" and 0.032 or 0.15)

        if gameId() ~= "CandyBomb" then
            saveCandyLearning(true)
            roundKey = nil
            placementSentFor = nil
            recordedBombRound = nil
            previousPhase = nil
            activeProfile = model.global
            resetActionState(true)
            resetRoundLearning()
            continue
        end

        if not minigameAutoplayEnabled("CandyBomb") then
            continue
        end

        saveCandyLearning(false)
        local phase = publicPhase()
        local private = privateState()
        activeProfile = profileFor(private)
        local myBoard = safeIndex(private, "myBoard")
        local myCells = boardCells(myBoard)
        local opponentBoard = safeIndex(private, "opponentBoard")
        local opponentCells = boardCells(opponentBoard)

        if phase ~= previousPhase then
            if phase == "BombPlacement" then
                roundKey = tostring(workspace:GetServerTimeNow())
                    .. ":" .. tostring(rng:NextInteger(1, 1000000000))
                placementSentFor = nil
                recordedBombRound = nil
                resetActionState(true)
                resetRoundLearning()
                activeProfile.eatRounds = (tonumber(activeProfile.eatRounds) or 0) + 1
                model.global.eatRounds = (tonumber(model.global.eatRounds) or 0) + 0.20
            elseif phase == "Playing" then
                resetActionState(true)
            end
            previousPhase = phase
        end

        if phase == "BombPlacement" then
            if roundKey and placementSentFor ~= roundKey then
                placementSentFor = roundKey
                local bombs = chooseBombPlacement(activeProfile)
                task.wait(randomRange(rng, 0.045, 0.11))
                if gameId() == "CandyBomb" and publicPhase() == "BombPlacement" then
                    fireAction("PlaceBombs", bombs)
                end
            end
            continue
        end

        if opponentCells then observeOpponentEating(opponentCells) end
        if myCells then recordCompletedOpponentBombs(myCells) end
        if phase ~= "Playing" or not myCells then continue end

        local currentTurn = tonumber(safeIndex(private, "currentTurn"))
        if currentTurn ~= previousTurn then
            if previousTurn ~= nil then
                pendingChoice = nil
                pendingSignature = nil
                pendingSentAt = 0
            end
            previousTurn = currentTurn
        end
        if currentTurn ~= 1 then continue end

        local sig = boardSignature(myCells)
        if pendingChoice ~= nil then
            local processed =
                cellValue(myCells, pendingChoice, "eaten") == true
                or sig ~= pendingSignature
                or bombEventSerial ~= pendingBombSerial

            if processed then
                pendingChoice = nil
                pendingSignature = nil
                pendingSentAt = 0
            elseif os.clock() - pendingSentAt < 0.62 then
                continue
            else
                pendingChoice = nil
                pendingSignature = nil
                pendingSentAt = 0
            end
        end

        local choice = chooseCandyToEat(myCells, activeProfile, attemptedCells)
        if not choice then continue end

        task.wait(randomRange(rng, 0.045, 0.10))
        local fresh = privateState()
        local freshCells = boardCells(safeIndex(fresh, "myBoard"))
        if gameId() == "CandyBomb"
            and publicPhase() == "Playing"
            and tonumber(safeIndex(fresh, "currentTurn")) == 1
            and freshCells
            and cellValue(freshCells, choice, "eaten") ~= true
        then
            local freshSig = boardSignature(freshCells)
            local sent = fireAction("EatCandy", choice)
            if sent then
                attemptedCells[choice] = true
                pendingChoice = choice
                pendingSignature = freshSig
                pendingSentAt = os.clock()
                pendingBombSerial = bombEventSerial
            end
        end
    end

    if bombConnection then
        pcall(function() bombConnection:Disconnect() end)
    end
end)



task.spawn(function()
    local rng = Random.new(
        (LocalPlayer.UserId * 214013
            + math.floor(workspace:GetServerTimeNow() * 10000))
        % 2147483647
    )




















    local function psychologyAlpha(n)







        local a = 1.0

        if n == 37 then a += 0.80 end
        if n == 73 then a += 0.65 end
        if n == 69 then a += 0.55 end
        if n == 7 or n == 77 then a += 0.35 end
        if n % 10 == 7 then a += 0.12 end
        if n == 50 then a += 0.10 end

        return a
    end

    local function newProfile()
        local profile = {
            secretAlpha = table.create(100),
            exactSecrets = 0,
            censoredSecrets = 0,



            guessStateCounts = {},
            guessSamples = 0,

            firstGuessCounts = table.create(100),
            recentOwnSecrets = {},
        }

        for n = 1, 100 do
            profile.secretAlpha[n] = psychologyAlpha(n)
            profile.firstGuessCounts[n] = 0
        end

        return profile
    end

    local NUMBER_LEARNING_PATH = "TuffHub_NumberGuessLearning_v1.json"
    local model = rawget(_G, "__TSUNAMI_NUMBER_GUESS_OPTIMAL_V9")
        or rawget(_G, "__TSUNAMI_NUMBER_GUESS_OPTIMAL_V8")
        or rawget(_G, "__TSUNAMI_NUMBER_GUESS_OPTIMAL_V7")

    if type(model) ~= "table" then
        local readfileFn = envFunction("readfile")
        local isfileFn = envFunction("isfile")
        if readfileFn and isfileFn then
            local okExists, exists = pcall(isfileFn, NUMBER_LEARNING_PATH)
            if okExists and exists then
                local okRead, body = pcall(readfileFn, NUMBER_LEARNING_PATH)
                if okRead and type(body) == "string" then
                    local okDecode, decoded = pcall(HttpService.JSONDecode, HttpService, body)
                    if okDecode and type(decoded) == "table" then model = decoded end
                end
            end
        end
    end

    if type(model) ~= "table" then
        model = { profiles = {}, global = newProfile() }
    end
    rawset(_G, "__TSUNAMI_NUMBER_GUESS_OPTIMAL_V9", model)
    if type(model.profiles) ~= "table" then model.profiles = {} end

    local function ensureNumberProfile(profile)
        if type(profile) ~= "table" then profile = newProfile() end
        profile.secretAlpha = type(profile.secretAlpha) == "table" and profile.secretAlpha or table.create(100)
        profile.guessStateCounts = type(profile.guessStateCounts) == "table" and profile.guessStateCounts or {}
        for state, counts in pairs(profile.guessStateCounts) do
            if type(counts) == "table" then
                local normalized = {}
                for guess, count in pairs(counts) do
                    local numericGuess = tonumber(guess)
                    if numericGuess then normalized[numericGuess] = tonumber(count) or 0 end
                end
                profile.guessStateCounts[state] = normalized
            else
                profile.guessStateCounts[state] = nil
            end
        end
        profile.firstGuessCounts = type(profile.firstGuessCounts) == "table" and profile.firstGuessCounts or table.create(100, 0)
        profile.recentOwnSecrets = type(profile.recentOwnSecrets) == "table" and profile.recentOwnSecrets or {}
        profile.exactSecrets = tonumber(profile.exactSecrets) or 0
        profile.censoredSecrets = tonumber(profile.censoredSecrets) or 0
        profile.guessSamples = tonumber(profile.guessSamples) or 0
        profile.lastSeen = tonumber(profile.lastSeen) or 0
        for n = 1, 100 do
            profile.secretAlpha[n] = tonumber(profile.secretAlpha[n]) or psychologyAlpha(n)
            profile.firstGuessCounts[n] = tonumber(profile.firstGuessCounts[n]) or 0
        end
        while #profile.recentOwnSecrets > 24 do table.remove(profile.recentOwnSecrets, 1) end
        return profile
    end

    model.global = ensureNumberProfile(model.global)
    for key, profile in pairs(model.profiles) do model.profiles[key] = ensureNumberProfile(profile) end

    local numberDirty = false
    local lastNumberSave = 0
    local function pruneNumberProfiles()
        local entries = {}
        for key, profile in pairs(model.profiles) do
            entries[#entries + 1] = { key = key, lastSeen = tonumber(profile.lastSeen) or 0 }
        end
        if #entries <= 64 then return end
        table.sort(entries, function(a, b) return a.lastSeen > b.lastSeen end)
        for i = 65, #entries do model.profiles[entries[i].key] = nil end
    end
    local function saveNumberLearning(force)
        if not numberDirty then return end
        local now = os.clock()
        if not force and now - lastNumberSave < 0.75 then return end
        local writefileFn = envFunction("writefile")
        if not writefileFn then return end
        pruneNumberProfiles()
        local okEncode, body = pcall(HttpService.JSONEncode, HttpService, model)
        if okEncode and type(body) == "string" then
            local okWrite = pcall(writefileFn, NUMBER_LEARNING_PATH, body)
            if okWrite then numberDirty = false; lastNumberSave = now end
        end
    end

    local function opponentKey(private)
        local opponent = safeIndex(private, "opponent")

        if typeof(opponent) == "Instance"
            and opponent:IsA("Player")
        then
            return "uid:" .. tostring(opponent.UserId)
        end

        return "obj:" .. tostring(opponent or "unknown")
    end

    local function profileFor(private)
        local key = opponentKey(private)
        local profile = model.profiles[key]

        if type(profile) ~= "table" then
            profile = newProfile()
            model.profiles[key] = profile
            numberDirty = true
        else
            profile = ensureNumberProfile(profile)
            model.profiles[key] = profile
        end
        profile.lastSeen = os.time()
        return profile
    end

    local function stateKey(low, high)
        return tostring(low) .. ":" .. tostring(high)
    end

    local function addGuessPolicySample(profile, low, high, guess, scale)
        if not profile or not guess then return end
        if guess < low or guess > high then return end

        scale = scale or 1
        local key = stateKey(low, high)
        local counts = profile.guessStateCounts[key]

        if type(counts) ~= "table" then
            counts = {}
            profile.guessStateCounts[key] = counts
        end

        counts[guess] = (tonumber(counts[guess]) or 0) + scale
        profile.guessSamples =
            (tonumber(profile.guessSamples) or 0) + scale

        if low == 1 and high == 100 then
            profile.firstGuessCounts[guess] =
                (tonumber(profile.firstGuessCounts[guess]) or 0)
                + scale
        end
        numberDirty = true
    end

    local function addExactSecret(profile, secret, scale)
        secret = tonumber(secret)
        if not profile or not secret or secret < 1 or secret > 100 then
            return
        end

        scale = scale or 1
        profile.secretAlpha[secret] =
            (tonumber(profile.secretAlpha[secret]) or psychologyAlpha(secret))
            + scale
        profile.exactSecrets =
            (tonumber(profile.exactSecrets) or 0) + scale
        numberDirty = true
    end

    local function addCensoredSecret(profile, low, high, scale)
        if not profile then return end
        low = math.clamp(math.floor(tonumber(low) or 1), 1, 100)
        high = math.clamp(math.floor(tonumber(high) or 100), 1, 100)
        if low > high then return end

        scale = scale or 0.35





        local sum = 0
        for n = low, high do
            sum += math.max(
                1e-9,
                tonumber(profile.secretAlpha[n]) or psychologyAlpha(n)
            )
        end
        if sum <= 0 then return end

        for n = low, high do
            local current =
                math.max(
                    1e-9,
                    tonumber(profile.secretAlpha[n]) or psychologyAlpha(n)
                )
            profile.secretAlpha[n] = current + scale * current / sum
        end

        profile.censoredSecrets =
            (tonumber(profile.censoredSecrets) or 0) + scale
        numberDirty = true
    end

    local function guessLogArray()
        local log = tryIndex({ "session", "public", "guessLog" })
        local out = {}

        if log ~= nil then
            pcall(function()
                for i, entry in log do
                    if type(i) == "number" then
                        out[i] = entry
                    end
                end
            end)
        end

        return out
    end

    local function logSignature(log)
        local out = {}

        for i = 1, 256 do
            local entry = log[i]
            if entry == nil then break end

            out[#out + 1] =
                tostring(entry.guesserIndex)
                .. ":"
                .. tostring(entry.guess)
                .. ":"
                .. tostring(entry.response)
        end

        return table.concat(out, "|")
    end

    local function boundsForSeat(log, seat)
        local low, high = 1, 100
        local foundCorrect = nil

        for i = 1, 256 do
            local entry = log[i]
            if entry == nil then break end

            if tonumber(entry.guesserIndex) == seat then
                local guess = tonumber(entry.guess)
                local response = entry.response

                if guess then
                    if response == "Higher" then
                        low = math.max(low, guess + 1)
                    elseif response == "Lower" then
                        high = math.min(high, guess - 1)
                    elseif response == "Correct" then
                        low, high = guess, guess
                        foundCorrect = guess
                    end
                end
            end
        end

        return low, high, foundCorrect
    end

    local function recordOpponentGuessPolicy(
        log,
        mine,
        profile,
        processedPolicyEntries
    )
        local opponentLow, opponentHigh = 1, 100
        local opponentOrder = 0

        for i = 1, 256 do
            local entry = log[i]
            if entry == nil then break end

            local guesser = tonumber(entry.guesserIndex)
            local guess = tonumber(entry.guess)
            local response = entry.response

            if guesser and guess and guesser ~= mine then
                opponentOrder += 1

                local entryKey =
                    tostring(i)
                    .. ":"
                    .. tostring(guesser)
                    .. ":"
                    .. tostring(guess)
                    .. ":"
                    .. tostring(response)

                if not processedPolicyEntries[entryKey] then
                    processedPolicyEntries[entryKey] = true

                    addGuessPolicySample(
                        profile,
                        opponentLow,
                        opponentHigh,
                        guess,
                        1
                    )
                    addGuessPolicySample(
                        model.global,
                        opponentLow,
                        opponentHigh,
                        guess,
                        0.20
                    )
                end

                if response == "Higher" then
                    opponentLow = math.max(opponentLow, guess + 1)
                elseif response == "Lower" then
                    opponentHigh = math.min(opponentHigh, guess - 1)
                elseif response == "Correct" then
                    opponentLow, opponentHigh = guess, guess
                end
            end
        end
    end

    local function combinedSecretWeights(profile, low, high)
        local weights = table.create(100, 0)

        local specificEvidence =
            (tonumber(profile.exactSecrets) or 0)
            + (tonumber(profile.censoredSecrets) or 0)




        local specificMix =
            math.clamp(specificEvidence / 10, 0, 1)

        for n = low, high do
            local specific =
                tonumber(profile.secretAlpha[n]) or psychologyAlpha(n)
            local global =
                tonumber(model.global.secretAlpha[n])
                or psychologyAlpha(n)
            local baseline = psychologyAlpha(n)

            weights[n] =
                baseline * (1 - specificMix) * 0.85
                + global * (1 - specificMix) * 0.15
                + specific * specificMix
        end

        return weights
    end

    local function exactOptimalGuess(weights, low, high)
        if low >= high then return low end




        local dp = {}
        local height = {}
        local root = {}




        local prefix = { [0] = 0 }

        for n = 1, 100 do
            prefix[n] =
                (prefix[n - 1] or 0)
                + math.max(0, tonumber(weights[n]) or 0)
        end

        local function intervalWeight(l, r)
            if l > r then return 0 end
            return (prefix[r] or 0) - (prefix[l - 1] or 0)
        end

        for l = low, high + 1 do
            dp[l] = {}
            height[l] = {}
            root[l] = {}
            dp[l][l - 1] = 0
            height[l][l - 1] = 0
        end

        for length = 1, high - low + 1 do
            for l = low, high - length + 1 do
                local r = l + length - 1
                local w = intervalWeight(l, r)

                local bestCost = math.huge
                local bestHeight = math.huge
                local bestRoot = l

                for k = l, r do
                    local leftCost =
                        (k > l) and dp[l][k - 1] or 0
                    local rightCost =
                        (k < r) and dp[k + 1][r] or 0

                    local cost = leftCost + rightCost + w

                    local leftHeight =
                        (k > l) and height[l][k - 1] or 0
                    local rightHeight =
                        (k < r) and height[k + 1][r] or 0
                    local candidateHeight =
                        1 + math.max(leftHeight, rightHeight)

                    if cost < bestCost - 1e-9
                        or (
                            math.abs(cost - bestCost) <= 1e-9
                            and candidateHeight < bestHeight
                        )
                        or (
                            math.abs(cost - bestCost) <= 1e-9
                            and candidateHeight == bestHeight
                            and math.abs(
                                k - (l + r) * 0.5
                            )
                                < math.abs(
                                    bestRoot - (l + r) * 0.5
                                )
                        )
                    then
                        bestCost = cost
                        bestHeight = candidateHeight
                        bestRoot = k
                    end
                end

                dp[l][r] = bestCost
                height[l][r] = bestHeight
                root[l][r] = bestRoot
            end
        end

        return root[low][high]
    end

    local function humanGuessBaseWeight(guess, low, high)
        local count = high - low + 1
        local center = (low + high) * 0.5
        local lowerMid = math.floor(center)
        local upperMid = math.ceil(center)

        local normalized =
            math.abs(guess - center)
            / math.max(1, count * 0.5)


        local weight =
            0.04
            + math.exp(-normalized * 5.5) * 1.6

        if guess == lowerMid or guess == upperMid then
            weight += 5.5
        end


        if guess % 10 == 0 then weight += 0.34 end
        if guess % 5 == 0 then weight += 0.18 end

        if low == 1 and high == 100 then
            if guess == 50 then weight += 5.0 end
            if guess == 51 then weight += 1.2 end
            if guess == 37 then weight += 0.45 end
            if guess == 69 then weight += 0.32 end
            if guess == 73 then weight += 0.30 end
        end

        return weight
    end

    local function policyChoices(profile, low, high)
        local specific =
            profile.guessStateCounts[stateKey(low, high)]
        local global =
            model.global.guessStateCounts[stateKey(low, high)]

        local evidence = 0
        if type(specific) == "table" then
            for _, count in pairs(specific) do
                evidence += tonumber(count) or 0
            end
        end

        local specificTrust =
            math.clamp(evidence / 6, 0, 1)

        local choices = {}
        local total = 0

        for guess = low, high do
            local base =
                humanGuessBaseWeight(guess, low, high)
            local specificCount =
                type(specific) == "table"
                and (tonumber(specific[guess]) or 0)
                or 0
            local globalCount =
                type(global) == "table"
                and (tonumber(global[guess]) or 0)
                or 0

            local weight =
                base * (1 - specificTrust)
                + specificCount * 7.0 * specificTrust
                + globalCount * 0.65

            if weight > 0 then
                choices[#choices + 1] = {
                    guess = guess,
                    weight = weight,
                }
                total += weight
            end
        end

        if total <= 0 then
            return {
                {
                    guess = math.floor((low + high) * 0.5),
                    probability = 1,
                },
            }
        end





        for _, choice in ipairs(choices) do
            choice.probability = choice.weight / total
        end

        return choices
    end

    local function expectedOpponentSteps(profile, secret)
        local memo = {}

        local function solve(low, high)
            if low > high then return 0 end
            if low == high then return 1 end

            local key = stateKey(low, high)
            local cached = memo[key]
            if cached ~= nil then return cached end

            local choices = policyChoices(profile, low, high)
            local expected = 0

            for _, choice in ipairs(choices) do
                local guess = choice.guess
                local branch

                if guess == secret then
                    branch = 1
                elseif secret > guess then
                    branch = 1 + solve(guess + 1, high)
                else
                    branch = 1 + solve(low, guess - 1)
                end

                expected += choice.probability * branch
            end

            memo[key] = expected
            return expected
        end

        return solve(1, 100)
    end

    local function canonicalDepth(secret, upperMedian)
        local low, high = 1, 100
        local depth = 0

        while low <= high and depth < 100 do
            depth += 1
            local guess

            if upperMedian then
                guess = math.floor((low + high + 1) * 0.5)
            else
                guess = math.floor((low + high) * 0.5)
            end

            if guess == secret then
                return depth
            elseif secret > guess then
                low = guess + 1
            else
                high = guess - 1
            end
        end

        return depth
    end

    local function chooseStrongSecret(profile)











        local maxRobustDepth = -math.huge
        local deepest = {}

        for secret = 1, 100 do
            local robustDepth =
                math.min(
                    canonicalDepth(secret, false),
                    canonicalDepth(secret, true)
                )

            if robustDepth > maxRobustDepth then
                maxRobustDepth = robustDepth
                table.clear(deepest)
                deepest[1] = secret
            elseif robustDepth == maxRobustDepth then
                deepest[#deepest + 1] = secret
            end
        end

        local recentPenalty = {}
        for i, n in ipairs(profile.recentOwnSecrets) do
            local age = #profile.recentOwnSecrets - i
            recentPenalty[n] =
                (recentPenalty[n] or 0)
                + math.exp(-0.36 * age)
        end

        local policyEvidence = tonumber(profile.guessSamples) or 0
        local scored = table.create(#deepest)
        local bestScore = -math.huge

        for _, secret in ipairs(deepest) do




            local learnedDifficulty = expectedOpponentSteps(profile, secret)
            local score =
                learnedDifficulty
                - (recentPenalty[secret] or 0) * 0.55

            scored[#scored + 1] = {
                secret = secret,
                score = score,
            }
            if score > bestScore then bestScore = score end
        end

        table.sort(scored, function(a, b)
            if math.abs(a.score - b.score) > 1e-9 then
                return a.score > b.score
            end
            return a.secret < b.secret
        end)




        local pool = {}
        if policyEvidence >= 8 then
            local tolerance = 0.08
            for _, item in ipairs(scored) do
                if item.score >= bestScore - tolerance then
                    pool[#pool + 1] = item
                else
                    break
                end
            end
        else
            for _, item in ipairs(scored) do
                pool[#pool + 1] = item
            end
        end

        local chosen
        if policyEvidence >= 8 and #pool > 1 then
            local temperature =
                math.clamp(
                    0.07 / math.sqrt(policyEvidence / 8),
                    0.015,
                    0.06
                )
            local total = 0
            for _, item in ipairs(pool) do
                item.weight =
                    math.exp((item.score - bestScore) / temperature)
                total += item.weight
            end

            local roll = rng:NextNumber() * math.max(total, 1e-9)
            chosen = pool[#pool].secret
            for _, item in ipairs(pool) do
                roll -= item.weight
                if roll <= 0 then
                    chosen = item.secret
                    break
                end
            end
        else
            chosen = pool[rng:NextInteger(1, #pool)].secret
        end

        profile.recentOwnSecrets[#profile.recentOwnSecrets + 1] = chosen
        while #profile.recentOwnSecrets > 20 do
            table.remove(profile.recentOwnSecrets, 1)
        end
        numberDirty = true

        return chosen
    end

    local currentSessionKey = nil
    local previousPhase = nil
    local roundSerial = 0
    local pickSentFor = nil
    local lastGuessSignature = nil
    local learnedSecretForRound = false
    local finalizedRound = false
    local processedPolicyEntries = {}
    local activeProfile = nil
    local lastMyBoundsLow = 1
    local lastMyBoundsHigh = 100

    local function resetRoundState()
        pickSentFor = nil
        lastGuessSignature = nil
        learnedSecretForRound = false
        finalizedRound = false
        table.clear(processedPolicyEntries)
        lastMyBoundsLow = 1
        lastMyBoundsHigh = 100
    end

    while not controller.destroyed do
        task.wait(gameId() == "NumberGuess" and 0.025 or 0.15)
        saveNumberLearning(false)

        if gameId() ~= "NumberGuess" then
            saveNumberLearning(true)
            currentSessionKey = nil
            previousPhase = nil
            activeProfile = nil
            resetRoundState()
            continue
        end

        if not minigameAutoplayEnabled("NumberGuess") then
            continue
        end

        local phase = publicPhase()
        local mine = seatIndex()
        if not mine then continue end

        local private = tryIndex({ "session", "private" })
        activeProfile = profileFor(private)

        if phase == "Picking" and previousPhase ~= "Picking" then
            roundSerial += 1
            currentSessionKey =
                tostring(roundSerial)
                .. ":"
                .. tostring(workspace:GetServerTimeNow())
            resetRoundState()
        elseif not currentSessionKey then
            currentSessionKey =
                tostring(workspace:GetServerTimeNow())
                .. ":"
                .. tostring(rng:NextInteger(1, 1000000000))
        end

        previousPhase = phase

        local log = guessLogArray()
        local signature = logSignature(log)

        recordOpponentGuessPolicy(
            log,
            mine,
            activeProfile,
            processedPolicyEntries
        )

        local myLow, myHigh, exactSecret =
            boundsForSeat(log, mine)
        lastMyBoundsLow, lastMyBoundsHigh = myLow, myHigh

        if exactSecret and not learnedSecretForRound then
            learnedSecretForRound = true
            addExactSecret(activeProfile, exactSecret, 1)
            addExactSecret(model.global, exactSecret, 0.20)
        end

        if phase == "Picking" then
            local mySecret =
                tryIndex({
                    "session",
                    "private",
                    "mySecretNumber",
                })
            local picked =
                tryIndex({
                    "session",
                    "public",
                    "pickedStatus",
                    mine,
                })

            if mySecret == nil
                and picked ~= true
                and pickSentFor ~= currentSessionKey
            then
                pickSentFor = currentSessionKey
                local secret = chooseStrongSecret(activeProfile)



                if gameId() == "NumberGuess"
                    and publicPhase() == "Picking"
                then
                    fireAction("PickNumber", secret)
                end
            end

            continue
        end

        if phase == "Finished" and not finalizedRound then
            finalizedRound = true

            if not learnedSecretForRound then
                addCensoredSecret(
                    activeProfile,
                    lastMyBoundsLow,
                    lastMyBoundsHigh,
                    0.35
                )
                addCensoredSecret(
                    model.global,
                    lastMyBoundsLow,
                    lastMyBoundsHigh,
                    0.07
                )
            end
        end

        if phase ~= "Guessing" then
            continue
        end

        if tonumber(
            tryIndex({
                "session",
                "public",
                "currentTurn",
            })
        ) ~= mine
        then
            continue
        end

        if tryIndex({
            "session",
            "public",
            "responding",
        }) == true
        then
            continue
        end

        if signature == lastGuessSignature then
            continue
        end

        if myLow > myHigh then
            continue
        end

        local weights =
            combinedSecretWeights(
                activeProfile,
                myLow,
                myHigh
            )

        local guess
        local optimizerOk, optimizerResult = pcall(
            exactOptimalGuess,
            weights,
            myLow,
            myHigh
        )

        if optimizerOk
            and type(optimizerResult) == "number"
            and optimizerResult >= myLow
            and optimizerResult <= myHigh
        then
            guess = math.floor(optimizerResult)
        else



            guess = math.floor((myLow + myHigh) * 0.5)
        end

        lastGuessSignature = signature


        if gameId() == "NumberGuess"
            and publicPhase() == "Guessing"
            and tonumber(
                tryIndex({
                    "session",
                    "public",
                    "currentTurn",
                })
            ) == mine
            and tryIndex({
                "session",
                "public",
                "responding",
            }) ~= true
        then
            local sent = fireAction("Guess", guess)



            if not sent then
                lastGuessSignature = nil
            end
        else
            lastGuessSignature = nil
        end
    end
    saveNumberLearning(true)
end)



task.spawn(function()
    local FootballDraft = require(ReplicatedStorage.Shared.Config.FootballDraft)
    local rng = Random.new((LocalPlayer.UserId * 1664525 + math.floor(workspace:GetServerTimeNow() * 1000)) % 2147483647)
    local seenCandidates = nil
    local candidatesSeenAt = 0
    local actionBusy = false











    local LINES = { "Front", "Mid", "Back", "GK" }
    local LINE_BIT = { Front = 1, Mid = 2, Back = 4, GK = 8 }
    local LINE_TOTAL = { Front = 3, Mid = 3, Back = 4, GK = 1 }
    local valueCache = {}
    local maskStats = {}
    local generatedSinceYield = 0

    local function toArray(proxy)
        local out = {}
        if proxy ~= nil then
            pcall(function()
                for i, value in proxy do
                    if type(i) == "number" then out[i] = value end
                end
            end)
        end
        local compact = {}
        for i = 1, 16 do
            if out[i] ~= nil then compact[#compact + 1] = out[i] end
        end
        return compact
    end

    local function candidateSignature(candidates)
        return table.concat(candidates, "\0")
    end

    local function stateFromLineup(lineup)
        local state = { Front = 0, Mid = 0, Back = 0, GK = 0 }
        for _, slot in ipairs(FootballDraft.Formation) do
            local occupied = false
            pcall(function()
                occupied = lineup ~= nil and lineup[slot.SlotId] ~= nil
            end)
            if not occupied then
                state[slot.Line] = (state[slot.Line] or 0) + 1
            end
        end
        return state
    end

    local function copyState(state)
        return {
            Front = state.Front,
            Mid = state.Mid,
            Back = state.Back,
            GK = state.GK,
        }
    end

    local function remainingSlots(state)
        return state.Front + state.Mid + state.Back + state.GK
    end

    local function openMask(state)
        local mask = 0
        for _, line in ipairs(LINES) do
            if (state[line] or 0) > 0 then
                mask += LINE_BIT[line]
            end
        end
        return mask
    end

    local function stateKey(state, rerolls)
        return table.concat({
            tostring(state.Front),
            tostring(state.Mid),
            tostring(state.Back),
            tostring(state.GK),
            tostring(rerolls),
        }, ":")
    end

    local function syntheticLineup(state)
        local lineup = {}
        local filledNeeded = {
            Front = LINE_TOTAL.Front - state.Front,
            Mid = LINE_TOTAL.Mid - state.Mid,
            Back = LINE_TOTAL.Back - state.Back,
            GK = LINE_TOTAL.GK - state.GK,
        }
        local filled = { Front = 0, Mid = 0, Back = 0, GK = 0 }

        for _, slot in ipairs(FootballDraft.Formation) do
            local line = slot.Line
            if filled[line] < filledNeeded[line] then


                lineup[slot.SlotId] = "__TSUNAMI_FILLED__"
                filled[line] += 1
            end
        end
        return lineup
    end

    local function generatedOffer(state)
        local sim = {
            Lineup = syntheticLineup(state),
            Candidates = {},
            Rerolls = 0,
        }
        local ok, cards = pcall(FootballDraft.GenerateOffer, sim)
        generatedSinceYield += 1
        if ok and type(cards) == "table" then
            return cards
        end
        return {}
    end

    local function maybeYield(deadline)
        if generatedSinceYield >= 24 then
            generatedSinceYield = 0
            if os.clock() < deadline then
                task.wait()
            end
        end
    end

    local function cardLine(card)
        if type(card) ~= "table" then return nil end
        if type(card.line) == "string" then return card.line end
        if type(card.name) == "string" then
            local ok, line = pcall(FootballDraft.GetLine, card.name)
            if ok then return line end
        end
        return nil
    end

    local function cardOVR(card)
        if type(card) ~= "table" then return 0 end
        local value = tonumber(card.ovr)
        if value then return value end
        if type(card.name) == "string" then
            local ok, ovr = pcall(FootballDraft.GetOVR, card.name)
            if ok then return tonumber(ovr) or 0 end
        end
        return 0
    end

    local function nameLine(name)
        local ok, line = pcall(FootballDraft.GetLine, name)
        return ok and line or nil
    end

    local function nameOVR(name)
        local ok, ovr = pcall(FootballDraft.GetOVR, name)
        return ok and (tonumber(ovr) or 0) or 0
    end

    local function afterPickingLine(state, line)
        if not line or (state[line] or 0) <= 0 then return nil end
        local nextState = copyState(state)
        nextState[line] -= 1
        return nextState
    end

    local function buildMaskStats(mask, deadline)
        local cached = maskStats[mask]
        if cached then return cached end

        local state = {
            Front = bit32.band(mask, LINE_BIT.Front) ~= 0 and 1 or 0,
            Mid = bit32.band(mask, LINE_BIT.Mid) ~= 0 and 1 or 0,
            Back = bit32.band(mask, LINE_BIT.Back) ~= 0 and 1 or 0,
            GK = bit32.band(mask, LINE_BIT.GK) ~= 0 and 1 or 0,
        }
        local values = {}
        local targetSamples = 96

        for _ = 1, targetSamples do
            if os.clock() >= deadline then break end
            local cards = generatedOffer(state)
            local best = 0
            for _, card in ipairs(cards) do
                best = math.max(best, cardOVR(card))
            end
            if best > 0 then values[#values + 1] = best end
            maybeYield(deadline)
        end

        if #values == 0 then
            return {
                mean = 82,
                marginal = { 3.5, 2.0, 1.0 },
                provisional = true,
            }
        end

        table.sort(values)
        local n = #values
        local sum = 0
        for _, value in ipairs(values) do sum += value end
        local mean = sum / n
        local expectedMax = { [1] = mean }

        for draws = 2, 4 do
            local expectation = 0
            for i, value in ipairs(values) do
                local hi = (i / n) ^ draws
                local lo = ((i - 1) / n) ^ draws
                expectation += value * (hi - lo)
            end
            expectedMax[draws] = expectation
        end

        local stats = {
            mean = mean,
            marginal = {
                math.max(0, expectedMax[2] - expectedMax[1]),
                math.max(0, expectedMax[3] - expectedMax[2]),
                math.max(0, expectedMax[4] - expectedMax[3]),
            },
            provisional = n < targetSamples,
        }
        if not stats.provisional then
            maskStats[mask] = stats
        end
        return stats
    end

    local function tailEstimate(state, rerolls, deadline)
        local remaining = remainingSlots(state)
        if remaining <= 0 then return 0 end

        local mask = openMask(state)
        local stats = maskStats[mask]
        if not stats and os.clock() < deadline then
            stats = buildMaskStats(mask, deadline)
        end
        stats = stats or {
            mean = 82,
            marginal = { 3.5, 2.0, 1.0 },
        }

        local value = remaining * stats.mean
        if rerolls <= 0 then return value end





        local increments = {}
        for _ = 1, remaining do
            for k = 1, math.min(3, rerolls) do
                increments[#increments + 1] = stats.marginal[k] or 0
            end
        end
        table.sort(increments, function(a, b) return a > b end)
        for i = 1, math.min(rerolls, #increments) do
            value += increments[i]
        end
        return value
    end

    local estimateFuture
    estimateFuture = function(state, rerolls, deadline)
        local remaining = remainingSlots(state)
        if remaining <= 0 then return 0, true end

        rerolls = math.max(0, math.floor(tonumber(rerolls) or 0))
        local key = stateKey(state, rerolls)
        local cached = valueCache[key]
        if cached ~= nil then return cached, true end

        if os.clock() >= deadline then
            return tailEstimate(state, rerolls, deadline), false
        end




        local futureByLine = {}
        local complete = true
        for _, line in ipairs(LINES) do
            if state[line] > 0 then
                local child = afterPickingLine(state, line)
                local childValue, childComplete = estimateFuture(child, rerolls, deadline)
                futureByLine[line] = childValue
                if not childComplete then complete = false end
                if os.clock() >= deadline then
                    complete = false
                    break
                end
            end
        end

        local rerollValue = -math.huge
        if rerolls > 0 then
            local rerollComplete
            rerollValue, rerollComplete = estimateFuture(state, rerolls - 1, deadline)
            if not rerollComplete then complete = false end
        end

        if os.clock() >= deadline then
            return tailEstimate(state, rerolls, deadline), false
        end




        local targetSamples
        if remaining <= 2 then
            targetSamples = 44
        elseif remaining <= 4 then
            targetSamples = 28
        elseif remaining <= 7 then
            targetSamples = 17
        else
            targetSamples = 10
        end

        local sum = 0
        local samples = 0
        for _ = 1, targetSamples do
            if os.clock() >= deadline then
                complete = false
                break
            end

            local cards = generatedOffer(state)
            local best = rerollValue
            for _, card in ipairs(cards) do
                local line = cardLine(card)
                local continuation = line and futureByLine[line]
                if continuation ~= nil then
                    best = math.max(best, cardOVR(card) + continuation)
                end
            end

            if best > -math.huge then
                sum += best
                samples += 1
            end
            maybeYield(deadline)
        end

        if samples == 0 then
            return tailEstimate(state, rerolls, deadline), false
        end

        local value = sum / samples
        if complete and samples == targetSamples then
            valueCache[key] = value
        end
        return value, complete and samples == targetSamples
    end

    local function chooseOptimalAction(lineup, candidates, rerolls, budgetSeconds)
        local state = stateFromLineup(lineup)
        local deadline = os.clock() + math.max(0.05, budgetSeconds)
        local futureByLine = {}



        for _, line in ipairs(LINES) do
            if state[line] > 0 then
                local child = afterPickingLine(state, line)
                futureByLine[line] = select(1, estimateFuture(child, rerolls, deadline))
            end
        end





        local bestIndex = nil
        local bestImmediateOVR = -math.huge
        local bestPickValue = -math.huge
        for i, name in ipairs(candidates) do
            local line = nameLine(name)
            local continuation = line and futureByLine[line]
            if continuation ~= nil then
                local immediate = nameOVR(name)
                local value = immediate + continuation
                if immediate > bestImmediateOVR
                    or (
                        immediate == bestImmediateOVR
                        and value > bestPickValue
                    )
                then
                    bestIndex = i
                    bestImmediateOVR = immediate
                    bestPickValue = value
                end
            end
        end

        local rerollValue = -math.huge
        if rerolls > 0 and os.clock() < deadline then
            rerollValue = select(1, estimateFuture(state, rerolls - 1, deadline))
        elseif rerolls > 0 then


            rerollValue = tailEstimate(state, rerolls - 1, deadline)
        end




        local reroll = rerolls > 0 and rerollValue > bestPickValue + 0.05
        return reroll, bestIndex
    end




    task.spawn(function()
        while not controller.destroyed do
            if minigameAutoplayEnabled("FootballDraft") and gameId() == "FootballDraft" then
                for mask = 1, 15 do
                    if controller.destroyed
                        or not minigameAutoplayEnabled("FootballDraft")
                        or gameId() ~= "FootballDraft"
                    then
                        break
                    end
                    if maskStats[mask] == nil then
                        buildMaskStats(mask, os.clock() + 0.34)
                    end
                    task.wait()
                end
                return
            end
            task.wait(0.35)
        end
    end)

    while not controller.destroyed do
        task.wait(0.07)
        if gameId() ~= "FootballDraft" or publicPhase() ~= "Drafting" then
            seenCandidates = nil
            candidatesSeenAt = 0
            actionBusy = false
            continue
        end
        if not minigameAutoplayEnabled("FootballDraft") then
            seenCandidates = nil
            candidatesSeenAt = 0
            actionBusy = false
            continue
        end
        if actionBusy or tryIndex({ "session", "private", "finished" }) == true then continue end

        local lineup = tryIndex({ "session", "private", "lineup" }) or {}
        local candidates = toArray(tryIndex({ "session", "private", "candidates" }))
        local rerolls = tonumber(tryIndex({ "session", "private", "rerolls" })) or 0
        local signature = candidateSignature(candidates)

        if signature ~= seenCandidates then
            seenCandidates = signature
            candidatesSeenAt = os.clock()
        end

        if #candidates == 0 then
            actionBusy = true
            fireAction("GetOffer")
            task.delay(0.18, function() actionBusy = false end)
            continue
        end

        local revealWait = math.max(0.12, (FootballDraft.RevealTime(#candidates) or 0) - (FootballDraft.PickTolerance or 0) + 0.03)
        local deadline = tonumber(tryIndex({ "session", "public", "deadline" }))
        local remainingTime = deadline and (deadline - workspace:GetServerTimeNow()) or math.huge





        local elapsedReveal = os.clock() - candidatesSeenAt
        local revealBudgetLeft = math.max(0.05, revealWait - elapsedReveal - 0.10)
        local actionBudgetLeft = remainingTime == math.huge and 0.90 or math.max(0.05, remainingTime - 0.60)
        local thinkBudget = math.min(0.90, revealBudgetLeft, actionBudgetLeft)
        local reroll, pickIndex = chooseOptimalAction(lineup, candidates, rerolls, thinkBudget)

        if reroll and remainingTime > 0.65 then
            actionBusy = true
            task.wait(randomRange(rng, 0.04, 0.08))
            if gameId() == "FootballDraft" and publicPhase() == "Drafting" then
                fireAction("Reroll")
            end
            task.delay(0.16, function() actionBusy = false end)
            continue
        end

        elapsedReveal = os.clock() - candidatesSeenAt
        if elapsedReveal < revealWait and remainingTime > 0.55 then
            task.wait(math.min(revealWait - elapsedReveal, math.max(0, remainingTime - 0.50)))
        end




        local liveCandidates = toArray(tryIndex({ "session", "private", "candidates" }))
        if candidateSignature(liveCandidates) ~= signature then
            continue
        end

        if pickIndex then
            actionBusy = true
            task.wait(randomRange(rng, 0.03, 0.06))
            if gameId() == "FootballDraft" and publicPhase() == "Drafting" then
                fireAction("Pick", pickIndex)
            end
            task.delay(0.18, function() actionBusy = false end)
        end
    end
end)



task.spawn(function()
    local rng = Random.new(
        (LocalPlayer.UserId * 22695477
            + math.floor(workspace:GetServerTimeNow() * 1000))
        % 2147483647
    )


    local physics = rawget(_G, "__TSUNAMI_KNOCKOUT_ULTIMATE_PHYSICS_V6")
    if type(physics) ~= "table" then
        physics = {
            dt = 1 / 30,
            steps = 90,
            dragLambda = 3.0,
            restitution = 0.88,
            sinkMargin = 0,
            powerSpeed = {},
            samples = 0,
            collisionSamples = 0,
            dragSamples = 0,
            sinkSamples = 0,
        }
        rawset(_G, "__TSUNAMI_KNOCKOUT_ULTIMATE_PHYSICS_V6", physics)
    end
    physics.powerSpeed = type(physics.powerSpeed) == "table" and physics.powerSpeed or {}

    local function newOpponentProfile()
        local p = {
            rounds = 0,
            attackCount = 0,
            defendCount = 0,
            powerCounts = table.create(10, 0),
            offsetSum = 0,
            offsetSq = 0,
            offsetN = 0,
            targetEdgeCount = 0,
            targetNearestCount = 0,
            targetCenterCount = 0,
            recentPower = 7,
        }
        for i = 1, 10 do p.powerCounts[i] = 0 end
        return p
    end

    local KNOCKOUT_LEARNING_PATH = "TuffHub_KnockoutLearning_v1.json"
    local opponentModel = rawget(_G, "__TSUNAMI_KNOCKOUT_OPPONENT_V7")
        or rawget(_G, "__TSUNAMI_KNOCKOUT_OPPONENT_V6")
    if type(opponentModel) ~= "table" then
        local readfileFn = envFunction("readfile")
        local isfileFn = envFunction("isfile")
        if readfileFn and isfileFn then
            local okExists, exists = pcall(isfileFn, KNOCKOUT_LEARNING_PATH)
            if okExists and exists then
                local okRead, body = pcall(readfileFn, KNOCKOUT_LEARNING_PATH)
                if okRead and type(body) == "string" then
                    local okDecode, decoded = pcall(HttpService.JSONDecode, HttpService, body)
                    if okDecode and type(decoded) == "table" then opponentModel = decoded end
                end
            end
        end
    end
    if type(opponentModel) ~= "table" then
        opponentModel = { profiles = {}, global = newOpponentProfile() }
    end
    rawset(_G, "__TSUNAMI_KNOCKOUT_OPPONENT_V7", opponentModel)
    if type(opponentModel.profiles) ~= "table" then opponentModel.profiles = {} end
    if type(opponentModel.global) ~= "table" then opponentModel.global = newOpponentProfile() end

    local function ensureOpponentProfile(p)
        if type(p) ~= "table" then p = newOpponentProfile() end
        p.powerCounts = type(p.powerCounts) == "table" and p.powerCounts or table.create(10, 0)
        for i = 1, 10 do p.powerCounts[i] = tonumber(p.powerCounts[i]) or 0 end
        p.rounds = tonumber(p.rounds) or 0
        p.attackCount = tonumber(p.attackCount) or 0
        p.defendCount = tonumber(p.defendCount) or 0
        p.offsetSum = tonumber(p.offsetSum) or 0
        p.offsetSq = tonumber(p.offsetSq) or 0
        p.offsetN = tonumber(p.offsetN) or 0
        p.targetEdgeCount = tonumber(p.targetEdgeCount) or 0
        p.targetNearestCount = tonumber(p.targetNearestCount) or 0
        p.targetCenterCount = tonumber(p.targetCenterCount) or 0
        p.recentPower = tonumber(p.recentPower) or 7
        return p
    end
    opponentModel.global = ensureOpponentProfile(opponentModel.global)
    local knockoutDirty = false
    local lastKnockoutSave = 0
    local function saveKnockoutLearning(force)
        if not knockoutDirty then return end
        local now = os.clock()
        if not force and now - lastKnockoutSave < 0.75 then return end
        local writefileFn = envFunction("writefile")
        if not writefileFn then return end
        local okEncode, body = pcall(HttpService.JSONEncode, HttpService, opponentModel)
        if okEncode and type(body) == "string" then
            local okWrite = pcall(writefileFn, KNOCKOUT_LEARNING_PATH, body)
            if okWrite then
                knockoutDirty = false
                lastKnockoutSave = now
            end
        end
    end

    local function knockoutOpponentKey()
        local opponent = tryIndex({ "session", "private", "opponent" })
        if typeof(opponent) == "Instance" and opponent:IsA("Player") then
            return "uid:" .. tostring(opponent.UserId)
        end
        local players = Players:GetPlayers()
        if #players == 2 then
            for _, player in ipairs(players) do
                if player ~= LocalPlayer then return "uid:" .. tostring(player.UserId) end
            end
        end
        return "unknown"
    end

    local function opponentProfile()
        local key = knockoutOpponentKey()
        local p = opponentModel.profiles[key]
        if type(p) ~= "table" then
            p = newOpponentProfile()
            opponentModel.profiles[key] = p
        else
            p = ensureOpponentProfile(p)
            opponentModel.profiles[key] = p
        end
        return p
    end

    local previousPhase = nil
    local aimingKey = nil
    local planned = {}
    local aimSent = {}
    local lockedByUs = {}
    local commitStarted = false
    local launchSnapshot = nil
    local lastResolutionKey = nil

    local function publicPucks()
        return tryIndex({ "session", "public", "pucks" })
    end

    local function puckInstance(id)
        for _, instance in ipairs(CollectionService:GetTagged("KnockoutPuck")) do
            if instance:GetAttribute("PuckId") == id then
                return instance
            end
        end
        return nil
    end

    local function worldPosition(instance)
        if not instance then return nil end
        if instance:IsA("BasePart") then return instance.Position end
        if instance:IsA("Model") then return instance:GetPivot().Position end
        return nil
    end

    local function innerPart()
        local tableModel = tryIndex({ "session", "public", "tableModel" })
        if typeof(tableModel) ~= "Instance" then return nil end
        local board = tableModel:FindFirstChild("KnockoutBoard")
        return board and board:FindFirstChild("InnerPart") or nil
    end

    local function localXZ(inner, worldPos)
        local p = inner.CFrame:PointToObjectSpace(worldPos)
        return Vector2.new(p.X, p.Z)
    end

    local function collectPucks(mine, inner)
        local own, enemy = {}, {}
        local pucks = publicPucks()
        if pucks == nil then return own, enemy end

        pcall(function()
            for _, data in pucks do
                if data.alive == true then
                    local instance = puckInstance(data.id)
                    local world = worldPosition(instance)
                    if world then
                        local radius = 0.19
                        if instance:IsA("BasePart") then
                            radius = math.max(instance.Size.X, instance.Size.Z) * 0.5
                        end
                        local entry = {
                            id = data.id,
                            team = tonumber(data.team),
                            locked = data.locked == true,
                            alive = true,
                            radius = radius,
                            world = world,
                            p = localXZ(inner, world),
                            instance = instance,
                        }
                        if entry.team == mine then
                            own[#own + 1] = entry
                        else
                            enemy[#enemy + 1] = entry
                        end
                    end
                end
            end
        end)

        table.sort(own, function(a, b) return tostring(a.id) < tostring(b.id) end)
        table.sort(enemy, function(a, b) return tostring(a.id) < tostring(b.id) end)
        return own, enemy
    end

    local function boardHalf(inner)
        return inner.Size.X * 0.5, inner.Size.Z * 0.5
    end

    local function edgeDistance(inner, p)
        local hx, hz = boardHalf(inner)
        return math.min(hx - math.abs(p.X), hz - math.abs(p.Y))
    end

    local function nearestOutward(inner, p)
        local hx, hz = boardHalf(inner)
        local xr = hx - math.abs(p.X)
        local zr = hz - math.abs(p.Y)
        if xr <= zr then
            return Vector2.new(p.X >= 0 and 1 or -1, 0), xr
        end
        return Vector2.new(0, p.Y >= 0 and 1 or -1), zr
    end

    local function angleForDirection(dir)
        return math.atan2(dir.X, dir.Y)
    end

    local function rotate2(dir, radians)
        local c, s = math.cos(radians), math.sin(radians)
        return Vector2.new(
            dir.X * c - dir.Y * s,
            dir.X * s + dir.Y * c
        )
    end

    local function rayDistanceToBoundary(inner, origin, dir, radius)
        local hx, hz = boardHalf(inner)
        local margin = tonumber(physics.sinkMargin) or 0
        hx += margin - (radius or 0) * 0.05
        hz += margin - (radius or 0) * 0.05
        local best = math.huge

        if math.abs(dir.X) > 1e-8 then
            local a = (hx - origin.X) / dir.X
            local b = (-hx - origin.X) / dir.X
            if a > 0 then best = math.min(best, a) end
            if b > 0 then best = math.min(best, b) end
        end
        if math.abs(dir.Y) > 1e-8 then
            local a = (hz - origin.Y) / dir.Y
            local b = (-hz - origin.Y) / dir.Y
            if a > 0 then best = math.min(best, a) end
            if b > 0 then best = math.min(best, b) end
        end
        return best
    end

    local function defaultTravel(inner, power)
        local r = math.max(0.2, math.min(inner.Size.X, inner.Size.Z) * 0.5)
        return r * (0.08 + 0.145 * math.clamp(power, 1, 10))
    end

    local function fittedPowerSpeed(inner, power)
        local direct = physics.powerSpeed[power]
        if type(direct) == "table" and (tonumber(direct.n) or 0) > 0 then
            return tonumber(direct.mean) or 0
        end

        local xs, ys = {}, {}
        for p = 1, 10 do
            local sample = physics.powerSpeed[p]
            if type(sample) == "table" and (tonumber(sample.n) or 0) > 0 then
                xs[#xs + 1] = p
                ys[#ys + 1] = tonumber(sample.mean) or 0
            end
        end

        if #xs >= 2 then
            local sx, sy, sxx, sxy = 0, 0, 0, 0
            for i = 1, #xs do
                sx += xs[i]
                sy += ys[i]
                sxx += xs[i] * xs[i]
                sxy += xs[i] * ys[i]
            end
            local n = #xs
            local denom = n * sxx - sx * sx
            if math.abs(denom) > 1e-8 then
                local slope = (n * sxy - sx * sy) / denom
                local intercept = (sy - slope * sx) / n
                return math.max(0.01, intercept + slope * power)
            end
        elseif #xs == 1 then
            return math.max(0.01, ys[1] * power / xs[1])
        end



        local lambda = math.max(0.35, tonumber(physics.dragLambda) or 3)
        return defaultTravel(inner, power) * lambda
    end

    local function nearestPowerForSpeed(inner, speed)
        local bestP, bestErr = 5, math.huge
        for p = 1, 10 do
            local err = math.abs(fittedPowerSpeed(inner, p) - speed)
            if err < bestErr then
                bestErr = err
                bestP = p
            end
        end
        return bestP
    end

    local function addPowerSample(power, speed)
        if power < 1 or power > 10 or speed <= 0 then return end
        local slot = physics.powerSpeed[power]
        if type(slot) ~= "table" then
            slot = { mean = speed, n = 1 }
            physics.powerSpeed[power] = slot
            return
        end
        local n = tonumber(slot.n) or 0
        local mean = tonumber(slot.mean) or speed
        local alpha = n < 6 and (1 / (n + 1)) or 0.12
        slot.mean = mean * (1 - alpha) + speed * alpha
        slot.n = n + 1
    end

    local function trajectoryPoint(sample)
        if sample == nil then return nil end
        local x = tonumber(safeIndex(sample, "x"))
        local z = tonumber(safeIndex(sample, "z"))
        if x == nil or z == nil then return nil end
        return Vector2.new(x, z)
    end

    local function trajectoryLength(trajectory)
        local n = 0
        pcall(function() n = #trajectory end)
        return n
    end

    local function velocityAt(trajectory, i, dt)
        local a = trajectoryPoint(safeIndex(trajectory, i))
        local b = trajectoryPoint(safeIndex(trajectory, i + 1))
        if not a or not b or dt <= 0 then return nil end
        return (b - a) / dt
    end

    local function snapshotLaunch(inner, own, enemy)
        local snap = {
            own = {},
            enemy = {},
            all = {},
            plans = {},
            hx = inner.Size.X * 0.5,
            hz = inner.Size.Z * 0.5,
        }
        for _, puck in ipairs(own) do
            local data = { id = puck.id, team = puck.team, p = puck.p, radius = puck.radius, mine = true }
            snap.own[#snap.own + 1] = data
            snap.all[puck.id] = data
        end
        for _, puck in ipairs(enemy) do
            local data = { id = puck.id, team = puck.team, p = puck.p, radius = puck.radius, mine = false }
            snap.enemy[#snap.enemy + 1] = data
            snap.all[puck.id] = data
        end
        for id, plan in pairs(planned) do
            snap.plans[id] = {
                angle = plan.angle,
                power = plan.power,
                dir = plan.dir,
            }
        end
        return snap
    end

    local function estimateFreeSegment(trajectories, id, i, snap, dt)
        local trajectory = safeIndex(trajectories, id)
        if not trajectory then return false end
        local p = trajectoryPoint(safeIndex(trajectory, i))
        local v1 = velocityAt(trajectory, i, dt)
        local v2 = velocityAt(trajectory, i + 1, dt)
        if not p or not v1 or not v2 or v1.Magnitude < 1e-4 or v2.Magnitude < 1e-4 then
            return false
        end
        if v1.Unit:Dot(v2.Unit) < 0.996 then return false end

        local selfData = snap.all[id]
        local radius = selfData and selfData.radius or 0.19
        for otherId, other in pairs(snap.all) do
            if otherId ~= id then
                local otherTrajectory = safeIndex(trajectories, otherId)
                local op = otherTrajectory and trajectoryPoint(safeIndex(otherTrajectory, i)) or other.p
                if op and (op - p).Magnitude < radius + other.radius + 0.18 then
                    return false
                end
            end
        end
        return true, v1, v2
    end

    local function updateOpponentBehavior(inner, trajectories, dt, snap)
        local profile = opponentProfile()
        local global = opponentModel.global
        profile.rounds += 1
        global.rounds += 0.18
        knockoutDirty = true

        local edgeMinId, edgeMin = nil, math.huge
        for _, target in ipairs(snap.own) do
            local e = edgeDistance(inner, target.p)
            if e < edgeMin then edgeMin, edgeMinId = e, target.id end
        end

        for _, enemy in ipairs(snap.enemy) do
            local trajectory = safeIndex(trajectories, enemy.id)
            local v = trajectory and velocityAt(trajectory, 1, dt) or nil
            if v and v.Magnitude > 1e-4 then
                local dir = v.Unit
                local power = nearestPowerForSpeed(inner, v.Magnitude)
                profile.powerCounts[power] += 1
                global.powerCounts[power] += 0.18
                profile.recentPower = profile.recentPower * 0.75 + power * 0.25

                local bestTarget, bestMiss, bestForward = nil, math.huge, math.huge
                local nearestTarget, nearestDistance = nil, math.huge
                for _, target in ipairs(snap.own) do
                    local delta = target.p - enemy.p
                    local dist = delta.Magnitude
                    if dist < nearestDistance then
                        nearestDistance = dist
                        nearestTarget = target
                    end
                    if dist > 0.01 then
                        local forward = delta:Dot(dir)
                        if forward > 0 then
                            local miss = math.abs(delta.X * dir.Y - delta.Y * dir.X)
                            if miss < bestMiss then
                                bestMiss = miss
                                bestForward = forward
                                bestTarget = target
                            end
                        end
                    end
                end

                local attackThreshold = enemy.radius + (bestTarget and bestTarget.radius or 0.19) + 0.34
                if bestTarget and bestMiss <= attackThreshold then
                    profile.attackCount += 1
                    global.attackCount += 0.18
                    if bestTarget.id == edgeMinId then profile.targetEdgeCount += 1 end
                    if nearestTarget and bestTarget.id == nearestTarget.id then profile.targetNearestCount += 1 end

                    local direct = (bestTarget.p - enemy.p).Unit
                    local cross = direct.X * dir.Y - direct.Y * dir.X
                    local dot = math.clamp(direct:Dot(dir), -1, 1)
                    local offset = math.atan2(cross, dot)
                    profile.offsetSum += offset
                    profile.offsetSq += offset * offset
                    profile.offsetN += 1
                else
                    local inward = -enemy.p
                    if inward.Magnitude > 0.01 and dir:Dot(inward.Unit) > 0.65 then
                        profile.defendCount += 1
                        global.defendCount += 0.18
                    end
                end
            end
        end
    end

    local function learnResolution(inner)
        local resolution = tryIndex({ "session", "public", "resolution" })
        if resolution == nil or launchSnapshot == nil then return end
        local key = tostring(safeIndex(resolution, "startTime") or resolution)
        if key == lastResolutionKey then return end
        local trajectories = safeIndex(resolution, "trajectories")
        local dt = tonumber(safeIndex(resolution, "dt"))
        if trajectories == nil or not dt or dt <= 0 then return end
        lastResolutionKey = key

        physics.dt = physics.dt * 0.75 + dt * 0.25

        local maxSteps = 0
        for id in pairs(launchSnapshot.all) do
            local trajectory = safeIndex(trajectories, id)
            if trajectory then maxSteps = math.max(maxSteps, trajectoryLength(trajectory)) end
        end
        if maxSteps > 2 then
            physics.steps = math.floor((tonumber(physics.steps) or maxSteps) * 0.80 + maxSteps * 0.20 + 0.5)
        end



        for id, plan in pairs(launchSnapshot.plans) do
            local trajectory = safeIndex(trajectories, id)
            local v = trajectory and velocityAt(trajectory, 1, dt) or nil
            if v and v.Magnitude > 1e-4 and plan.dir then
                if v.Unit:Dot(plan.dir) > 0.992 then
                    addPowerSample(math.clamp(math.floor(plan.power + 0.5), 1, 10), v.Magnitude)
                end
            end
        end


        local lambdaSum, lambdaN = 0, 0
        for id in pairs(launchSnapshot.all) do
            local trajectory = safeIndex(trajectories, id)
            local n = trajectory and trajectoryLength(trajectory) or 0
            for i = 1, math.max(0, n - 2) do
                local free, v1, v2 = estimateFreeSegment(trajectories, id, i, launchSnapshot, dt)
                if free then
                    local ratio = v2.Magnitude / math.max(v1.Magnitude, 1e-6)
                    if ratio > 0.50 and ratio < 1.001 then
                        local lambda = -math.log(ratio) / dt
                        if lambda >= 0 and lambda < 20 then
                            lambdaSum += lambda
                            lambdaN += 1
                        end
                    end
                end
            end
        end
        if lambdaN > 0 then
            local observed = lambdaSum / lambdaN
            physics.dragLambda = math.clamp((tonumber(physics.dragLambda) or observed) * 0.86 + observed * 0.14, 0.05, 20)
            physics.dragSamples = (tonumber(physics.dragSamples) or 0) + lambdaN
        end


        local eSum, eN = 0, 0
        local ids = {}
        for id in pairs(launchSnapshot.all) do ids[#ids + 1] = id end
        for aIndex = 1, #ids - 1 do
            for bIndex = aIndex + 1, #ids do
                local aId, bId = ids[aIndex], ids[bIndex]
                local ta, tb = safeIndex(trajectories, aId), safeIndex(trajectories, bId)
                local ad, bd = launchSnapshot.all[aId], launchSnapshot.all[bId]
                local n = math.min(trajectoryLength(ta or {}), trajectoryLength(tb or {}))
                for i = 2, math.max(1, n - 2) do
                    local pa = trajectoryPoint(safeIndex(ta, i))
                    local pb = trajectoryPoint(safeIndex(tb, i))
                    if pa and pb then
                        local delta = pb - pa
                        local rsum = ad.radius + bd.radius
                        if delta.Magnitude <= rsum + 0.08 and delta.Magnitude > 1e-5 then
                            local normal = delta.Unit
                            local vaBefore = velocityAt(ta, i - 1, dt)
                            local vbBefore = velocityAt(tb, i - 1, dt)
                            local vaAfter = velocityAt(ta, i + 1, dt)
                            local vbAfter = velocityAt(tb, i + 1, dt)
                            if vaBefore and vbBefore and vaAfter and vbAfter then
                                local pre = (vaBefore - vbBefore):Dot(normal)
                                local post = (vaAfter - vbAfter):Dot(normal)
                                if pre > 0.10 and post < 0 then
                                    local e = -post / pre
                                    if e >= 0 and e <= 1.35 then
                                        eSum += e
                                        eN += 1
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        if eN > 0 then
            local observed = eSum / eN
            physics.restitution = math.clamp((tonumber(physics.restitution) or observed) * 0.82 + observed * 0.18, 0.10, 1.20)
            physics.collisionSamples = (tonumber(physics.collisionSamples) or 0) + eN
        end


        local marginSum, marginN = 0, 0
        local hx, hz = boardHalf(inner)
        for id in pairs(launchSnapshot.all) do
            local trajectory = safeIndex(trajectories, id)
            local n = trajectory and trajectoryLength(trajectory) or 0
            for i = 1, n do
                local sample = safeIndex(trajectory, i)
                if safeIndex(sample, "sunk") == true then
                    local p = trajectoryPoint(sample)
                    if p then
                        local margin = math.max(math.abs(p.X) - hx, math.abs(p.Y) - hz)
                        marginSum += margin
                        marginN += 1
                    end
                    break
                end
            end
        end
        if marginN > 0 then
            local observed = marginSum / marginN
            physics.sinkMargin = (tonumber(physics.sinkMargin) or observed) * 0.82 + observed * 0.18
            physics.sinkSamples = (tonumber(physics.sinkSamples) or 0) + marginN
        end

        physics.samples = (tonumber(physics.samples) or 0) + 1
        updateOpponentBehavior(inner, trajectories, dt, launchSnapshot)
        saveKnockoutLearning(true)
    end

    local function pointSegmentDistance(p, a, b)
        local ab = b - a
        local denom = ab:Dot(ab)
        if denom <= 1e-9 then return (p - a).Magnitude, 0 end
        local t = math.clamp((p - a):Dot(ab) / denom, 0, 1)
        return (p - (a + ab * t)).Magnitude, t
    end

    local function clearApproach(shooter, target, contact, own, enemy)
        local clearance = (shooter.radius + target.radius) * 0.86
        for _, other in ipairs(own) do
            if other.id ~= shooter.id then
                local d, t = pointSegmentDistance(other.p, shooter.p, contact)
                if t > 0.04 and t < 0.96 and d < clearance + other.radius * 0.50 then
                    return false
                end
            end
        end
        for _, other in ipairs(enemy) do
            if other.id ~= target.id then
                local d, t = pointSegmentDistance(other.p, shooter.p, contact)
                if t > 0.04 and t < 0.96 and d < clearance + other.radius * 0.50 then
                    return false
                end
            end
        end
        return true
    end

    local function actionStaticScore(inner, shooter, action, target)
        local travel = fittedPowerSpeed(inner, action.power) / math.max(0.2, tonumber(physics.dragLambda) or 3)
        local boundary = rayDistanceToBoundary(inner, shooter.p, action.dir, shooter.radius)
        local missRisk = math.max(0, travel - boundary)
        local score = -missRisk * 35

        if action.kind == "defense" then
            local predicted = shooter.p + action.dir * math.min(travel, boundary * 0.90)
            score += edgeDistance(inner, predicted) * 10
            score -= predicted.Magnitude * 0.9
        elseif target then
            local outward, targetEdge = nearestOutward(inner, target.p)
            local alignment = math.max(0, action.dir:Dot(outward))
            score += alignment * 8
            score += 8 / (0.2 + math.max(0, targetEdge))
            score -= (target.p - shooter.p).Magnitude * 0.45
        end
        return score
    end

    local function candidateActions(inner, shooter, own, enemy, ownIndex, ownCount)
        local candidates = {}
        local hx, hz = boardHalf(inner)
        local lane = ownIndex - (ownCount + 1) * 0.5

        local anchors = {
            Vector2.new(0, 0),
            Vector2.new(math.clamp(lane * hx * 0.15, -hx * 0.22, hx * 0.22), math.clamp(-lane * hz * 0.08, -hz * 0.18, hz * 0.18)),
            Vector2.new(math.clamp(lane * hx * 0.10, -hx * 0.18, hx * 0.18), math.clamp(lane * hz * 0.14, -hz * 0.20, hz * 0.20)),
        }

        for _, anchor in ipairs(anchors) do
            local delta = anchor - shooter.p
            if delta.Magnitude > 0.02 then
                local dir = delta.Unit
                for power = 1, 6 do
                    local action = { kind = "defense", targetId = nil, dir = dir, angle = angleForDirection(dir), power = power }
                    action.staticScore = actionStaticScore(inner, shooter, action, nil)
                    candidates[#candidates + 1] = action
                end
            end
        end

        for _, target in ipairs(enemy) do
            local outward = select(1, nearestOutward(inner, target.p))
            local contactRadius = shooter.radius + target.radius




            for offset = -54, 54, 3 do
                local normal = rotate2(outward, math.rad(offset)).Unit
                local contact = target.p - normal * contactRadius
                local delta = contact - shooter.p
                if delta.Magnitude > 0.02 then
                    local dir = delta.Unit
                    local incidence = dir:Dot(normal)
                    if incidence > 0.16 and clearApproach(shooter, target, contact, own, enemy) then
                        for power = 1, 10 do
                            local action = {
                                kind = "attack",
                                targetId = target.id,
                                dir = dir,
                                angle = angleForDirection(dir),
                                power = power,
                                normal = normal,
                                incidence = incidence,
                            }
                            action.staticScore = actionStaticScore(inner, shooter, action, target)
                                + incidence * 7
                            candidates[#candidates + 1] = action
                        end
                    end
                end
            end
        end

        table.sort(candidates, function(a, b) return a.staticScore > b.staticScore end)
        local out, seen = {}, {}
        for _, action in ipairs(candidates) do
            local key = action.kind .. ":" .. tostring(action.targetId or "-") .. ":" .. tostring(action.power) .. ":" .. string.format("%.3f", action.angle)
            if not seen[key] then
                seen[key] = true
                out[#out + 1] = action
                if #out >= 12 then break end
            end
        end
        return out
    end

    local function enumeratePlans(own, options)
        local states = { { plan = {}, static = 0 } }
        for _, puck in ipairs(own) do
            if not puck.locked then
                local expanded = {}
                for _, state in ipairs(states) do
                    for _, action in ipairs(options[puck.id] or {}) do
                        local plan = table.clone(state.plan)
                        plan[puck.id] = action
                        expanded[#expanded + 1] = {
                            plan = plan,
                            static = state.static + action.staticScore,
                        }
                    end
                end
                table.sort(expanded, function(a, b) return a.static > b.static end)
                states = {}
                for i = 1, math.min(220, #expanded) do states[i] = expanded[i] end
            end
        end
        return states
    end

    local function powerDistribution(profile)
        local global = opponentModel.global
        local weights, total = {}, 0
        local n = 0
        for p = 1, 10 do n += tonumber(profile.powerCounts[p]) or 0 end
        local gn = 0
        for p = 1, 10 do gn += tonumber(global.powerCounts[p]) or 0 end
        for p = 1, 10 do
            local localP = ((tonumber(profile.powerCounts[p]) or 0) + 0.55) / (n + 5.5)
            local globalP = ((tonumber(global.powerCounts[p]) or 0) + 0.55) / (gn + 5.5)
            local prior = math.exp(-0.16 * math.abs(p - 7))
            local w = localP * 0.68 + globalP * 0.12 + prior * 0.20
            weights[p] = w
            total += w
        end
        return weights, total
    end

    local function chooseWeightedPower(profile)
        local weights, total = powerDistribution(profile)
        local x = rng:NextNumber() * total
        local running = 0
        for p = 1, 10 do
            running += weights[p]
            if x <= running then return p end
        end
        return 7
    end

    local function sampledOpponentAction(inner, puck, targets, profile)
        local attackTotal = profile.attackCount + profile.defendCount + 2
        local attackP = (profile.attackCount + 1.1) / attackTotal
        attackP = math.clamp(attackP * 0.78 + 0.16, 0.18, 0.94)

        if #targets > 0 and rng:NextNumber() < attackP then
            local edgeRate = (profile.targetEdgeCount + 1) / (profile.attackCount + 2)
            local nearRate = (profile.targetNearestCount + 1) / (profile.attackCount + 2)
            local scored = {}
            local total = 0
            local minDist = math.huge
            local minEdge = math.huge
            for _, target in ipairs(targets) do
                minDist = math.min(minDist, (target.p - puck.p).Magnitude)
                minEdge = math.min(minEdge, edgeDistance(inner, target.p))
            end
            for _, target in ipairs(targets) do
                local dist = (target.p - puck.p).Magnitude
                local edge = edgeDistance(inner, target.p)
                local score =
                    0.25
                    + edgeRate * (1 / (0.25 + edge))
                    + nearRate * (1 / (0.35 + dist))
                    + 0.15 * (edge <= minEdge + 1e-4 and 1 or 0)
                    + 0.10 * (dist <= minDist + 1e-4 and 1 or 0)
                scored[target.id] = score
                total += score
            end
            local x = rng:NextNumber() * total
            local running, target = 0, targets[1]
            for _, candidate in ipairs(targets) do
                running += scored[candidate.id]
                if x <= running then target = candidate break end
            end

            local direct = (target.p - puck.p).Unit
            local mean = profile.offsetN > 0 and profile.offsetSum / profile.offsetN or 0
            local variance = profile.offsetN > 1 and math.max(0, profile.offsetSq / profile.offsetN - mean * mean) or math.rad(12) ^ 2
            local sd = math.clamp(math.sqrt(variance), math.rad(4), math.rad(28))

            local u1 = math.max(1e-6, rng:NextNumber())
            local u2 = rng:NextNumber()
            local z = math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2)
            local dir = rotate2(direct, math.clamp(mean + z * sd, math.rad(-50), math.rad(50))).Unit
            local power = chooseWeightedPower(profile)
            return { kind = "attack", targetId = target.id, dir = dir, angle = angleForDirection(dir), power = power }
        end

        local inward = -puck.p
        if inward.Magnitude < 0.02 then inward = Vector2.new(0, 1) end
        inward = inward.Unit
        local jitter = math.rad(rng:NextNumber(-18, 18))
        local dir = rotate2(inward, jitter).Unit
        return { kind = "defense", targetId = nil, dir = dir, angle = angleForDirection(dir), power = math.clamp(math.floor(chooseWeightedPower(profile) * 0.55 + 0.5), 1, 6) }
    end

    local function adversarialOpponentPlan(inner, enemy, own)
        local plan = {}
        for index, puck in ipairs(enemy) do
            local options = candidateActions(inner, puck, enemy, own, index, #enemy)
            local best = options[1]
            if best then plan[puck.id] = best end
        end
        return plan
    end

    local function opponentScenarios(inner, own, enemy)
        local profile = opponentProfile()
        local scenarios = {}
        scenarios[#scenarios + 1] = { plan = adversarialOpponentPlan(inner, enemy, own), weight = 0.18 }

        local sampleN = math.clamp(12 + math.floor(profile.rounds * 0.9), 12, 22)
        for _ = 1, sampleN do
            local plan = {}
            for _, puck in ipairs(enemy) do
                plan[puck.id] = sampledOpponentAction(inner, puck, own, profile)
            end
            scenarios[#scenarios + 1] = { plan = plan, weight = 0.82 / sampleN }
        end
        return scenarios
    end

    local function simulate(inner, own, enemy, ownPlan, enemyPlan)
        local bodies = {}
        local byId = {}

        local function add(puck, mine, action)
            local speed = action and fittedPowerSpeed(inner, action.power) or 0
            local body = {
                id = puck.id,
                mine = mine,
                p = puck.p,
                v = action and action.dir * speed or Vector2.new(0, 0),
                radius = puck.radius,
                alive = true,
            }
            bodies[#bodies + 1] = body
            byId[body.id] = body
        end
        for _, puck in ipairs(own) do add(puck, true, ownPlan[puck.id]) end
        for _, puck in ipairs(enemy) do add(puck, false, enemyPlan[puck.id]) end

        local dt = math.clamp(tonumber(physics.dt) or (1 / 30), 1 / 120, 0.12)
        local steps = math.clamp(math.floor(tonumber(physics.steps) or 90), 35, 180)
        local lambda = math.clamp(tonumber(physics.dragLambda) or 3, 0.05, 20)
        local restitution = math.clamp(tonumber(physics.restitution) or 0.88, 0.10, 1.20)
        local hx, hz = boardHalf(inner)
        local sinkMargin = tonumber(physics.sinkMargin) or 0




        local minDiameter = math.huge
        local maxInitialSpeed = 0
        for _, body in ipairs(bodies) do
            minDiameter = math.min(minDiameter, body.radius * 2)
            maxInitialSpeed = math.max(maxInitialSpeed, body.v.Magnitude)
        end
        minDiameter = math.max(0.08, minDiameter)
        local substeps = math.clamp(
            math.ceil(maxInitialSpeed * dt / (minDiameter * 0.42)),
            1,
            5
        )
        local subDt = dt / substeps
        local damping = math.exp(-lambda * subDt)

        for _ = 1, steps do
            local maxSpeed = 0
            for _sub = 1, substeps do
                for _, body in ipairs(bodies) do
                    if body.alive then
                        body.p += body.v * subDt
                        maxSpeed = math.max(maxSpeed, body.v.Magnitude)
                        if math.abs(body.p.X) > hx + sinkMargin
                            or math.abs(body.p.Y) > hz + sinkMargin
                        then
                            body.alive = false
                            body.v = Vector2.new(0, 0)
                        end
                    end
                end

                for i = 1, #bodies - 1 do
                    local a = bodies[i]
                    if a.alive then
                        for j = i + 1, #bodies do
                            local b = bodies[j]
                            if b.alive then
                                local delta = b.p - a.p
                                local dist = delta.Magnitude
                                local minDist = a.radius + b.radius
                                if dist > 1e-7 and dist < minDist then
                                    local n = delta / dist
                                    local overlap = minDist - dist
                                    a.p -= n * (overlap * 0.5)
                                    b.p += n * (overlap * 0.5)
                                    local closing = (a.v - b.v):Dot(n)
                                    if closing > 0 then
                                        local impulse = (1 + restitution) * closing * 0.5
                                        a.v -= n * impulse
                                        b.v += n * impulse
                                    end
                                end
                            end
                        end
                    end
                end

                for _, body in ipairs(bodies) do
                    if body.alive then body.v *= damping end
                end
            end
            if maxSpeed < 0.025 then break end
        end

        local myAlive, enemyAlive = 0, 0
        local mySafety, enemySafety = 0, 0
        for _, body in ipairs(bodies) do
            if body.alive then
                local safety = math.min(hx - math.abs(body.p.X), hz - math.abs(body.p.Y))
                if body.mine then
                    myAlive += 1
                    mySafety += safety
                else
                    enemyAlive += 1
                    enemySafety += safety
                end
            end
        end

        if enemyAlive == 0 and myAlive > 0 then
            return 2000 + myAlive * 140 + mySafety * 10
        end
        if myAlive == 0 and enemyAlive > 0 then
            return -2000 - enemyAlive * 140 - enemySafety * 5
        end
        if myAlive == 0 and enemyAlive == 0 then
            return -120
        end



        return (myAlive - enemyAlive) * 260 + mySafety * 18 - enemySafety * 7
    end

    local function robustPlan(inner, own, enemy)
        local options = {}
        for i, puck in ipairs(own) do
            if not puck.locked then
                options[puck.id] = candidateActions(inner, puck, own, enemy, i, #own)
            end
        end
        local plans = enumeratePlans(own, options)
        if #plans == 0 then return {} end
        local scenarios = opponentScenarios(inner, own, enemy)

        local profile = opponentProfile()
        local confidence = math.clamp(profile.rounds / 12, 0, 1)
        local tailWeight = 0.36 - confidence * 0.12
        local worstWeight = 0.12 - confidence * 0.05
        local meanWeight = 1 - tailWeight - worstWeight

        local bestObjective, bestPlan = -math.huge, plans[1].plan
        for _, candidate in ipairs(plans) do
            local values = {}
            local weightedMean = 0
            local totalWeight = 0
            for _, scenario in ipairs(scenarios) do
                local value = simulate(inner, own, enemy, candidate.plan, scenario.plan)
                values[#values + 1] = value
                weightedMean += value * scenario.weight
                totalWeight += scenario.weight
            end
            weightedMean /= math.max(totalWeight, 1e-8)
            table.sort(values)
            local tailCount = math.max(1, math.ceil(#values * 0.25))
            local tail = 0
            for i = 1, tailCount do tail += values[i] end
            tail /= tailCount
            local worst = values[1]
            local objective = weightedMean * meanWeight + tail * tailWeight + worst * worstWeight + candidate.static * 0.025
            if objective > bestObjective then
                bestObjective = objective
                bestPlan = candidate.plan
            end
        end
        return bestPlan
    end

    local function allOpponentLocked(enemy)
        if #enemy == 0 then return true end
        for _, puck in ipairs(enemy) do
            if not puck.locked then return false end
        end
        return true
    end

    local function resetAiming(clearSnapshot)
        aimingKey = nil
        table.clear(planned)
        table.clear(aimSent)
        table.clear(lockedByUs)
        commitStarted = false
        if clearSnapshot ~= false then launchSnapshot = nil end
    end

    while not controller.destroyed do
        task.wait(gameId() == "Knockout" and 0.028 or 0.15)

        if gameId() ~= "Knockout" then
            saveKnockoutLearning(true)
            previousPhase = nil
            resetAiming(true)
            continue
        end

        if not minigameAutoplayEnabled("Knockout") then
            previousPhase = nil
            resetAiming(true)
            continue
        end

        saveKnockoutLearning(false)
        local phase = publicPhase()
        if phase == "Resolving" then
            local inner = innerPart()
            if inner then learnResolution(inner) end
        end

        if phase ~= "Aiming" then
            if previousPhase == "Aiming" and phase == "Resolving" then

            elseif phase ~= "Resolving" then
                resetAiming(true)
            end
            previousPhase = phase
            continue
        end
        previousPhase = phase

        local inner = innerPart()
        local mine = seatIndex()
        if not inner or not mine then continue end
        local own, enemy = collectPucks(mine, inner)
        if #own == 0 then continue end

        local deadline = tonumber(tryIndex({ "session", "public", "deadline" }))
        local key = tostring(deadline or "nodeadline") .. ":" .. tostring(#own) .. ":" .. tostring(#enemy)

        if aimingKey ~= key then
            resetAiming(true)
            aimingKey = key
            local selected = robustPlan(inner, own, enemy)
            for id, action in pairs(selected) do planned[id] = action end
            launchSnapshot = snapshotLaunch(inner, own, enemy)
        end

        for _, puck in ipairs(own) do
            local action = planned[puck.id]
            if action and not puck.locked and not aimSent[puck.id] then
                aimSent[puck.id] = true
                fireAction("SetAim", puck.id, action.angle, action.power)
                task.wait(0.030)
            end
        end

        local remaining = deadline and (deadline - workspace:GetServerTimeNow()) or math.huge
        if not commitStarted and (allOpponentLocked(enemy) or remaining <= 3.1) then
            commitStarted = true
        end

        if commitStarted then
            for _, puck in ipairs(own) do
                if not puck.locked and not lockedByUs[puck.id] then
                    local action = planned[puck.id]
                    if action then
                        fireAction("SetAim", puck.id, action.angle, action.power)
                        task.wait(0.040)
                    end
                    if gameId() == "Knockout" and publicPhase() == "Aiming" then
                        lockedByUs[puck.id] = true
                        fireAction("LockAim", puck.id)
                        task.wait(0.040)
                    end
                end
            end
        end
    end
end)



task.spawn(function()
    local BattleshipUtils =
        require(ReplicatedStorage.SharedModules.BattleshipUtils)

    local GRID_SIZE = BattleshipUtils.GRID_SIZE
    local SHIPS = BattleshipUtils.SHIPS
    local coordKey = BattleshipUtils.coordKey
    local resolveGrid = BattleshipUtils.resolveGrid
    local rng = Random.new(
        (LocalPlayer.UserId * 134775813
            + math.floor(workspace:GetServerTimeNow() * 1000))
        % 2147483647
    )






















    local bit = bit32
    local FULL32 = 0xFFFFFFFF

    local function cellIndex(r, c)
        return (r - 1) * GRID_SIZE + c
    end

    local function indexToRowCol(index)
        return (index - 1) // GRID_SIZE + 1,
            (index - 1) % GRID_SIZE + 1
    end

    local function cellBit(index)
        if index <= 32 then
            return bit.lshift(1, index - 1), 0
        end
        return 0, bit.lshift(1, index - 33)
    end

    local function maskHas(lo, hi, index)
        if index <= 32 then
            return bit.band(lo, bit.lshift(1, index - 1)) ~= 0
        end
        return bit.band(hi, bit.lshift(1, index - 33)) ~= 0
    end

    local function masksOverlap(aLo, aHi, bLo, bHi)
        return
            bit.band(aLo, bLo) ~= 0
            or bit.band(aHi, bHi) ~= 0
    end

    local function popcount32(value)
        value = bit.band(value, FULL32)
        local count = 0

        while value ~= 0 do
            value = bit.band(value, value - 1)
            count += 1
        end

        return count
    end

    local function maskIntersectionCount(aLo, aHi, bLo, bHi)
        return
            popcount32(bit.band(aLo, bLo))
            + popcount32(bit.band(aHi, bHi))
    end

    local function maskContainsAll(lo, hi, wantedLo, wantedHi)
        return
            bit.band(lo, wantedLo) == wantedLo
            and bit.band(hi, wantedHi) == wantedHi
    end

    local function maskKey(lo, hi)
        return tostring(lo) .. ":" .. tostring(hi)
    end

    local function cellsMask(cells)
        local lo, hi = 0, 0
        if cells ~= nil then
            pcall(function()
                for _, cell in cells do
                    local r = tonumber(cell.row)
                    local c = tonumber(cell.col)
                    if r and c
                        and r >= 1 and r <= GRID_SIZE
                        and c >= 1 and c <= GRID_SIZE
                    then
                        local bLo, bHi =
                            cellBit(cellIndex(r, c))
                        lo = bit.bor(lo, bLo)
                        hi = bit.bor(hi, bHi)
                    end
                end
            end)
        end
        return lo, hi
    end

    local function makePlacements(shipIndex, size)
        local out = {}

        for r = 1, GRID_SIZE do
            for c = 1, GRID_SIZE - size + 1 do
                local cells = {}
                local lo, hi = 0, 0

                for k = 0, size - 1 do
                    local rr, cc = r, c + k
                    local idx = cellIndex(rr, cc)
                    local bLo, bHi = cellBit(idx)
                    lo = bit.bor(lo, bLo)
                    hi = bit.bor(hi, bHi)
                    cells[#cells + 1] = {
                        row = rr,
                        col = cc,
                        index = idx,
                    }
                end

                out[#out + 1] = {
                    shipIndex = shipIndex,
                    horizontal = true,
                    cells = cells,
                    lo = lo,
                    hi = hi,
                    key = maskKey(lo, hi),
                }
            end
        end

        for c = 1, GRID_SIZE do
            for r = 1, GRID_SIZE - size + 1 do
                local cells = {}
                local lo, hi = 0, 0

                for k = 0, size - 1 do
                    local rr, cc = r + k, c
                    local idx = cellIndex(rr, cc)
                    local bLo, bHi = cellBit(idx)
                    lo = bit.bor(lo, bLo)
                    hi = bit.bor(hi, bHi)
                    cells[#cells + 1] = {
                        row = rr,
                        col = cc,
                        index = idx,
                    }
                end

                out[#out + 1] = {
                    shipIndex = shipIndex,
                    horizontal = false,
                    cells = cells,
                    lo = lo,
                    hi = hi,
                    key = maskKey(lo, hi),
                }
            end
        end

        return out
    end

    local placements = {}
    local placementIndexByMask = {}
    local cellExposure = table.create(64, 0)

    for shipIndex, ship in ipairs(SHIPS) do
        placements[shipIndex] =
            makePlacements(shipIndex, ship.size)
        placementIndexByMask[shipIndex] = {}

        for pIndex, placement in ipairs(placements[shipIndex]) do
            placementIndexByMask[shipIndex][placement.key] = pIndex

            for _, cell in ipairs(placement.cells) do
                cellExposure[cell.index] += 1
            end
        end
    end

    local maxExposure = 1
    for i = 1, 64 do
        maxExposure = math.max(maxExposure, cellExposure[i])
    end





    local EXPECTED_FLEET_COUNT = 270000
    local fleetBuffers = {}
    local fleetCount = 0
    local fleetReady = false

    local function fleetAt(slot, i)
        if slot <= 3 then
            return buffer.readu8(fleetBuffers[slot], i - 1)
        end
        return buffer.readu32(fleetBuffers[slot], (i - 1) * 4)
    end

    local function releaseFleetIndex()
        table.clear(fleetBuffers)
        fleetCount = 0
        fleetReady = false
    end

    local function buildFleetIndex()
        if fleetReady then return true end
        releaseFleetIndex()
        fleetBuffers[1] = buffer.create(EXPECTED_FLEET_COUNT)
        fleetBuffers[2] = buffer.create(EXPECTED_FLEET_COUNT)
        fleetBuffers[3] = buffer.create(EXPECTED_FLEET_COUNT)
        fleetBuffers[4] = buffer.create(EXPECTED_FLEET_COUNT * 4)
        fleetBuffers[5] = buffer.create(EXPECTED_FLEET_COUNT * 4)

        local p1List, p2List, p3List = placements[1], placements[2], placements[3]
        local sliceStarted = os.clock()
        for p1i, p1 in ipairs(p1List) do
            for p2i, p2 in ipairs(p2List) do
                if not masksOverlap(p1.lo, p1.hi, p2.lo, p2.hi) then
                    local lo12 = bit.bor(p1.lo, p2.lo)
                    local hi12 = bit.bor(p1.hi, p2.hi)
                    for p3i, p3 in ipairs(p3List) do
                        if not masksOverlap(lo12, hi12, p3.lo, p3.hi) then
                            fleetCount += 1
                            if fleetCount > EXPECTED_FLEET_COUNT then
                                releaseFleetIndex()
                                return false
                            end
                            local oneByteOffset = fleetCount - 1
                            local fourByteOffset = oneByteOffset * 4
                            buffer.writeu8(fleetBuffers[1], oneByteOffset, p1i)
                            buffer.writeu8(fleetBuffers[2], oneByteOffset, p2i)
                            buffer.writeu8(fleetBuffers[3], oneByteOffset, p3i)
                            buffer.writeu32(fleetBuffers[4], fourByteOffset, bit.bor(lo12, p3.lo))
                            buffer.writeu32(fleetBuffers[5], fourByteOffset, bit.bor(hi12, p3.hi))
                        end
                    end
                end
                if os.clock() - sliceStarted >= 0.004 then
                    if controller.destroyed then
                        releaseFleetIndex()
                        return false
                    end
                    task.wait()
                    sliceStarted = os.clock()
                end
            end
        end
        fleetReady = fleetCount == EXPECTED_FLEET_COUNT
        if not fleetReady then releaseFleetIndex() end
        return fleetReady
    end


    local function newBattleProfile()
        local p = {
            completedFleets = 0,
            exactFleetCounts = {},
            shipPlacementCounts = {
                {}, {}, {},
            },

            gamesObserved = 0,
            shotSamples = 0,
            cellShots = table.create(64, 0),
            firstShots = table.create(64, 0),
            earlyShots = table.create(64, 0),


            afterHitDelta = {},
            afterMissDelta = {},

            recentOurFleets = {},
            lastOurFleetKey = nil,
            lastOurFleetLo = nil,
            lastOurFleetHi = nil,
            lastOurP1 = nil,
            lastOurP2 = nil,
            lastOurP3 = nil,
        }

        for i = 1, 64 do
            p.cellShots[i] = 0
            p.firstShots[i] = 0
            p.earlyShots[i] = 0
        end

        return p
    end

    local BATTLE_LEARNING_PATH = "TuffHub_BattleshipLearning_v1.json"
    local battleModel =
        rawget(_G, "__TSUNAMI_BATTLESHIP_EXACT_V12")
        or rawget(_G, "__TSUNAMI_BATTLESHIP_EXACT_V11")
        or rawget(_G, "__TSUNAMI_BATTLESHIP_EXACT_V9")

    if type(battleModel) ~= "table" then
        local readfileFn = envFunction("readfile")
        local isfileFn = envFunction("isfile")
        if readfileFn and isfileFn then
            local okExists, exists = pcall(isfileFn, BATTLE_LEARNING_PATH)
            if okExists and exists then
                local okRead, body = pcall(readfileFn, BATTLE_LEARNING_PATH)
                if okRead and type(body) == "string" then
                    local okDecode, decoded = pcall(HttpService.JSONDecode, HttpService, body)
                    if okDecode and type(decoded) == "table" then battleModel = decoded end
                end
            end
        end
    end

    if type(battleModel) ~= "table" then battleModel = { profiles = {}, global = newBattleProfile() } end
    rawset(_G, "__TSUNAMI_BATTLESHIP_EXACT_V12", battleModel)
    if type(battleModel.profiles) ~= "table" then battleModel.profiles = {} end

    local function ensureBattleProfile(profile)
        if type(profile) ~= "table" then profile = newBattleProfile() end
        profile.exactFleetCounts = type(profile.exactFleetCounts) == "table" and profile.exactFleetCounts or {}
        profile.shipPlacementCounts = type(profile.shipPlacementCounts) == "table" and profile.shipPlacementCounts or {{}, {}, {}}
        for i = 1, 3 do
            local source = type(profile.shipPlacementCounts[i]) == "table" and profile.shipPlacementCounts[i] or {}
            local normalized = {}
            for placementIndex, count in pairs(source) do
                local numericIndex = tonumber(placementIndex)
                if numericIndex then normalized[numericIndex] = tonumber(count) or 0 end
            end
            profile.shipPlacementCounts[i] = normalized
        end
        profile.cellShots = type(profile.cellShots) == "table" and profile.cellShots or table.create(64, 0)
        profile.firstShots = type(profile.firstShots) == "table" and profile.firstShots or table.create(64, 0)
        profile.earlyShots = type(profile.earlyShots) == "table" and profile.earlyShots or table.create(64, 0)
        for i = 1, 64 do
            profile.cellShots[i] = tonumber(profile.cellShots[i]) or 0
            profile.firstShots[i] = tonumber(profile.firstShots[i]) or 0
            profile.earlyShots[i] = tonumber(profile.earlyShots[i]) or 0
        end
        profile.afterHitDelta = type(profile.afterHitDelta) == "table" and profile.afterHitDelta or {}
        profile.afterMissDelta = type(profile.afterMissDelta) == "table" and profile.afterMissDelta or {}
        profile.recentOurFleets = type(profile.recentOurFleets) == "table" and profile.recentOurFleets or {}
        while #profile.recentOurFleets > 24 do table.remove(profile.recentOurFleets, 1) end
        profile.completedFleets = tonumber(profile.completedFleets) or 0
        profile.gamesObserved = tonumber(profile.gamesObserved) or 0
        profile.shotSamples = tonumber(profile.shotSamples) or 0
        profile.lastSeen = tonumber(profile.lastSeen) or 0
        return profile
    end

    battleModel.global = ensureBattleProfile(battleModel.global)
    for key, profile in pairs(battleModel.profiles) do battleModel.profiles[key] = ensureBattleProfile(profile) end

    local battleDirty = false
    local lastBattleSave = 0
    local function pruneBattleProfiles()
        local entries = {}
        for key, profile in pairs(battleModel.profiles) do entries[#entries + 1] = { key = key, lastSeen = tonumber(profile.lastSeen) or 0 } end
        if #entries <= 48 then return end
        table.sort(entries, function(a, b) return a.lastSeen > b.lastSeen end)
        for i = 49, #entries do battleModel.profiles[entries[i].key] = nil end
    end
    local function pruneFleetHistory(profile)
        local entries = {}
        for key, count in pairs(profile.exactFleetCounts) do entries[#entries + 1] = { key = key, count = tonumber(count) or 0 } end
        if #entries <= 128 then return end
        table.sort(entries, function(a, b) return a.count > b.count end)
        local keep = {}
        for i = 1, 128 do keep[entries[i].key] = entries[i].count end
        profile.exactFleetCounts = keep
    end
    local function saveBattleLearning(force)
        if not battleDirty then return end
        local now = os.clock()
        if not force and now - lastBattleSave < 0.85 then return end
        local writefileFn = envFunction("writefile")
        if not writefileFn then return end
        pruneBattleProfiles()
        pruneFleetHistory(battleModel.global)
        for _, profile in pairs(battleModel.profiles) do pruneFleetHistory(profile) end
        local okEncode, body = pcall(HttpService.JSONEncode, HttpService, battleModel)
        if okEncode and type(body) == "string" then
            local okWrite = pcall(writefileFn, BATTLE_LEARNING_PATH, body)
            if okWrite then battleDirty = false; lastBattleSave = now end
        end
    end

    local function opponentKey()
        local opponent =
            tryIndex({ "session", "private", "opponent" })

        if typeof(opponent) == "Instance"
            and opponent:IsA("Player")
        then
            return "uid:" .. tostring(opponent.UserId)
        end

        return "obj:" .. tostring(opponent or "unknown")
    end

    local function profileForOpponent()
        local key = opponentKey()
        local profile = battleModel.profiles[key]

        if type(profile) ~= "table" then
            profile = newBattleProfile()
            battleModel.profiles[key] = profile
            battleDirty = true
        else
            profile = ensureBattleProfile(profile)
            battleModel.profiles[key] = profile
        end
        profile.lastSeen = os.time()
        return profile
    end

    local function fleetKey(p1, p2, p3)
        return tostring(p1)
            .. ":"
            .. tostring(p2)
            .. ":"
            .. tostring(p3)
    end

    local function fleetStructureStats(p1, p2, p3)
        local horizontalCount = 0
        local edgeShips = 0
        local occupiedOwner = {}
        local adjacency = 0
        local nearParallel = 0

        for shipIndex = 1, 3 do
            local placementIndex =
                shipIndex == 1 and p1
                or shipIndex == 2 and p2
                or p3
            local placement =
                placements[shipIndex][placementIndex]

            if placement.horizontal then
                horizontalCount += 1
            end

            local touchesEdge = false
            for _, cell in ipairs(placement.cells) do
                occupiedOwner[cell.index] = shipIndex

                if cell.row == 1
                    or cell.row == GRID_SIZE
                    or cell.col == 1
                    or cell.col == GRID_SIZE
                then
                    touchesEdge = true
                end
            end

            if touchesEdge then
                edgeShips += 1
            end
        end

        for idx, owner in pairs(occupiedOwner) do
            local r, c = indexToRowCol(idx)

            for _, d in ipairs({
                { 1, 0 },
                { 0, 1 },
            }) do
                local rr = r + d[1]
                local cc = c + d[2]

                if rr <= GRID_SIZE and cc <= GRID_SIZE then
                    local other =
                        occupiedOwner[cellIndex(rr, cc)]

                    if other and other ~= owner then
                        adjacency += 1
                    end
                end
            end
        end

        for a = 1, 2 do
            local paIndex =
                a == 1 and p1
                or a == 2 and p2
                or p3
            local pa = placements[a][paIndex]

            for b = a + 1, 3 do
                local pbIndex =
                    b == 1 and p1
                    or b == 2 and p2
                    or p3
                local pb = placements[b][pbIndex]

                if pa.horizontal == pb.horizontal then
                    if pa.horizontal then
                        local rowA = pa.cells[1].row
                        local rowB = pb.cells[1].row

                        if math.abs(rowA - rowB) <= 1 then
                            local minA = pa.cells[1].col
                            local maxA = pa.cells[#pa.cells].col
                            local minB = pb.cells[1].col
                            local maxB = pb.cells[#pb.cells].col

                            if math.max(minA, minB)
                                <= math.min(maxA, maxB) + 1
                            then
                                nearParallel += 1
                            end
                        end
                    else
                        local colA = pa.cells[1].col
                        local colB = pb.cells[1].col

                        if math.abs(colA - colB) <= 1 then
                            local minA = pa.cells[1].row
                            local maxA = pa.cells[#pa.cells].row
                            local minB = pb.cells[1].row
                            local maxB = pb.cells[#pb.cells].row

                            if math.max(minA, minB)
                                <= math.min(maxA, maxB) + 1
                            then
                                nearParallel += 1
                            end
                        end
                    end
                end
            end
        end

        return
            horizontalCount,
            edgeShips,
            adjacency,
            nearParallel
    end

    local function fleetPriorWeight(profile, p1, p2, p3)
        local specificCompleted =
            tonumber(profile.completedFleets) or 0
        local globalCompleted =
            tonumber(battleModel.global.completedFleets) or 0

        local key = fleetKey(p1, p2, p3)
        local specificExact =
            tonumber(profile.exactFleetCounts[key]) or 0
        local globalExact =
            tonumber(
                battleModel.global.exactFleetCounts[key]
            ) or 0

        local weight =
            1
            + specificExact * 18
            + globalExact * 1.15

        for shipIndex = 1, 3 do
            local possible = #placements[shipIndex]
            local placementIndex =
                shipIndex == 1 and p1
                or shipIndex == 2 and p2
                or p3

            if specificCompleted > 0 then
                local count =
                    tonumber(
                        profile.shipPlacementCounts[shipIndex][
                            placementIndex
                        ]
                    ) or 0

                local normalized =
                    (count + 0.65)
                    / (specificCompleted + 0.65 * possible)
                    * possible

                weight *=
                    math.max(0.12, normalized) ^ 0.58
            end

            if globalCompleted > 0 then
                local count =
                    tonumber(
                        battleModel.global.shipPlacementCounts[
                            shipIndex
                        ][placementIndex]
                    ) or 0

                local normalized =
                    (count + 0.80)
                    / (globalCompleted + 0.80 * possible)
                    * possible

                weight *=
                    math.max(0.25, normalized) ^ 0.10
            end
        end

        return math.clamp(weight, 0.015, 350)
    end

    local function recordCompletedOpponentFleet(
        profile,
        opponentSeat,
        sessionKey
    )
        if not profile then return end
        if profile._lastCompletedSession == sessionKey then
            return
        end

        local details =
            tryIndex({
                "session",
                "public",
                "sunkShipDetails",
                opponentSeat,
            })

        if details == nil then return end

        local exact = {}
        pcall(function()
            for _, detail in details do
                local shipIndex = tonumber(detail.shipIndex)
                if shipIndex
                    and shipIndex >= 1
                    and shipIndex <= 3
                    and detail.cells
                then
                    local lo, hi = cellsMask(detail.cells)
                    exact[shipIndex] =
                        placementIndexByMask[shipIndex][
                            maskKey(lo, hi)
                        ]
                end
            end
        end)

        if not (exact[1] and exact[2] and exact[3]) then
            return
        end

        local function record(target, scale)
            target.completedFleets =
                (tonumber(target.completedFleets) or 0)
                + scale

            local key =
                fleetKey(exact[1], exact[2], exact[3])

            target.exactFleetCounts[key] =
                (tonumber(target.exactFleetCounts[key]) or 0)
                + scale

            for shipIndex = 1, 3 do
                local counts =
                    target.shipPlacementCounts[shipIndex]
                local idx = exact[shipIndex]
                counts[idx] =
                    (tonumber(counts[idx]) or 0)
                    + scale
            end
        end

        record(profile, 1)
        record(battleModel.global, 0.18)
        battleDirty = true

        profile._lastCompletedSession = sessionKey
    end

    local function myShips()
        return tryIndex({ "session", "private", "myShips" })
    end

    local function shipIsPlaced(index)
        return safeIndex(myShips(), index) ~= nil
    end

    local function ownFleetOccupancyMask()
        local lo, hi = 0, 0
        local ships = myShips()

        if ships ~= nil then
            pcall(function()
                for _, ship in ships do
                    local sLo, sHi = cellsMask(ship.cells)
                    lo = bit.bor(lo, sLo)
                    hi = bit.bor(hi, sHi)
                end
            end)
        end

        return lo, hi
    end

    local function ownShootGrid(mine)
        local tableModel =
            tryIndex({ "session", "public", "tableModel" })

        if typeof(tableModel) ~= "Instance" then
            return nil
        end

        local board =
            tableModel:FindFirstChild(
                "BattleshipBoard" .. tostring(mine)
            )
        local grids = board and board:FindFirstChild("Grids")
        local shoot = grids and grids:FindFirstChild("Shoot")

        if not shoot then return nil end

        local ok, result = pcall(resolveGrid, shoot)
        return ok and result or nil
    end

    local function shotValueToHit(value)
        if type(value) == "boolean" then
            return value
        end

        if type(value) == "string" then
            local lower = string.lower(value)

            if string.find(lower, "hit", 1, true) then
                return true
            end
            if string.find(lower, "miss", 1, true) then
                return false
            end
        end

        if value ~= nil then
            for _, field in ipairs({
                "hit",
                "isHit",
                "IsHit",
            }) do
                local v = safeIndex(value, field)
                if type(v) == "boolean" then
                    return v
                end
            end

            local result =
                safeIndex(value, "result")
                or safeIndex(value, "response")

            if type(result) == "string" then
                local lower = string.lower(result)

                if string.find(lower, "hit", 1, true) then
                    return true
                end
                if string.find(lower, "miss", 1, true) then
                    return false
                end
            end
        end

        return nil
    end

    local function pegHitAt(grid, r, c)
        local cell =
            grid
            and grid.cells[r]
            and grid.cells[r][c]

        if not cell then return nil end

        for _, desc in ipairs(cell:GetDescendants()) do
            if CollectionService:HasTag(
                desc,
                "BattleshipPeg"
            ) then
                local value =
                    desc:GetAttribute("IsHit")

                if type(value) == "boolean" then
                    return value
                end
            end
        end

        return nil
    end

    local localShotOutcomeCache = {}

    local posteriorCache = {
        valid = nil,
        hitLo = 0,
        hitHi = 0,
        missLo = 0,
        missHi = 0,
        sunkPlacement = {},
    }

    local function resetPosteriorCache()
        posteriorCache.valid = nil
        posteriorCache.hitLo = 0
        posteriorCache.hitHi = 0
        posteriorCache.missLo = 0
        posteriorCache.missHi = 0
        posteriorCache.sunkPlacement = {}
    end

    local function cacheCanFilter(knowledge)
        if posteriorCache.valid == nil then
            return false
        end

        if not maskContainsAll(
            knowledge.hitLo,
            knowledge.hitHi,
            posteriorCache.hitLo,
            posteriorCache.hitHi
        ) then
            return false
        end

        if not maskContainsAll(
            knowledge.missLo,
            knowledge.missHi,
            posteriorCache.missLo,
            posteriorCache.missHi
        ) then
            return false
        end

        for shipIndex = 1, 3 do
            local old =
                posteriorCache.sunkPlacement[shipIndex]

            if old
                and knowledge.sunkPlacement[shipIndex] ~= old
            then
                return false
            end
        end

        return true
    end

    local function addMaskCell(lo, hi, index)
        local bLo, bHi = cellBit(index)
        return bit.bor(lo, bLo), bit.bor(hi, bHi)
    end

    local function collectShotKnowledge(mine, opponent)
        local shotMap =
            tryIndex({
                "session",
                "public",
                "shots",
                mine,
            })

        local grid = ownShootGrid(mine)

        local firedLo, firedHi = 0, 0
        local hitLo, hitHi = 0, 0
        local missLo, missHi = 0, 0

        local firedSet = {}
        local hitSet = {}
        local missSet = {}

        for r = 1, GRID_SIZE do
            for c = 1, GRID_SIZE do
                local key = coordKey(r, c)
                local value = safeIndex(shotMap, key)

                if value ~= nil then
                    local idx = cellIndex(r, c)
                    firedSet[idx] = true
                    firedLo, firedHi =
                        addMaskCell(firedLo, firedHi, idx)

                    local hit =
                        localShotOutcomeCache[key]

                    if hit == nil then
                        hit = shotValueToHit(value)
                    end
                    if hit == nil then
                        hit = pegHitAt(grid, r, c)
                    end

                    if hit == true then
                        hitSet[idx] = true
                        hitLo, hitHi =
                            addMaskCell(hitLo, hitHi, idx)
                    elseif hit == false then
                        missSet[idx] = true
                        missLo, missHi =
                            addMaskCell(missLo, missHi, idx)
                    end
                end
            end
        end

        local sunkPlacement = {}
        local sunkCells = {}

        local details =
            tryIndex({
                "session",
                "public",
                "sunkShipDetails",
                opponent,
            })

        if details ~= nil then
            pcall(function()
                for _, detail in details do
                    local shipIndex =
                        tonumber(detail.shipIndex)

                    if shipIndex
                        and detail.cells
                    then
                        local sLo, sHi =
                            cellsMask(detail.cells)

                        sunkPlacement[shipIndex] =
                            placementIndexByMask[shipIndex][
                                maskKey(sLo, sHi)
                            ]

                        for _, cell in detail.cells do
                            local idx =
                                cellIndex(
                                    tonumber(cell.row),
                                    tonumber(cell.col)
                                )
                            sunkCells[idx] = true
                            firedSet[idx] = true
                            hitSet[idx] = true

                            firedLo, firedHi =
                                addMaskCell(
                                    firedLo,
                                    firedHi,
                                    idx
                                )
                            hitLo, hitHi =
                                addMaskCell(
                                    hitLo,
                                    hitHi,
                                    idx
                                )
                        end
                    end
                end
            end)
        end

        return {
            firedLo = firedLo,
            firedHi = firedHi,
            hitLo = hitLo,
            hitHi = hitHi,
            missLo = missLo,
            missHi = missHi,
            firedSet = firedSet,
            hitSet = hitSet,
            missSet = missSet,
            sunkPlacement = sunkPlacement,
            sunkCells = sunkCells,
        }
    end

    local function fleetMatchesKnowledge(i, knowledge)
        local lo = fleetAt(4, i)
        local hi = fleetAt(5, i)

        if masksOverlap(
            lo, hi,
            knowledge.missLo,
            knowledge.missHi
        ) then
            return false
        end

        if not maskContainsAll(
            lo, hi,
            knowledge.hitLo,
            knowledge.hitHi
        ) then
            return false
        end

        local sunk = knowledge.sunkPlacement

        if sunk[1] and fleetAt(1, i) ~= sunk[1] then
            return false
        end
        if sunk[2] and fleetAt(2, i) ~= sunk[2] then
            return false
        end
        if sunk[3] and fleetAt(3, i) ~= sunk[3] then
            return false
        end

        return true
    end

    local function remainingUnhitCell(
        placement,
        knowledge
    )
        local remaining = nil
        local count = 0

        for _, cell in ipairs(placement.cells) do
            if not knowledge.hitSet[cell.index] then
                count += 1
                remaining = cell.index
                if count > 1 then
                    return nil
                end
            end
        end

        if count == 1 then
            return remaining
        end

        return nil
    end

    local function posteriorSummary(
        knowledge,
        profile
    )
        local valid = {}
        local occ = table.create(64, 0)
        local sink = table.create(64, 0)
        local targetOcc = table.create(64, 0)

        for i = 1, 64 do
            occ[i] = 0
            sink[i] = 0
            targetOcc[i] = 0
        end

        local unresolvedHitLo, unresolvedHitHi = 0, 0
        local unresolvedHitCount = 0

        for idx in pairs(knowledge.hitSet) do
            if not knowledge.sunkCells[idx] then
                unresolvedHitCount += 1
                unresolvedHitLo, unresolvedHitHi =
                    addMaskCell(
                        unresolvedHitLo,
                        unresolvedHitHi,
                        idx
                    )
            end
        end

        local totalWeight = 0
        local validCount = 0
        local canFilter = cacheCanFilter(knowledge)

        local function accumulatePlacement(
            shipIndex,
            pIndex,
            weight
        )
            local placement =
                placements[shipIndex][pIndex]
            local isSunk =
                knowledge.sunkPlacement[shipIndex]
                    ~= nil

            local connectsToLiveHit =
                not isSunk
                and unresolvedHitCount > 0
                and masksOverlap(
                    placement.lo,
                    placement.hi,
                    unresolvedHitLo,
                    unresolvedHitHi
                )

            for _, cell in ipairs(placement.cells) do
                if not knowledge.firedSet[cell.index] then
                    occ[cell.index] += weight

                    if connectsToLiveHit then
                        targetOcc[cell.index] += weight
                    end
                end
            end

            if not isSunk then
                local cell =
                    remainingUnhitCell(
                        placement,
                        knowledge
                    )

                if cell
                    and not knowledge.firedSet[cell]
                then
                    sink[cell] += weight
                end
            end
        end

        local function processFleet(i)
            if not fleetMatchesKnowledge(i, knowledge) then
                return
            end

            local p1 = fleetAt(1, i)
            local p2 = fleetAt(2, i)
            local p3 = fleetAt(3, i)

            local weight =
                fleetPriorWeight(
                    profile,
                    p1,
                    p2,
                    p3
                )

            validCount += 1
            valid[validCount] = i
            totalWeight += weight

            accumulatePlacement(1, p1, weight)
            accumulatePlacement(2, p2, weight)
            accumulatePlacement(3, p3, weight)
        end

        if canFilter then
            local source = posteriorCache.valid

            for n = 1, #source do
                processFleet(source[n])

                if n % 50000 == 0 then
                    task.wait()
                end
            end
        else
            for i = 1, fleetCount do
                processFleet(i)

                if i % 60000 == 0 then
                    task.wait()
                end
            end
        end

        posteriorCache.valid = valid
        posteriorCache.hitLo = knowledge.hitLo
        posteriorCache.hitHi = knowledge.hitHi
        posteriorCache.missLo = knowledge.missLo
        posteriorCache.missHi = knowledge.missHi
        posteriorCache.sunkPlacement = {
            knowledge.sunkPlacement[1],
            knowledge.sunkPlacement[2],
            knowledge.sunkPlacement[3],
        }

        return {
            valid = valid,
            count = validCount,
            totalWeight = totalWeight,
            occ = occ,
            sink = sink,
            targetOcc = targetOcc,
            unresolvedHitCount = unresolvedHitCount,
        }
    end

    local function binaryEntropy(p)
        if p <= 1e-12 or p >= 1 - 1e-12 then
            return 0
        end

        return
            -p * math.log(p)
            - (1 - p) * math.log(1 - p)
    end

    local function chooseExactShot(
        knowledge,
        profile
    )
        local summary =
            posteriorSummary(
                knowledge,
                profile
            )

        if summary.count <= 0
            or summary.totalWeight <= 0
        then
            local bestExposure = -math.huge
            local fallback = {}

            for idx = 1, 64 do
                if not knowledge.firedSet[idx] then
                    local value = cellExposure[idx]

                    if value > bestExposure then
                        bestExposure = value
                        table.clear(fallback)
                        fallback[1] = idx
                    elseif value == bestExposure then
                        fallback[#fallback + 1] = idx
                    end
                end
            end

            if #fallback == 0 then return nil end

            local idx =
                fallback[
                    rng:NextInteger(1, #fallback)
                ]
            local r, c = indexToRowCol(idx)
            return { row = r, col = c }
        end

        local targetMode =
            summary.unresolvedHitCount > 0
        local ranked = {}

        for idx = 1, 64 do
            if not knowledge.firedSet[idx] then
                ranked[#ranked + 1] = {
                    idx = idx,
                    p =
                        summary.occ[idx]
                        / summary.totalWeight,
                    sinkP =
                        summary.sink[idx]
                        / summary.totalWeight,
                    targetP =
                        summary.targetOcc[idx]
                        / summary.totalWeight,
                }
            end
        end

        if #ranked == 0 then return nil end

        table.sort(ranked, function(a, b)
            if targetMode
                and math.abs(a.targetP - b.targetP) > 1e-12
            then
                return a.targetP > b.targetP
            end

            if math.abs(a.p - b.p) > 1e-12 then
                return a.p > b.p
            end

            if math.abs(a.sinkP - b.sinkP) > 1e-12 then
                return a.sinkP > b.sinkP
            end

            return a.idx < b.idx
        end)




        if not targetMode then
            local bestObjective = -math.huge
            local best = {}

            for rank = 1, math.min(12, #ranked) do
                local item = ranked[rank]
                local information =
                    binaryEntropy(item.p)

                local objective =
                    item.p
                    + item.sinkP * 0.025
                    + information * 0.0025

                if objective > bestObjective + 1e-11 then
                    bestObjective = objective
                    table.clear(best)
                    best[1] = item.idx
                elseif
                    math.abs(objective - bestObjective) <= 1e-11
                then
                    best[#best + 1] = item.idx
                end
            end

            local chosen =
                best[
                    rng:NextInteger(1, #best)
                ]

            local row, col = indexToRowCol(chosen)
            return { row = row, col = col }
        end





        local candidate = {}
        local seen = {}

        for _, item in ipairs(ranked) do
            if item.targetP > 0 then
                candidate[#candidate + 1] = item
                seen[item.idx] = true

                if #candidate >= 12 then
                    break
                end
            end
        end

        for _, item in ipairs(ranked) do
            if #candidate >= 12 then break end

            if not seen[item.idx] then
                candidate[#candidate + 1] = item
                seen[item.idx] = true
            end
        end

        local N = #candidate

        if N == 0 then
            local row, col =
                indexToRowCol(ranked[1].idx)
            return { row = row, col = col }
        end

        local singletonWeight = {}

        for rank = 1, N do
            singletonWeight[rank] =
                summary.occ[
                    candidate[rank].idx
                ]
        end



        local subsetWeight = {}

        local function addPresentSubsets(
            presentRanks,
            weight
        )
            local count = #presentRanks

            if count < 2 then
                return
            end

            local function rec(
                startAt,
                remaining,
                mask
            )
                if remaining == 0 then
                    subsetWeight[mask] =
                        (subsetWeight[mask] or 0)
                        + weight
                    return
                end

                local maxStart =
                    count - remaining + 1

                for pos = startAt, maxStart do
                    local rank = presentRanks[pos]
                    rec(
                        pos + 1,
                        remaining - 1,
                        bit.bor(
                            mask,
                            bit.lshift(1, rank - 1)
                        )
                    )
                end
            end

            for size = 2, math.min(5, count) do
                rec(1, size, 0)
            end
        end

        for n = 1, summary.count do
            local fleetIndex =
                summary.valid[n]

            local weight =
                fleetPriorWeight(
                    profile,
                    fleetAt(1, fleetIndex),
                    fleetAt(2, fleetIndex),
                    fleetAt(3, fleetIndex)
                )

            local present = {}

            for rank = 1, N do
                local idx =
                    candidate[rank].idx

                if maskHas(
                    fleetAt(4, fleetIndex),
                    fleetAt(5, fleetIndex),
                    idx
                ) then
                    present[#present + 1] = rank
                end
            end

            addPresentSubsets(
                present,
                weight
            )

            if n % 35000 == 0 then
                task.wait()
            end
        end

        local function jointWeight(mask)
            if bit.band(mask, mask - 1) == 0 then
                for rank = 1, N do
                    if bit.band(
                        mask,
                        bit.lshift(1, rank - 1)
                    ) ~= 0
                    then
                        return singletonWeight[rank] or 0
                    end
                end

                return 0
            end

            return subsetWeight[mask] or 0
        end

        local continuationMemo = {}

        local function bestContinuation(
            mask,
            depth
        )
            if depth <= 0 then
                return 0
            end

            local memoKey =
                tostring(mask)
                .. ":"
                .. tostring(depth)

            local cached =
                continuationMemo[memoKey]

            if cached ~= nil then
                return cached
            end

            local best = 0

            for rank = 1, N do
                local bitValue =
                    bit.lshift(1, rank - 1)

                if bit.band(mask, bitValue) == 0 then
                    local nextMask =
                        bit.bor(mask, bitValue)
                    local weight =
                        jointWeight(nextMask)

                    if weight > 0 then
                        local value =
                            weight
                            + bestContinuation(
                                nextMask,
                                depth - 1
                            )

                        if value > best then
                            best = value
                        end
                    end
                end
            end

            continuationMemo[memoKey] = best
            return best
        end

        local bestObjective = -math.huge
        local bestSink = -math.huge
        local choices = {}

        for rank = 1, N do
            local item = candidate[rank]
            local firstWeight =
                singletonWeight[rank] or 0
            local firstMask =
                bit.lshift(1, rank - 1)

            local chainWeight =
                firstWeight
                + bestContinuation(
                    firstMask,
                    4
                )

            local chainValue =
                chainWeight
                / summary.totalWeight
            local information =
                binaryEntropy(item.p)

            local objective =
                chainValue
                + item.sinkP * 0.085
                + item.targetP * 0.035
                + information * 0.003

            if objective > bestObjective + 1e-10
                or (
                    math.abs(objective - bestObjective) <= 1e-10
                    and item.sinkP > bestSink + 1e-10
                )
            then
                bestObjective = objective
                bestSink = item.sinkP
                table.clear(choices)
                choices[1] = item.idx
            elseif
                math.abs(objective - bestObjective) <= 1e-10
                and math.abs(item.sinkP - bestSink) <= 1e-10
            then
                choices[#choices + 1] = item.idx
            end
        end

        if #choices == 0 then
            choices[1] =
                candidate[1].idx
        end

        local chosen =
            choices[
                rng:NextInteger(1, #choices)
            ]

        local row, col =
            indexToRowCol(chosen)

        return {
            row = row,
            col = col,
        }
    end

    local function deltaKey(dr, dc)
        return tostring(dr) .. "," .. tostring(dc)
    end

    local function addShotObservation(
        profile,
        idx,
        order,
        previousIdx,
        previousWasHit,
        scale
    )
        if not profile then return end
        scale = scale or 1

        profile.shotSamples =
            (tonumber(profile.shotSamples) or 0)
            + scale
        battleDirty = true
        profile.cellShots[idx] =
            (tonumber(profile.cellShots[idx]) or 0)
            + scale

        if order == 1 then
            profile.firstShots[idx] =
                (tonumber(profile.firstShots[idx]) or 0)
                + scale
        end

        profile.earlyShots[idx] =
            (tonumber(profile.earlyShots[idx]) or 0)
            + scale
                * math.exp(-0.16 * math.max(0, order - 1))

        if previousIdx then
            local pr, pc = indexToRowCol(previousIdx)
            local r, c = indexToRowCol(idx)
            local dr = math.clamp(r - pr, -2, 2)
            local dc = math.clamp(c - pc, -2, 2)
            local key = deltaKey(dr, dc)

            local bucket =
                previousWasHit
                and profile.afterHitDelta
                or profile.afterMissDelta

            bucket[key] =
                (tonumber(bucket[key]) or 0)
                + scale
        end
    end

    local function shotMapIndices(seat)
        local map =
            tryIndex({
                "session",
                "public",
                "shots",
                seat,
            })

        local out = {}

        for r = 1, GRID_SIZE do
            for c = 1, GRID_SIZE do
                if safeIndex(
                    map,
                    coordKey(r, c)
                ) ~= nil
                then
                    out[#out + 1] =
                        cellIndex(r, c)
                end
            end
        end

        return out
    end

    local observedOpponentShots = {}
    local opponentShotOrder = 0
    local previousOpponentShot = nil
    local previousOpponentWasHit = nil

    local function seedExistingOpponentShots(opponent)
        table.clear(observedOpponentShots)

        local current =
            shotMapIndices(opponent)

        for _, idx in ipairs(current) do
            observedOpponentShots[idx] = true
        end

        opponentShotOrder = #current
        previousOpponentShot = nil
        previousOpponentWasHit = nil
    end

    local function observeOpponentShots(
        opponent,
        profile
    )
        local current =
            shotMapIndices(opponent)

        local new = {}

        for _, idx in ipairs(current) do
            if not observedOpponentShots[idx] then
                new[#new + 1] = idx
            end
        end

        if #new == 0 then return end




        if #new > 1 then
            for _, idx in ipairs(new) do
                observedOpponentShots[idx] = true
            end
            opponentShotOrder += #new
            previousOpponentShot = nil
            previousOpponentWasHit = nil
            return
        end

        local idx = new[1]
        observedOpponentShots[idx] = true
        opponentShotOrder += 1

        local ownLo, ownHi =
            ownFleetOccupancyMask()
        local wasHit =
            maskHas(ownLo, ownHi, idx)

        addShotObservation(
            profile,
            idx,
            opponentShotOrder,
            previousOpponentShot,
            previousOpponentWasHit,
            1
        )
        addShotObservation(
            battleModel.global,
            idx,
            opponentShotOrder,
            previousOpponentShot,
            previousOpponentWasHit,
            0.18
        )

        previousOpponentShot = idx
        previousOpponentWasHit = wasHit
    end

    local function fleetDefensiveScore(
        profile,
        p1,
        p2,
        p3,
        fleetIndex
    )
        local evidence =
            tonumber(profile.shotSamples) or 0
        local globalEvidence =
            tonumber(battleModel.global.shotSamples) or 0

        local trust =
            math.clamp(evidence / 22, 0, 1)

        local score = 0
        local placementIndexes = {
            p1, p2, p3,
        }

        local occupiedOwner = {}

        local horizontalCount,
            edgeShips,
            adjacencyCount,
            nearParallelCount =
                fleetStructureStats(
                    p1,
                    p2,
                    p3
                )




        if horizontalCount == 0
            or horizontalCount == 3
        then
            score += (1 - trust) * 2.8
        else
            score -= (1 - trust) * 0.18
        end




        score -=
            edgeShips
            * (1 - trust)
            * 0.16



        score += adjacencyCount * 1.45
        score += nearParallelCount * 0.72

        for shipIndex = 1, 3 do
            local placement =
                placements[shipIndex][
                    placementIndexes[shipIndex]
                ]

            for _, cell in ipairs(placement.cells) do
                local idx = cell.index





                local generic =
                    cellExposure[idx] / maxExposure

                local specificCell =
                    (tonumber(profile.cellShots[idx]) or 0)
                    / math.max(1, evidence)
                local specificFirst =
                    (tonumber(profile.firstShots[idx]) or 0)
                    / math.max(1, profile.gamesObserved)
                local specificEarly =
                    tonumber(profile.earlyShots[idx]) or 0

                local globalCell =
                    (tonumber(
                        battleModel.global.cellShots[idx]
                    ) or 0)
                    / math.max(1, globalEvidence)

                local hazard =
                    generic * (1 - trust) * 1.35
                    + globalCell * (1 - trust) * 3.0
                    + specificCell * trust * 9.0
                    + specificFirst * trust * 3.5
                    + specificEarly
                        / math.max(1, evidence)
                        * trust
                        * 5.5

                score += hazard
                occupiedOwner[idx] = shipIndex
            end




            local horizontalFollow =
                (tonumber(
                    profile.afterHitDelta[
                        deltaKey(0, 1)
                    ]
                ) or 0)
                + (tonumber(
                    profile.afterHitDelta[
                        deltaKey(0, -1)
                    ]
                ) or 0)

            local verticalFollow =
                (tonumber(
                    profile.afterHitDelta[
                        deltaKey(1, 0)
                    ]
                ) or 0)
                + (tonumber(
                    profile.afterHitDelta[
                        deltaKey(-1, 0)
                    ]
                ) or 0)

            local followTotal =
                horizontalFollow + verticalFollow

            if followTotal > 0 then
                local orientationRisk =
                    placement.horizontal
                    and horizontalFollow / followTotal
                    or verticalFollow / followTotal

                score += orientationRisk * trust * 2.7
            end
        end



        for idx, owner in pairs(occupiedOwner) do
            local r, c = indexToRowCol(idx)

            for _, d in ipairs({
                { 1, 0 },
                { -1, 0 },
                { 0, 1 },
                { 0, -1 },
            }) do
                local rr = r + d[1]
                local cc = c + d[2]

                if rr >= 1 and rr <= GRID_SIZE
                    and cc >= 1 and cc <= GRID_SIZE
                then
                    local other =
                        occupiedOwner[
                            cellIndex(rr, cc)
                        ]

                    if other and other ~= owner then
                        score += 0.30
                    end
                end
            end
        end

        local key = fleetKey(p1, p2, p3)

        for i, recent in ipairs(profile.recentOurFleets) do
            if recent == key then
                local age =
                    #profile.recentOurFleets - i
                score +=
                    2.2 * math.exp(-0.34 * age)
            end
        end




        if profile.lastOurFleetLo ~= nil
            and profile.lastOurFleetHi ~= nil
        then
            local overlap =
                maskIntersectionCount(
                    fleetAt(4, fleetIndex),
                    fleetAt(5, fleetIndex),
                    profile.lastOurFleetLo,
                    profile.lastOurFleetHi
                )

            score += overlap * 0.20

            local sameShips = 0
            if p1 == profile.lastOurP1 then sameShips += 1 end
            if p2 == profile.lastOurP2 then sameShips += 1 end
            if p3 == profile.lastOurP3 then sameShips += 1 end

            score += sameShips * 0.95
        end

        return score, horizontalCount
    end

    local function generateDefensiveLayout(profile)
        local TOP_KEEP = 128
        local best = {}

        local horizontalFollow =
            (tonumber(
                profile.afterHitDelta[
                    deltaKey(0, 1)
                ]
            ) or 0)
            + (tonumber(
                profile.afterHitDelta[
                    deltaKey(0, -1)
                ]
            ) or 0)

        local verticalFollow =
            (tonumber(
                profile.afterHitDelta[
                    deltaKey(1, 0)
                ]
            ) or 0)
            + (tonumber(
                profile.afterHitDelta[
                    deltaKey(-1, 0)
                ]
            ) or 0)

        local followTotal =
            horizontalFollow + verticalFollow
        local directionalConfidence =
            followTotal > 0
            and math.abs(
                horizontalFollow - verticalFollow
            ) / followTotal
            or 0

        local allowAllParallel =
            (tonumber(profile.shotSamples) or 0) >= 18
            and followTotal >= 6
            and directionalConfidence >= 0.62

        local function insertCandidate(candidate)
            local inserted = false

            for i = 1, #best do
                if candidate.score < best[i].score then
                    table.insert(best, i, candidate)
                    inserted = true
                    break
                end
            end

            if not inserted then
                best[#best + 1] = candidate
            end

            if #best > TOP_KEEP then
                table.remove(best)
            end
        end

        for i = 1, fleetCount do
            local p1 = fleetAt(1, i)
            local p2 = fleetAt(2, i)
            local p3 = fleetAt(3, i)

            local score, horizontalCount =
                fleetDefensiveScore(
                    profile,
                    p1,
                    p2,
                    p3,
                    i
                )

            if allowAllParallel
                or horizontalCount == 1
                or horizontalCount == 2
            then
                insertCandidate({
                    fleetIndex = i,
                    p1 = p1,
                    p2 = p2,
                    p3 = p3,
                    horizontalCount = horizontalCount,
                    score = score,
                })
            end

            if i % 50000 == 0 then
                task.wait()
            end
        end

        if #best == 0 then return nil end

        local previousKey =
            profile.lastOurFleetKey
            or profile.recentOurFleets[
                #profile.recentOurFleets
            ]




        if previousKey ~= nil and #best > 1 then
            local filtered = {}

            for _, candidate in ipairs(best) do
                local candidateKey =
                    fleetKey(
                        candidate.p1,
                        candidate.p2,
                        candidate.p3
                    )

                if candidateKey ~= previousKey then
                    filtered[#filtered + 1] = candidate
                end
            end

            if #filtered > 0 then
                best = filtered
            end
        end

        local evidence =
            tonumber(profile.shotSamples) or 0



        local poolSize =
            math.min(
                #best,
                evidence >= 40 and 18
                    or evidence >= 16 and 32
                    or 64
            )

        local bestScore = best[1].score
        local temperature =
            evidence >= 40 and 0.16
                or evidence >= 16 and 0.28
                or 0.55

        local total = 0
        for i = 1, poolSize do
            local delta =
                math.max(0, best[i].score - bestScore)
            best[i].weight =
                math.exp(-delta / temperature)
            total += best[i].weight
        end

        local roll =
            rng:NextNumber() * math.max(total, 1e-9)
        local chosen = best[poolSize]

        for i = 1, poolSize do
            roll -= best[i].weight
            if roll <= 0 then
                chosen = best[i]
                break
            end
        end

        local key =
            fleetKey(
                chosen.p1,
                chosen.p2,
                chosen.p3
            )

        profile.recentOurFleets[
            #profile.recentOurFleets + 1
        ] = key

        while #profile.recentOurFleets > 24 do
            table.remove(profile.recentOurFleets, 1)
        end

        profile.lastOurFleetKey = key
        profile.lastOurFleetLo =
            fleetAt(4, chosen.fleetIndex)
        profile.lastOurFleetHi =
            fleetAt(5, chosen.fleetIndex)
        profile.lastOurP1 = chosen.p1
        profile.lastOurP2 = chosen.p2
        profile.lastOurP3 = chosen.p3
        battleDirty = true

        return {
            placements[1][chosen.p1].cells,
            placements[2][chosen.p2].cells,
            placements[3][chosen.p3].cells,
        }
    end

    local plannedLayout = nil
    local placementSession = nil
    local firingBusy = false
    local lastShotSignature = nil
    local currentGameKey = nil
    local currentMatchKey = nil
    local battleGameSerial = 0
    local previousBattlePhase = nil
    local activeProfile = nil

    local function shotSignature(seat)
        local map =
            tryIndex({
                "session",
                "public",
                "shots",
                seat,
            })

        local out = {}

        for r = 1, GRID_SIZE do
            for c = 1, GRID_SIZE do
                if safeIndex(
                    map,
                    coordKey(r, c)
                ) ~= nil
                then
                    out[#out + 1] =
                        tostring(r)
                        .. ","
                        .. tostring(c)
                end
            end
        end

        return table.concat(out, "|")
    end

    local function buildGameKey()
        local tableModel =
            tryIndex({ "session", "public", "tableModel" })

        return
            tostring(tableModel)
            .. ":"
            .. opponentKey()
    end

    local shotVFXConnection = nil

    pcall(function()
        shotVFXConnection =
            CollectionService:GetInstanceAddedSignal(
                "BattleshipShotVFX"
            ):Connect(function(instance)
                if controller.destroyed
                    or gameId() ~= "Battleship"
                then
                    return
                end

                local mine = seatIndex()
                if not mine or not minigameAutoplayEnabled("Battleship") then return end

                local grid = ownShootGrid(mine)
                if not grid or not grid.partToCoord then
                    return
                end

                local node = instance
                local coord = nil

                while node do
                    coord = grid.partToCoord[node]
                    if coord then break end
                    node = node.Parent
                end

                if not coord then return end

                task.spawn(function()
                    local deadline =
                        os.clock() + 0.12

                    repeat
                        local isHit =
                            instance:GetAttribute("IsHit")

                        if type(isHit) == "boolean" then
                            localShotOutcomeCache[
                                coordKey(
                                    coord.row,
                                    coord.col
                                )
                            ] = isHit
                            return
                        end

                        task.wait()
                    until os.clock() >= deadline
                        or controller.destroyed
                end)
            end)
    end)

    while not controller.destroyed do
        task.wait(gameId() == "Battleship" and 0.012 or 0.15)
        saveBattleLearning(false)

        if gameId() ~= "Battleship" then
            saveBattleLearning(true)
            if fleetReady then releaseFleetIndex() end
            plannedLayout = nil
            placementSession = nil
            firingBusy = false
            lastShotSignature = nil
            currentGameKey = nil
            currentMatchKey = nil
            previousBattlePhase = nil
            activeProfile = nil
            table.clear(localShotOutcomeCache)
            resetPosteriorCache()
            table.clear(observedOpponentShots)
            continue
        end

        if not minigameAutoplayEnabled("Battleship") then
            firingBusy = false
            lastShotSignature = nil
            continue
        end

        local mine = seatIndex()
        if not mine then continue end

        local opponent =
            mine == 1 and 2 or 1

        local phase = publicPhase()
        local matchKey = buildGameKey()





        local enteredPlacement =
            phase == "Placement"
            and previousBattlePhase ~= "Placement"

        local changedMatch =
            currentMatchKey ~= matchKey

        if changedMatch
            or currentGameKey == nil
            or enteredPlacement
        then
            battleGameSerial += 1
            currentMatchKey = matchKey
            currentGameKey =
                matchKey
                .. ":game:"
                .. tostring(battleGameSerial)
                .. ":"
                .. tostring(workspace:GetServerTimeNow())

            plannedLayout = nil
            placementSession = nil
            firingBusy = false
            lastShotSignature = nil
            table.clear(localShotOutcomeCache)
            resetPosteriorCache()

            activeProfile = profileForOpponent()
            activeProfile.gamesObserved =
                (tonumber(activeProfile.gamesObserved) or 0) + 1
            battleModel.global.gamesObserved =
                (tonumber(battleModel.global.gamesObserved) or 0)
                + 0.18
            battleDirty = true

            seedExistingOpponentShots(opponent)
        end

        previousBattlePhase = phase

        activeProfile =
            activeProfile or profileForOpponent()

        observeOpponentShots(
            opponent,
            activeProfile
        )

        recordCompletedOpponentFleet(
            activeProfile,
            opponent,
            currentGameKey
        )



        if not minigameAutoplayEnabled("Battleship") then
            if fleetReady then releaseFleetIndex() end
            continue
        end
        if not fleetReady and not buildFleetIndex() then
            task.wait(0.10)
            continue
        end

        if phase == "Placement" then
            if not plannedLayout then
                plannedLayout =
                    generateDefensiveLayout(
                        activeProfile
                    )
                placementSession =
                    tostring(
                        workspace:GetServerTimeNow()
                    )
            end

            if plannedLayout then
                for shipIndex = 1, #SHIPS do
                    if not shipIsPlaced(shipIndex) then
                        local placing =
                            tryIndex({
                                "session",
                                "public",
                                "placingShipIndex",
                                mine,
                            })

                        if placing == nil
                            or tonumber(placing) == shipIndex
                        then
                            local cells = {}
                            for _, cell in ipairs(
                                plannedLayout[shipIndex]
                            ) do
                                cells[#cells + 1] = {
                                    row = cell.row,
                                    col = cell.col,
                                }
                            end

                            fireAction(
                                "PlaceShip",
                                {
                                    shipIndex = shipIndex,
                                    cells = cells,
                                }
                            )

                            local deadline =
                                os.clock() + 1.0

                            while os.clock() < deadline
                                and not shipIsPlaced(shipIndex)
                            do
                                task.wait(0.035)
                            end
                        end

                        break
                    end
                end
            end

            continue
        end

        if phase ~= "Firing"
            or firingBusy
        then
            continue
        end

        if tonumber(
            tryIndex({
                "session",
                "public",
                "currentTurn",
            })
        ) ~= mine
        then
            continue
        end

        local signature =
            shotSignature(mine)

        if signature == lastShotSignature then
            continue
        end

        firingBusy = true

        task.spawn(function()
            local expectedSignature = signature

            local knowledge =
                collectShotKnowledge(
                    mine,
                    opponent
                )

            local shot =
                chooseExactShot(
                    knowledge,
                    activeProfile
                )

            if shot then
                if gameId() == "Battleship"
                    and publicPhase() == "Firing"
                    and tonumber(
                        tryIndex({
                            "session",
                            "public",
                            "currentTurn",
                        })
                    ) == mine
                    and shotSignature(mine)
                        == expectedSignature
                then
                    local key =
                        coordKey(
                            shot.row,
                            shot.col
                        )

                    local sent =
                        fireAction(
                            "Fire",
                            {
                                row = shot.row,
                                col = shot.col,
                            }
                        )

                    if sent then
                        local processed = false
                        local processDeadline =
                            os.clock() + 0.85

                        while os.clock() < processDeadline do
                            task.wait(0.010)

                            if shotSignature(mine)
                                ~= expectedSignature
                            then
                                processed = true
                                break
                            end
                        end

                        if processed then




                            local outcome =
                                localShotOutcomeCache[key]
                            local resolveDeadline =
                                os.clock() + 0.075

                            while os.clock() < resolveDeadline
                                and outcome == nil
                            do
                                local shotMap =
                                    tryIndex({
                                        "session",
                                        "public",
                                        "shots",
                                        mine,
                                    })

                                outcome =
                                    shotValueToHit(
                                        safeIndex(
                                            shotMap,
                                            key
                                        )
                                    )

                                if outcome == nil then
                                    local grid =
                                        ownShootGrid(mine)
                                    outcome =
                                        pegHitAt(
                                            grid,
                                            shot.row,
                                            shot.col
                                        )
                                end

                                if outcome == nil then
                                    outcome =
                                        localShotOutcomeCache[key]
                                end

                                if outcome == nil then
                                    task.wait(0.008)
                                end
                            end

                            if outcome == nil then
                                RunService.Heartbeat:Wait()

                                local first =
                                    tonumber(
                                        tryIndex({
                                            "session",
                                            "public",
                                            "currentTurn",
                                        })
                                    )

                                RunService.Heartbeat:Wait()

                                local second =
                                    tonumber(
                                        tryIndex({
                                            "session",
                                            "public",
                                            "currentTurn",
                                        })
                                    )

                                if first == second then
                                    outcome = second == mine
                                else
                                    RunService.Heartbeat:Wait()

                                    outcome =
                                        tonumber(
                                            tryIndex({
                                                "session",
                                                "public",
                                                "currentTurn",
                                            })
                                        ) == mine
                                end
                            end

                            localShotOutcomeCache[key] =
                                outcome == true
                        end
                    end
                end
            end

            lastShotSignature = nil
            firingBusy = false
        end)
    end

    if shotVFXConnection then
        pcall(function()
            shotVFXConnection:Disconnect()
        end)
    end
    releaseFleetIndex()
    saveBattleLearning(true)
end)

end)
end







task.spawn(function()

















if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local function requireWhenReadyLOSS(moduleScript)
    while screenGui.Parent do
        local ok, result = pcall(require, moduleScript)
        if ok and result ~= nil then return result end
        task.wait(0.25)
    end
end

local ClientGlobals = requireWhenReadyLOSS(
    ReplicatedStorage:WaitForChild("Client")
        :WaitForChild("Modules")
        :WaitForChild("ClientGlobals")
)
local Remotes = requireWhenReadyLOSS(
    ReplicatedStorage:WaitForChild("Shared")
        :WaitForChild("Remotes")
)
if not (ClientGlobals and Remotes) then return end

local ActiveMinigame = ClientGlobals.ActiveMinigame
local MinigameBombExplosion = Remotes.MinigameBombExplosion

local BattleshipUtils = nil
local FootballDraftConfig = nil
local BrainrotsConfig = nil

pcall(function()
    BattleshipUtils = require(ReplicatedStorage.SharedModules.BattleshipUtils)
end)
pcall(function()
    FootballDraftConfig = require(ReplicatedStorage.Shared.Config.FootballDraft)
end)
pcall(function()
    BrainrotsConfig = require(ReplicatedStorage.Shared.Config.Brainrots)
end)

local BATTLESHIP_SHIP_COUNT = 3
if type(BattleshipUtils) == "table" and type(BattleshipUtils.SHIPS) == "table" then
    BATTLESHIP_SHIP_COUNT = math.max(1, #BattleshipUtils.SHIPS)
end

local FOOTBALL_MAX_OVR_BY_LINE = {}
if type(FootballDraftConfig) == "table" and type(BrainrotsConfig) == "table" then
    for name in pairs(BrainrotsConfig.BrainrotRarities or {}) do
        if not (BrainrotsConfig.UnobtainableBrainrots or {})[name] then
            local okLine, line = pcall(FootballDraftConfig.GetLine, name)
            local okOVR, ovr = pcall(FootballDraftConfig.GetOVR, name)

            if okLine and okOVR and type(line) == "string" and type(ovr) == "number" then
                FOOTBALL_MAX_OVR_BY_LINE[line] = math.max(
                    FOOTBALL_MAX_OVR_BY_LINE[line] or 0,
                    ovr
                )
            end
        end
    end
end

local GLOBAL_KEY = "__TSUNAMI_CLINCH_LOSS_HOP_V27"
local LEGACY_GLOBAL_KEYS = {
    "__TSUNAMI_CLINCH_LOSS_HOP_V1",
    "__TSUNAMI_CLINCH_LOSS_HOP_V2",
    "__TSUNAMI_CLINCH_LOSS_HOP_V3",
    "__TSUNAMI_CLINCH_LOSS_HOP_V4",
    "__TSUNAMI_CLINCH_LOSS_HOP_V5",
    "__TSUNAMI_CLINCH_LOSS_HOP_V6",
    "__TSUNAMI_CLINCH_LOSS_HOP_V7",
    "__TSUNAMI_CLINCH_LOSS_HOP_V8",
    "__TSUNAMI_CLINCH_LOSS_HOP_V9",
    "__TSUNAMI_CLINCH_LOSS_HOP_V10",
    "__TSUNAMI_CLINCH_LOSS_HOP_V11",
    "__TSUNAMI_CLINCH_LOSS_HOP_V12",
    "__TSUNAMI_CLINCH_LOSS_HOP_V13",
    "__TSUNAMI_CLINCH_LOSS_HOP_V14",
    "__TSUNAMI_CLINCH_LOSS_HOP_V15",
    "__TSUNAMI_CLINCH_LOSS_HOP_V16",
    "__TSUNAMI_CLINCH_LOSS_HOP_V17",
    "__TSUNAMI_CLINCH_LOSS_HOP_V18",
    "__TSUNAMI_CLINCH_LOSS_HOP_V19",
    "__TSUNAMI_CLINCH_LOSS_HOP_V20",
    "__TSUNAMI_CLINCH_LOSS_HOP_V21",
    "__TSUNAMI_CLINCH_LOSS_HOP_V22",
    "__TSUNAMI_CLINCH_LOSS_HOP_V23",
    "__TSUNAMI_CLINCH_LOSS_HOP_V24",
    "__TSUNAMI_CLINCH_LOSS_HOP_V25",
    "__TSUNAMI_CLINCH_LOSS_HOP_V26",
    GLOBAL_KEY,
}

for _, key in ipairs(LEGACY_GLOBAL_KEYS) do
    local oldController = rawget(_G, key)
    if oldController and type(oldController.Destroy) == "function" then
        pcall(function()
            oldController:Destroy()
        end)
    end
    rawset(_G, key, nil)
end

local controller = {
    destroyed = false,
    triggered = false,
    pendingLossReason = nil,
    destinationServerId = nil,
    destinationResolvedAt = 0,
    destinationLookupBusy = false,
    triggerReason = nil,
    triggerObservedAt = nil,
    kickIssuedAt = nil,
    teleportAttemptedAt = nil,
    evaluationRequested = false,
    lastDepartureAttemptAt = 0,
    departureAttemptCount = 0,
    kickLogged = false,
    urgentDepartureScheduled = false,
    queuedMatchResultWinnerIndex = nil,
    queuedMatchResultSet = false,
    queuedKnockoutMatchWinner = nil,
    queuedKnockoutMatchWinnerSet = false,
    queuedKnockoutLastRoundWinner = nil,
    queuedKnockoutLastRoundWinnerSet = false,
    queuedKnockoutResolutionLoss = false,
    queuedCandyThirdBombState = false,
    queuedPopcornPrivatePayload = nil,
    queuedPopcornPrivatePayloadSet = false,
    queuedPopcornPublicWinner = nil,
    queuedPopcornPublicWinnerSet = false,
    connections = {},
    disconnectors = {},
}
rawset(_G, GLOBAL_KEY, controller)

local SERVER_PAGE_LIMIT = 100
local SERVER_MAX_PAGES = 1
local DESTINATION_REFRESH_INTERVAL = 12
local Randomizer = Random.new()

local NORMALIZED_SCORE_GAMES = {
    CandyBomb = true,
    PopcornBurst = true,
    NumberGuess = true,
}

local SEAT_SCORE_GAMES = {
    ConnectFour = true,
    Battleship = true,
    Knockout = true,
}

local SUPPORTED_GAMES = {
    CandyBomb = true,
    PopcornBurst = true,
    NumberGuess = true,
    ConnectFour = true,
    Battleship = true,
    Knockout = true,
    FootballDraft = true,
}

local KICK_GAME_DISPLAY_NAMES = {
    CandyBomb = "Candy Bomb",
    PopcornBurst = "Popcorn",
    NumberGuess = "Number Guess",
    ConnectFour = "Connect Four",
    Battleship = "Battleship",
    Knockout = "Knockout",
    FootballDraft = "Football Draft",
}






local ROUND_START_PHASES = {
    CandyBomb = {
        BombPlacement = true,
        Playing = true,
    },
    PopcornBurst = {
        Playing = true,
    },
    NumberGuess = {
        Guessing = true,
    },
    ConnectFour = {
        Playing = true,
    },
    Battleship = {
        Firing = true,
    },
    Knockout = {
        Starting = true,
        Aiming = true,
    },
    FootballDraft = {
        Drafting = true,
    },
}

local tracker = {
    gameId = nil,
    initialized = false,
    phase = nil,
    publicWinner = nil,
    lastRoundWinner = nil,
    cachedSeatIndex = nil,
    cachedOpponentSeat = nil,
    cachedOpponent = nil,
    cachedRequiredWins = nil,
    knockoutOpponentLossPending = false,
    knockoutPendingRoundStartOpponentWins = nil,
    knockoutRoundPuckTeams = {},
    guessCount = nil,
    localWins = 0,
    opponentWins = 0,
    roundStartLocalWins = nil,
    roundStartOpponentWins = nil,
    seriesBestOfRounds = nil,
    bestOfOneCandidateSince = nil,
    votedBestOfRounds = nil,
    candyBombsHit = 0,
    candyBombEvents = 0,
    candyLastObservedBoardBombs = nil,
    candyAwaitingFreshBoard = false,
    candyAwaitingBoardToken = nil,
    candyBoardFreshConfirmed = false,
    candyRoundStartOpponentWins = nil,
    candyClinchRoundArmed = false,
    popcornSeenFromRoundStart = false,
    popcornMyResultKeys = {},
    popcornOpponentResultKeys = {},
    popcornMyAccumulatedPoints = 0,
    popcornOpponentAccumulatedPoints = 0,
    popcornWasFinished = nil,
    popcornLastActiveKernelSlot = nil,
    popcornLastResultCell = nil,
    popcornOpponentWasFinished = nil,
    popcornOpponentLastActiveKernelSlot = nil,
    popcornOpponentLastResultCell = nil,
    popcornPrivatePayload = nil,
    popcornBestOfRounds = nil,
    popcornRoundStartLocalWins = nil,
    popcornRoundStartOpponentWins = nil,
    popcornAwaitingFreshRound = false,
    popcornPendingRoundLocalWins = nil,
    popcornPendingRoundOpponentWins = nil,





    popcornRoundInitialized = false,
    popcornMyCurrentResultKey = nil,
    popcornOpponentCurrentResultKey = nil,
    popcornMyResultsSinceBaseline = 0,
    popcornOpponentResultsSinceBaseline = 0,
    popcornMyExpectedResults = nil,
    popcornOpponentExpectedResults = nil,
    popcornMyFinal = false,
    popcornOpponentFinal = false,
    popcornMyLastVisibleRemaining = nil,
    popcornOpponentLastVisibleRemaining = nil,
    footballOpponentCompletedFirstObserved = false,
    footballLocalCompletedFirstObserved = false,
    connectFourAwaitingFreshRound = false,
    connectFourRoundArmed = false,
    battleshipAwaitingFreshRound = false,
    battleshipRoundArmed = false,
    gameIdTeardownSeen = false,
}

local evaluateState
local executePendingLossIfReady
local scheduleUrgentDeparture
local cachedClinchRoundReady

local function addConnection(connection)
    if typeof(connection) == "RBXScriptConnection" then
        controller.connections[#controller.connections + 1] = connection
    end
end

local function addDisconnector(value)
    if type(value) == "function" then
        controller.disconnectors[#controller.disconnectors + 1] = value
    elseif typeof(value) == "RBXScriptConnection" then
        addConnection(value)
    end
end

local function tryIndex(path)
    local ok, value = pcall(ActiveMinigame.TryIndex, ActiveMinigame, path)
    if ok then
        return value
    end
    return nil
end

local function numeric(value, fallback)
    local n = tonumber(value)
    if n == nil then
        return fallback
    end
    return n
end




local function safeIndex(value, key)
    if value == nil then
        return nil
    end

    local ok, result = pcall(function()
        return value[key]
    end)

    if ok then
        return result
    end

    return nil
end

local function safeSequenceLength(value, maxScan)
    if value == nil then
        return 0
    end

    local okLength, length = pcall(function()
        return #value
    end)

    if okLength and type(length) == "number" and length > 0 then
        return math.floor(length)
    end

    local highest = 0
    local consecutiveMisses = 0
    local limit = math.max(1, math.floor(maxScan or 256))

    for index = 1, limit do
        if safeIndex(value, index) ~= nil then
            highest = index
            consecutiveMisses = 0
        else
            consecutiveMisses += 1
            if highest > 0 and consecutiveMisses >= 4 then
                break
            end
        end
    end

    return highest
end

local function readIndexed(pathPrefix, index)
    local path = table.clone(pathPrefix)
    path[#path + 1] = index

    local direct = tryIndex(path)
    if direct ~= nil then
        return direct
    end

    local parent = tryIndex(pathPrefix)
    return safeIndex(parent, index)
end

local function currentGameId()
    local gameId = tryIndex({ "session", "gameId" })
    if type(gameId) == "string" then
        return gameId
    end
    return nil
end

local function currentPhase()
    local phase = tryIndex({ "session", "public", "phase" })
    if type(phase) == "string" then
        return phase
    end
    return nil
end

local function currentSeatIndex()
    return numeric(tryIndex({ "session", "private", "seatIndex" }), nil)
end

local function opponentSeatIndex(seatIndex)
    if seatIndex == 1 then
        return 2
    end
    if seatIndex == 2 then
        return 1
    end
    return nil
end

local function currentOpponent()
    local opponent = tryIndex({ "session", "private", "opponent" })
    if typeof(opponent) == "Instance" and opponent:IsA("Player") then
        return opponent
    end
    return nil
end

local function validBestOf(value)
    local n = numeric(value, nil)
    if n == nil then
        return nil
    end

    n = math.floor(n)
    if n == 1 or n == 3 or n == 5 then
        return n
    end

    return nil
end

local function readRoundVoteEvidence()



    local utility = rawget(_G, "__TUFFHUB_UTILITY_FEATURES")
    if type(utility) == "table" and utility.AutoChooseRounds == true then
        local configured = validBestOf(utility.RoundsToChoose)
        if configured ~= nil then
            tracker.votedBestOfRounds = configured
            if configured > 1 then
                tracker.seriesBestOfRounds = configured
            end
        end
    end

    local voting = tryIndex({ "voting" })
    if voting ~= nil then
        local votePhase = safeIndex(voting, "votePhase") or "game"





        if votePhase == "game" and currentGameId() == nil then





            tracker.votedBestOfRounds = nil
            tracker.seriesBestOfRounds = nil
            tracker.bestOfOneCandidateSince = nil
        end

        local opponentVote = safeIndex(voting, "opponentVote")
        local opponentBestOf = validBestOf(safeIndex(opponentVote, "bestOf"))
        if opponentBestOf ~= nil then




            if opponentBestOf > 1 then
                tracker.votedBestOfRounds = opponentBestOf
            elseif tracker.votedBestOfRounds == nil then
                tracker.votedBestOfRounds = 1
            end
        end
    end



    local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local minigameGui = playerGui and playerGui:FindFirstChild("MinigameGui")
    local votingGui = minigameGui and minigameGui:FindFirstChild("Voting")
    local bestOfGui = votingGui and votingGui:FindFirstChild("BestofGamemode")
    local list = bestOfGui and bestOfGui:FindFirstChild("List")

    if list then
        local choices = {
            { name = "One", value = 1 },
            { name = "Three", value = 3 },
            { name = "Five", value = 5 },
        }

        for _, choice in ipairs(choices) do
            local button = list:FindFirstChild(choice.name)
            if button and button:FindFirstChild("SelectionStroke") then
                tracker.votedBestOfRounds = choice.value
                break
            end
        end
    end
end

local function currentBestOfRounds()
    readRoundVoteEvidence()

    local observed = validBestOf(tryIndex({ "bestOfRounds" }))
    local phase = currentPhase()

    if observed == 3 or observed == 5 then
        tracker.seriesBestOfRounds = observed
        tracker.bestOfOneCandidateSince = nil
        return observed
    end



    if tracker.seriesBestOfRounds == 3 or tracker.seriesBestOfRounds == 5 then
        return tracker.seriesBestOfRounds
    end

    if tracker.votedBestOfRounds == 3 or tracker.votedBestOfRounds == 5 then
        tracker.seriesBestOfRounds = tracker.votedBestOfRounds
        tracker.bestOfOneCandidateSince = nil
        return tracker.seriesBestOfRounds
    end

    if observed ~= 1 then
        tracker.bestOfOneCandidateSince = nil
        return tracker.seriesBestOfRounds
    end




    if tracker.votedBestOfRounds == 1 then
        tracker.seriesBestOfRounds = 1
        tracker.bestOfOneCandidateSince = nil
        return 1
    end





    local gameplayPhase = phase ~= nil
        and phase ~= "Voting"
        and phase ~= "Finished"

    if not gameplayPhase then
        tracker.bestOfOneCandidateSince = nil
        return tracker.seriesBestOfRounds
    end

    if tracker.bestOfOneCandidateSince == nil then
        tracker.bestOfOneCandidateSince = os.clock()
        return tracker.seriesBestOfRounds
    end

    if os.clock() - tracker.bestOfOneCandidateSince >= 1.0 then
        tracker.seriesBestOfRounds = 1
        return 1
    end

    return tracker.seriesBestOfRounds
end

local function winsRequired(bestOfRounds)
    return math.floor(bestOfRounds / 2) + 1
end

local function readSeriesScores(gameId, seatIndex)
    local localWins
    local opponentWins

    if NORMALIZED_SCORE_GAMES[gameId] then
        localWins = numeric(readIndexed({ "playerWins" }, 1), nil)
        opponentWins = numeric(readIndexed({ "playerWins" }, 2), nil)

        if localWins == nil or opponentWins == nil then
            localWins = numeric(readIndexed({ "session", "public", "playerWins" }, 1), localWins)
            opponentWins = numeric(readIndexed({ "session", "public", "playerWins" }, 2), opponentWins)
        end
    elseif SEAT_SCORE_GAMES[gameId] then
        local opponentSeat = opponentSeatIndex(seatIndex)
        if seatIndex and opponentSeat then
            localWins = numeric(
                readIndexed({ "session", "public", "playerWins" }, seatIndex),
                nil
            )
            opponentWins = numeric(
                readIndexed({ "session", "public", "playerWins" }, opponentSeat),
                nil
            )

            if localWins == nil or opponentWins == nil then
                localWins = numeric(readIndexed({ "playerWins" }, seatIndex), localWins)
                opponentWins = numeric(readIndexed({ "playerWins" }, opponentSeat), opponentWins)
            end
        end
    else


        local opponentSeat = opponentSeatIndex(seatIndex)
        if seatIndex and opponentSeat then
            localWins = numeric(
                readIndexed({ "session", "public", "playerWins" }, seatIndex),
                nil
            )
            opponentWins = numeric(
                readIndexed({ "session", "public", "playerWins" }, opponentSeat),
                nil
            )
        end

        if localWins == nil or opponentWins == nil then
            localWins = numeric(readIndexed({ "playerWins" }, 1), localWins)
            opponentWins = numeric(readIndexed({ "playerWins" }, 2), opponentWins)
        end
    end






    if gameId == tracker.gameId then
        if localWins == nil then
            localWins = tracker.localWins
        end
        if opponentWins == nil then
            opponentWins = tracker.opponentWins
        end
    end

    return math.max(0, math.floor(localWins or 0)),
        math.max(0, math.floor(opponentWins or 0))
end

local function getEnvironmentTable()
    local env = _G
    local ok, genv = pcall(function()
        if type(getgenv) == "function" then
            return getgenv()
        end
        return nil
    end)

    if ok and type(genv) == "table" then
        env = genv
    end

    return env
end

local function environmentFunction(name)
    local env = getEnvironmentTable()
    local value = env and env[name]

    if type(value) ~= "function" and env ~= _G then
        value = _G[name]
    end

    if type(value) == "function" then
        return value
    end

    return nil
end

local function getRequestFunction()
    local env = getEnvironmentTable()

    local direct = environmentFunction("request")
        or environmentFunction("http_request")
    if direct then
        return direct
    end

    local synTable = env and env.syn or rawget(_G, "syn")
    if type(synTable) == "table" and type(synTable.request) == "function" then
        return synTable.request
    end

    local httpTable = env and env.http or rawget(_G, "http")
    if type(httpTable) == "table" and type(httpTable.request) == "function" then
        return httpTable.request
    end

    return nil
end

local function fetchServerPage(requestFn, cursor)
    local url = "https://games.roblox.com/v1/games/"
        .. tostring(game.PlaceId)
        .. "/servers/Public?sortOrder=Desc&limit="
        .. tostring(SERVER_PAGE_LIMIT)
        .. "&excludeFullGames=true"

    if type(cursor) == "string" and cursor ~= "" then
        url ..= "&cursor=" .. HttpService:UrlEncode(cursor)
    end

    local ok, response = pcall(requestFn, {
        Url = url,
        Method = "GET",
        Headers = {
            ["Accept"] = "application/json",
        },
    })

    if not ok or type(response) ~= "table" then
        return nil
    end

    local body = response.Body or response.body
    if type(body) ~= "string" then
        return nil
    end

    local decodedOk, decoded = pcall(HttpService.JSONDecode, HttpService, body)
    if not decodedOk or type(decoded) ~= "table" then
        return nil
    end

    return decoded
end

local function resolveDestinationServer()
    local requestFn = getRequestFunction()
    if not requestFn then
        return nil
    end

    local originJobId = game.JobId
    local candidates = {}
    local seen = {}
    local cursor = nil

    for _ = 1, SERVER_MAX_PAGES do
        if controller.destroyed or controller.triggered then
            break
        end

        local page = fetchServerPage(requestFn, cursor)
        if not page then
            break
        end

        for _, server in ipairs(page.data or {}) do
            local serverId = server.id
            local playing = numeric(server.playing, nil)
            local maxPlayers = numeric(server.maxPlayers, nil)

            if type(serverId) == "string"
                and serverId ~= ""
                and serverId ~= originJobId
                and not seen[serverId]
                and playing ~= nil
                and maxPlayers ~= nil
                and maxPlayers > 0
                and playing < maxPlayers
            then
                seen[serverId] = true
                candidates[#candidates + 1] = {
                    id = serverId,
                    playing = playing,
                    maxPlayers = maxPlayers,
                    fullness = playing / maxPlayers,
                    openSlots = maxPlayers - playing,
                }
            end
        end

        cursor = page.nextPageCursor
        if type(cursor) ~= "string" or cursor == "" then
            break
        end
    end

    if #candidates == 0 then
        return nil
    end

    table.sort(candidates, function(a, b)
        if a.playing ~= b.playing then
            return a.playing > b.playing
        end
        if a.fullness ~= b.fullness then
            return a.fullness > b.fullness
        end
        if a.openSlots ~= b.openSlots then
            return a.openSlots < b.openSlots
        end
        return a.id < b.id
    end)

    local topCount = math.min(10, #candidates)
    local selected = candidates[Randomizer:NextInteger(1, topCount)]
    return selected and selected.id or nil
end

local function refreshDestinationServer(force)
    if controller.destroyed or controller.triggered then
        return controller.destinationServerId
    end

    if controller.destinationLookupBusy then
        return controller.destinationServerId
    end

    if not force
        and controller.destinationServerId
        and os.clock() - controller.destinationResolvedAt < DESTINATION_REFRESH_INTERVAL
    then
        return controller.destinationServerId
    end

    controller.destinationLookupBusy = true
    local destination = resolveDestinationServer()
    controller.destinationLookupBusy = false

    if type(destination) == "string"
        and destination ~= ""
        and destination ~= game.JobId
    then
        controller.destinationServerId = destination
        controller.destinationResolvedAt = os.clock()
    end

    if executePendingLossIfReady then
        executePendingLossIfReady()
    end

    return controller.destinationServerId
end

local function performDisconnectAndTeleport(destinationServerId, reason)
    local utility = rawget(_G, "__TUFFHUB_UTILITY_FEATURES")
    if type(utility) ~= "table"
        or utility.PauseScript == true
        or utility.PauseMinigameFeatures == true
        or utility.LeaveWhenAboutToLose ~= true
    then
        controller.pendingLossReason = nil
        return false
    end
    if controller.destroyed then
        return false
    end






    local now = os.clock()
    if now - numeric(controller.lastDepartureAttemptAt, 0) < 0.05 then
        return false
    end
    controller.lastDepartureAttemptAt = now
    controller.departureAttemptCount = numeric(controller.departureAttemptCount, 0) + 1

    local triggerReason = reason or controller.pendingLossReason or "clinching-loss"
    controller.triggerReason = triggerReason
    controller.triggerObservedAt = controller.triggerObservedAt or now
    controller.kickIssuedAt = now

    local kickedGameId = currentGameId()
    if type(kickedGameId) ~= "string" or kickedGameId == "" then
        if type(triggerReason) == "string" then
            kickedGameId = string.match(triggerReason, "^([^:]+)")
        end
    end

    local kickedGameName = KICK_GAME_DISPLAY_NAMES[kickedGameId]
        or (type(kickedGameId) == "string" and kickedGameId ~= "" and kickedGameId)
        or "Unknown"
    local kickLogSeparator = string.rep("\\", 10)
    if utility.PauseScript ~= true
        and utility.PauseMinigameFeatures ~= true
        and utility.PrintKicksToTerminal == true
        and controller.kickLogged ~= true
    then
        controller.kickLogged = true
        print("KICKED | Game: " .. tostring(kickedGameName))
        print(kickLogSeparator)
    end





    local kickAccepted = pcall(function()
        LocalPlayer:Kick("Lost Duel")
    end)

    local teleportAccepted = false
    if type(destinationServerId) == "string"
        and destinationServerId ~= ""
        and destinationServerId ~= game.JobId
    then
        controller.teleportAttemptedAt = os.clock()
        teleportAccepted = pcall(function()
            TeleportService:TeleportToPlaceInstance(
                game.PlaceId,
                destinationServerId,
                LocalPlayer
            )
        end)
    end






    local accepted = kickAccepted or teleportAccepted
    if not accepted then
        controller.lastDepartureAttemptAt = 0
    end
    return accepted
end

executePendingLossIfReady = function()
    if controller.destroyed then
        return
    end

    if controller.pendingLossReason == nil then
        return
    end

    performDisconnectAndTeleport(
        controller.destinationServerId,
        controller.pendingLossReason
    )
end

scheduleUrgentDeparture = function()
    if controller.destroyed
        or controller.pendingLossReason == nil
        or controller.urgentDepartureScheduled
    then
        return
    end

    controller.urgentDepartureScheduled = true





    task.spawn(function()
        controller.urgentDepartureScheduled = false
        if not controller.destroyed and controller.pendingLossReason ~= nil then
            executePendingLossIfReady()
        end
    end)
end

local function latchClinchingLoss(reason)
    local utility = rawget(_G, "__TUFFHUB_UTILITY_FEATURES")
    if type(utility) ~= "table"
        or utility.PauseScript == true
        or utility.PauseMinigameFeatures == true
        or utility.LeaveWhenAboutToLose ~= true
    then
        return false
    end
    if controller.destroyed then
        return false
    end

    controller.triggerObservedAt = controller.triggerObservedAt or os.clock()
    if controller.pendingLossReason == nil then
        controller.pendingLossReason = reason or "clinching-loss"
    end





    performDisconnectAndTeleport(
        controller.destinationServerId,
        controller.pendingLossReason
    )
    scheduleUrgentDeparture()
    return true
end

local function isOpponentPlayer(value, opponent)
    if typeof(value) ~= "Instance" or not value:IsA("Player") then
        return false
    end

    if opponent and value == opponent then
        return true
    end

    return value ~= LocalPlayer
end

local function publicWinnerIdentity(value)
    if typeof(value) == "Instance" and value:IsA("Player") then
        return "P:" .. tostring(value.UserId)
    end
    if value == nil then
        return nil
    end
    return typeof(value) .. ":" .. tostring(value)
end

local function resetTracker(gameId)
    tracker.gameId = gameId
    tracker.initialized = false
    tracker.phase = currentPhase()
    tracker.publicWinner = publicWinnerIdentity(
        tryIndex({ "session", "public", "winner" })
    )
    tracker.lastRoundWinner = tryIndex({ "session", "public", "lastRoundWinner" })
    tracker.cachedSeatIndex = nil
    tracker.cachedOpponentSeat = nil
    tracker.cachedOpponent = nil
    tracker.cachedRequiredWins = nil
    tracker.knockoutOpponentLossPending = false
    tracker.knockoutPendingRoundStartOpponentWins = nil
    table.clear(tracker.knockoutRoundPuckTeams)
    tracker.guessCount = nil
    tracker.localWins = 0
    tracker.opponentWins = 0
    tracker.roundStartLocalWins = nil
    tracker.roundStartOpponentWins = nil
    tracker.seriesBestOfRounds = nil
    tracker.bestOfOneCandidateSince = nil


    tracker.candyBombsHit = 0
    tracker.candyBombEvents = 0
    tracker.candyLastObservedBoardBombs = nil
    tracker.candyAwaitingFreshBoard = false
    tracker.candyAwaitingBoardToken = nil
    tracker.candyBoardFreshConfirmed = false
    tracker.candyRoundStartOpponentWins = nil
    tracker.candyClinchRoundArmed = false
    tracker.popcornSeenFromRoundStart = false
    table.clear(tracker.popcornMyResultKeys)
    table.clear(tracker.popcornOpponentResultKeys)
    tracker.popcornMyAccumulatedPoints = 0
    tracker.popcornOpponentAccumulatedPoints = 0
    tracker.popcornWasFinished = nil
    tracker.popcornLastActiveKernelSlot = nil
    tracker.popcornLastResultCell = nil
    tracker.popcornOpponentWasFinished = nil
    tracker.popcornOpponentLastActiveKernelSlot = nil
    tracker.popcornOpponentLastResultCell = nil
    tracker.popcornPrivatePayload = nil
    tracker.popcornBestOfRounds = nil
    tracker.popcornRoundStartLocalWins = nil
    tracker.popcornRoundStartOpponentWins = nil
    tracker.popcornAwaitingFreshRound = false
    tracker.popcornPendingRoundLocalWins = nil
    tracker.popcornPendingRoundOpponentWins = nil
    tracker.popcornRoundInitialized = false
    tracker.popcornMyCurrentResultKey = nil
    tracker.popcornOpponentCurrentResultKey = nil
    tracker.popcornMyResultsSinceBaseline = 0
    tracker.popcornOpponentResultsSinceBaseline = 0
    tracker.popcornMyExpectedResults = nil
    tracker.popcornOpponentExpectedResults = nil
    tracker.popcornMyFinal = false
    tracker.popcornOpponentFinal = false
    tracker.popcornMyLastVisibleRemaining = nil
    tracker.popcornOpponentLastVisibleRemaining = nil
    tracker.footballOpponentCompletedFirstObserved = false
    tracker.footballLocalCompletedFirstObserved = false
    tracker.connectFourAwaitingFreshRound = false
    tracker.connectFourRoundArmed = false
    tracker.battleshipAwaitingFreshRound = false
    tracker.battleshipRoundArmed = false
    tracker.gameIdTeardownSeen = false
end

local function hasConnectFourWin(grid, targetSeat)
    if grid == nil or targetSeat == nil then
        return false
    end

    local function ownerAt(col, row)
        local column = safeIndex(grid, col)
        if column == nil then
            return nil
        end

        local value = safeIndex(column, row)
        local direct = numeric(value, nil)
        if direct ~= nil then
            return direct
        end

        if value ~= nil then
            return numeric(
                safeIndex(value, "seatIndex")
                    or safeIndex(value, "playerIndex")
                    or safeIndex(value, "team")
                    or safeIndex(value, "ownerIndex")
                    or safeIndex(value, "owner"),
                nil
            )
        end

        return nil
    end

    local directions = {
        { 1, 0 },
        { 0, 1 },
        { 1, 1 },
        { 1, -1 },
    }

    for col = 1, 7 do
        for row = 1, 6 do
            if ownerAt(col, row) == targetSeat then
                for _, direction in ipairs(directions) do
                    local dc = direction[1]
                    local dr = direction[2]
                    local complete = true

                    for step = 1, 3 do
                        local nextCol = col + dc * step
                        local nextRow = row + dr * step

                        if nextCol < 1
                            or nextCol > 7
                            or nextRow < 1
                            or nextRow > 6
                            or ownerAt(nextCol, nextRow) ~= targetSeat
                        then
                            complete = false
                            break
                        end
                    end

                    if complete then
                        return true
                    end
                end
            end
        end
    end

    return false
end

local function ownBattleshipsAllSunk(seatIndex)
    if seatIndex == nil then
        return false
    end

    local sunk = readIndexed(
        { "session", "public", "sunkShipDetails" },
        seatIndex
    )

    if sunk == nil then
        return false
    end

    return safeSequenceLength(sunk, 16) >= BATTLESHIP_SHIP_COUNT
end

local function ownBattleshipsAllHitByOpponentShots(seatIndex)
    local opponentSeat = opponentSeatIndex(seatIndex)
    if seatIndex == nil or opponentSeat == nil then
        return false
    end

    local ships = tryIndex({ "session", "private", "myShips" })
    local opponentShots = readIndexed(
        { "session", "public", "shots" },
        opponentSeat
    )

    if ships == nil or opponentShots == nil then
        return false
    end

    local seenShips = 0
    local seenCells = 0

    for shipIndex = 1, BATTLESHIP_SHIP_COUNT do
        local ship = safeIndex(ships, shipIndex)
        if ship == nil then
            return false
        end

        local cells = safeIndex(ship, "cells")
        if cells == nil then
            return false
        end

        local cellCount = safeSequenceLength(cells, 16)
        if cellCount <= 0 then
            return false
        end

        seenShips += 1

        for cellIndex = 1, cellCount do
            local cell = safeIndex(cells, cellIndex)
            local row = numeric(safeIndex(cell, "row"), nil)
            local col = numeric(safeIndex(cell, "col"), nil)

            if row == nil or col == nil then
                return false
            end

            seenCells += 1
            local key = tostring(row) .. "," .. tostring(col)




            if safeIndex(opponentShots, key) == nil then
                return false
            end
        end
    end

    return seenShips == BATTLESHIP_SHIP_COUNT and seenCells > 0
end

local function readPopcornStateTotal(state)
    if state == nil then
        return nil
    end

    local exactKeys = {
        "totalPoints",
        "totalScore",
        "pointsTotal",
        "scoreTotal",
        "score",
        "points",
    }

    for _, key in ipairs(exactKeys) do
        local value = numeric(safeIndex(state, key), nil)
        if value ~= nil then
            return value
        end
    end

    local discovered = nil
    pcall(function()
        for key, value in state do
            if type(key) == "string" and type(value) == "number" then
                local lower = string.lower(key)
                local mentionsScore = string.find(lower, "score", 1, true) ~= nil
                    or string.find(lower, "point", 1, true) ~= nil
                local mentionsTotal = string.find(lower, "total", 1, true) ~= nil

                if mentionsScore and mentionsTotal then
                    discovered = value
                    break
                end
            end
        end
    end)

    return discovered
end

local function parsePointNumber(text)
    if type(text) ~= "string" then
        return nil
    end

    local cleaned = string.gsub(text, ",", "")
    local best = nil

    for token in string.gmatch(cleaned, "[-+]?%d+%.?%d*") do
        local value = tonumber(token)
        if value ~= nil then
            if best == nil or math.abs(value) > math.abs(best) then
                best = value
            end
        end
    end

    return best
end

local function readPointsFromGuiObject(root)
    if not root then
        return nil
    end

    local best = nil
    for _, descendant in ipairs(root:GetDescendants()) do
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
            local value = parsePointNumber(descendant.Text)
            if value ~= nil then
                if best == nil or value > best then
                    best = value
                end
            end
        end
    end

    return best
end

local function readPopcornBoardPoints(seatIndex)
    local opponentSeat = opponentSeatIndex(seatIndex)
    if seatIndex == nil or opponentSeat == nil then
        return nil, nil
    end

    local tableModel = tryIndex({ "session", "public", "tableModel" })
    if typeof(tableModel) ~= "Instance" then
        return nil, nil
    end

    local board = tableModel:FindFirstChild("PopcornBurstBoard")
    if not board then
        return nil, nil
    end

    local function pointsForSeat(seat)
        local part = board:FindFirstChild("Side" .. tostring(seat) .. "PointsPart")
        if not part then
            return nil
        end

        local gui = part:FindFirstChild("SurfaceGui")
        return readPointsFromGuiObject(gui or part)
    end

    return pointsForSeat(seatIndex), pointsForSeat(opponentSeat)
end

local function readPopcornKernelLayout(seatIndex)
    if seatIndex == nil then
        return nil
    end

    local tableModel = tryIndex({ "session", "public", "tableModel" })
    if typeof(tableModel) ~= "Instance" then
        return nil
    end

    local board = tableModel:FindFirstChild("PopcornBurstBoard")
    if not board then
        return nil
    end

    local side = board:FindFirstChild("Side" .. tostring(seatIndex))
    if not side then
        return nil
    end

    local indices = {}
    for _, child in ipairs(side:GetChildren()) do
        local index = tonumber(child.Name)
        if index ~= nil then
            local hasKernel = child:FindFirstChild("Popcorn") ~= nil
                or child:FindFirstChild("Kernel") ~= nil

            if hasKernel then
                indices[#indices + 1] = index
            end
        end
    end

    if #indices <= 0 then
        return nil
    end

    table.sort(indices)

    local positionByIndex = {}
    for position, index in ipairs(indices) do
        positionByIndex[index] = position
    end

    return {
        count = #indices,
        indices = indices,
        positionByIndex = positionByIndex,
        firstIndex = indices[1],
        lastIndex = indices[#indices],
    }
end

local function readPopcornKernelLayoutEitherSeat(seatIndex, opponentSeat)
    local layout = readPopcornKernelLayout(seatIndex)
    if layout then
        return layout
    end

    return readPopcornKernelLayout(opponentSeat)
end

local function popcornSlotPosition(layout, slotIndex)
    if not layout or slotIndex == nil then
        return nil
    end

    local exact = layout.positionByIndex[slotIndex]
    if exact ~= nil then
        return exact
    end





    local first = layout.firstIndex
    if first ~= nil then
        local estimated = math.floor(slotIndex - first + 1)
        if estimated >= 1 and estimated <= layout.count then
            return estimated
        end
    end

    return nil
end

local function popcornProcessedKernelCount(state, layout)
    if type(state) ~= "table" or not layout then
        return nil
    end

    if state.finished == true then
        return layout.count
    end

    local resultCell = nil
    if type(state.lastResult) == "table" then
        resultCell = numeric(state.lastResult.cellIndex, nil)
    end
    local resultPosition = popcornSlotPosition(layout, resultCell)
    if resultPosition ~= nil then
        return math.clamp(resultPosition, 0, layout.count)
    end

    local activeSlot = numeric(state.activeKernelSlot, nil)
    local activePosition = popcornSlotPosition(layout, activeSlot)
    if activePosition ~= nil then
        return math.clamp(activePosition - 1, 0, layout.count)
    end

    return nil
end

local function popcornResultCell(state)
    if state == nil then
        return nil
    end

    local result = safeIndex(state, "lastResult")
    if result == nil and type(state) == "table" then
        result = state.lastResult
    end

    return numeric(safeIndex(result, "cellIndex"), nil)
end

local function readPopcornPrivateState(stateName)
    local private = tracker.popcornPrivatePayload
    if private == nil then
        private = tryIndex({ "session", "private" })
    end







    local state = safeIndex(private, stateName)
    if state == nil then
        state = tryIndex({ "session", "private", stateName })
    end

    local function field(name)
        local fromState = safeIndex(state, name)
        if fromState ~= nil then
            return fromState
        end

        return tryIndex({ "session", "private", stateName, name })
    end

    local lastResult = field("lastResult")
    if lastResult ~= nil then
        local cellIndex = safeIndex(lastResult, "cellIndex")
        local rating = safeIndex(lastResult, "rating")
        local points = safeIndex(lastResult, "points")

        if cellIndex ~= nil or rating ~= nil or points ~= nil then
            lastResult = {
                cellIndex = cellIndex,
                rating = rating,
                points = points,
            }
        elseif type(lastResult) ~= "table" then
            lastResult = nil
        end
    else
        local cellIndex = tryIndex({
            "session", "private", stateName, "lastResult", "cellIndex"
        })
        local rating = tryIndex({
            "session", "private", stateName, "lastResult", "rating"
        })
        local points = tryIndex({
            "session", "private", stateName, "lastResult", "points"
        })

        if cellIndex ~= nil or rating ~= nil or points ~= nil then
            lastResult = {
                cellIndex = cellIndex,
                rating = rating,
                points = points,
            }
        end
    end

    local kernelIndex = numeric(
        field("kernelIndex")
            or field("KernelIndex")
            or field("processedKernels")
            or field("currentKernelIndex"),
        nil
    )
    local totalKernels = numeric(
        field("totalKernels")
            or field("TotalKernels")
            or field("kernelCount")
            or field("KernelCount"),
        nil
    )

    return {
        finished = field("finished") == true,
        activeKernelSlot = numeric(field("activeKernelSlot"), nil),
        ringDuration = numeric(field("ringDuration"), nil),
        kernelIndex = kernelIndex,
        totalKernels = totalKernels,
        lastResult = lastResult,
        raw = state,
    }
end

local function resultKey(result)
    if result == nil then
        return nil
    end

    local cellIndex = safeIndex(result, "cellIndex")
    if cellIndex == nil then
        return nil
    end

    return table.concat({
        tostring(cellIndex),
        tostring(safeIndex(result, "rating")),
        tostring(safeIndex(result, "points")),
    }, ":")
end

local function readPopcornKernelCounts(seatIndex)
    if seatIndex == nil then
        return nil, nil
    end

    local tableModel = tryIndex({ "session", "public", "tableModel" })
    if typeof(tableModel) ~= "Instance" then
        return nil, nil
    end

    local board = tableModel:FindFirstChild("PopcornBurstBoard")
    if not board then
        return nil, nil
    end

    local side = board:FindFirstChild("Side" .. tostring(seatIndex))
    if not side then
        return nil, nil
    end

    local totalSlots = 0
    local remainingKernels = 0

    for _, child in ipairs(side:GetChildren()) do
        if tonumber(child.Name) ~= nil then
            totalSlots += 1

            if child:FindFirstChild("Popcorn") ~= nil
                or child:FindFirstChild("Kernel") ~= nil
            then
                remainingKernels += 1
            end
        end
    end

    if totalSlots <= 0 then
        return nil, nil
    end

    return totalSlots, remainingKernels
end

local function popcornHasLiveKernel(state)
    if type(state) ~= "table" or state.finished == true then
        return false
    end

    local activeSlot = numeric(state.activeKernelSlot, nil)
    local duration = numeric(state.ringDuration, nil)
    if activeSlot == nil or activeSlot <= 0 or duration == nil or duration <= 0 then
        return false
    end

    local resultCell = popcornResultCell(state)
    return resultCell == nil or resultCell ~= activeSlot
end

local function popcornStateScore(state)
    if type(state) ~= "table" then
        return nil
    end

    local raw = state.raw
    local score = readPopcornStateTotal(raw)
    if score ~= nil then
        return score
    end

    if raw ~= nil then
        for _, key in ipairs({ "Score", "score", "TotalScore", "totalScore", "Points", "points" }) do
            local value = numeric(safeIndex(raw, key), nil)
            if value ~= nil then
                return value
            end
        end
    end

    return nil
end

local function popcornExactProgressFinished(state)
    if type(state) ~= "table" then
        return false
    end

    local current = numeric(state.kernelIndex, nil)
    local total = numeric(state.totalKernels, nil)

    return current ~= nil
        and total ~= nil
        and total > 0
        and current >= total
end

local function initializePopcornRoundTracking(
    s,
    myState,
    opponentState,
    myTotalSlots,
    opponentTotalSlots,
    myRemaining,
    opponentRemaining
)
    tracker.popcornRoundInitialized = true




    tracker.popcornRoundStartLocalWins = s.localWins
    tracker.popcornRoundStartOpponentWins = s.opponentWins
    tracker.popcornAwaitingFreshRound = false
    tracker.popcornPendingRoundLocalWins = nil
    tracker.popcornPendingRoundOpponentWins = nil

    tracker.popcornMyCurrentResultKey = resultKey(myState.lastResult)
    tracker.popcornOpponentCurrentResultKey = resultKey(opponentState.lastResult)
    tracker.popcornMyResultsSinceBaseline = 0
    tracker.popcornOpponentResultsSinceBaseline = 0




    local function expectedResults(state, totalSlots, remaining, currentResultKey)
        if remaining ~= nil and remaining > 0 then
            return remaining
        end

        local total = numeric(state.totalKernels, nil)
            or numeric(totalSlots, nil)
        local current = numeric(state.kernelIndex, nil)

        if total ~= nil and total > 0 and current ~= nil then
            return math.max(0, math.floor(total - current))
        end




        if currentResultKey == nil then
            if total ~= nil and total > 0 then
                return math.floor(total)
            end
            return 16
        end

        return nil
    end

    tracker.popcornMyExpectedResults = expectedResults(
        myState,
        myTotalSlots,
        myRemaining,
        tracker.popcornMyCurrentResultKey
    )
    tracker.popcornOpponentExpectedResults = expectedResults(
        opponentState,
        opponentTotalSlots,
        opponentRemaining,
        tracker.popcornOpponentCurrentResultKey
    )




    tracker.popcornMyFinal = myState.finished == true
        or popcornExactProgressFinished(myState)
    tracker.popcornOpponentFinal = opponentState.finished == true
        or popcornExactProgressFinished(opponentState)

    tracker.popcornMyLastVisibleRemaining = myRemaining
    tracker.popcornOpponentLastVisibleRemaining = opponentRemaining

    table.clear(tracker.popcornMyResultKeys)
    table.clear(tracker.popcornOpponentResultKeys)
    tracker.popcornMyAccumulatedPoints = 0
    tracker.popcornOpponentAccumulatedPoints = 0



    tracker.popcornSeenFromRoundStart =
        tracker.popcornMyCurrentResultKey == nil
        and tracker.popcornOpponentCurrentResultKey == nil
end

local function updatePopcornResultCounter(state, isOpponent)
    local key = resultKey(state.lastResult)
    if key == nil then
        return false
    end

    local previousKey
    if isOpponent then
        previousKey = tracker.popcornOpponentCurrentResultKey
    else
        previousKey = tracker.popcornMyCurrentResultKey
    end

    if key == previousKey then
        return false
    end

    if isOpponent then
        tracker.popcornOpponentCurrentResultKey = key
        tracker.popcornOpponentResultsSinceBaseline += 1
        tracker.popcornOpponentAccumulatedPoints += numeric(state.lastResult.points, 0)
    else
        tracker.popcornMyCurrentResultKey = key
        tracker.popcornMyResultsSinceBaseline += 1
        tracker.popcornMyAccumulatedPoints += numeric(state.lastResult.points, 0)
    end

    return true
end

local function ensurePopcornRemainingBaselines(
    myState,
    opponentState,
    myRemaining,
    opponentRemaining
)
    if tracker.popcornMyExpectedResults == nil
        and not tracker.popcornMyFinal
        and myRemaining ~= nil
        and myRemaining > 0
    then
        tracker.popcornMyExpectedResults = myRemaining
        tracker.popcornMyCurrentResultKey = resultKey(myState.lastResult)
        tracker.popcornMyResultsSinceBaseline = 0
    end

    if tracker.popcornOpponentExpectedResults == nil
        and not tracker.popcornOpponentFinal
        and opponentRemaining ~= nil
        and opponentRemaining > 0
    then
        tracker.popcornOpponentExpectedResults = opponentRemaining
        tracker.popcornOpponentCurrentResultKey = resultKey(opponentState.lastResult)
        tracker.popcornOpponentResultsSinceBaseline = 0
    end
end

local function updatePopcornTerminalFlags(
    myState,
    opponentState,
    myRemaining,
    opponentRemaining
)
    local myReachedZeroAfterVisible = myRemaining ~= nil
        and myRemaining == 0
        and tracker.popcornMyLastVisibleRemaining ~= nil
        and tracker.popcornMyLastVisibleRemaining > 0
    local opponentReachedZeroAfterVisible = opponentRemaining ~= nil
        and opponentRemaining == 0
        and tracker.popcornOpponentLastVisibleRemaining ~= nil
        and tracker.popcornOpponentLastVisibleRemaining > 0

    if myState.finished == true
        or popcornExactProgressFinished(myState)
        or myReachedZeroAfterVisible
    then
        tracker.popcornMyFinal = true
    end

    if opponentState.finished == true
        or popcornExactProgressFinished(opponentState)
        or opponentReachedZeroAfterVisible
    then
        tracker.popcornOpponentFinal = true
    end





    if tracker.popcornMyExpectedResults ~= nil
        and tracker.popcornMyExpectedResults > 0
        and tracker.popcornMyResultsSinceBaseline >= tracker.popcornMyExpectedResults
    then
        tracker.popcornMyFinal = true
    end

    if tracker.popcornOpponentExpectedResults ~= nil
        and tracker.popcornOpponentExpectedResults > 0
        and tracker.popcornOpponentResultsSinceBaseline >= tracker.popcornOpponentExpectedResults
    then
        tracker.popcornOpponentFinal = true
    end

    tracker.popcornMyLastVisibleRemaining = myRemaining
    tracker.popcornOpponentLastVisibleRemaining = opponentRemaining
end

local function readFootballDraftState(seatIndex)
    local opponentSeat = opponentSeatIndex(seatIndex)
    if seatIndex == nil or opponentSeat == nil then
        return nil
    end

    local myCompleted = readIndexed(
        { "session", "public", "completed" },
        seatIndex
    ) == true
    local opponentCompleted = readIndexed(
        { "session", "public", "completed" },
        opponentSeat
    ) == true
    local myOVR = numeric(
        readIndexed({ "session", "public", "totalOVR" }, seatIndex),
        nil
    )
    local opponentOVR = numeric(
        readIndexed({ "session", "public", "totalOVR" }, opponentSeat),
        nil
    )

    return {
        myCompleted = myCompleted,
        opponentCompleted = opponentCompleted,
        myOVR = myOVR,
        opponentOVR = opponentOVR,
    }
end

local function footballMaxPossibleLocalOVR()
    if type(FootballDraftConfig) ~= "table"
        or type(FootballDraftConfig.Formation) ~= "table"
    then
        return nil
    end

    local lineup = tryIndex({ "session", "private", "lineup" })
    if lineup == nil then
        return nil
    end

    local total = 0

    for _, slot in ipairs(FootballDraftConfig.Formation) do
        local slotId = slot.SlotId
        local line = slot.Line
        local draftedName = safeIndex(lineup, slotId)

        if draftedName ~= nil then
            local okOVR, ovr = pcall(FootballDraftConfig.GetOVR, draftedName)
            if not okOVR or type(ovr) ~= "number" then
                return nil
            end
            total += ovr
        else
            local maxLine = FOOTBALL_MAX_OVR_BY_LINE[line]
            if type(maxLine) ~= "number" then
                return nil
            end
            total += maxLine
        end
    end

    return total
end

local function currentCandyBoardObject()
    local board = tryIndex({ "session", "private", "myBoard" })
    if board ~= nil then
        return board
    end

    local private = tryIndex({ "session", "private" })
    return safeIndex(private, "myBoard")
end

local function countCandyBombsHit()
    local board = currentCandyBoardObject()
    local cells = tryIndex({ "session", "private", "myBoard", "cells" })

    if cells == nil then
        cells = safeIndex(board, "cells")
    end

    if cells == nil then
        return nil
    end

    local bombCount = 0
    local sawCell = false

    for index = 1, 32 do
        local cell = safeIndex(cells, index)
        if cell ~= nil then
            sawCell = true

            if safeIndex(cell, "eaten") == true
                and safeIndex(cell, "wasBomb") == true
            then
                bombCount += 1
            end
        elseif sawCell then
            break
        end
    end

    if not sawCell then
        return nil
    end

    return bombCount
end

local function clinchPossibleFromRoundLoss(opponentWins, requiredWins)
    if requiredWins == nil then
        return false
    end





    local beforeRound = tracker.roundStartOpponentWins
    if beforeRound == nil then



        return false
    end

    beforeRound = math.max(0, math.floor(numeric(beforeRound, 0)))



    return beforeRound == requiredWins - 1
end

local function exactRoundLossClinches(opponentWins, requiredWins)
    if clinchPossibleFromRoundLoss(opponentWins, requiredWins) then
        return true
    end





    return requiredWins ~= nil
        and numeric(opponentWins, 0) >= requiredWins
end

local function armCandyRoundFromCurrentSeries()


    local bestOf = currentBestOfRounds()
    if bestOf == nil then
        tracker.candyRoundStartOpponentWins = nil
        tracker.candyClinchRoundArmed = false
        return
    end

    local requiredWins = winsRequired(bestOf)
    local seatIndex = currentSeatIndex()
    local _, opponentWins = readSeriesScores("CandyBomb", seatIndex)

    tracker.candyRoundStartOpponentWins = opponentWins
    tracker.roundStartOpponentWins = opponentWins
    tracker.candyClinchRoundArmed = opponentWins == requiredWins - 1
end

local function resetCandyRoundBombCounter(observedBombs)
    local baseline = math.clamp(math.floor(numeric(observedBombs, 0)), 0, 3)
    tracker.candyBombsHit = baseline
    tracker.candyBombEvents = baseline
    tracker.candyLastObservedBoardBombs = observedBombs
end

local function beginFreshCandyRound()



    if type(controller.pendingLossReason) == "string"
        and string.sub(controller.pendingLossReason, 1, 10) == "CandyBomb:"
    then
        controller.pendingLossReason = nil
    end

    tracker.candyBombsHit = 0
    tracker.candyBombEvents = 0
    tracker.candyAwaitingBoardToken = currentCandyBoardObject()
    tracker.candyAwaitingFreshBoard = true
    tracker.candyBoardFreshConfirmed = false





    tracker.candyRoundStartOpponentWins = nil
    tracker.candyClinchRoundArmed = false
    armCandyRoundFromCurrentSeries()
end

local function syncCandyBombBoardCount()
    local observedBombs = countCandyBombsHit()
    if observedBombs == nil then
        tracker.candyBombsHit = math.min(
            3,
            math.max(tracker.candyBombsHit, tracker.candyBombEvents)
        )
        return nil
    end

    observedBombs = math.clamp(math.floor(numeric(observedBombs, 0)), 0, 3)

    if tracker.candyAwaitingFreshBoard then
        local board = currentCandyBoardObject()
        local tokenChanged = board ~= nil
            and tracker.candyAwaitingBoardToken ~= nil
            and board ~= tracker.candyAwaitingBoardToken

        local countReset = tracker.candyLastObservedBoardBombs ~= nil
            and observedBombs < tracker.candyLastObservedBoardBombs





        if not tokenChanged and not countReset then
            tracker.candyLastObservedBoardBombs = observedBombs
            return observedBombs
        end

        tracker.candyAwaitingFreshBoard = false
        tracker.candyAwaitingBoardToken = nil
        tracker.candyBoardFreshConfirmed = true
        resetCandyRoundBombCounter(observedBombs)
        armCandyRoundFromCurrentSeries()
        return observedBombs
    end




    if tracker.candyLastObservedBoardBombs == 3 and observedBombs < 3 then
        if type(controller.pendingLossReason) == "string"
            and string.sub(controller.pendingLossReason, 1, 10) == "CandyBomb:"
        then
            controller.pendingLossReason = nil
        end

        resetCandyRoundBombCounter(observedBombs)
        tracker.candyAwaitingFreshBoard = false
        tracker.candyAwaitingBoardToken = nil
        tracker.candyBoardFreshConfirmed = true
        armCandyRoundFromCurrentSeries()
        return observedBombs
    end

    tracker.candyLastObservedBoardBombs = observedBombs
    tracker.candyBombsHit = math.min(
        3,
        math.max(tracker.candyBombsHit, observedBombs, tracker.candyBombEvents)
    )

    return observedBombs
end

local function processCandyBomb(s)
    local wasInCandyRound = tracker.phase == "BombPlacement"
        or tracker.phase == "Playing"
    local isInCandyRound = s.phase == "BombPlacement"
        or s.phase == "Playing"

    if isInCandyRound and not wasInCandyRound then
        beginFreshCandyRound()
    end

    local observedBombs = syncCandyBombBoardCount()





    if tracker.candyClinchRoundArmed == true
        and tracker.candyAwaitingFreshBoard ~= true
        and tracker.candyBoardFreshConfirmed == true
        and math.max(
            numeric(observedBombs, 0),
            numeric(tracker.candyBombEvents, 0),
            numeric(tracker.candyBombsHit, 0)
        ) >= 3
    then
        latchClinchingLoss("CandyBomb:ThirdBombState")
        return
    end




    if s.requiredWins ~= nil
        and s.opponentWins >= s.requiredWins
    then
        local winner = tryIndex({ "session", "public", "winner" })
        if isOpponentPlayer(winner, s.opponent) then
            latchClinchingLoss("CandyBomb:WinnerFallback")
        end
    end
end

local function processNumberGuess(s)
    local guessLog = tryIndex({ "session", "public", "guessLog" })
    if guessLog == nil then
        tracker.guessCount = nil
        return
    end

    local count = safeSequenceLength(guessLog, 256)
    if tracker.guessCount == nil then
        tracker.guessCount = count


        local lastEntry = safeIndex(guessLog, count)
        if s.phase == "Guessing"
            and safeIndex(lastEntry, "response") == "Correct"
            and numeric(safeIndex(lastEntry, "guesserIndex"), nil) == s.opponentSeat
            and exactRoundLossClinches(s.opponentWins, s.requiredWins)
        then
            latchClinchingLoss("NumberGuess:ExistingCorrect")
        end
        return
    end

    if count < tracker.guessCount then
        tracker.guessCount = count
        return
    end

    if count > tracker.guessCount then
        for index = tracker.guessCount + 1, count do
            local entry = safeIndex(guessLog, index)
            if safeIndex(entry, "response") == "Correct"
                and numeric(safeIndex(entry, "guesserIndex"), nil) == s.opponentSeat
                and exactRoundLossClinches(s.opponentWins, s.requiredWins)
            then
                latchClinchingLoss("NumberGuess:Correct")
                break
            end
        end
    end

    tracker.guessCount = count
end

local function processConnectFour(s)
    if s.opponentSeat == nil then
        return
    end

    local grid = tryIndex({ "session", "public", "grid" })
    local opponentHasWin = hasConnectFourWin(grid, s.opponentSeat)




    if tracker.connectFourAwaitingFreshRound then
        if opponentHasWin then
            return
        end

        tracker.connectFourAwaitingFreshRound = false
        tracker.connectFourRoundArmed = true
        return
    end

    if not tracker.connectFourRoundArmed then
        tracker.connectFourRoundArmed = true
    end

    if opponentHasWin
        and exactRoundLossClinches(s.opponentWins, s.requiredWins)
    then
        latchClinchingLoss("ConnectFour:FourInRow")
    end
end

local function processBattleship(s)
    if s.phase == "Placement" or s.phase == "Starting" then
        tracker.battleshipAwaitingFreshRound = true
        tracker.battleshipRoundArmed = false
        return
    end

    local allCellsHit = ownBattleshipsAllHitByOpponentShots(s.seatIndex)
    local allSunk = ownBattleshipsAllSunk(s.seatIndex)





    if tracker.battleshipAwaitingFreshRound then
        if allCellsHit or allSunk then
            return
        end

        tracker.battleshipAwaitingFreshRound = false
        tracker.battleshipRoundArmed = true
        return
    end

    if not tracker.battleshipRoundArmed then
        tracker.battleshipRoundArmed = true
    end

    if not exactRoundLossClinches(s.opponentWins, s.requiredWins) then
        return
    end





    if allCellsHit then
        latchClinchingLoss("Battleship:AllOwnShipCellsHit")
        return
    end



    if allSunk then
        latchClinchingLoss("Battleship:AllOwnShipsSunk")
    end
end










local function cacheKnockoutReplicatedPuckTeams(seatIndex, opponentSeat)
    if seatIndex == nil or opponentSeat == nil then
        return
    end

    local pucks = tryIndex({ "session", "public", "pucks" })
    if pucks == nil then
        return
    end

    local function cachePuck(puck)
        if puck == nil then
            return
        end
        local team = numeric(safeIndex(puck, "team"), nil)
        local puckId = safeIndex(puck, "id")
        if puckId ~= nil and (team == seatIndex or team == opponentSeat) then
            tracker.knockoutRoundPuckTeams[puckId] = team
        end
    end

    local iterated = false
    local okIter = pcall(function()
        for _, puck in pucks do
            iterated = true
            cachePuck(puck)
        end
    end)
    if not okIter or not iterated then
        for i = 1, 64 do
            local puck = safeIndex(pucks, i)
            if puck ~= nil then
                cachePuck(puck)
            end
        end
    end
end

local function cacheKnockoutRoundPucks(s)
    if s == nil or s.seatIndex == nil or s.opponentSeat == nil then
        return
    end

    cacheKnockoutReplicatedPuckTeams(s.seatIndex, s.opponentSeat)

    local pucks = tryIndex({ "session", "public", "pucks" })
    if pucks == nil then
        return
    end

    local function cachePuck(puck)
        if puck == nil then
            return
        end
        local team = numeric(safeIndex(puck, "team"), nil)
        local puckId = safeIndex(puck, "id")
        if puckId ~= nil and (team == s.seatIndex or team == s.opponentSeat) then
            tracker.knockoutRoundPuckTeams[puckId] = team
        end
    end

    local iterated = false
    local okIter = pcall(function()
        for _, puck in pucks do
            iterated = true
            cachePuck(puck)
        end
    end)
    if not okIter or not iterated then
        for i = 1, 64 do
            local puck = safeIndex(pucks, i)
            if puck ~= nil then
                cachePuck(puck)
            end
        end
    end
end

local function trajectorySunkState(trajectory)
    if trajectory == nil then
        return nil, false
    end

    local sawSample = false
    local sunk = false

    local okIter = pcall(function()
        for _, sample in trajectory do
            if sample ~= nil then
                sawSample = true
                if safeIndex(sample, "sunk") == true then
                    sunk = true
                end
            end
        end
    end)

    if not okIter or not sawSample then
        local misses = 0
        for index = 1, 4096 do
            local sample = safeIndex(trajectory, index)
            if sample ~= nil then
                sawSample = true
                misses = 0
                if safeIndex(sample, "sunk") == true then
                    sunk = true
                end
            elseif sawSample then
                misses += 1
                if misses >= 8 then
                    break
                end
            end
        end
    end

    return sunk, sawSample
end

local function knockoutFinalResolutionOutcome(s)
    if s.seatIndex == nil or s.opponentSeat == nil then
        return nil
    end

    local resolution = tryIndex({ "session", "public", "resolution" })
    if resolution == nil then
        return nil
    end

    local trajectories = safeIndex(resolution, "trajectories")
    if trajectories == nil then
        trajectories = tryIndex({
            "session",
            "public",
            "resolution",
            "trajectories",
        })
    end
    if trajectories == nil then
        return nil
    end

    local liveById = {}
    local roundTeams = {}
    for puckId, team in pairs(tracker.knockoutRoundPuckTeams) do
        roundTeams[puckId] = team
    end

    local pucks = tryIndex({ "session", "public", "pucks" })
    local function captureLivePuck(puck)
        if puck == nil then return end
        local puckId = safeIndex(puck, "id")
        local team = numeric(safeIndex(puck, "team"), nil)
        if puckId == nil or (team ~= s.seatIndex and team ~= s.opponentSeat) then
            return
        end
        liveById[puckId] = puck


        if roundTeams[puckId] == nil
            and (safeIndex(puck, "alive") == true or safeIndex(trajectories, puckId) ~= nil)
        then
            roundTeams[puckId] = team
        end
    end

    if pucks ~= nil then
        local iterated = false
        local okIter = pcall(function()
            for _, puck in pucks do
                iterated = true
                captureLivePuck(puck)
            end
        end)
        if not okIter or not iterated then
            for i = 1, 64 do
                local puck = safeIndex(pucks, i)
                if puck ~= nil then
                    captureLivePuck(puck)
                end
            end
        end
    end




    pcall(function()
        for _, puckInstance in ipairs(CollectionService:GetTagged("KnockoutPuck")) do
            local puckId = puckInstance:GetAttribute("PuckId")
            local team = numeric(puckInstance:GetAttribute("TeamIndex"), nil)
            if puckId ~= nil
                and (team == s.seatIndex or team == s.opponentSeat)
                and safeIndex(trajectories, puckId) ~= nil
            then
                roundTeams[puckId] = team
            end
        end
    end)

    local mySurvivors = 0
    local opponentSurvivors = 0
    local sawMyPuck = false
    local sawOpponentPuck = false
    local incompleteResolution = false
    local roundPuckCount = 0

    for puckId, team in pairs(roundTeams) do
        roundPuckCount += 1
        if team == s.seatIndex then
            sawMyPuck = true
        elseif team == s.opponentSeat then
            sawOpponentPuck = true
        end

        local trajectory = safeIndex(trajectories, puckId)
        local sunk, sawSample = trajectorySunkState(trajectory)
        local survives = nil

        if sawSample then
            survives = not sunk
        else
            local livePuck = liveById[puckId]
            if livePuck ~= nil then
                local alive = safeIndex(livePuck, "alive")
                if alive == true then
                    survives = true
                elseif alive == false then
                    survives = false
                end
            end
        end

        if survives == nil then
            incompleteResolution = true
        elseif survives then
            if team == s.seatIndex then
                mySurvivors += 1
            else
                opponentSurvivors += 1
            end
        end
    end

    if roundPuckCount == 0
        or incompleteResolution
        or not sawMyPuck
        or not sawOpponentPuck
    then
        return nil
    end

    return {
        mySurvivors = mySurvivors,
        opponentSurvivors = opponentSurvivors,
        opponentGuaranteedRoundWin =
            mySurvivors == 0 and opponentSurvivors > 0,
        draw =
            mySurvivors == 0 and opponentSurvivors == 0,
    }
end



local function knockoutResolutionPayloadProvesLoss(resolution, seatIndex, opponentSeat)
    if resolution == nil or seatIndex == nil or opponentSeat == nil then
        return false
    end

    cacheKnockoutReplicatedPuckTeams(seatIndex, opponentSeat)
    local trajectories = safeIndex(resolution, "trajectories")
    if trajectories == nil then return false end

    local mySurvivors = 0
    local opponentSurvivors = 0
    local sawMyPuck = false
    local sawOpponentPuck = false

    for puckId, team in pairs(tracker.knockoutRoundPuckTeams) do
        if team == seatIndex or team == opponentSeat then
            if team == seatIndex then sawMyPuck = true else sawOpponentPuck = true end
            local trajectory = safeIndex(trajectories, puckId)
            if trajectory == nil then return false end
            local sunk, sawSample = trajectorySunkState(trajectory)
            if not sawSample then return false end
            if not sunk then
                if team == seatIndex then
                    mySurvivors += 1
                else
                    opponentSurvivors += 1
                end
            end
        end
    end

    return sawMyPuck
        and sawOpponentPuck
        and mySurvivors == 0
        and opponentSurvivors > 0
end

local function processKnockout(s)





    if clinchPossibleFromRoundLoss(s.opponentWins, s.requiredWins) then



        local outcome = knockoutFinalResolutionOutcome(s)
        if outcome and outcome.opponentGuaranteedRoundWin then
            latchClinchingLoss("Knockout:ResolutionGuaranteedLoss")
            return
        end
    end

    local lastRoundWinner = tryIndex({ "session", "public", "lastRoundWinner" })
    local opponentWonRound = numeric(lastRoundWinner, nil) == s.opponentSeat





    if opponentWonRound then
        if not tracker.knockoutOpponentLossPending then
            tracker.knockoutOpponentLossPending = true
            tracker.knockoutPendingRoundStartOpponentWins =
                tracker.roundStartOpponentWins
        end

        local beforeRound = tracker.knockoutPendingRoundStartOpponentWins
        local clinchedFromSnapshot = s.requiredWins ~= nil
            and beforeRound ~= nil
            and math.max(0, math.floor(numeric(beforeRound, 0)))
                == s.requiredWins - 1





        local clinchedFromLiveScore = s.requiredWins ~= nil
            and s.opponentWins >= s.requiredWins

        if clinchedFromSnapshot or clinchedFromLiveScore then
            latchClinchingLoss("Knockout:LastRoundWinner")
            tracker.lastRoundWinner = lastRoundWinner
            return
        end
    end




    if (s.phase == "Starting" or s.phase == "Aiming")
        and not opponentWonRound
    then
        tracker.knockoutOpponentLossPending = false
        tracker.knockoutPendingRoundStartOpponentWins = nil
    end

    tracker.lastRoundWinner = lastRoundWinner
end

local function processFootballDraft(s)
    local draft = readFootballDraftState(s.seatIndex)
    if not draft then
        return
    end

    if draft.opponentCompleted and not draft.myCompleted then
        tracker.footballOpponentCompletedFirstObserved = true
    elseif draft.myCompleted and not draft.opponentCompleted then
        tracker.footballLocalCompletedFirstObserved = true
    end

    if not exactRoundLossClinches(s.opponentWins, s.requiredWins) then
        return
    end







    if draft.opponentCompleted
        and not draft.myCompleted
        and draft.opponentOVR ~= nil
    then
        local myMaximum = footballMaxPossibleLocalOVR()
        if myMaximum ~= nil and draft.opponentOVR >= myMaximum then
            latchClinchingLoss("FootballDraft:OpponentCompletedUncatchable")
            return
        end
    end

    if draft.myCompleted
        and draft.opponentCompleted
        and draft.myOVR ~= nil
        and draft.opponentOVR ~= nil
    then
        if draft.opponentOVR > draft.myOVR then
            latchClinchingLoss("FootballDraft:FinalOVR")
            return
        end

        if draft.opponentOVR == draft.myOVR
            and tracker.footballOpponentCompletedFirstObserved
            and not tracker.footballLocalCompletedFirstObserved
        then
            latchClinchingLoss("FootballDraft:EqualOVROpponentFinishedFirst")
            return
        end
    end
end

local function processPopcorn(s)




    local stableBestOf = currentBestOfRounds()
    if stableBestOf ~= nil then
        tracker.popcornBestOfRounds = stableBestOf
    end

    local popcornRequiredWins = nil
    if tracker.popcornBestOfRounds ~= nil then
        popcornRequiredWins = winsRequired(tracker.popcornBestOfRounds)
    end

    local myState = readPopcornPrivateState("myState")
    local opponentState = readPopcornPrivateState("opponentState")

    local myTotalSlots, myRemaining = readPopcornKernelCounts(s.seatIndex)
    local opponentTotalSlots, opponentRemaining = readPopcornKernelCounts(s.opponentSeat)

    local myLiveKernel = popcornHasLiveKernel(myState)

    if not tracker.popcornRoundInitialized then
        initializePopcornRoundTracking(
            s,
            myState,
            opponentState,
            myTotalSlots,
            opponentTotalSlots,
            myRemaining,
            opponentRemaining
        )
    else





        local priorLocalWins = numeric(tracker.popcornRoundStartLocalWins, 0)
        local priorOpponentWins = numeric(tracker.popcornRoundStartOpponentWins, 0)
        local opponentScoreAdvanced = s.opponentWins > priorOpponentWins
        local localScoreAdvanced = s.localWins > priorLocalWins
        local scoreAdvanced = opponentScoreAdvanced or localScoreAdvanced






        if opponentScoreAdvanced
            and popcornRequiredWins ~= nil
            and priorOpponentWins == popcornRequiredWins - 1
            and s.opponentWins >= popcornRequiredWins
        then
            latchClinchingLoss("PopcornBurst:ClinchingSeriesScoreAdvanced")
            return
        end

        if scoreAdvanced and not tracker.popcornAwaitingFreshRound then
            tracker.popcornAwaitingFreshRound = true
            tracker.popcornPendingRoundLocalWins = s.localWins
            tracker.popcornPendingRoundOpponentWins = s.opponentWins
        end

        if tracker.popcornAwaitingFreshRound then



            local freshBoard = myRemaining ~= nil and myRemaining > 0
            local freshPrivate = myState.finished ~= true
            local freshKernelState = myLiveKernel
                or resultKey(myState.lastResult) == nil

            if freshBoard and freshPrivate and freshKernelState then
                local freshSnapshot = {
                    localWins = numeric(tracker.popcornPendingRoundLocalWins, s.localWins),
                    opponentWins = numeric(tracker.popcornPendingRoundOpponentWins, s.opponentWins),
                }

                initializePopcornRoundTracking(
                    freshSnapshot,
                    myState,
                    opponentState,
                    myTotalSlots,
                    opponentTotalSlots,
                    myRemaining,
                    opponentRemaining
                )
            else


                return
            end
        end
    end

    ensurePopcornRemainingBaselines(
        myState,
        opponentState,
        myRemaining,
        opponentRemaining
    )

    updatePopcornResultCounter(myState, false)
    updatePopcornResultCounter(opponentState, true)
    updatePopcornTerminalFlags(
        myState,
        opponentState,
        myRemaining,
        opponentRemaining
    )

    local myPoints, opponentPoints = readPopcornBoardPoints(s.seatIndex)

    if myPoints == nil then
        myPoints = popcornStateScore(myState)
    end
    if opponentPoints == nil then
        opponentPoints = popcornStateScore(opponentState)
    end




    if tracker.popcornSeenFromRoundStart then
        myPoints = tracker.popcornMyAccumulatedPoints
        opponentPoints = tracker.popcornOpponentAccumulatedPoints
    end

    local clinchingRound = popcornRequiredWins ~= nil
        and (
            (tracker.popcornRoundStartOpponentWins ~= nil
                and tracker.popcornRoundStartOpponentWins == popcornRequiredWins - 1)
            or s.opponentWins >= popcornRequiredWins
        )





    if clinchingRound then
        local layout = readPopcornKernelLayoutEitherSeat(
            s.seatIndex,
            s.opponentSeat
        )
        local processed = popcornProcessedKernelCount(myState, layout)
        local total = layout and layout.count
            or numeric(myState.totalKernels, nil)

        local remainingUpperBound = nil
        if myRemaining ~= nil then
            remainingUpperBound = math.max(0, math.floor(myRemaining))
        end
        if total ~= nil and processed ~= nil then
            local byProgress = math.max(
                0,
                math.floor(total - processed)
            )
            remainingUpperBound = remainingUpperBound == nil
                and byProgress
                or math.max(remainingUpperBound, byProgress)
        end

        local localScoreUpperBase = nil
        local function addLocalScoreCandidate(value)
            value = numeric(value, nil)
            if value ~= nil then
                localScoreUpperBase = localScoreUpperBase == nil
                    and value
                    or math.max(localScoreUpperBase, value)
            end
        end
        addLocalScoreCandidate(myPoints)
        addLocalScoreCandidate(popcornStateScore(myState))
        if tracker.popcornSeenFromRoundStart then
            addLocalScoreCandidate(tracker.popcornMyAccumulatedPoints)
        end




        local opponentScoreLowerBound = nil
        local function addOpponentScoreCandidate(value)
            value = numeric(value, nil)
            if value ~= nil then
                opponentScoreLowerBound = opponentScoreLowerBound == nil
                    and value
                    or math.min(opponentScoreLowerBound, value)
            end
        end
        addOpponentScoreCandidate(opponentPoints)
        addOpponentScoreCandidate(popcornStateScore(opponentState))
        if tracker.popcornSeenFromRoundStart then
            addOpponentScoreCandidate(tracker.popcornOpponentAccumulatedPoints)
        end

        if remainingUpperBound ~= nil
            and localScoreUpperBase ~= nil
            and opponentScoreLowerBound ~= nil
        then
            local absoluteMaxPossible =
                localScoreUpperBase + remainingUpperBound * 100
            if opponentScoreLowerBound > absoluteMaxPossible then
                latchClinchingLoss("PopcornBurst:MathematicallyUnwinnable")
                return
            end
        end
    end





    local liveWinner = tryIndex({ "session", "public", "winner" })
    local liveWinnerIdentity = publicWinnerIdentity(liveWinner)
    local winnerChanged = liveWinnerIdentity ~= tracker.publicWinner
    local liveWinnerIsOpponent = isOpponentPlayer(liveWinner, s.opponent)
    if not liveWinnerIsOpponent
        and s.opponentSeat ~= nil
        and tonumber(liveWinner) ~= nil
        and tonumber(liveWinner) == tonumber(s.opponentSeat)
    then
        liveWinnerIsOpponent = true
    end

    if clinchingRound and winnerChanged and liveWinnerIsOpponent then
        latchClinchingLoss("PopcornBurst:PublicWinnerTransition")
        return
    end







    if clinchingRound and tracker.popcornMyFinal then
        if myPoints ~= nil
            and opponentPoints ~= nil
            and opponentPoints > myPoints
        then
            latchClinchingLoss("PopcornBurst:FinalKernelScoreLost")
            return
        end





        if tracker.popcornSeenFromRoundStart
            and tracker.popcornOpponentAccumulatedPoints
                > tracker.popcornMyAccumulatedPoints
        then
            latchClinchingLoss("PopcornBurst:OpponentPassedFinalScore")
            return
        end




        local winner = tryIndex({ "session", "public", "winner" })
        if isOpponentPlayer(winner, s.opponent) then
            latchClinchingLoss("PopcornBurst:FinalPublicWinner")
            return
        end

        if popcornRequiredWins ~= nil
            and s.opponentWins >= popcornRequiredWins
        then
            latchClinchingLoss("PopcornBurst:FinalSeriesScore")
            return
        end
    end

    tracker.popcornWasFinished = myState.finished == true
    tracker.popcornLastActiveKernelSlot = myState.activeKernelSlot
    tracker.popcornLastResultCell = popcornResultCell(myState)
    tracker.popcornOpponentWasFinished = opponentState.finished == true
    tracker.popcornOpponentLastActiveKernelSlot = opponentState.activeKernelSlot
    tracker.popcornOpponentLastResultCell = popcornResultCell(opponentState)
end

local function processPublicWinnerTransition(s)
    local winner = tryIndex({ "session", "public", "winner" })
    local identity = publicWinnerIdentity(winner)
    local changed = identity ~= tracker.publicWinner

    if s.gameId ~= "PopcornBurst"
        and s.gameId ~= "CandyBomb"
        and changed
        and isOpponentPlayer(winner, s.opponent)
        and clinchPossibleFromRoundLoss(s.opponentWins, s.requiredWins)
    then
        latchClinchingLoss(s.gameId .. ":PublicWinner")
    end

    tracker.publicWinner = identity
end

local function processKnockoutMatchWinnerFallback(s)
    if s.gameId ~= "Knockout" then
        return
    end





    local matchWinner = tryIndex({ "session", "public", "matchWinner" })
    if isOpponentPlayer(matchWinner, s.opponent) then
        latchClinchingLoss("Knockout:MatchWinner")
    end
end

local function processMatchResultFallback(s)
    if not s or not SUPPORTED_GAMES[s.gameId] then
        return
    end





    local winnerIndex = numeric(
        tryIndex({ "matchResult", "winnerIndex" }),
        nil
    )

    if winnerIndex == nil then
        local matchResult = tryIndex({ "matchResult" })
        winnerIndex = numeric(safeIndex(matchResult, "winnerIndex"), nil)
    end

    if winnerIndex ~= nil and winnerIndex ~= 0 and winnerIndex ~= 1 then
        latchClinchingLoss(tostring(s.gameId) .. ":MatchResult")
    end
end

local function evaluateCachedTerminalState()
    local cachedGameId = tracker.gameId
    if not cachedGameId or not SUPPORTED_GAMES[cachedGameId] then
        return
    end

    local seatIndex = currentSeatIndex() or tracker.cachedSeatIndex
    local opponentSeat = opponentSeatIndex(seatIndex) or tracker.cachedOpponentSeat
    local opponent = currentOpponent() or tracker.cachedOpponent
    local bestOf = tracker.seriesBestOfRounds
        or tracker.votedBestOfRounds
    local requiredWins = tracker.cachedRequiredWins
    if requiredWins == nil and bestOf ~= nil then
        requiredWins = winsRequired(bestOf)
    end

    local localWins, opponentWins = readSeriesScores(cachedGameId, seatIndex)
    local s = {
        gameId = cachedGameId,
        phase = currentPhase(),
        seatIndex = seatIndex,
        opponentSeat = opponentSeat,
        bestOf = bestOf,
        requiredWins = requiredWins,
        localWins = localWins,
        opponentWins = opponentWins,
        opponent = opponent,
    }





    if cachedGameId == "CandyBomb" then
        processCandyBomb(s)
    elseif cachedGameId == "NumberGuess" then
        processNumberGuess(s)
    elseif cachedGameId == "ConnectFour" then
        processConnectFour(s)
    elseif cachedGameId == "Battleship" then
        processBattleship(s)
    elseif cachedGameId == "Knockout" then
        processKnockout(s)
        processKnockoutMatchWinnerFallback(s)
    elseif cachedGameId == "FootballDraft" then
        processFootballDraft(s)
    elseif cachedGameId == "PopcornBurst" then
        processPopcorn(s)
    end





    if requiredWins ~= nil and opponentWins >= requiredWins then
        latchClinchingLoss(cachedGameId .. ":SeriesScoreTeardown")
    end

    processPublicWinnerTransition(s)
    processMatchResultFallback(s)
end

evaluateState = function()
    if controller.destroyed or controller.triggered then
        return
    end




    readRoundVoteEvidence()

    local gameId = currentGameId()






    if gameId == nil and tracker.gameId and SUPPORTED_GAMES[tracker.gameId] then
        tracker.gameIdTeardownSeen = true
        evaluateCachedTerminalState()
        tracker.phase = currentPhase()
        return
    end

    if gameId ~= tracker.gameId or tracker.gameIdTeardownSeen then
        resetTracker(gameId)
    end

    if not gameId or not SUPPORTED_GAMES[gameId] then
        tracker.phase = currentPhase()
        return
    end

    local liveSeatIndex = currentSeatIndex()
    if liveSeatIndex ~= nil then
        tracker.cachedSeatIndex = liveSeatIndex
        tracker.cachedOpponentSeat = opponentSeatIndex(liveSeatIndex)
    end

    local seatIndex = liveSeatIndex or tracker.cachedSeatIndex
    local opponentSeat = opponentSeatIndex(seatIndex) or tracker.cachedOpponentSeat
    local bestOf = currentBestOfRounds()
    local requiredWins = if bestOf ~= nil then winsRequired(bestOf) else nil
    if requiredWins ~= nil then
        tracker.cachedRequiredWins = requiredWins
    elseif gameId == "Knockout" then
        requiredWins = tracker.cachedRequiredWins
    end
    local localWins, opponentWins = readSeriesScores(gameId, seatIndex)
    local phase = currentPhase()

    local liveOpponent = currentOpponent()
    if liveOpponent ~= nil then
        tracker.cachedOpponent = liveOpponent
    end
    local opponent = liveOpponent or tracker.cachedOpponent

    local s = {
        gameId = gameId,
        phase = phase,
        seatIndex = seatIndex,
        opponentSeat = opponentSeat,
        bestOf = bestOf,
        requiredWins = requiredWins,
        localWins = localWins,
        opponentWins = opponentWins,
        opponent = opponent,
    }

    if not tracker.initialized then
        tracker.initialized = true
        tracker.phase = phase
        tracker.localWins = localWins
        tracker.opponentWins = opponentWins
        tracker.roundStartLocalWins = localWins
        tracker.roundStartOpponentWins = opponentWins
        tracker.publicWinner = publicWinnerIdentity(
            tryIndex({ "session", "public", "winner" })
        )
        tracker.lastRoundWinner = tryIndex({ "session", "public", "lastRoundWinner" })

        if gameId == "CandyBomb" then
            local observedBombs = countCandyBombsHit()
            tracker.candyBombsHit = observedBombs or 0
            tracker.candyBombEvents = tracker.candyBombsHit
            tracker.candyLastObservedBoardBombs = observedBombs
            tracker.candyAwaitingFreshBoard = false
            tracker.candyAwaitingBoardToken = nil
            tracker.candyBoardFreshConfirmed = observedBombs ~= nil
            armCandyRoundFromCurrentSeries()
        end

        if gameId == "NumberGuess" then
            local log = tryIndex({ "session", "public", "guessLog" })
            tracker.guessCount = log ~= nil and safeSequenceLength(log, 256) or nil
        end

        if gameId == "PopcornBurst" then
            local myState = readPopcornPrivateState("myState")
            local opponentState = readPopcornPrivateState("opponentState")



            tracker.popcornRoundInitialized = false
            tracker.popcornRoundStartLocalWins = localWins
            tracker.popcornRoundStartOpponentWins = opponentWins
            tracker.popcornAwaitingFreshRound = false
            tracker.popcornPendingRoundLocalWins = nil
            tracker.popcornPendingRoundOpponentWins = nil
            tracker.popcornSeenFromRoundStart = false
            tracker.popcornWasFinished = myState.finished == true
            tracker.popcornLastActiveKernelSlot = myState.activeKernelSlot
            tracker.popcornLastResultCell = popcornResultCell(myState)
            tracker.popcornOpponentWasFinished = opponentState.finished == true
            tracker.popcornOpponentLastActiveKernelSlot = opponentState.activeKernelSlot
            tracker.popcornOpponentLastResultCell = popcornResultCell(opponentState)
        end
    end




    local roundStartPhases = ROUND_START_PHASES[gameId]
    if tracker.initialized
        and gameId ~= "PopcornBurst"
        and roundStartPhases
        and roundStartPhases[phase] == true
        and phase ~= tracker.phase
    then
        tracker.roundStartLocalWins = localWins
        tracker.roundStartOpponentWins = opponentWins

        if gameId == "Knockout" then
            tracker.knockoutOpponentLossPending = false
            tracker.knockoutPendingRoundStartOpponentWins = nil
            table.clear(tracker.knockoutRoundPuckTeams)
        elseif gameId == "ConnectFour" then
            tracker.connectFourAwaitingFreshRound = true
            tracker.connectFourRoundArmed = false
        elseif gameId == "Battleship" then
            tracker.battleshipAwaitingFreshRound = true
            tracker.battleshipRoundArmed = false
        end
    elseif tracker.roundStartOpponentWins == nil then
        tracker.roundStartLocalWins = localWins
        tracker.roundStartOpponentWins = opponentWins
    elseif opponentWins < tracker.roundStartOpponentWins then

        tracker.roundStartLocalWins = localWins
        tracker.roundStartOpponentWins = opponentWins
    end

    if gameId == "Knockout"
        and (phase == "Starting" or phase == "Aiming" or phase == "Launching")
    then
        cacheKnockoutRoundPucks(s)
    end




    if gameId ~= "PopcornBurst"
        and gameId ~= "CandyBomb"
        and requiredWins ~= nil
        and opponentWins >= requiredWins
    then
        latchClinchingLoss(gameId .. ":SeriesScore")
    end

    if gameId == "CandyBomb" then
        processCandyBomb(s)
    elseif gameId == "NumberGuess" then
        processNumberGuess(s)
    elseif gameId == "ConnectFour" then
        processConnectFour(s)
    elseif gameId == "Battleship" then
        processBattleship(s)
    elseif gameId == "Knockout" then
        processKnockout(s)
    elseif gameId == "FootballDraft" then
        processFootballDraft(s)
    elseif gameId == "PopcornBurst" then
        processPopcorn(s)
    end

    processPublicWinnerTransition(s)
    processKnockoutMatchWinnerFallback(s)
    processMatchResultFallback(s)

    tracker.phase = phase
    tracker.localWins = localWins
    tracker.opponentWins = opponentWins
end




if MinigameBombExplosion and MinigameBombExplosion.OnClientEvent then
    addConnection(MinigameBombExplosion.OnClientEvent:Connect(function(_, explodedPlayer)
        if controller.destroyed or controller.triggered then
            return
        end

        if currentGameId() ~= "CandyBomb" or explodedPlayer ~= LocalPlayer then
            return
        end




        syncCandyBombBoardCount()
        if tracker.candyAwaitingFreshBoard then
            tracker.candyAwaitingFreshBoard = false
            tracker.candyAwaitingBoardToken = nil
            tracker.candyBoardFreshConfirmed = true
            resetCandyRoundBombCounter(0)
            armCandyRoundFromCurrentSeries()
        elseif tracker.candyRoundStartOpponentWins == nil then
            tracker.candyBoardFreshConfirmed = true
            armCandyRoundFromCurrentSeries()
        end

        tracker.candyBombEvents = math.min(3, tracker.candyBombEvents + 1)
        tracker.candyBombsHit = tracker.candyBombEvents



        if tracker.candyBombEvents == 3 then
            local bestOf = currentBestOfRounds()
            local requiredWins = bestOf and winsRequired(bestOf) or nil
            local seatIndex = currentSeatIndex()
            local _, liveOpponentWins = readSeriesScores("CandyBomb", seatIndex)

            if tracker.candyClinchRoundArmed == true
                or exactRoundLossClinches(liveOpponentWins, requiredWins)
            then
                latchClinchingLoss("CandyBomb:ThirdBombEvent")
                return
            end
        end

        evaluateState()
    end))
end



local okRaw, rawListener = pcall(function()
    return ActiveMinigame:ListenRaw(function()
        controller.evaluationRequested = true
    end)
end)
if okRaw then
    addDisconnector(rawListener)
end




do
    local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local minigameGui = playerGui and playerGui:FindFirstChild("MinigameGui")
    local votingGui = minigameGui and minigameGui:FindFirstChild("Voting")
    local bestOfGui = votingGui and votingGui:FindFirstChild("BestofGamemode")
    local list = bestOfGui and bestOfGui:FindFirstChild("List")

    if list then
        for _, item in ipairs({
            { button = list:FindFirstChild("One"), value = 1 },
            { button = list:FindFirstChild("Three"), value = 3 },
            { button = list:FindFirstChild("Five"), value = 5 },
        }) do
            if item.button and item.button:IsA("GuiButton") then
                addConnection(item.button.Activated:Connect(function()
                    tracker.votedBestOfRounds = item.value
                    if item.value > 1 then
                        tracker.seriesBestOfRounds = item.value
                        tracker.bestOfOneCandidateSince = nil
                    end
                end))
            end
        end
    end
end



local okPrivate, privateListener = pcall(function()
    return ActiveMinigame:Listen({ "session", "private" }, function(privateValue)
        controller.queuedPopcornPrivatePayload = privateValue
        controller.queuedPopcornPrivatePayloadSet = true

        if tracker.gameId == "PopcornBurst"
            and tracker.popcornRoundInitialized
            and tracker.popcornSeenFromRoundStart
            and cachedClinchRoundReady()
        then
            tracker.popcornPrivatePayload = privateValue
            local myState = safeIndex(privateValue, "myState")
            local opponentState = safeIndex(privateValue, "opponentState")

            if myState ~= nil then
                updatePopcornResultCounter(myState, false)
                if tracker.popcornMyExpectedResults ~= nil
                    and tracker.popcornMyExpectedResults > 0
                    and tracker.popcornMyResultsSinceBaseline
                        >= tracker.popcornMyExpectedResults
                then
                    tracker.popcornMyFinal = true
                end
            end

            if opponentState ~= nil then
                updatePopcornResultCounter(opponentState, true)
                if tracker.popcornOpponentExpectedResults ~= nil
                    and tracker.popcornOpponentExpectedResults > 0
                    and tracker.popcornOpponentResultsSinceBaseline
                        >= tracker.popcornOpponentExpectedResults
                then
                    tracker.popcornOpponentFinal = true
                end
            end

            local expected = tracker.popcornMyExpectedResults
            if expected ~= nil and expected >= 0 then
                local remaining = math.max(
                    0,
                    expected - tracker.popcornMyResultsSinceBaseline
                )
                local absoluteMaxPossible =
                    tracker.popcornMyAccumulatedPoints + remaining * 100
                if tracker.popcornOpponentAccumulatedPoints > absoluteMaxPossible then
                    latchClinchingLoss("PopcornBurst:PrivateUnwinnableScoreSignal")
                elseif tracker.popcornMyFinal
                    and tracker.popcornOpponentAccumulatedPoints
                        > tracker.popcornMyAccumulatedPoints
                then
                    latchClinchingLoss("PopcornBurst:PrivateResultSignal")
                end
            elseif tracker.popcornMyFinal
                and tracker.popcornOpponentAccumulatedPoints
                    > tracker.popcornMyAccumulatedPoints
            then
                latchClinchingLoss("PopcornBurst:PrivateResultSignal")
            end
        end

        controller.evaluationRequested = true
    end)
end)
if okPrivate then
    addDisconnector(privateListener)
end




for _, path in ipairs({
    { "session", "public", "phase" },
    { "session", "public", "resolution" },
    { "session", "public", "pucks" },
    { "session", "public", "lastRoundWinner" },
    { "session", "public", "matchWinner" },
    { "session", "public", "playerWins", 1 },
    { "session", "public", "playerWins", 2 },
}) do
    local ok, listener = pcall(function()
        return ActiveMinigame:Listen(path, function(value)
            local leaf = path[#path]
            if leaf == "matchWinner" then
                controller.queuedKnockoutMatchWinner = value
                controller.queuedKnockoutMatchWinnerSet = true
                if value ~= nil
                    and tracker.cachedOpponent ~= nil
                    and value == tracker.cachedOpponent
                then
                    latchClinchingLoss("Knockout:MatchWinnerSignal")
                end
            elseif leaf == "lastRoundWinner" then
                controller.queuedKnockoutLastRoundWinner = value
                controller.queuedKnockoutLastRoundWinnerSet = true

                local opponentSeat = tracker.cachedOpponentSeat
                local requiredWins = tracker.cachedRequiredWins
                local beforeRound = tracker.roundStartOpponentWins
                if beforeRound == nil then
                    beforeRound = tracker.opponentWins
                end
                if tonumber(value) ~= nil
                    and tonumber(value) == tonumber(opponentSeat)
                    and requiredWins ~= nil
                    and beforeRound ~= nil
                    and math.max(0, math.floor(numeric(beforeRound, 0))) == requiredWins - 1
                then
                    latchClinchingLoss("Knockout:LastRoundWinnerSignal")
                end
            elseif leaf == "resolution" then
                local seatIndex = tracker.cachedSeatIndex
                local opponentSeat = tracker.cachedOpponentSeat
                local requiredWins = tracker.cachedRequiredWins
                local beforeRound = tracker.roundStartOpponentWins
                if beforeRound == nil then
                    beforeRound = tracker.opponentWins
                end
                cacheKnockoutReplicatedPuckTeams(seatIndex, opponentSeat)
                if requiredWins ~= nil
                    and beforeRound ~= nil
                    and math.max(0, math.floor(numeric(beforeRound, 0))) == requiredWins - 1
                    and knockoutResolutionPayloadProvesLoss(value, seatIndex, opponentSeat)
                then
                    controller.queuedKnockoutResolutionLoss = true
                    latchClinchingLoss("Knockout:ResolutionSignalGuaranteedLoss")
                end
            end
            controller.evaluationRequested = true
        end)
    end)
    if ok then
        addDisconnector(listener)
    end
end



do
    local ok, listener = pcall(function()
        return ActiveMinigame:Listen({ "session", "private", "myBoard", "cells" }, function(cells)
            if tracker.gameId ~= "CandyBomb"
                or tracker.candyClinchRoundArmed ~= true
                or cells == nil
            then
                controller.evaluationRequested = true
                return
            end

            local bombs = 0
            local sawCell = false
            for index = 1, 32 do
                local cell = safeIndex(cells, index)
                if cell ~= nil then
                    sawCell = true
                    if safeIndex(cell, "eaten") == true
                        and safeIndex(cell, "wasBomb") == true
                    then
                        bombs += 1
                    end
                elseif sawCell then
                    break
                end
            end

            if bombs >= 3 then
                controller.queuedCandyThirdBombState = true
                latchClinchingLoss("CandyBomb:ThirdBombStateSignal")
            end
            controller.evaluationRequested = true
        end)
    end)
    if ok then addDisconnector(listener) end
end




for seat = 1, 2 do
    local path = { "playerWins", seat }
    local ok, listener = pcall(function()
        return ActiveMinigame:Listen(path, function(value)
            local gameId = tracker.gameId or currentGameId()
            if gameId
                and SUPPORTED_GAMES[gameId]
                and gameId ~= "CandyBomb"
                and tracker.cachedOpponentSeat == seat
                and tracker.cachedRequiredWins ~= nil
                and numeric(value, -1) >= tracker.cachedRequiredWins
            then
                latchClinchingLoss(gameId .. ":SeriesScoreSignal")
            end
            controller.evaluationRequested = true
        end)
    end)
    if ok then addDisconnector(listener) end
end




cachedClinchRoundReady = function()
    local requiredWins = tracker.cachedRequiredWins
    local popcornContext = tracker.gameId == "PopcornBurst"
        or currentGameId() == "PopcornBurst"
    if requiredWins == nil and popcornContext then
        local bestOf = tracker.popcornBestOfRounds
            or tracker.seriesBestOfRounds
            or tracker.votedBestOfRounds
        if bestOf ~= nil then
            requiredWins = winsRequired(bestOf)
        end
    end
    if requiredWins == nil then
        return false
    end

    local beforeRound = popcornContext
        and tracker.popcornRoundStartOpponentWins
        or tracker.roundStartOpponentWins
    if beforeRound == nil then
        beforeRound = tracker.opponentWins
    end
    return beforeRound ~= nil
        and math.max(0, math.floor(numeric(beforeRound, 0))) == requiredWins - 1
end

do
    local ok, listener = pcall(function()
        return ActiveMinigame:Listen({ "session", "public", "guessLog" }, function(guessLog)
            if tracker.gameId == "NumberGuess"
                and cachedClinchRoundReady()
                and guessLog ~= nil
            then
                local count = safeSequenceLength(guessLog, 256)
                local entry = safeIndex(guessLog, count)
                if safeIndex(entry, "response") == "Correct"
                    and numeric(safeIndex(entry, "guesserIndex"), nil)
                        == tracker.cachedOpponentSeat
                then
                    latchClinchingLoss("NumberGuess:CorrectSignal")
                end
            end
            controller.evaluationRequested = true
        end)
    end)
    if ok then addDisconnector(listener) end
end

do
    local ok, listener = pcall(function()
        return ActiveMinigame:Listen({ "session", "public", "grid" }, function(grid)
            if tracker.gameId == "ConnectFour"
                and tracker.cachedOpponentSeat ~= nil
                and tracker.connectFourAwaitingFreshRound ~= true
                and cachedClinchRoundReady()
                and hasConnectFourWin(grid, tracker.cachedOpponentSeat)
            then
                latchClinchingLoss("ConnectFour:FourInRowSignal")
            end
            controller.evaluationRequested = true
        end)
    end)
    if ok then addDisconnector(listener) end
end

local function fastBattleshipTerminalCheck()
    if tracker.gameId ~= "Battleship"
        or tracker.battleshipAwaitingFreshRound == true
        or not cachedClinchRoundReady()
    then
        return
    end
    local seatIndex = tracker.cachedSeatIndex
    if seatIndex ~= nil and ownBattleshipsAllHitByOpponentShots(seatIndex) then
        latchClinchingLoss("Battleship:AllOwnShipCellsHitSignal")
        return
    end
    if seatIndex ~= nil and ownBattleshipsAllSunk(seatIndex) then
        latchClinchingLoss("Battleship:AllOwnShipsSunkSignal")
    end
end

for _, path in ipairs({
    { "session", "public", "shots", 1 },
    { "session", "public", "shots", 2 },
    { "session", "public", "sunkShipDetails", 1 },
    { "session", "public", "sunkShipDetails", 2 },
}) do
    local ok, listener = pcall(function()
        return ActiveMinigame:Listen(path, function()
            fastBattleshipTerminalCheck()
            controller.evaluationRequested = true
        end)
    end)
    if ok then addDisconnector(listener) end
end

local function fastFootballTerminalCheck()
    if tracker.gameId ~= "FootballDraft" or not cachedClinchRoundReady() then
        return
    end
    local seatIndex = tracker.cachedSeatIndex
    if seatIndex == nil then
        return
    end
    processFootballDraft({
        gameId = "FootballDraft",
        seatIndex = seatIndex,
        opponentSeat = tracker.cachedOpponentSeat,
        requiredWins = tracker.cachedRequiredWins,
        localWins = tracker.localWins,
        opponentWins = tracker.opponentWins,
        opponent = tracker.cachedOpponent,
    })
end

for _, path in ipairs({
    { "session", "public", "totalOVR", 1 },
    { "session", "public", "totalOVR", 2 },
    { "session", "public", "completed", 1 },
    { "session", "public", "completed", 2 },
    { "session", "private", "lineup" },
}) do
    local ok, listener = pcall(function()
        return ActiveMinigame:Listen(path, function()
            fastFootballTerminalCheck()
            controller.evaluationRequested = true
        end)
    end)
    if ok then addDisconnector(listener) end
end


for _, path in ipairs({
    { "session", "private", "myBoard", "cells" },
    { "session", "public", "guessLog" },
    { "session", "public", "grid" },
    { "session", "public", "winCells" },
    { "session", "public", "winner" },
    { "session", "public", "phase" },
    { "session", "public", "sunkShipDetails" },
    { "session", "public", "shots", 1 },
    { "session", "public", "shots", 2 },
    { "session", "public", "totalOVR", 1 },
    { "session", "public", "totalOVR", 2 },
    { "session", "public", "completed", 1 },
    { "session", "public", "completed", 2 },
    { "session", "private", "lineup" },
    { "session", "private", "myState" },
    { "session", "private", "opponentState" },
}) do
    local ok, listener = pcall(function()
        return ActiveMinigame:Listen(path, function()
            controller.evaluationRequested = true
        end)
    end)
    if ok then
        addDisconnector(listener)
    end
end




do
    local ok, listener = pcall(function()
        return ActiveMinigame:Listen({ "session", "public", "winner" }, function(value)
            if value ~= nil then
                controller.queuedPopcornPublicWinner = value
                controller.queuedPopcornPublicWinnerSet = true

                local opponentWinner = tracker.cachedOpponent ~= nil
                    and value == tracker.cachedOpponent
                if not opponentWinner
                    and tracker.cachedOpponentSeat ~= nil
                    and tonumber(value) ~= nil
                    and tonumber(value) == tonumber(tracker.cachedOpponentSeat)
                then
                    opponentWinner = true
                end

                if opponentWinner then
                    if tracker.gameId == "PopcornBurst" and cachedClinchRoundReady() then
                        latchClinchingLoss("PopcornBurst:PublicWinnerSignal")
                    elseif tracker.gameId ~= nil
                        and tracker.gameId ~= "CandyBomb"
                        and cachedClinchRoundReady()
                    then
                        latchClinchingLoss(tostring(tracker.gameId) .. ":PublicWinnerSignal")
                    end
                end
            end
            controller.evaluationRequested = true
        end)
    end)
    if ok then
        addDisconnector(listener)
    end
end





do
    local ok, listener = pcall(function()
        return ActiveMinigame:Observe({ "matchResult" }, function(result)
            if result ~= nil then
                controller.queuedMatchResultWinnerIndex = tonumber(
                    safeIndex(result, "winnerIndex")
                )
                controller.queuedMatchResultSet =
                    controller.queuedMatchResultWinnerIndex ~= nil

                local winnerIndex = controller.queuedMatchResultWinnerIndex
                local gameId = currentGameId() or tracker.gameId
                if winnerIndex ~= nil
                    and winnerIndex ~= 0
                    and winnerIndex ~= 1
                    and gameId
                    and SUPPORTED_GAMES[gameId]
                then
                    latchClinchingLoss(tostring(gameId) .. ":MatchResultSignal")
                end
            end
        end)
    end)
    if ok then
        addDisconnector(listener)
    end
end


for _, path in ipairs({
    { "voting" },
    { "session" },
    { "session", "gameId" },
    { "session", "public" },
    { "playerWins" },
    { "bestOfRounds" },
    { "matchResult" },
}) do
    local ok, listener = pcall(function()
        return ActiveMinigame:Listen(path, function()
            controller.evaluationRequested = true
        end)
    end)
    if ok then
        addDisconnector(listener)
    end
end

local function consumeQueuedReplicatorSignals()
    if controller.queuedCandyThirdBombState then
        controller.queuedCandyThirdBombState = false
        if (currentGameId() == "CandyBomb" or tracker.gameId == "CandyBomb")
            and tracker.candyClinchRoundArmed == true
        then
            latchClinchingLoss("CandyBomb:ThirdBombStateSignal")
        end
    end

    if controller.queuedKnockoutResolutionLoss then
        controller.queuedKnockoutResolutionLoss = false
        if currentGameId() == "Knockout" or tracker.gameId == "Knockout" then
            latchClinchingLoss("Knockout:ResolutionSignalGuaranteedLoss")
        end
    end

    if controller.queuedPopcornPublicWinnerSet then
        controller.queuedPopcornPublicWinnerSet = false
        local value = controller.queuedPopcornPublicWinner
        controller.queuedPopcornPublicWinner = nil

        local popcornContext = currentGameId() == "PopcornBurst"
            or tracker.gameId == "PopcornBurst"
        if popcornContext then
            local opponent = currentOpponent() or tracker.cachedOpponent
            local opponentSeat = opponentSeatIndex(currentSeatIndex())
                or tracker.cachedOpponentSeat
            local requiredWins = tracker.cachedRequiredWins
            if requiredWins == nil then
                local bestOf = tracker.popcornBestOfRounds
                    or tracker.seriesBestOfRounds
                    or tracker.votedBestOfRounds
                if bestOf ~= nil then
                    requiredWins = winsRequired(bestOf)
                end
            end

            local beforeRound = tracker.popcornRoundStartOpponentWins
            if beforeRound == nil then
                beforeRound = tracker.roundStartOpponentWins
            end

            local opponentWinner = isOpponentPlayer(value, opponent)
            if not opponentWinner
                and opponentSeat ~= nil
                and tonumber(value) ~= nil
                and tonumber(value) == tonumber(opponentSeat)
            then
                opponentWinner = true
            end

            local _, liveOpponentWins = readSeriesScores(
                "PopcornBurst",
                currentSeatIndex() or tracker.cachedSeatIndex
            )
            local clinchingWinner = requiredWins ~= nil
                and (
                    (beforeRound ~= nil
                        and math.max(0, math.floor(numeric(beforeRound, 0)))
                            == requiredWins - 1)
                    or numeric(liveOpponentWins, 0) >= requiredWins
                )

            if opponentWinner and clinchingWinner then
                latchClinchingLoss("PopcornBurst:QueuedPublicWinner")
            end
        end
    end

    if controller.queuedMatchResultSet then
        controller.queuedMatchResultSet = false
        local winnerIndex = tonumber(controller.queuedMatchResultWinnerIndex)
        controller.queuedMatchResultWinnerIndex = nil
        local gameId = currentGameId() or tracker.gameId
        if winnerIndex ~= nil
            and winnerIndex ~= 0
            and winnerIndex ~= 1
            and gameId
            and SUPPORTED_GAMES[gameId]
        then
            latchClinchingLoss(tostring(gameId) .. ":MatchResultQueued")
        end
    end

    if controller.queuedPopcornPrivatePayloadSet then
        controller.queuedPopcornPrivatePayloadSet = false
        if currentGameId() == "PopcornBurst"
            and controller.queuedPopcornPrivatePayload ~= nil
        then
            tracker.popcornPrivatePayload = controller.queuedPopcornPrivatePayload
        else
            tracker.popcornPrivatePayload = nil
        end
        controller.queuedPopcornPrivatePayload = nil
    end

    local knockoutContext = currentGameId() == "Knockout"
        or tracker.gameId == "Knockout"

    if controller.queuedKnockoutMatchWinnerSet then
        controller.queuedKnockoutMatchWinnerSet = false
        local value = controller.queuedKnockoutMatchWinner
        controller.queuedKnockoutMatchWinner = nil
        if knockoutContext then
            local opponent = currentOpponent() or tracker.cachedOpponent
            if isOpponentPlayer(value, opponent) then
                latchClinchingLoss("Knockout:MatchWinnerQueued")
            end
        end
    end

    if controller.queuedKnockoutLastRoundWinnerSet then
        controller.queuedKnockoutLastRoundWinnerSet = false
        local value = numeric(controller.queuedKnockoutLastRoundWinner, nil)
        controller.queuedKnockoutLastRoundWinner = nil
        if knockoutContext then
            local opponentSeat = opponentSeatIndex(currentSeatIndex())
                or tracker.cachedOpponentSeat
            local requiredWins = tracker.cachedRequiredWins
            local beforeRound = tracker.knockoutPendingRoundStartOpponentWins
                or tracker.roundStartOpponentWins
            if opponentSeat ~= nil
                and value == opponentSeat
                and requiredWins ~= nil
                and beforeRound ~= nil
                and math.max(0, math.floor(numeric(beforeRound, 0)))
                    == requiredWins - 1
            then
                latchClinchingLoss("Knockout:LastRoundWinnerQueued")
            end
        end
    end
end




addConnection(TeleportService.TeleportInitFailed:Connect(function(player)
    if player == LocalPlayer and controller.pendingLossReason ~= nil then
        controller.triggered = false
        controller.lastDepartureAttemptAt = 0
    end
end))





local function urgentDeparturePump()
    if controller.pendingLossReason ~= nil then
        executePendingLossIfReady()
    end
end

pcall(function()
    addConnection(RunService.PreSimulation:Connect(urgentDeparturePump))
end)
addConnection(RunService.Stepped:Connect(urgentDeparturePump))
pcall(function()
    addConnection(RunService.RenderStepped:Connect(urgentDeparturePump))
end)

do
    local nextFallbackEvaluationAt = 0
    addConnection(RunService.Heartbeat:Connect(function()



        consumeQueuedReplicatorSignals()

        local now = os.clock()
        local gameId = currentGameId()
        local activeSupportedGame = gameId and SUPPORTED_GAMES[gameId] == true
        local shouldEvaluate = controller.evaluationRequested == true






        if not shouldEvaluate and now >= nextFallbackEvaluationAt then
            shouldEvaluate = true
            nextFallbackEvaluationAt = now + (activeSupportedGame and 0.05 or 0.25)
        end

        if shouldEvaluate then
            controller.evaluationRequested = false
            evaluateState()
            nextFallbackEvaluationAt = math.max(
                nextFallbackEvaluationAt,
                now + (activeSupportedGame and 0.05 or 0.25)
            )
        end



        executePendingLossIfReady()
    end))
end




task.spawn(function()
    local lastActiveGame = nil
    local nextRefreshAt = 0

    while not controller.destroyed and not controller.triggered do
        local utility = rawget(_G, "__TUFFHUB_UTILITY_FEATURES")
        local gameId = currentGameId()
        local enabled = type(utility) == "table"
            and utility.LeaveWhenAboutToLose == true
            and utility.PauseScript ~= true
            and utility.PauseMinigameFeatures ~= true
            and gameId ~= nil
            and SUPPORTED_GAMES[gameId] == true

        if enabled then
            local now = os.clock()
            if gameId ~= lastActiveGame or now >= nextRefreshAt then
                lastActiveGame = gameId
                nextRefreshAt = now + DESTINATION_REFRESH_INTERVAL
                refreshDestinationServer(true)
            end
            task.wait(0.50)
        else
            lastActiveGame = nil
            nextRefreshAt = 0
            task.wait(0.75)
        end
    end
end)



task.defer(evaluateState)

function controller:Destroy()
    if self.destroyed then
        return
    end

    self.destroyed = true

    for _, disconnect in ipairs(self.disconnectors) do
        pcall(disconnect)
    end
    table.clear(self.disconnectors)

    for _, connection in ipairs(self.connections) do
        pcall(function()
            connection:Disconnect()
        end)
    end
    table.clear(self.connections)

    if rawget(_G, GLOBAL_KEY) == self then
        rawset(_G, GLOBAL_KEY, nil)
    end
end
end)