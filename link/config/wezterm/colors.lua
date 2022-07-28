local colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = '#3B4252',

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = '#434C5E',
      -- The color of the text for the tab
      fg_color = '#E5E9F0',

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Normal',

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = 'None',

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = true,

      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab.  The default is false.
      strikethrough = false,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = '#2E3440',
      fg_color = '#D8DEE9',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = '#81A1C1',
      fg_color = '#ECEFF4',
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = '#434C5E',
      fg_color = '#A3BE8C',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },
  selection_bg = "rgba(50% 50% 50% 50%)",
  selection_fg = '#d8dee9',

  ansi = {
    '#3b4252',
    '#bf616a',
    '#a3be8c',
    '#ebcb8b',
    '#81a1c1',
    '#b48ead',
    '#88c0d0',
    '#e5e9f0',
  },
  background = '#434C5E',
  brights = {
    '#4c566a',
    '#bf616a',
    '#a3be8c',
    '#ebcb8b',
    '#81a1c1',
    '#b48ead',
    '#8fbcbb',
    '#eceff4',
  },
  cursor_bg = '#eceff4',
  cursor_border = '#eceff4',
  cursor_fg = '#282828',
  foreground = '#d8dee9',
}

return colors
