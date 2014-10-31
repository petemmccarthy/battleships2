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
    @cells = (1..100).map { |cell| '~' }.each_slice(10).to_a
    @cells[0][0] = 'S'
    @cells[1][0] = 'A'
    @cells[2][0] = 'D'
    @cells[0][1] = 'O'
    @cells[0][2] = 'X'
    erb :board
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
