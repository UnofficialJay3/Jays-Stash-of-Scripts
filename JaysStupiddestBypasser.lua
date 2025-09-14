-- Scripted by @IlIl_ILovAltAccsHAHA - Unofficial Jay | Git: @UnofficialJay3
-- Please note that this bypasser just MAY not work. Recommend saying stuff you want to say and THAN saying your juicy swear word!
-- May be patched, may not be, but who cares? Just swear in your mind!

-- Also note that THIS IS A INSPARATION FROM ANOTHER SCRIPT! I give 99% credit to https://rscripts.net/script/cookie-bypass-op-chat-bypass-Opr3 for the RTL method.
-- Thank you @mertylmaz from rscripts for the script (I made it from scratch and the methods from scratch, got the idea not stealing.) and @my_ci from scriptblox for the actual script? Then the other person took it to rscripts?

-- Load JaysStupiddestBypasser
loadstring(game:HttpGet("https://raw.githubusercontent.com/UnofficialJay3/Jays-Stash-of-Scripts/refs/heads/main/JaysStupiddestBypasserObfuscated.lua"))()

-- Here is the bypassing method functions I Used. Yeah I am reeally generous.

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



-- LAL converter
-- Look-ALikes table:
local lookAlikes = { -- I manually listed the characters that can work for the chat... Maybe I should gatekeep this?
	a = {"а", "ạ", "Α", "А", "Ａ", "ɑ"},
	b = {"Β", "В", "Ｂ"},
	c = {"с", "С", "Ｃ"},
	d = {"Ｄ"},
	e = {"е", "ẹ", "Ε", "Е", "Ｅ"},
	f = {"Ｆ"},
	g = {"ɡ", "Ｇ"},
	h = {"Η", "Н", "Ｈ"},
	i = {"Ⅰ", "Ⅰ", "丨", "∣"},
	l = {"丨", "∣"},
	j = {"Ｊ"},
	k = {"κ", "Κ", "К", "Ｋ"},
	m = {"Μ", "М", "Ｍ"},
	n = {"Ν", "Ｎ"},
	o = {"о", "ο", "Ο", "О", "〇", "Ｏ"},
	p = {"р", "Ρ", "Р", "Ｐ"},
	q = {"Ｑ"},
	r = {"Ｒ"},
	s = {"Ｓ"},
	t = {"τ", "Τ", "Т", "Ｔ"},
	u = {"υ", "∪", "Ｕ", "υ"},
	v = {"ν", "∨", "Ｖ"},
	w = {"Ｗ", "ω"},
	x = {"х", "×", "Ｘ"},
	y = {"у", "Υ", "Ｙ"},
	z = {"Ｚ"}
}

-- Look-Alike Letter Converter
local function LALConverter(message)
	local result = {}
	for char in message:gmatch(".") do
		local lower = char:lower()
		local options = lookAlikes[lower]
		if options then
			local choice = options[math.random(1, #options)]
			table.insert(result, choice)
		else
			table.insert(result, char)
		end
	end
	return table.concat(result)
end