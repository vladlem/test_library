class Api::Admin::BooksController < Api::Admin::ApiController
  before_action :find_book, except: %i[create index updated]

  def index
    books = Book.all
    render json: books, status: :ok
  end

  def show
    if @result.message.present?
      render json: { errors: result.message }, status: :not_found
    else
      book = @result.books.first
      render json: book, status: :ok
    end
  end

  def create
    result = Services::BookCreate.call(name: book_params[:name], author: book_params[:author])
    if result.message.present?
      render json: { errors: result.message }, status: :not_found
    else
      render json: result.book, status: :ok
    end
  end

  def update
    result = Services::BookUpdate.call(id: book_params[:id], name: book_params[:name], author: book_params[:author])
    if result.message.present?
      render json: { errors: result.message }, status: :internal_server_error
    else
      render json: result.book, status: :ok
    end
  end

  def destroy
    book = @result.book.first
    book.destroy
  end

  private

  def find_book
    @result = Services::BookSearch.call(id: book_params[:id])
  end

  def book_params
    params.permit(:id, :name, :author)
  end
end
