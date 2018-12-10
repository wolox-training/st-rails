class Api::V1::Users::SessionsController < ApplicationController

  def create
    puts 'hablame!'
    render json: {msg: 'hola'}
  end
end
