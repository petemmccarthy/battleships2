require 'sinatra/base'

class Battleships < Sinatra::Base

  require_relative './player'
  require_relative './game'

  GAME = Game.new

  set :views, Proc.new { File.join(root, "..", "views") }

  enable :sessions

  get '/' do
    puts session.inspect
    erb :index
  end

  get '/new_game' do
    erb :new_game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
