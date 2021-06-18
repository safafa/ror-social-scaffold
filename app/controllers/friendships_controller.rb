class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    @friendship = user.friendships.build(friend_id: current_user.id, confirmed: false)
    if Friendship.where(user_id: params[:user_id],
                        friend_id: current_user.id).or(Friendship.where(
                                                         user_id: current_user.id, friend_id: params[:user_id]
                                                       )).exists?
      flash[:alert] = 'Invitation already sent!'
      redirect_to users_path
      nil
    elsif @friendship.save
      redirect_to users_path
    end
  end

  def confirm
    friend = User.find(params[:user_id])
    flash[:alert] = if friend.confirm_friend(current_user)
                      'Confirmed!'
                    else
                      'Not confirmed.'
                    end
    redirect_to user_path(current_user.id)
  end

  def reject
    friend = User.find(params[:user_id])
    flash[:alert] = if friend.reject_friend(current_user)
                      'Rejected!'
                    else
                      'Not Rejected'
                    end
    redirect_to user_path(current_user.id)
  end

  def remove
    friend = User.find(params[:user_id])
    flash[:alert] = if friend.remove_friend(current_user)
                      'Removed!'
                    else
                      'Not Removed'
                    end
    redirect_to user_path(current_user.id)
  end
end
