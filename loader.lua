if game.PlaceId == 1417427737 then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/iamz4ri/script/main/games/ms.lua"))()
else
	game.Players.LocalPlayer:Kick("Error loading.\n\nNo supported game found.\n\nPlease join a supported game.")
end
