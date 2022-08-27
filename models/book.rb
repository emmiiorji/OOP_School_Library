class Book
  attr_reader :rentals, :title, :author

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end
end
