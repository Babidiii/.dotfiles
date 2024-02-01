local utils = {}

---@generic T
---@param value `T`
---@param default T
---@return T
function utils.set_default(value, default)
    if value == nil then
        return default
    end
    return value
end


---#
local utils = {}

---@param plugin_name name of the plugin to load
---@return the loaded plugin
function utils.require(plugin_name) 
  local has_plugin, plugin = pcall(require, plugin_name)
  if not has_plugin then
    error("This plugins requires" + plugin_name)
  end

  return plugin
end

return utils
