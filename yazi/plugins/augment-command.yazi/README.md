# augment-command.yazi

A [Yazi](https://github.com/sxyazi/yazi)
plugin that enhances Yazi's default commands.
This plugin is inspired by the
[Yazi tips page](https://yazi-rs.github.io/docs/tips),
the [bypass.yazi](https://github.com/Rolv-Apneseth/bypass.yazi) plugin
and the [fast-enter.yazi](https://github.com/ourongxing/fast-enter.yazi) plugin.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [What about the commands are augmented?](#what-about-the-commands-are-augmented)
- [Augmented commands](#augmented-commands)
- [New commands](#new-commands)
- [Usage](#usage)
- [Windows support?](#windows-support)
- [Licence](#licence)

## Requirements

- [Yazi](https://github.com/sxyazi/yazi) v0.3.0+
- [7z or 7zz command](https://github.com/p7zip-project/p7zip)
- [ls](https://www.gnu.org/software/coreutils/manual/html_node/ls-invocation.html#ls-invocation)
- Linux or macOS

## Installation

```sh
# Add the plugin
ya pack -a hankertrix/augment-command

# Install plugin
ya pack -i

# Update plugin
ya pack -u
```

## Configuration

| Configuration                       | Values                                             | Default   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ----------------------------------- | -------------------------------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `prompt`                            | `true` or `false`                                  | `false`   | Create a prompt to choose between hovered and selected items when both exist. If this option is disabled, selected items will only be operated on when the hovered item is selected, otherwise the hovered item will be the default item that is operated on.                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `default_item_group_for_prompt`     | `hovered`, `selected` or `none`                    | `hovered` | The default item group to operate on when the prompt is submitted without any value. This only takes effect if `prompt` is set to `true`, otherwise this option doesn't do anything. `hovered` means the hovered item is operated on, `selected` means the selected items are operated on, and `none` just cancels the operation.                                                                                                                                                                                                                                                                                                                                                                                                    |
| `smart_enter`                       | `true` or `false`                                  | `true`    | Use one command to open files or enter a directory. With this option set, the `enter` and `open` commands will both call the `enter` command when a directory is hovered and call the `open` command when a regular file is hovered.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| `smart_paste`                       | `true` or `false`                                  | `false`   | Paste items into a directory without entering it. The behaviour is exactly the same as the [smart-paste tip on Yazi's documentation](https://yazi-rs.github.io/docs/tips#smart-paste). Setting this option to `false` will use the default `paste` behaviour. You can also enable smart pasting by passing the `--smart` flag to the paste command.                                                                                                                                                                                                                                                                                                                                                                                  |
| `enter_archives`                    | `true` or `false`                                  | `true`    | Automatically extract and enter archive files. This option requires the [7z or 7zz command](https://github.com/p7zip-project/p7zip) to be present.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `extract_behaviour`                 | `overwrite`, `rename`, `rename_existing` or `skip` | `rename`  | Determines how [7z](https://github.com/p7zip-project/p7zip) deals with existing files when extracting an archive. `overwrite` results in [7z](https://github.com/p7zip-project/p7zip) overwriting existing files when extracting. `rename` results in [7z](https://github.com/p7zip-project/p7zip) renaming the new files with the same name as existing files. `rename_existing` results in [7z](https://github.com/p7zip-project/p7zip) renaming the existing files with the same name as the new files. `skip` results in [7z](https://github.com/p7zip-project/p7zip) skipping files that have the same name as existing files. See the [7z documentation](https://documentation.help/7-Zip/overwrite.htm) for more information. |
| `extract_retries`                   | An integer, like `1`, `3`, `10`, etc.              | `3`       | This option determines how many times the plugin will retry opening an encrypted or password-protected archive when a wrong password is given. This value plus 1 is the total number of times the plugin will try opening an encrypted or password-protected archive.                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `must_have_hovered_item`            | `true` or `false`                                  | `true`    | This option stops the plugin from executing any commands when there is no hovered item.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `skip_single_subdirectory_on_enter` | `true` or `false`                                  | `true`    | Skip directories when there is only one subdirectory and no other files when entering directories. This behaviour can be turned off by passing the `--no-skip` flag to the `enter` or `open` commands.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `skip_single_subdirectory_on_leave` | `true` or `false`                                  | `true`    | Skip directories when there is only one subdirectory and no other files when leaving directories. This behaviour can be turned off by passing the `--no-skip` flag to the `leave` command.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `ignore_hidden_items`               | `true` or `false`                                  | `false`   | Ignore hidden items when determining whether a directory only has one subdirectory and no other items. Setting this option to `false` will mean that hidden items in a directory will stop the plugin from skipping the single subdirectory.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `wraparound_file_navigation`        | `true` or `false`                                  | `false`   | Wrap around from the bottom to the top or from the top to the bottom when using the `arrow` or `parent-arrow` command to navigate.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |

To configure this plugin, add the code below to your `~/.config/yazi/init.lua` file:

```lua
-- ~/.config/yazi/init.lua

-- Using the default configuration
require("augment-command"):setup({
    prompt = false,
    default_item_group_for_prompt = "hovered",
    smart_enter = true,
    smart_paste = false,
    enter_archives = true,
    extract_behaviour = "rename",
    extract_retries = 3,
    must_have_hovered_item = true,
    skip_single_subdirectory_on_enter = true,
    skip_single_subdirectory_on_leave = true,
    ignore_hidden_items = false,
    wraparound_file_navigation = false,
})
```

Note that you don't have to do this if you want to use the default configuration.
You also can leave out configuration options that you would like to be left as default,
for example:

```lua
-- ~/.config/yazi/init.lua

-- Custom configuration
require("augment-command"):setup({
    prompt = true,
    default_item_group_for_prompt = "none",
    extract_behaviour = "overwrite",
    extract_retries = 5,
    ignore_hidden_items = true,
    wraparound_file_navigation = true,
})
```

## What about the commands are augmented?

All commands that can operate on multiple files and directories,
like `open`, `rename`, `remove` and `shell`,
as well as the new commands `editor` and `pager`,
now determine an item group to operate on.
By default, the command will operate on the hovered item,
unless the hovered item is also selected,
then it will operate on the selected items.

- When `must_have_hovered_item` is set to `true`,
  having no hovered item means the plugin will cancel the operation.
- When `must_have_hovered_item` is set to `false` and
  there are selected items, the selected items will be operated on.
- With `prompt` is set to `true`,
  the plugin will always prompt you to
  choose an item group when there are
  both selected items and a hovered item.

## Augmented commands

### Open (`open`)

- When `smart_enter` is set to `true`,
  calls the `enter` command when the hovered item is a directory.
- `--no-skip` flag, which only applies
  when `smart_enter` is used as it is passed to the `enter` command.
  More details about this flag can be found at the documentation
  for the [enter command](#enter-enter).
- Automatically extracts and enters archive files,
  with support for skipping directories
  that contain only one subdirectory in the extracted archive.
  This can be disabled by setting `enter_archives` to `false` in the configuration.
  This feature requires
  [the 7z or 7zz command](https://github.com/p7zip-project/p7zip)
  to be present as well as the
  [ls](https://www.gnu.org/software/coreutils/manual/html_node/ls-invocation.html#ls-invocation) command.

### Enter (`enter`)

- When `smart_enter` is set to `true`,
  calls the `open` command when the hovered item is a file.
- Automatically skips directories that
  contain only one subdirectory when entering directories.
  This can be turned off by setting
  `skip_single_subdirectory_on_enter` to `false` in the configuration.
  This feature requires the
  [ls](https://www.gnu.org/software/coreutils/manual/html_node/ls-invocation.html#ls-invocation) command.
- `--no-skip` flag. It stops the plugin from skipping directories
  that contain only one subdirectory when entering directories,
  even when `skip_single_subdirectory_on_enter` is set to `true`.
  This allows you to set a key to navigate into directories
  without skipping the directories that contain only one subdirectory.

### Leave (`leave`)

- Automatically skips directories that
  contain only one subdirectory when leaving directories.
  This can be turned off by
  setting `skip_single_subdirectory_on_leave` to `false`
  in the configuration.
  This feature requires the
  [ls](https://www.gnu.org/software/coreutils/manual/html_node/ls-invocation.html#ls-invocation) command.
- `--no-skip` flag. It stops the plugin
  from skipping directories that contain only one subdirectory,
  even when `skip_single_subdirectory_on_leave` is set to `true`.
  This allows you to set a key to navigate out of directories
  without skipping the directories that contain only one subdirectory.

### Rename (`rename`)

- The `rename` command is augmented as stated in
  [this section above](#what-about-the-commands-are-augmented).

### Remove (`remove`)

- The `remove` command is augmented as stated in
  [this section above](#what-about-the-commands-are-augmented).

### Paste (`paste`)

- When `smart_paste` is set to `true`,
  the `paste` command will paste items
  into a hovered directory without entering it.
  If the hovered item is not a directory,
  the command pastes in the current directory instead.
  Otherwise, when `smart_paste` is set to `false`,
  the `paste` command will behave like the default
  `paste` command.
- `--smart` flag to enable pasting in a hovered directory
  without entering the directory.
  This flag will cause the `paste` command to paste items
  into a hovered directory even when `smart_paste` is set to `false`.
  This allows you to set a key to use smart paste
  instead of using smart paste for every paste command.

### Shell (`shell`)

- This command runs the shell command given with the augment stated in
  [this section above](#what-about-the-commands-are-augmented). You should
  only use this command if you need the plugin to determine a suitable
  item group for the command to operate on. Otherwise, you should just
  use the default shell command provided by Yazi.
- To use this command, the syntax is exactly the same as the default
  shell command provided by Yazi. You just provide the command you want and
  provide any Yazi shell variable, which is documented
  [here](https://yazi-rs.github.io/docs/configuration/keymap/#manager.shell).
  The plugin will automatically replace the shell variable you give
  with the file paths for the item group before executing the command.
- You will also need to escape the quotes when giving the shell command
  if you use the same quotes to quote the given arguments to the plugin.
  For example, if you pass the arguments to the plugin with double quotes,
  i.e. `--args="shell"`, you will have to escape the double quotes with a
  backslash character, like shown below:
  ```toml
  # ~/.config/yazi/keymap.toml
  [[manager.prepend_keymap]]
  on = [ "o" ]
  run = 'plugin augment-command --args="shell \"$EDITOR $@\" --block --confirm"'
  desc = "Open the editor"
  ```
- Alternatively, you can use the triple single quote `'''` delimiter
  for the run string and avoid the escaping the shell command altogether,
  like the two examples below:

  ```toml
  # ~/.config/yazi/keymap.toml
  [[manager.prepend_keymap]]
  on = [ "o" ]
  run = '''plugin augment-command --args='shell "$EDITOR $@" --block --confirm''''
  desc = "Open the editor"

  [[manager.prepend_keymap]]
  on = [ "i" ]
  run = '''plugin augment-command --args="shell '$PAGER $@' --block --confirm"'''
  desc = "Open the pager"
  ```

### Arrow (`arrow`)

- When `wraparound_file_navigation` is set to `true`,
  the arrow command will wrap around from the bottom to the top or
  from the top to the bottom when navigating.
  Otherwise, it'll behave like the default `arrow` command.

## New commands

### Parent-arrow (`parent-arrow`)

- This command behaves like the `arrow` command,
  but in the parent directory.
  It allows you to navigate the parent directory
  without leaving the current directory.
- When `wraparound_file_navigation` is set to `true`,
  this command will also wrap around from the bottom to the top or
  from top to the bottom when navigating in the parent directory.
  For this feature to work, you will need the
  [ls](https://www.gnu.org/software/coreutils/manual/html_node/ls-invocation.html#ls-invocation) command.
  You will also need to have your directories
  sorted first for this feature to work,
  i.e. in your `~/.config/yazi/yazi.toml` file:

```toml
# ~/.config/yazi/yazi.toml
[manager]
sort_dir_first = true
```

- You can also replicate this using this series of commands below,
  but it doesn't work as well,
  and doesn't support wraparound navigation:

```toml
# ~/.config/yazi/keymap.toml

# Use K to move up in the parent directory
[[manager.prepend_keymap]]
on   = [ "K" ]
run  = [ "leave", "arrow -1", "enter" ]
desc = "Move up in the parent directory"


# Use J to move down in the parent directory
[[manager.prepend_keymap]]
on   = [ "J" ]
run  = [ "leave", "arrow 1", "enter" ]
desc = "Move down in the parent directory"
```

### Editor (`editor`)

- The `editor` command opens the default editor set by the `$EDITOR` environment variable.
- The command is also augmented as stated in
  [this section above](#what-about-the-commands-are-augmented).

### Pager (`pager`)

- The `pager` command opens the default pager set by the `$PAGER` environment variable.
- The command is also augmented as stated in
  [this section above](#what-about-the-commands-are-augmented).

## Usage

Add the commands that you would like to use to your `keymap.toml` file,
located at `~/.config/yazi/keymap.toml`,
in this format:

```toml
# ~/.config/yazi/keymap.toml
[[manager.prepend_keymap]]
on = [ "key" ]
run = "plugin augment-command --args='command arguments --flags --options=42'"
desc = "Description"
```

For example, to use the augmented `enter` command:

```toml
# ~/.config/yazi/keymap.toml
[[manager.prepend_keymap]]
on = [ "l" ]
run = "plugin augment-command --args='enter'"
desc = "Enter a directory and skip directories with only a single subdirectory"
```

All the default arguments, flags and options provided by Yazi are also supported, for example:

```toml
# ~/.config/yazi/keymap.toml
[[manager.prepend_keymap]]
on   = [ "k" ]
run  = "plugin augment-command --args='arrow -1'"
desc = "Move cursor up"

[[manager.prepend_keymap]]
on = [ "r" ]
run = "plugin augment-command --args='rename --cursor=before_ext'"
desc = "Rename a file or directory"

[[manager.prepend_keymap]]
on = [ "D" ]
run = "plugin augment-command --args='remove --permanently'"
desc = "Permanently delete the files"
```

For the default descriptions of the commands,
you can refer to
[Yazi's `keymap.toml` file](https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/keymap.toml).

Essentially, all you need to do to use this plugin
is to wrap a Yazi command in single quotes,
like `'enter'`,
then add `plugin augment-command --args=`
in front of it, which results in
`plugin augment-command --args='enter'`.

### Full configuration example

For a full configuration example,
you can take a look at
[my `keymap.toml` file](https://github.com/hankertrix/Dotfiles/blob/master/.config/yazi/keymap.toml).

## Windows support?

Pull requests for Windows support are welcome!

## Licence

This plugin is licenced under the GNU GPL v3 licence.
You can view the full licence in the `LICENSE` file.
