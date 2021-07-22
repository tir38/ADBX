require "damerau-levenshtein"

def find_unknown_command(known_commands, unknown_command)
  # find levenshtein best guess
  lev_best_guess = perform_levenshtein(unknown_command, known_commands)

  # levenshtein won't find partial matches
  # (e.g. if we are looking for 'max', we expect 'max_bright' to be a possible guess)
  # so look for partials in command list
  possible_partials = find_partials(unknown_command, known_commands)

  # don't add levenshtein guess if already in partial list
  if !possible_partials.include?(lev_best_guess) && lev_best_guess != ""
    possible_partials.append(lev_best_guess)
  end

  possible_partials
end

def find_partials(unknown_command, known_commands)
  possible = []
  known_commands.each do |command|
    if command.include? unknown_command
      possible.append(command)
    end
  end
  possible
end

def perform_levenshtein(unknown_command, known_commands)
  dl = DamerauLevenshtein

  best_guess = ""
  best_guess_distance = -1

  known_commands.each do |command|
    guess_distance = dl.distance(command, unknown_command)
    if best_guess.empty? || guess_distance <= best_guess_distance
      best_guess = command
      best_guess_distance = guess_distance
      next
    end
  end

  # Return empty string if best_guess_distance is really high
  # How helpful would it be to provide a suggested match to 'ashpoijeiphasdrtqadjh' ?
  if best_guess_distance < 10
    best_guess
  else
    ""
  end
end

