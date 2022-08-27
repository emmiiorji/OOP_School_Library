def display_home_choices
  choices = [
    "List all books", "List all people", "Create a person", "Create a book",
    "Create a rental", "List all rentals for a given person id", "Exit"
  ]
  puts "\n\nPlease choose an action by entering the option number."
  choices.each_with_index { |choice, index| puts "#{index + 1} - #{choice}" }
  print "Choice: "
end