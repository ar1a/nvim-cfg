return {
  {
    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach *.rs",
    opts = {}, -- required, even if empty
  },
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              -- extraArgs = {
              --   "--target-dir=target/analyzer"
              -- }
              targetDir = true,
            },
            imports = {
              prefix = "crate", -- don't use relative paths for imports (super::) vs (crate::)
            },
          },
        },
      },
    },
  },
}
