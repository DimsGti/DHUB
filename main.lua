-- D-Hub | Clean Premium Loader
-- Onyx build

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ══════════════════════════════
-- CONFIG
-- ══════════════════════════════
local DISCORD_LINK = "https://discord.com/invite/6SUC6U7Chd"
local LOAD_DURATION = 10

local GAME_SCRIPTS = {
    [93978595733734] = "https://raw.githubusercontent.com/DimsGti/ViolenceDistrict/main/main.lua",
    [125927821145949] = "https://raw.githubusercontent.com/DimsGti/MAMv2/refs/heads/main/main.lua",
}

-- ══════════════════════════════
-- EARLY GAME ID CHECK
-- ══════════════════════════════
-- Mengecek apakah PlaceId atau GameId terdaftar di GAME_SCRIPTS
local targetScriptUrl = GAME_SCRIPTS[game.PlaceId] or GAME_SCRIPTS[game.GameId]

if not targetScriptUrl then
    -- Jika tidak ada, langsung kick dan tunjukkan ID aslinya agar mudah dicek
    local errorMsg = string.format(
        "D-Hub — Not Supported In This Game.\n(PlaceId: %s | GameId: %s)",
        tostring(game.PlaceId),
        tostring(game.GameId)
    )
    LocalPlayer:Kick(errorMsg)
    return -- Hentikan script di sini, tidak perlu meload UI
end

-- ══════════════════════════════
-- PALETTE
-- ══════════════════════════════
local BG          = Color3.fromRGB(10, 7, 18)
local PURPLE      = Color3.fromRGB(138, 43, 226)
local PURPLE_DIM  = Color3.fromRGB(80, 30, 140)
local WHITE_SOFT  = Color3.fromRGB(230, 215, 255)
local DIM_TEXT    = Color3.fromRGB(120, 95, 170)
local BAR_TRACK   = Color3.fromRGB(28, 18, 48)

-- ══════════════════════════════
-- ROOT
-- ══════════════════════════════
if PlayerGui:FindFirstChild("DHubLoader") then
    PlayerGui.DHubLoader:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DHubLoader"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = PlayerGui

local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = game:GetService("Lighting")
TweenService:Create(Blur, TweenInfo.new(1, Enum.EasingStyle.Quad), {Size = 14}):Play()

-- Full dark bg
local Bg = Instance.new("Frame")
Bg.Size = UDim2.fromScale(1, 1)
Bg.BackgroundColor3 = BG
Bg.BackgroundTransparency = 1
Bg.BorderSizePixel = 0
Bg.ZIndex = 1
Bg.Parent = ScreenGui
TweenService:Create(Bg, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()

-- Subtle vignette gradient
local Vig = Instance.new("UIGradient")
Vig.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 5, 40)),
    ColorSequenceKeypoint.new(0.5, BG),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 5, 40)),
})
Vig.Rotation = 45
Vig.Parent = Bg

-- ══════════════════════════════
-- CENTER WRAPPER
-- ══════════════════════════════
local Wrap = Instance.new("Frame")
Wrap.Size = UDim2.new(0, 340, 0, 160)
Wrap.AnchorPoint = Vector2.new(0.5, 0.5)
Wrap.Position = UDim2.fromScale(0.5, 0.5)
Wrap.BackgroundTransparency = 1
Wrap.BorderSizePixel = 0
Wrap.ZIndex = 2
Wrap.Parent = ScreenGui

-- ══════════════════════════════
-- TITLE
-- ══════════════════════════════
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 42)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Loading D-Hub"
Title.TextColor3 = WHITE_SOFT
Title.Font = Enum.Font.GothamBold
Title.TextSize = 26
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.ZIndex = 3
Title.Parent = Wrap

-- Subtle glow stroke on title
local TitleStroke = Instance.new("UIStroke")
TitleStroke.Color = PURPLE
TitleStroke.Thickness = 0.8
TitleStroke.Transparency = 0.55
TitleStroke.Parent = Title

-- ══════════════════════════════
-- PROGRESS BAR
-- ══════════════════════════════
local BarTrack = Instance.new("Frame")
BarTrack.Size = UDim2.new(1, 0, 0, 3)
BarTrack.Position = UDim2.new(0, 0, 0, 52)
BarTrack.BackgroundColor3 = BAR_TRACK
BarTrack.BorderSizePixel = 0
BarTrack.ZIndex = 3
BarTrack.Parent = Wrap

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(0, 4)
BarCorner.Parent = BarTrack

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = PURPLE
BarFill.BorderSizePixel = 0
BarFill.ZIndex = 4
BarFill.Parent = BarTrack

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 4)
FillCorner.Parent = BarFill

-- Bar fill gradient
local FillGrad = Instance.new("UIGradient")
FillGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 20, 200)),
})
FillGrad.Parent = BarFill

-- Glow dot at bar tip
local GlowDot = Instance.new("Frame")
GlowDot.Size = UDim2.new(0, 8, 0, 8)
GlowDot.AnchorPoint = Vector2.new(0.5, 0.5)
GlowDot.Position = UDim2.new(0, 0, 0.5, 0)
GlowDot.BackgroundColor3 = Color3.fromRGB(210, 120, 255)
GlowDot.BorderSizePixel = 0
GlowDot.ZIndex = 5
GlowDot.Parent = BarFill

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(0, 4)
DotCorner.Parent = GlowDot

-- ══════════════════════════════
-- STATUS TEXT (small, cycling)
-- ══════════════════════════════
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 18)
StatusLabel.Position = UDim2.new(0, 0, 0, 62)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "initializing..."
StatusLabel.TextColor3 = DIM_TEXT
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 11
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.ZIndex = 3
StatusLabel.Parent = Wrap

-- ══════════════════════════════
-- DISCORD BUTTON
-- ══════════════════════════════
local DiscBtn = Instance.new("TextButton")
DiscBtn.Size = UDim2.new(1, 0, 0, 34)
DiscBtn.Position = UDim2.new(0, 0, 0, 94)
DiscBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscBtn.BackgroundTransparency = 0.15
DiscBtn.BorderSizePixel = 0
DiscBtn.Text = "Discord  —  Copy Invite"
DiscBtn.TextColor3 = Color3.new(1, 1, 1)
DiscBtn.Font = Enum.Font.GothamSemibold
DiscBtn.TextSize = 12
DiscBtn.ZIndex = 3
DiscBtn.Parent = Wrap

local DiscCorner = Instance.new("UICorner")
DiscCorner.CornerRadius = UDim.new(0, 7)
DiscCorner.Parent = DiscBtn

local DiscStroke = Instance.new("UIStroke")
DiscStroke.Color = Color3.fromRGB(130, 145, 255)
DiscStroke.Thickness = 1
DiscStroke.Transparency = 0.6
DiscStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
DiscStroke.Parent = DiscBtn

-- Copied feedback
local CopiedFade = false
DiscBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if setclipboard then
            setclipboard(DISCORD_LINK)
        elseif syn and syn.write_clipboard then
            syn.write_clipboard(DISCORD_LINK)
        end
    end)
    if not CopiedFade then
        CopiedFade = true
        DiscBtn.Text = "✓ Copied!"
        TweenService:Create(DiscBtn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(50, 180, 100)
        }):Play()
        task.delay(1.8, function()
            TweenService:Create(DiscBtn, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(88, 101, 242)
            }):Play()
            DiscBtn.Text = "Discord  —  Copy Invite"
            CopiedFade = false
        end)
    end
end)

DiscBtn.MouseEnter:Connect(function()
    TweenService:Create(DiscBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
end)
DiscBtn.MouseLeave:Connect(function()
    TweenService:Create(DiscBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.15}):Play()
end)

-- ══════════════════════════════
-- FADE IN WRAP
-- ══════════════════════════════
Wrap.Position = UDim2.new(0.5, 0, 0.52, 0)

-- status messages
local statuses = {
    "scanning game...",
    "loading modules...",
    "injecting scripts...",
    "verifying environment...",
    "almost ready...",
}

-- ══════════════════════════════
-- DISPATCH
-- ══════════════════════════════
local function dispatch()
    StatusLabel.Text = "launching..."
    task.wait(0.5)
    -- Outro
    TweenService:Create(Bg, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
    TweenService:Create(Blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Size = 0}):Play()
    task.wait(0.6)
    ScreenGui:Destroy()
    Blur:Destroy()
    
    -- Load script dari URL yang sudah diverifikasi di awal
    loadstring(game:HttpGet(targetScriptUrl))()
end

-- ══════════════════════════════
-- MAIN LOOP
-- ══════════════════════════════
task.spawn(function()
    -- fade wrap in
    local WrapAlpha = Instance.new("NumberValue")
    TweenService:Create(Title, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
    Title.TextTransparency = 1

    local startTime = tick()
    local statusIdx = 1

    -- status cycling every 1.8s
    task.spawn(function()
        while true do
            task.wait(1.8)
            statusIdx = statusIdx % #statuses + 1
            StatusLabel.Text = statuses[statusIdx]
        end
    end)

    -- bar fill loop
    while true do
        task.wait(0.03)
        local elapsed = tick() - startTime
        local raw = math.clamp(elapsed / LOAD_DURATION, 0, 1)
        -- ease out cubic
        local pct = 1 - (1 - raw)^3

        BarFill.Size = UDim2.new(pct, 0, 1, 0)
        GlowDot.Position = UDim2.new(1, 0, 0.5, 0)

        if elapsed >= LOAD_DURATION then
            BarFill.Size = UDim2.new(1, 0, 1, 0)
            break
        end
    end

    task.wait(0.4)
    dispatch()
end)
