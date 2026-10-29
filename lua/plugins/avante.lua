-- avante has a compiled part that needs `make`, and vim.pack has no build option.
-- Register this before vim.pack.add() so it also runs on the first install.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local spec, kind = ev.data.spec, ev.data.kind
    if spec.name == "avante.nvim" and (kind == "install" or kind == "update") then
      vim.system({ "make" }, { cwd = ev.data.path }, function(res)
        if res.code ~= 0 then
          vim.schedule(function()
            vim.notify("avante.nvim build failed:\n" .. (res.stderr or ""), vim.log.levels.ERROR)
          end)
        end
      end)
    end
  end,
})

vim.pack.add({
  { src = "https://github.com/yetone/avante.nvim", version = "main" },

  -- Required
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",

  -- Optional
  "https://github.com/nvim-mini/mini.pick",   -- needed for selector = "mini_pick"
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/HakonHarnes/img-clip.nvim",
})

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()
require("mini.pick").setup()

require("render-markdown").setup({
  file_types = { "markdown", "Avante" },
})

require("avante").setup({
  provider = "gnai",
  providers = {
    gnai = {
      __inherited_from = "openai",
      endpoint = "https://gnai.intel.com/api/providers/openai/v1",
      api_key_name = "GNAI_TOKEN",
      model = "gpt-5.4-mini",
      timeout = 60000,
      extra_request_body = {
        max_completion_tokens = 16384,
      },
    },
    gnai_claude = {
      __inherited_from = "claude",
      endpoint = "https://gnai.intel.com/api/providers/anthropic",
      api_key_name = "GNAI_TOKEN",
      model = "claude-haiku-4-5",
      timeout = 60000,
      extra_request_body = {
        temperature = 0,
        max_tokens = 16384,
      },
    },
  },

  input = { provider = "native" },

  -- Only settings that differ from avante's defaults
  behaviour = {
    auto_suggestions = false,
    minimize_diff = true,
    enable_token_counting = false,
    auto_add_current_file = false,
    confirmation_ui_style = "inline_buttons",
  },

  windows = {
    position = "right",
    wrap = true,
    width = 30,
  },

  selector = { provider = "mini_pick" },
})
