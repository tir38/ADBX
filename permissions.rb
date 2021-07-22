require "open3"

def list_all_permissions(package)
  base_shell = %Q[adb shell dumpsys package #{package}]
  grep = %Q[ | GREP_COLOR='01;92' egrep --color=always 'granted=true|$' | GREP_COLOR='01;91' egrep -i --color=always 'granted=false|$']
  stdout, _ = Open3.capture2(base_shell + grep)
  puts stdout
end