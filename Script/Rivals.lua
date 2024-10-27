-- Chargement de LinoriaLib
local LinoriaLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/"))()

-- Création de la fenêtre principale
local Window = LinoriaLib:CreateWindow("Rivals Script") -- Titre de la fenêtre

-- Création de l'onglet "Legit"
local LegitTab = Window:CreateTab("Legit")

-- Ajouter des contrôles dans l'onglet "Legit"
LegitTab:CreateLabel("Options Legit") -- Crée une étiquette

-- Variables pour l'aimbot
local fov = 700       -- Champ de vision
local aimSpeed = 5    -- Vitesse d'aim
local predictionMultiplier = 0.1  -- Multiplicateur pour la prédiction

-- Slider pour le FOV
LegitTab:CreateSlider("FOV", 100, 1000, 700, function(value)
    fov = value
    print("FOV réglé à: " .. value) -- Remplacez ceci par votre logique
end)

-- Slider pour la vitesse d'aim
LegitTab:CreateSlider("Aim Speed", 1, 20, 5, function(value)
    aimSpeed = value
    print("Vitesse d'aim réglée à: " .. value) -- Remplacez ceci par votre logique
end)

-- Slider pour le multiplicateur de prédiction
LegitTab:CreateSlider("Prediction Multiplier", 0.1, 1, 0.1, function(value)
    predictionMultiplier = value
    print("Multiplicateur de prédiction réglé à: " .. value) -- Remplacez ceci par votre logique
end)

-- Création de l'onglet "Visual"
local VisualTab = Window:CreateTab("Visual")

-- Ajouter des contrôles dans l'onglet "Visual"
VisualTab:CreateLabel("Options Visuelles") -- Crée une étiquette

-- Checkbox pour activer/désactiver une fonction visuelle
VisualTab:CreateToggle("Activer les Box ESP", false, function(state)
    if state then
        print("Box ESP activé") -- Remplacez ceci par votre logique pour activer l'ESP
    else
        print("Box ESP désactivé") -- Remplacez ceci par votre logique pour désactiver l'ESP
    end
end)

-- Slider pour la transparence de l'ESP
VisualTab:CreateSlider("Transparence ESP", 0, 1, 0.5, function(value)
    print("Transparence ESP réglée à: " .. value) -- Remplacez ceci par votre logique
end)

-- Configuration du script d'aimbot
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = game.Workspace.CurrentCamera

-- Fonction pour prédire la position de la cible
local function predict_position(targetPosition, velocity)
    return targetPosition + (velocity * predictionMultiplier)
end

-- Fonction pour obtenir la cible la plus proche
local function get_closest_target()
    local closestPlayer = nil
    local shortestDistance = fov

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local targetPart = player.Character:FindFirstChild("Head") -- On vise la tête
            local targetPosition = targetPart.Position
            local targetVelocity = player.Character.HumanoidRootPart.Velocity or Vector3.new(0, 0, 0)

            -- Calcul de la position prédite de la cible
            local predictedPosition = predict_position(targetPosition, targetVelocity)
            local screenPosition, onScreen = Camera:WorldToViewportPoint(predictedPosition)

            if onScreen then
                local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                local distanceFromCenter = (Vector2.new(screenPosition.X, screenPosition.Y) - screenCenter).Magnitude

                if distanceFromCenter < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distanceFromCenter
                end
            end
        end
    end

    return closestPlayer
end

-- Fonction principale d'aimbot
local function aim_at_target()
    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = get_closest_target()

        if target and target.Character and target.Character:FindFirstChild("Head") then
            local targetPart = target.Character.Head
            local predictedPosition = predict_position(targetPart.Position, target.Character.HumanoidRootPart.Velocity)

            -- Convertir la position prédite en coordonnées écran et calculer le mouvement de la souris
            local screenPosition = Camera:WorldToViewportPoint(predictedPosition)
            local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            local deltaX = (screenPosition.X - screenCenter.X) / aimSpeed
            local deltaY = (screenPosition.Y - screenCenter.Y) / aimSpeed

            -- Déplacement de la souris vers la cible
            mousemoverel(deltaX, deltaY)
        end
    end
end

-- Connexion à RenderStepped pour exécuter la fonction d'aimbot
RunService.RenderStepped:Connect(aim_at_target)
