class Person
  attr_accessor :age, name
  attr_reader :id

  def initialize(age, name: 'Unknown', parent_permission: true)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

end
