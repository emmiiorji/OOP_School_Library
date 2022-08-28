require_relative './app'

def display_home_choices
  choices = [
    'List all books', 'List all people', 'Create a person', 'Create a book',
    'Create a rental', 'List all rentals for a given person id', 'Exit'
  ]
  puts "\n\nPlease choose an action by entering the option number."
  choices.each_with_index { |choice, index| puts "#{index + 1} - #{choice}" }
  print 'Choice: '
end

def main
  puts "\nWelcome to School Library App!\n"
  display_home_choices

  app = App.new
  app.create_classrooms('Class1') # Create some classroom

  trials = 0
  loop do
    choice = gets.chomp
    case choice
    when '1'
      app.list_all_books
      display_home_choices
    when '2'
      app.list_all_people
      display_home_choices
    when '3'
      app.create_person
      display_home_choices
    when '4'
      app.create_book
      display_home_choices
    when '5'
      app.create_rental
      display_home_choices
    when '6'
      app.rental_by_id
      display_home_choices
    when '7'
      puts "\nThank you for using this app. Bye!"
      return
    else
      trials += 1
      puts "You've entered an invalid character#{trials > 2 ? ' three times. Bye' : ''}!"
      print 'Choice: '
    end
    break if trials > 2
  end
end

main
