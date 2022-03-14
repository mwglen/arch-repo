# Set to True to load settings configured via autoconfig.yml
config.load_autoconfig(False)
c.qt.highdpi = True
c.auto_save.session = False
c.aliases = {
    'q': 'quit',
    'w': 'session-save',
    'wq': 'quit --save'
}
config.set("colors.webpage.darkmode.enabled", True)
c.completion.show = "auto"
c.downloads.location.directory = '~/Downloads'
c.tabs.show = 'never'
c.statusbar.show = 'never'
c.scrolling.bar = 'never'
c.scrolling.smooth = True

# Fonts
c.fonts.default_family = '"NotoSans Nerd Font"'
c.fonts.default_size = '11pt'
c.fonts.completion.entry = '11pt "NotoSans Nerd Font"'
c.fonts.debug_console = '11pt "NotoSans Nerd Font"'
c.fonts.prompts = 'default_size "NotoSans Nerd Font"'
c.fonts.statusbar = '11pt "NotoSans Nerd Font"'

# Use dmenu
#config.bind('o', 'spawn --userscript dmenu-open')
#config.bind('O', 'spawn --userscript dmenu-open --tab')

config.bind('pw', 'spawn --userscript qute-bitwarden')
config.bind('pu', 'spawn --userscript qute-bitwarden -e')
config.bind('pd', 'spawn --userscript qute-bitwarden -w')

# Colors
c.colors.completion.fg = ['#9cc4ff', 'white', 'white']
c.colors.completion.odd.bg = '#1c1f24'
c.colors.completion.even.bg = '#232429'
c.colors.completion.category.fg = '#e1acff'
c.colors.completion.category.bg = 'qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #000000, stop:1 #232429)'
c.colors.completion.category.border.top = '#3f4147'
c.colors.completion.category.border.bottom = '#3f4147'
c.colors.completion.item.selected.fg = '#282c34'
c.colors.completion.item.selected.bg = '#ecbe7b'
c.colors.completion.item.selected.match.fg = '#c678dd'
c.colors.completion.match.fg = '#c678dd'
c.colors.completion.scrollbar.fg = 'black'
c.colors.downloads.bar.bg = '#282c34'
c.colors.downloads.error.bg = '#ff6c6b'
c.colors.hints.fg = '#282c34'
c.colors.hints.match.fg = '#98be65'
c.colors.messages.info.bg = '#282c34'
c.colors.statusbar.normal.bg = '#282c34'
c.colors.statusbar.insert.fg = 'white'
c.colors.statusbar.insert.bg = '#497920'
c.colors.statusbar.passthrough.bg = '#34426f'
c.colors.statusbar.command.bg = '#282c34'
c.colors.statusbar.url.warn.fg = 'yellow'
c.colors.tabs.bar.bg = '#1c1f34'
c.colors.tabs.odd.bg = '#282c34'
c.colors.tabs.even.bg = '#282c34'
c.colors.tabs.selected.odd.bg = '#282c34'
c.colors.tabs.selected.even.bg = '#282c34'
c.colors.tabs.pinned.odd.bg = 'seagreen'
c.colors.tabs.pinned.even.bg = 'darkseagreen'
c.colors.tabs.pinned.selected.odd.bg = '#282c34'
c.colors.tabs.pinned.selected.even.bg = '#282c34'

# Search Engines
c.url.searchengines = {
    'DEFAULT': 'https://www.google.com/search?q={}',
    'arch':    'https://wiki.archlinux.org/?search={}',
    'wiki':    'https://en.wikipedia.org/wiki/{}',
    'yt':      'https://www.youtube.com/results?search_query={}'
}

# Normal Mode Keybindings
config.bind(';m', 'hint links spawn baka-mplayer {hint-url}')
config.bind('M', 'spawn baka-mplayer {url}')
config.bind('xb', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')
config.bind('xx', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')
