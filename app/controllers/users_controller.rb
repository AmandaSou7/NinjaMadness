class UsersController < ApplicationController
  def index
    @users = User.select("users.*, players.alias_name").joins(:players)
  end

  def new
    reset_session
    @user = User.new
    @player = Player.new
  end

  def create
    @user = User.new(params[:user])
    @user.valid?
    @player = Player.new(:alias_name => params[:player][:username])
    @player.valid?
    
    session[:username] = params[:player][:username]
    session[:first_name] = params[:user][:first_name]
    session[:last_name] = params[:user][:last_name]
    session[:email_address] = params[:user][:email_address]

    if @player.valid? && @user.valid?
      @user.save
      User.last.players.create(:alias_name => session[:username])
      reset_session
      # redirect_to @user
      redirect_to "http://localhost:8000"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:id])
      redirect_to @user
    else
      render edit.html.erb
    end
  end

  def show
    @user = User.find(params[:id])
    @player = Player.all
  end

  def delete
    User.find(params[:id]).destroy
    render index.html.erb
  end
end
