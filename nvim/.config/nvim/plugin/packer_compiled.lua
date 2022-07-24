-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/jchill/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/jchill/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/jchill/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/jchill/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/jchill/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  delimitMate = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/delimitMate",
    url = "https://github.com/Raimondi/delimitMate"
  },
  indentLine = {
    config = { "\27LJ\2\n5\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\bâ”‚\20indentLine_char\6g\bvim\0" },
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/indentLine",
    url = "https://github.com/Yggdroot/indentLine"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nÙ\1\0\0\5\0\r\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0004\4\0\0=\4\a\0035\4\b\0=\4\t\0034\4\0\0=\4\n\0034\4\0\0=\4\v\3=\3\f\2B\0\2\1K\0\1\0\rsections\14lualine_z\14lualine_y\14lualine_x\1\4\0\0\rfiletype\rprogress\rlocation\14lualine_a\1\0\0\foptions\1\0\0\1\0\1\18icons_enabled\1\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18Hello, world!\nprintŸ\2\1\0\a\0\21\0\"6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0005\3\b\0005\4\6\0005\5\4\0003\6\3\0=\6\5\5=\5\a\4=\4\t\3=\3\v\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\f\0'\2\r\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\f\0'\2\14\0B\0\2\0016\0\15\0009\0\16\0009\0\17\0'\2\18\0'\3\19\0'\4\20\0B\0\4\1K\0\1\0\30:Telescope find_files<CR>\n<C-p>\6n\bset\vkeymap\bvim\17file_browser\bfzf\19load_extension\rdefaults\1\0\0\rmappings\1\0\0\6i\1\0\0\n<C-h>\1\0\0\0\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\n´\1\0\0\3\0\t\0\0176\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\4\0'\1\6\0=\1\5\0006\0\0\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0\27colorscheme tokyonight\bcmd\tdark\15background\6o\27tokyonight_transparent#tokyonight_transparent_sidebar\6g\bvim\0" },
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/jchill/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18Hello, world!\nprintŸ\2\1\0\a\0\21\0\"6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0005\3\b\0005\4\6\0005\5\4\0003\6\3\0=\6\5\5=\5\a\4=\4\t\3=\3\v\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\f\0'\2\r\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\f\0'\2\14\0B\0\2\0016\0\15\0009\0\16\0009\0\17\0'\2\18\0'\3\19\0'\4\20\0B\0\4\1K\0\1\0\30:Telescope find_files<CR>\n<C-p>\6n\bset\vkeymap\bvim\17file_browser\bfzf\19load_extension\rdefaults\1\0\0\rmappings\1\0\0\6i\1\0\0\n<C-h>\1\0\0\0\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nÙ\1\0\0\5\0\r\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0004\4\0\0=\4\a\0035\4\b\0=\4\t\0034\4\0\0=\4\n\0034\4\0\0=\4\v\3=\3\f\2B\0\2\1K\0\1\0\rsections\14lualine_z\14lualine_y\14lualine_x\1\4\0\0\rfiletype\rprogress\rlocation\14lualine_a\1\0\0\foptions\1\0\0\1\0\1\18icons_enabled\1\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n´\1\0\0\3\0\t\0\0176\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\4\0'\1\6\0=\1\5\0006\0\0\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0\27colorscheme tokyonight\bcmd\tdark\15background\6o\27tokyonight_transparent#tokyonight_transparent_sidebar\6g\bvim\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: indentLine
time([[Config for indentLine]], true)
try_loadstring("\27LJ\2\n5\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\bâ”‚\20indentLine_char\6g\bvim\0", "config", "indentLine")
time([[Config for indentLine]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
