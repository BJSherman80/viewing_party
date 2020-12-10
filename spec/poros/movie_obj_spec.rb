require 'rails_helper'

describe MovieObj do
  it 'exists' do
    attr = {
      title: 'Crash',
      runtime: 120,
      id: 12345,
      vote_average: 8.0
    }

    movie = MovieObj.new(attr)

    expect(movie).to be_a(MovieObj)
    expect(movie.title).to eq('Crash')
    expect(movie.runtime).to eq(120)
    expect(movie.api_id).to eq(12345)
    expect(movie.vote_average).to eq(8.0)
  end
end
