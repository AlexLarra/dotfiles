# Plan: Vim-Tmux-Opencode Integration

## 1. Tests en tmux sin bloquear Vim (1-b)
- **Objetivo**: `vim-rspec` ejecuta en panel tmux libre (panel 3 de la ventana actual), Vim no se bloquea.
- **Comportamiento**: El formatter quickfix sigue escribiendo `quickfix.out`. Carga manual con `<leader>q`.
- **Cambio**: Modificar `g:rspec_command` en `.vimrc` para usar `tmux send-keys` en lugar de `!`.
- **Nota**: El panel 3 en `.tmux_work.zsh` está libre (`cd && clear`).

## 2. Opencode con modos de contexto + Visual selection (2-b)
- **Objetivo**: Tres atajos (`<leader>oe`, `<leader>or`, `<leader>ot`) que abren opencode con prompts pre-cargados.
- **Comportamiento**: En modo Normal usa archivo+línea. En modo Visual usa el texto seleccionado como parte del prompt.
- **Cambio**: Crear función `OpencodeMode(mode)` en `.vimrc` con mapeos Normal y Visual.
- **Modos**:
  - `explain`: explica el método/código.
  - `refactor`: refactoriza a Ruby idiomático.
  - `test`: genera test RSpec.

## 3. Saltar de logs tmux a Vim automáticamente (3-a)
- **Objetivo**: `<leader>le` (last error) captura últimas líneas del panel 3 de tmux, parsea último `file.rb:line`, y abre en Vim.
- **Cambio**: Crear función `TmuxGotoLastError()` en `.vimrc`.
- **Detalle**: Usa `tmux capture-pane -p -t work:#I.3` y regex para `*.rb:<line>`.

## 4. Toggle Rails Test (bonus)
- **Objetivo**: `<leader>tt` salta de implementación a test y viceversa usando convenciones Rails.
- **Cambio**: Crear función `OpenRailsTest()` en `.vimrc`.
- **Fallback**: Si no existe, abrir fzf filtrado en `spec/`.
