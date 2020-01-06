class RelationshipsController < ApplicationController
	def create
		# :followed_idはhidden_tagから渡されたパラメータの目印
		user = User.find(params[:followed_id])
		current_user.follow(user)
		redirect_to user_path(user)
	end

	def destroy
		user = Relationship.find(params[:id]).followed
		current_user.unfollow(user)
		redirect_to user_path(user)
	end
end
