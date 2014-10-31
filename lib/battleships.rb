require 'sinatra/base'

class Battleships < Sinatra::Base

  require_relative './player'
  require_relative './game'

  GAME = Game.new

  set :views, Proc.new { File.join(root, "..", "views") }

  enable :sessions

  get '/' do
    # puts GAME.inspect
    @name = session[:me]
    erb :index
  end

  post '/register' do
    puts session.inspect
    # name = params[:player_name]
    player = Player.new(name: params[:player_name])
    GAME.add_player player
    # GAME.add_player Player.new(name: params[:player_name])
    session[:me] = params[:player_name]
    session[:me_as_player_object] = player
    erb :index
  end

  get '/new_game' do
    erb :new_game
  end

  get '/board' do
    erb :board
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
