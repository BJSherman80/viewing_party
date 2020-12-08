class PartiesController < ApplicationController
  def new
    @movie = params['movie']
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
    if party.save
      flash[:success] = 'Your viewing party has been created'
      redirect_to dashboard_path
    else
      flash[:error] = 'Missing fields. Please try again.'
      @movie = {
        title: params[:movie_title],
        runtime: params[:movie_runtime],
        id: params[:movie_api_id]
      }
      render :new
    end
  end

  # private
  # def party_params
  #   params.permit(:movie_id, :party_duration, :date, :start_time)
  # end

  # def movie_params
  #   params.permit(:movie_title, :movie_runtime, :movie_api_id)
  # end
end
