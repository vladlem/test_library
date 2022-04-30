module Services
  class BookCreate < Base
    def call
      book = Book.create!({ author: context.author, name: context.name })
      context.author = book.author
    rescue => e
      context.fail!(message: e.message)
    end
  end
end
