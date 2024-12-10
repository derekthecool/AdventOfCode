HOME = (os.getenv("HOME") or os.getenv("USERPROFILE"))
package.path = string.format("%s;%s/AdventOfCode/2024/lua/?.lua", package.path, HOME)

-- Import all functions from luafun to the global table
for k, v in pairs(require("fun")) do
	_G[k] = v
end

