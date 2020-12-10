# [Viewing Party](https://viewing-party-bdj.herokuapp.com/)

### About this Project

Viewing party is an application that utilizes the Movie Database API. Users can see the top 40 movies or search for a specific moive of their liking. Users can add friends, can create movie viewing parties and can invite friends or be invited by friends to a movie viewing party.

## Summary

  - [Getting Started](#getting-started)
  - [Versioning](#versioning)
  - [Runing the tests](#running-the-tests)
  - [Deployment](#deployment)
  - [Built With](#built-with)
  - [Authors](#authors)

## Getting Started

The below instructions will get you a copy of the project up and running on
your local machine for development and testing purposes. See deployment
for notes on how to deploy the project on a live system.

## Local Setup

1. Fork and Clone the repo
  - You can find the repo for this project [here](https://github.com/jakeheft/viewing_party)
2. Install gem packages: `bundle install`
  - Gems: Faraday, Figaro
  - Testing Gems: ShouldaMatchers, Webmock, VCR
3. Setup the database: `rails db:create`

Example wireframes to follow are found [here](https://backend.turing.io/module3/projects/viewing_party/wireframes)

## Versioning

The following versions are recommended for this project.

- Ruby 2.5.3

- Rails 5.2.4.3

## Running the tests

To run all of the tests, you will use `bundle exec rspec`

To run a specific test, you will use `bundle exec rspec:<test line number goes here>`

## Deployment

From the command line, do the following:
  - `heroku create`
  - `git push heroku master`
  - `heroku run rake db:migrate`
  - You may also want to run the following command to seed your heroku database:
  - `heroku run rake db:seed`

## Authors

- [**Jake Heft**](https://github.com/jakeheft)
- [**Brett Sherman**](https://github.com/BJSherman80)
- [**Dani Coleman**](https://github.com/dcoleman21)
