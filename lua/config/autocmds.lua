-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- from <https://www.reddit.com/r/neovim/comments/1jpbc7s/disable_virtual_text_if_there_is_diagnostic_in/>
vim.api.nvim_create_autocmd({ "CursorMoved", "DiagnosticChanged" }, {
  group = vim.api.nvim_create_augroup("diagnostic_virt_text_hide", {}),
  callback = function(ev)
    local lnum, _ = unpack(vim.api.nvim_win_get_cursor(0))
    lnum = lnum - 1 -- need 0-based index

    local hidden_lnum = vim.b[ev.buf].diagnostic_hidden_lnum
    if hidden_lnum and hidden_lnum ~= lnum then
      vim.b[ev.buf].diagnostic_hidden_lnum = nil
      -- display all the decorations if the current line changed
      vim.diagnostic.show(nil, ev.buf)
    end

    for _, namespace in pairs(vim.diagnostic.get_namespaces()) do
      local ns_id = namespace.user_data.virt_text_ns
      if ns_id then
        local extmarks = vim.api.nvim_buf_get_extmarks(ev.buf, ns_id, { lnum, 0 }, { lnum, -1 }, {})
        for _, extmark in pairs(extmarks) do
          local id = extmark[1]
          vim.api.nvim_buf_del_extmark(ev.buf, ns_id, id)
        end

        if extmarks and not vim.b[ev.buf].diagnostic_hidden_lnum then
          vim.b[ev.buf].diagnostic_hidden_lnum = lnum
        end
      end
    end
  end,
})
