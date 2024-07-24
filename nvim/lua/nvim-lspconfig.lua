vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    -- call twice to jump to help window
    bufmap('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>')

    -- Jump to the definition
    bufmap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>')

    -- Jump to declaration
    bufmap('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>')

    -- Lists all the references 
    bufmap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>')

    -- Displays a function's signature information
    bufmap('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = "single" }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { border = "single" }
)

vim.diagnostic.config({float = {border= "single" }})
