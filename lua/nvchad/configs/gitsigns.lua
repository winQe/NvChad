dofile(vim.g.base46_cache .. "git")

local options = {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "󰍵" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "│" },
  },

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local map = vim.keymap.set

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Next Git Hunk" })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Previous Git Hunk" })

    -- Actions
    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Git Hunk" })
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Git Hunk" })
    map("n", "<leader>hS", gs.stage_buffer, { desc = "Git Stage Buffer" })
    map("n", "<leader>ha", gs.stage_hunk, { desc = "Git Stage Hunk" })
    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Git Undo Stage Hunk" })
    map("n", "<leader>hR", gs.reset_buffer, { desc = "Git Reset Buffer" })
    map("n", "<leader>hp", gs.preview_hunk, { desc = "Git Preview Hunk" })
    map("n", "<leader>hb", function()
      gs.blame_line { full = true }
    end, { desc = "Blame Line" })
    map("n", "<leader>tB", gs.toggle_current_line_blame, { desc = "Git Toggle Current Line Blame" })
    map("n", "<leader>hd", gs.diffthis, { desc = "Git Diff This" })
    map("n", "<leader>hD", function()
      gs.diffthis "~"
    end, { desc = "Git Diff This ~" })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git Select Hunk" })
  end,
}

return options
