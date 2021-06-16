class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    @friendship = user.friendships.build(:friend_id => current_user.id, :confirmed => false)
    if  Friendship.where(user_id: params[:user_id], friend_id:current_user.id).exists?
      redirect_to users_path
      return
    else
      if @friendship.save
        redirect_to root_path
      end
    end
  end

  def confirm
    friend = User.find(params[:user_id])
    if friend.confirm_friend(current_user)
      flash[:alert] = 'Confirmed!'
      redirect_to user_path(current_user.id)
    else
      flash[:alert] = 'Not confirmed.'
      redirect_to user_path(current_user.id)
    end
    
  end
end
