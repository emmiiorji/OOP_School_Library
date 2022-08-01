class Person
  def initialize(age, name = 'Unknown', parent_permission = true)
    @age = age
    @name = name
    @parent_permission = parent_permission
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

  def name=(name)
    @name = name
  end

  def age=(age)
    @age = age
  end
end
