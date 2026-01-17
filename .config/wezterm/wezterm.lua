local wezterm = require "wezterm"
local act = wezterm.action

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.integrated_title_buttons = { 'Close' }
-- config.use_fancy_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
    font = wezterm.font { family = 'Gruvbox Dark Hard' },
    font_size = 9.5,
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

-- https://github.com/wezterm/wezterm/discussions/4945
-- Custom title and icon based on: https://github.com/protiumx/.dotfiles/blob/854d4b159a0a0512dc24cbc840af467ac84085f8/stow/wezterm/.config/wezterm/wezterm.lua#L291-L319
local process_icons = {
    ["bash"] = wezterm.nerdfonts.cod_terminal_bash,
    ["bun"] = wezterm.nerdfonts.dev_bun,
    ["cargo"] = wezterm.nerdfonts.dev_rust,
    ["docker"] = wezterm.nerdfonts.linux_docker,
    ["docker-compose"] = wezterm.nerdfonts.linux_docker,
    ["gh"] = wezterm.nerdfonts.dev_github_badge,
    ["git"] = wezterm.nerdfonts.fa_git,
    ["go"] = wezterm.nerdfonts.seti_go,
    ["kubectl"] = wezterm.nerdfonts.md_kubernetes,
    ["lua"] = wezterm.nerdfonts.seti_lua,
    ["make"] = wezterm.nerdfonts.seti_makefile,
    ["node"] = wezterm.nerdfonts.fa_node_js,
    ["nvim"] = wezterm.nerdfonts.linux_neovim,
    ["psql"] = "󱤢",
    ["ruby"] = wezterm.nerdfonts.cod_ruby,
    ["stern"] = wezterm.nerdfonts.md_kubernetes,
    ["sudo"] = wezterm.nerdfonts.fa_hashtag,
}

-- Return the Tab's current working directory
local function get_cwd(tab)
    -- Note, returns URL Object: https://wezfurlong.org/wezterm/config/lua/pane/get_current_working_dir.html
    local pane = tab.active_pane
    if not pane or not pane.current_working_dir then
        return "?"
    end
    local cwd = pane.current_working_dir.file_path
    return cwd == "/" and cwd or cwd:sub(1, -2)
end

-- Remove all path components and return only the last value
local function remove_abs_path(path) return path:gsub("(.*[/\\])(.*)", "%2") end

-- Return the pretty path of the tab's current working directory
local function get_display_cwd(tab)
    local current_dir = get_cwd(tab)
    return current_dir:gsub(os.getenv("HOME"), "~")
end

-- Return the concise name and icon of the running process for display
local function get_process(tab)
    if not tab.active_pane or tab.active_pane.foreground_process_name == "" then
        return {
            name = "[?]",
            icon = wezterm.nerdfonts.cod_server_process
        }
    end

    local process_name = remove_abs_path(tab.active_pane.foreground_process_name)
    -- Strip version numbers (e.g., python3.14 -> python, node24 -> node)
    local base_name = process_name:gsub("%d[%.%d]*$", "")

    return {
        name = base_name or process_name or "[?]",
        icon = process_icons[base_name] or process_icons[process_name] or wezterm.nerdfonts.cod_server_process
    }
end

-- Pretty format the tab title
local function format_title(tab)
    local cwd = get_display_cwd(tab)
    local process = get_process(tab)

    return string.format(" %s %s | %s ", process.icon, process.name, cwd)
end

-- Determine if a tab has unseen output since last visited
local function has_unseen_output(tab)
    if not tab.is_active then
        for _, pane in ipairs(tab.panes) do
            if pane.has_unseen_output then return true end
        end
    end
    return false
end

-- Returns manually set title (from `tab:set_title()` or `wezterm cli set-tab-title`) or creates a new one
local function get_tab_title(tab)
    local title = tab.tab_title
    if title and #title > 0 then return title end
    return format_title(tab)
end

function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
      return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local title = get_tab_title(tab)

    if tab.is_active then
        return {
            { Attribute = { Intensity = "Bold" } },
            { Background = { Color = "Black" } },
            { Foreground = { Color = "#EFBF04" } },
            { Text = title },
        }
    end
    if has_unseen_output(tab) then
        return {
            { Foreground = { Color = "White" } },
            -- { Background = { Color = "Anthracite" } },
            { Text = title },
        }
    end
    return title
end)

return config
