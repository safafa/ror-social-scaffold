class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    @friendship = user.friendships.build(:friend_id => current_user.id)
    if  Friendship.where(user_id: params[:user_id], friend_id:current_user.id).exists?
      redirect_to users_path
      return
    else
      if @friendship.save
        redirect_to root_path
      end
    end
  end
end
