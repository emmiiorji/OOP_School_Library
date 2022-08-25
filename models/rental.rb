class Rental
  attr_accessor :date
  attr_reader :book

  def initialize(person, book, date)
    @date = date

    @book = book
    book.rentals << self
  end
end
