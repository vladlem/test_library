class Api::Client::BooksController < ApplicationController
  before_action :authorize_request
  before_action :find_book, except: %i[create index updated]

  def index
    books = Book.pluck(:name, :author)
    render json: books, status: :ok
  end

  def show
    user_book = UserBook.find(book_params[:id])
    render json: user_book, status: :ok
  rescue => e
    render json: { errors: e.message }, status: :not_found
  end

  def create
    result = Services::BookReservationCreate.call(
      user_id: current_user.id,
      book_id: book_params[:book_id],
      reservation_status: book_params[:reservation_status]
    )
    if result.message.present?
      render json: { errors: result.message }, status: :not_found
    else
      render json: result.book, status: :ok
    end
  end

  def update
    result = Services::BookReservationUpdate.call(id: book_params[:id], author: book_params[:reservation_status])
    if result.message.present?
      render json: { errors: result.message }, status: :internal_server_error
    else
      render json: result.book, status: :ok
    end
  end

  private

  def find_book
    @result = UserBook.find(book_params[:id])
  end

  def book_params
    params.permit(:id, :book_id, :reservation_status)
  end
end
