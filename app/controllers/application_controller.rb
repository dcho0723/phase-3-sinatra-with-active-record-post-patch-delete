require 'pry'
class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  post '/reviews' do
    review = Review.create(
      score: params[:score],
      comment: params[:comment],
      game_id: params[:game_id],
      user_id: params[:user_id]
    )
    review.to_json
  end

  patch '/reviews/:id' do
    review = Review.find(params[:id])
    review.update(
      comment: params[:comment],
      score: params[:score]
    )
    review.to_json
  end

  get '/games' do
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  get '/games/:id' do
    game = Game.find(params[:id])

    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

  # get '/reviews' do
  #   review = Review.all.limit(10)
  #   review.to_json
  # end

  get '/reviews/:id' do
    review = Review.find(params[:id])
    review.to_json
  end

  delete '/reviews/:id' do
    review = Review.all.find(params[:id])
    review.destroy
    review.to_json
  end



end
