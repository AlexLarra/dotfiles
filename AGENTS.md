# Dotfiles

Repo de configuraciones personales para Linux.

## Estructura

```
.
code/
  alacritty/      # Terminal emulator config
  git/            # .gitconfig, .gitignore
  nvim/           # Neovim config (lazy.nvim, lua/config/ + lua/plugins/)
  opencode/       # opencode.json + AGENTS.md symlinked to ~/.config/opencode/
  rspec/          # RSpec config
  tmux/           # .tmux.conf + .tmux_work.zsh (workspace setup script)
script/
  install.sh      # Symlinks everything to $HOME
sh/
  sh_aliases      # Sourced by ~/.zshrc
  sh_functions    # Custom zsh functions (gpr, jira, iacommit, tg, etc.)
zsh/
  .zshrc          # Sources ~/.sh_aliases, ~/.sh_functions, ~/.dotfiles.env
  themes/pure     # zsh prompt theme
```

## Reglas

- Idioma: español conciso, sin cortesías. Tono directo.
- Código y comandos técnicos en inglés.
- Shell: todo es **zsh**. `install.sh` usa `#!/bin/zsh`; `sh_functions` y `sh_aliases` se sourcean desde `.zshrc`.
- `nvim`: respetar estructura `code/nvim/lua/config/` y `code/nvim/lua/plugins/`.
- `tmux`: mantener `.tmux_work.zsh` como script de workspace; `.tmux.conf` usa prefix `C-a`.
- No commitear secrets. `~/.dotfiles.env` (con `GITHUB_TOKEN`, `OPENAI_API_KEY`, `TELEGRAM_BOT_KEY`) está fuera del repo.
- No modificar rutas de symlink en `install.sh` sin coordinar con la estructura de directorios.
- No modificar configuraciones ajenas al scope de la tarea.
- No crear documentación (`README`, `AGENTS.md`, etc.) salvo que se solicite explícitamente.

## Build / Test

- No hay build system global. Los tests son manuales o scripts individuales.
- Validar cambios en dotfiles con `make` si existe un `Makefile` en el subdirectorio relevante.

## Convenciones

- Commits: mensajes en inglés, imperativo, breves.
- `sh_functions`: funciones custom con helpers (OpenAI, Telegram, Chrome DevTools, ngrok, etc.).
