-- check if being executed on nixos
local fd_os_release = io.open("/etc/os-release", "r")
if fd_os_release == nil then
  -- not on linux, so not nixos
  return {}
end
local s_os_release = fd_os_release:read("*a")
fd_os_release:close()
s_os_release = s_os_release:lower()
if not s_os_release:match("nixos") then
  return {}
end

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- don't use nil
      nil_ls = false,
      nixd = {
        mason = false, -- mason on nixos considered "harmful"
        -- or so they say...
      },
    },
  },
}
