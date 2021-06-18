module FriendshipsHelper
  def accept_invitation_btn(friend)
    link_to('Confirm', user_friendship_confirm_path(friend), method: :post, class: 'profile-link')
  end

  def invitation(user)
    if !user.friend?(current_user) and !user.request_friend?(current_user) and !user.pending_friend?(current_user)
      link_to('Send friendship', user_friendships_path(user.id), method: :post, class: 'profile-link')
    end
  end

  def reject_invitation_btn(friend)
    link_to('Reject', user_friendship_reject_path(friend), method: :delete, class: 'profile-link')
  end
end
