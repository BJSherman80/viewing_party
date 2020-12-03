class FriendshipController < ApplicationController
  def create
    friend = User.find_by(email: params[:email])
    friendship = Friendship.new(user: current_user, friend: friend)
    if current_user.email == params[:email]
      flash[:failure] = "That's your own email, silly!"
    elsif User.find_by(email: params[:email])
      friendship.save
    # Friendship.create(user: friend, friend: current_user)
      flash[:success] = "#{friend.name} is now your friend"
    else
      flash[:failure] = "There aren't any users with that email"
    end
    redirect_to dashboard_path
  end
end
