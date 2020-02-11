class CommentsController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		comment = Comment.new(comment_params)
		comment.user_id = current_user.id
		comment.book_id = @book.id
		comment.save
		# コメントフォームも読み込み直すため
		@comment = Comment.new
		# redirect_to book_path(book.id)
	end

	def destroy
		# これはリダイレクト先(再読み込み先)で必要
		@book = Book.find(params[:book_id])
		comment = Comment.find(params[:comment_id])
		# これらだと一致する条件が複数見つかる
		# comment = current_user.comments.find_by(book_id: @book.id)
		# これでも良いのではないか？
		# comment = @book.comments.find_by(user_id: current_user.id)
		comment.destroy
		# こちらはフォームは読み込み直す必要なし
		# redirect_to book_path(@book.id)
	end

	private
	def comment_params
		params.require(:comment).permit(:comment, :user_id, :book_id)
	end
end
