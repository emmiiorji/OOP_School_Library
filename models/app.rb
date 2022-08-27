require_relative './student'
require_relative './teacher'
require_relative './classroom'
require_relative './rental'

class App
  attr_accessor :classrooms

  def initialize
    @persons = []
    @books = []
    @rentals = []
    @classrooms = []
    create_classrooms('Class1') # Create some classroom
  end

  def create_classrooms(label = nil)
    puts 'Enter classroom label' unless label
    label = gets.chomp unless label
    @classrooms.push(Classroom.new(label)) unless @classrooms.filter {|classroom| classroom.label === label}.length > 0
  end

  def create_person
    print 'Do you want to create a student(1) or a teacher (2)? [Enter the number]: '
    create_choice = gets.chomp
    case create_choice
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'You have made an invalid choice. Exiting...'
      return
    end
  end

  def create_student
    begin
      print 'Age: '
      age = Float(gets.chomp)
    rescue ArgumentError
      puts 'Invalid value for age. Exiting...'
      # Return to the beginning
    end

    print 'Name: '
    name = gets.chomp

    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp.downcase === 'y'
    @persons.push(Student.new(age, @classrooms[0], name, parent_permission: permission))
    'Student created successfully'
  end

  def create_teacher
    begin
      print 'Age: '
      age = Float(gets.chomp)
    rescue ArgumentError
      puts 'Invalid value for age. Creating teacher was unsuccessful...'
      return
      # Return to the beginning
    end

    print 'Name: '
    name = gets.chomp

    print 'Specialization: '
    specialization = gets.chomp.downcase === 'y'
    @persons.push(Teacher.new(age, specialization, name))
    'Teacher created successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp
    @books.push(Book.new(title, author))
    puts 'Book created successfully'
  end

  def list_all_people
    puts "\nNo one found" if @persons.empty?
    @persons.each { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"}
  end

  def list_all_books
    puts "\nNo book found" if @books.empty?
    @books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}"}
  end

  def create_rental
    puts "\n\nSelect a book from the following list by number"
    @books.each_with_index { |book, _index| puts "Title: \"#{book.title}\", Author: #{book.author}" }
    puts 'Choice book: '
    begin
      choice_book_index = Integer(gets.chomp)
      unless (0...@books.length).member?(choice_book_index)
        puts "No book with index #{choice_book_index}.\nCreating rental unsuccessful..."
        return
      end
    rescue ArgumentError
      puts "Invalid value for book index.\nCreating rental unsuccessful..."
      return
      # Return to the beginning
    end

    puts "\n\nSelect a person from the following list by number (not id)"
    @persons.each_with_index { |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    }
    puts 'Choice book: '
    begin
      choice_person_index = Integer(gets.chomp)
      unless (0...@persons.length).member?(choice_person_index)
        puts "No one with index #{choice_person_index}.\nCreating rental unsuccessful..."
        return
      end
    rescue ArgumentError
      puts "Invalid value for person index.\nCreating rental unsuccessful..."
      return
    end

    puts 'Date [YYYY/MM/DD]: '
    rent_date = gets.chomp
    begin
      t_date = Time.strptime(rent_date, '%Y/%m/%d')
      if t_date.strftime('%Y/%m/%d')
        rentals.push(Rental.new(persons[choice_person_index, books[choice_book_index, rent_date]]))
        puts 'Rental created succssfully'
      end
    rescue ArgumentError
      puts "Invalid value for date\nCreating rental was unsuccessful..."
      return
    end
  end

  def get_rental_by_id
    puts 'ID of person: '
    begin
      person_id = Integer(gets.chomp)
    rescue ArgumentError
      puts 'ID must be a valid integer'
      return
    end

    person = @persons.filter { |person| person.id === person_id }
    if person.length < 1
      puts "No one with ID #{choice_person_index}."
      return
    end
    puts "Rentals by #{person[0].name}:"
    rentals.filter {
      |rental| rental.person.id === person_id
    }.each {
      |rental| puts "Date: #{rental.date}, Book: \"#{rental.book.name}\" by #{rental.book.author}"
    }
  end
end
