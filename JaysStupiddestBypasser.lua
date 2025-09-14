-- Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: @UnofficialJay3
-- Please note that this bypasser just MAY not work. Recommend saying stuff you want to say and THAN saying your juicy swear word!
-- May be patched, may not be, but who cares? Just swear in your mind!

-- Load JaysStupiddestBypasser
loadstring(game:HttpGet("No url yet."))()

-- Here is the bypassing method functions I Used

-- RTLConverter function
local function RTLConverter(message, rtl)
	rtl = rtl or "؍"
	local result = {}

	-- get UTF-8 codepoints
	for _, codepoint in utf8.codes(message) do
		local char = utf8.char(codepoint)
		table.insert(result, 1, rtl .. char) -- insert at front = reverse
	end

	result = table.concat(result)
	print("Passed string: " .. message)
	print("RTL Converted: " .. result)
	return result
end

-- How to use:
-- RTLConverter("I can say fuck now!!!") -- Automatically prints it in console.

-- Good RTL characters to use for the RTL converter: ؍ ا و
-- Very confusing combinding LTR characters to RTL characters. 😕