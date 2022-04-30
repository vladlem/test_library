module Services
  class BookReservationCreate < Base
    def call
      book_search = Services::BookSearch.call(id: context.book_id)
      return context.fail!(message: result.message) if book_search.message.present?

      user_book = UserBook.create!({
        user_id: context.current_user_id,
        book_id: book_search.book.id,
        reservation_status: context.reservation_status
      })
      context.user_book = user_book
    rescue => e
      context.fail!(message: e.message)
    end
  end
end
