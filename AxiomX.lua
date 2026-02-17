local BoladoHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/GigaScripts15/LibaryBoladoHub/refs/heads/main/BoladoHub.lua"))()

local gui = BoladoHub.new({
    Name = "Meu Script",
    Size = UDim2.new(0, 450, 0, 450) -- Aumentei um pouco para caber mais opções
})

-- Abas
local main = gui:AddTab("Main", "home")
local teleports = gui:AddTab("Teleports", "star")
local visual = gui:AddTab("Visual", "eye") -- Nova aba para visual

-- ============ SISTEMA DE HIGHLIGHT LEGÍTIMO ============
local HighlightSystem = {
    ActiveHighlights = {},
    PlayerHighlights = {}
}

-- Função para criar highlight
function HighlightSystem.createHighlight(target, color, outlineColor)
    if not target or not target:IsA("Model") then
        return nil
    end
    
    -- Verificar se já existe highlight
    if HighlightSystem.ActiveHighlights[target] then
        return HighlightSystem.ActiveHighlights[target]
    end
    
    -- Criar highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "PlayerHighlight_" .. target.Name
    highlight.FillColor = color or Color3.fromRGB(0, 255, 0)
    highlight.OutlineColor = outlineColor or Color3.fromRGB(0, 200, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = target
    highlight.Parent = game:GetService("CoreGui") -- Ou workspace
    
    -- Salvar no cache
    HighlightSystem.ActiveHighlights[target] = highlight
    
    -- Conectar remoção automática
    target.Destroying:Connect(function()
        HighlightSystem.removeHighlight(target)
    end)
    
    return highlight
end

-- Função para remover highlight
function HighlightSystem.removeHighlight(target)
    local highlight = HighlightSystem.ActiveHighlights[target]
    if highlight then
        highlight:Destroy()
        HighlightSystem.ActiveHighlights[target] = nil
    end
end

-- Limpar todos os highlights
function HighlightSystem.clearAll()
    for target, highlight in pairs(HighlightSystem.ActiveHighlights) do
        highlight:Destroy()
    end
    HighlightSystem.ActiveHighlights = {}
end

-- ============ ELEMENTOS NA ABA PRINCIPAL ============
gui:Label({
    Parent = main,
    Text = "Configurações de Jogo",
    Size = 16,
    Bold = true
})

-- REMOVI as opções de Aimbot (trapaça) e substituí por opções legítimas

-- Configurações de movimento
gui:Slider({
    Parent = main,
    Text = "Velocidade",
    Min = 16,
    Max = 100,
    Default = 16,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = value
                gui:Log("Velocidade ajustada: " .. value)
            end
        end
    end
})

gui:Slider({
    Parent = main,
    Text = "Altura do Pulo",
    Min = 50,
    Max = 200,
    Default = 50,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.JumpPower = value
                gui:Log("Altura do pulo: " .. value)
            end
        end
    end
})

gui:Separator({Parent = main})

-- ============ ABA VISUAL (HIGHLIGHTS LEGÍTIMOS) ============
gui:Label({
    Parent = visual,
    Text = "Sistema de Highlight",
    Size = 16,
    Bold = true
})

gui:Label({
    Parent = visual,
    Text = "Apenas para aliados/itens do jogo",
    Size = 12,
    Bold = false
})

-- Highlight para aliados (LEGÍTIMO)
local highlightAliados = false
gui:Toggle({
    Parent = visual,
    Text = "Highlight de Aliados",
    Callback = function(state)
        highlightAliados = state
        gui:Log("Highlight de aliados: " .. (state and "ON" or "OFF"))
        
        if state then
            -- Sistema para destacar aliados (como em muitos jogos)
            spawn(function()
                while highlightAliados do
                    local player = game.Players.LocalPlayer
                    if player and player.Team then
                        for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                            if otherPlayer ~= player and otherPlayer.Team == player.Team then
                                if otherPlayer.Character then
                                    HighlightSystem.createHighlight(
                                        otherPlayer.Character,
                                        Color3.fromRGB(0, 255, 0),  -- Verde para aliados
                                        Color3.fromRGB(0, 200, 0)
                                    )
                                end
                            end
                        end
                    end
                    wait(1)
                end
                
                -- Limpar ao desativar
                HighlightSystem.clearAll()
            end)
        else
            HighlightSystem.clearAll()
        end
    end
})

-- Highlight para objetivos
gui:Toggle({
    Parent = visual,
    Text = "Highlight de Objetivos",
    Callback = function(state)
        gui:Log("Highlight de objetivos: " .. (state and "ON" or "OFF"))
        
        if state then
            -- Procurar partes nomeadas como "Objective", "Flag", etc.
            spawn(function()
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and 
                       (obj.Name:find("Objective") or 
                        obj.Name:find("Flag") or 
                        obj.Name:find("Target")) then
                        
                        -- Criar highlight amarelo para objetivos
                        local model = Instance.new("Model")
                        model.Name = "ObjectiveHighlight"
                        obj:Clone().Parent = model
                        
                        HighlightSystem.createHighlight(
                            model,
                            Color3.fromRGB(255, 255, 0),  -- Amarelo
                            Color3.fromRGB(255, 200, 0)
                        )
                    end
                end
            end)
        else
            -- Remover apenas highlights de objetivos
            for target, highlight in pairs(HighlightSystem.ActiveHighlights) do
                if target.Name:find("ObjectiveHighlight") then
                    HighlightSystem.removeHighlight(target)
                end
            end
        end
    end
})

-- Seletor de cor para highlight
gui:Dropdown({
    Parent = visual,
    Text = "Cor do Highlight",
    Options = {"Verde", "Azul", "Vermelho", "Amarelo", "Roxo"},
    Default = "Verde",
    Callback = function(option)
        gui:Log("Cor selecionada: " .. option)
        -- Esta função pode ser expandida para alterar as cores dinamicamente
    end
})

-- Botão para limpar todos os highlights
gui:Button({
    Parent = visual,
    Text = "Limpar Highlights",
    Icon = "trash-2",
    Callback = function()
        HighlightSystem.clearAll()
        gui:Log("Todos os highlights foram removidos")
    end
})

gui:Separator({Parent = visual})

-- Opções visuais adicionais
gui:Toggle({
    Parent = visual,
    Text = "Mostrar Nomes",
    Callback = function(state)
        gui:Log("Mostrar nomes: " .. (state and "ON" or "OFF"))
        -- Aqui você poderia implementar um sistema legítimo de mostrar nomes acima dos jogadores
    end
})

gui:Toggle({
    Parent = visual,
    Text = "Mostrar Healthbars",
    Callback = function(state)
        gui:Log("Healthbars: " .. (state and "ON" or "OFF"))
        -- Sistema legítimo de mostrar barras de vida (apenas para aliados)
    end
})

-- ============ ABA TELEPORTS ============
gui:Label({
    Parent = teleports,
    Text = "Teleportes Seguros",
    Size = 16,
    Bold = true
})

-- Teleports apenas para lugares públicos/abertos
local safeLocations = {
    ["Spawn"] = Vector3.new(0, 5, 0),
    ["Base"] = Vector3.new(100, 5, 0),
    ["Loja"] = Vector3.new(50, 5, -50),
    ["Arena"] = Vector3.new(-100, 5, 0)
}

for name, position in pairs(safeLocations) do
    gui:Button({
        Parent = teleports,
        Text = "Teleport: " .. name,
        Callback = function()
            local char = game.Players.LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(position)
                    gui:Log("Teleportado para " .. name)
                    
                    -- Adicionar highlight temporário no destino
                    local highlightPart = Instance.new("Part")
                    highlightPart.Size = Vector3.new(5, 0.1, 5)
                    highlightPart.Position = position + Vector3.new(0, 2.5, 0)
                    highlightPart.Anchored = true
                    highlightPart.CanCollide = false
                    highlightPart.Transparency = 0.7
                    highlightPart.Color = Color3.fromRGB(0, 255, 0)
                    highlightPart.Parent = workspace
                    
                    game.Debris:AddItem(highlightPart, 3)
                end
            end
        end
    })
end

-- ============ BOTÕES UTILITÁRIOS ============
gui:Separator({Parent = main})

gui:Button({
    Parent = main,
    Text = "Reset Personagem",
    Icon = "refresh-cw",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character then
            player.Character:BreakJoints()
            gui:Log("Personagem resetado")
        end
    end
})

gui:Button({
    Parent = main,
    Text = "Ativar Fly (Teste)",
    Icon = "wind",
    Callback = function()
        -- Sistema de voo básico para teste em áreas seguras
        gui:Log("Modo fly ativado (apenas teste)")
        -- NOTA: Implementação de fly seria longa, apenas um placeholder
    end
})

-- ============ HOTKEYS ============
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        if gui:IsVisible() then
            gui:Hide()
        else
            gui:Show()
        end
    end
    
    -- Hotkey para limpar highlights (F1)
    if input.KeyCode == Enum.KeyCode.F1 then
        HighlightSystem.clearAll()
        gui:Log("Highlights limpos via F1")
    end
end)

-- ============ LOG INICIAL ============
gui:Log("✅ Script GUI carregado com sucesso!")
gui:Log("📌 Pressione RightControl para mostrar/ocultar")
gui:Log("🎯 Sistema de highlight LEGÍTIMO ativo")
gui:Log("⚠️ Use apenas features permitidas pelo jogo")

-- Auto-cleanup quando o jogador sai
game.Players.LocalPlayer.CharacterRemoving:Connect(function()
    HighlightSystem.clearAll()
end)

game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.Name == gui.Name then
        HighlightSystem.clearAll()
    end
end)