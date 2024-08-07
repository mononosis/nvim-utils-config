local M = {}

function M.this_file_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  print(str)
  return str:match("(.*/)")
end

-- Function to split a string by a delimiter
function M.split(str, delimiter)
  local result = {}
  for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

-- Function to add directories to the runtimepath
function M.add_paths_to_rtp(paths)
  for _, path in ipairs(paths) do
    vim.o.runtimepath = path .. ',' .. vim.o.runtimepath
  end
end

function M.set_packages_paths(dir)
  if dir then
    package.path = dir .. '/?/init.lua' .. ';' ..
        dir .. '/plugins/?/init.lua' .. ';' ..
        dir .. '/?.lua' .. ';' ..
        dir .. '/lua/?/init.lua' .. ';' ..
        dir .. '/lua/?.lua' .. ';' ..
        dir .. '/plugin/?.lua' .. ';' ..
        dir .. '/plugin/init.lua' .. ';' ..
        --'/lua/?/init.lua' .. ';' ..
        package.path .. ';'
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

_G.user_utils_config = M

