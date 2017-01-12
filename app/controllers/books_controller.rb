class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :rent, :return]

  # GET /books
  # GET /books.json
  def index
    @books_rented     = Book.joins("JOIN rent_logs ON books.id = rent_logs.book_id AND rent_logs.return_at IS NULL")
    @books_available  = Book.joins("LEFT JOIN rent_logs ON books.id = rent_logs.book_id WHERE (rent_logs.book_id NOT IN (SELECT rent_logs.book_id FROM rent_logs WHERE rent_logs.return_at IS NULL) OR rent_logs.id IS NULL)").distinct
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @rents = @book.rent_logs
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def rent
    @book.rent_logs.create(user: current_user, rent_at: Time.now)
    redirect_to books_path
  end

  def return
    @book.rent_logs.where(return_at: nil).first.update(return_at: Time.now)
    redirect_to books_path
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author, :abstract)
    end
end
