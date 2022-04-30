module Services
  class BookReservationCreate < Base
    def call
      user_book = UserBook.find(context.user_book_id)

      user_book = user_book.update({ reservation_status: context.reservation_status })
      context.user_book = user_book
    rescue => e
      context.fail!(message: e.message)
    end
  end
end