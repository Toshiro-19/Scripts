local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10)

-- ≡ Configuration
local CONFIG = {
    COLORS = {
        DARK_GRAY = Color3.fromRGB(40, 40, 40),
        WHITE = Color3.fromRGB(255, 255, 255),
        GREEN = Color3.fromRGB(0, 170, 127)
    },
    SPLASH_TWEEN_INFO = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
    -- Mapeo de PlaceId a URLs de scripts en GitHub
    GAME_SCRIPTS = {
        ["17046616162"] = "https://raw.githubusercontent.com/62883/ToshiX-Project/main/Scripts/LastToLeave.lua", -- Last to Leave (placeholder, reemplaza con URL real)
        ["17305810799"] = "https://raw.githubusercontent.com/62883/ToshiX-Project/main/Scripts/NPCorDie.lua", -- NPC or Die (placeholder, reemplaza con URL real)
        ["15698198545"] = "https://raw.githubusercontent.com/62883/ToshiX-Project/main/Dead%20Rails.lua.txt", -- Dead Rails
        ["14025040428"] = "https://raw.githubusercontent.com/62883/ToshiX-Project/main/Rebirths%20Ultimate.txt", -- Rebirth Champions Ultimate
        ["14459537874"] = "https://raw.githubusercontent.com/62883/ToshiX-Project/main/Scripts/GrowAGarden.lua", -- Grow a Garden (placeholder, reemplaza con URL real)
        ["15549609922"] = "https://raw.githubusercontent.com/62883/ToshiX-Project/main/Fisch" -- Fisch
    }
}

-- ≡ Utility Functions
local function destroyExistingSplash()
    local splash = playerGui:FindFirstChild("ToshiXSplash")
    if splash then
        splash:Destroy()
        print("Destroyed existing splash GUI")
    end
end

local function createSplashScreen()
    local splash = Instance.new("ScreenGui")
    splash.Name = "ToshiXSplash"
    splash.IgnoreGuiInset = true
    splash.ResetOnSpawn = false
    splash.Parent = playerGui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = CONFIG.COLORS.DARK_GRAY
    bg.BackgroundTransparency = 0.2
    bg.Parent = splash

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 200, 0, 60)
    title.Position = UDim2.new(0.5, -150, 0.4, -50)
    title.Text = "ToshiX"
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 60
    title.TextColor3 = CONFIG.COLORS.WHITE
    title.BackgroundTransparency = 1
    title.TextTransparency = 1
    title.Parent = bg

    local author = Instance.new("TextLabel")
    author.Size = UDim2.new(0, 200, 0, 30)
    author.Position = UDim2.new(0.5, -100, 0.55, 0)
    author.Text = "by ToshiX"
    author.Font = Enum.Font.GothamSemibold
    author.TextSize = 20
    author.TextColor3 = CONFIG.COLORS.GREEN
    author.BackgroundTransparency = 1
    author.TextTransparency = 1
    author.Parent = bg

    print("Splash screen created")
    return splash, bg, title, author
end

local function animateSplashScreen(splash, bg, title, author)
    local tweenInfo = CONFIG.SPLASH_TWEEN_INFO

    local titleTweenIn = TweenService:Create(title, tweenInfo, {
        TextTransparency = 0,
        Size = UDim2.new(0, 300, 0, 100)
    })
    titleTweenIn:Play()
    titleTweenIn.Completed:Wait()

    local authorTweenIn = TweenService:Create(author, tweenInfo, {TextTransparency = 0})
    authorTweenIn:Play()
    authorTweenIn.Completed:Wait()

    task.wait(1)

    local titleTweenOut = TweenService:Create(title, tweenInfo, {TextTransparency = 1})
    local authorTweenOut = TweenService:Create(author, tweenInfo, {TextTransparency = 1})
    local bgTweenOut = TweenService:Create(bg, tweenInfo, {BackgroundTransparency =  Marianne)

    titleTweenOut:Play()
    authorTweenOut:Play()
    bgTweenOut:Play()
    bgTweenOut.Completed:Wait()

    splash:Destroy()
    print("Splash screen animation completed and destroyed")
end

local function showError(message)
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0, 200, 0, 50)
    notification.Position = UDim2.new(0.5, -100, 0.1, 0)
    notification.BackgroundColor3 = Color3.fromRGB(255, 85, 85) -- Red
    notification.Text = message
    notification.TextColor3 = CONFIG.COLORS.WHITE
    notification.TextSize = 14
    notification.Font = Enum.Font.GothamSemibold
    notification.BackgroundTransparency = 0.3
    notification.TextScaled = true
    notification.Parent = playerGui

    local tween = TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundTransparency = 1, TextTransparency = 1})
    tween:Play()
    tween.Completed:Connect(function()
        notification:Destroy()
    end)
    print("Error shown: " .. message)
end

local function detectAndExecuteGameScript()
    -- Obtener el PlaceId del juego actual
    local placeId = tostring(game.PlaceId)
    local success, gameInfo = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    local gameName = success and gameInfo.Name or "Unknown Game"
    print("Detected game: " .. gameName .. " (PlaceId: " .. placeId .. ")")

    -- Verificar si hay un script para este juego
    local scriptUrl = CONFIG.GAME_SCRIPTS[placeId]
    if scriptUrl then
        print("Found script for game: " .. scriptUrl)
        local success, result = pcall(function()
            local scriptContent = game:HttpGet(scriptUrl)
            return loadstring(scriptContent)()
        end)
        if not success then
            warn("Failed to execute script for game " .. gameName .. ": " .. tostring(result))
            showError("Failed to load script for " .. gameName)
        else
            print("Script executed successfully for " .. gameName)
        end
    else
        print("No script found for game: " .. gameName .. " (PlaceId: " .. placeId .. ")")
        showError("No script available for " .. gameName)
    end
end

-- ≡ Initialization
local function init()
    if not playerGui then
        warn("PlayerGui not found")
        return
    end
    print("Starting splash initialization")
    destroyExistingSplash()
    
    local splash, bg, title, author = createSplashScreen()
    animateSplashScreen(splash, bg, title, author)

    -- Detectar el juego y ejecutar el script correspondiente
    detectAndExecuteGameScript()
end

-- ≡ Execution
local success, errorMsg = pcall(init)
if not success then
    warn("Initialization failed: " .. tostring(errorMsg))
    showError("Script failed to initialize")
end
