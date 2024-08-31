local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local GameId = game.GameId

local Games = {
    { name = "Phantom Forces", gameid = 113491250, link = "https://raw.githubusercontent.com/Axal-Dev/Axal-Dev/main/Game/Phantom%20Forces.lua"},
    { name = "test place", gameid = 299659045, link = "https://raw.githubusercontent.com/Axal-Dev/Axal-Dev/main/Game/Phantom%20Forces.lua"},
}

function Fetch(URL)
    return game:HttpGet(tostring(URL))
end


for _, Supported in Games do
    if Supported.gameid == GameId then
        Library:Notify(`Axal-Dev a détécter que tu est in {Supported.name}.`, 5)

        loadstring(Fetch(Supported.link))()
        return "loaded regular"
    end
end

Library:Notify("Ton jeux n'est pas supporter ! Loading InfiniteYield.....")
loadstring(Fetch("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
