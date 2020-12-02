class FriendshipController < ApplicationController
  def create
    friend = User.find_by(email: params[:email])
    Friendship.create(user: current_user, friend: friend)
    # Friendship.create(user: friend, friend: current_user)
    flash[:success] = "#{friend.name} is now your friend"
    redirect_to dashboard_path
  end
end
