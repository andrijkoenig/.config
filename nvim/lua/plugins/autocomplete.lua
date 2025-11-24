return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '1.*',
    opts = {
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = 'enter' },
        completion = {
            ghost_text = { enabled = true },
            menu = { draw = { columns = { { "label", "label_description", gap = 1 }, { "kind" }, { "source_name" } } } } ,
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            }
        },
        signature = {
            enabled = true,
        },
    }
}
