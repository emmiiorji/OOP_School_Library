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
  end
end
