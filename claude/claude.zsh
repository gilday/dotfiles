# Claude Code supervisor sleep-prevention toggle.
# Holds `caffeinate -is` against the Claude Code supervisor pid, so the
# mac stays awake while background sessions run but the display still
# sleeps normally. Useful for unattended overnight `/loop` runs.

cc-wake-on() {
  local roster=$HOME/.claude/daemon/roster.json
  if [[ ! -f $roster ]]; then
    print -u2 "cc-wake-on: no Claude Code supervisor (roster missing)"
    return 1
  fi
  local pid
  pid=$(jq -r '.supervisorPid // empty' "$roster")
  if [[ -z $pid ]] || ! kill -0 "$pid" 2>/dev/null; then
    print -u2 "cc-wake-on: supervisor pid '${pid:-?}' not running"
    return 1
  fi
  if pgrep -f "caffeinate -is -w $pid" >/dev/null; then
    print "cc-wake-on: already caffeinating supervisor pid $pid"
    return 0
  fi
  nohup caffeinate -is -w "$pid" >/dev/null 2>&1 &
  disown
  print "cc-wake-on: caffeinating supervisor pid $pid (auto-releases when it exits)"
}

cc-wake-off() {
  if pkill -f 'caffeinate -is -w ' 2>/dev/null; then
    print "cc-wake-off: released"
  else
    print "cc-wake-off: no caffeinate-on-supervisor process found"
  fi
}

cc-wake-status() {
  local procs
  procs=$(pgrep -lf 'caffeinate -is -w ' || true)
  if [[ -n $procs ]]; then
    print "$procs"
    pmset -g assertions | grep -E 'PreventUserIdleSystemSleep|PreventSystemSleep' | head
  else
    print "cc-wake-status: not active"
  fi
}
