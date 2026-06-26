local M = {}

function M.open_last_migration()
  local latest = vim.fn.system("ls -t db/migrate/*.rb | head -n 1")
  latest = latest:gsub("\n", "")
  if latest ~= "" then
    vim.cmd("tabedit " .. vim.fn.fnameescape(latest))
  else
    print("No migration files found.")
  end
end

function M.open_changed_files()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")
  if branch == "master" or branch == "main" then
    print("Already on master/main branch.")
    return
  end

  local root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n+$", "")
  if root == "" then
    print("Not inside a git repository.")
    return
  end

  local merge_base = vim.fn.system("cd " .. vim.fn.shellescape(root) .. " && git merge-base HEAD master 2>/dev/null || git merge-base HEAD main 2>/dev/null"):gsub("\n+$", "")
  if merge_base == "" then
    print("Could not find merge base with master/main.")
    return
  end

  local changed = vim.fn.systemlist("cd " .. vim.fn.shellescape(root) .. " && git diff --name-only " .. vim.fn.shellescape(merge_base))

  local cwd = vim.fn.getcwd()
  local filtered = {}
  for _, f in ipairs(changed) do
    if f ~= "" then
      local abs = root .. "/" .. f
      local rel = vim.fn.fnamemodify(abs, ":.")
      table.insert(filtered, rel)
    end
  end

  if #filtered == 0 then
    print("No changes compared to master/main.")
    return
  end

  local fzf = require("fzf-lua")
  fzf.fzf_exec(filtered, {
    previewer = "builtin",
    actions = {
      ["default"] = fzf.actions.file_tabedit,
    },
  })
end

function M.tmux_opencode()
  local full_path = vim.fn.expand("%:p")
  local root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n+$", "")
  local rel_path
  if root ~= "" then
    rel_path = full_path:gsub("^" .. vim.pesc(root) .. "/", "")
  else
    rel_path = full_path
  end
  local ln = vim.fn.line(".")
  local cmd = string.format('opencode --prompt "En el contexto de la línea %d del archivo %s "', ln, rel_path)
  local shell_cmd = "tmux split-window -h \\; send-keys " .. vim.fn.shellescape(cmd) .. " \\; send-keys Left"
  vim.fn.system(shell_cmd)
end

function M.tmux_rspec(spec)
  vim.g.last_rspec_spec = spec
  local pane_id = vim.fn.system("tmux split-window -h -P -F '#{pane_id}'"):gsub("\n", "")
  if pane_id == "" then return end
  local rspec_args = spec == "" and "" or " " .. vim.fn.shellescape(spec)
  local cmd = "cd " .. vim.fn.shellescape(vim.fn.getcwd()) .. " && bundle exec rspec --format progress --require ~/workspace/dotfiles/code/rspec/quickfix_formatter.rb --format QuickfixFormatter --out quickfix.out" .. rspec_args
  vim.fn.system("tmux send-keys -t " .. pane_id .. " " .. vim.fn.shellescape(cmd) .. " C-m")
end

function M.get_visual_selection()
  local line_start = vim.fn.getpos("'<")[2]
  local col_start = vim.fn.getpos("'<")[3]
  local line_end = vim.fn.getpos("'>")[2]
  local col_end = vim.fn.getpos("'>")[3]
  local lines = vim.fn.getline(line_start, line_end)
  if #lines == 0 then return "" end
  local end_col = col_end - (vim.o.selection == "inclusive" and 1 or 2)
  lines[#lines] = lines[#lines]:sub(1, end_col)
  lines[1] = lines[1]:sub(col_start)
  return table.concat(lines, "\n")
end

function M.opencode_mode(mode, text)
  local full_path = vim.fn.expand("%:p")
  local root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n+$", "")
  local rel_path
  if root ~= "" then
    rel_path = full_path:gsub("^" .. vim.pesc(root) .. "/", "")
  else
    rel_path = full_path
  end
  local ln = vim.fn.line(".")
  local prompt
  if text == "" then
    if mode == "explain" then
      prompt = string.format("Explain the method at line %d in %s. Describe inputs, outputs, and side effects.", ln, rel_path)
    elseif mode == "refactor" then
      prompt = string.format("Refactor the code at line %d in %s to be more idiomatic and efficient. Show the improved code and explain changes.", ln, rel_path)
    elseif mode == "test" then
      prompt = string.format("Generate a comprehensive RSpec test for the code at line %d in %s. Include edge cases.", ln, rel_path)
    else
      prompt = mode
    end
  else
    local escaped = text:gsub('"', '\\"')
    if mode == "explain" then
      prompt = string.format("Explain the following Ruby code from %s at line %d:\n\n%s", rel_path, ln, escaped)
    elseif mode == "refactor" then
      prompt = string.format("Refactor the following code from %s at line %d to be more idiomatic and efficient. Show the improved code and explain changes:\n\n%s", rel_path, ln, escaped)
    elseif mode == "test" then
      prompt = string.format("Generate a comprehensive RSpec test for the following code from %s at line %d. Include edge cases:\n\n%s", rel_path, ln, escaped)
    else
      prompt = string.format("%s (from %s at line %d):\n\n%s", mode, rel_path, ln, escaped)
    end
  end
  local cmd = string.format('opencode --prompt "%s"', prompt)
  vim.fn.system("tmux split-window -h \\; send-keys " .. vim.fn.shellescape(cmd) .. " \\; send-keys Left")
end

function M.tmux_find_rails_pane()
  local win = vim.fn.system('tmux display-message -p "#I"'):gsub("\n+$", "")
  local panes = vim.fn.system('tmux list-panes -t work:' .. win .. ' -F "#{pane_index} #{pane_current_command}"')
  for line in panes:gmatch("[^\r\n]+") do
    local parts = vim.split(line, " ")
    if #parts >= 2 then
      local idx = parts[1]
      local cmd = parts[2]
      if cmd:match("puma") or cmd:match("rails") or cmd:match("spring") or cmd:match("ruby") then
        return "work:" .. win .. "." .. idx
      end
    end
  end
  return ""
end

function M.tmux_goto_last_error()
  local pane = M.tmux_find_rails_pane()
  if pane == "" then
    print("No Rails pane found")
    return
  end
  local logs = vim.fn.system("tmux capture-pane -p -t " .. vim.fn.shellescape(pane) .. " | tail -n 100")
  local lines = vim.split(logs, "\n")
  local error_idx = -1
  for i = #lines, 1, -1 do
    if lines[i]:match("Error") or lines[i]:match("Exception") or lines[i]:match("Completed 500") or lines[i]:match("NameError") or lines[i]:match("RuntimeError") or lines[i]:match("NoMethodError") or lines[i]:match("ArgumentError") or lines[i]:match("StandardError") then
      error_idx = i
      break
    end
  end
  if error_idx == -1 then
    print("No error found in logs")
    return
  end
  local last_match = {}
  for i = error_idx, #lines do
    local m = lines[i]:match("([a-zA-Z0-9_%%-/]+%%.rb):(%d+)")
    if m then
      local file, line = lines[i]:match("([a-zA-Z0-9_%%-/]+%%.rb):(%d+)")
      last_match = {file, line}
      break
    end
  end
  if #last_match == 0 then
    print("No error pattern found in logs")
    return
  end
  local root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n+$", "")
  if root == "" then
    print("Not inside a git repository")
    return
  end
  local full = root .. "/" .. last_match[1]
  if vim.fn.filereadable(full) == 1 then
    vim.cmd("tabedit +" .. last_match[2] .. " " .. vim.fn.fnameescape(full))
  else
    print("File not found: " .. full)
  end
end

function M.open_rails_test()
  local current = vim.fn.expand("%:p")
  local test = current:gsub("app/(.+)%.rb", "spec/%1_spec.rb")
  if test == current then
    test = current:gsub("lib/(.+)%.rb", "spec/%1_spec.rb")
  end
  if test == current then
    test = current:gsub("spec/(.+)_spec%.rb", "app/%1.rb")
    if test == current then
      test = current:gsub("spec/(.+)_spec%.rb", "lib/%1.rb")
    end
  end
  if vim.fn.filereadable(test) == 1 then
    vim.cmd("tabedit " .. vim.fn.fnameescape(test))
  else
    local root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n+$", "")
    if root ~= "" then
      local fzf = require("fzf-lua")
      local specs = vim.fn.systemlist("find " .. vim.fn.shellescape(root .. "/spec") .. " -type f")
      fzf.fzf_exec(specs, {
        actions = {
          ["default"] = fzf.actions.file_tabedit,
        },
      })
    else
      print("Could not find corresponding test file")
    end
  end
end

return M
