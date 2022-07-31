class Person
  def initialize(age, name = 'Unknown', parent_permission = true)
    @age, @name, @parent_permission = age, name, parent_permission
  end

  def id
    @id
  end

  def name
    @name
  end
  
  def age
    @age
  end
end