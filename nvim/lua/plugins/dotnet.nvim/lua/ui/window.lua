local M = {}

---@class ListItem
---@field value string
---@field visual string
---@field isMarked boolean

local function update_lines(buf, items)
    local lines = {}
    for i, item in ipairs(items) do
        local mark = item.isMarked and "[x]" or "[ ]"
        table.insert(lines, i .. "\t" .. mark .. "\t" .. item.visual)
    end
    vim.api.nvim_set_option_value("modifiable", true, { buf = buf }) -- Temporarily make buffer modifiable to update lines
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_set_option_value("modifiable", false, { buf = buf }) -- Temporarily make buffer modifiable to update lines
end

---@param items ListItem[]
---@param title string
---@param on_done fun(marked_items: ListItem[])
M.create_multiselect = function(items, title, on_done)
    title = title or "Title"

    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.4)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local buf = vim.api.nvim_create_buf(false, true)
    update_lines(buf, items)
    local footer_text = "Enter: toggle mark | Ctrl+Enter: finish | q: quit"
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        style = "minimal",
        width = width,
        height = height,
        row = row,
        col = col,
        title = { { title, "FloatBorder" } },
        title_pos = 'center',
        footer = { { footer_text, "FloatBorder" } },
        footer_pos = 'right',
        border = 'rounded',
    })

    -- Toggle item mark
    local function toggle_mark()
        local line = vim.api.nvim_win_get_cursor(win)[1]
        local item = items[line]
        if item then
            item.isMarked = not item.isMarked
            update_lines(buf, items)
        end
    end

    -- Close window and return marked items via callback
    local function close_and_return()
        vim.api.nvim_win_close(win, true)
        local marked = {}
        for _, item in ipairs(items) do
            if item.isMarked then table.insert(marked, item) end
        end
        if on_done then
            on_done(marked)
        end
    end

    -- Keymaps
    vim.keymap.set('n', '<CR>', toggle_mark, { buffer = buf, noremap = true })
    vim.keymap.set('n', '<C-CR>', close_and_return, { buffer = buf, noremap = true })
    vim.keymap.set('n', 'q', function() vim.api.nvim_win_close(win, true) end, { buffer = buf, noremap = true })
end

return M
