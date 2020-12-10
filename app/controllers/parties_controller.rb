class PartiesController < ApplicationController
  def new
    @movie = MovieObj.new(
      id: params[:movie_api_id],
      title: params[:movie_title],
      runtime: params[:movie_runtime]
    )
  end

  def create
    movie = Movie.create(
      title: params[:movie_title],
      runtime: params[:movie_runtime],
      api_id: params[:movie_api_id]
    )
    party = Party.new(
      date: params[:date],
      start_time: params[:start_time],
      party_duration: params[:party_duration],
      movie_id: movie.id,
      user_id: current_user.id
    )
    if params[:party_duration].to_i < movie[:runtime]
      flash[:error] = 'Party duration cannot by shorter than movie length time.'
      @movie = MovieObj.new(
        title: params[:movie_title],
        runtime: params[:movie_runtime],
        id: params[:movie_api_id]
      )
      render :new
    elsif party.save
      create_guests(party)
      flash[:success] = 'Your viewing party has been created'
      redirect_to dashboard_path
    else
      flash[:error] = 'Missing fields. Please try again.'
      @movie = MovieObj.new(
        title: params[:movie_title],
        runtime: params[:movie_runtime],
        id: params[:movie_api_id]
      )
      render :new
    end
  end

  private

  def create_guests(party)
      if params[:guests] != nil
        guest_list = params[:guests][current_user.id.to_s].select do |guest_id|
         User.find(guest_id) if guest_id != ""
       end
        guest_list.each do |user_id|
         party.guests.create!(friend_id: user_id)
      end
      x = Guest.party_guests(party.guests)
    end
  end
end
