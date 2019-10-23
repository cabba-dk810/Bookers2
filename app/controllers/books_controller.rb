class BooksController < ApplicationController
	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book.id), notice: "You have created book successfully."
		else
			@user = User.find(current_user.id)
			@books = Book.all
			render :index
		end
	end

	def show
		if user_signed_in?
		@book = Book.find(params[:id])
		else
			redirect_to user_session_path
		end
	end

	def index
		if user_signed_in?
		@book = Book.new
		@books = Book.all
		else
			redirect_to user_session_path
		end
	end

	def edit
		if user_signed_in?
			@book = Book.find(params[:id])
			if @book.user_id != current_user.id
				redirect_to books_path
			end
		else
			redirect_to books_path
		end
	end

	def update
		@book = Book.find(params[:id])
		@book.user_id = current_user.id
		if @book.update(book_params)
			redirect_to book_path(@book.id), notice: "You have updated book successfully."
		else
			render 'books/edit'
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
