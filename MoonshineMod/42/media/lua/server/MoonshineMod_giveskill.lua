Moonshine = Moonshine or {}
Recipe = Recipe or {}
Recipe.OnGiveXP = Recipe.OnGiveXP or {}








function Recipe.OnGiveXP.FillCoal_1(recipe, ingredients, result, player)
    if player:getPerkLevel(Perks.Woodwork) <= 3 then
        player:getXp():AddXP(Perks.Woodwork, 3);
    else
        player:getXp():AddXP(Perks.Woodwork, 2);
    end
end




function Recipe.OnGiveXP.MakeMash_1(recipe, ingredients, result, player)
    if player:getPerkLevel(Perks.Cooking) <= 3 then
        player:getXp():AddXP(Perks.Cooking, 3);
    else
        player:getXp():AddXP(Perks.Cooking, 2);
    end
end