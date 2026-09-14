require "recipecode"
-- require 'timedactionshelper'   -- B42-ONLY file; does not exist in B41.
-- LuaManager$GlobalObject.require warns and areturns null rather than throwing
-- (offsets 80-93), so this never broke anything -- but it printed two
-- `require("timedactionshelper") failed` WARNs into every single B41 boot log,
-- which is exactly the noise that makes a real warning easy to miss.
-- Nothing in either file references the helper (word-boundary grep, 2026-09-14).

Moonshine = Moonshine or {}








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