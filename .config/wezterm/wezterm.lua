local wezterm = require "wezterm"
local act = wezterm.action

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.window_decorations = 'RESIZE'
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
    font = wezterm.font { family = 'Gruvbox Dark Hard' },
    font_size = 10.0,
    active_titlebar_bg = '#333333',
    inactive_titlebar_bg = '#333333',

}

config.colors = {
    tab_bar = {
        inactive_tab_edge = '#575757',
    },
}

-- fix window padding
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = '2cell',
}

config.color_scheme = 'Gruvbox dark, hard (base16)'
config.font = wezterm.font "Fira Code Nerd Font"
config.font_size = 9.5
-- disable ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

wezterm.on("update-status", function(window, pane)
    window:set_right_status(window:active_workspace())
end)

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
    { key = "-", mods = "LEADER", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "=", mods = "LEADER", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "s", mods = "LEADER", action = act.PaneSelect },

    -- tmux-sessionizer replacement
    {
        key = "f",
        mods = "LEADER",
        action = wezterm.action_callback(function(window, pane)
            local home        = wezterm.home_dir
            local search_dirs = { home .. '/dev' }
            local workspaces  = {}

            -- dynamically build fuzzy list
            local find_cmd    = 'find ' .. table.concat(search_dirs, " ") .. ' -type d -mindepth 1 -maxdepth 1'
            for dir in io.popen(find_cmd):lines() do
                table.insert(workspaces, { id = dir, label = dir })
            end

            window:perform_action(
                act.InputSelector {
                    action = wezterm.action_callback(
                        function(inner_window, inner_pane, id, label)
                            if id and label then
                                inner_window:perform_action(
                                    act.SwitchToWorkspace {
                                        name = label,
                                        spawn = {
                                            label = "Workspace: " .. label,
                                            cwd = id,
                                        },
                                    },
                                    inner_pane
                                )
                            end
                        end
                    ),
                    title = 'SwitchToWorkspace',
                    choices = workspaces,
                    fuzzy = true,
                    fuzzy_description = "Fuzzy matching: ",
                },
                pane
            )
        end),
    },
    -- create workspace
    {
        key = "W",
        mods = "LEADER",
        action = act.PromptInputLine {
            description = wezterm.format {
                { Text = "New workspace :" },
            },
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:perform_action(
                        act.SwitchToWorkspace {
                            name = line,
                        },
                        pane
                    )
                end
            end),
        },
    },
    -- select existing workspace
    {
        key = "w",
        mods = "LEADER",
        action = act.ShowLauncherArgs {
            flags = "FUZZY|WORKSPACES",
        },
    },
}

return config
