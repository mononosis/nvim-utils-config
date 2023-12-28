-- Function to split a string by a delimiter
local function split(str, delimiter)
  local result = {}
  for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

-- Function to add directories to the runtimepath
local function add_paths_to_rtp(paths)
  for _, path in ipairs(paths) do
    vim.o.runtimepath = vim.o.runtimepath .. ',' .. path
  end
end


local M = {}
function M.set_packages_paths(dir)
  if dir then
    package.path = package.path .. ';' .. dir .. '/?/init.lua' .. ';' .. dir .. '/?.lua' .. ';' .. dir .. '/?/?/.lua' .. ';'
  end
end

function M.GetPathWithoutLastSubpath(path)
  -- Remove any trailing slashes
  path = path:gsub("/+$", "")

  -- Find the last occurrence of "/"
  local endIdx = path:match(".*/()")

  -- If a slash is found, return the substring up to (but not including) the last slash.
  -- Otherwise, return nil or an empty string to indicate that there's no preceding path.
  if endIdx then
    return path:sub(1, endIdx - 1)
  else
    return nil -- or return "" if you prefer to return an empty string
  end
end

function M.GetLastSubpath(path)
  -- Remove any trailing slashes
  path = path:gsub("/+$", "")
  -- Find the last occurrence of "/"
  local startIdx = path:match("^.*/()")

  -- If a slash is found, return the substring after it. Otherwise, return the whole path.
  if startIdx then
    return path:sub(startIdx)
  else
    return path
  end
end

return M
