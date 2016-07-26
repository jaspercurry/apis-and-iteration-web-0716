def welcome
  # puts out a welcome message here!
  "Hi, welcome to Star Wars film explorer!"
end

def get_character_from_user
  puts "please enter a character"
  user = gets.strip
  user.downcase
  # use gets to capture the user's input. This method should return that input, downcased. 
end

