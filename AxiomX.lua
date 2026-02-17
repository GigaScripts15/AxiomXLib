-- AxiomX UI Library
-- Version: 1.0.0
-- Author: AxiomX
-- KeySystem: exemple: 1234
-- GitHub: https://github.com/AxiomXDev
-- Discord: https://discord.gg/axiomx

local AxiomX = {}
AxiomX.__index = AxiomX

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local Debris = game:GetService("Debris")

-- Player
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Constants
local SCREEN_PADDING = 20
local WINDOW_MIN_WIDTH = 400
local WINDOW_MIN_HEIGHT = 300
local WINDOW_MAX_WIDTH = 800
local WINDOW_MAX_HEIGHT = 600
local WINDOW_DEFAULT_SIZE = Vector2.new(550, 500)
local DRAG_HANDLE_HEIGHT = 40
local TAB_HEIGHT = 40
local SECTION_PADDING = 15
local COMPONENT_SPACING = 10
local ANIMATION_SPEED = 0.1
local NOTIFICATION_DURATION = 3

-- Module Imports (simulados para exemplo)
local Modules = {
    Window = {},
    Tabs = {},
    Sections = {},
    Components = {},
    Themes = {},
    Icons = {},
    KeySystem = {},
    Discord = {},
    Minimize = {},
    Notifications = {}
}

-- Themes System
Modules.Themes = {
    Themes = {
        ["Dark"] = {
            Primary = Color3.fromRGB(30, 30, 35),
            Secondary = Color3.fromRGB(40, 40, 45),
            Tertiary = Color3.fromRGB(50, 50, 60),
            Accent = Color3.fromRGB(0, 170, 255),
            Text = Color3.fromRGB(240, 240, 240),
            SubText = Color3.fromRGB(180, 180, 180),
            Success = Color3.fromRGB(50, 200, 100),
            Error = Color3.fromRGB(220, 60, 60),
            Warning = Color3.fromRGB(255, 180, 0),
            Info = Color3.fromRGB(0, 170, 255),
            Border = Color3.fromRGB(60, 60, 70),
            Shadow = Color3.fromRGB(10, 10, 15)
        },
        ["Midnight"] = {
            Primary = Color3.fromRGB(15, 20, 30),
            Secondary = Color3.fromRGB(25, 30, 45),
            Tertiary = Color3.fromRGB(35, 40, 60),
            Accent = Color3.fromRGB(120, 80, 255),
            Text = Color3.fromRGB(230, 230, 240),
            SubText = Color3.fromRGB(160, 160, 180),
            Success = Color3.fromRGB(60, 220, 140),
            Error = Color3.fromRGB(240, 80, 80),
            Warning = Color3.fromRGB(255, 200, 80),
            Info = Color3.fromRGB(100, 160, 255),
            Border = Color3.fromRGB(50, 55, 75),
            Shadow = Color3.fromRGB(5, 10, 20)
        },
        ["Red Neon"] = {
            Primary = Color3.fromRGB(20, 15, 20),
            Secondary = Color3.fromRGB(30, 20, 25),
            Tertiary = Color3.fromRGB(45, 25, 30),
            Accent = Color3.fromRGB(255, 0, 80),
            Text = Color3.fromRGB(255, 240, 240),
            SubText = Color3.fromRGB(200, 160, 170),
            Success = Color3.fromRGB(80, 255, 120),
            Error = Color3.fromRGB(255, 40, 40),
            Warning = Color3.fromRGB(255, 120, 40),
            Info = Color3.fromRGB(255, 80, 160),
            Border = Color3.fromRGB(65, 30, 40),
            Shadow = Color3.fromRGB(15, 5, 10)
        },
        ["Blue Tech"] = {
            Primary = Color3.fromRGB(10, 20, 35),
            Secondary = Color3.fromRGB(20, 35, 55),
            Tertiary = Color3.fromRGB(30, 50, 80),
            Accent = Color3.fromRGB(0, 200, 255),
            Text = Color3.fromRGB(220, 240, 255),
            SubText = Color3.fromRGB(150, 190, 220),
            Success = Color3.fromRGB(0, 255, 200),
            Error = Color3.fromRGB(255, 60, 90),
            Warning = Color3.fromRGB(255, 180, 0),
            Info = Color3.fromRGB(0, 180, 255),
            Border = Color3.fromRGB(40, 70, 100),
            Shadow = Color3.fromRGB(5, 15, 25)
        }
    },
    
    Current = "Dark",
    
    GetTheme = function(self, themeName)
        return self.Themes[themeName] or self.Themes[self.Current]
    end,
    
    SetTheme = function(self, themeName)
        if self.Themes[themeName] then
            self.Current = themeName
            return true
        end
        return false
    end,
    
    AddCustomTheme = function(self, name, themeData)
        if not self.Themes[name] then
            self.Themes[name] = themeData
            return true
        end
        return false
    end
}

-- Icons System
Modules.Icons = {
    Icons = {
        Home = "rbxassetid://10734846452",
        Settings = "rbxassetid://10734846789",
        User = "rbxassetid://10734846912",
        Star = "rbxassetid://10734847045",
        Bell = "rbxassetid://10734847178",
        Key = "rbxassetid://10734847301",
        Lock = "rbxassetid://10734847424",
        Unlock = "rbxassetid://10734847547",
        Check = "rbxassetid://10734847670",
        Cross = "rbxassetid://10734847793",
        Info = "rbxassetid://10734847916",
        Warning = "rbxassetid://10734848039",
        Search = "rbxassetid://10734848162",
        Download = "rbxassetid://10734848285",
        Upload = "rbxassetid://10734848408",
        Refresh = "rbxassetid://10734848531",
        Play = "rbxassetid://10734848654",
        Stop = "rbxassetid://10734848777",
        Pause = "rbxassetid://10734848900",
        Next = "rbxassetid://10734849023",
        Previous = "rbxassetid://10734849146"
    },
    
    GetIcon = function(self, iconName)
        return self.Icons[iconName] or ""
    end,
    
    AddIcon = function(self, name, assetId)
        if not self.Icons[name] then
            self.Icons[name] = assetId
            return true
        end
        return false
    end
}

-- Notifications System
Modules.Notifications = {
    ActiveNotifications = {},
    NotificationQueue = {},
    MaxNotifications = 5,
    
    ShowNotification = function(self, title, message, notificationType, duration)
        duration = duration or NOTIFICATION_DURATION
        
        -- Criação da notificação
        local notificationFrame = Instance.new("Frame")
        notificationFrame.Name = "AxiomXNotification"
        notificationFrame.Size = UDim2.new(0, 300, 0, 80)
        notificationFrame.Position = UDim2.new(1, -320, 1, -100 - (#self.ActiveNotifications * 90))
        notificationFrame.AnchorPoint = Vector2.new(1, 1)
        notificationFrame.BackgroundColor3 = Modules.Themes:GetTheme().Secondary
        notificationFrame.BackgroundTransparency = 0.1
        notificationFrame.BorderSizePixel = 0
        notificationFrame.ZIndex = 100
        
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, 8)
        uiCorner.Parent = notificationFrame
        
        local uiStroke = Instance.new("UIStroke")
        uiStroke.Color = Modules.Themes:GetTheme().Border
        uiStroke.Thickness = 1
        uiStroke.Parent = notificationFrame
        
        local uiShadow = Instance.new("ImageLabel")
        uiShadow.Name = "Shadow"
        uiShadow.Image = "rbxassetid://5554236805"
        uiShadow.ImageColor3 = Modules.Themes:GetTheme().Shadow
        uiShadow.ImageTransparency = 0.5
        uiShadow.ScaleType = Enum.ScaleType.Slice
        uiShadow.SliceCenter = Rect.new(23, 23, 277, 277)
        uiShadow.Size = UDim2.new(1, 10, 1, 10)
        uiShadow.Position = UDim2.new(0, -5, 0, -5)
        uiShadow.BackgroundTransparency = 1
        uiShadow.ZIndex = 99
        uiShadow.Parent = notificationFrame
        
        local iconLabel = Instance.new("ImageLabel")
        iconLabel.Name = "Icon"
        iconLabel.Size = UDim2.new(0, 24, 0, 24)
        iconLabel.Position = UDim2.new(0, 15, 0, 15)
        iconLabel.BackgroundTransparency = 1
        iconLabel.ZIndex = 101
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Text = title
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 16
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Size = UDim2.new(1, -60, 0, 20)
        titleLabel.Position = UDim2.new(0, 50, 0, 15)
        titleLabel.BackgroundTransparency = 1
        titleLabel.ZIndex = 101
        
        local messageLabel = Instance.new("TextLabel")
        messageLabel.Name = "Message"
        messageLabel.Text = message
        messageLabel.Font = Enum.Font.Gotham
        messageLabel.TextSize = 14
        messageLabel.TextXAlignment = Enum.TextXAlignment.Left
        messageLabel.TextYAlignment = Enum.TextYAlignment.Top
        messageLabel.TextWrapped = true
        messageLabel.Size = UDim2.new(1, -60, 0, 40)
        messageLabel.Position = UDim2.new(0, 50, 0, 35)
        messageLabel.BackgroundTransparency = 1
        messageLabel.ZIndex = 101
        
        local closeButton = Instance.new("ImageButton")
        closeButton.Name = "Close"
        closeButton.Image = Modules.Icons:GetIcon("Cross")
        closeButton.Size = UDim2.new(0, 20, 0, 20)
        closeButton.Position = UDim2.new(1, -25, 0, 10)
        closeButton.BackgroundTransparency = 1
        closeButton.ZIndex = 101
        
        -- Configurar cores baseado no tipo
        local theme = Modules.Themes:GetTheme()
        local accentColor
        
        if notificationType == "Success" then
            accentColor = theme.Success
            iconLabel.Image = Modules.Icons:GetIcon("Check")
        elseif notificationType == "Error" then
            accentColor = theme.Error
            iconLabel.Image = Modules.Icons:GetIcon("Cross")
        elseif notificationType == "Warning" then
            accentColor = theme.Warning
            iconLabel.Image = Modules.Icons:GetIcon("Warning")
        else -- Info como padrão
            accentColor = theme.Info
            iconLabel.Image = Modules.Icons:GetIcon("Info")
        end
        
        iconLabel.ImageColor3 = accentColor
        titleLabel.TextColor3 = accentColor
        messageLabel.TextColor3 = theme.Text
        closeButton.ImageColor3 = theme.SubText
        
        iconLabel.Parent = notificationFrame
        titleLabel.Parent = notificationFrame
        messageLabel.Parent = notificationFrame
        closeButton.Parent = notificationFrame
        
        notificationFrame.Parent = game:GetService("CoreGui")
        
        -- Animar entrada
        notificationFrame.Position = UDim2.new(1, 300, 1, -100 - (#self.ActiveNotifications * 90))
        local tweenIn = TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -320, 1, -100 - (#self.ActiveNotifications * 90))
        })
        tweenIn:Play()
        
        -- Adicionar à lista de notificações ativas
        table.insert(self.ActiveNotifications, {
            Frame = notificationFrame,
            ExpireTime = tick() + duration
        })
        
        -- Configurar eventos
        closeButton.MouseButton1Click:Connect(function()
            self:HideNotification(notificationFrame)
        end)
        
        -- Auto-fechar
        task.spawn(function()
            task.wait(duration)
            self:HideNotification(notificationFrame)
        end)
        
        -- Reposicionar notificações
        self:UpdateNotificationPositions()
    end,
    
    HideNotification = function(self, notificationFrame)
        local tweenOut = TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 300, notificationFrame.Position.Y.Scale, notificationFrame.Position.Y.Offset)
        })
        tweenOut:Play()
        
        tweenOut.Completed:Connect(function()
            notificationFrame:Destroy()
            
            -- Remover da lista
            for i, notification in ipairs(self.ActiveNotifications) do
                if notification.Frame == notificationFrame then
                    table.remove(self.ActiveNotifications, i)
                    break
                end
            end
            
            -- Reposicionar notificações restantes
            self:UpdateNotificationPositions()
        end)
    end,
    
    UpdateNotificationPositions = function(self)
        for i, notification in ipairs(self.ActiveNotifications) do
            local targetPosition = UDim2.new(1, -320, 1, -100 - ((i - 1) * 90))
            TweenService:Create(notification.Frame, TweenInfo.new(0.2), {
                Position = targetPosition
            }):Play()
        end
    end
}

-- Key System Module
Modules.KeySystem = {
    CurrentKey = nil,
    KeyVerified = false,
    MaxAttempts = 5,
    Attempts = 0,
    Cooldown = false,
    
    VerifyKey = function(self, inputKey, correctKey)
        if self.Cooldown then
            return false, "Por favor, aguarde antes de tentar novamente."
        end
        
        if self.Attempts >= self.MaxAttempts then
            self.Cooldown = true
            task.wait(15)
            self.Cooldown = false
            self.Attempts = 0
        end
        
        self.Attempts += 1
        
        if inputKey == correctKey then
            self.KeyVerified = true
            self.CurrentKey = inputKey
            self.Attempts = 0
            return true, "Key verificada com sucesso!"
        else
            local remaining = self.MaxAttempts - self.Attempts
            return false, string.format("Key incorreta. Tentativas restantes: %d", remaining)
        end
    end,
    
    ResetAttempts = function(self)
        self.Attempts = 0
        self.Cooldown = false
    end
}

-- Discord Module
Modules.Discord = {
    DiscordURL = "https://discord.gg/axiomx",
    
    SetDiscordURL = function(self, url)
        self.DiscordURL = url
    end,
    
    OpenDiscord = function(self)
        if self.DiscordURL then
            pcall(function()
                setclipboard(self.DiscordURL)
                Modules.Notifications:ShowNotification("Discord", "Link copiado para a área de transferência!", "Success", 3)
            end)
        end
    end
}

-- Minimize System
Modules.Minimize = {
    IsMinimized = false,
    MinimizeIcon = nil,
    
    CreateMinimizeIcon = function(self, window)
        if self.MinimizeIcon then
            self.MinimizeIcon:Destroy()
        end
        
        local iconFrame = Instance.new("Frame")
        iconFrame.Name = "AxiomXMinimizeIcon"
        iconFrame.Size = UDim2.new(0, 50, 0, 50)
        iconFrame.Position = UDim2.new(0.5, -25, 1, -70)
        iconFrame.AnchorPoint = Vector2.new(0.5, 1)
        iconFrame.BackgroundColor3 = Modules.Themes:GetTheme().Accent
        iconFrame.BackgroundTransparency = 0.2
        iconFrame.BorderSizePixel = 0
        iconFrame.ZIndex = 100
        
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, 12)
        uiCorner.Parent = iconFrame
        
        local iconLabel = Instance.new("ImageLabel")
        iconLabel.Name = "Icon"
        iconLabel.Image = "rbxassetid://10734846452" -- Ícone AxiomX
        iconLabel.Size = UDim2.new(0, 30, 0, 30)
        iconLabel.Position = UDim2.new(0.5, -15, 0.5, -15)
        iconLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        iconLabel.BackgroundTransparency = 1
        iconLabel.ImageColor3 = Modules.Themes:GetTheme().Text
        iconLabel.ZIndex = 101
        iconLabel.Parent = iconFrame
        
        local dragHandle = Instance.new("TextButton")
        dragHandle.Name = "DragHandle"
        dragHandle.Size = UDim2.new(1, 0, 1, 0)
        dragHandle.BackgroundTransparency = 1
        dragHandle.Text = ""
        dragHandle.ZIndex = 102
        dragHandle.Parent = iconFrame
        
        -- Drag system para o ícone
        local dragging
        local dragInput
        local dragStart
        local startPos
        
        local function update(input)
            local delta = input.Position - dragStart
            iconFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
        
        dragHandle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = iconFrame.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        
        dragHandle.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input == dragInput then
                update(input)
            end
        end)
        
        -- Clique para restaurar
        dragHandle.MouseButton1Click:Connect(function()
            self:RestoreWindow(window)
        end)
        
        iconFrame.Parent = game:GetService("CoreGui")
        self.MinimizeIcon = iconFrame
        
        -- Animar entrada
        iconFrame.Position = UDim2.new(0.5, -25, 1, 50)
        TweenService:Create(iconFrame, TweenInfo.new(0.3), {
            Position = UDim2.new(0.5, -25, 1, -70)
        }):Play()
    end,
    
    MinimizeWindow = function(self, window)
        if self.IsMinimized then return end
        
        self.IsMinimized = true
        
        -- Salvar posição e tamanho da janela
        self.LastWindowSize = window.MainFrame.Size
        self.LastWindowPosition = window.MainFrame.Position
        
        -- Animar fechamento
        local tween = TweenService:Create(window.MainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        tween:Play()
        
        tween.Completed:Connect(function()
            window.MainFrame.Visible = false
            self:CreateMinimizeIcon(window)
        end)
    end,
    
    RestoreWindow = function(self, window)
        if not self.IsMinimized then return end
        
        self.IsMinimized = false
        
        -- Remover ícone
        if self.MinimizeIcon then
            TweenService:Create(self.MinimizeIcon, TweenInfo.new(0.2), {
                Position = UDim2.new(0.5, -25, 1, 50)
            }):Play()
            
            task.wait(0.2)
            self.MinimizeIcon:Destroy()
            self.MinimizeIcon = nil
        end
        
        -- Restaurar janela
        window.MainFrame.Visible = true
        window.MainFrame.Size = UDim2.new(0, 0, 0, 0)
        window.MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        local tween = TweenService:Create(window.MainFrame, TweenInfo.new(0.3), {
            Size = self.LastWindowSize,
            Position = self.LastWindowPosition
        })
        tween:Play()
    end
}

-- Window Class
Modules.Window = {
    Windows = {},
    ActiveWindow = nil,
    
    Create = function(self, config)
        config = config or {}
        local window = {}
        setmetatable(window, self)
        self.__index = self
        
        -- Configurações padrão
        window.Name = config.Name or "AxiomX Window"
        window.Theme = config.Theme or "Dark"
        window.KeySystem = config.KeySystem or false
        window.Key = config.Key or nil
        window.Discord = config.Discord or nil
        window.Size = config.Size or WINDOW_DEFAULT_SIZE
        window.Position = config.Position or UDim2.new(0.5, -window.Size.X/2, 0.5, -window.Size.Y/2)
        
        -- Aplicar tema
        Modules.Themes:SetTheme(window.Theme)
        if window.Discord then
            Modules.Discord:SetDiscordURL(window.Discord)
        end
        
        -- Criar ScreenGui
        window.ScreenGui = Instance.new("ScreenGui")
        window.ScreenGui.Name = "AxiomXUI"
        window.ScreenGui.ResetOnSpawn = false
        window.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
        -- Criar janela principal
        window.MainFrame = Instance.new("Frame")
        window.MainFrame.Name = "MainWindow"
        window.MainFrame.Size = UDim2.new(0, 0, 0, 0)
        window.MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        window.MainFrame.BackgroundColor3 = Modules.Themes:GetTheme().Primary
        window.MainFrame.BorderSizePixel = 0
        window.MainFrame.Visible = false
        
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, 8)
        uiCorner.Parent = window.MainFrame
        
        local uiStroke = Instance.new("UIStroke")
        uiStroke.Color = Modules.Themes:GetTheme().Border
        uiStroke.Thickness = 1
        uiStroke.Parent = window.MainFrame
        
        local uiShadow = Instance.new("ImageLabel")
        uiShadow.Name = "Shadow"
        uiShadow.Image = "rbxassetid://5554236805"
        uiShadow.ImageColor3 = Modules.Themes:GetTheme().Shadow
        uiShadow.ImageTransparency = 0.3
        uiShadow.ScaleType = Enum.ScaleType.Slice
        uiShadow.SliceCenter = Rect.new(23, 23, 277, 277)
        uiShadow.Size = UDim2.new(1, 20, 1, 20)
        uiShadow.Position = UDim2.new(0, -10, 0, -10)
        uiShadow.BackgroundTransparency = 1
        uiShadow.Parent = window.MainFrame
        
        -- Drag handle
        window.DragHandle = Instance.new("TextButton")
        window.DragHandle.Name = "DragHandle"
        window.DragHandle.Size = UDim2.new(1, 0, 0, DRAG_HANDLE_HEIGHT)
        window.DragHandle.BackgroundTransparency = 1
        window.DragHandle.Text = ""
        window.DragHandle.ZIndex = 2
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Text = window.Name
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 18
        titleLabel.TextColor3 = Modules.Themes:GetTheme().Text
        titleLabel.Position = UDim2.new(0, 15, 0, 0)
        titleLabel.Size = UDim2.new(1, -100, 1, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.ZIndex = 3
        titleLabel.Parent = window.DragHandle
        
        -- Botão minimize
        local minimizeButton = Instance.new("ImageButton")
        minimizeButton.Name = "MinimizeButton"
        minimizeButton.Image = "rbxassetid://10734912345"
        minimizeButton.Size = UDim2.new(0, 20, 0, 20)
        minimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
        minimizeButton.AnchorPoint = Vector2.new(1, 0.5)
        minimizeButton.BackgroundTransparency = 1
        minimizeButton.ImageColor3 = Modules.Themes:GetTheme().SubText
        minimizeButton.ZIndex = 3
        
        minimizeButton.MouseButton1Click:Connect(function()
            Modules.Minimize:MinimizeWindow(window)
        end)
        minimizeButton.Parent = window.DragHandle
        
        -- Botão Discord
        local discordButton = Instance.new("ImageButton")
        discordButton.Name = "DiscordButton"
        discordButton.Image = "rbxassetid://10734878901"
        discordButton.Size = UDim2.new(0, 20, 0, 20)
        discordButton.Position = UDim2.new(1, -25, 0.5, -10)
        discordButton.AnchorPoint = Vector2.new(1, 0.5)
        discordButton.BackgroundTransparency = 1
        discordButton.ImageColor3 = Modules.Themes:GetTheme().SubText
        discordButton.ZIndex = 3
        
        discordButton.MouseButton1Click:Connect(function()
            Modules.Discord:OpenDiscord()
        end)
        discordButton.Parent = window.DragHandle
        
        window.DragHandle.Parent = window.MainFrame
        
        -- Container de tabs
        window.TabsContainer = Instance.new("Frame")
        window.TabsContainer.Name = "TabsContainer"
        window.TabsContainer.Size = UDim2.new(1, 0, 0, TAB_HEIGHT)
        window.TabsContainer.Position = UDim2.new(0, 0, 0, DRAG_HANDLE_HEIGHT)
        window.TabsContainer.BackgroundTransparency = 1
        window.TabsContainer.ZIndex = 2
        
        local tabsUIList = Instance.new("UIListLayout")
        tabsUIList.FillDirection = Enum.FillDirection.Horizontal
        tabsUIList.Padding = UDim.new(0, 0)
        tabsUIList.Parent = window.TabsContainer
        
        window.TabsContainer.Parent = window.MainFrame
        
        -- Content frame
        window.ContentFrame = Instance.new("Frame")
        window.ContentFrame.Name = "Content"
        window.ContentFrame.Size = UDim2.new(1, -30, 1, -DRAG_HANDLE_HEIGHT - TAB_HEIGHT - 20)
        window.ContentFrame.Position = UDim2.new(0, 15, 0, DRAG_HANDLE_HEIGHT + TAB_HEIGHT + 10)
        window.ContentFrame.BackgroundTransparency = 1
        window.ContentFrame.ClipsDescendants = true
        
        window.ContentFrame.Parent = window.MainFrame
        
        -- Inicializar sistema de drag
        self:InitDrag(window)
        
        -- Key System
        if window.KeySystem and window.Key then
            self:ShowKeyScreen(window)
        else
            window.MainFrame.Parent = window.ScreenGui
            window.ScreenGui.Parent = game:GetService("CoreGui")
            
            -- Animar entrada
            task.spawn(function()
                task.wait(0.1)
                window.MainFrame.Visible = true
                local tween = TweenService:Create(window.MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, window.Size.X, 0, window.Size.Y),
                    Position = window.Position
                })
                tween:Play()
            end)
        end
        
        -- Tabs
        window.Tabs = {}
        window.ActiveTab = nil
        
        table.insert(self.Windows, window)
        self.ActiveWindow = window
        
        return window
    end,
    
    InitDrag = function(self, window)
        local dragging
        local dragInput
        local dragStart
        local startPos
        
        local function update(input)
            local delta = input.Position - dragStart
            local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            
            -- Limitar dentro da tela
            local screenSize = workspace.CurrentCamera.ViewportSize
            local windowSize = window.MainFrame.AbsoluteSize
            
            local minX = 0
            local maxX = screenSize.X - windowSize.X
            local minY = 0
            local maxY = screenSize.Y - windowSize.Y
            
            local absX = newPos.X.Offset
            local absY = newPos.Y.Offset
            
            absX = math.clamp(absX, minX, maxX)
            absY = math.clamp(absY, minY, maxY)
            
            window.MainFrame.Position = UDim2.new(0, absX, 0, absY)
        end
        
        window.DragHandle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = window.MainFrame.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        
        window.DragHandle.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input == dragInput then
                update(input)
            end
        end)
    end,
    
    ShowKeyScreen = function(self, window)
        local keyScreen = Instance.new("Frame")
        keyScreen.Name = "KeyScreen"
        keyScreen.Size = UDim2.new(1, 0, 1, 0)
        keyScreen.BackgroundColor3 = Modules.Themes:GetTheme().Primary
        keyScreen.BorderSizePixel = 0
        
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, 8)
        uiCorner.Parent = keyScreen
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Text = window.Name
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 24
        titleLabel.TextColor3 = Modules.Themes:GetTheme().Accent
        titleLabel.Size = UDim2.new(1, 0, 0, 40)
        titleLabel.Position = UDim2.new(0, 0, 0.2, 0)
        titleLabel.BackgroundTransparency = 1
        
        local subtitleLabel = Instance.new("TextLabel")
        subtitleLabel.Text = "Insira a Key de acesso"
        subtitleLabel.Font = Enum.Font.Gotham
        subtitleLabel.TextSize = 16
        subtitleLabel.TextColor3 = Modules.Themes:GetTheme().SubText
        subtitleLabel.Size = UDim2.new(1, 0, 0, 30)
        subtitleLabel.Position = UDim2.new(0, 0, 0.3, 0)
        subtitleLabel.BackgroundTransparency = 1
        
        local keyInput = Instance.new("TextBox")
        keyInput.Name = "KeyInput"
        keyInput.PlaceholderText = "Digite sua key aqui..."
        keyInput.Font = Enum.Font.Gotham
        keyInput.TextSize = 14
        keyInput.TextColor3 = Modules.Themes:GetTheme().Text
        keyInput.PlaceholderColor3 = Modules.Themes:GetTheme().SubText
        keyInput.Size = UDim2.new(0, 300, 0, 40)
        keyInput.Position = UDim2.new(0.5, -150, 0.5, -20)
        keyInput.BackgroundColor3 = Modules.Themes:GetTheme().Secondary
        keyInput.BorderSizePixel = 0
        
        local inputCorner = Instance.new("UICorner")
        inputCorner.CornerRadius = UDim.new(0, 4)
        inputCorner.Parent = keyInput
        
        local verifyButton = Instance.new("TextButton")
        verifyButton.Name = "VerifyButton"
        verifyButton.Text = "VERIFICAR"
        verifyButton.Font = Enum.Font.GothamBold
        verifyButton.TextSize = 14
        verifyButton.TextColor3 = Modules.Themes:GetTheme().Text
        verifyButton.Size = UDim2.new(0, 300, 0, 40)
        verifyButton.Position = UDim2.new(0.5, -150, 0.5, 40)
        verifyButton.BackgroundColor3 = Modules.Themes:GetTheme().Accent
        verifyButton.BorderSizePixel = 0
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 4)
        buttonCorner.Parent = verifyButton
        
        local messageLabel = Instance.new("TextLabel")
        messageLabel.Name = "Message"
        messageLabel.Text = ""
        messageLabel.Font = Enum.Font.Gotham
        messageLabel.TextSize = 14
        messageLabel.TextColor3 = Modules.Themes:GetTheme().Error
        messageLabel.Size = UDim2.new(1, 0, 0, 30)
        messageLabel.Position = UDim2.new(0, 0, 0.7, 0)
        messageLabel.BackgroundTransparency = 1
        messageLabel.Visible = false
        
        -- Montar hierarquia
        titleLabel.Parent = keyScreen
        subtitleLabel.Parent = keyScreen
        keyInput.Parent = keyScreen
        verifyButton.Parent = keyScreen
        messageLabel.Parent = keyScreen
        
        keyScreen.Parent = window.ScreenGui
        window.ScreenGui.Parent = game:GetService("CoreGui")
        
        -- Eventos
        verifyButton.MouseButton1Click:Connect(function()
            local key = keyInput.Text
            if key == "" then return end
            
            local success, message = Modules.KeySystem:VerifyKey(key, window.Key)
            
            messageLabel.Text = message
            messageLabel.TextColor3 = success and Modules.Themes:GetTheme().Success or Modules.Themes:GetTheme().Error
            messageLabel.Visible = true
            
            if success then
                task.wait(1)
                keyScreen:Destroy()
                window.MainFrame.Parent = window.ScreenGui
                
                -- Animar entrada da janela principal
                window.MainFrame.Visible = true
                local tween = TweenService:Create(window.MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, window.Size.X, 0, window.Size.Y),
                    Position = window.Position
                })
                tween:Play()
            end
        end)
        
        keyInput.Focused:Connect(function()
            messageLabel.Visible = false
        end)
    end,
    
    CreateTab = function(self, tabName, icon)
        local tab = {}
        tab.Name = tabName
        tab.Icon = icon
        tab.Sections = {}
        
        -- Criar botão da tab
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName .. "Tab"
        tabButton.Text = ""
        tabButton.Size = UDim2.new(0, 100, 1, 0)
        tabButton.BackgroundColor3 = Modules.Themes:GetTheme().Secondary
        tabButton.BorderSizePixel = 0
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 6)
        tabCorner.Parent = tabButton
        
        local tabIcon = Instance.new("ImageLabel")
        tabIcon.Name = "Icon"
        tabIcon.Image = icon or ""
        tabIcon.Size = UDim2.new(0, 20, 0, 20)
        tabIcon.Position = UDim2.new(0.5, -25, 0.5, -10)
        tabIcon.BackgroundTransparency = 1
        tabIcon.ImageColor3 = Modules.Themes:GetTheme().Text
        
        local tabLabel = Instance.new("TextLabel")
        tabLabel.Name = "Label"
        tabLabel.Text = tabName
        tabLabel.Font = Enum.Font.GothamMedium
        tabLabel.TextSize = 14
        tabLabel.TextColor3 = Modules.Themes:GetTheme().Text
        tabLabel.Size = UDim2.new(0, 60, 0, 20)
        tabLabel.Position = UDim2.new(0.5, -10, 0.5, -10)
        tabLabel.BackgroundTransparency = 1
        tabLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        tabIcon.Parent = tabButton
        tabLabel.Parent = tabButton
        tabButton.Parent = self.TabsContainer
        
        -- Content frame para esta tab
        local tabContent = Instance.new("Frame")
        tabContent.Name = tabName .. "Content"
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.Position = UDim2.new(0, 0, 0, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.Visible = false
        
        local contentList = Instance.new("UIListLayout")
        contentList.Padding = UDim.new(0, SECTION_PADDING)
        contentList.Parent = tabContent
        
        tabContent.Parent = self.ContentFrame
        
        -- Função para ativar tab
        local function activateTab()
            if self.ActiveTab then
                -- Desativar tab anterior
                local prevTabButton = self.TabsContainer:FindFirstChild(self.ActiveTab.Name .. "Tab")
                if prevTabButton then
                    TweenService:Create(prevTabButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = Modules.Themes:GetTheme().Secondary
                    }):Play()
                end
                
                local prevTabContent = self.ContentFrame:FindFirstChild(self.ActiveTab.Name .. "Content")
                if prevTabContent then
                    prevTabContent.Visible = false
                end
            end
            
            -- Ativar nova tab
            TweenService:Create(tabButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Modules.Themes:GetTheme().Tertiary
            }):Play()
            
            tabContent.Visible = true
            self.ActiveTab = tab
        end
        
        -- Evento de clique
        tabButton.MouseButton1Click:Connect(activateTab)
        
        -- Definir como primeira tab se não houver tab ativa
        if not self.ActiveTab then
            activateTab()
        end
        
        -- Métodos da tab
        tab.CreateSection = function(sectionName)
            local section = {}
            section.Name = sectionName
            
            -- Criar frame da section
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Name = sectionName .. "Section"
            sectionFrame.Size = UDim2.new(1, 0, 0, 0)
            sectionFrame.BackgroundColor3 = Modules.Themes:GetTheme().Secondary
            sectionFrame.BackgroundTransparency = 0.5
            sectionFrame.BorderSizePixel = 0
            
            local sectionCorner = Instance.new("UICorner")
            sectionCorner.CornerRadius = UDim.new(0, 6)
            sectionCorner.Parent = sectionFrame
            
            local sectionStroke = Instance.new("UIStroke")
            sectionStroke.Color = Modules.Themes:GetTheme().Border
            sectionStroke.Thickness = 1
            sectionStroke.Parent = sectionFrame
            
            local sectionTitle = Instance.new("TextLabel")
            sectionTitle.Name = "Title"
            sectionTitle.Text = sectionName
            sectionTitle.Font = Enum.Font.GothamBold
            sectionTitle.TextSize = 16
            sectionTitle.TextColor3 = Modules.Themes:GetTheme().Accent
            sectionTitle.Size = UDim2.new(1, -20, 0, 30)
            sectionTitle.Position = UDim2.new(0, 10, 0, 5)
            sectionTitle.BackgroundTransparency = 1
            sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local sectionContent = Instance.new("Frame")
            sectionContent.Name = "Content"
            sectionContent.Size = UDim2.new(1, -20, 1, -40)
            sectionContent.Position = UDim2.new(0, 10, 0, 35)
            sectionContent.BackgroundTransparency = 1
            
            local contentList = Instance.new("UIListLayout")
            contentList.Padding = UDim.new(0, COMPONENT_SPACING)
            contentList.Parent = sectionContent
            
            sectionTitle.Parent = sectionFrame
            sectionContent.Parent = sectionFrame
            sectionFrame.Parent = tabContent
            
            -- Métodos da section
            section.CreateButton = function(buttonName, callback)
                local button = Instance.new("TextButton")
                button.Name = buttonName
                button.Text = buttonName
                button.Font = Enum.Font.Gotham
                button.TextSize = 14
                button.TextColor3 = Modules.Themes:GetTheme().Text
                button.Size = UDim2.new(1, 0, 0, 35)
                button.BackgroundColor3 = Modules.Themes:GetTheme().Tertiary
                button.BorderSizePixel = 0
                button.AutoButtonColor = false
                
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 4)
                buttonCorner.Parent = button
                
                local buttonStroke = Instance.new("UIStroke")
                buttonStroke.Color = Modules.Themes:GetTheme().Border
                buttonStroke.Thickness = 1
                buttonStroke.Parent = button
                
                button.MouseEnter:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(
                            math.floor(Modules.Themes:GetTheme().Tertiary.R * 255 + 20),
                            math.floor(Modules.Themes:GetTheme().Tertiary.G * 255 + 20),
                            math.floor(Modules.Themes:GetTheme().Tertiary.B * 255 + 20)
                        )
                    }):Play()
                end)
                
                button.MouseLeave:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {
                        BackgroundColor3 = Modules.Themes:GetTheme().Tertiary
                    }):Play()
                end)
                
                button.MouseButton1Click:Connect(function()
                    if callback then
                        callback()
                    end
                end)
                
                button.Parent = sectionContent
                
                -- Atualizar altura da section
                sectionFrame.Size = UDim2.new(1, 0, 0, sectionContent.UIListLayout.AbsoluteContentSize.Y + 45)
                
                return button
            end
            
            section.CreateToggle = function(toggleName, defaultValue, callback)
                local toggle = Instance.new("Frame")
                toggle.Name = toggleName
                toggle.Size = UDim2.new(1, 0, 0, 30)
                toggle.BackgroundTransparency = 1
                
                local toggleLabel = Instance.new("TextLabel")
                toggleLabel.Name = "Label"
                toggleLabel.Text = toggleName
                toggleLabel.Font = Enum.Font.Gotham
                toggleLabel.TextSize = 14
                toggleLabel.TextColor3 = Modules.Themes:GetTheme().Text
                toggleLabel.Size = UDim2.new(1, -50, 1, 0)
                toggleLabel.Position = UDim2.new(0, 0, 0, 0)
                toggleLabel.BackgroundTransparency = 1
                toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local toggleButton = Instance.new("TextButton")
                toggleButton.Name = "Toggle"
                toggleButton.Size = UDim2.new(0, 40, 0, 20)
                toggleButton.Position = UDim2.new(1, -40, 0.5, -10)
                toggleButton.AnchorPoint = Vector2.new(1, 0.5)
                toggleButton.BackgroundColor3 = defaultValue and Modules.Themes:GetTheme().Accent or Modules.Themes:GetTheme().Tertiary
                toggleButton.BorderSizePixel = 0
                toggleButton.AutoButtonColor = false
                
                local toggleCorner = Instance.new("UICorner")
                toggleCorner.CornerRadius = UDim.new(0, 10)
                toggleCorner.Parent = toggleButton
                
                local toggleState = defaultValue or false
                
                toggleButton.MouseButton1Click:Connect(function()
                    toggleState = not toggleState
                    
                    TweenService:Create(toggleButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = toggleState and Modules.Themes:GetTheme().Accent or Modules.Themes:GetTheme().Tertiary
                    }):Play()
                    
                    if callback then
                        callback(toggleState)
                    end
                end)
                
                toggleLabel.Parent = toggle
                toggleButton.Parent = toggle
                toggle.Parent = sectionContent
                
                -- Atualizar altura da section
                sectionFrame.Size = UDim2.new(1, 0, 0, sectionContent.UIListLayout.AbsoluteContentSize.Y + 45)
                
                return toggle
            end
            
            section.CreateSlider = function(sliderName, minValue, maxValue, defaultValue, callback)
                local slider = Instance.new("Frame")
                slider.Name = sliderName
                slider.Size = UDim2.new(1, 0, 0, 60)
                slider.BackgroundTransparency = 1
                
                local sliderLabel = Instance.new("TextLabel")
                sliderLabel.Name = "Label"
                sliderLabel.Text = sliderName
                sliderLabel.Font = Enum.Font.Gotham
                sliderLabel.TextSize = 14
                sliderLabel.TextColor3 = Modules.Themes:GetTheme().Text
                sliderLabel.Size = UDim2.new(1, 0, 0, 20)
                sliderLabel.Position = UDim2.new(0, 0, 0, 0)
                sliderLabel.BackgroundTransparency = 1
                sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local valueLabel = Instance.new("TextLabel")
                valueLabel.Name = "Value"
                valueLabel.Text = tostring(defaultValue or minValue)
                valueLabel.Font = Enum.Font.GothamMedium
                valueLabel.TextSize = 14
                valueLabel.TextColor3 = Modules.Themes:GetTheme().Accent
                valueLabel.Size = UDim2.new(0, 50, 0, 20)
                valueLabel.Position = UDim2.new(1, -50, 0, 0)
                valueLabel.AnchorPoint = Vector2.new(1, 0)
                valueLabel.BackgroundTransparency = 1
                valueLabel.TextXAlignment = Enum.TextXAlignment.Right
                
                local sliderTrack = Instance.new("Frame")
                sliderTrack.Name = "Track"
                sliderTrack.Size = UDim2.new(1, 0, 0, 6)
                sliderTrack.Position = UDim2.new(0, 0, 0, 30)
                sliderTrack.BackgroundColor3 = Modules.Themes:GetTheme().Tertiary
                sliderTrack.BorderSizePixel = 0
                
                local trackCorner = Instance.new("UICorner")
                trackCorner.CornerRadius = UDim.new(0, 3)
                trackCorner.Parent = sliderTrack
                
                local sliderFill = Instance.new("Frame")
                sliderFill.Name = "Fill"
                sliderFill.Size = UDim2.new(0, 0, 1, 0)
                sliderFill.BackgroundColor3 = Modules.Themes:GetTheme().Accent
                sliderFill.BorderSizePixel = 0
                
                local fillCorner = Instance.new("UICorner")
                fillCorner.CornerRadius = UDim.new(0, 3)
                fillCorner.Parent = sliderFill
                
                local sliderButton = Instance.new("TextButton")
                sliderButton.Name = "SliderButton"
                sliderButton.Size = UDim2.new(0, 20, 0, 20)
                sliderButton.Position = UDim2.new(0, -10, 0.5, -10)
                sliderButton.AnchorPoint = Vector2.new(0, 0.5)
                sliderButton.BackgroundColor3 = Modules.Themes:GetTheme().Text
                sliderButton.BorderSizePixel = 0
                sliderButton.AutoButtonColor = false
                
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 10)
                buttonCorner.Parent = sliderButton
                
                sliderFill.Parent = sliderTrack
                sliderButton.Parent = sliderTrack
                
                local currentValue = defaultValue or minValue
                local isSliding = false
                
                local function updateSlider(value)
                    currentValue = math.clamp(value, minValue, maxValue)
                    local percent = (currentValue - minValue) / (maxValue - minValue)
                    
                    sliderFill.Size = UDim2.new(percent, 0, 1, 0)
                    sliderButton.Position = UDim2.new(percent, -10, 0.5, -10)
                    valueLabel.Text = tostring(math.floor(currentValue))
                    
                    if callback then
                        callback(currentValue)
                    end
                end
                
                sliderButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        isSliding = true
                    end
                end)
                
                sliderButton.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        isSliding = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local mousePos = input.Position
                        local trackPos = sliderTrack.AbsolutePosition
                        local trackSize = sliderTrack.AbsoluteSize
                        
                        local relativeX = (mousePos.X - trackPos.X) / trackSize.X
                        relativeX = math.clamp(relativeX, 0, 1)
                        
                        local value = minValue + (relativeX * (maxValue - minValue))
                        updateSlider(value)
                    end
                end)
                
                sliderTrack.MouseButton1Down:Connect(function()
                    local mousePos = UserInputService:GetMouseLocation()
                    local trackPos = sliderTrack.AbsolutePosition
                    local trackSize = sliderTrack.AbsoluteSize
                    
                    local relativeX = (mousePos.X - trackPos.X) / trackSize.X
                    relativeX = math.clamp(relativeX, 0, 1)
                    
                    local value = minValue + (relativeX * (maxValue - minValue))
                    updateSlider(value)
                end)
                
                -- Inicializar
                updateSlider(currentValue)
                
                sliderLabel.Parent = slider
                valueLabel.Parent = slider
                sliderTrack.Parent = slider
                slider.Parent = sectionContent
                
                -- Atualizar altura da section
                sectionFrame.Size = UDim2.new(1, 0, 0, sectionContent.UIListLayout.AbsoluteContentSize.Y + 45)
                
                return slider
            end
            
            section.CreateLabel = function(labelText)
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Text = labelText
                label.Font = Enum.Font.Gotham
                label.TextSize = 14
                label.TextColor3 = Modules.Themes:GetTheme().SubText
                label.Size = UDim2.new(1, 0, 0, 25)
                label.BackgroundTransparency = 1
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextWrapped = true
                
                label.Parent = sectionContent
                
                -- Atualizar altura da section
                sectionFrame.Size = UDim2.new(1, 0, 0, sectionContent.UIListLayout.AbsoluteContentSize.Y + 45)
                
                return label
            end
            
            section.CreateSeparator = function()
                local separator = Instance.new("Frame")
                separator.Name = "Separator"
                separator.Size = UDim2.new(1, 0, 0, 1)
                separator.BackgroundColor3 = Modules.Themes:GetTheme().Border
                separator.BorderSizePixel = 0
                
                separator.Parent = sectionContent
                
                -- Atualizar altura da section
                sectionFrame.Size = UDim2.new(1, 0, 0, sectionContent.UIListLayout.AbsoluteContentSize.Y + 45)
                
                return separator
            end
            
            -- Atualizar altura inicial
            sectionFrame.Size = UDim2.new(1, 0, 0, 45)
            
            return section
        end
        
        return tab
    end
}

-- API Principal
function AxiomX:CreateWindow(config)
    return Modules.Window:Create(config)
end

-- Funções auxiliares
function AxiomX:ShowNotification(title, message, type, duration)
    Modules.Notifications:ShowNotification(title, message, type, duration)
end

function AxiomX:SetTheme(themeName)
    return Modules.Themes:SetTheme(themeName)
end

function AxiomX:GetCurrentTheme()
    return Modules.Themes.Current
end

function AxiomX:AddCustomTheme(name, themeData)
    return Modules.Themes:AddCustomTheme(name, themeData)
end

function AxiomX:SetDiscordURL(url)
    Modules.Discord:SetDiscordURL(url)
end

function AxiomX:GetVersion()
    return "1.0.0"
end

-- Exemplo de uso
local ExampleUsage = [[
-- AxiomX UI Library - Exemplo de Uso

local AxiomX = loadstring(game:HttpGet(""))()

local Window = AxiomX:CreateWindow({
    Name = "AxiomX Hub Premium",
    Theme = "Dark",
    KeySystem = true,
    Key = "1234",
    Discord = "https://discord.gg/axiomx",
    Size = Vector2.new(550, 500)
})

local MainTab = Window:CreateTab("Main", "rbxassetid://10734846452")
local MainSection = MainTab:CreateSection("Principal")

MainSection:CreateButton("Testar AxiomX", function()
    AxiomX:ShowNotification("Sucesso", "AxiomX está funcionando!", "Success", 3)
    print("AxiomX rodando perfeitamente!")
end)

MainSection:CreateToggle("Habilitar Features", false, function(state)
    print("Toggle state:", state)
end)

MainSection:CreateSlider("Velocidade", 0, 100, 50, function(value)
    print("Velocidade:", value)
end)

MainSection:CreateLabel("Bem-vindo ao AxiomX UI")
MainSection:CreateSeparator()

local ConfigTab = Window:CreateTab("Config", "rbxassetid://10734846789")
local ConfigSection = ConfigTab:CreateSection("Configurações")

ConfigSection:CreateButton("Mudar para Tema Midnight", function()
    AxiomX:SetTheme("Midnight")
    AxiomX:ShowNotification("Tema", "Tema alterado para Midnight", "Info", 3)
end)

ConfigSection:CreateButton("Copiar Discord", function()
    AxiomX:ShowNotification("Discord", "Link copiado para área de transferência", "Success", 3)
end)
]]

return AxiomX