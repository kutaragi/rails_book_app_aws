class BooksController < ApplicationController
	def new
		@book = Book.new
		@user = User.find(current_user.id)
	end
	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice] = "You have created book successfully."
			redirect_to book_path(@book.id)
		else
			@user = User.find(current_user.id)
			@books = Book.all
			flash[:notice] = "error"
			render :index
		end
	end
	def index
		@user = User.find(current_user.id)
  		@book = Book.new
		@books = Book.all
	end
	def show
		@book = Book.new
		@post_book = Book.find(params[:id])
		# @user = User.find(params[:id])
	end
	def edit
		@edit_book = Book.find(params[:id])
		if @edit_book.user.id != current_user.id
			redirect_to books_path
		end
	end
	def update
		@edit_book = Book.find(params[:id])
		if @edit_book.update(book_params)
			flash[:notice] = "You have updated book successfully."
			redirect_to book_path(@edit_book.id)
		else
			flash[:notice] = "error"
			render :edit
		end
	end
	def destroy
		@destroy_book = Book.find(params[:id])
		@destroy_book.destroy
		redirect_to books_path
	end

	private
		def book_params
			params.require(:book).permit(:title, :body)
		end
end
