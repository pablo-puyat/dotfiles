# Keyboard Shortcuts Reference

## AeroSpace

| shortcut    | context         | action                          |
|-------------|-----------------|---------------------------------|
| alt enter   | main            | iTerm2                          |
| alt tab     | main            | switch workspace                |
| alt d       | main            | switch to workspace d           |
| alt o       | main            | switch to workspace o           |
| alt h       | main            | focus left                      |
| alt j       | main            | focus down                      |
| alt k       | main            | focus up                        |
| alt l       | main            | focus right                     |
| alt shift h | main            | move left                       |
| alt shift j | main            | move down                       |
| alt shift k | main            | move up                         |
| alt shift l | main            | move right                      |
| alt shift - | main            | resize smart -50                |
| alt shift = | main            | resize smart +50                |
| alt shift d | main            | move node to worksapce dev      |
| alt shift o | main            | move node to workspace other    |
| alt shift ; | main            | switch to service mode          |
| esc         | service         | reload config                   |
| r           | service         | flatten-workspace-tree          |
| f           | service         | layout floating tiling          |
| backspace   | service         | close all but current window    |
| enter       | service         | fullscreen                      |
| alt shift l | service         | join with right                 |
| alt shift k | service         | join with up                    |
| alt shift j | service         | join with down                  |
| alt shift h | service         | join with left                  |

## Neovim - Navigation

| shortcut    | context          | action                          |
|-------------|------------------|---------------------------------|
| gd          | code            | go to definition                 |
| gr          | code            | find references                  |
| gi          | code            | go to implementation             |
| ctrl-o      | navigation      | jump back                        |
| ctrl-i      | navigation      | jump forward                     |
| <leader>ff  | telescope       | find files                       |
| <leader>fg  | telescope       | live grep (search in files)      |
| <leader>fb  | telescope       | browse buffers                   |
| <leader>fh  | telescope       | file history                     |
| <leader>lr  | laravel         | find related laravel files       |

## Neovim - Custom Commands
| Command         | Action                                  |
|----------------|------------------------------------------|
| :Related       | Show related files for current file      |
| :JumpHistory   | Show navigation history                  |
| :ClassHierarchy| Show inheritance tree                    |
| :TraitList     | Show traits used                         |

## Terminal (ZSH)
| Shortcut    | Action                                  |
|-------------|-----------------------------------------|
| Ctrl-R      | Fuzzy search command history            |
| Ctrl-T      | Fuzzy search files                      |
| Alt-C       | Fuzzy search directories and cd         |
| Ctrl-A      | Move to beginning of line               |
| Ctrl-E      | Move to end of line                     |
| Alt-B       | Move backward one word                  |
| Alt-F       | Move forward one word                   |

## Git Aliases
| Alias       | Command         | Action                           |
|-------------|-----------------|----------------------------------|
| gst         | git status      | Show working tree status         |
| ga          | git add         | Stage files                      |
| gc          | git commit      | Commit staged changes            |
| gp          | git push        | Push commits to remote           |
| gl          | git pull        | Pull changes from remote         |
| gd          | git diff        | Show changes in working tree     |
| gco         | git checkout    | Switch branches/restore files    |

## NPM Aliases
| Alias       | Command          | Action                          |
|-------------|------------------|---------------------------------|
| npmr        | npm run          | Run npm script                  |
| npmi        | npm install      | Install dependencies            |
| npmid       | npm install -D   | Install dev dependencies        |
| dev         | npm run dev      | Run development server          |

## Custom Functions
| Command     | Action                                   |
|-------------|------------------------------------------|
| mkcd        | Make directory and cd into it            |
| gacp        | Git add, commit, and push in one go      |
| port        | Find process using specified port        |
| killport    | Kill process on specified port           |
| extract     | Extract any archive type                 |
| keys        | Show this shortcut reference             |

## Laravel Navigation
| Command         | Action                                      |
|-----------------|---------------------------------------------|
| <leader>lr      | Find related Laravel files                  |
| :Related        | Show test/controller/factory/migration      |

## Directory Navigation
| Command     | Action                                   |
|-------------|------------------------------------------|
| ..          | Go up one directory                      |
| ...         | Go up two directories                    |
| d           | Show directory stack                     |
| 1-9         | Jump to numbered directory in stack      |
