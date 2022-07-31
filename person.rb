class Person
  def initialize(age, name = 'Unknown', parent_permission = true)
    @age, @name, @parent_permission = age, name, parent_permission
  end
end