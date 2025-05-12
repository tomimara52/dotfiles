return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/nvim-cmp'
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function()
          local bufmap = function(mode, lhs, rhs)
            local opts = {buffer = true}
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          -- Displays hover information about the symbol under the cursor
          -- call twice to jump to help window
          bufmap('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover({ border = "single" })<CR>')

          -- Jump to the definition
          bufmap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>')

          -- Jump to declaration
          bufmap('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>')

          -- Lists all the references 
          bufmap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>')

          -- Displays a function's signature information
          bufmap('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help({ border = "single" })<CR>')

          -- Renames all references to the symbol under the cursor
          bufmap('n', '<leader>ln', '<cmd>lua vim.lsp.buf.rename()<CR>')

          -- Selects a code action available at the current cursor position
          bufmap('n', '<leader>lc', '<cmd>lua vim.lsp.buf.code_action()<CR>')

          -- Show diagnostics in a floating window
          bufmap('n', '<leader>ll', '<cmd>lua vim.diagnostic.open_float()<CR>')

          -- Move to the previous diagnostic
          bufmap('n', '<leader>l{', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

          -- Move to the next diagnostic
          bufmap('n', '<leader>l}', '<cmd>lua vim.diagnostic.goto_next()<CR>')
        end
      })

      vim.diagnostic.config({float = {border= "single" }})
    end,
  },

	{
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-vsnip',
			'hrsh7th/vim-vsnip',
		},
		config = function()
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' }, -- For vsnip users.
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

      -- Set up lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require('lspconfig')['clangd'].setup {capabilities = capabilities}
      require('lspconfig')['ts_ls'].setup {capabilities = capabilities}
      require('lspconfig')['eslint'].setup({
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })
      require('lspconfig')['html'].setup {capabilities = capabilities}
      require('lspconfig')['rust_analyzer'].setup {capabilities = capabilities}
      require('lspconfig')['hls'].setup {capabilities = capabilities}
      require('lspconfig')['intelephense'].setup {capabilities = capabilities}
      require('lspconfig')['pyright'].setup {capabilities = capabilities}
      require('lspconfig')['lua_ls'].setup {
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            return
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT'
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
              }
            }
          })
        end,
        settings = {
          Lua = {}
        },
        capabilities = capabilities
      }
    end
  },
  {
    'hrsh7th/vim-vsnip',
    event = "InsertEnter",
    config = function()
      vim.cmd([[
        imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'

        imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
      ]])
    end,
  },
  {
    'rafamadriz/friendly-snippets',
    event = "InsertEnter",
  }
}
