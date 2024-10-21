local RoMirror = {}
RoMirror.__index = RoMirror

-- Initialize mirrors table
RoMirror.mirrors = {}

-- checks if URL is up, valid, exists, etc.
function RoMirror.URLExists(URL: string)
	local success, response = pcall(function()
		return game:GetService("HttpService"):GetAsync(URL)
	end)
	return success and response ~= nil
end

-- self-explanatory
function RoMirror.isNull(content: string)
	return (
		content == nil
		or content == ""
		or content == " "
		or content == "null"
	)
end

function RoMirror.__addToMirrors(tag: string, URL: string)
    if not RoMirror.mirrors[tag] then
        RoMirror.mirrors[tag] = {}
    end
    table.insert(RoMirror.mirrors[tag], URL)
end

function RoMirror.__removeToMirrors(tag: string, URL: string)
    if RoMirror.mirrors[tag] then
        for i, mirrorURL in ipairs(RoMirror.mirrors[tag]) do
            if mirrorURL == URL then
                table.remove(RoMirror.mirrors[tag], i)
                break
            end
        end
    end
end

function RoMirror.getFromMirror(tag: string)
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
        end
    end

    return nil, "Failed to fetch content from mirrors for tag: " .. tag
end

return RoMirror

