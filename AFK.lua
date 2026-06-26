local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local uiParent = pcall(function() return CoreGui.Name end) and CoreGui or LocalPlayer:WaitForChild("PlayerGui")

if uiParent:FindFirstChild("MinimalAntiAFK") then
    uiParent.MinimalAntiAFK:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MinimalAntiAFK"
ScreenGui.Parent = uiParent
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local BlackScreen = Instance.new("Frame")
BlackScreen.Size = UDim2.new(1, 0, 1, 0)
BlackScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BlackScreen.ZIndex = 5
BlackScreen.Visible = false
BlackScreen.Parent = ScreenGui

local OpenBtn = Instance.new("TextButton")
OpenBtn.Name = "OpenButton"
OpenBtn.Size = UDim2.new(0, 45, 0, 45)
OpenBtn.Position = UDim2.new(0.5, -22, 0, 10)
OpenBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
OpenBtn.Text = "AFK"
OpenBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 13
OpenBtn.ZIndex = 10
OpenBtn.Visible = false
OpenBtn.Parent = ScreenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0.5, 0)
Instance.new("UIStroke", OpenBtn).Color = Color3.fromRGB(80, 80, 80)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 240, 0, 305)
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -152)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 10
MainFrame.Parent = ScreenGui
local MFStroke = Instance.new("UIStroke", MainFrame)
MFStroke.Color = Color3.fromRGB(60, 60, 60)
MFStroke.Thickness = 1
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 30)
Topbar.BackgroundTransparency = 1
Topbar.ZIndex = 11
Topbar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Anti-AFK System"
Title.TextColor3 = Color3.fromRGB(200, 200, 200)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 12
Title.Parent = Topbar

local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0, 30, 0, 30)
HideBtn.Position = UDim2.new(1, -60, 0, 0)
HideBtn.BackgroundTransparency = 1
HideBtn.Text = "-"
HideBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
HideBtn.Font = Enum.Font.GothamBold
HideBtn.TextSize = 16
HideBtn.ZIndex = 12
HideBtn.Parent = Topbar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 13
CloseBtn.ZIndex = 12
CloseBtn.Parent = Topbar

local function makeDivider(yPos)
    local d = Instance.new("Frame")
    d.Size = UDim2.new(1, -30, 0, 1)
    d.Position = UDim2.new(0, 15, 0, yPos)
    d.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    d.BorderSizePixel = 0
    d.ZIndex = 11
    d.Parent = MainFrame
end
makeDivider(30)

local TimerLabel = Instance.new("TextLabel")
TimerLabel.Size = UDim2.new(1, 0, 0, 40)
TimerLabel.Position = UDim2.new(0, 0, 0, 40)
TimerLabel.BackgroundTransparency = 1
TimerLabel.Text = "00H 00M 00S"
TimerLabel.TextColor3 = Color3.fromRGB(245, 245, 245)
TimerLabel.Font = Enum.Font.GothamBlack
TimerLabel.TextSize = 24
TimerLabel.ZIndex = 11
TimerLabel.Parent = MainFrame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 180, 0, 34)
ToggleBtn.Position = UDim2.new(0.5, -90, 0, 90)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
ToggleBtn.Text = "AFK : OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 13
ToggleBtn.AutoButtonColor = false
ToggleBtn.ZIndex = 11
ToggleBtn.Parent = MainFrame
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

makeDivider(138)

local FpsSectionLabel = Instance.new("TextLabel")
FpsSectionLabel.Size = UDim2.new(0, 80, 0, 18)
FpsSectionLabel.Position = UDim2.new(0, 15, 0, 146)
FpsSectionLabel.BackgroundTransparency = 1
FpsSectionLabel.Text = "FPS CAP"
FpsSectionLabel.TextColor3 = Color3.fromRGB(130, 130, 130)
FpsSectionLabel.Font = Enum.Font.GothamBold
FpsSectionLabel.TextSize = 11
FpsSectionLabel.TextXAlignment = Enum.TextXAlignment.Left
FpsSectionLabel.ZIndex = 11
FpsSectionLabel.Parent = MainFrame

local CurrentFpsLabel = Instance.new("TextLabel")
CurrentFpsLabel.Size = UDim2.new(0, 100, 0, 18)
CurrentFpsLabel.Position = UDim2.new(1, -115, 0, 146)
CurrentFpsLabel.BackgroundTransparency = 1
CurrentFpsLabel.Text = "Active: --"
CurrentFpsLabel.TextColor3 = Color3.fromRGB(90, 170, 90)
CurrentFpsLabel.Font = Enum.Font.Gotham
CurrentFpsLabel.TextSize = 10
CurrentFpsLabel.TextXAlignment = Enum.TextXAlignment.Right
CurrentFpsLabel.ZIndex = 11
CurrentFpsLabel.Parent = MainFrame

local fpsPresets = {
    {cap = 30,   label = "30"},
    {cap = 60,   label = "60"},
    {cap = 144,  label = "144"},
    {cap = 240,  label = "240"},
}

local BTN_W = 38
local BTN_H = 28
local BTN_GAP = 4
local totalW = #fpsPresets * BTN_W + (#fpsPresets - 1) * BTN_GAP
local startX = (240 - totalW) / 2
local currentFpsCap = nil
local fpsButtonRefs = {}

local function deselectAllFpsButtons()
    for _, ref in ipairs(fpsButtonRefs) do
        TweenService:Create(ref.btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
        TweenService:Create(ref.stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(70, 70, 70)}):Play()
        ref.btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
end

local function applyFpsCap(cap)
    currentFpsCap = cap
    pcall(function() setfpscap(cap) end)
    CurrentFpsLabel.Text = "Active: " .. cap .. " FPS"
end

for i, preset in ipairs(fpsPresets) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, BTN_W, 0, BTN_H)
    btn.Position = UDim2.new(0, startX + (i - 1) * (BTN_W + BTN_GAP), 0, 170)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = preset.label
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.AutoButtonColor = false
    btn.ZIndex = 11
    btn.Parent = MainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(70, 70, 70)
    stroke.Thickness = 1

    fpsButtonRefs[i] = {btn = btn, stroke = stroke, cap = preset.cap}

    btn.MouseEnter:Connect(function()
        if currentFpsCap ~= preset.cap then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if currentFpsCap ~= preset.cap then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
        end
    end)
    btn.MouseButton1Click:Connect(function()
        deselectAllFpsButtons()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 110, 200)}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(100, 140, 230)}):Play()
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        applyFpsCap(preset.cap)
    end)
end

local CustomLabel = Instance.new("TextLabel")
CustomLabel.Size = UDim2.new(0, 55, 0, 24)
CustomLabel.Position = UDim2.new(0, 15, 0, 212)
CustomLabel.BackgroundTransparency = 1
CustomLabel.Text = "Custom :"
CustomLabel.TextColor3 = Color3.fromRGB(130, 130, 130)
CustomLabel.Font = Enum.Font.Gotham
CustomLabel.TextSize = 11
CustomLabel.TextXAlignment = Enum.TextXAlignment.Left
CustomLabel.ZIndex = 11
CustomLabel.Parent = MainFrame

local CustomInput = Instance.new("TextBox")
CustomInput.Size = UDim2.new(0, 78, 0, 24)
CustomInput.Position = UDim2.new(0, 72, 0, 212)
CustomInput.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
CustomInput.Text = ""
CustomInput.PlaceholderText = "1 – 9999"
CustomInput.TextColor3 = Color3.fromRGB(220, 220, 220)
CustomInput.PlaceholderColor3 = Color3.fromRGB(75, 75, 75)
CustomInput.Font = Enum.Font.Gotham
CustomInput.TextSize = 11
CustomInput.ClearTextOnFocus = true
CustomInput.ZIndex = 11
CustomInput.Parent = MainFrame
Instance.new("UICorner", CustomInput).CornerRadius = UDim.new(0, 5)
local InputStroke = Instance.new("UIStroke", CustomInput)
InputStroke.Color = Color3.fromRGB(70, 70, 70)
InputStroke.Thickness = 1

local SetBtn = Instance.new("TextButton")
SetBtn.Size = UDim2.new(0, 58, 0, 24)
SetBtn.Position = UDim2.new(0, 158, 0, 212)
SetBtn.BackgroundColor3 = Color3.fromRGB(55, 95, 175)
SetBtn.Text = "SET"
SetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SetBtn.Font = Enum.Font.GothamBold
SetBtn.TextSize = 11
SetBtn.AutoButtonColor = false
SetBtn.ZIndex = 11
SetBtn.Parent = MainFrame
Instance.new("UICorner", SetBtn).CornerRadius = UDim.new(0, 5)

SetBtn.MouseEnter:Connect(function() TweenService:Create(SetBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(75, 115, 205)}):Play() end)
SetBtn.MouseLeave:Connect(function() TweenService:Create(SetBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(55, 95, 175)}):Play() end)

local function fireSetBtn()
    local val = tonumber(CustomInput.Text)
    if val and val >= 1 and val <= 9999 then
        val = math.clamp(math.floor(val), 1, 9999)
        deselectAllFpsButtons()
        applyFpsCap(val)
        CustomInput.Text = tostring(val)
    else
        TweenService:Create(InputStroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(210, 55, 55)}):Play()
        task.delay(0.6, function()
            TweenService:Create(InputStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(70, 70, 70)}):Play()
        end)
        CustomInput.Text = ""
    end
end

SetBtn.MouseButton1Click:Connect(fireSetBtn)
CustomInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then fireSetBtn() end
end)

local BlackToggleBtn = Instance.new("TextButton")
BlackToggleBtn.Size = UDim2.new(0, 180, 0, 34)
BlackToggleBtn.Position = UDim2.new(0.5, -90, 0, 252)
BlackToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
BlackToggleBtn.Text = "จอดำ : OFF"
BlackToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
BlackToggleBtn.Font = Enum.Font.GothamBold
BlackToggleBtn.TextSize = 13
BlackToggleBtn.AutoButtonColor = false
BlackToggleBtn.ZIndex = 11
BlackToggleBtn.Parent = MainFrame
Instance.new("UICorner", BlackToggleBtn).CornerRadius = UDim.new(0, 6)
local BTStroke = Instance.new("UIStroke", BlackToggleBtn)
BTStroke.Color = Color3.fromRGB(80, 80, 80)
BTStroke.Thickness = 1

local isBlackScreen = false

BlackToggleBtn.MouseEnter:Connect(function()
    if not isBlackScreen then
        TweenService:Create(BlackToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
    end
end)
BlackToggleBtn.MouseLeave:Connect(function()
    if not isBlackScreen then
        TweenService:Create(BlackToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
    end
end)

BlackToggleBtn.MouseButton1Click:Connect(function()
    isBlackScreen = not isBlackScreen
    if isBlackScreen then
        BlackToggleBtn.Text = "จอดำ : ON"
        TweenService:Create(BlackToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(120, 90, 200)}):Play()
        BlackToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        BlackScreen.Visible = true
        pcall(function() RunService:Set3dRenderingEnabled(false) end)
    else
        BlackToggleBtn.Text = "จอดำ : OFF"
        TweenService:Create(BlackToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
        BlackToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        BlackScreen.Visible = false
        pcall(function() RunService:Set3dRenderingEnabled(true) end)
    end
end)

local isAFK = false
local afkConnection
local startTime = 0

local function formatTime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = seconds % 60
    return string.format("%02dH %02dM %02dS", h, m, s)
end

task.spawn(function()
    while task.wait(1) do
        if isAFK then
            TimerLabel.Text = formatTime(os.time() - startTime)
        end
    end
end)

ToggleBtn.MouseEnter:Connect(function() TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play() end)
ToggleBtn.MouseLeave:Connect(function() TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play() end)
HideBtn.MouseEnter:Connect(function()  TweenService:Create(HideBtn,   TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play() end)
HideBtn.MouseLeave:Connect(function()  TweenService:Create(HideBtn,   TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play() end)
CloseBtn.MouseEnter:Connect(function() TweenService:Create(CloseBtn,  TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 100, 100)}):Play() end)
CloseBtn.MouseLeave:Connect(function() TweenService:Create(CloseBtn,  TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play() end)
OpenBtn.MouseEnter:Connect(function()  TweenService:Create(OpenBtn,   TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play() end)
OpenBtn.MouseLeave:Connect(function()  TweenService:Create(OpenBtn,   TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play() end)

ToggleBtn.MouseButton1Click:Connect(function()
    isAFK = not isAFK
    if isAFK then
        startTime = os.time()
        TimerLabel.Text = "00H 00M 00S"
        TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(60, 180, 100)}):Play()
        ToggleBtn.Text = "AFK : RUNNING"
        afkConnection = LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    else
        TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(200, 70, 70)}):Play()
        ToggleBtn.Text = "AFK : OFF"
        if afkConnection then afkConnection:Disconnect(); afkConnection = nil end
    end
end)

HideBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    OpenBtn.Visible = false
    MainFrame.Visible = true
end)

CloseBtn.MouseButton1Click:Connect(function()
    if afkConnection then afkConnection:Disconnect(); afkConnection = nil end
    pcall(function() RunService:Set3dRenderingEnabled(true) end)
    pcall(function() setfpscap(60) end)
    ScreenGui:Destroy()
end)

local function makeDraggable(handle, body)
    local dragging, dragInput, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = body.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            body.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                      startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(Topbar, MainFrame)
makeDraggable(OpenBtn, OpenBtn)
