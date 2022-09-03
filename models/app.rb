require 'time'

require_relative './student'
require_relative './teacher'
require_relative './classroom'
require_relative './rental'
require_relative './book'
require_relative './storage'

class App
  attr_accessor :classrooms

  def initialize
    @persons = []
    @books = []
    @rentals = []
    @classrooms = []
    create_classrooms('Pogramming') # Create some classroom
  end

  def quit
    storage = Storage.new
    storage.save_data(@persons, './save_instances/persons')
    storage.save_data(@books, './save_instances/books')
    storage.save_data(@rentals, './save_instances/rentals')
    storage.save_data(@classrooms, './save_instances/classrooms')
    exit
  end

  def read_input(label_string)
    print "#{label_string}: "
    gets.chomp
  end

  def create_classrooms(label = nil)
    label ||= read_input('Enter classroom label')
    @classrooms.push(Classroom.new(label)) if @classrooms.filter do |classroom|
                                                classroom.label == label
                                              end.empty?
  end

  def create_person
    create_choice = read_input('Do you want to create a student(1) or a teacher (2)? [Enter the number]')
    case create_choice
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'You have made an invalid choice. Exiting...'
      nil
    end
  end

  def create_student
    begin
      age = Float(read_input('Age'))
    rescue ArgumentError
      puts 'Invalid value for age. Exiting...'
      return
    end

    name = read_input('Name')

    permission = read_input('Has parent permission? [Y/N]').downcase == 'y'
    @persons.push(Student.new(age, @classrooms[0], name, parent_permission: permission))
    puts 'Student created successfully'
  end

  def create_teacher
    begin
      age = Float(read_input('Age'))
    rescue ArgumentError
      puts 'Invalid value for age. Creating teacher was unsuccessful...'
      return
    end

    name = read_input('Name')

    specialization = read_input('Specialization')
    @persons.push(Teacher.new(age, specialization, name))
    puts 'Teacher created successfully'
  end

  def create_book
    title = read_input('Title')

    author = read_input('Author')
    @books.push(Book.new(title, author))
    puts 'Book created successfully'
  end

  def list_all_people
    puts "\nNo one found" if @persons.empty?
    @persons.each { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
  end

  def list_all_books
    puts "\nNo book found" if @books.empty?
    @books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def confirm_item_index(index, group)
    begin
      choice_index = Integer(index)
      unless (0...group.length).member?(choice_index)
        puts "No book with index #{choice_index}.\nCreating rental unsuccessful..."
        return -1
      end
    rescue ArgumentError
      puts "Invalid value for book index.\nCreating rental unsuccessful..."
      return -1
    end
    choice_index
  end

  def verify_date(date)
    t_date = Time.strptime(date, '%Y/%m/%d')
    return date if t_date.strftime('%Y/%m/%d')
  rescue ArgumentError
    puts "Invalid value for date\nCreating rental was unsuccessful..."
    -1
  end

  def create_rental
    puts "\n\nSelect a book from the following list by number"
    @books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}" }
    choice_book_index = confirm_item_index(read_input('Choice book'), @books)
    return if choice_book_index == -1

    puts "\n\nSelect a person from the following list by number (not id)"
    @persons.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    choice_person_index = confirm_item_index(read_input('Choice person'), @persons)
    return if choice_person_index == -1

    rent_date = verify_date(read_input('Date [YYYY/MM/DD]'))
    @rentals.push(Rental.new(@persons[choice_person_index], @books[choice_book_index], rent_date))
    puts 'Rental created succssfully'
  end

  def rental_by_id
    begin
      person_id = Integer(read_input('ID of person'))
    rescue ArgumentError
      puts 'ID must be a valid integer'
      return
    end

    selected_person = @persons.filter { |person| person.id == person_id }
    if selected_person.empty?
      puts "No one with ID #{person_id}."
      return
    end
    puts "Rentals by #{selected_person[0].name}:"
    rentals_by_person = @rentals.filter do |rental|
      rental.person.id == person_id
    end
    rentals_by_person.each do |rental|
      puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
    end
  end
end
