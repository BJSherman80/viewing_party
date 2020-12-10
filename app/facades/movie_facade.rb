class MovieFacade
  def self.fetch_top_40_movies
    MovieService.top_rated.map do |movie_data|
      MovieObj.new(movie_data)
    end
  end

  def self.fetch_movie_search_results(search_word)
    MovieService.search(search_word).map do |movie_data|
      MovieObj.new(movie_data)
    end
  end

  def self.movie_details(movie_id)
    MovieObj.new(MovieService.movie_details(movie_id))
  end

  def self.fetch_movie_reviews(movie_id)
    MovieService.reviews(movie_id).map do |review|
      ReviewObj.new(review)
    end
  end

  def self.fetch_movie_cast(movie_id)
    MovieService.credits(movie_id).map do |cast|
      CastObj.new(cast)
    end
  end

  def self.top_rated_or_search(search)
    if search == '' || search == nil
      self.fetch_top_40_movies
    else
      self.fetch_movie_search_results(search)
    end
  end

  def self.fetch_now_playing
    MovieService.now_playing.map do |movie|
      MovieObj.new(movie)
    end
  end
end
