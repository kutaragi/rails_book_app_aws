class ChatsController < ApplicationController
  def create
  	@chat = Chat.new(chat_params)
  	@chat.user_id = current_user.id
  	@chat.save
  	@chats = Room.find(@chat.room_id).chats
  end

  def show
  	@user = User.find(params[:id])
  	rooms = current_user.user_rooms.pluck(:room_id)
  	user_room = UserRoom.find_by(user_id: @user.id, room_id: rooms)

  	unless user_room.nil?
  		@room = user_room.room
  	else
  		@room = Room.new
  		@room.save
  		UserRoom.create(user_id: current_user.id, room_id: @room.id)
  		UserRoom.create(user_id: @user.id, room_id: @room.id)
  	end
  	@chats = @room.chats
  	@chat = Chat.new(room_id: @room.id)
  end

  private
  def chat_params
  	params.require(:chat).permit(:message, :room_id)
  end
end
