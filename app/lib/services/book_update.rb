module Services
  class BookUpdate < Base
    def call
      result = Services::BookSearch.call(id: context.id)
      return context.fail!(message: result.message) if result.message.present?

      book = result.books.first
      if book.update({ author: context.author, name: context.name })
        context.book = book
      else
        context.fail!(message: "book is not updated")
      end
    end
  end
end
