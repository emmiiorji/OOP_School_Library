class Nameable
  def correct_name
    raise NotImplementedError, "#{self.class} has not implemented method #{__method__}"
  end
end

class Person < Nameable
  attr_accessor :age, name
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age >= 18
  end
end
