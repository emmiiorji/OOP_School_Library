require_relative "./student.rb"
require_relative "./teacher.rb"
require_relative "./classroom.rb"
require_relative "./rental.rb"

class App
  attr_accessor :classrooms

  def initialize
    @persons = []
    @books = []
    @rentals = []
    @classrooms = []
    create_classrooms("Class1") #Create some classroom
  end

  def create_classrooms(label = nil)
    puts "Enter classroom label" unless label
    label = gets.chomp unless label
    @classrooms.push(Classroom.new(label)) unless @classrooms.filter {|classroom| classroom.label === label}.length > 0
  end

  def create_person
    print "Do you want to create a student(1) or a teacher (2)? [Enter the number]: "
    create_choice = gets.chomp
    case create_choice
    when "1"
      create_student
    when "2"
      create_teacher
    else
      puts "You have made an invalid choice. Exiting..."
      return
    end
  end
end
