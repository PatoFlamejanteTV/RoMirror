local RoMirror = require(game.ServerScriptService.RoMirror)

-- Add URLs to the mirrors
RoMirror.__addToMirrors("main.lua", "https://raw.githubusercontent.com/PatoFlamejanteTV/RobloxResouces/refs/heads/main/testing.lua")
RoMirror.__addToMirrors("main.lua", "https://invalidURL.com/testacc/erfger/a.lua")

-- Fetch content from the mirrors
local function fetchContent(tag)
    local mirrors = RoMirror.mirrors[tag]
    if not mirrors then
        return nil, "No mirrors found for tag: " .. tag
    end

    for _, URL in ipairs(mirrors) do
        local success, content = pcall(function()
            return game:GetService("HttpService"):GetAsync(URL)
        end)
        if success and not RoMirror.isNull(content) then
            return content
        else
            warn("Failed to fetch content from URL: ", URL)
        end
    end

    return nil, "Failed to fetch content from all mirrors for tag: " .. tag
end

local content, err = fetchContent("main.lua")
if content then
	print("Content fetched from mirrors: ", content)
else
    warn("Failed to fetch content: ", err)
end

--[[-- Remove URLs from the mirrors
RoMirror.__removeToMirrors("main.lua", "https://pastebin.com/fdhgkjfdhl")
RoMirror.__removeToMirrors("main.lua", "https://github.com/testacc/erfger/a.lua")

-- Verify removal
local contentAfterRemoval, errAfterRemoval = fetchContent("main.lua")
if contentAfterRemoval then
    print("Content fetched from mirrors after removal: ", contentAfterRemoval)
else
    warn("Failed to fetch content after removal: ", errAfterRemoval)
end

]]
