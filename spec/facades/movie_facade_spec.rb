require 'rails_helper'

describe 'Movie Facade' do
  it 'returns a list of top 40 movies', :vcr do
    movies = MovieFacade.fetch_top_40_movie_data

    expect(movies).to be_an(Array)
    expect(movies.first).to be_a(MovieObj)
    expect(movies.first.title).to be_a(String)
    # expect(movies.first.title).to eq('Crash')
  end
end
