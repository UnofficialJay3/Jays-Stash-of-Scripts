-- This is a test. DO NOT EXPECT ANYTHING... Uhhh. Cool?

local module = {}

function module.Print(stroing)
    print(stroing)
end

function module.getplayer()
    print(`Your playuh: {game.Players.LocalPlayer.Name}`)
    return game.Players.LocalPlayer
end

return module