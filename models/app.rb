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

  def create_student
    begin
      print "Age: "
      age = Float(gets.chomp)
    rescue ArgumentError
      puts "Invalid value for age. Exiting..."
      #Return to the beginning
    end

    print "Name: "
    name = gets.chomp

    print "Has parent permission? [Y/N]: "
    permission = gets.chomp.downcase === "y"
    @persons.push(Student.new(age, @classrooms[0], name, parent_permission: permission))
    "Student created successfully"
  end

  def create_teacher
    begin
      print "Age: "
      age = Float(gets.chomp)
    rescue ArgumentError
      puts "Invalid value for age. Creating teacher was unsuccessful..."
      return
      #Return to the beginning
    end

    print "Name: "
    name = gets.chomp

    print "Specialization: "
    specialization = gets.chomp.downcase === "y"
    @persons.push(Teacher.new(age, specialization, name))
    "Teacher created successfully"
  end
end
