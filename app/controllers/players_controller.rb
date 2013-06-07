class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(params[:username])
    if @player.save
      redirect_to :back
    else
      render :new
    end
  end

  def show
    @user = Player.find(params[:id])
  end

  def auth
  end

  def delete
    Player.find(params[:id]).destroy
    render index.html.erb
  end
end
