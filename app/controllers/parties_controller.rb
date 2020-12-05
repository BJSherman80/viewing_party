class PartiesController < ApplicationController
  def new
    @movie = params['movie']
  end

  def create
    movie = Movie.new(movie_params)
    party = Party.new(party_params)
    if party.save
      flash[:success] = 'Your viewing party has been created'
      redirect_to dashboard_path
    else
      flash[:error] = 'Please try again'
      render :new
    end
  end

  private
  def party_params
    params.permit(:movie_title, :party_duration, :date, :start_time)
  end

  def movie_params
    params.permit(:title, :runtime, :api_id)
  end
end
