local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local GameId = game.GameId

local Games = {
    { name = "Phantom Forces", gameid = 113491250, link = "https://raw.githubusercontent.com/Axal-Dev/Axal-Dev/main/Axal-Beta"},
}

function Fetch(URL)
    return game:HttpGet(tostring(URL))
end


for _, Supported in Games do
    if Supported.gameid == GameId then
        Library:Notify(`Axal-Dev has detected you being in {Supported.name}.`, 5)

        loadstring(Fetch(Supported.link))()
        return "loaded regular"
    end
end

Library:Notify("Your game is not supported !")
