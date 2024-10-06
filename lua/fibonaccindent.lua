local M = {}

function M.greet()
    print("Hello world!")
end

function M.setup(opts)
    opts = opts or {}
    vim.api.nvim_create_user_command("greetworld", M.greet, {})


end

return M
