require 'rails_helper'

describe 'Movie Facade' do
  it 'returns a list of top 40 movies' do
    movies = MovieFacade.fetch_top_40_movies

    expect(movies).to be_an(Array)
    expect(movies.first).to be_a(MovieObj)
    expect(movies.first.title).to be_a(String)
  end

  it 'can see search results' do
    movies = MovieFacade.fetch_movie_search_results('happy')

    expect(movies).to be_an(Array)
    expect(movies.first).to be_a(MovieObj)
    expect(movies.first.title).to be_a(String)
  end

  it 'can see movie details' do
    movie = MovieFacade.movie_details(9614)

    expect(movie).to be_a(MovieObj)
    expect(movie.title).to eq('Happy Gilmore')
    expect(movie.runtime).to eq(92)
  end

  it 'can see movie reviews' do
    reviews = MovieFacade.fetch_movie_reviews(9614)

    expect(reviews).to be_a(Array)
    expect(reviews.first).to be_a(ReviewObj)
    expect(reviews.first.author).to be_a(String)
  end

  it 'can see a movies cast' do
    cast = MovieFacade.fetch_movie_cast(9614)

    expect(cast).to be_a(Array)
    expect(cast.first).to be_a(CastObj)
    expect(cast.first.name).to be_a(String)
  end

  it 'will run search if search params exist' do
    search = 'happy'
    movies = MovieFacade.service_identifier(search)

    expect(movies).to be_an(Array)
    expect(movies.first).to be_a(MovieObj)
    expect(movies.first.title).to be_a(String)
    expect(movies.first.title.downcase.include?('happy')).to eq(true)
  end

  it 'will show top 40 if search is empty' do
    search = ''
    movies = MovieFacade.service_identifier(search)

    expect(movies).to be_an(Array)
    expect(movies.first).to be_a(MovieObj)
    expect(movies.first.title).to be_a(String)
    expect(movies.count).to eq(40)
  end

  it 'will show movies now playing in theaters' do
    movies = MovieFacade.fetch_now_playing

    expect(movies).to be_an(Array)
    expect(movies.first).to be_a(MovieObj)
    expect(movies.first.title).to be_a(String)
  end

  it 'will show now playing if that is searched for' do
    search = 'now_playing'
    movies = MovieFacade.service_identifier(search)

    expect(movies).to be_an(Array)
    expect(movies.first).to be_a(MovieObj)
    expect(movies.first.title).to be_a(String)
  end
end
