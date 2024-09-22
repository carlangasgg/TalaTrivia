class Trivias::TriviaController < ApplicationController
  def start
    render json: { message: 'Im here' }
  end
end
