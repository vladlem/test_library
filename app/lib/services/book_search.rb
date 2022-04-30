module Services
  class SearchBook < Base
    def call
      books_scope = if context.id.present?
          Book.where(id: context.id)
        elsif conext.name.present? && context.author.present?
          Book.where(name: conext.name, author: context.author)
        elsif conext.name.present?
          Book.where(name: conext.name)
        elsif context.author.present?
          Book.where(author: context.author)
        end

      books = books_scope.pluck(:id, :name, :author)
      if books.present?
        context.books = books
      else
        context.fail!(message: "book is not found")
      end
    end
  end
end