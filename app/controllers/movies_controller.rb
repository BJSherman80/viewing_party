class MoviesController < ApplicationController
  def index
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |f|
      f.params['api_key'] = ENV['MOVIE_API_KEY']
    end

    @movies = []
    page_num = 0
    2.times do
      page_num += 1

      response = conn.get("/3/movie/top_rated") do |req|
        req.params[:page] = page_num
      end

      movie_data = JSON.parse(response.body, symbolize_names: true)
      @movies << movie_data[:results]
    end
    @movies = @movies.flatten
  end

  def search
    search_word = params[:search]

    conn = Faraday.new(url: 'https://api.themoviedb.org') do |f|
      f.params['api_key'] = ENV['MOVIE_API_KEY']
    end

    @search_results = []
    page_num = 0
    2.times do
      page_num += 1

      response = conn.get("/3/search/movie") do |req|
        req.params[:query] = search_word
        req.params[:page] = page_num
      end

      movie_data = JSON.parse(response.body, symbolize_names: true)
      @search_results << movie_data[:results]
    end
    @search_results = @search_results.flatten
  end
end
