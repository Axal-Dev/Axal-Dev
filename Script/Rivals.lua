-- Chargement de LinoriaLib
local LinoriaLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/"))()

-- Création de la fenêtre principale
local Window = LinoriaLib:CreateWindow("Aimbot GUI") -- Titre de la fenêtre

-- Création d'un onglet "Legit"
local LegitTab = Window:CreateTab("Legit")

-- Exemple de label et slider dans l'onglet Legit
LegitTab:CreateLabel("Bienvenue dans l'onglet Legit!") -- Crée une étiquette

-- Slider pour ajuster une valeur (ex: FOV)
LegitTab:CreateSlider("FOV", 100, 1000, 700, function(value)
    print("FOV réglé à: " .. value) -- Remplacez ceci par la logique souhaitée
end)

-- Slider pour ajuster la vitesse d'aim
LegitTab:CreateSlider("Aim Speed", 1, 20, 5, function(value)
    print("Vitesse d'aim réglée à: " .. value) -- Remplacez ceci par la logique souhaitée
end)

-- Slider pour ajuster le multiplicateur de prédiction
LegitTab:CreateSlider("Prediction Multiplier", 0.1, 1, 0.1, function(value)
    print("Multiplicateur de prédiction réglé à: " .. value) -- Remplacez ceci par la logique souhaitée
end)
