local null_ls = require("null-ls")
local sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.stylua.with({
        extra_args = { "--config-path", vim.fn.expand("~/.config/stylua.toml") },
    }),
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.pylint,
}
null_ls.config({ diagnostics_format = "#{m} (#{s})", sources = sources })

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    local opts = { noremap = true, silent = true }
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gtd", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<Leader>lc", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", opts)
    buf_set_keymap("n", "<Leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<Leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "<Leader>ll", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    buf_set_keymap("n", "<Leader>lq", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)
    buf_set_keymap("n", "<Leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    buf_set_keymap(
        "n",
        "<Leader>ls",
        "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>",
        opts
    )

    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_option("formatexpr", "v:lua.vim.lsp.formatexpr()")
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

local on_attach_disabled_formatting = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    on_attach(client, bufnr)
end

local nvim_lsp = require("lspconfig")
local setup_lsp = function(lsp, on_attach)
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
    })
end

local servers = { "clangd", "null-ls" }
local servers_disabled_formatting = { "pylsp" }
for _, lsp in ipairs(servers) do
    setup_lsp(lsp, on_attach)
end
for _, lsp in ipairs(servers_disabled_formatting) do
    setup_lsp(lsp, on_attach_disabled_formatting)
end

require("sekme").setup({})