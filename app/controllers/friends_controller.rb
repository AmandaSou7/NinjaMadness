class FriendsController < ApplicationController
  def index
    @friends = Friend.all
  end

  def new
    @friend = Friend.new
  end

  def create
    @friend = Friend.new(params[:friend_id])

    if @friend.valid?
      @user = User.find(params[:user_id])
      @user.Friend.create(params[:friend_id])
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @friend = Friend.find(params[:id])
  end

  def delete
    Friend.find(params[:id]).destroy
    render index.html.erb
  end
end
