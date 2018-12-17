class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(params[:id])
  end

  def create
    @user = User.find_by(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.new
  end

  def update
    @user = User.find_by(params[:id])
  end

  def destroy
  end
end
