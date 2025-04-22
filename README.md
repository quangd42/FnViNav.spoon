# FnViNav Spoon

A Hammerspoon Spoon that enables Vi-style navigation using the Fn key. When holding the Fn key:
- `h`, `j`, `k`, `l` work as arrow keys
- `a`, `s`, `d` work as modifiers (alt, shift, cmd)

Examples:
  - `Fn + h` → left arrow
  - `Fn + a + h` → alt + left (= next beginning of word)
  - `Fn + d + l` → cmd + right (= end of line)
  - `Fn + a + s + l` → alt + shift + right (= select to next end of word)

## Dependencies

- [Hammerspoon](https://github.com/Hammerspoon/hammerspoon/releases/tag/1.0.0) >= v1.0.0

## Installation

### Method 1: Download Spoon (Recommended)

1. Download [FnViNav.spoon](https://github.com/quangd42/FnViNav.spoon/releases/latest/download/FnViNav.spoon)
2. Double-click the downloaded file to install
3. Add to your Hammerspoon config (`~/.hammerspoon/init.lua`):
```lua
hs.loadSpoon("FnViNav"):start()
```

Or with SpoonInstall:
```lua
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:andUse("FnViNav", { start = true })
```

### Method 2: Manual Installation

1. Clone the repository:
```bash
git clone https://github.com/quangd42/FnViNav.spoon.git ~/.hammerspoon/Spoons/FnViNav.spoon
```

2. Add to your Hammerspoon config (`~/.hammerspoon/init.lua`):
```lua
hs.loadSpoon("FnViNav"):start()
```

## License

MIT License - https://opensource.org/licenses/MIT

## Contributions

Issues and pull requests are welcome.

## Credits

This code is an extension of @asmagill's [viKeys](https://github.com/asmagill/hammerspoon-config/blob/master/utils/_keys/viKeys.lua).

## Why Hammerspoon and not Karabiner?

I used to use Karabiner to two simple mappings:
- Capslock -> Escape on tap, Control on hold
- Fn + HJKL -> Arrows

However, it takes around 300-400MB of RAM on my 8GB RAM Macbook Air. Hammerspoon is much more lightweight for my specific needs, and Lua is a nice and simple scripting language.

This Spoon together with [ControlEscape.spoon](https://github.com/jasonrudolph/ControlEscape.spoon) achieves what I need for ~1/8 the RAM.

